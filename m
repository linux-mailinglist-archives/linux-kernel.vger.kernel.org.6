Return-Path: <linux-kernel+bounces-409396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C86B89C8C37
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F74285813
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D6574421;
	Thu, 14 Nov 2024 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ZhLzCptR"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F603BBC5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731592441; cv=none; b=BYcdDKA2qLOUcYYEqWXmtWZUYUttWh19n8h2pzk0NR6Wd5/OKpziuUcVBLzvueAf330JZo6OzBJltY1r8Ha8Co0zVe7ValnEXOm3+9UoLnSpyD/72RrTkQzXLXloxpm4tSrmG0vMA20BiI4R6/wzquamx6qC+ozJix0tfgaYUxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731592441; c=relaxed/simple;
	bh=2b8xKyOQ5Oj+r1rsPmsfhswWR7sy85VzeMpp9g7y4Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f3dY9MzULiqwzoe2yewaEQruydjwcomeahxO7Vple/4v/gWkFgxDuYdp5J0c+7aUSuW4TPN0g1EMLKFyFBP5lJkRAEJCoXlcU7Y77ZCvKUucnTxGzjy1yhbcqmOoKJhdHdhyd8TvjGkgKeVL3zVw5yf5Q8h2LIX6etmqwMq8P8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ZhLzCptR; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-132.bstnma.fios.verizon.net [173.48.113.132])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4AEDrhTE001788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 08:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1731592425; bh=PPHH19sz1b5FCEkrSRevlh2ewLvJRUjGu4Ppejh9IiY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=ZhLzCptROjwMXgnjgie3ZjDaCXHk4z2GWi2PQnT2mmqN3NAHqLBkW61iPYNXCbE2s
	 34zgRJpyHTHfvrNfskzbQdYBDisFILXF0SEPlR4eRwS5cQhJFdZQS4jMbB73hBs+0Q
	 FJ3iwhDEz0L4Fom+EoqXmRQQBc6M3lqc/EdT1CYCwiniZ0UdNulQO8QFtXliItuFWm
	 5eSdgX5JhCAZhjBxakgWuzmxOH1Oz8sezmbu2t92BHHoFi6KOUs3fZQd1vd1LDc7b3
	 FnkmZd3KwbbRVejiz7jQRlDFlpcwG14BkZLz7UydBj4nRFQdHmB6lPq5PLpwnLUDSi
	 wk5eGM/BehFCg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 481E715C1942; Thu, 14 Nov 2024 08:53:43 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] jbd2: Avoid dozens of -Wflex-array-member-not-at-end warnings
Date: Thu, 14 Nov 2024 08:53:36 -0500
Message-ID: <173159220756.521904.14770235209517754981.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <ZyU94w0IALVhc9Jy@kspp>
References: <ZyU94w0IALVhc9Jy@kspp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 01 Nov 2024 14:45:23 -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we
> are getting ready to enable it, globally.
> 
> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
> a flexible structure (`struct shash_desc`) where the size of the
> flexible-array member (`__ctx`) is known at compile-time, and
> refactor the rest of the code, accordingly.
> 
> [...]

Applied, thanks!

[1/1] jbd2: Avoid dozens of -Wflex-array-member-not-at-end warnings
      commit: 2bd9077b6261b8f1281d0fa74d51afe090319263

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


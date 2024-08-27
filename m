Return-Path: <linux-kernel+bounces-303344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D11960B01
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8D41F23A83
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCDA1BD010;
	Tue, 27 Aug 2024 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="DOng+Tn5"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3156E1C4EF0
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762883; cv=none; b=FNQa3Q37JHR3TBkECRC1751VErGQFEAhiL/WKAKfTaBXy3H0wnrs78kK97Gra4uXyFmlBT3owbPGzNe0kuLcwD0jgXP3Z1BXmsuK6K6tLBNLhBQ93y8Z9gnoffe5RqF6hk1Z+kPQpzJ+sArPYFW8pj8JXE08v5XIUm/x7XmJ2FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762883; c=relaxed/simple;
	bh=QJ7zIFY31lkCcAHm0ucVlZlKcMSfL7bKNpyvkzdcIOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WDKRnCcOHgxfMjHbSuJ0cTxwyB7EGIC0OtNWWPt2d+iFDpOUbg8yETQUB+KbQzXFENNL5E/v18R8R7WCCB7vY84tl0ND9ANAtbZxuP1Lkjq/K9CZBNnhxqNc0FcLvFQQoNLamDzloFSEcq+75Nq7O1irxSE5yDxxZItAI4FUz/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=DOng+Tn5; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-93.bstnma.fios.verizon.net [173.48.112.93])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47RClfJP021511
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 08:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724762864; bh=KgVLvwVgnSvW9lbOpNjtiCly4AHmvAivyIX/Y/Q3TN8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=DOng+Tn5f7F2t//3P7tqFchr3uYXRD6kcynFwec/V2hjzwe/ha6W8YwcWeqH1z5np
	 vtrPQDm/Cb1twEh8zyInp1y0948QgVl9B23ZwtteadX61MO9E4EimVxpxxaFLc0Imj
	 cfHtgpmGkZO1Ogym1vvXDvUEjucgOZtGX180cw9+sQoC73+JZhYwHN9j6uBGml4jDV
	 p1VU/tsUgqHnMPWDJAp1wgjxoA02EyygzWSliwcU6WXU4jZ9ukRsjZ/ztOpa1VaDQI
	 3xXksQZioXt3yQ4ew5NwYXOw88K9qKpe6R20z/2/eVnfTQDBbrELNi4joQ2d14YLZH
	 w6cqiyg5BrJKA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id BBB7315C1972; Tue, 27 Aug 2024 08:47:38 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] jbd2: fix kernel-doc for j_transaction_overhead_buffers
Date: Tue, 27 Aug 2024 08:47:28 -0400
Message-ID: <172476284020.635532.13847870872561422486.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723051647.3053491-1-rdunlap@infradead.org>
References: <20240723051647.3053491-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 22 Jul 2024 22:16:47 -0700, Randy Dunlap wrote:
> Use the correct struct member name in the kernel-doc notation
> to prevent a kernel-doc build warning.
> 
> include/linux/jbd2.h:1303: warning: Function parameter or struct member 'j_transaction_overhead_buffers' not described in 'journal_s'
> include/linux/jbd2.h:1303: warning: Excess struct member 'j_transaction_overhead' description in 'journal_s'
> 
> 
> [...]

Applied, thanks!

[1/1] jbd2: fix kernel-doc for j_transaction_overhead_buffers
      commit: 7e8fb2eda9885ea2d13179a4c0bbf810f900ef25

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


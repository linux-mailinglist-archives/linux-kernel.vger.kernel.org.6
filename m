Return-Path: <linux-kernel+bounces-303338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1881C960AF0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C374C1F2235A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4BF1C0DC2;
	Tue, 27 Aug 2024 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="MxaVnte3"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124111BF801
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762874; cv=none; b=mHxbzYz/1+fV4FJwK/JHy1qYpiC2AbG67mqoLehm0V5YM5LtDeODAUpkeRCiz7+g1e+iThJVZOQE/N1Fwkm29HAmk+M2WpoSdAUO3ckr93M/UiyFV60kOcI6uVgL996MrV10ICFFOqmOu5igjRQLpnGJXb7PChnbQeDwh4WbW2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762874; c=relaxed/simple;
	bh=LYqmpaIdE1wYPo3wHu0ijU4oRzcYiUcPh5Apz2eAs7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dvf/wlBVmMKctJsQps+7qL631jDTcp7pSZcw2IcmWmcKzvxyjvqqbtwxswIcr/QqRxp4TqlucLqzMIlcTsjMYcF6yMLh2/IJTpQ6YL7jJ+mKG1t5XbgJfua3IQZNzRK8M/Lqiukae+hHZCxF6lzGLaeICfzN010lP+OzwJ1SsCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=MxaVnte3; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-93.bstnma.fios.verizon.net [173.48.112.93])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47RClevf021489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 08:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724762863; bh=O9aqUbJiflq+Jj5TMarn+kwjgS0QFHmSlvz6N5WUEwo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=MxaVnte3Hmv04Y05uQQWhcVr0C3AGSHPc216zcjDTwwMwcMwY2NvzufimrCbSx7JA
	 Ozg963EHK9wkdEhooN5yViXtDjWvdz2BE8kXX173OIg9kztqR6ilJDD+2ssLJmQRCi
	 m0lvyW9IwfjJbkQ2HYD5ZFFH1cTAQiCYui3FbMeO5LvqnyZlsYa4dQ1+Un20ITq40T
	 4rJUemu0JP0zSKKGhSaqNaEM9hEIZJlaCnZRsdnJqHTggWG44drlxDAMLg8LLTAf8y
	 +LF/0DpBsyjSv2WHdBWQvnyiQTi6qAWxn/eeWdNhWYPqHLiNrp0MaLC8pFaChilwz+
	 0AnYGLi75EonQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id B9E5B15C1942; Tue, 27 Aug 2024 08:47:38 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Markus Elfring <Markus.Elfring@web.de>
Cc: "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext4: Use seq_putc() in two functions
Date: Tue, 27 Aug 2024 08:47:27 -0400
Message-ID: <172476284016.635532.5082003928541749251.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <076974ab-4da3-4176-89dc-0514e020c276@web.de>
References: <076974ab-4da3-4176-89dc-0514e020c276@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 13 Jul 2024 20:15:44 +0200, Markus Elfring wrote:
> Single characters (line breaks) should be put into a sequence.
> Thus use the corresponding function “seq_putc”.
> 
> This issue was transformed by using the Coccinelle software.
> 
> 

Applied, thanks!

[1/1] ext4: Use seq_putc() in two functions
      commit: bd8daa7717d94752ecd4a60b67a928d7159c2825

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


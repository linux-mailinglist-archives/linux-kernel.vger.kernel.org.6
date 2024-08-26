Return-Path: <linux-kernel+bounces-302270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3013495FBF2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F96D1C22729
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20072481B7;
	Mon, 26 Aug 2024 21:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="pDouXqIw"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E4626AC3;
	Mon, 26 Aug 2024 21:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708721; cv=none; b=Ivr1SKMNLx7q/Xi/kQWrffeBztZ1LgyEZerDoYdZMRgV9p3d5LcdCprErhhrmuh7yrEutb+iGp7NV0oeM12S76Unh0ma3ocg6rpS2fo/Xl1gJLT8PbjsOojG1rX3ugKGcy6F5UfPCTtbvy0Em6pfuaBEyxAsgcIs+JGcCuJ9hBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708721; c=relaxed/simple;
	bh=9HuQOiSNN6/kKxzX7pc6LVjoP+jiMmXY4yGzX/h5pGg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nID1GCfSf3KyIwUirloEwWSw63kpz5VCVMZ9j56MxknxJhu/yRWtVR00P0DM9SkqH6peNM2RIwED5URwtjqQmi2rR3g+Tr5JBUCPTMx/SSJlKMeqRTRQqLsi7ZW5kBzbR1lyCZVUajgUrkgQNRNqUamf4ct8ckNu6zywOzdEbkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=pDouXqIw; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2151F41AB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1724708719; bh=4Sdbpb1WMKaV3Ic3jTBKuIlKBSluMuTdNbalX8xuK/4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pDouXqIwDro5X4QCaXAhhs/9gu7YN9wTUNttrlWbQfRbwBfL/RbWzgLBKl279Hxgs
	 qkpj0Bu2cDfk5hPiHMpBU/ojS9SAkLd5ofMDL1+p5GVhb61MN5bW6hH84dWFYLJGXM
	 Q8xoGsOViVGfUZrcmu28p8frWVsVT9QPFgYNiZxT0BV4QID1re/uBNubinNuvIL8LP
	 W9ldrIQbweVKadknoAg6s06geYlvoAdeGANWTnGTCHSYEhIYzmHy5Y05oV0H1P9pwW
	 w+3CIq2Rc/UTb0sjydpRcFfxVp5OoMGqiyQ+yLPPCych8jjuiTS3DbdCsJZriURSD2
	 8xf3Bu4Xp2Lpg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2151F41AB9;
	Mon, 26 Aug 2024 21:45:19 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Haoyang Liu <tttturtleruss@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: hust-os-kernel-patches@googlegroups.com, Haoyang Liu
 <tttturtleruss@hust.edu.cn>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v7] docs/zh_CN: Add dev-tools/kcsan Chinese translation
In-Reply-To: <20240817175151.164923-1-tttturtleruss@hust.edu.cn>
References: <20240817175151.164923-1-tttturtleruss@hust.edu.cn>
Date: Mon, 26 Aug 2024 15:45:18 -0600
Message-ID: <87seur5575.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Haoyang Liu <tttturtleruss@hust.edu.cn> writes:

> Translate dev-tools/kcsan commit 31f605a308e6
> ("kcsan, compiler_types: Introduce __data_racy type qualifier")
> into Chinese and add it in dev-tools/zh_CN/index.rst
>
> Signed-off-by: Haoyang Liu <tttturtleruss@hust.edu.cn>
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> ---
> v6 -> v7: Replace duplicated inclusion with a note to avoid compile warnings.
> v5 -> v6: Fix a typo.
> v4 -> v5: Translate link into Chinese as well according to reviewer's advice.
> v3 -> v4: Added original English text for proper nouns and modified some unclear experessions.
> v2 -> v3: Revised some sentences based on reviewer's suggestions and updated the KTSAN url.
> v1 -> v2: Added commit tag and fixed style problems according to reviewer's suggestions. 
>
>  .../translations/zh_CN/dev-tools/index.rst    |   2 +-
>  .../translations/zh_CN/dev-tools/kcsan.rst    | 320 ++++++++++++++++++
>  2 files changed, 321 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/dev-tools/kcsan.rst

Applied, thanks.

jon


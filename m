Return-Path: <linux-kernel+bounces-290889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EFC955A8E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 03:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A971C20B34
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 01:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6126F33E8;
	Sun, 18 Aug 2024 01:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="qipz2NpE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JIPqqg2L"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CB9A41
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 01:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723945725; cv=none; b=S8WymhdTJ9Ul93p2XAug92Fp9l+7omrSacquOQCtIUg+q2XZj0q9gi8iWlFQMtjqsYTB1E2AZb6LscByGSDaGRKI2TA9HiXSgvmOji3cdW57miUUUcjKJnj1tos331O4YRKubnO2hQFS4Xlun9ElNvXJq3E81H4nuwpJ/ox7zN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723945725; c=relaxed/simple;
	bh=JejcE/qEO35srPQYS/IHZYpsCVzO5HTOoQ9qy/RhFU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRmvwOck/v7DtevtF+8bn8KHhtQ5lnbPplJrNmj1IsZbQ1Obh5UfkbL/ARRc/zT+5NwkwKQeTJRS421G1vmxeDRjvwwOSzqiskxf1+BNhzADRJEHtY1DIdrgb8XWKAUHkwdYmuAOmfeE19SNqodUrEZmDC/wDPcl4vKU829o3vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=qipz2NpE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JIPqqg2L; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 10A12138FC19;
	Sat, 17 Aug 2024 21:48:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 17 Aug 2024 21:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1723945720; x=
	1724032120; bh=so7ap9O4i6T1l+eY2GWYjpjsxiRwe2Wo10QeB0EQ3AI=; b=q
	ipz2NpEjWeS0I7KC8Gs/gkdO5QCqeqQjUt4Fba0e+18NKNqVpQ2JIc1piD6stq9c
	F8yvun7jgKn2wwslanUjWh1xMNhwKzMK+61NfzbuluNE7rV+rLAjELSrErD4nZ01
	huLzAcmrY8irIsn89G93/3xTTPdfDD/TuYYXb+evodp0S6M+0IDT59blR0RoOV2/
	hArhl2CRDmsG/7uRSbrqyRlO3Q4L7/4/mELIQssIoFx3yd6ymK21BnISP3Y44Y3b
	8ejwXPPj185vULJ3K8m6J6v3xo8OT/hv7Q3T+H7bGBKQ8O0BSepLaK5VDuBs+0Rg
	c9kxYO/YjY1qBj+sQqXug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723945720; x=1724032120; bh=so7ap9O4i6T1l+eY2GWYjpjsxiRw
	e2Wo10QeB0EQ3AI=; b=JIPqqg2L5IrFwTcssdFY+FD2AKZdF3hegKvrPa6q/k6/
	lVf7pUXqu37gKD5q7KGXmolx60HZXoVJEg5JCgVbsKI8grf8nzwNu8In8pZyTvKy
	cJg2nL4DctC4CAGxW8Xi4v+q4W0doF0ylY73aV3cPNzKzoBgt2mAbqrT7kyltsdv
	/ruT+gqMy2ygEsDK5RTqIrziCfkWFxJSuOBe1Mo0b/Wgyq7Se4OZI0BHBw+WWpti
	faen8m8lWAJOWirGMftroLcVlcP7sRNgXZr3F0Nz5pTMSRaQGCx7Mp3XzhxYIsBU
	We3ONCsWpE20iPHFN2wNiqca8NtMKvGPjpApjRIzLg==
X-ME-Sender: <xms:91LBZti1SJKrTg_EUHn6j52gIZvt9N5GeHputDJlFMzueuFTJme-5w>
    <xme:91LBZiCZa9dWUcHHNIhcyxHU17IgUmPLez4hYRkDJPl1yjRXLVjB_oRilADcBGnEY
    Bb-0gT1pp6mQS4mfho>
X-ME-Received: <xmr:91LBZtFKQ0XEdmp0ipSEa2fsRCpm_eeuHIa2UhTTX3qOjEwG1HpnaUuqnf779ccLegxeC52dz3OtIEF1OK7mLQ0T1p80nJIjfVM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduuddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhephefhhfettefgkedvieeu
    ffevveeufedtlefhjeeiieetvdelfedtgfefuedukeeunecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhho
    tggthhhirdhjphdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtggvfhho
    rhhgvgdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegurghnrdgtrghrphgvnhhtvghrsehlihhnrghr
    ohdrohhrgh
X-ME-Proxy: <xmx:91LBZiQNbm4W98e8hS3itkVduBcnKwKtOHf5wjD4kDzv-AOZm7EBCA>
    <xmx:91LBZqy0HXYcpePiTI9z8MBXcwgK1GsTTtHrqhXK0u5DR8-lWl1trg>
    <xmx:91LBZo4RbzKANhO0bU6pgLMaZhy6q_qAFfJyjQFFm1YYNEstVE6AjQ>
    <xmx:91LBZvyelQhU0RJI6V6-y1CKZCBAKZaQa5SDxeCCDuYKuXfAYXFqpQ>
    <xmx:-FLBZu_aZh1KB4QuR2ZAjh2cAau0SRsIEBnEB-NsjAbiU2z2mxiSwWk4>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Aug 2024 21:48:38 -0400 (EDT)
Date: Sun, 18 Aug 2024 10:48:37 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] firewire: ohci: fix error path to detect initiated reset
 in TI TSB41BA3D phy
Message-ID: <20240818014837.GA188655@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
References: <20240817091128.180303-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817091128.180303-1-o-takashi@sakamocchi.jp>

On Sat, Aug 17, 2024 at 06:11:28PM +0900, Takashi Sakamoto wrote:
> A commit 404957c1e207 ("firewire: ohci: use guard macro to serialize
> accesses to phy registers") refactored initiated_reset() helper function,
> while the error path was changed wrongly.
> 
> This commit fixes the bug.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Fixes: 404957c1e207 ("firewire: ohci: use guard macro to serialize accesses to phy registers")
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/ohci.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto


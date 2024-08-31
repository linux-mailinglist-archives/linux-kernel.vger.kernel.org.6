Return-Path: <linux-kernel+bounces-309735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 949D2966FDE
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 08:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5AA11C21E05
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 06:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4933716D9AE;
	Sat, 31 Aug 2024 06:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="ncZ59w5a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qTU84pI9"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E9761FEB;
	Sat, 31 Aug 2024 06:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725086918; cv=none; b=g5kmBelV0+U0Rt+ClIsFgIDAqwrvb+kt1Xa668jhX4XRZiHfvO7y6DicBKlS/Lhv1p+FTisfN9C4C0VDYIOWIYw3fX7kb5KtflNsWGD8u7lbvdF90alVR+xyGUM9KLgp4tc/ovaozxHMc4sRVL9slFiXeLITGoJwBt7ooIu5EmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725086918; c=relaxed/simple;
	bh=AWlIbgwDW15uXnvfiFNOWTtR+Bzmb9Zh8lOvtOTxJeE=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Gv1EimJlEBem/d3Q/Nz//KbGW4oTY9QhdeJLc5vkAvR3R7TS7GSvz7yN/eqDUbbz+aGjEkEBpZ3aumC4fAZlt+QnBdTgJALBfdxexsF+7ttIbFPVToScGZPJJfnnrTYKw8NqkR8vRECIKqKnPn+E/aWUgLGdkffOHR2WJJ/UiwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=ncZ59w5a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qTU84pI9; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id AC67A114063E;
	Sat, 31 Aug 2024 02:48:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 31 Aug 2024 02:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1725086915; x=1725173315; bh=20rH0T2L4W72RaArx6nM2uEwp1FMBQ6S
	wXbHHbGIl6g=; b=ncZ59w5a1l3Xp3qgxe4bgBRj/0P2RbRnmheZ/d+mThbns8kr
	UljPq8epg0BCm+JtOnXh/Zx7EcKjs8pQ1jAgFNL0jKDkCnBbl5hx1YJi1dXPi2eX
	HiiUXVR9/ocmEsV+1uajHXZexxnqZqBGM6XQ2Om89FvpvaBF51wvRJWulHUnK+XI
	MnKC1RJlhq8tqmz0F1s4YI7f67aQ6x5b/ja2Jawqt1ADqwGEo1D3o+lQpFlDznm/
	IKVFva08Z8N/34MonnfowGeThAo3pLpzPDpP6lzaukxKsAbdvjF55RviXcyqEm6J
	nVsVu57o78cJ9BWi/Z542XdFsQggC/i735s1Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725086915; x=
	1725173315; bh=20rH0T2L4W72RaArx6nM2uEwp1FMBQ6SwXbHHbGIl6g=; b=q
	TU84pI9xVIYwnR9xkAsHrLOoYG6juW/ZlRKRaI9dxOGigfkOLDcn8Apt2LJWZiQe
	Sa1QOIqS4JTeSTCb9jJoZ8nOnJ6J9cb9ynav/pNG9KsJCfodObGjvtvn8rkVYG4q
	UZ3cKPJcVrxFHqDHejsTP/Lbx4JHQSOnuZU/qtU4hiPuTkIatjSrbWwhKV5Pl3Pr
	t1qnwcnj15lqtlhzc66axQSS98GH+MgVaWF6HYYByNGcPtHkr+UFX/MnMDqRlXXg
	Ffgb4Erub6JaGlo0d96IJDSmBqAQ9gtTPRPjwTiR039SbHkJ57vkTRmTTpTXoPZP
	UhSONd71I1T29RIa72Nkw==
X-ME-Sender: <xms:w7zSZtXL9uAqMN3lg0jIrbBtWrvwORzZpxZVBgX18pq036-wrIjGlw>
    <xme:w7zSZtlDiGrpRj6UiYiVaIBoIKGhRhzsfz3pS34hNZmXYhZjz-yiyaG_utD8gtkSL
    lNos5t2s848LvZKD_Q>
X-ME-Received: <xmr:w7zSZpYxZnqdTSfxu3JjZF9V4bL2l1kPkJDuk7rPG-1WTQo7sYZ7xaKF7GdLCqW8WoPuS92Nxu8iB6IZhuqWhfBbk22N4eueVGP9ONs-0kM8WqBoa0UzOv7K4Yk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefjedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpegtgffhggfufffkfhevjgfvofesthhqmhdthhdt
    jeenucfhrhhomhepufhvvghnucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrd
    guvghvqeenucggtffrrghtthgvrhhnpedvhfdtudduvdeujeeufffgudekvdefvefgueei
    iedvledtheegieevffdtteekudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvhdpnhgspghrtghp
    thhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeimphhoshhtmhgrrh
    hkvghtohhssdhuphhsthhrvggrmhhinhhgsehlihhsthhsrdhsrhdrhhhtpdhrtghpthht
    oheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqd
    hkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopeht
    ghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehkrhiikhdoughtsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegrshgrhhhisehlihhsthhsrdhlihhnuhigrdgu
    vghvpdhrtghpthhtohepthhofihinhgthhgvnhhmihesghhmrghilhdrtghomhdprhgtph
    htthhopehkohhnrhgrugdrugihsggtihhosehsohhmrghinhhlihhnvgdrohhrghdprhgt
    phhtthhopehmrghrtggrnhesmhgrrhgtrghnrdhsth
X-ME-Proxy: <xmx:w7zSZgVNO_3QdtrIY9rMINnq3SvYnWykU533H6IzIuL8zzHQn2_FSg>
    <xmx:w7zSZnkNUqwz-B8fSLHr95omjNdxLtFWPA2EkFc00kQpUlfjB3zy6w>
    <xmx:w7zSZtcOffHIZ_P-RJQJE9dzUv4MrMdkzDFsg2e30m0CX6A1i9olGg>
    <xmx:w7zSZhENZsBECJK6V7bkmtr4vJgE7q3azXP6pOVXA4ZntkBUt_pSog>
    <xmx:w7zSZhn3_A3JO2R-23XmMKrFxJ2ESz1mX7GrEMt9R84C7Zj091-0Mewd>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Aug 2024 02:48:35 -0400 (EDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Sven Peter <sven@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 2/4] irqchip/apple-aic: Skip unnecessary setting of use_fast_ipi
Date: Sat, 31 Aug 2024 08:48:23 +0200
Message-Id: <05775A47-1FA8-47BF-9449-351CB35B9A42@svenpeter.dev>
References: <20240831055605.3542-3-towinchenmi@gmail.com>
Cc: Hector Martin <marcan@marcan.st>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, konrad.dybcio@somainline.org,
 ~postmarketos/upstreaming@lists.sr.ht
In-Reply-To: <20240831055605.3542-3-towinchenmi@gmail.com>
To: Nick Chan <towinchenmi@gmail.com>
X-Mailer: iPhone Mail (21G93)



> On 31. Aug 2024, at 07:57, Nick Chan <towinchenmi@gmail.com> wrote:
>=20
> =EF=BB=BFuse_fast_ipi is true by default and there is no need to "enable" i=
t.
>=20
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---

Acked-by: Sven Peter <sven@svenpeter.dev>


> drivers/irqchip/irq-apple-aic.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-a=
ic.c
> index 5c534d9fd2b0..8d81d5fb3c50 100644
> --- a/drivers/irqchip/irq-apple-aic.c
> +++ b/drivers/irqchip/irq-apple-aic.c
> @@ -987,9 +987,7 @@ static int __init aic_of_ic_init(struct device_node *n=
ode, struct device_node *p
>    off +=3D sizeof(u32) * (irqc->max_irq >> 5); /* MASK_CLR */
>    off +=3D sizeof(u32) * (irqc->max_irq >> 5); /* HW_STATE */
>=20
> -    if (irqc->info.fast_ipi)
> -        static_branch_enable(&use_fast_ipi);
> -    else
> +    if (!irqc->info.fast_ipi)
>        static_branch_disable(&use_fast_ipi);
>=20
>    irqc->info.die_stride =3D off - start_off;
> --
> 2.46.0
>=20



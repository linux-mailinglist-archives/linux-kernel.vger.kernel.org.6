Return-Path: <linux-kernel+bounces-309749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58188966FF6
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 09:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD003B21A14
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 07:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1AF16DEBD;
	Sat, 31 Aug 2024 07:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="H0TLueDx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nzj/0dTA"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F63D161326;
	Sat, 31 Aug 2024 07:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725087965; cv=none; b=qo4HdYOOQvahx1lQSQQdcc92GGjSpxmREYwi1BpAuDEzwG8kkUtq4HsiD8E7negabad6MNm5c93lGxDdlLQnLyeDWXIQBQddRSYEKeHMS/VngYkZdrgt3b3o4x8uiy7RAPrUIIxyy5ll6iTOqeicSaZBuTMmCnCRLT1Bq/kJSwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725087965; c=relaxed/simple;
	bh=6Hi53CaTME2Ebi8syWQ/1uJ40kzCigIEHluZ0P4NkH0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=f7ZEBwdROBNUpq/BrOLZW7EhbWxoapnJF6nDgy8uiRXRpvuF0u3DsHxjM2s9izmZP9unIHIyvzqnJu9H6D4kM6gW7ZQLxVI4ZATUHzaBloo7xQA1E3eZ/Bs67e8ndCHybxDInTB4V7zuu0qholLWSg1ePfpvT0ym0b/RgZEVae4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=H0TLueDx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nzj/0dTA; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B3034114060D;
	Sat, 31 Aug 2024 03:06:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sat, 31 Aug 2024 03:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1725087962; x=1725174362; bh=/T1bfOUPYYzScaMq5P6hnUwfWlzujRpW
	wVsHEjQEmYM=; b=H0TLueDxi6d928Vlm6k4RRKm4UK8mJP755amtUx3FCEaXpdx
	NKzuCh5SaIDYvfpsmwL7153AzfRTWnsQ4nHy5mov9mIgtyq1J5Uihce2c1sAuTmf
	ZfYgx1LPgHg3oMxxuImcfPaF51qObNbaWqqjdmarS7qBniZ5urGjouusxeBCGjPc
	+DKGEmcJLZjDjTMKIs9zEE5DC08GxjDpfbXVYXsDdxr2J2vUzdpSQSEZMUcKoZqQ
	JKOWaxWhchcEQxVfu2YT+7iX0t2GKh2GqHAIs/+313DUtiQNTWr7lZLp3UFnXLaN
	ABNml02IISseiqidvE7l3f5Zk+YqlIcng2wckQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725087962; x=
	1725174362; bh=/T1bfOUPYYzScaMq5P6hnUwfWlzujRpWwVsHEjQEmYM=; b=n
	zj/0dTAISeRr64Xh8UneSnfw9ng1a4Feh+GPiUByBGsY4p7xPr3jaDg6u7Xb6P1h
	Z/3QtXJnn4rywt9D5/t25zO7yUHoEF2IYl5uba3bTe3ObbVZI65MQN2rTLesvKw2
	W6ew/6Sy5Q1+2gJSQuwCR7zY7tEd7h3hYq16YdcyutwNA8ibqZOpylsUhdmJCanx
	/I4/U9Whk9TxR+cKVoiHZ50EjlCKzKOB3DuvtM9v4TcBHBrE5qau7kxhZflEfHOv
	4vXYrHI+5opdbtnbAw9KLeXtHFJMGxfovk+fvcLEPo63/5RX/C8dCdidV9bK3WUv
	PyPgguNg+ZH9IdtDPaJuw==
X-ME-Sender: <xms:2sDSZjNtXAS2jxEhpMLuiMXBc8Ux0K2Xsk7iUqpVVnI_fALuoqTNPg>
    <xme:2sDSZt9scBKO6Jo-SGa3LNSB_wzyh3eQPoyDdxt-gdGKbGSrtxNWHokEW9U4YvMVM
    ZPntrhO0T_zqbgNL7I>
X-ME-Received: <xmr:2sDSZiQNo5K8qMv2t9Qu_nbyXtCrL6lHlXSdBj2q9pkyTvADzsoRCY-I4GM-ovVjCbIGS2cAj9B73RpMC6rpqqN8HLuMYnDO4hcGve73ewrXWl2_Mcu24FqSIuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefjedguddugecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:2sDSZntcToeLQMts6aRKZG8rOsqdZVPJ2RQb44L1TlEFIU0qaLp0EQ>
    <xmx:2sDSZremGysfn7_s673amKOetK6HOHSceQdJIiOtkkNFlYnirP1hNg>
    <xmx:2sDSZj0CKRbyfjdbA8IS6ZfsJHATsxDwKKUR36h1XoX_69c9uyMjfg>
    <xmx:2sDSZn9TUrAAYSjWRnnqXJsiczk_jJJH2fyexR_heYN2Hr5BEVJZeQ>
    <xmx:2sDSZm-pE1OXg5IJJocP9luLGahLwus20cnPEwz10LTgrRqGb7nAlIOy>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Aug 2024 03:06:02 -0400 (EDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Sven Peter <sven@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 3/4] irqchip/apple-aic: Add a new "Global fast IPIs only" feature level
Date: Sat, 31 Aug 2024 09:05:50 +0200
Message-Id: <612CCDB4-26A7-432C-89F9-48743D547859@svenpeter.dev>
References: <20240831055605.3542-4-towinchenmi@gmail.com>
Cc: Hector Martin <marcan@marcan.st>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, konrad.dybcio@somainline.org,
 ~postmarketos/upstreaming@lists.sr.ht
In-Reply-To: <20240831055605.3542-4-towinchenmi@gmail.com>
To: Nick Chan <towinchenmi@gmail.com>
X-Mailer: iPhone Mail (21G93)


>=20
> On 31. Aug 2024, at 07:57, Nick Chan <towinchenmi@gmail.com> wrote:
>=20
> =EF=BB=BFStarting with the A11 (T8015) SoC, Apple began using arm64 sysreg=
s for
> fast IPIs. However, on A11, there is no such things as "Local" fast IPIs,
> as the SYS_IMP_APL_IPI_RR_LOCAL_EL1 register does not seem to exist.
>=20
> Add a new feature level, used by the compatible "apple,t8015-aic",
> controlled by a static branch key named use_local_fast_ipi. When
> use_fast_ipi is true and use_local_fast_ipi is false, fast IPIs are used
> but all IPIs goes through the register SYS_IMP_APL_IPI_RR_GLOBAL_EL1, as
> "global" IPIs.
>=20
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---

Reviewed-by: Sven Peter <sven@svenpeter.dev>

> drivers/irqchip/irq-apple-aic.c | 24 +++++++++++++++++++++++-
> 1 file changed, 23 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-a=
ic.c
> index 8d81d5fb3c50..01a3c79054f5 100644
> --- a/drivers/irqchip/irq-apple-aic.c
> +++ b/drivers/irqchip/irq-apple-aic.c
> @@ -235,6 +235,8 @@ enum fiq_hwirq {
> };
>=20
> static DEFINE_STATIC_KEY_TRUE(use_fast_ipi);
> +/* True if SYS_IMP_APL_IPI_RR_LOCAL_EL1 exists for local fast IPIs (M1+) *=
/
> +static DEFINE_STATIC_KEY_TRUE(use_local_fast_ipi);
>=20
> struct aic_info {
>    int version;
> @@ -252,6 +254,7 @@ struct aic_info {
>=20
>    /* Features */
>    bool fast_ipi;
> +    bool local_fast_ipi;
> };
>=20
> static const struct aic_info aic1_info __initconst =3D {
> @@ -270,17 +273,32 @@ static const struct aic_info aic1_fipi_info __initco=
nst =3D {
>    .fast_ipi    =3D true,
> };
>=20
> +static const struct aic_info aic1_local_fipi_info __initconst =3D {
> +    .version    =3D 1,
> +
> +    .event        =3D AIC_EVENT,
> +    .target_cpu    =3D AIC_TARGET_CPU,
> +
> +    .fast_ipi    =3D true,
> +    .local_fast_ipi =3D true,
> +};
> +
> static const struct aic_info aic2_info __initconst =3D {
>    .version    =3D 2,
>=20
>    .irq_cfg    =3D AIC2_IRQ_CFG,
>=20
>    .fast_ipi    =3D true,
> +    .local_fast_ipi =3D true,
> };
>=20
> static const struct of_device_id aic_info_match[] =3D {
>    {
>        .compatible =3D "apple,t8103-aic",
> +        .data =3D &aic1_local_fipi_info,
> +    },
> +    {
> +        .compatible =3D "apple,t8015-aic",
>        .data =3D &aic1_fipi_info,
>    },
>    {
> @@ -750,7 +768,8 @@ static void aic_ipi_send_fast(int cpu)
>    u64 cluster =3D MPIDR_CLUSTER(mpidr);
>    u64 idx =3D MPIDR_CPU(mpidr);
>=20
> -    if (MPIDR_CLUSTER(my_mpidr) =3D=3D cluster)
> +    if (static_branch_likely(&use_local_fast_ipi) &&
> +        MPIDR_CLUSTER(my_mpidr) =3D=3D cluster)
>        write_sysreg_s(FIELD_PREP(IPI_RR_CPU, idx),
>                   SYS_IMP_APL_IPI_RR_LOCAL_EL1);
>    else
> @@ -990,6 +1009,9 @@ static int __init aic_of_ic_init(struct device_node *=
node, struct device_node *p
>    if (!irqc->info.fast_ipi)
>        static_branch_disable(&use_fast_ipi);
>=20
> +    if (!irqc->info.local_fast_ipi)
> +        static_branch_disable(&use_local_fast_ipi);
> +
>    irqc->info.die_stride =3D off - start_off;
>=20
>    irqc->hw_domain =3D irq_domain_create_tree(of_node_to_fwnode(node),
> --
> 2.46.0
>=20



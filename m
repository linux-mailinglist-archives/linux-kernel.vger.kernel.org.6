Return-Path: <linux-kernel+bounces-388362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5F79B5E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48948284399
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95C41E1C2D;
	Wed, 30 Oct 2024 09:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="QunG6r9Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R2HMVRLO"
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740271D14FD
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 09:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730279164; cv=none; b=gXKCTI0zTVYXhWrG/HxmwmvjOCpVBEVANSK5Jb6aVtAFUnru8nuiInUaedOgz9zTsEUE5CTaty4yPQr+p/DRvL9X3P2Ybo3fXc5ADOW/KzuwoSacI4cvtymX2zffND4/faj/IHMoeevJ+7fX2O9eotCx5uASfONpN4amhWoAILg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730279164; c=relaxed/simple;
	bh=ZZxRaZVnt2nPYJGGjL4kGTBYOspXUmfXAMHRfo3hkns=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QgixC+AEvggIGSbWwbAuYKGqQpDCYs6LB/o1Kh6zz1IO90b7jzDDsoknfjsqDzaAUjjb/XMAzjmhUgIvnJZGLvn708YZwy5xXQDQmXsjk8Oqz0ULwhYfnYuFhKoOgwHpemJEA4kyPWEo3yyf/AUQQB+UtpIEaK13LYq2dbiBIpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=QunG6r9Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R2HMVRLO; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id A02681380206;
	Wed, 30 Oct 2024 05:05:59 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-09.internal (MEProxy); Wed, 30 Oct 2024 05:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1730279159;
	 x=1730365559; bh=4RrBTD10h5kAqDyvKF9/qsl96Pvp6WfhJjPxSJBS5qs=; b=
	QunG6r9YK1xbZPqXk6hgK3NemTDS/RjM2Pwhl6W8xtj/x2HeNjOaEg91ihqeQU84
	K6RraylgJgKTKoyU4P2AbdkUQMoItbYROaybzi0avcl/3uCJa2Lx8hpnUzBJ5+EZ
	50wUskvHBDElCZ5rzuFs0PBm+9y440Bc268AdIv/C2zw94dyCgga0ap+iqjAnPN+
	kba/4MLPzbK+ASWhHJPHgvL/4UVLd6ElZbHh1eAc+UOqdUq4jCL2ItLgPvdcqlMF
	BRSyKZa89HEKGr2cqXRqdnmY5DMGEUA8AWPYgZAJlJMHlLglOpjVr//WKsgqT8DJ
	52e8V2qeNwe5ohg7utZ7qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730279159; x=
	1730365559; bh=4RrBTD10h5kAqDyvKF9/qsl96Pvp6WfhJjPxSJBS5qs=; b=R
	2HMVRLOHr5n9s6Tk3nMse5fvbxcruJ4mHIzoRa/9mC9YNfozN/Ku3oXJ1RVGhZax
	WtlP4M8Ag3guJWZqFcOm7VtFeMsT9v+WoXRkXVM9yBCVZo/R5t9PwmfjA5t3fpRw
	hen32LO8ZtHJN+tNhQJXzAxKyPmWc5PKYr5hQt4w0pwN6+lH9Tkml9hEh2Cpfm5t
	sPgSMt/87ACt1gZdoG8EKG+FOxeMBxF2bePLnw619HD2GfxwLdaSCeYxt4EykKR1
	Q/uP0Q+eqc+VYQal1DSTsyUdULX+T3vxvsIeJ9NLZgH2Qq/4gQniJ7Alh/znNfIO
	ymSl332YVweMfnaMEaboQ==
X-ME-Sender: <xms:9vYhZ9Qqv0NpAcsR9kYB4QnFGZfif5wXwbiwOKYE_j7lcl_luTSxwA>
    <xme:9vYhZ2zQRTR7MvgxVrYyuFGp7LBV-w5BCRBQ8F0laqxVhoUanGOXdqm6VLS2Y1Hyt
    0Mcpe4TYVqEVVvXFJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekvddguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdflihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgse
    hflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeejheefuddvtdfggfdvffek
    teehhfelgfdvvedvkeeuffefkeehheegvefhveetjeenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghho
    rghtrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegthhgvnhhhuhgrtggriheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhu
    ohhrvghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhonhhgrghrtghhsehlih
    hsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhoohhnghhsohhnqdhkvghrnhgv
    lheslhhishhtshdrlhhoohhnghhnihigrdgtnhdprhgtphhtthhopegthhgvnhhhuhgrtg
    griheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehlihiguhgvfhgvnhhgsehlohho
    nhhgshhonhdrtghnpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlseigvghntdhnrdhnrghmvg
X-ME-Proxy: <xmx:9vYhZy0e6706Q3BP1ewFrOQJMqFYiKQ-EJqUsPppGjC12HxMObmvFw>
    <xmx:9vYhZ1Czlzb01zuJi3diiR2GZTSbx3v4OjTW6515tgXLmv0D-QQMOw>
    <xmx:9vYhZ2j9tHOQlqDompGiSfUNOJ92xfLHUTV4iJvsjU7XnK_yiPyMGQ>
    <xmx:9vYhZ5rxgSxm8bEhHEa85XpMuynRylSh9jPbapTp_nsjMrEwMpJB0A>
    <xmx:9_YhZ6hNtLRLkzvCSH2P0OgX9iWuZC05aqLDyodAhHRLjoOVsQPDqgli>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6697D1C20066; Wed, 30 Oct 2024 05:05:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 30 Oct 2024 09:05:38 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Huacai Chen" <chenhuacai@loongson.cn>,
 "Huacai Chen" <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, "Xuefeng Li" <lixuefeng@loongson.cn>,
 "Guo Ren" <guoren@kernel.org>, "Xuerui Wang" <kernel@xen0n.name>,
 linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Message-Id: <4b6df6db-2f2e-4128-a969-c9dff3345c84@app.fastmail.com>
In-Reply-To: <20241030081110.3431220-1-chenhuacai@loongson.cn>
References: <20241030081110.3431220-1-chenhuacai@loongson.cn>
Subject: Re: [PATCH] LoongArch: Disable KASAN if PGDIR_SIZE is too large for cpu_vabits
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B410=E6=9C=8830=E6=97=A5=E5=8D=81=E6=9C=88 =E4=B8=8A=
=E5=8D=888:11=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> If PGDIR_SIZE is too large for cpu_vabits, KASAN_SHADOW_END will
> overflow UINTPTR_MAX because KASAN_SHADOW_START/KASAN_SHADOW_END are
> aligned up by PGDIR_SIZE. And then the overflowed KASAN_SHADOW_END loo=
ks
> like a user space address.
>
> For example, PGDIR_SIZE of CONFIG_4KB_4LEVEL is 2^39, which is too lar=
ge
> for Loongson-2K series whose cpu_vabits =3D 39.
>
> Since CONFIG_4KB_4LEVEL is completely legal for CPUs with cpu_vabits <=3D
> 39, we just disable KASAN via early return in kasan_init(). Otherwise =
we
> get a boot failure.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

I was hit by this issue as well.

Thanks
- Jiaxun

> ---
>  arch/loongarch/mm/kasan_init.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasan_=
init.c
> index 4a0d1880dd71..6bdcc8751d4e 100644
> --- a/arch/loongarch/mm/kasan_init.c
> +++ b/arch/loongarch/mm/kasan_init.c
> @@ -262,6 +262,17 @@ void __init kasan_init(void)
>  	u64 i;
>  	phys_addr_t pa_start, pa_end;
>=20
> +	/*
> +	 * If PGDIR_SIZE is too large for cpu_vabits, KASAN_SHADOW_END will
> +	 * overflow UINTPTR_MAX and then looks like a user space address.
> +	 * For example, PGDIR_SIZE of CONFIG_4KB_4LEVEL is 2^39, which is too
> +	 * large for Loongson-2K series whose cpu_vabits =3D 39.
> +	 */
> +	if (KASAN_SHADOW_END < vm_map_base) {
> +		pr_warn("PGDIR_SIZE too large for cpu_vabits, KernelAddressSanitize=
r=20
> disabled.\n");
> +		return;
> +	}
> +
>  	/*
>  	 * PGD was populated as invalid_pmd_table or invalid_pud_table
>  	 * in pagetable_init() which depends on how many levels of page
> --=20
> 2.43.5

--=20
- Jiaxun


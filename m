Return-Path: <linux-kernel+bounces-340201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 580A2986FCA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6A21F24152
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B950A155A47;
	Thu, 26 Sep 2024 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="H6qTvVtq"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4781AB6C5
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342199; cv=none; b=s++ZNMNnVpcd+239CYnLLhrO7YEz/Q2tuA9x5DP+g82p5gFodskN0R1Ps0sstJi55Wzq69GVtU7X0KfcZ9BU2nenHbAe2DDlE253HXGHqlUGdXQFU7ZT8W2cgmnlOCSf+QlE6mIaSVfglrajCMenPQAytTwYpG1uQRcfVaZWd0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342199; c=relaxed/simple;
	bh=7PkzOUnuPkgQ3LtHursG8Iucx2zFyr8ihELw1sXDK/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLqLg354WTsPcjun1snk+1t3LrVAKUzG+3ppwSO55nU4WHR/PNXhLXMOrjhlvmP3nK1s0/uZ+2s8K1lXksgEVcsVbd+2T8tsbn4SpqJWjYPVxi4Zg7aLg4MBK4iT5Br1qrej4J29v+cdxNydGX/4xLHFARvZ7H18L3NIVsHdtJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=H6qTvVtq; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1FE204063F
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727342192;
	bh=kdMJjD4opcK8pwxBZ4G695jfmJjislpk7/g9KxdUbMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=H6qTvVtqCJBPI6D7O8XOFObqrB8B0HZbO1zYm906PeSvPXHopNGORjLQjK3dUxGq+
	 piyGSleX/Lt59QqnDL06t7E2d5zJCVywByWLDKSI8r0R/FpPVILDAcEJaObNledAh9
	 qMZGWv8aQjY5GNbixBQ6/xCsmrWvt9sI8OLHk2jhGiysp4g6+AlhtGMujGemzqQLki
	 5U/dAiTPvpYpvNzZvK/lPAWsRBNE3Mwodt0TH0SK7qocGwD6OrxDBypMZpdAsJpRLR
	 PnlXZzLWcZC999uqaokHahjvEtOG55rGANeZ+DArveVCkNlolRN/Czp4u97QnsJzpv
	 h6Q7i27wiyRTw==
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-504a0ae7b6bso199399e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 02:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727342186; x=1727946986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdMJjD4opcK8pwxBZ4G695jfmJjislpk7/g9KxdUbMA=;
        b=CD4r9IzL9U/HdFvKDrNHNz8PZPthaQaL+oGUXNhRPjp8/L8vtZpyQPzKLSHL+3igG8
         9+f3RdN8LQ/7Eqa1c43XVkhiv6ftWAYsa/v1Z4tqJcngB3BOWO39ri+YPKmH39ICUh6T
         vEdOuKzyvMgaikum61WnBWliDtCajoes2nH/LifW2Yby5zeb/GZ5rNr3Qmkw/tOVlgQi
         picla6Iyc2LwQiBdAXnuvHNtbcuokl9OhQ+iUK4nAWmkJca0wXUbyZwXBaM3/h3KkWqo
         gse2m8chdvs/1oZWMQZ4Nl6UggeZ6GxQHOxVCNE7JbDb0qmT/nJs9RyD0YT1wR7m0ccc
         FCCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhhXnOp7V9mX4QngZ31RQRkUukssQ+TtcAmSNwa6SfAO2oBNb5oQ0QWGRISZDiqdir8ttbsw6KCQrX904=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqtRZl7SCAYdEi26BA/Cf1T6mPb1DtioZ7tyYeYGe1sTXi2HX5
	6JliEDdeksMMiMpcKWIbXKHEVNgKkV8yP+H11SYDQv+9HiqiQ0IsoUvJtayei7b6Zxa3dDKsDaO
	aZLRupLhgAiCWm8Je7wYtB24P6JfPxE8iA9fRK6llu+z2Purkblaoo/GDH2mvlxh1P0kfeAWamD
	Ss79rQqtIETSgwts822l6kGZKQNan0kHWCBpjrWXyh6JZoolaDCcgX
X-Received: by 2002:a05:6122:1ad2:b0:4ef:53ad:97bd with SMTP id 71dfb90a1353d-505c1d785f8mr6687411e0c.3.1727342185782;
        Thu, 26 Sep 2024 02:16:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR3msiAwchookUE9Ihf5EsDoE38TLBraGCf/1zdqN40ufE7jE1N/koOITa7IqCiTgfKipTai/pknyfcKtKkPI=
X-Received: by 2002:a05:6122:1ad2:b0:4ef:53ad:97bd with SMTP id
 71dfb90a1353d-505c1d785f8mr6687385e0c.3.1727342185405; Thu, 26 Sep 2024
 02:16:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com>
 <20240925143325.518508-2-aleksandr.mikhalitsyn@canonical.com>
 <20240925155706.zad2euxxuq7h6uja@quack3> <142a28f9-5954-47f6-9c0c-26f7c142dbc1@huawei.com>
In-Reply-To: <142a28f9-5954-47f6-9c0c-26f7c142dbc1@huawei.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Thu, 26 Sep 2024 11:16:07 +0200
Message-ID: <CAEivzxc-b-QDx8AEdHEwa06Q2TYgZZkw2PWQ+K_Lyf+oyTM1Zg@mail.gmail.com>
Subject: Re: [PATCH 1/1] ext4: fix crash on BUG_ON in ext4_alloc_group_tables
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, tytso@mit.edu, stable@vger.kernel.org, 
	Andreas Dilger <adilger.kernel@dilger.ca>, =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	Wesley Hershberger <wesley.hershberger@canonical.com>, Yang Erkun <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 10:29=E2=80=AFAM Baokun Li <libaokun1@huawei.com> w=
rote:
>
> On 2024/9/25 23:57, Jan Kara wrote:
> > On Wed 25-09-24 16:33:24, Alexander Mikhalitsyn wrote:
> >> [   33.882936] EXT4-fs (dm-5): mounted filesystem 8aaf41b2-6ac0-4fa8-b=
92b-77d10e1d16ca r/w with ordered data mode. Quota mode: none.
> >> [   33.888365] EXT4-fs (dm-5): resizing filesystem from 7168 to 786432=
 blocks
> >> [   33.888740] ------------[ cut here ]------------
> >> [   33.888742] kernel BUG at fs/ext4/resize.c:324!
> > Ah, I was staring at this for a while before I understood what's going =
on
> > (it would be great to explain this in the changelog BTW).  As far as I
> > understand commit 665d3e0af4d3 ("ext4: reduce unnecessary memory alloca=
tion
> > in alloc_flex_gd()") can actually make flex_gd->resize_bg larger than
> > flexbg_size (for example when ogroup =3D flexbg_size, ngroup =3D 2*flex=
bg_size
> > - 1) which then confuses things. I think that was not really intended a=
nd
> > instead of fixing up ext4_alloc_group_tables() we should really change
> > the logic in alloc_flex_gd() to make sure flex_gd->resize_bg never exce=
eds
> > flexbg size. Baokun?
> >
> >                                                               Honza
>
> Hi Honza,
>
> Your analysis is absolutely correct. It's a bug!
> Thank you for locating this issue=EF=BC=81
> An extra 1 should not be added when calculating resize_bg in
> alloc_flex_gd().
>
>
> Hi Aleksandr,

Hi Baokun,

>
> Could you help test if the following changes work?

I can confirm that this patch helps.

Tested-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

Kind regards,
Alex

>
>
> Thanks,
> Baokun
>
> ---
>
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index e04eb08b9060..1f01a7632149 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -253,10 +253,12 @@ static struct ext4_new_flex_group_data
> *alloc_flex_gd(unsigned int flexbg_size,
>          /* Avoid allocating large 'groups' array if not needed */
>          last_group =3D o_group | (flex_gd->resize_bg - 1);
>          if (n_group <=3D last_group)
> -               flex_gd->resize_bg =3D 1 << fls(n_group - o_group + 1);
> +               flex_gd->resize_bg =3D 1 << fls(n_group - o_group);
>          else if (n_group - last_group < flex_gd->resize_bg)
> -               flex_gd->resize_bg =3D 1 << max(fls(last_group - o_group =
+ 1),
> +               flex_gd->resize_bg =3D 1 << max(fls(last_group - o_group)=
,
>                                                fls(n_group - last_group))=
;
>
>          flex_gd->groups =3D kmalloc_array(flex_gd->resize_bg,
>                                          sizeof(struct ext4_new_group_dat=
a),
>


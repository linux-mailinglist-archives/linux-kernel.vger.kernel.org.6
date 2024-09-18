Return-Path: <linux-kernel+bounces-332208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C639797B6C7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 04:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79836281A02
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 02:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737B274C08;
	Wed, 18 Sep 2024 02:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bNHqtbRJ"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC2A10A1C
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 02:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726625989; cv=none; b=YvQ7SXd7Z/uORt4W1pHRpUnZLimHSspRDgnicgJbMQMT5hjTyFjRM+BkpLERT1GXg/zDYYzrd0pm/gmZQAc9FMyBwXwMiSblSFJrcfh0mdZ1jZ5kBNvkJ71+D83Z+iAAU8NSkhhwLEC2MDq7yxevHZYThH1IuiqhffsDazbW2ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726625989; c=relaxed/simple;
	bh=8UrAn19MGzGhcM5qs5gKj8H85GBBbUXKlqHrjzCPzKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBNjtGl3FXqmLsXcbMQiY65sGIFXk543P51MFdzYTy3XpMkbV/qDALqsAihG/rkayK/fhuUVGfFFlBYMUeakvFq29rdC4j2h46M9Ulok8O5v02o+YtDCEvaknTQ8NyE73mCsDGhXxibGL5SpO1it/yaoEcPrJ4PyvU1rSaF06/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bNHqtbRJ; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e04a6feef3so3131762b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 19:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726625986; x=1727230786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38IQuyNYr4G9x/ownl5XlsDSTzr49ps/SxbJM8SwQFo=;
        b=bNHqtbRJU5i61FMMwENLAMpPODUBOjegY/o3ujZGhkVTTahxelDN684qUhUasX5Usj
         cx7gYKmZq2aWM6S44OUP0k7ymMXgCa0RtAKWhmLNQOnzulnFv4gd2y6kfTCBc5wrxzHb
         uCAeUUfey3z2rltONs/AZpLdxylvNO+/QKNyskfPJYvkgrujAbo123jHPsQ22fyS4i5a
         ks8wrTKdjb4L+w9PfBVuVQpcCZtqL5HnvFKYyyZVbviSn+kSHrvkN592eNj1RBMu+rkZ
         3fg0O1F/Rzzp/wXL7ijAdvGfYtAcKzAjL4kivwCDiuROGAlWD0dV3joTkqlGU8pbLzgy
         pIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726625986; x=1727230786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38IQuyNYr4G9x/ownl5XlsDSTzr49ps/SxbJM8SwQFo=;
        b=kdMIblUufsK7BZrrqewh1uyWjDkLYf4//q9TeCxLs356suIAoVMRzLkyX/MY/7t9Gz
         eG/y50YLCAXiw4iShzxuOw1G3GQeorUzxjRlQtiEFANIurues40W2mu1u7e0DcorhL3a
         Oij2csLTSVhv9BPbTymhJXsVtcFFB3Y68ybEo43UbnfBKvVkZcmmB5tkBAVjW+19olns
         JIcwlE6YbRO4BI5xyoAaT7Ojw+IfGyy26/h4qayEJs+nIAG8ahd6TNFFqe5w7rzoYNon
         n8edXGGOHAikN+fOonUFgaRHx56BStfhVbgIB2h5ihYWC1LolejY6OxEfoK1i0AXdOhF
         Lj6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtahi22mI4RQd2aRZcHLgExDwYQ2KLeLA0+ejWuTc9SYD22fmAHjuVqR0s3M8tjp6ZdWUrj7u53vpBEDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0SIL2gWHX11tacjqDvwVfAJ5q/nBCffJ2l0z64ARYIAOb2Rwn
	n07QEvFqa3f7ucxxbzscQsvN8gF/h0DSeFQgIXlHhHnyAFqgmoobuFeOAOq+7liF0nvoU7KdtfR
	PDE1u8IL3R0sdVYL/RSadK2UjT5mUCcMAYzg8tg==
X-Google-Smtp-Source: AGHT+IHOt2Ka7riRi9KlsNvxnjXNk/TzLRXNpslrLJ1cdFZAENN+p8UUfEyuX+yWYAAlor05TArp4Fyp6/Ol8vRYhnE=
X-Received: by 2002:a05:6808:1897:b0:3e0:422e:f05b with SMTP id
 5614622812f47-3e071ae3bdamr13876490b6e.29.1726625986589; Tue, 17 Sep 2024
 19:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913080053.36636-1-mikisabate@gmail.com>
In-Reply-To: <20240913080053.36636-1-mikisabate@gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 18 Sep 2024 10:19:35 +0800
Message-ID: <CAEEQ3w=H7X0yeNg_qwbf0MxTO8gmXRaD0wJFv=xCKjqH-WNA_w@mail.gmail.com>
Subject: Re: [External] [PATCH] riscv: Prevent a bad reference count on CPU nodes
To: =?UTF-8?B?TWlxdWVsIFNhYmF0w6kgU29sw6A=?= <mikisabate@gmail.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	sudeep.holla@arm.com, jeremy.linton@arm.com, sunilvl@ventanamicro.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

On Fri, Sep 13, 2024 at 4:02=E2=80=AFPM Miquel Sabat=C3=A9 Sol=C3=A0 <mikis=
abate@gmail.com> wrote:
>
> When populating cache leaves we previously fetched the CPU device node
> at the very beginning. But when ACPI is enabled we go through a
> specific branch which returns early and does not call 'of_node_put' for
> the node that was acquired.
>
> Since we are not using a CPU device node for the ACPI code anyways, we
> can simply move the initialization of it just passed the ACPI block, and
> we are guaranteed to have an 'of_node_put' call for the acquired node.
> This prevents a bad reference count of the CPU device node.
>
> Moreover, the previous function did not check for errors when acquiring
> the device node, so a return -ENOENT has been added for that case.
>
> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mikisabate@gmail.com>
> ---
> I was wondering if this should also be sent to stable, but  I have not se=
en
> a report on it, and this is not responsible for an oops or anything like =
that.
> So in the end I decided not to, but maybe you consider otherwise.
>
>  arch/riscv/kernel/cacheinfo.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.=
c
> index d6c108c50cba..d32dfdba083e 100644
> --- a/arch/riscv/kernel/cacheinfo.c
> +++ b/arch/riscv/kernel/cacheinfo.c
> @@ -75,8 +75,7 @@ int populate_cache_leaves(unsigned int cpu)
>  {
>         struct cpu_cacheinfo *this_cpu_ci =3D get_cpu_cacheinfo(cpu);
>         struct cacheinfo *this_leaf =3D this_cpu_ci->info_list;
> -       struct device_node *np =3D of_cpu_device_node_get(cpu);
> -       struct device_node *prev =3D NULL;
> +       struct device_node *np, *prev;
>         int levels =3D 1, level =3D 1;
>
>         if (!acpi_disabled) {
> @@ -100,6 +99,10 @@ int populate_cache_leaves(unsigned int cpu)
>                 return 0;
>         }
>
> +       np =3D of_cpu_device_node_get(cpu);
> +       if (!np)
> +               return -ENOENT;
> +

It is necessary because the caller of populate_cache_leaves has a
return value judgment.
So,  Reviewed-by: Yunhui Cui <cuiyunhui@bytedance.com>

>         if (of_property_read_bool(np, "cache-size"))
>                 ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
>         if (of_property_read_bool(np, "i-cache-size"))
> --
> 2.46.0
>

Thanks,
Yunhui


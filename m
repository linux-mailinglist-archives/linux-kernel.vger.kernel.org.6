Return-Path: <linux-kernel+bounces-203690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43968FDF1A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765BF1C214A2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 06:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2289130482;
	Thu,  6 Jun 2024 06:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CCAYwqwO"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D37273472
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 06:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717656503; cv=none; b=fi8e2A9J8qgPLcJQ2u9Or3tFn7sGK+Ovn/rA5bqn/2b9nm8pmeXu0g/KptIjpArWjnCeVSqWdcMwzAAfkGx4Ai/Iszn3g01/wWZ3voVZ62T058ei+bGTFy/saMGVws1JOYRDqL8G/ImQCIyeSRmOb1Fo0kGdEkMMeAhQEbeVYE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717656503; c=relaxed/simple;
	bh=wqfPO29UB1/mjfccPPQT5JKS23yxeBTG0IwgeGdDHYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXRPcZO1GB0lLXIFKjjnCF9iPmMw2HLx4WIwqvDp7OqZ17eCvazQMFjFf5FqsW6XMKE08J+QOYF3LAl+RHrN7zINr8PqXiFOdjNnGpqVLn25Z/ZBADt+ty0Jvo4nJ3ixaKum9wxxXdX0ow0UaqO7rlRoviHGfvkOrBLOO9Ekux4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CCAYwqwO; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-25071c66178so311473fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 23:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1717656500; x=1718261300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vilLytCpZB8nt5wILPrH9W0JpiXVzx6FOQqaxS4d2XI=;
        b=CCAYwqwOKEozqe9/+R/2kOhT40SXTE/4MG2P4EgcDH6DNTzCqYb/k36NwK7dCegURk
         Jz89eWlaDAWSbb19AsKJiZs5CjguCKksv0bH1pIRlXTLYkTfShrORnpZWWcxUZDiY0/E
         0KpTkCtsY0vq+Jyg423J9zfQx09pFNBoDmYqQjHQXnvGeKh/MZ/96sETak7Wfekcq/WJ
         XSBWRgPLjrJsaU/JkiI/lq0l7lpF996rMSfbmMacVk0ICbbaTpxIGIBMago+z5NarYlA
         MwRd/XeDjm3OQq3C6sxHh9BHJF3EA7djVgook7ZM/eiEt7hKPVxyHpn2U+Ht5sByTRgt
         /LLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717656500; x=1718261300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vilLytCpZB8nt5wILPrH9W0JpiXVzx6FOQqaxS4d2XI=;
        b=H5AAIqP0tXzWAvc6l/yX6TXI2UdfpEM3/eZ8hFCucquHR9gZN5D2Fu6NgFZlsvDxmP
         RPQIiarykVh2fyAX2S89A8VXCH9rY5qfJTu4alcQ5HySQSa+ZaRsIEyoJTWV9lr7GpDZ
         6+MYNQhFqxwsJIBNm0q/G0UOLYuLm5bRLyBZ5sui0Z0nTyNbA7ffnA5HCz2HCDU9WC/W
         tdHsZ01+TgU/YXBYeyCCasVqzPuNqj/OGKBdKj0YOgdjNYwddAJ1xXgV2r4sk3GdvE+F
         q4vQw7+gE+zxk2deLhhnCdNWcvEEhInGwvVMDp5/VzwK/GMxoeRsgMQ1f0I/63lWkdG0
         8X5A==
X-Forwarded-Encrypted: i=1; AJvYcCV8+L3y2QNr6tbI1k6QkLStd5Q4eXd8Pikwny+y7odSEX5hyO0qFKKly7otmVL+dpNtlDEofDG0jyZVRCIUv079vY2N41/fAS4nOZYk
X-Gm-Message-State: AOJu0YwTjQey2Q/HToQ9layIWFGdA9mZMkXYLiRZx0h/wgQbX4hZYNIs
	atA5GQKoEHJt1ExFGAeXD1fcj3E6Mq0ddZLOBEteLdkCvRYlt6ekSC9hZP8iB235mfes9zMvmPd
	GicChj9NPfG4clPOzHUhDDE4jWdKjExgW6X03+w==
X-Google-Smtp-Source: AGHT+IE9l1hb0fFNXM4TPj/1zk1+1sZkZrVriFNUDmWKzdih+CtOnkmEdNr0xFuAptlVFLMK5CzKhMf9J7ne5mRr3iw=
X-Received: by 2002:a05:6871:e015:b0:24f:d159:ea2 with SMTP id
 586e51a60fabf-25121e60d1dmr5176728fac.28.1717656500045; Wed, 05 Jun 2024
 23:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531100407.282-1-dqfext@gmail.com>
In-Reply-To: <20240531100407.282-1-dqfext@gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 6 Jun 2024 14:48:09 +0800
Message-ID: <CAEEQ3wkKxt-p1339EbXt-1nF_GvMmgYMio3OBHZSNke1kJc5sQ@mail.gmail.com>
Subject: Re: [External] [PATCH] RISC-V: Implement ioremap_wc/wt
To: Qingfang Deng <dqfext@gmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Samuel Holland <samuel.holland@sifive.com>, 
	Qingfang Deng <qingfang.deng@siflower.com.cn>, Eric Chan <ericchancf@google.com>, 
	Andrea Parri <parri.andrea@gmail.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Hi Qingfang,


On Fri, May 31, 2024 at 6:04=E2=80=AFPM Qingfang Deng <dqfext@gmail.com> wr=
ote:
>
> From: Qingfang Deng <qingfang.deng@siflower.com.cn>
>
> Currently on RISC-V, ioremap_wc/wt uses the default ioremap
> implementation, which maps the memory as strongly-ordered non-cacheable
> IO memory on systems with Svpbmt.
>
> To improve performance, map the memory as weakly-ordered non-cacheable
> normal memory.
>
> Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
> ---
>  arch/riscv/include/asm/io.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> index 1c5c641075d2..582503e0f508 100644
> --- a/arch/riscv/include/asm/io.h
> +++ b/arch/riscv/include/asm/io.h
> @@ -133,6 +133,14 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw(=
))
>  #define outsq(addr, buffer, count) __outsq(PCI_IOBASE + (addr), buffer, =
count)
>  #endif
>
> +#ifdef CONFIG_MMU
> +#define ioremap_wc(addr, size) \
> +       ioremap_prot((addr), (size), \
> +                    (_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_NOCACHE)

> +
> +#define ioremap_wt ioremap_wc
> +#endif
> +
>  #include <asm-generic/io.h>
>
>  #ifdef CONFIG_MMU
> --
> 2.34.1
>
>

Can you provide specific test data for performance improvement?

Thanks,
Yunhui


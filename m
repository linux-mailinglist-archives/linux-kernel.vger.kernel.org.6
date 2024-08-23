Return-Path: <linux-kernel+bounces-299436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4956095D484
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6770A1C23293
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FC418660B;
	Fri, 23 Aug 2024 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GR2s24/j"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2CB18BBB9
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434813; cv=none; b=JWsu9+6DnWOUBSeYIxVerT3HgTdj1EJFE4Iy6yEkxeMhNSAifykgBu9hCodC1FiYDQDY11Alu/B4GALkWKB8zM/F1yGwBDGso756FszaG4vT8lW/KSLpiCF08C9dHGVPDJ0tqk3jf0OuKIqyIOBgqRdmOxdHVFy2Xxlzr2qQR+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434813; c=relaxed/simple;
	bh=TXfNChzrZarBmVT6IrFhYmqesKQ5ZLs7w+O0BxvrYPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnDQSRSMUNvBX5sNJXvioPXagREyDTb6Wj20UwdjCRJU5qaz7BHk7RHKPw+GtIy0sXSUtvnCBtxAuOlMPm/um5ACoJA5k1OoHjH0RZs7aFa98Y7oYBmcpmerL4qwd3LUVfQMDvcA2I5Zjlg1mOkYXX2h0GYBYdDztLjE8bAUDLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GR2s24/j; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8682bb5e79so315940866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 10:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724434809; x=1725039609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OH1qxLnA+Zvrf4Sge9MNfEyRKt/TljXbeyPaYEb99N4=;
        b=GR2s24/jdHvEuzW7FPkpGr9WgObDzH9zQXuDm3zqc7QxfYIUbmn6LNI8RtODCf3uEQ
         uJEinpRvz0aasJrxAuadBDCXQO5W2aXeHJ6qhlymhYrdlqoOllFxOYxQ2PQm5aihF/TT
         XSsfhgOJe0KcFbGp9NF1dCJAGdtTy8mtHzIrQEJr3GoKXGSX2/oi5bfCQLl/j5ln0m8D
         r2Asdl7aI7EA8fEgZorIIJmlr5ac6ITIaomywTG9XA/9fnlhBelSl0m86BVnzMhhOhah
         WpXV9qcgSXy/MQ7oGiRSpVCG1FQtMbDYOqtnADNOtMVz3yfmIVzhJ61f2LJDO8IvDcMp
         xx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724434809; x=1725039609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OH1qxLnA+Zvrf4Sge9MNfEyRKt/TljXbeyPaYEb99N4=;
        b=Ilv1GQS7WXq0vUVUVbdTaafsluhol8PcxqjBJrt0Jy8h+6StV+ol0L8YhMcaIydb5A
         UYqR7WS744BgmlvX82QcAdxxuZbcvdn5YxZotErNfE54kexT/sXQI/CwLNht4oqTxadX
         pts/uOvhjaWQ4+3ohmmm3kDBFPoSAQda5uNl19yGvDSOmUOYbn10FogUvyn5HH2/Y1y0
         5ZMpoD53EWD9v8ONj97EnOZ3ghOdVxkI4LamiZQl3CDIJYatzs8vUtXc0xMOeVKXMtR7
         LanJfy8v5yPMVT6kVllppcSGBr9Opog0szEop1rgJpWIh+WWlSQ5CLkdArzqU9o00tFI
         oJlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMtRKKh1mSPS3hibjgfzDoUvB/beEEAPy/dJ2QwETBgMW/bsatZONkpccf3/4vL7Kk4NGU319RhvG9/gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD1pFVmr/3rpxXV8NDjWoTCl2+iF7C321GIx2HBXmJcjM1aTcW
	3fdYSignejlHbk4nPDhen0pve8MrUj9J+aNE/KMZ1HQ1T5e+NpwnoX8r+tjbG0/XmoAEyLDc7c0
	wZwUoXk8TQ9p0ISZLeOK/u51frdwlZ4VOLJBl
X-Google-Smtp-Source: AGHT+IEZXgTuCQle3Qpj7pdoBe4KBDDR6xavAWwaoebPKgC9Cg72qfd1jKAOJU/eu4TnICfm5Wzzvw5N7Ktr3y4lfAU=
X-Received: by 2002:a17:907:3fa9:b0:a86:a178:42de with SMTP id
 a640c23a62f3a-a86a54b8d19mr207320166b.54.1724434808769; Fri, 23 Aug 2024
 10:40:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823173103.94978-1-jdamato@fastly.com> <20240823173103.94978-2-jdamato@fastly.com>
In-Reply-To: <20240823173103.94978-2-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 23 Aug 2024 19:39:56 +0200
Message-ID: <CANn89iJE01V4TBCXg=w=M8=75TXypuYMJ_pXBUrN9NdRRAtAZg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/6] net: Add sysfs parameter irq_suspend_timeout
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, amritha.nambiar@intel.com, 
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net, 
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org, 
	willy@infradead.org, willemdebruijn.kernel@gmail.com, skhawaja@google.com, 
	kuba@kernel.org, Martin Karsten <mkarsten@uwaterloo.ca>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Breno Leitao <leitao@debian.org>, 
	Johannes Berg <johannes.berg@intel.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 7:31=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> From: Martin Karsten <mkarsten@uwaterloo.ca>
>
> This patch doesn't change any behavior but prepares the code for other
> changes in the following commits which use irq_suspend_timeout as a
> timeout for IRQ suspension.
>
> Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Co-developed-by: Joe Damato <jdamato@fastly.com>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> ---
>  rfc -> v1:
>    - Removed napi.rst documentation from this patch; added to patch 6.
>
>  include/linux/netdevice.h |  2 ++
>  net/core/dev.c            |  3 ++-
>  net/core/net-sysfs.c      | 18 ++++++++++++++++++
>  3 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 0ef3eaa23f4b..31867bb2ff65 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1857,6 +1857,7 @@ enum netdev_reg_state {
>   *     @gro_flush_timeout:     timeout for GRO layer in NAPI
>   *     @napi_defer_hard_irqs:  If not zero, provides a counter that woul=
d
>   *                             allow to avoid NIC hard IRQ, on busy queu=
es.
> + *     @irq_suspend_timeout:   IRQ suspension timeout
>   *
>   *     @rx_handler:            handler for received packets
>   *     @rx_handler_data:       XXX: need comments on this one
> @@ -2060,6 +2061,7 @@ struct net_device {
>         struct netdev_rx_queue  *_rx;
>         unsigned long           gro_flush_timeout;
>         int                     napi_defer_hard_irqs;
> +       unsigned long           irq_suspend_timeout;
>         unsigned int            gro_max_size;
>         unsigned int            gro_ipv4_max_size;
>         rx_handler_func_t __rcu *rx_handler;
> diff --git a/net/core/dev.c b/net/core/dev.c
> index e7260889d4cb..3bf325ec25a3 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -11945,6 +11945,7 @@ static void __init net_dev_struct_check(void)
>         CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_=
rx, _rx);
>         CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_=
rx, gro_flush_timeout);
>         CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_=
rx, napi_defer_hard_irqs);
> +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_=
rx, irq_suspend_timeout);
>         CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_=
rx, gro_max_size);
>         CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_=
rx, gro_ipv4_max_size);
>         CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_=
rx, rx_handler);
> @@ -11956,7 +11957,7 @@ static void __init net_dev_struct_check(void)
>  #ifdef CONFIG_NET_XGRESS
>         CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_=
rx, tcx_ingress);
>  #endif
> -       CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_rx=
, 104);
> +       CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_rx=
, 112);
>  }
>
>  /*
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 0e2084ce7b75..fb6f3327310f 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -440,6 +440,23 @@ static ssize_t napi_defer_hard_irqs_store(struct dev=
ice *dev,
>  }
>  NETDEVICE_SHOW_RW(napi_defer_hard_irqs, fmt_dec);
>
> +static int change_irq_suspend_timeout(struct net_device *dev, unsigned l=
ong val)
> +{
> +       WRITE_ONCE(dev->irq_suspend_timeout, val);
> +       return 0;
> +}
> +
> +static ssize_t irq_suspend_timeout_store(struct device *dev,
> +                                        struct device_attribute *attr,
> +                                        const char *buf, size_t len)
> +{
> +       if (!capable(CAP_NET_ADMIN))
> +               return -EPERM;
> +
> +       return netdev_store(dev, attr, buf, len, change_irq_suspend_timeo=
ut);
> +}
> +NETDEVICE_SHOW_RW(irq_suspend_timeout, fmt_ulong);
> +
>  static ssize_t ifalias_store(struct device *dev, struct device_attribute=
 *attr,
>                              const char *buf, size_t len)
>  {
> @@ -664,6 +681,7 @@ static struct attribute *net_class_attrs[] __ro_after=
_init =3D {
>         &dev_attr_tx_queue_len.attr,
>         &dev_attr_gro_flush_timeout.attr,
>         &dev_attr_napi_defer_hard_irqs.attr,
> +       &dev_attr_irq_suspend_timeout.attr,
>         &dev_attr_phys_port_id.attr,
>         &dev_attr_phys_port_name.attr,
>         &dev_attr_phys_switch_id.attr,
> --
> 2.25.1


Please no more per-device sysfs entry, shared by all the users of the devic=
e.

Let's not repeat past mistakes.

Nowadays, we need/want per receive-queue tuning, preferably set with netlin=
k.


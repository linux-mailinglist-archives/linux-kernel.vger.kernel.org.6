Return-Path: <linux-kernel+bounces-513585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA26A34C24
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD8D3AD1D1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2E1212B3A;
	Thu, 13 Feb 2025 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZAdcG3d2"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81256204C0B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739468016; cv=none; b=WBflQ98CXdiWjEqLaMc3ATKkW2PBvwC6Fy80CdlmniFLfv6iGUEjLhUizZ/4BC7eUiSCTuuf/H44ovxpO4TeMlHPE1x9FkMLcIBXWBNTdnIceaJsiayLkq4KOygW7qO7YDzSguaJFnyubDSt+w0UO+FDow1X9OAOdpNroLl+bQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739468016; c=relaxed/simple;
	bh=IBE3DqvfPltRFsm3mBAK8i9sdVtPitaS7V/S98s+J1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSc/lA3ERIlebKJ5F2tU2P6SsG12ppTbWZMxqmMavDhLu8lAPWBfuZSWNHwNkfov2nigk+RRrVjdzUm0EMTEJ/18/OvYLnAk8J0UWmCOV3/45YoYxn8s5YYqNVloWuYEGeef6VT2L7T871j5r4MsLJA01WrKfrHyNecM9Y2sc/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZAdcG3d2; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-545092d763cso6739e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739468013; x=1740072813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGgVrzsAeNL3Ky4gN5+3YPP2m5D+SPcUN3lTNqfCOfc=;
        b=ZAdcG3d2q4EirvAbbptmx24krGguX6P9vGMVWSJsyrWNpWGCepGpiVTMCx9cflDNX1
         BxzYrLkAEfOwBkX30FngzCfzwVqA40ZJ3pez0NH9lY+mhl5xCXWy3e512zpsD1sW1zhK
         Q+CdK78eLODpJXYsqNcS1t7PKCcf4xk0dum6lYg/4EGhEwKYOZzeSisNFdSUv7FHMr6x
         /YN3lSQ37WP4dfdPqnOaEMrFOsRppUeArScX/QQGOcBYbFBYyAQ6p4qKrh1Y9xkbMj/n
         +NuNpZ+ZjAPo7Oze3aIpb6nWLvGtp10ZNdQ5jt4Il/bB+Ths88rd0bTksVvmkproLnLm
         Jmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739468013; x=1740072813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGgVrzsAeNL3Ky4gN5+3YPP2m5D+SPcUN3lTNqfCOfc=;
        b=A4lRFWGfcTWEI070z22Bw7W/34gxGwomfsjqk+jarLELXS4T1itE9/rfSaeJA8K9Ux
         QwCkBFAHhupovd8Dv1oyJvcn1mfwYgqLQr6xY9bQ6zc+OXaH6L1fXMg7TbS8zDL3Wfzm
         Xb/xNfP89HFCjOu39HD+KXWHl7NKrSz94t2au2SZ3EBYp1I1Tb8NCta5Zvz9gqgYabqH
         LvG4kGgvJ9NroCZRTmifvfoOPKtdnYTCvGnde+bTpP2afY/JnXPhsFuJXVWJIVK30c/h
         RMnSoAdqWfm+SczhIXHmgIpkE0fY7iiuyC5e7DYgybX/axf/wuv/WbWqLvMdXkTLjN+T
         Havw==
X-Forwarded-Encrypted: i=1; AJvYcCVR6Kb3PsPteCezZdFJ7p02xilCt1ffSS7ec8CGHVQ+1M3eVcGdqsi2lUFNJYKh7VMzvpTOCwbXKOrM4oI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU6Z1GMj+lxY6GaojYMGFj3bg5WvjjXTiTJs1AZbhg1QCvkn/Y
	DjbLM2Z4EUuU+64dsKDMhXmDY51/057YLC4VVJIbsCWklluobmx6haHyLj/hbN8U6m0aSnqGrtN
	Sf01iei5Io0PcwARPjb7RkPC+efI0u63vxUWY
X-Gm-Gg: ASbGncv7AVO21aODC3GE5gmu1lPZHE31O0jqip355RAaQEjNcgdcXD90EQCLxQUoqsV
	Nbm1A1QHyb10MQfNJQWdF0UMr4rifHZ8oEFtePwzgbb5/N1+c9BY0IqHtLEAU9k1V0bbgz9wD97
	csuP0BVmC+kVvrfXr3KEUBiv6ZTshj
X-Google-Smtp-Source: AGHT+IET0OV89iYfpu0mSYog4w1SQPmfp2RBaQSQSyY+Bufo1G9ums2tRHgQYhjw7LlG2MpjYEKfhvU+TU3OvVYN8WM=
X-Received: by 2002:a05:6512:1193:b0:543:e3c3:5a5e with SMTP id
 2adb3069b0e04-5451e020774mr343672e87.4.1739468012362; Thu, 13 Feb 2025
 09:33:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212000747.3403836-1-vannapurve@google.com>
 <20250212000747.3403836-3-vannapurve@google.com> <ljdzupgyl2am4qgvirwpdonwuzwjaysemu43icrzxjt5olr3yx@dldbi5tqwhjh>
In-Reply-To: <ljdzupgyl2am4qgvirwpdonwuzwjaysemu43icrzxjt5olr3yx@dldbi5tqwhjh>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 13 Feb 2025 09:33:20 -0800
X-Gm-Features: AWEUYZlhzsA-Sl-KzuUXdz9zcP5QTmYOsipXxAYftqBemHGY7puDNPu9R37JLpc
Message-ID: <CAGtprH9OVVMXLyPnKXZ+K=S7XuPePHLwco0sXV-irGVj-SCbkQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/4] x86/tdx: Route safe halt execution via tdx_safe_halt()
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, erdemaktas@google.com, ackerleytng@google.com, 
	jxgao@google.com, sagis@google.com, oupton@google.com, pgonda@google.com, 
	dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 4:54=E2=80=AFAM Kirill A. Shutemov <kirill@shutemov=
.name> wrote:
>
> On Wed, Feb 12, 2025 at 12:07:45AM +0000, Vishal Annapurve wrote:
> > Direct HLT instruction execution causes #VEs for TDX VMs which is route=
d
> > to hypervisor via TDCALL. safe_halt() routines execute HLT in STI-shado=
w
> > so IRQs need to remain disabled until the TDCALL to ensure that pending
> > IRQs are correctly treated as wake events. So "sti;hlt" sequence needs =
to
> > be replaced with "TDCALL; raw_local_irq_enable()" for TDX VMs.
>
> The last sentence is somewhat confusing.
>
> Maybe drop it and add explanation that #VE handler doesn't have info abou=
t
> STI shadow, enables interrupts before TDCALL which can lead to missed
> wakeup events.

Ack, will fix it in the next version.

>
> > @@ -409,6 +410,12 @@ void __cpuidle tdx_safe_halt(void)
> >               WARN_ONCE(1, "HLT instruction emulation failed\n");
> >  }
> >
> > +static void __cpuidle tdx_safe_halt(void)
> > +{
> > +     tdx_halt();
> > +     raw_local_irq_enable();
>
> What is justification for raw_? Why local_irq_enable() is not enough?
>
> To very least, it has to be explained.

Let me replace it with a more suitable arch specific <>_irq_enable()
function in the next version. Intention here is to just enable
interrupts.

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov


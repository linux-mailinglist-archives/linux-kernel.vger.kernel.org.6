Return-Path: <linux-kernel+bounces-428585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A649E10E6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 02:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1D6280BDB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A86B3BB21;
	Tue,  3 Dec 2024 01:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gammGrEF"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBE27CF16
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 01:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733190307; cv=none; b=L2h20q74Ay+kdIzUTkV/NIV/QCv6LHaLAaX2Jk4UmEIPMuiXkxN+xquOfGTMjhTArCtWrIAQnTyhw/qPAev2J/f6Q6DgEZ4myHOhYCpLMkVdDNo/HqHLmxgK8mMYoHI5i3KxH31ZWOX++QDOOnIM4sX6ZMGWfTsaATNU458iJ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733190307; c=relaxed/simple;
	bh=HbuFI/riZulpFH9oeFjnjmTcBp+J3kMI3l1dSbEdv+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzt0rDj4IDYHKMKf39OJNT82tRUsN+Rm+DfYpQSAA4gfrjGWA87f6S/jztXMZAyW2tOkDLhKGJZ4yXq5zTi1nVtaKNN2U9rBFXc/LIwm9SArWzHhrO9NPvBkeAasaW4XVN7SyVxlM7FgoOI0eN0SFmflmY5Dkyz4MUyynSRQhp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gammGrEF; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-51526b9e341so1274875e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 17:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733190305; x=1733795105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wscqKrTwFb9sgoc/UfAh+DpARa9frP273Npy3sEJYN8=;
        b=gammGrEFMqVu53ULwAZUDC4NzMOr+sqjMgaeTg626yFrwlHXVCEHQ6hgv4uPkfwRA8
         2piOnABchhi1iIBxRJaRcx+3LYtaHB9lf2WbFRFlOlEHWVK3lQ6bwxY3ZWrE/4GWfm0K
         VTdu264Sj9GjnS3XUvDrqblEc6SauRU/J1nUjjOW5BvJeIO36aiQXxvgTOtj1INTfzT2
         IBkHnR1g7O7smg1Ws/unIpYS2OraU1rYj4yJwoZFqsRB+95WshFMWJ7PS6HpP4w2jVGn
         v3XC6Ge9mMblziHTFYlQSoX+3CXbZ0VcCtI5V6vtPjRAPPLliNqgPyg5c6ISJl8vi5D3
         TQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733190305; x=1733795105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wscqKrTwFb9sgoc/UfAh+DpARa9frP273Npy3sEJYN8=;
        b=J1x29TCn0ZFe9nVUX+JDpCdKyAdsgLLQgWdCvuPGs7sR+C5cX7+IxUFerCvRsKgX4B
         x8shOBPfvtN8gnrSLBdYw+e5iPjMvqoVMKn3nrML7+99ZqxFRiDoJyR7Nub1muD3GdK9
         jgfjHiuuC/nMT4AvgZB5kdaG/usyMwZNMeaXiCUTm0wZim8B6VkR6o//FaYibj1WMxmH
         7iIy1gTR6DgbKqkrvwYdN4M8nyzVNCyLkrxWnhgeRlIqAiUgkPVgM2coHoUlgXC2NHjA
         WVXcsiVw3DGuBpSjsZxRLWX8zPmUcwgoOMOV2ZyJiltDf9aJbt4V2f6Ns6b8so+bIE+E
         JAaA==
X-Gm-Message-State: AOJu0Ywr3o81MGJ43HnRwsQfgnptAzAYbH91RVq9pWU7i0aSyDaE3gJj
	QSfFSfveVjD/ZaXR6hPQlg1KeSzQTZh0bO823d4NPRGbWEHgMrb2OqaG1pT/A2eg73ShHOhy5UA
	9eRkSV84i91uuRRAtb57fROIHmFVj5KrBJcmY
X-Gm-Gg: ASbGncuYa1X/Qel7Hc8MDRNHcUo9rzagx3jSZEgfF6K2YOT5EvBBXZny2o2mAs5FuZI
	0kUHVVwgVK6Uscabjkj6YGFcHpcdJYQyt
X-Google-Smtp-Source: AGHT+IEp0cLLV0HS2GVNv35k+CB8WVNUZpet9fwmVxa/fQluHk3o8PZV+wDlJqqbk9+pA1JRUyjCGBWE6ek73EZak9c=
X-Received: by 2002:a05:6122:169a:b0:515:4fab:2e53 with SMTP id
 71dfb90a1353d-515bf56cea7mr1114649e0c.7.1733190304632; Mon, 02 Dec 2024
 17:45:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203005921.1119116-1-kevinloughlin@google.com>
 <20241203005921.1119116-2-kevinloughlin@google.com> <a9560e97-478d-4e03-b936-cf6f663279a4@citrix.com>
In-Reply-To: <a9560e97-478d-4e03-b936-cf6f663279a4@citrix.com>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Mon, 2 Dec 2024 17:44:53 -0800
Message-ID: <CAGdbjmLRA5g+Rgiq-fRbWaNqXK51+naNBi0b3goKxsN-79wpaw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] x86, lib, xenpv: Add WBNOINVD helper functions
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: linux-kernel@vger.kernel.org, seanjc@google.com, pbonzini@redhat.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	kvm@vger.kernel.org, thomas.lendacky@amd.com, pgonda@google.com, 
	sidtelang@google.com, mizhang@google.com, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 5:28=E2=80=AFPM Andrew Cooper <andrew.cooper3@citrix=
.com> wrote:
>
> On 03/12/2024 12:59 am, Kevin Loughlin wrote:
> > diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/par=
avirt.h
> > index d4eb9e1d61b8..c040af2d8eff 100644
> > --- a/arch/x86/include/asm/paravirt.h
> > +++ b/arch/x86/include/asm/paravirt.h
> > @@ -187,6 +187,13 @@ static __always_inline void wbinvd(void)
> >       PVOP_ALT_VCALL0(cpu.wbinvd, "wbinvd", ALT_NOT_XEN);
> >  }
> >
> > +extern noinstr void pv_native_wbnoinvd(void);
> > +
> > +static __always_inline void wbnoinvd(void)
> > +{
> > +     PVOP_ALT_VCALL0(cpu.wbnoinvd, "wbnoinvd", ALT_NOT_XEN);
> > +}
>
> Given this, ...
>
> > diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> > index fec381533555..a66b708d8a1e 100644
> > --- a/arch/x86/kernel/paravirt.c
> > +++ b/arch/x86/kernel/paravirt.c
> > @@ -149,6 +154,7 @@ struct paravirt_patch_template pv_ops =3D {
> >       .cpu.write_cr0          =3D native_write_cr0,
> >       .cpu.write_cr4          =3D native_write_cr4,
> >       .cpu.wbinvd             =3D pv_native_wbinvd,
> > +     .cpu.wbnoinvd           =3D pv_native_wbnoinvd,
> >       .cpu.read_msr           =3D native_read_msr,
> >       .cpu.write_msr          =3D native_write_msr,
> >       .cpu.read_msr_safe      =3D native_read_msr_safe,
>
> this, and ...
>
> > diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> > index d6818c6cafda..a5c76a6f8976 100644
> > --- a/arch/x86/xen/enlighten_pv.c
> > +++ b/arch/x86/xen/enlighten_pv.c
> > @@ -1162,6 +1162,7 @@ static const typeof(pv_ops) xen_cpu_ops __initcon=
st =3D {
> >               .write_cr4 =3D xen_write_cr4,
> >
> >               .wbinvd =3D pv_native_wbinvd,
> > +             .wbnoinvd =3D pv_native_wbnoinvd,
> >
> >               .read_msr =3D xen_read_msr,
> >               .write_msr =3D xen_write_msr,
>
> this, what is the point having a paravirt hook which is wired to
> native_wbnoinvd() in all cases?
>
> That just seems like overhead for overhead sake.

I'm mirroring what's done for WBINVD here, which was changed to a
paravirt hook in 10a099405fdf ("cpuidle, xenpv: Make more PARAVIRT_XXL
noinstr clean") in order to avoid calls out to instrumented code as
described in the commit message in more detail. I believe a hook is
similarly required for WBNOINVD, but please let me know if you
disagree. Thanks!


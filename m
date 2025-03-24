Return-Path: <linux-kernel+bounces-574302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 427A0A6E382
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 20:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1895F3A5C61
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C7919D897;
	Mon, 24 Mar 2025 19:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="hzrlVIqF"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05263199E84
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742844443; cv=none; b=VRhKdUZABWq9Izb2FIpxwP8r7uf73qB1uQdo0/ArVjBehNwYiwJVZw+8D1jsiKBOnCctXOjL1vECB+pITVk1IVuDw1KqVXJK9M8YXnREvXXPpIEYCJuYvc3L5rCCO/AkbfRpCgq9wHFWOrN2diTzm4LK0VmPg3IVtpF1y2kzMWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742844443; c=relaxed/simple;
	bh=tow1bbsuiMKdxwcgM5wqdG0LBLdJEDfAWZYo0p/RsCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJZ8JvvP/GZ1ynKBadkZNsB+0VZAS1B/+Ipr0KT/RmPDMzRgDaerhnPQkv5NXuzGTo2zJgTaIcANDjNo7zU6El19kw1CTcAvaC5L4TdNwg+0ILHKSAABtcdO15EmQi1dZYFRSn1UhxzRDPX3SytfZ76RuMoYcujrsFR9X3FCABQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=hzrlVIqF; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-476a304a8edso42310481cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1742844441; x=1743449241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=risWjFwCypYzMEcsgslZMqIUPKF0hXh9xXq6g1dCnwU=;
        b=hzrlVIqF5lXKCI9UnOheIx2QUoJEvTxg22bRKZZBa+LUBMgnKw+pD4bt4qLCuyssJk
         XV6T0WIwlkOQFa6HFlqpDlXHqYyu1vfwxV5vegnUU+nD2dZh9AJR1xwcoCwU1AIti75W
         VTpsCkZ+fdKar18/9YWbd+I2rZbCCBSR8hqqACZ07U/4ScUoeHEAZ+MP/2um+89n7+yC
         0yTM5MNH4uHWkOi1uvdUmTVb8xpyXD3DPT1vl8eVrr2pTw8b6UOggWB1HWhHCwY7zhqh
         TFB56YDd3f4rdl1xQXCvCCrMzR7h3VZ24+zNHQ1K8mnvig7AHXpQCVb0VhD/wG4ghasA
         /vIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742844441; x=1743449241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=risWjFwCypYzMEcsgslZMqIUPKF0hXh9xXq6g1dCnwU=;
        b=DEbp+X5NZ70+KNkM2M7e47sL0g1V/IGU7pDbY+t5H1ljGde6pQEvqqEl6S5MTdlOVr
         FVu8M32xDLz4NKvPSGmkTKcaUS/8T5pG2NhzzYBx5HaB5dy00WbEigEnMFaFOO+zfITu
         iRDNHCX77c0xFmlC6P2dGkpbwru+eRE+6Fa0eHf5CJlsvvRCZhYIBspW70hIwC4Jv3sH
         cqvlo+BO/5eCRzRkg+Dhq1s7JBZSojBVkhgF3ocPZy7bOdfoNLZiXNQSAcPGvO0+n7eU
         LD0e1ISD2ipm3JpjuLaFI5Yp9q/CryHYqPSGo8zR4USAXGy7XC/+sdu3+VNoFJ7gEV5m
         oSrg==
X-Forwarded-Encrypted: i=1; AJvYcCXoVDw5nTSjcYxevmMPPaCQKHhjW2G/dBkzRM7BqCS1zBCpnYsZ1DYzv+D7Ay4MPPGsr070GKA+/b+3SEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzInhv7xDBPtD7cKgbk81yngydB+ZZkX78MoSkbpBk8LEjr+5FN
	7c8Ecqi8UortcvMT30qorr7+n6AZsYcVrI8N60cwQCk4zn7wM6Y9fO/bmeKhnEWkUSwOYb2UMX/
	SL+gfAw8ZZHSUd4HcHGcbkG2nzxsZXNoeflURPg==
X-Gm-Gg: ASbGncskRxyk+TG12LIliDVuLSp8rbjNH1U6jlh5kKmOvJwf6S/4KKpYUlyd1Zk8o8Z
	GKSPgCKr7eFkUpjnawgS0qOucN8yML8bWMddHichg+DvdYvXzKdH3tZdx5FN1+d9GyoPm47mtt/
	FWcwBFoCvx6lGOCp9pFH3HKNCtRpVoRJPsx/M=
X-Google-Smtp-Source: AGHT+IGstsIg4qTmJ5YmWZYDNChDQ3+AV2nMWCj2a+cFs02lJM90kE8eqj7HIwLM8JIykyDhXLdef0fVOQCXvqByXHY=
X-Received: by 2002:a05:622a:550f:b0:472:bbb:1bab with SMTP id
 d75a77b69052e-4771dd88e91mr196322501cf.24.1742844440714; Mon, 24 Mar 2025
 12:27:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-12-changyuanl@google.com> <CALu+AoS01QJ-H5Vpr378rbx==iRQLG0HajtMCUzDXRO75biCag@mail.gmail.com>
In-Reply-To: <CALu+AoS01QJ-H5Vpr378rbx==iRQLG0HajtMCUzDXRO75biCag@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 24 Mar 2025 15:26:43 -0400
X-Gm-Features: AQ5f1JrjPincvTv7ELB8J7T2hdmnlfkqUUS0uCgm9_GvQ7ohVp8PZ0NaxW7sdEs
Message-ID: <CA+CK2bC4PM0JnHOUm7qfpQ=wUhwsYQ-hJ12tTK_7pSWgYk+bhg@mail.gmail.com>
Subject: Re: [PATCH v5 11/16] kexec: add config option for KHO
To: Dave Young <dyoung@redhat.com>
Cc: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org, graf@amazon.com, 
	akpm@linux-foundation.org, luto@kernel.org, anthony.yznaga@oracle.com, 
	arnd@arndb.de, ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, dave.hansen@linux.intel.com, dwmw2@infradead.org, 
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, 
	krzk@kernel.org, rppt@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	hpa@zytor.com, peterz@infradead.org, ptyadav@amazon.de, robh+dt@kernel.org, 
	robh@kernel.org, saravanak@google.com, skinsburskii@linux.microsoft.com, 
	rostedt@goodmis.org, tglx@linutronix.de, thomas.lendacky@amd.com, 
	usama.arif@bytedance.com, will@kernel.org, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 12:18=E2=80=AFAM Dave Young <dyoung@redhat.com> wro=
te:
>
> On Thu, 20 Mar 2025 at 23:05, Changyuan Lyu <changyuanl@google.com> wrote=
:
> >
> > From: Alexander Graf <graf@amazon.com>
> >
> > We have all generic code in place now to support Kexec with KHO. This
> > patch adds a config option that depends on architecture support to
> > enable KHO support.
> >
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Co-developed-by: Changyuan Lyu <changyuanl@google.com>
> > Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> > ---
> >  kernel/Kconfig.kexec | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> > index 4d111f871951..57db99e758a8 100644
> > --- a/kernel/Kconfig.kexec
> > +++ b/kernel/Kconfig.kexec
> > @@ -95,6 +95,21 @@ config KEXEC_JUMP
> >           Jump between original kernel and kexeced kernel and invoke
> >           code in physical address mode via KEXEC
> >
> > +config KEXEC_HANDOVER
> > +       bool "kexec handover"
> > +       depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_=
FILE
> > +       select MEMBLOCK_KHO_SCRATCH
> > +       select KEXEC_FILE
> > +       select DEBUG_FS
> > +       select LIBFDT
> > +       select CMA
> > +       select XXHASH
> > +       help
> > +         Allow kexec to hand over state across kernels by generating a=
nd
> > +         passing additional metadata to the target kernel. This is use=
ful
> > +         to keep data or state alive across the kexec. For this to wor=
k,
> > +         both source and target kernels need to have this option enabl=
ed.
> > +
>
> Have you tested kdump?  In my mind there are two issues,  one is with
> CMA enabled, it could cause kdump crashkernel memory reservation
> failures more often due to the fragmented low memory.  Secondly,  in

As I understand cma low memory scratch reservation is needed only to
support some legacy pci devices that cannot use the full 64-bit space.
If so, I am not sure if KHO needs to be supported on machines with
such devices. However, even if we keep it, it should really be small,
so I would not expect that to be a problem for crash kernel memory
reservation.

> kdump kernel dump the crazy scratch memory in vmcore is not very
> meaningful.  Otherwise I suspect this is not tested under kdump.  If
> so please disable this option for kdump.

The scratch memory will appear as regular CMA in the vmcore. The crash
kernel can be kexec loaded only from userland, long after the scratch
memory is converted to CMA.

Pasha


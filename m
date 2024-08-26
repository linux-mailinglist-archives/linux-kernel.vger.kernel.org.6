Return-Path: <linux-kernel+bounces-302080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871CA95F994
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C743284186
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159F2199229;
	Mon, 26 Aug 2024 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2PAnyuI8"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D5D1990C1
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 19:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724700154; cv=none; b=XcixbMXnMJy7n2XeYwm6udo8/7VCS4qlcW7V2S4uobSPTJNsCdTodVPVxpwDSJqB/8ByE2tXHDj7T60VdOv8jH9Y/wzLIBO7G37KgWIRYtILNciSNdeHymOC36KWSUVxtYB/88pjNEynAqt8/ipHqBAF2HzBGQEkvoE41IzjxW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724700154; c=relaxed/simple;
	bh=d0Tbcicfw12lu66Hi+IWpf31ATCDbXiJ5b/jIGBwUFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0ILAJFPbX/4IrWjmtkxTaK2GHYFHNhIpwShAvmQZF8pZyZMQDriPUSHBR4CLNRv76d/6mm235R0XwGdOot0+vxphh22NQo1JXWgxP5i2OPi+TwREEKHkLy3g9ejVRM4M3mGuXRH4I0ZqG8pfO+mz4Ya3T3iHFi0TES3A9TAbOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2PAnyuI8; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44fee2bfd28so3881cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724700151; x=1725304951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wNdOTO9/+NVQXsVxQX97atR2OiG6XZKQOu9cHgk5Ak=;
        b=2PAnyuI86bi/+05fDsu1aqo27QKZFEKrv53uVlYnUi5KRsVigSukOfA2PHi3q6TyU+
         OD1+Y4Vxa7PIuAA9ENm52h+c2o2CPhaOERfn9pxIVSMfemFZRnInEyapnxuho8xkNNVk
         C4xhsj7G4FGtKnfDJX+tJo5HMILd3V+6Obk2C/EqsI6ovv83pwokqY4d5peGDJRxiNMQ
         mFNfJWlx9M4UWlGTG2GPENg/hXfQhI/cZhmqfygO8s+nS1HCwv/ujwzxqqJ8cPr0+kFB
         BxboZzjUQpRb3fLY71ORsPA1eYxFvkzoO5uAwhYwnsB9xPoltZ5lIfV9ZzfiQxLVKxes
         4sIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724700151; x=1725304951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wNdOTO9/+NVQXsVxQX97atR2OiG6XZKQOu9cHgk5Ak=;
        b=vAwCqJ1ZgXZ/OeBh/BHcDN5kceR2YweQgEfOBvu33XoO+3T7DEQxme0Gn9bptEh0HQ
         ga69pHKvHP3cb4Kz8aFW4TsgKyRSYLsduMI8l2PonPPGOytows9bCdxjAE4RB8G5x7s7
         M1hqYwBrSRr4Bbo7APUBMuLhrBaQTLU7Q5+LuQyzrIOhMLXw/dZht79dmfFBZ3sgPi+I
         Y7lA8vIiPdHN5fLxFAJypyeX/ux1ceNsvjGxb68mwNgEjmxuTrHeq+8MoOVBf3hLK8eK
         ToZEWbEVUyUU9J3Eb9R4RZ7zDVCyvy+ZKDdwVGk6NUiZNh0glEissqCgGK/Z9js5SssO
         3IzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJmHT+F7R6iFnZj1NQPR9dSETtF2zz2ZWssXcn8EM+v79bagoz/ME1rZMkXzgTOKq/5zOgYSj7ToLch2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9jMLvCw0ZC5gvdd5xRf1da8lMKMfs44j/HWtZoQh1TdMHkd7p
	O0x5YR1d1OvxWb6bJrwEJz3aFYSojqQBSJv31EMumw7zGJwV9ssAtCXpPRmMf9zWrtSNW8lwaGt
	Bn9XM95eBwOKbZMg6ptlCP38m1i8NPeHdPoLCDQK6LBzx1WmnjzIhlUZfrg==
X-Google-Smtp-Source: AGHT+IEHqcP2Os4407lfkc/Wjcnfd6ETwj9VLhWZxgpLrRyuMSjkmCPlgErqZFSvLa3suF/+Lf0SJQRZTnMov6Fl8LI=
X-Received: by 2002:a05:622a:4b16:b0:447:e728:d9b with SMTP id
 d75a77b69052e-45661a3283emr527261cf.26.1724700151136; Mon, 26 Aug 2024
 12:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723723470.git.kai.huang@intel.com> <20240819212156.166703-1-sagis@google.com>
 <29fba60b-b024-417c-86e2-d76a23aa4d6c@intel.com> <CAAhR5DEEsFNqdxbd62tGh9Cj7ZQMQs6fEjAKs6djkZzgZALOfw@mail.gmail.com>
 <f4b60d0e-bec7-45d0-bbdf-fb04362c863a@intel.com> <CAAhR5DFrOaXDbndFOSWAfdu-79buSR2ki_AU=z68FcHmn9o4Ow@mail.gmail.com>
 <47dbc3b5dd6bd7cc3fa94ffe770e22419daf1d01.camel@intel.com>
In-Reply-To: <47dbc3b5dd6bd7cc3fa94ffe770e22419daf1d01.camel@intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Mon, 26 Aug 2024 14:22:20 -0500
Message-ID: <CAAhR5DGKNG=RiRyLj1r=xsueUBpyPXOhbhxg72UQTZRXcyyuzw@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] TDX host: kexec() support
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "Hansen, Dave" <dave.hansen@intel.com>, "luto@kernel.org" <luto@kernel.org>, 
	"bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, 
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"seanjc@google.com" <seanjc@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2024 at 4:31=E2=80=AFAM Huang, Kai <kai.huang@intel.com> wr=
ote:
>
> On Fri, 2024-08-23 at 11:15 -0500, Sagi Shahar wrote:
> > On Mon, Aug 19, 2024 at 5:44=E2=80=AFPM Huang, Kai <kai.huang@intel.com=
> wrote:
> > >
> > >
> > >
> > > On 20/08/2024 10:28 am, Sagi Shahar wrote:
> > > > On Mon, Aug 19, 2024 at 5:16=E2=80=AFPM Huang, Kai <kai.huang@intel=
.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 20/08/2024 9:21 am, Sagi Shahar wrote:
> > > > > > > Currently kexec() support and TDX host are muturally exclusiv=
e in the
> > > > > > > Kconfig.  This series adds the TDX host kexec support so that=
 they can
> > > > > > > work together and can be enabled at the same time in the Kcon=
fig.
> > > > > >
> > > > > > I tried testing the kexec functionality and noticed that the TD=
X module
> > > > > > fails initialization on the second kernel so you can't actually=
 kexec
> > > > > > between 2 kernels that enable TDX. Is that the expected behavio=
r? Are
> > > > > > there future patches to enable that functionality?
> > > > > >
> > > > >
> > > > > Thanks for testing!
> > > > >
> > > > > Yes this is the expected behaviour.  If the first kernel has enab=
led
> > > > > TDX, then the second kernel will fail to init TDX.  The reason th=
e first
> > > > > SEAMCALL to initialize TDX module in the second kernel will fail =
due to
> > > > > module having been initialized.
> > > > >
> > > > > However if the first kernel has not enabled TDX, the second kerne=
l is
> > > > > able to enable it.
> > > >
> > > > Are there any plans to support both kernels being able to enable TD=
X
> > > > in the future? Either by changes to KVM or the TDX module?
> > >
> > > AFAICT we haven't received such requirement so far.  Let me double ch=
eck
> > > internally and get back here.
> > >
> > > Btw, if we want to do this purely from software, changing KVM isn't t=
he
> > > right thing to do.  We need to somehow pass key data structures manag=
ing
> > > TDX module to the second kernel, e.g., module status, locations of
> > > PAMTs.  And the second kernel needs to be modified to understand thos=
e,
> > > which means some old (second) kernels with TDX support may not be abl=
e
> > > to support this even if we add this to the kernel.
> >
> > Would it be possible to tear down the tdx module and re-initialize it
> > on the next kernel? I don't think there's a requirement for the tdx
> > module data structures to remain intact during kexec but it could be
> > useful if tdx can be enabled on the new kernel.
>
> We discussed this internally.  The TDX module cannot be re-initialized af=
ter
> torn down.  However the new kernel can reload the (same) TDX module and r=
e-
> initialize it (the P-SEAMLDR supports reload or runtime update TDX module=
).
>
> However our primary focus is to enable baseline TDX support in upstream. =
 For
> TDX host kexec, at this stage we focus on: 1) enable both TDX and Kexec i=
n the
> Kconfig; 2) allow normal kexec and kdump to work when TDX is enabled.  Ma=
king
> the second kernel be able to use TDX is next-step plan.
>
> May I ask is there any real use case that requires the second kernel to b=
e
> able to use TDX at this stage?

[Again in plaintext]

Right now I don't think we have production requirements for kexec at
all besides kdump support. Kexec from TDX enabled kernel to a non-TDX
kernel definitely doesn't have a production requirement.

It would be nice to be able to kexec to a TDX enabled kernel to speed
up the development cycle instead of waiting for a full reboot but
that's not a high priority at the moment.


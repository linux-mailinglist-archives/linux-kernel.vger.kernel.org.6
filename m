Return-Path: <linux-kernel+bounces-537187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE57DA488FD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799A23A4DB2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1404726E95E;
	Thu, 27 Feb 2025 19:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2TxopmCH"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976E526E957
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684429; cv=none; b=Rsf0TMz4afM1UjhwcxaRL52COAqu/fFRe0k1eyBSVTw5ZsvtZWtIbX6PDRsKyb/gq6I02PdvRPWISn7ZpRAY35dEeW3bYbj0XB3HjiN45gUMQ+lRBfpzXBA8lAr6z9Uwhh47bbFUCEXOlTPkGZJJ1hCPEcbTmaCMsoPWVtqNBrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684429; c=relaxed/simple;
	bh=d1Qxg472CkVrkJspIto61QqE2XsIjtKw5J3xPkJikcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+6IeuJSUqAKHo8Vq1yYrQLHS+m09rxzSC6+U1ESKjn/IkdcuuByaIAajedWjbPdqy4r2NtdkCcs3XLyY7bUHwC2Q0rsTdK88pq/UbvvI2uuirr7Pt6aswxYqdZSgNypaQSpehR/cFH+ETDlJP5md0lXbllVhXlCeqFsbmrLxMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2TxopmCH; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54843052b67so1286e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740684426; x=1741289226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtLSNJVT+92AMNNdy2v/ceT4EU9CKE0f6wRbNLrZ7oU=;
        b=2TxopmCHJ9v8GWtr7FbdgnCMwGCilGeXlaG2avMM5+IrJNSNvvm8qp3GPFvmuxHPgO
         3/5I9UwOcaZdAj3dk0Uf3zb/+Ic8uWgzcNlgFhC1VOSP3VIrAUg1iKv/FJCoGwu9EcNY
         Mx/4Rrho733WrpUPTjlyv1Quuiz5VnLvLDxH12MEWOmbP6+qVRmKU6X2ejaqm1ipsQ1c
         3FXOQAUB0Each3LKu+MIxxicGkug6g4D98UQsVowTq9LzUXuGzw/0SxwC+AQVRtGM9oH
         4lnA0Q5SbXQc8OF/fFq+PJSOemiixhP8UbbrlD5WpHQA4BQM31ZErsHW2HCdmpXWxnjm
         xFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740684426; x=1741289226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtLSNJVT+92AMNNdy2v/ceT4EU9CKE0f6wRbNLrZ7oU=;
        b=E4zHdb0eoFkY+euEc3Vy3Lf+zq1HuujKVZ7magUHdgMpVDaNTJq8tye0QCpt1K3Izo
         lNAkqM2aQmluzAKcj6IuXbaC9uXXnjvTtj9NTrHTu42c4bORspVIUGEKa5LuLFSzZyiC
         5DumjOt7mb3wav/DIU/2xEtUyCu+szH1xQfKDpEgWIKFcHaUa+x+ERHX78MQvN8Q1XqO
         kEcBwbql8E4KeqPN0EczbYChqtZRGEnDrFyqVNo1/+nSN81HDOp4AW7PtGZjca+uJjQq
         Flz4d5qiujCB4sA5kefSb80fxsQ4xFvlLosdQCGNCf3S5ZLgc/B7OAqsKiO/O+42LWiP
         0TGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyTmMrOMJZnmvAp5p3lfcrJK0lpc0mNWpPVRtnYP1f+weF0+CPW29tv2Ag/zvhykaRMy+6EAtXBDGTjJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxotKy6B7xlw4mMfXxDSTbQOMgprOcVwEvXddyasC08PBrw4kc3
	kSj47SqJWSoTlFkbCpblVlbQbeO9tn3TR3tkMS6cuTOu9sT8S0Uqmpc+i0qLNfEuxUJoADOXP+7
	hVGMZdLlJGyF9nTAmBiGaqbU5RRRDO0HTuxTz
X-Gm-Gg: ASbGncugFCX3nea4Rje1RKaIEGuvCfYUa4qFD/8FPLzbSXMk/n1PF44w9ld1esnsuK6
	pHcE0L31DcjVB2wbAH4zZ4ArFCxi2HjSkxNHlY9WQz2I7o4gDwnQTBCAx/3MNgS8rVEz6rVUlr9
	sPe2nen+f283KLeBU2ryq8SDK+ApqThDboSMT36N2V
X-Google-Smtp-Source: AGHT+IEdSIwybUjSkkV5vNkBMcDTqOmFlDjP0ogUFLrcyG7hy/eEgdi+TbKAXYt1FUTQRVem2blej27QUoMzQ6ig7ik=
X-Received: by 2002:a05:6512:3a84:b0:543:cf0c:ed14 with SMTP id
 2adb3069b0e04-5494debd8fdmr16005e87.5.1740684425486; Thu, 27 Feb 2025
 11:27:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225004704.603652-1-vannapurve@google.com>
 <20250225004704.603652-3-vannapurve@google.com> <pvbwlmkknw7cwln4onmi5mujpykyaxisb73khlriq7pzqhgno2@nvu3cbchp4am>
In-Reply-To: <pvbwlmkknw7cwln4onmi5mujpykyaxisb73khlriq7pzqhgno2@nvu3cbchp4am>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 27 Feb 2025 11:26:53 -0800
X-Gm-Features: AQ5f1JpNkvOxWDJlk_d64tma-tOWc1scSvqjWSXHu6nUjd70ID7CCmOSArfFMN8
Message-ID: <CAGtprH8mxENaH-Y0=b0kKJio=EG0OKt_qeguRBJECagXL4poPA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] x86/tdx: Fix arch_safe_halt() execution for TDX VMs
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: dave.hansen@linux.intel.com, kirill.shutemov@linux.intel.com, 
	jgross@suse.com, ajay.kaher@broadcom.com, ak@linux.intel.com, 
	tony.luck@intel.com, thomas.lendacky@amd.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, pbonzini@redhat.com, 
	seanjc@google.com, kai.huang@intel.com, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	erdemaktas@google.com, ackerleytng@google.com, jxgao@google.com, 
	sagis@google.com, afranji@google.com, kees@kernel.org, jikos@kernel.org, 
	peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, virtualization@lists.linux.dev, 
	bcm-kernel-feedback-list@broadcom.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 3:49=E2=80=AFAM Kirill A. Shutemov <kirill@shutemov=
.name> wrote:
>
> On Tue, Feb 25, 2025 at 12:47:03AM +0000, Vishal Annapurve wrote:
> > Direct HLT instruction execution causes #VEs for TDX VMs which is route=
d
> > to hypervisor via TDCALL. If HLT is executed in STI-shadow, resulting #=
VE
> > handler will enable interrupts before TDCALL is routed to hypervisor
> > leading to missed wakeup events.
> >
> > Current TDX spec doesn't expose interruptibility state information to
> > allow #VE handler to selectively enable interrupts. To bypass this
> > issue, TDX VMs need to replace "sti;hlt" execution with direct TDCALL
> > followed by explicit interrupt flag update.
> >
> > Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
> > prevented the idle routines from executing HLT instruction in STI-shado=
w.
> > But it missed the paravirt routine which can be reached like this as an
> > example:
> >         acpi_safe_halt() =3D>
> >         raw_safe_halt()  =3D>
> >         arch_safe_halt() =3D>
> >         irq.safe_halt()  =3D>
> >         pv_native_safe_halt()
>
> I would rather use paravirt spinlock example. It is less controversial.
> I still see no point in ACPI cpuidle be a thing in TDX guests.
>

I will modify the description to include a paravirt spinlock example.

> >
> > To reliably handle arch_safe_halt() for TDX VMs, introduce explicit
> > dependency on CONFIG_PARAVIRT and override paravirt halt()/safe_halt()
> > routines with TDX-safe versions that execute direct TDCALL and needed
> > interrupt flag updates. Executing direct TDCALL brings in additional
> > benefit of avoiding HLT related #VEs altogether.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
> > Signed-off-by: Vishal Annapurve <vannapurve@google.com>
>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov


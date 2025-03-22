Return-Path: <linux-kernel+bounces-572128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49973A6C6D5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 02:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A633B88AC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 01:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199A11BDCF;
	Sat, 22 Mar 2025 01:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ksBD1ukS"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235951C695
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 01:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742605701; cv=none; b=J7WGKEd1kHGC3isbWoTdO4W7gOiOo3FqgghCJsoVfZS4VjQH0y84wLbaMBN5FP02HaM50Jx6xBsiL18IriNu5RtRc4UIfuo8vtRHCz7ZL3D2AMoUk1LwmV/yqcu7FlvMup7wZvHJa+I86PAOcCwyFNSt0efplbgKsO1Cr/+l8sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742605701; c=relaxed/simple;
	bh=UlCEukpy828X+t+n7YKj+Gp5G6r5hcYtbALRFRMl084=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=peaE/PzzF5smib35Z7Nk4GFHbdwS7moxYy5RgqONqKFx7NaDh89VC5e03v1Ufk6rL+NANE+J7e1Z5JC8aE4I0vfmlSOHXNbtk9Hv2RtA1cjZGHOe4CaNJcllxEoWWXDSBbJl8Li8speHqqy6bNdROSJEmPyFWZJEht69OKz8baM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ksBD1ukS; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2264c9d0295so87895ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 18:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742605699; x=1743210499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PORJkvOxkuHko+fxCJKgIIFheR3by/P8aDDODWCERsg=;
        b=ksBD1ukSjSEb+r8Vk7lgryrmWJtd2YMrsCF1FeFC+FE0vB3nLO4v9ZWLSTdntvFS7A
         DUiYiEkoyQXzsYGkhr7O4rvHm/BHXOCPTxsuUhTDGOqvLrxWbXf9UToFVgFE4fZ6sKiE
         OizvW4/zG6g9N7Xd2qVmye6pzX7h3h+E8o5yKX5mPgrSIV7cIlg4APbc07x1bmQSdlnY
         OK9p692wSjG59aEi08xFNOGmkdc7MO8m2C7xwQm0o4h57ORonvXqr3G4B+mhhgKhe+li
         7yetnIawuHG5M3ajaJKX9MDw1Kw4L0lTr6PMv+m5qQijpdoC2JQWmn/MFVgxx6+XY0z4
         8i/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742605699; x=1743210499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PORJkvOxkuHko+fxCJKgIIFheR3by/P8aDDODWCERsg=;
        b=dDpknhPmoE0UIOwZoQssWn4qwOA2Ljdj15XtYap4BN39arNXNU//FZZo1oIQsbRp5V
         yIOEf4dZa0zJ4KPlguRMcPEDm1B/0YRVW5OmZNmVQXnHElClo3/tInW9ecVklWSJQj/O
         Q5D79yrM7h9GAt2/cnpiiH+Zpc/2wOfGmHGpW42JbC0QAN3esQundmhn2TTvYWjCVcKq
         JcAFZZo9IhrGc/0WrFz8l/9GWBFbuaokGdyr+m4rzw7q5M0weUwrU7vktIni92PP1eUU
         FuWfYOnPUZZIZn7HHU44ScrS8/oLwsQfpfeNnJ9OT80tPtib5RhhT1K5TxWS7jCzFQ3S
         V14A==
X-Forwarded-Encrypted: i=1; AJvYcCV9bhvi+jB4zRCzsl5nitOEpyLRnqAPddgL5ButAgHnWi0oI14PZJO7B75msSoK9toAhMJI6J5K40GZNJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfhgHxIXb+kZJM2f54/QGp3k+hxjqn7ZGwHNme7yQOW0fdBljN
	nCNQAhSapZiSOdhZC63U9IBlTJiBDcr+kdT/CcmLoM3wI4ko7+qumowZnVjNKAVFllwxg3GJxrJ
	VMZ7Z/8UfT6j5vkJg1D6FZM2Vqc/mnfr4186M
X-Gm-Gg: ASbGncvElSyK78F2AS2X5dRJAbbRXZFzXQA3kPbqwpZwje0K6HyCrX/VVcreBmADLEu
	DH4egWpH4EpWq6uFS1nd0zgY/fPWLT1m64LrdeCzJRbC/pM4/9jVmMGPu3sEauZy9RBSEryJ72G
	f+4sxla0Yg6FMRI5mePLbWICuIss2Pvm/VN1vH4tHkpbnV2shcP86puMVRqTOXYUdS8GM=
X-Google-Smtp-Source: AGHT+IHwBjcoBQJD7PgR24WQYCLIQsyJ/8mCgJRTKFIdiYFR1Yc44CsmaI9H6JC3a7kMd6MKs5kEznfjIsb/OAkQoIg=
X-Received: by 2002:a17:902:e742:b0:215:79b5:aa7e with SMTP id
 d9443c01a7336-22799f46955mr693655ad.13.1742605698803; Fri, 21 Mar 2025
 18:08:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228014416.3925664-1-vannapurve@google.com>
In-Reply-To: <20250228014416.3925664-1-vannapurve@google.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 21 Mar 2025 18:08:06 -0700
X-Gm-Features: AQ5f1JoTxkcQ6rnzBlVlnNhEnnZwVceT5ZUnX3gSJIePazDtJUJ8CyOxsH4dLZY
Message-ID: <CAGtprH-8oJ66nunFHvZu_KcHjDM3=nTn1g46dSUOHMaOwo5HrA@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] x86/tdx: Fix HLT logic execution for TDX VMs
To: dave.hansen@linux.intel.com, kirill.shutemov@linux.intel.com, 
	jgross@suse.com, ajay.kaher@broadcom.com, ak@linux.intel.com, 
	tony.luck@intel.com, thomas.lendacky@amd.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, 
	pbonzini@redhat.com, seanjc@google.com, kai.huang@intel.com, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, 
	afranji@google.com, kees@kernel.org, jikos@kernel.org, peterz@infradead.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev, bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 5:44=E2=80=AFPM Vishal Annapurve <vannapurve@google=
.com> wrote:
>
> Direct HLT instruction execution causes #VEs for TDX VMs which is routed
> to hypervisor via TDCALL. safe_halt() routines execute HLT in STI-shadow
> so IRQs need to remain disabled until the TDCALL to ensure that pending
> IRQs are correctly treated as wake events. As per current TDX spec, HLT
> #VE handler doesn't have access to interruptibility state to selectively
> enable interrupts, it ends up enabling interrupts during #VE handling
> before the TDCALL is executed.
>
> Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
> effectively solved this issue for idle routines by defining TDX specific
> idle routine which directly invokes TDCALL while keeping interrupts
> disabled, but missed handling arch_safe_halt(). This series intends to fi=
x
> arch_safe_halt() execution for TDX VMs.
>
> Changes introduced by the series include:
> - Move *halt() variants outside CONFIG_PARAVIRT_XXL and under
>   CONFIG_PARAVIRT [1].
> - Add explicit dependency on CONFIG_PARAVIRT for TDX VMs.
> - Route "sti; hlt" sequences via tdx_safe_halt() for reliability.
> - Route "hlt" sequences via tdx_halt() to avoid unnecessary #VEs.
> - Warn and fail emulation if HLT #VE emulation executes with interrupts
>   enabled.
>
> Changes since v6:
> 1) Addressed Kirills's comments.
> 2) Fixed a build failure.
>
> v6: https://lore.kernel.org/lkml/20250225004704.603652-1-vannapurve@googl=
e.com/
>
> Kirill A. Shutemov (1):
>   x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT
>
> Vishal Annapurve (2):
>   x86/tdx: Fix arch_safe_halt() execution for TDX VMs
>   x86/tdx: Emit warning if IRQs are enabled during HLT #VE handling
>
>  arch/x86/Kconfig                      |  1 +
>  arch/x86/coco/tdx/tdx.c               | 34 ++++++++++++++++++++++-
>  arch/x86/include/asm/irqflags.h       | 40 +++++++++++++++------------
>  arch/x86/include/asm/paravirt.h       | 20 +++++++-------
>  arch/x86/include/asm/paravirt_types.h |  3 +-
>  arch/x86/include/asm/tdx.h            |  4 +--
>  arch/x86/kernel/paravirt.c            | 14 ++++++----
>  arch/x86/kernel/process.c             |  2 +-
>  8 files changed, 78 insertions(+), 40 deletions(-)
>
> --
> 2.48.1.711.g2feabab25a-goog
>

Just a ping for review of this series if anything more needs to be discusse=
d.


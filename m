Return-Path: <linux-kernel+bounces-170163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C57E98BD2B6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8132A28701E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6FA156C66;
	Mon,  6 May 2024 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qViKs9Wd"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D890156232
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715012663; cv=none; b=ray/YV5zox5bA1DIEF6aYEI+sLtZrPUFGsb9Uoxc0uPVEWEGoYTjgUzarpcxQZ81ooYEQ/TnsObS4oYK8J9n0bBZNWEBSLQ9U89OohS+0RcGNEtrLjSYM2eYzy8zJ9oAWTooT+aGuFNGlgnhbdwMJdJrSvUSRwsqeP32GtiRJ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715012663; c=relaxed/simple;
	bh=1umspOg6P+YBt+kF0yVj2x9Zp4XiH8wmBDIrxcQqV7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkR+DlV43UxTH7W14mon43IS0Jl3UivMYPkRvv41bQO1yJnQtTlUM5PTjbY9Di4yb45iaoSv0naAXGExxOwbWiPmH79XvqrhzIx9qGHYGyDqefJV/vIaDqK8vtVb8YS+ahfR/Nf4++n0SON2l9PY6qvSDifImtGWA4jVAFsZSsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qViKs9Wd; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso11863a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 09:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715012660; x=1715617460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0dZxDAccYcCY4EmOhr7flN+YOjsFHzjNLPRNOnfYa0=;
        b=qViKs9Wd+c7g78kKgq8EMMvh7MvtZ4OmxCKyh2SRwzBLBVTlF/7O8ruQn+x3Wqtm12
         I59mrENk1veQ95lmFFoPEFTTRmkiCuB22DTFWAdcijIf5wXsM2+5RttZpXsesjqeNyZh
         q5kU8j5gIAqH21CbwNrsvOUbq1u0h92GlzZiDMv3RfQrLMOyCfcbWxjAPaT/ahhZMvPj
         AWAnWfqBtT1r0HhzQzDhFTcAU/abk0Gg+49X5PsXRnyh7OrZTpL1s5E+LoiB6FBKWBtG
         C3WJec2At8RrKn8/OFZoDabKf12tyb/YjOKblzFgRhL3FM6lLsSTP+D2XsJpNWniJP4n
         JXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715012660; x=1715617460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0dZxDAccYcCY4EmOhr7flN+YOjsFHzjNLPRNOnfYa0=;
        b=jVqniPVVi93zBUIPY5K/RzC7DqKJnDDjpWgxi3pAFj04anBGUz0HgCJiFL/sxUwMWt
         MdQj2i7I6m7+XgHhApg2c99XTYNaYadLaspmlm0myoSj860Big6/qmw9vCOj8F96LuoO
         HGmnD8y+wyuWZJw9NHrMiKmxATDdGQEn+YVQj8fP8ydrEsyv9LZ14ViwyPWQlcECEx9v
         XoA0Tvn4zGkEanvn/+Zpxip3IEQ3IBIqPmACjaLlZ97WAk/6T1FSRv+6QLCUek+wyoXs
         MCqOIDeEkAEd29nvMUmbQmsJ82qrLT5Y6VXX6g0f2cPz+bPStBB+43QASbENJ+leDS8N
         TK2A==
X-Forwarded-Encrypted: i=1; AJvYcCU3p6uZx8x8Wse67+C3Qgv+w8y/OJrkbLIZ4S4UltPJjldm2s+B5IYB+pPmmgyoJvOkJEc9Dl2BCOMKMJPCO4LgvTGb7HOw1R1g2mhQ
X-Gm-Message-State: AOJu0YyinnP7R2fdr5O+6DNnVIrFIXB7y+2STsaoR5IMR+vlkZq3dWyN
	WUjdDlKoSOPP8P4Ih6paxCN3Hefc7TplvE4TvzPPy0Vkhe1PWGXdTEadV17DpYvRELeit7ydpzr
	Svvd1GO3mGbW6lQcc3DpJBqVxUugYwnm8EOpr
X-Google-Smtp-Source: AGHT+IFfKJPpR85/urooKgDXyAvRKv1p8Ab+gb4qgrqhtuI42OCDChtqOgl7yd9hwmAY+uLAF+ntmjZvvrebUqjOnAQ=
X-Received: by 2002:aa7:d44f:0:b0:572:e6fb:ab07 with SMTP id
 4fb4d7f45d1cf-572e6fbac14mr225538a12.7.1715012653454; Mon, 06 May 2024
 09:24:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429060643.211-1-ravi.bangoria@amd.com> <20240429060643.211-3-ravi.bangoria@amd.com>
In-Reply-To: <20240429060643.211-3-ravi.bangoria@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 6 May 2024 09:24:00 -0700
Message-ID: <CALMp9eQzbNVJpuxp1orNswnyfKy=aFSPYFRnd3H7fbi0+NfDvw@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86/bus_lock: Add support for AMD
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, seanjc@google.com, pbonzini@redhat.com, 
	thomas.lendacky@amd.com, hpa@zytor.com, rmk+kernel@armlinux.org.uk, 
	peterz@infradead.org, james.morse@arm.com, lukas.bulwahn@gmail.com, 
	arjan@linux.intel.com, j.granados@samsung.com, sibs@chinatelecom.cn, 
	nik.borisov@suse.com, michael.roth@amd.com, nikunj.dadhania@amd.com, 
	babu.moger@amd.com, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, santosh.shukla@amd.com, ananth.narayan@amd.com, 
	sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 28, 2024 at 11:08=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.c=
om> wrote:
>
> Upcoming AMD uarch will support Bus Lock Detect (called Bus Lock Trap
> in AMD docs). Add support for the same in Linux. Bus Lock Detect is
> enumerated with cpuid CPUID Fn0000_0007_ECX_x0 bit [24 / BUSLOCKTRAP].
> It can be enabled through MSR_IA32_DEBUGCTLMSR. When enabled, hardware
> clears DR6[11] and raises a #DB exception on occurrence of Bus Lock if
> CPL > 0. More detail about the feature can be found in AMD APM[1].
>
> [1]: AMD64 Architecture Programmer's Manual Pub. 40332, Rev. 4.07 - June
>      2023, Vol 2, 13.1.3.6 Bus Lock Trap
>      https://bugzilla.kernel.org/attachment.cgi?id=3D304653

Is there any chance of getting something similar to Intel's "VMM
bus-lock detection," which causes a trap-style VM-exit on a bus lock
event?


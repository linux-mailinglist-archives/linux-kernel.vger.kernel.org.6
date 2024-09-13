Return-Path: <linux-kernel+bounces-328663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93A797870B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78FDB28C5B6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9306C84D29;
	Fri, 13 Sep 2024 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lo51zDP3"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3799F1C2BF
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 17:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249349; cv=none; b=oD1Et+iU+MQTxuV0ywqpYh3DXb7KDSWAg2vjtqMjrWNwKTqXnxm5GUiKSurmRipMrfJ+072NmjbD+NBtANfg8cIeXq3vNOqaWtClRLLEOSQuVH9NdLVkmL0TP770l/NUASJIHl03+ZqP8zHGLYHWoS35Uuvxo+4vAb96z3I8Q0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249349; c=relaxed/simple;
	bh=173AQeyMDaJ45QZOQirS7+SDcWgIwJyD7RHQE/oNyVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RT2sVoqZX8laVi9Qcc9dUjfWMoODJZ0TJ2NdRQt4oJBU7orN7DCb1XJe/VLy5nvJ/iz+M9q46bW61ao379CrIkQAyuauGB66g6kiVv7md3a2NYVe3tqzUa9w6oG4/XAF+dRaogJC4itgH2pNM7f/T50CkLzYG67YV7qRxScEMhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lo51zDP3; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-39d3ad05f8eso11695ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 10:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726249345; x=1726854145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8W5LH9MX3hMkElj2Z0bxV+YjhV0sKkJFY50QdMlkH6A=;
        b=Lo51zDP3IUE12e+3hFs0NO/gHeNnl7/YLpzALvCUZAUOqJKXXK4bfwtVWVp7uP3vtD
         FJa0qOaIeRsdEa/qUA/QMbER1sHx/VmwODFjfa99De2b+CVosLnWoLqEjdK1BSojmnr8
         7XNzqdhv7sbQEd6d9VxXZgoYJsmrwHRJ8uUhVMobbf2Zw4K6e0Ojtrax/+RLra6n6Osl
         qLvk4cu0OJ+v5reI5smhmPT2Pgzjkf34iV/a4PBdbYfp0pp27p2NhSZ/tC/fIaae2YXe
         yBHu1mHXZhX8+Ofq+6UfvyyJin0aeTwsIUh1rUZEYcNGgV1tIdO9Z6er3mT779BgUKa8
         vN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726249345; x=1726854145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8W5LH9MX3hMkElj2Z0bxV+YjhV0sKkJFY50QdMlkH6A=;
        b=VdNapqnn+AT85MvEaSnx7F7N0/k2OP3Ds5FZ4pdXBB5ENWVuRumevvC0DuQqa+N51n
         T+AvDlyOIFRSKv44kGhZjqyT+JLKYZ9kWR5oDepKzM2ZzlPGHYVSTT0tTYPW2FbKSFkA
         T9Kpaot6m+gQei4BeHXyF7Fs92jlNB7rOi2P/mdJ+fkD/LfIdkYBRNyhPiDL0/3XwgDU
         Jxwr98Y9hJG5+tWQbAtqHHTk0jIxYH3ArbX3Ll0E3BNjrBYYbbIh0kEmRiMxyLwovLXW
         cWlpof+1y+1Tciq8T9Jg3oXzEqw7aYg+U8yKx/Cp6jsIwnkH7f8es3EpzdZePSk2QfOg
         tuNA==
X-Gm-Message-State: AOJu0YzLdjy3ICbgPeVBxD8Ekm9RMpHsu/xgpJl5C1u5H7xKNGXX1unF
	FNBKgPxUxd4/sODp5knZqvdqM3QpYEK3tuKQlVatWQkPqQyX7JBpba5dfiQ5SuRN6sqzhe1AvUU
	ZEvwcXrtzTZnc0IP5gkSzHVs77gR6lz/0SY/b
X-Google-Smtp-Source: AGHT+IEAfzEpcAH80+98bRbDt00y7w7gSufYRSYoHgdXgSwFe329MnxAcBG0lIP7pS5hRLNyP4mhgzWnfrVP3m8JQig=
X-Received: by 2002:a05:6e02:1aab:b0:3a0:439b:f610 with SMTP id
 e9e14a558f8ab-3a0856cfd7fmr10007445ab.15.1726249345097; Fri, 13 Sep 2024
 10:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731150811.156771-1-nikunj@amd.com> <20240731150811.156771-21-nikunj@amd.com>
In-Reply-To: <20240731150811.156771-21-nikunj@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 13 Sep 2024 10:42:13 -0700
Message-ID: <CALMp9eRZtg126iSZ4zzH_SjEz2V+-FRJfkw7=fLxSoVL1NTp_g@mail.gmail.com>
Subject: Re: [PATCH v11 20/20] x86/cpu/amd: Do not print FW_BUG for Secure TSC
To: Nikunj A Dadhania <nikunj@amd.com>
Cc: linux-kernel@vger.kernel.org, thomas.lendacky@amd.com, bp@alien8.de, 
	x86@kernel.org, kvm@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, 
	dave.hansen@linux.intel.com, pgonda@google.com, seanjc@google.com, 
	pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 8:16=E2=80=AFAM Nikunj A Dadhania <nikunj@amd.com> =
wrote:
>
> When Secure TSC is enabled and TscInvariant (bit 8) in CPUID_8000_0007_ed=
x
> is set, the kernel complains with the below firmware bug:
>
> [Firmware Bug]: TSC doesn't count with P0 frequency!
>
> Secure TSC does not need to run at P0 frequency; the TSC frequency is set
> by the VMM as part of the SNP_LAUNCH_START command. Skip this check when
> Secure TSC is enabled
>
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> Tested-by: Peter Gonda <pgonda@google.com>
> ---
>  arch/x86/kernel/cpu/amd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index be5889bded49..87b55d2183a0 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -370,7 +370,8 @@ static void bsp_determine_snp(struct cpuinfo_x86 *c)
>
>  static void bsp_init_amd(struct cpuinfo_x86 *c)
>  {
> -       if (cpu_has(c, X86_FEATURE_CONSTANT_TSC)) {
> +       if (cpu_has(c, X86_FEATURE_CONSTANT_TSC) &&
> +           !cc_platform_has(CC_ATTR_GUEST_SECURE_TSC)) {

Could we extend this to never complain in a virtual machine? i.e.
...
-       if (cpu_has(c, X86_FEATURE_CONSTANT_TSC)) {
+       if (cpu_has(c, X86_FEATURE_CONSTANT_TSC) &&
+           !cpu_has(c, X86_FEATURE_HYPERVISOR)) {
...


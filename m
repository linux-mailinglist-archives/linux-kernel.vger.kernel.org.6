Return-Path: <linux-kernel+bounces-517404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE60A38059
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405A53A7219
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9131917D7;
	Mon, 17 Feb 2025 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="deL/tFec"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559E818DB1C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788600; cv=none; b=quZeSAJ0gj5iGXp1+CpMPZJcIDXg1QrDCn6+Qc7y45o1XERCgl0mnpnewepNnB6un25crs1K/v2Tg5ZQlpnM2ZtoxaoSKJwIAeoDRfgb2YWd++VuQszJ19Q+1ywtFRKv09IeTmwIY/FdOkwZoyxGz73EKVChFuwiWvbIxDHVKEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788600; c=relaxed/simple;
	bh=ZhfaGtlvZqWXgNva+NYSmoolTHk2KiOLJE52OgXB5sk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KtBUELH3B9yGB56gJqtK3s1UN3OH/3xtl5gvwuqzYUe5i5FgduBFJ6Qs87F3i4a+ZAUZ/tSVLHDRaCO+RtDNNHfR+sS1NocJ6F6GAw8kh7zS5eS2Hv2rf+E1xNqsytZGJcaGaIbQlNBWXxMawKc5VwotIfaKMDskAKk5H50LVNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=deL/tFec; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d19f5ce8a0so7942115ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1739788597; x=1740393397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXuIrr0uZbsvb+1H4q1P/dQZuaUoc6czcr9gRmWyKlc=;
        b=deL/tFecVDEJIZlrLLq+rhcpwOytGywXaqtUqVDvnQDkyYC1esodHmiQhidBa/ZtDi
         J92UEou9+8wUhLII+DwEmg4/OcBv1PVKcqRTweYR/9QsO9pOdT7Hb6TojB9KXn/KdiP1
         q8dwCykjA9ZJ3isZ/RpXgSQSyc1IHpRVx4AneqWp6f85dGLQKYV96X9mEeGpofTJJ1Ax
         YbvAFyZo/t4WQOy4SZlZ66EgtHCa7Ory1jB81OEw3IDi546Nj/QSM7Xz7HGE5wavH+xO
         L6CYa99MmIDLljxqKzvOu1krkDXqDrPoXF9neebdNZ93TKtKjI+hVjy7Ean18AMUIOTt
         o8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739788597; x=1740393397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXuIrr0uZbsvb+1H4q1P/dQZuaUoc6czcr9gRmWyKlc=;
        b=KEL0taVNJgt8/ao+3jfuNKZLH42uIUH5Z8UtBmei9J1Z3HL15WNST6zfWBfjx4Bul0
         CHXJya4wBjWHySJADQeLVx37aHg9qUjU9a7CDG7KiL70oOQXBHflqC8Bi8DKTi7UZxgX
         KOkFqFgcmgpA1enRNVqON+6y8Ax4q0mK9da7Dr/8LQSkeAzplUj8xy14ds+Qe5PHlm93
         I6a7bWbh8jUKQ5dy7iQG3p7H7qPMSuJqbXFLDy4TemPpB4LW55LM0bQWvcKLnWV39xmA
         uudGrzfrPTi0SMWWQy8ppivstG6/oEQOydJcq0k92SmY9jP0elckQDWOIf9Qa2329JiV
         tA9w==
X-Forwarded-Encrypted: i=1; AJvYcCUbUP/s4Yr8wkypb41ux3lDhJOnhWyrkPxh+0+L3fQeY6g3wfqjp2qhwDk00V6qSerxVbouY53jTvBhkr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxwZrIdzE7o/8+ZsBQmazHmCC0OwUOVdArwSd5vrbRMBa0xRP8
	ksZJXCKihOq4BnLOUUDXkPDoylQLYDt9KPw1CGoxAaWYEI+gLklVhXaaj8tmLh0hTKi+jd9/Fb0
	i6utq9WCKYs/pKtpxiqCTWsGrkN6E3+wpyiBkE4KYP3HQpEq1
X-Gm-Gg: ASbGnctyCEw7EbFAsaMVkzJIEJQ9oXDCub9fgo/eyrF96htGnM58iEDslqNRUeA3TjA
	AjZKIdlFjgKpBKDUhnFiB0pSMzJ1KmMrBE2eVxx/yOFQXefp3MFDtU4rNv/ZIvi5XDy3db9cXSA
	==
X-Google-Smtp-Source: AGHT+IEw269iT/y4krWNO0LRo2RLfVtDkGsMXcWgAorAmpNUQzvjAfq/Q6R4P+Rr0miTce5VQs94e89cnvKhqhjf5ic=
X-Received: by 2002:a05:6e02:184d:b0:3cf:b2ca:39b7 with SMTP id
 e9e14a558f8ab-3d281e294f4mr66755685ab.3.1739788597288; Mon, 17 Feb 2025
 02:36:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217084506.18763-7-ajones@ventanamicro.com> <20250217084506.18763-8-ajones@ventanamicro.com>
In-Reply-To: <20250217084506.18763-8-ajones@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 17 Feb 2025 16:06:26 +0530
X-Gm-Features: AWEUYZkeJbANn3o67oIBgEtVLiGAHW5hziZFAcMUSpUUnQ4RfYuy1apwMnNIRW0
Message-ID: <CAAhSdy14rpAPQcv0nuhZ6DRhABa38cBq3oB7y28X6Fe8_adCbw@mail.gmail.com>
Subject: Re: [PATCH 1/5] riscv: KVM: Fix hart suspend status check
To: Andrew Jones <ajones@ventanamicro.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	atishp@atishpatra.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, cleger@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 2:15=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> "Not stopped" means started or suspended so we need to check for
> a single state in order to have a chance to check for each state.
> Also, we need to use target_vcpu when checking for the suspend
> state.
>
> Fixes: 763c8bed8c05 ("RISC-V: KVM: Implement SBI HSM suspend call")
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kvm/vcpu_sbi_hsm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_hsm.c b/arch/riscv/kvm/vcpu_sbi_hsm.=
c
> index dce667f4b6ab..13a35eb77e8e 100644
> --- a/arch/riscv/kvm/vcpu_sbi_hsm.c
> +++ b/arch/riscv/kvm/vcpu_sbi_hsm.c
> @@ -79,12 +79,12 @@ static int kvm_sbi_hsm_vcpu_get_status(struct kvm_vcp=
u *vcpu)
>         target_vcpu =3D kvm_get_vcpu_by_id(vcpu->kvm, target_vcpuid);
>         if (!target_vcpu)
>                 return SBI_ERR_INVALID_PARAM;
> -       if (!kvm_riscv_vcpu_stopped(target_vcpu))
> -               return SBI_HSM_STATE_STARTED;
> -       else if (vcpu->stat.generic.blocking)
> +       if (kvm_riscv_vcpu_stopped(target_vcpu))
> +               return SBI_HSM_STATE_STOPPED;
> +       else if (target_vcpu->stat.generic.blocking)
>                 return SBI_HSM_STATE_SUSPENDED;
>         else
> -               return SBI_HSM_STATE_STOPPED;
> +               return SBI_HSM_STATE_STARTED;
>  }
>
>  static int kvm_sbi_ext_hsm_handler(struct kvm_vcpu *vcpu, struct kvm_run=
 *run,
> --
> 2.48.1
>


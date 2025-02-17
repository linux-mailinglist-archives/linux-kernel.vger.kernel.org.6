Return-Path: <linux-kernel+bounces-517419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE3AA38077
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF6E87A50DD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78943217657;
	Mon, 17 Feb 2025 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="LmYVUA+T"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAB5216E1E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789058; cv=none; b=ujvRsTqXpxxsVFuAD14Tk2v/5vhQ5m0SYMOg1VHnr2QoVTU/MrePL0If9dXEUNqLcFzMjIgNUzQlRFKLYjiG8jJPM9Vh1844ArJsy0VpvNchdsdo2/q0p5JOuJm2jmPRaGYaGxiCp9rtaVoNb4DzpwZ6SlkOMoIzm7VMOerDS0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789058; c=relaxed/simple;
	bh=D0MOkPWP2WN17C0xDRNnf0+yyPZKfDZ1qJT410554nU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrJhSIYXq1TeO8rBhjJLVs0t9/tEI7GyvsgUUp09oUzMo1Ry5RwEcPqA1KNhsnWJSCqEsX0o+9RIK9KNMJKHjafKsWFhPg5FOY3S/jaNsOXGm1WP6qS9DPYPUGSDXkbWXjHw9oxctnu0KspcUeF2Vxxj/2nuHxiw7xgOYOR+jcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=LmYVUA+T; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85527b814abso57825739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1739789056; x=1740393856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEC9IKTHffK3WvFzTVA0qo6PFNnuHBV9vhhQNHZZ8nE=;
        b=LmYVUA+Tj+NDjrdPhsGWPrj1g+2HJVDT/CgTmxfUZJizho8FlBR8GSgYYeVu0djQx7
         pRIwm6LPtZ6X1/mRfBjErYmPm+Xvg35pPNnYTkviQ6ByyGd/nbOoby/HzGfu5ScFWJzs
         CYVU4gpFWw1UKKC68onDKmT5JajZCLeV0Wy/957bXZ0FW4GN5i1K6e2CHxNDqzKqi9pZ
         uvojgxQ/XVhzF4EEnqrJfs/QsdUAqjTLJi4Nk7hAweIYLXHldxmEZKwi1dtJmXJRQHwZ
         NiLuMplnOBCnhilquvJdWxqeWTOAFoOhdZYrbOF4n0U5BsF+910STC0X9XTW8xOM12kZ
         aFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789056; x=1740393856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEC9IKTHffK3WvFzTVA0qo6PFNnuHBV9vhhQNHZZ8nE=;
        b=X8y9UPg+ZI+VxKIhAyasaGjcPIKQp7KKg8MmrJjc8LFVeVogmgvh3vEqhVQnr9JYfu
         6CIopiO8QowXO7kEb8Uay6E9PmBjt4pUtpFBC80e7NA53EferSXy4sbyyFFFH5uC+Xyy
         cD0TwpEucaUBVBx2oXacMThi6NlbUEUsXmrh/oxMy7f0KL6ayFCQ48SC9b74Xw8kdVMj
         iTfgqrFOIp++2owdvqL6LT8AaSojIOiU24ws73mW6Me3nehGhfN0SgBPatZuS5pksCMN
         sJod0ly25ss0HywrH9COTGN16NgFAge9IPw9rpFgEuwOGneigYHU40s439PODTLza4qT
         /c4A==
X-Forwarded-Encrypted: i=1; AJvYcCWvTUMiXCXYuUoGyt+nat/tDTccyvgEZYnjfAQyqhfr/QBf4hnZHGBGJ5MvdMg49jx24X5JPzs2K/oBgrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZqWsvIHQaOE9kDocDYDf9FRWWP8SgHGpYTD3rSqGc63IG1Sb0
	YMLTVy//sfq1/a2iO2hMweLxuZcmdHzHWrssw6txwWbGj0pbJsTjxdEkGFghFTPxrbuAf4W8V6A
	cRVYL32qc3CW5FU4gwBYLUT8aVqnaxz5MMvsurA==
X-Gm-Gg: ASbGncsOThMv83vfZilfcSgb0MlXiVTkaSHiF4xi4xFTiTAUg+BhkVeIakE29rKEPPv
	b6BeQt+DqDWnzvSLFACuMmBeuN+ehXHLj2wqlPVI8QbDI4FTf2WkGDYm6VIE6KwTmH+QpJ2bPhQ
	==
X-Google-Smtp-Source: AGHT+IEx965Kes7J9PFe/fEC2qu7c1lQXF8r1O+rb4FsIYIqeAylTS8U1CDqrpwteAP6QAUGVznUvUBjnd38LJ5N3iE=
X-Received: by 2002:a05:6e02:2181:b0:3d1:4b97:4f2d with SMTP id
 e9e14a558f8ab-3d280763f51mr58551715ab.5.1739789056483; Mon, 17 Feb 2025
 02:44:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217084506.18763-7-ajones@ventanamicro.com> <20250217084506.18763-11-ajones@ventanamicro.com>
In-Reply-To: <20250217084506.18763-11-ajones@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 17 Feb 2025 16:14:05 +0530
X-Gm-Features: AWEUYZkbD0BHzIgdISlWzpxxTEzeWANGopBZGPKVtWrdTFLAAwqfFFUQyuGlYn8
Message-ID: <CAAhSdy2y-hsdNLQf3YVGkC-v7ZdK1NpR6TDnJRoce+qD+7m3Wg@mail.gmail.com>
Subject: Re: [PATCH 4/5] riscv: KVM: Fix SBI TIME error generation
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
> When an invalid function ID of an SBI extension is used we should
> return not-supported, not invalid-param.
>
> Fixes: 5f862df5585c ("RISC-V: KVM: Add v0.1 replacement SBI extensions de=
fined in v0.2")
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kvm/vcpu_sbi_replace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_replace.c b/arch/riscv/kvm/vcpu_sbi_=
replace.c
> index 74e3a38c6a29..5fbf3f94f1e8 100644
> --- a/arch/riscv/kvm/vcpu_sbi_replace.c
> +++ b/arch/riscv/kvm/vcpu_sbi_replace.c
> @@ -21,7 +21,7 @@ static int kvm_sbi_ext_time_handler(struct kvm_vcpu *vc=
pu, struct kvm_run *run,
>         u64 next_cycle;
>
>         if (cp->a6 !=3D SBI_EXT_TIME_SET_TIMER) {
> -               retdata->err_val =3D SBI_ERR_INVALID_PARAM;
> +               retdata->err_val =3D SBI_ERR_NOT_SUPPORTED;
>                 return 0;
>         }
>
> --
> 2.48.1
>


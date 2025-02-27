Return-Path: <linux-kernel+bounces-535798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BAEA47758
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B85B16E73E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BFE22370F;
	Thu, 27 Feb 2025 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="e1cQWA37"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CEE219A68
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740643718; cv=none; b=ViLlmfDqyj4fKj01nMU+TdKCrknBzWBvr8PNzqj7B4dN8xymK5raOvHna/KhJLDbyVj/57QNzk9PHMs9hMcFEuZKz+SF4c8ixSYIYaYawFOCtKAKD+K03CQLdfZFRNORZ5WW3PEH9REKlAep0fetGh1GScTImtU+EdTGcRin4Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740643718; c=relaxed/simple;
	bh=r5MYi7hZkFxlnQNhgITPV8HgnQ6Ea2Joi+mAWXpJyyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TD+jzUAhO9dY1zFIoVJ2J+A9blNfpa25sqEdARndyNqMpAxTSqSArx5ZEGWJeI3bMjcbb95IwdEdlCaP53gWMkyOrga9N+VopcHBewX5yWjqQDQhs0NHJcy0YmYq6NfQyYXoWnLGQO9bef1XpNqeGrh5OMUzwTVnX9Fm6eggnrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=e1cQWA37; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38dcac27bcbso1185212f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740643713; x=1741248513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SXEKvsRH1IHGZjXRKII/sR3OF5jBOeQXuZKp+7GCCWk=;
        b=e1cQWA37aUhyGsR2OBViUQPAq6FgG+YLOGWZRsc4sHnPG4EpG3XUGvLqBiMOOasXM/
         lFnrajwvHe5m5ZXImLhJ8tc0nBEvMOvPanmfXg0xlPITTjAGoG8cAcw5kpFmAjBxdJo/
         5s94IBY49j52HmTWEr6g7FKUmku1O7f1gBuD5cyPFn3A8SLWvYnddTAtQUAwZReCDFaU
         YRJLQRbpxkDRFx3AmZV5Mmmd6/2LV+EoMwQfbxzPeG0uSItAhE7db6WPii0vJ1OqNr57
         l8bbgjxxtOqciDkKCrYa8mhWOTqn86TTljeI2p0mEndi+byXz5o2UjrhusQukCCo0fZt
         wL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740643713; x=1741248513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXEKvsRH1IHGZjXRKII/sR3OF5jBOeQXuZKp+7GCCWk=;
        b=X4Zs9BufJqwiWpwLDFivVKvcyq9du+ojJuXqeZmgaWeVYMB1T5Lmr9pmN7CrxuK5fn
         z3mnTn3TFFfwo9X9QoGUpCy+U18iffiu3WAg7BEMqyBfbRSXc/TFYuGAm19EqkdIIyqF
         vDUFMNty2aBd3I+M0qanzjmGpLphfPGQKGzw2OuIlvU1VBA2OfSwVPppp1zrVnLy/UGP
         o0cWBiuj4NlZtduf+SQqCEFvivtcoetkJrcqG1zyNY8wrbai/b6y/3DJoiv+Ngv29IXf
         F2aC480cn84TtPSMONbR3ajeweb/97CPSA0T6V/gPPx3TE/DjPSeytu//74Cuxm31inG
         miAg==
X-Forwarded-Encrypted: i=1; AJvYcCX63MYwBZa/1knQt+ezr8Nj5vSjSF2lSn1ZnxKiN6/0uPe5glT0p5i4F/lHbBwy9BK0jMVbCLOngRn+EZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjE+TIwJeJis+q5qoaXFmwUUow89+Am03HKsulJFJPekRDDS/A
	Sphm5EYlzXIQXEONviSvP6C6dhKRRgIgZT6pjSvDb+XevZ1yov5NaPOJigdo4Mg=
X-Gm-Gg: ASbGncsWLVLJ+qgb8aNskdPzUQMOt0wN2MrJf9p2Rw/IaTTsW0oVUh/L0vQ4mSYtA7V
	x0rHz086HE8ZUeck0BBpFSTGBu5mro7wY8De08tQH56n+MHKsK1nHlqso2NDqdo5jWZmrRux12/
	7FmzI1PzFnhzvZs6CAHMw82f4ZkjhrtoQhoFF4IeNX+AEHVLGWkzuCdQ3DLnOOT0nzaNwxL++v7
	jfQ3akgWX7/KwY8P9bkefchnIiEyDVgx1lSqjs2EP0POaVxa86mo1L/6PsFTjOJTj1iSoiiUnFu
	VaBkKIQqVqzZow==
X-Google-Smtp-Source: AGHT+IFfzFnOGuM3XpELAhnmFcvI3sNcf5fvXpL9iafVg+5GXrJpxNcbrV4SnJPTY8dCnZQ7wtZd1A==
X-Received: by 2002:a5d:5f93:0:b0:38b:f4e6:21aa with SMTP id ffacd0b85a97d-390e1648bd8mr1563072f8f.5.1740643713445;
        Thu, 27 Feb 2025 00:08:33 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::8cf0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b6cd8sm1198683f8f.44.2025.02.27.00.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 00:08:33 -0800 (PST)
Date: Thu, 27 Feb 2025 09:08:32 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/4] KVM: riscv: selftests: Change command line option
Message-ID: <20250227-eb9e3d8de1de2ff609ac8f64@orel>
References: <20250226-kvm_pmu_improve-v1-0-74c058c2bf6d@rivosinc.com>
 <20250226-kvm_pmu_improve-v1-3-74c058c2bf6d@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226-kvm_pmu_improve-v1-3-74c058c2bf6d@rivosinc.com>

On Wed, Feb 26, 2025 at 12:25:05PM -0800, Atish Patra wrote:
> The PMU test commandline option takes an argument to disable a
> certain test. The initial assumption behind this was a common use case
> is just to run all the test most of the time. However, running a single
> test seems more useful instead. Especially, the overflow test has been
> helpful to validate PMU virtualizaiton interrupt changes.
> 
> Switching the command line option to run a single test instead
> of disabling a single test also allows to provide additional
> test specific arguments to the test. The default without any options
> remains unchanged which continues to run all the tests.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  tools/testing/selftests/kvm/riscv/sbi_pmu_test.c | 40 +++++++++++++++---------
>  1 file changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> index 284bc80193bd..533b76d0de82 100644
> --- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> +++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> @@ -39,7 +39,11 @@ static bool illegal_handler_invoked;
>  #define SBI_PMU_TEST_SNAPSHOT	BIT(2)
>  #define SBI_PMU_TEST_OVERFLOW	BIT(3)
>  
> -static int disabled_tests;
> +struct test_args {
> +	int disabled_tests;
> +};
> +
> +static struct test_args targs;
>  
>  unsigned long pmu_csr_read_num(int csr_num)
>  {
> @@ -604,7 +608,11 @@ static void test_vm_events_overflow(void *guest_code)
>  	vcpu_init_vector_tables(vcpu);
>  	/* Initialize guest timer frequency. */
>  	timer_freq = vcpu_get_reg(vcpu, RISCV_TIMER_REG(frequency));
> +
> +	/* Export the shared variables to the guest */
>  	sync_global_to_guest(vm, timer_freq);
> +	sync_global_to_guest(vm, vcpu_shared_irq_count);
> +	sync_global_to_guest(vm, targs);
>  
>  	run_vcpu(vcpu);
>  
> @@ -613,28 +621,30 @@ static void test_vm_events_overflow(void *guest_code)
>  
>  static void test_print_help(char *name)
>  {
> -	pr_info("Usage: %s [-h] [-d <test name>]\n", name);
> -	pr_info("\t-d: Test to disable. Available tests are 'basic', 'events', 'snapshot', 'overflow'\n");
> +	pr_info("Usage: %s [-h] [-t <test name>]\n", name);
> +	pr_info("\t-t: Test to run (default all). Available tests are 'basic', 'events', 'snapshot', 'overflow'\n");

It's probably fine to drop '-d', since we don't make any claims about
support, but doing so does risk breaking some CI somewhere. If that
potential breakage is a concern, then we could keep '-d', since nothing
stops us from having both.

>  	pr_info("\t-h: print this help screen\n");
>  }
>  
>  static bool parse_args(int argc, char *argv[])
>  {
>  	int opt;
> -
> -	while ((opt = getopt(argc, argv, "hd:")) != -1) {
> +	int temp_disabled_tests = SBI_PMU_TEST_BASIC | SBI_PMU_TEST_EVENTS | SBI_PMU_TEST_SNAPSHOT |
> +				  SBI_PMU_TEST_OVERFLOW;
> +	while ((opt = getopt(argc, argv, "h:t:n:")) != -1) {

'-h' doesn't need an argument and '-n' should be introduced with the next
patch.

>  		switch (opt) {
> -		case 'd':
> +		case 't':
>  			if (!strncmp("basic", optarg, 5))
> -				disabled_tests |= SBI_PMU_TEST_BASIC;
> +				temp_disabled_tests &= ~SBI_PMU_TEST_BASIC;
>  			else if (!strncmp("events", optarg, 6))
> -				disabled_tests |= SBI_PMU_TEST_EVENTS;
> +				temp_disabled_tests &= ~SBI_PMU_TEST_EVENTS;
>  			else if (!strncmp("snapshot", optarg, 8))
> -				disabled_tests |= SBI_PMU_TEST_SNAPSHOT;
> +				temp_disabled_tests &= ~SBI_PMU_TEST_SNAPSHOT;
>  			else if (!strncmp("overflow", optarg, 8))
> -				disabled_tests |= SBI_PMU_TEST_OVERFLOW;
> +				temp_disabled_tests &= ~SBI_PMU_TEST_OVERFLOW;
>  			else
>  				goto done;
> +			targs.disabled_tests = temp_disabled_tests;
>  			break;
>  		case 'h':
>  		default:
> @@ -650,25 +660,27 @@ static bool parse_args(int argc, char *argv[])
>  
>  int main(int argc, char *argv[])
>  {
> +	targs.disabled_tests = 0;
> +
>  	if (!parse_args(argc, argv))
>  		exit(KSFT_SKIP);
>  
> -	if (!(disabled_tests & SBI_PMU_TEST_BASIC)) {
> +	if (!(targs.disabled_tests & SBI_PMU_TEST_BASIC)) {
>  		test_vm_basic_test(test_pmu_basic_sanity);
>  		pr_info("SBI PMU basic test : PASS\n");
>  	}
>  
> -	if (!(disabled_tests & SBI_PMU_TEST_EVENTS)) {
> +	if (!(targs.disabled_tests & SBI_PMU_TEST_EVENTS)) {
>  		test_vm_events_test(test_pmu_events);
>  		pr_info("SBI PMU event verification test : PASS\n");
>  	}
>  
> -	if (!(disabled_tests & SBI_PMU_TEST_SNAPSHOT)) {
> +	if (!(targs.disabled_tests & SBI_PMU_TEST_SNAPSHOT)) {
>  		test_vm_events_snapshot_test(test_pmu_events_snaphost);
>  		pr_info("SBI PMU event verification with snapshot test : PASS\n");
>  	}
>  
> -	if (!(disabled_tests & SBI_PMU_TEST_OVERFLOW)) {
> +	if (!(targs.disabled_tests & SBI_PMU_TEST_OVERFLOW)) {
>  		test_vm_events_overflow(test_pmu_events_overflow);
>  		pr_info("SBI PMU event verification with overflow test : PASS\n");
>  	}
> 
> -- 
> 2.43.0
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>


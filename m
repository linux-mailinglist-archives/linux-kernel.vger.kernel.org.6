Return-Path: <linux-kernel+bounces-430031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F359E2B4C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A12C1684DC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749B31F7545;
	Tue,  3 Dec 2024 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vfkAQD+Q"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1F242A8C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 18:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733251513; cv=none; b=H5AJppmUD5i9QFuNdsFFaITc4vaS++2qyOkwBN8FcXgfepkytdKOLhuyzeXkpOxpr9McX3ISqpwQ/BnMlR9i5xyB8u/yhteIfP+XYfxZSeBcv+i5RAD2bENYnZvkDMtBj+TFN3CcHwBYDQWM/SH0RM9k5VUMiCwtLkhRjKtgdMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733251513; c=relaxed/simple;
	bh=WvMXf785DTq8wWZPy65DDlcFTq0jfzfzrHuiSDOxcyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VanW/ytyEr/68Fv7ol4C0TXN/rByCYaVyGaf4vg33gkHQWVP1iwXCjfi0ynPa2s4K1fkPhWpb6OVJENNVlXorETn89/iClqJlrAkLz9WYFaY5N5dE1Yk3nYDz3zy1aYT/g68SVtYuMuTTCkvIQGijqYIJS9hosroacZvcEjRjis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vfkAQD+Q; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee86a1a92dso2638464a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 10:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733251511; x=1733856311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DX1q4LbNfnO54nY1P9OjyEL2atntmm2otrVNiRk5aiw=;
        b=vfkAQD+QARJ1TK+c8tnEZZwuVTtm53SRydL6wF4LDacETUoKrV8Qc4jBDUFKKqKfNC
         e3GSWvJpDOa/1LjoCVNUkWe6vyXKrNjcgISQFhpmjjKeO6XSUzSewZx5TlJndtz2ppun
         /HwrPTrObXJs9U29S2pdpJLt0VLISSvAUUcgTFFTfFZco7s9EMUYOY5s97SjwDfnASfm
         L+vV9bKEttKmb/QVfATbY5G8JfLJGI8bnDqv3v42U8PimYMApGvhYUicm1/j7sR/xRYt
         v9ZRS+ocIonBoo2r9lDLeieWbyDz1Wc4qTxC3FZaViyT5tTvWVFs1dwZZYqlK5QtTBIE
         thyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733251511; x=1733856311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DX1q4LbNfnO54nY1P9OjyEL2atntmm2otrVNiRk5aiw=;
        b=PdQDuYerPK9FA4fb9q3ZOn4jsEJqctRpkmFsVkCJ6ukTZ3+2F/19PNAo3/Py8zcZkG
         REl3Hz3mgU5jxPNhJkogNt7XGGltCZ50RT/FgzAzdYgXmVQEf+29TeXDQdIZBiDGS6+G
         LFAwat93pBaSVywIEMgQypTVOlhQVH60IES2s3O5oNumJ3BNzbEhAlaVvMZrcyi0gfjs
         J7a0ftkEzw4/4IfdY56E+QuWKyqgjZhJ/GrnfCP4/8RL2HGJvOPNbc0oRLc6F9FPGwCJ
         zGaAgkUUV7VC7tGc6C8ZXW7T8lLtT6twlxeItm28y3H5cwcEdl+xoUMVLVfraGzo/MDJ
         8JLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFfV+uXl89tViJ21Zehcg8XNpjK7FdcpVhLXwuz8TrktPYgsVfWk5bYw2V+KGjh+c2E0UfmhzmcrQhLzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywde5Rvpj4Cv1l+K4DPvDtitYbf+G6PLErEg8a05zsDi3FLSRGc
	922vi5OyUVLnY45obqxokjJAdoy9Zxp6dOPaWSifbPTCt4GOWmGUTMklfEt0VME=
X-Gm-Gg: ASbGncuvM2/9xZx6oI4SwzizDbssuHXY55gwKHFl8A253BNSRMVEm5XGciXjeKEl88t
	U9w+VUFRdC0g4HUMWf1dkZDxUU1bWL68DHfXItl/xPR913iq+B8PdipMSPqOvn5zdsCAv72h7YQ
	PvVgKTCwZpcKcStmMngZL1dttOW8kINisRQ8yRAPL+KG80nu68acxnQF+eWUHiDc+zg6PeamJXH
	mnRaYMMSxrscoyvU2lTuInZMr2iTaeTTOJvgj25gC/7og==
X-Google-Smtp-Source: AGHT+IEhsEsYF/DSzp4oikyjn6fRzE2euETCh9znl9SEgHM1n6BH2uIgHofOP2OdcmmDuTYZp1vciQ==
X-Received: by 2002:a17:90b:4b06:b0:2ee:bf84:4fe8 with SMTP id 98e67ed59e1d1-2ef01262060mr4728642a91.30.1733251511178;
        Tue, 03 Dec 2024 10:45:11 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:eb46:d11e:11bc:ffc5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee488af41dsm9151463a91.28.2024.12.03.10.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 10:45:10 -0800 (PST)
Date: Tue, 3 Dec 2024 10:45:06 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Celeste Liu <uwu@coelacanthus.name>, Oleg Nesterov <oleg@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrea Bolognani <abologna@redhat.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ron Economos <re@w6rz.net>,
	Felix Yan <felixonmars@archlinux.org>,
	Ruizhe Pan <c141028@gmail.com>,
	Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>,
	Yao Zi <ziyao@disroot.org>, Han Gao <gaohan@iscas.ac.cn>,
	Quan Zhou <zhouquan@iscas.ac.cn>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] riscv/ptrace: add new regset to get original a0 register
Message-ID: <Z09RshGMxW3q6JpA@ghost>
References: <20241201-riscv-new-regset-v1-1-c83c58abcc7b@coelacanthus.name>
 <Z06ZAP-_4J4-6aK_@ghost>
 <20241203121948.GA18179@strace.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203121948.GA18179@strace.io>

On Tue, Dec 03, 2024 at 02:19:48PM +0200, Dmitry V. Levin wrote:
> On Mon, Dec 02, 2024 at 09:37:04PM -0800, Charlie Jenkins wrote:
> [...]
> > +static void ptrace_test(int opt, int *result)
> > +{
> > +	int status;
> > +	pid_t pid;
> > +	struct user_regs_struct regs;
> > +	struct iovec iov = {
> > +		.iov_base = &regs,
> > +		.iov_len = sizeof(regs),
> > +	};
> > +
> > +	unsigned long orig_a0;
> > +	struct iovec a0_iov = {
> > +		.iov_base = &orig_a0,
> > +		.iov_len = sizeof(orig_a0),
> > +	};
> > +
> > +	pid = fork();
> > +	if (pid == 0) {
> > +		/* Mark oneself being traced */
> > +		long val = ptrace(PTRACE_TRACEME, 0, 0, 0);
> > +		if (val)
> > +			perr_and_exit("failed to request for tracer to trace me: %ld\n", val);
> > +
> > +		kill(getpid(), SIGSTOP);
> > +
> > +		/* Perform exit syscall that will be intercepted */
> > +		exit(A0_OLD);
> > +	}
> > +
> > +	if (pid < 0)
> > +		exit(1);
> > +
> > +	if (waitpid(pid, &status, 0) != pid)
> > +		perr_and_exit("failed to wait for the tracee %d\n", pid);
> > +
> > +	/* Stop at the entry point of the syscall */
> > +	resume_and_wait_tracee(pid, PTRACE_SYSCALL);
> > +
> > +	/* Check tracee regs before the syscall */
> > +	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
> > +		perr_and_exit("failed to get tracee registers\n");
> > +	if (ptrace(PTRACE_GETREGSET, pid, NT_RISCV_ORIG_A0, &a0_iov))
> > +		perr_and_exit("failed to get tracee registers\n");
> > +	if (orig_a0 != A0_OLD)
> > +		perr_and_exit("unexpected orig_a0: 0x%lx\n", orig_a0);
> > +
> > +	/* Modify a0/orig_a0 for the syscall */
> > +	switch (opt) {
> > +	case A0_MODIFY:
> > +		regs.a0 = A0_NEW;
> > +		break;
> 
> Did you mean applying the modified user_regs_struct using PTRACE_SETREGSET?
> If yes, then there should be an appropriate PTRACE_SETREGSET NT_PRSTATUS call.
> If no, then regs is ignored, so why would you change it in the first place?
> 

Yes you are correct, there should be another PTRACE_SETREGSET. That was
a mistake in modifying the previous test case for this new patch.

- Charlie

> > +	case ORIG_A0_MODIFY:
> > +		orig_a0 = A0_NEW;
> > +		break;
> > +	}
> > +
> > +	if (ptrace(PTRACE_SETREGSET, pid, NT_RISCV_ORIG_A0, &a0_iov))
> > +		perr_and_exit("failed to set tracee registers\n");
> > +
> > +	/* Resume the tracee */
> > +	ptrace(PTRACE_CONT, pid, 0, 0);
> > +	if (waitpid(pid, &status, 0) != pid)
> > +		perr_and_exit("failed to wait for the tracee\n");
> > +
> > +	*result = WEXITSTATUS(status);
> > +}
> 
> -- 
> ldv


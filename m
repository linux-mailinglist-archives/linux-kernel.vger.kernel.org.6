Return-Path: <linux-kernel+bounces-543618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A6AA4D794
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BCEE1888DAD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1051FCFE6;
	Tue,  4 Mar 2025 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hutJPL4x"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95241FF1BB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741079014; cv=none; b=ojIlEj9QGbf7Rj5JmpXhXlsmfAlnG9rLVOyeSEyWQEucEjXWg/OPLGwF/lWFGZqUdt7LtymUkOgdSjl0jK36wNSmSke6m6vKA07MUQpN83d1/SEDABxTog215VLANhMXQdLHYmTQBrtx/dZzj7uXYkRX+FULVJHmwhFrMV6Sw1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741079014; c=relaxed/simple;
	bh=pD2QlyVVHGAg8ptt/VjbZEKq6kOGSccucp9idXzSK1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+Tee8BqTd2iAOwxRVF7ChWeSfMoL3NjwMeRkagSfUxbPdw1KCpJ3ycq+pXMbZSsmOHqDoCx2H+fM4hGxkM9FRxkRu9ZzsBNPHET9lZQ9f4CujCSoNTqkWGkw5VYa1x7tBgenA5tnh6pOQW3buhGIdD4z/163dhB9LkdBxc5t7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hutJPL4x; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-439ac3216dcso36385085e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 01:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741079011; x=1741683811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c/pyfoaR/eT3J3WSzi9ciqMZLn3faPQuYj0+Pv+ikCU=;
        b=hutJPL4xk+8gR/bqhX+xh8JfLLuYvPBHKVOW18W77rGePBVxt9vWqXg04NNxV507Fi
         5Ka0wsHln0BSuxEyxT2xwHRhnq2gu3TZoh0lg8cWTRwFn220C4U251Tq5gfbs2L1xs0w
         EPhqZDjdRf2jVPlrApaqTEBvppYuiKDyEUAU0PLR7l7LzDBxJwpHAMHeFwzhB8ufrdRO
         9ffrtuBmQy2xcOfe0fhA3rJQ30OBtFsyFKSAWliHtYTnejrOlm2b9p/c6nU6UtieuiLs
         kWTjvMTN9Fel8TqMJlFgzaAHM3EBi8vJS8BCX3W9gxb8VPssfjOr4D16YW4KHZnB6qNz
         0q8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741079011; x=1741683811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/pyfoaR/eT3J3WSzi9ciqMZLn3faPQuYj0+Pv+ikCU=;
        b=bLrE9WPYasT5dwMbWBWPjWaQYCpgzXQOv5dyOB6GIViiskSgX6cg3Gjhp0H+ffm1t8
         UoMtzZvbZzS4Vr8oFMi2aOvwXcxiIt261+KM2W8w38NEk5tgLzvsyQHB953SA3YQX/cY
         Ix6A3N3nM0XfHvvX+J79LX2rRyKtJj+JMKY7t0BTynjDf7MqfiRFFosdrXFEDVb8/TAu
         wif14Enmvv1kXOE8w1upSDYczhS3zg7xIft2tV+t+YcBSqUUwkJArmiPUR5KzaoIP9V2
         ol6ia48tx/N48dd7m0QNquCGXcDCrRIOlCEcZMcK2MTzikKNcNCt54lQDiplcvOjh6Ww
         wl2A==
X-Forwarded-Encrypted: i=1; AJvYcCX0NANOkOniMORU8/Mkf7LLolLrDiET151ZteLsuKoa9TUXOjYlavAie4RxZjO7M22BhVYjsxzVt07I4ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRNf/C1VsJ08rpsn7TDsZ7uO4k3vwx+2gt23nKgL5sb4bCxahz
	24ReE9om7DTHAYOM+OUDpg2q0EWQpDqLoecVQN5kvdoEVPgHJRYGzWwgtkubsA==
X-Gm-Gg: ASbGncvQoga+PMpEXi6h3rf0L+o3QBRfz6KhXUNKol2uHawRGYwpgWpB2rNmKki9/q4
	arOEVyUs0D7vbbogX3kAYbcEh/mSv6SH1NOSgiDD8j3ZA7oOSIsD3ZyRKFBWYyd7XAcggMGsZDc
	SOwgu7/Opxj2d3QkgWFjt0qtTqd4aBvdemi8eIQFsNV2+goeGwj2Xel+APrR+PQYTUQRGYw2xJB
	rLMmP/vJuh9RFMsw6dh4axREQMLytTzPeN8eJplHGSUvxy2nHvGiCweksUUi0ixKXLRGL8O1Y6s
	AaV5VG+LbIZYbthKO9k9QdjD7HUKG/zT+XUbUX0tSrRaV/Lk/TTMlQ8QjAwdsmiR9wMvMiN+bnX
	rWd1fFMqk0WNZ
X-Google-Smtp-Source: AGHT+IG+qNv3nEuovxtZ4Kh1LW4uAVYUbOr45A5k0T9kpCaFC9wlZiiNL+99xr4j/zMeBCPF6NNn8w==
X-Received: by 2002:a05:600c:3ba0:b0:43b:cbe2:ec0c with SMTP id 5b1f17b1804b1-43bcbe2efa9mr11724355e9.27.1741079010911;
        Tue, 04 Mar 2025 01:03:30 -0800 (PST)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bcb96b0c5sm18735925e9.19.2025.03.04.01.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 01:03:30 -0800 (PST)
Date: Tue, 4 Mar 2025 09:03:26 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: maz@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
	qperret@google.com, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH] KVM: arm64: Count pKVM stage-2 usage in secondary
 pagetable stats
Message-ID: <Z8bB3sr7X4RRV0CN@google.com>
References: <20250228121355.1377891-1-vdonnefort@google.com>
 <Z8Ycq3d7O8_3fozk@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8Ycq3d7O8_3fozk@linux.dev>

On Mon, Mar 03, 2025 at 01:18:35PM -0800, Oliver Upton wrote:
> On Fri, Feb 28, 2025 at 12:13:55PM +0000, Vincent Donnefort wrote:
> > Count the pages used by pKVM for the guest stage-2 in memory stats under
> > secondary pagetable stats, similarly to what the VHE mode does.
> > 
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index 1f55b0c7b11d..c2e022c41313 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -1088,12 +1088,18 @@ void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu)
> >  
> >  static void hyp_mc_free_fn(void *addr, void *unused)
> >  {
> > +	kvm_account_pgtable_pages(addr, -1);
> >  	free_page((unsigned long)addr);
> >  }
> 
> Don't we drain more than just stage-2 page tables into the teardown_mc
> (e.g. vcpu structs)?

Sigh, yes we do. I've left behind some changes we have in our Android branches.
Let me respin a proper version :-\ 

> 
> Thanks,
> Oliver


Return-Path: <linux-kernel+bounces-440206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D589EBA2C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6124B1888B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38EB22617E;
	Tue, 10 Dec 2024 19:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v+5Pdie3"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2335214229
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733859512; cv=none; b=Mn1f6eEdhm8kBdccPSgp3+/9QYPBe1aOgDEX6O6Dpc0bgZBrLYynVCrKkL47sxnj/3q1E7R+HUenS0EK5JWQJrKnL5kZlAPK5n9ol7yDBjvfWUYW88oVmb33MViwgusrIcYrQz+AQaU3q8uERpUmZ2ofhcM1zq4R9jsCaNZxaVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733859512; c=relaxed/simple;
	bh=AQTvlynankvW5TTQ4wAqJvvDhIl/3/qiybDSirkSEOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CN4+YXh9ag2XQrPG3RGo0kMdVYZTIY32b9CpHdLwTvf07RfO98PYxIiC9B35SBZxR/fWVqOlEbJazhaslPYlchqFo38iXHc+OqWbyjd+0VCc7Pcuxy27gLZDHhxyyY622ZEYFj5llrl0HyEhbU+Kgum7dvfvxk77NrPPu9h60lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v+5Pdie3; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so962599466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733859509; x=1734464309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6C+R+OmaQSfBiSVs1fcov+OgwEH54XQE839GPqKNBcg=;
        b=v+5Pdie3Ta3pLkfzq9cbaldPa9CK3KANfZ6kNBv1vNzVsMzbBoYJPhXom8w2tJLNcl
         4hmtr92ujdbqy/k2o5puL4AT6UX+sF+yqWeNzTOg3AUogPxVUMLUB7uj588xwXWYDnef
         3TdEx5k5cgdCTrqppsR9I5rLWar8+j2nNspBfm9yfcIfTca4tpRyQYDGb7/3Ud5wdH/H
         KGFS3vRVqV7wqTCGVPwNThyovtPvYOoElP76GwPpr1edIPsWdCYg3LVzCqRfEnognVQ3
         p3xeIDG5/51LDox1tcDcPddv9vTKY4KhZECKMh+YTb5M+It1cnt1t/SiRSn2ik4+qZo8
         5AEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733859509; x=1734464309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6C+R+OmaQSfBiSVs1fcov+OgwEH54XQE839GPqKNBcg=;
        b=U1fz6QpejzEwvR1U3SMTb0MeQhP94Gu+rqMGT7SBpUhg/DRZ6Td9uAfA9Fbm4MNFQI
         x6XwbDi+gOrEmYWJN94H+RdcHkOl4ZzmC7ZfDydU3cqOEH3c7z1oCr+HEN/YITS/jXYJ
         4GS+1m1cKLxuyftoMLIoFEeOjAVjp650s+VNeyy15tKfYacf3dw0yUfVqr7+cixYRQs4
         c9CNVcBC+RVJW435jrmTTRiZPwtpbbGRnTsV2OZyrmdHvYtfrkg2kyiIKuEH/slWV3ng
         B10V0ncfsUReV3V+DBt0c6rPuVgaF6XPXH3asxuzYSRIkA5GWLEL/u4zPYugZCbLG7X0
         Ui9A==
X-Forwarded-Encrypted: i=1; AJvYcCUu7sfThx6vN6JUjZksEmz0qs1cvHUZu/kHOek9CWpNcRdplC2IxGHTWSym895eq/jSBTCxiLMmbcs6Pkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7yoJt/wDqgK5bAFmXFmagj0+NoVkrncXYgvEWNyf8TlHhFUR0
	9MFuPSlzOpg4VQhZgV0gUguhgUTsLF0iU5VBoRUmY2Noab29bpFcVhxSTr9aNQ==
X-Gm-Gg: ASbGnctXbGz1DVgNUgkBJRFy/dcogrKqg198hPxbXGixxzvmPkfy5Z61tzXbPsLld5d
	iWYIo6olu+ypcixzvSQu89/aYNc4C0IsRfy60Is3tBAyqahGI9mQd8hYMuRk8lYTYr8XFppy5TN
	/RCqeJ0lKB/lOmuav/xmOz9g51LcnAIfFcVliStD8VhlybeizeJzPlKQauUDQPNTIPJ40Fnqx5X
	FS9VwNFjdJeadcQcu9pqvpsu7Al+gHRqNaorb2FSpJEfDx83kqGCjOQWNU5e2IWGQ5gmEWMmYc5
	k5/rhOF42Eyj
X-Google-Smtp-Source: AGHT+IEIqsQNTEuyN6pw6/E5dLWj8qHZRilsuJXfDr6drx/4L726HT8V897DbxQWUpXL/uP7eRX+MQ==
X-Received: by 2002:a05:6402:2712:b0:5d0:9054:b119 with SMTP id 4fb4d7f45d1cf-5d43314cfd3mr23651a12.21.1733859508811;
        Tue, 10 Dec 2024 11:38:28 -0800 (PST)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3c1f99b84sm6775290a12.11.2024.12.10.11.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:38:28 -0800 (PST)
Date: Tue, 10 Dec 2024 19:38:25 +0000
From: Quentin Perret <qperret@google.com>
To: Fuad Tabba <tabba@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Sebastian Ene <sebastianene@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/18] KVM: arm64: Introduce
 __pkvm_host_wrprotect_guest()
Message-ID: <Z1iYsVFgs1Cjwp2x@google.com>
References: <20241203103735.2267589-1-qperret@google.com>
 <20241203103735.2267589-14-qperret@google.com>
 <CA+EHjTx-MZHKwkGYPU+yN-CDkNh1kxTXN8FWTeaPfM95OSkjcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTx-MZHKwkGYPU+yN-CDkNh1kxTXN8FWTeaPfM95OSkjcQ@mail.gmail.com>

On Tuesday 10 Dec 2024 at 15:06:53 (+0000), Fuad Tabba wrote:
> > +static void handle___pkvm_host_wrprotect_guest(struct kvm_cpu_context *host_ctxt)
> > +{
> > +       DECLARE_REG(pkvm_handle_t, handle, host_ctxt, 1);
> > +       DECLARE_REG(u64, gfn, host_ctxt, 2);
> > +       struct pkvm_hyp_vm *hyp_vm;
> > +       int ret = -EINVAL;
> > +
> > +       if (!is_protected_kvm_enabled())
> > +               goto out;
> > +
> > +       hyp_vm = get_pkvm_hyp_vm(handle);
> > +       if (!hyp_vm)
> > +               goto out;
> > +       if (pkvm_hyp_vm_is_protected(hyp_vm))
> > +               goto put_hyp_vm;
> 
> These checks are (unsurprisingly) the same for all these functions.
> Does it make sense to have a helper do these checks?

Yup, that makes sense and should simplify the error handling on all the
call sites. I'll probably call that get_np_pkvm_hyp_vm() or something
along those lines and shove in pkvm.c in v3.


Return-Path: <linux-kernel+bounces-169986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC788BD035
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7646728C0B1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F3A13D52E;
	Mon,  6 May 2024 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hdtuAoz2"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B322313D521
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005376; cv=none; b=S1dWZ0umLtsDgzjxwvWz1tIfZZIrG3NVgeXFhooRry2qVzEeoZEs9z8GlA6OJFRQD1uQju/w+rmSEkF2GDiTolFljhRCDQ1kpBB1lWAOZ/3/5HiY6WoKttGSNZ1HpQJxsIIz5pafwbvBHk45DGnsQcD78gid+j0w8DR42E2gRK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005376; c=relaxed/simple;
	bh=zXf0oRwKRa35Uf2fc5HFWAslshC7yIuk6N3qMAfpum0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IjBvAL1PmCQKSGRHb0YUbmuHCgMUbr5Jx1jfBN54OL0WjEFn7PukCP8C5jYHzO/Pmwez4J5JTssqem649sSJI1NtTpilosI71TUEBALIpGvLBK9hjrMMSQWh+5ondM3YoUFwFz5Q8Cj9gN/YaliAEtWE8o5JwvmMoT9OwVTypkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hdtuAoz2; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5cf35636346so1639760a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 07:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715005375; x=1715610175; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZAxLlaFUQ5Nr5uKqQHOxzk/Ui78RUbkGzJjGGlszQQ=;
        b=hdtuAoz2zKdxmym7GK/KmJSjiXTe5IGtwPk6KqATkZxogB6jev4KZB6SfzJQuIKqug
         FlikVztei0jpJfqJfwuhrWUUEJtFKX9g9aek27/zD5Vr3GyjrvjGxo1o1kwrnE3Te44w
         yehbnsCckNbfKpp4l4g2yRYigeLf1IiT2Qu+1h34uBXPkGFy98/A0n9gG4rmIv3VeU4E
         ai04so6v/2yOxz08nxKHNo951++H5Tzu3j+TqCI5kxW1j9nBgzKHxkRuGFY0nxQdBg2Y
         Egvw/M7n3dJQ7oAZE2cAq+rtHsedhhhZYORmnI+2jH8SEMoNzXt1M/ACTeAAn+aahrWu
         E6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715005375; x=1715610175;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZAxLlaFUQ5Nr5uKqQHOxzk/Ui78RUbkGzJjGGlszQQ=;
        b=nx59eicLFmz0nDq1GULhDr/DPRWth2r/avBklVwUSa+0INkDKQL5bM9ni1qCb74SeT
         Y8Y44G7RW8Pu7F39n9OEnVWAXRgnmuSlj9rRaLMiFh9SFSbdeUr2BN+GUxMmkjVw0Avw
         mGs1WPsuIO3Iz1yyx/3WYQ1BnwoPkai62Aq6qoDb5Jr1JoE+PaBndTxjYlFzfA8bYPqL
         3kpMvs4vAMGJ7N6Qmp977zKNRJMXoQikWzVvdoiocNT+KraORQHwVwNi6ppW1rYfdmx3
         bV5jsBFhVynV4R34E0X0U6u1HVknJy7AaPc50cWPePecIM8corpPnnS9x7HQU/37e1ax
         lLjg==
X-Forwarded-Encrypted: i=1; AJvYcCU/JrEzuDGnslOF4WG1hq4E1jvorVIDVeCxzCPxkdbIkCk0o7TF5/40W1QRK0Iiqt3QoUbOOmBKHI96lluNkI2E3O8ZRFbyUkfH+G6m
X-Gm-Message-State: AOJu0Yw0zTxaaLH+FE7KfAxG32IUCfmFGNDrHM23RtzyAMDJU/iaTNJ3
	9r36QgylWBtmnqxbjf0BCXY7Buxa2IdIoiwyMgcHt9f64nFB1xni7yLHIV8k3T3+nvbx2oOaA+/
	+5A==
X-Google-Smtp-Source: AGHT+IH/owV+eNDXQLus+KtdeokiUbI0DgWTjOXkHc3rV0x1HkFFBn8QIgpOzkYZpgxSZWQTwXt+QQrz4Cc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:52a:b0:5dc:aa2a:7790 with SMTP id
 bx42-20020a056a02052a00b005dcaa2a7790mr36794pgb.2.1715005374547; Mon, 06 May
 2024 07:22:54 -0700 (PDT)
Date: Mon, 6 May 2024 07:22:53 -0700
In-Reply-To: <f05b978021522d70a259472337e0b53658d47636.1708933498.git.isaku.yamahata@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1708933498.git.isaku.yamahata@intel.com> <f05b978021522d70a259472337e0b53658d47636.1708933498.git.isaku.yamahata@intel.com>
Message-ID: <ZjjnvfSxBtS2psgh@google.com>
Subject: Re: [PATCH v19 101/130] KVM: TDX: handle ept violation/misconfig exit
From: Sean Christopherson <seanjc@google.com>
To: isaku.yamahata@intel.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	isaku.yamahata@gmail.com, Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com, 
	Sagi Shahar <sagis@google.com>, Kai Huang <kai.huang@intel.com>, chen.bo@intel.com, 
	hang.yuan@intel.com, tina.zhang@intel.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 26, 2024, isaku.yamahata@intel.com wrote:
> +static int tdx_handle_ept_violation(struct kvm_vcpu *vcpu)
> +{
> +	unsigned long exit_qual;
> +
> +	if (kvm_is_private_gpa(vcpu->kvm, tdexit_gpa(vcpu))) {
> +		/*
> +		 * Always treat SEPT violations as write faults.  Ignore the
> +		 * EXIT_QUALIFICATION reported by TDX-SEAM for SEPT violations.
> +		 * TD private pages are always RWX in the SEPT tables,
> +		 * i.e. they're always mapped writable.  Just as importantly,
> +		 * treating SEPT violations as write faults is necessary to
> +		 * avoid COW allocations, which will cause TDAUGPAGE failures
> +		 * due to aliasing a single HPA to multiple GPAs.
> +		 */
> +#define TDX_SEPT_VIOLATION_EXIT_QUAL	EPT_VIOLATION_ACC_WRITE

This does not needd a #define.  It's use in literally one place, one line below.


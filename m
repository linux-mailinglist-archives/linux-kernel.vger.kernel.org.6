Return-Path: <linux-kernel+bounces-311200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F63D9685F6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6174BB27596
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679FE1D2F73;
	Mon,  2 Sep 2024 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nQ/cfA7V"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B537183CDB
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275600; cv=none; b=IKcbGH1fVad4O1sHhBJsx+R9YhvJZ3+gJMRylZTQB/MwS2WbC20tKCENMh3LdQm4FIDifzeRDV4wkshDdSSbI6oMwhZGhIJ99sb1nWRz9Yo7lbk2SxFeaOCu5gN/KeE7f687w+uxPj0avIvF0kDeLLUdmM9bWTPzST9lfDR+j5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275600; c=relaxed/simple;
	bh=qB/qPSlPdkFfzd1CTJrbma28TcJMnQRtjZeVRJqkvSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqabfBBLGCEcRC7SjthnvhtTJvNGdyjeG2XWB0AW4JwMpefB+fZ+ECYuA450/KP0FKlDtSTnU1rfqglUwUlu3qhBDjLWo70+mx57JNmHW30/zKgf0oDIMG98cZFh7UZc0Q3p0VvltAogLGHX0pzPVC+A94SLT0aSRdxQCqz/m18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nQ/cfA7V; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374c8cef906so795769f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 04:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725275597; x=1725880397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=trOQbSRctpSwONXeBlAgxscj+bT35QMgk51a13CNx/U=;
        b=nQ/cfA7Vu2lFfgFZY+slo0KjaXsLKtsO+CdwCGBjuaaSXNzKc9iGBlwlz36K4yrtHg
         E98X2m1TqTSclg9KR/5fjkZf7Cfn7IN2svK/6EKWJqWBRhzydtHuVThDw+k7obvHg6xL
         Hg6BsjFfWWz3wWq3Cg593vgi9YCcmbd6rej6t/1PFAvR5L/vTX2PXL9D5iUREgeq9mBy
         neuLX0RJwqUPVJS0DTSKW6mmc65W33XCABbD3eq/HrJjocv7EeD6+nUb9ZJRHWl6BUnu
         Yb8M0BMOVLPNTx5hcOXQKxCbY1v8yIaThkzRPsn9E6dRU6PzoMTZanffF+hljT+nSsPV
         pxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725275597; x=1725880397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trOQbSRctpSwONXeBlAgxscj+bT35QMgk51a13CNx/U=;
        b=CcW6URchav9axxg7DtGp0R0BfiEm6ryN44GJLZZPwvxHlBpSVUH6QP0SE1Pwd9vAxU
         1pi4qdscTJ2crxdGnWivjzRnnSwOXAwehehfn/a58IZtDYN7wRTj8uNoOZ4cca0nWp9E
         eZOgxOeIvARf8i2RrJa8OF2IcMGVVNa6v5Leleh/S0XkqvfQxrdQC/oIB9eS8gVWi+Yq
         d5qEST/1U/ufwv+JvayIde0yUo0Ybd46inR0FoGRqvN0qjz3KoeVhujC93mebz/CbzUr
         dlDMKrhP+MFVZkEqQLllzD/nVTORDgcOvYFHKAUaZ43+nwA3/ldgEg9lC2291GvFdo+/
         r5+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGwgDvLg2BO8Po3eHli/tAT4f1RCIl1pIT5Fnl0SfEdeavJzDnDmos1REeiLGsBqUWVYaWWvLCcz17wKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD5PeK1QYXzuAny9LquwEy6+PRztn764s2DCMy7QcqUe7PYjRV
	9dLQdRa/iT9j32LUM+W6KdZD++6TEcVQXGamD3CkBt7DUpGdNK4LTFfBTwP6KQ==
X-Google-Smtp-Source: AGHT+IH7woCYVNiEDZabuscEJviasxR5ir6EOYwiqiG+6QJsMqDLh27XmLT7jAvAWCyzW79uw/yBHQ==
X-Received: by 2002:a5d:522d:0:b0:374:c4e2:ee00 with SMTP id ffacd0b85a97d-374c4e2f17dmr2647937f8f.53.1725275597192;
        Mon, 02 Sep 2024 04:13:17 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e27c70sm134013705e9.35.2024.09.02.04.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 04:13:16 -0700 (PDT)
Date: Mon, 2 Sep 2024 12:13:12 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Sebastian Ene <sebastianene@google.com>, akpm@linux-foundation.org,
	alexghiti@rivosinc.com, ankita@nvidia.com, ardb@kernel.org,
	catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
	james.morse@arm.com, mark.rutland@arm.com, oliver.upton@linux.dev,
	rananta@google.com, ryan.roberts@arm.com, shahuang@redhat.com,
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v9 4/5] KVM: arm64: Register ptdump with debugfs on guest
 creation
Message-ID: <ZtWdyKtw8EGYlJz5@google.com>
References: <20240827084549.45731-1-sebastianene@google.com>
 <20240827084549.45731-5-sebastianene@google.com>
 <ZtGd9UEudn8Z0IlG@google.com>
 <865xriw161.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <865xriw161.wl-maz@kernel.org>

[...]

> > > +static int kvm_ptdump_guest_open(struct inode *m, struct file *file)
> > > +{
> > > +	struct kvm *kvm = m->i_private;
> > > +	struct kvm_ptdump_guest_state *st;
> > > +	int ret;
> > > +
> > > +	if (!kvm_get_kvm_safe(kvm))
> > > +		return -ENOENT;
> > > +
> > > +	st = kvm_ptdump_parser_create(kvm);
> > > +	if (IS_ERR(st)) {
> > > +		ret = PTR_ERR(st);
> > > +		goto free_with_kvm_ref;
> > > +	}
> > > +
> > > +	ret = single_open(file, kvm_ptdump_guest_show, st);
> > > +	if (!ret)
> > > +		return 0;
> > > +
> > > +	kfree(st);
> > > +free_with_kvm_ref:
> > 
> > nit: I believe kfree understands IS_ERR() so you could have a simple "err:"
> > label covering all the error path.
> 
> I couldn't find such handling in kfree(). Could you point be to it?

My aplogies, I was confused by the DEFINE_FREE(kfree ...) for __free(). kfree()
only checks for null ptr.

Although, I wonder if the naming "free_with_kvm_ref" isn't an artifact from
previous code? Nothing is freeed here. So perhaps err_with_kvm_ref? which could
be shorten as this is the only label?

[...]


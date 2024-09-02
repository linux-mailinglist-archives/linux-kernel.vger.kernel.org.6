Return-Path: <linux-kernel+bounces-311434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF0A96891A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC632284542
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C7020FAB6;
	Mon,  2 Sep 2024 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VxQRb2Q4"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B75F1863E
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725284761; cv=none; b=dPJpxLJFgWuiXXv/sTW+89JGMyImh2iopTNE67FpuJ+MolUREf0iITpvFkx8fGV1nVu/8IwY4C+YtYpsp5+Qgof5bwxXw+uupxntPJ100lkg08BD1qHMWayOWnvGB4GVJmeTlbPJCoY5UjemanpndZGiM9TEq2z9cWK77CZFpzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725284761; c=relaxed/simple;
	bh=uYnSy5nGblpu0Q0UqiGyeRUNI6MNALFdJHiDwlpJT0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZF+G4oB/DeFLddT7snDtcavmWcWAX5cRAuXxlTJvXx8Jpih3XUNX/AXWtu3+kfhcXnCrfiL+Y07CKAknf27mMopE4ycuUxyYk+oH+TZvP1dnz6qP4/2u+Ep1cLAWe88SQA1htKYsjBbYqt17mMFYFuSuTk1XdhukqlZU0qdlEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VxQRb2Q4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42bba6a003bso77355e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 06:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725284758; x=1725889558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h0imZkgHwv/FFSZ/weDFaOI5QGpkoprAXSenH7V5Z+0=;
        b=VxQRb2Q4KYNYB+T5qXYa01+0/Uxs8mLZ+bHHI/Y6oDfcviIlvot5Xxjl34PiwTmQBh
         q9oV35PTcitoS0ULtIM+k/dKxh4HexcOKTkT+AS/7lUL7Hx4Niy0pqoBnsBTeozk3sKK
         qsplar/cI0IMdMlBOAGbFNEaUDsIcuufyLttgicPeUgcRqYFHBPwYozFvYpwes+eU3xd
         CjgzaJ1tkbSomcrfLsxkH7cZrV8+6ZqJLu2UorELqKYZnoEH3yYBucGxoCcBS/TiBiXF
         9CGDat9ZCDENh+gY1FF2yFkKqb1XXqDOYhI6ltCSaup+EuFw/KdWvcOlMQOgXpOytLCo
         8U8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725284758; x=1725889558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0imZkgHwv/FFSZ/weDFaOI5QGpkoprAXSenH7V5Z+0=;
        b=fQ7rrokX530kmtKW0MOqFNOhwpYmipHcfWTV5e/BzDL6IKhMr6w7xo4yjeo369ByZ6
         UskperTQgB7vqTfpTLHIrhX8weVRO1OTsREyCxwOrsI8W1DTk/98s7CrA2qbLVuBkAcw
         pZKXlN3JcaU7qhdOQtRLEN4aNr3RB3IqdZZkHocjggSHdIV3L/lB8+l1LGtdoR1w5qJA
         GHJJs/mR5kNXsU/xhxyw8hQ3N8uufte31D9HlH3awhoym2uDvYEO2+60nZI0mLWayDke
         jBObCU1a8rH4Xemd0J4jfLNMjQeHD9TFg64pFLHWM9iZuTElgHOA7YuNmvJ+PY0j3pIR
         YyfA==
X-Forwarded-Encrypted: i=1; AJvYcCWh3mjwx0a8KAAZLL08FTvSV+6GSGCaTjmx38DOnKt1abz6SNYywRePbCMgMUScF5ZbW/wM5zGrSTPBJCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWglTiTc5fywbc41SrM+6oBwltsQsv9BuRC3Ek/xW/F1+6gcT1
	39JrNMM1xVopeLwxYPoqlxPpfRbZh0OB5tzy12RFzfgIP/wVV37bVlFzFT4qhg==
X-Google-Smtp-Source: AGHT+IHfmxWe7A8SIdoui0sTmiBSuRgFc0ExDXB96UvRo3zFmjQuhTAROm1VQW7ctx3emLZKd2x6sA==
X-Received: by 2002:a05:600c:b8e:b0:426:7018:2e2f with SMTP id 5b1f17b1804b1-42c78770e08mr2096735e9.5.1725284758212;
        Mon, 02 Sep 2024 06:45:58 -0700 (PDT)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42c17fed40csm89809845e9.0.2024.09.02.06.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 06:45:57 -0700 (PDT)
Date: Mon, 2 Sep 2024 13:45:56 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Marc Zyngier <maz@kernel.org>, akpm@linux-foundation.org,
	alexghiti@rivosinc.com, ankita@nvidia.com, ardb@kernel.org,
	catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
	james.morse@arm.com, mark.rutland@arm.com, oliver.upton@linux.dev,
	rananta@google.com, ryan.roberts@arm.com, shahuang@redhat.com,
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v9 4/5] KVM: arm64: Register ptdump with debugfs on guest
 creation
Message-ID: <ZtXBlN6nBsEUhQ4P@google.com>
References: <20240827084549.45731-1-sebastianene@google.com>
 <20240827084549.45731-5-sebastianene@google.com>
 <ZtGd9UEudn8Z0IlG@google.com>
 <865xriw161.wl-maz@kernel.org>
 <ZtWdyKtw8EGYlJz5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtWdyKtw8EGYlJz5@google.com>

On Mon, Sep 02, 2024 at 12:13:12PM +0100, Vincent Donnefort wrote:
> [...]
> 
> > > > +static int kvm_ptdump_guest_open(struct inode *m, struct file *file)
> > > > +{
> > > > +	struct kvm *kvm = m->i_private;
> > > > +	struct kvm_ptdump_guest_state *st;
> > > > +	int ret;
> > > > +
> > > > +	if (!kvm_get_kvm_safe(kvm))
> > > > +		return -ENOENT;
> > > > +
> > > > +	st = kvm_ptdump_parser_create(kvm);
> > > > +	if (IS_ERR(st)) {
> > > > +		ret = PTR_ERR(st);
> > > > +		goto free_with_kvm_ref;
> > > > +	}
> > > > +
> > > > +	ret = single_open(file, kvm_ptdump_guest_show, st);
> > > > +	if (!ret)
> > > > +		return 0;
> > > > +
> > > > +	kfree(st);
> > > > +free_with_kvm_ref:
> > > 
> > > nit: I believe kfree understands IS_ERR() so you could have a simple "err:"
> > > label covering all the error path.
> > 
> > I couldn't find such handling in kfree(). Could you point be to it?
> 
> My aplogies, I was confused by the DEFINE_FREE(kfree ...) for __free(). kfree()
> only checks for null ptr.
> 
> Although, I wonder if the naming "free_with_kvm_ref" isn't an artifact from
> previous code? Nothing is freeed here. So perhaps err_with_kvm_ref? which could
> be shorten as this is the only label?
> 
> [...]

Yes, I guess that works better. Thanks for checking,

Seb


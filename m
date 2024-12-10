Return-Path: <linux-kernel+bounces-440215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E25909EBA4F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C214166542
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA4822686F;
	Tue, 10 Dec 2024 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v3wlQzic"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B5286352
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 19:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860008; cv=none; b=RrmGWKL8l4VM9+ZvCpWcargHRJyNiNd2mp+v9Jc9RXRaCZILyUt+feXGtWyafdXGNUR9Aqf1MFA5VJaNIdNrxeChldm0vhfqqnPj3MfhnQEq5B4ftXwSqBKrPjsmsCFLFXPpapz0HTu8FkRjHxfdtTXxcK8xMwQUZjEs72jnanA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860008; c=relaxed/simple;
	bh=n8zO3jKoyxsj6HbTi05UzzHpPoCA3MPc6h5O6atmL3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TksuccO/5FxjV6xM2UNUTE4EiaiuKua90drO2LB6vCFLh0w4FfR4HPEvkRBwpOcnOh7s5ZVa1m2p0d6wYnb46DJ3r0OWCMwULcE0PX/arEfZUqvmi0mfkjxJCy7iuyHApBPgx9p8uW/UiHcGw82Iv4NSg1vuA9EuYUlr7Cn0V4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v3wlQzic; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso893239066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733860005; x=1734464805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A0dTmTZsOI9hQmaca48zwWtaCXiY2ZalD73VTkV/Wfc=;
        b=v3wlQzic4uxAs5vztaqoHapLv8czpNBG9Jqyh5dLndAQWzhHZ65e+gs+u6XAbxIWOI
         2WpPXXHAd3GJv8ujQISC0ZMY4cxl5f3aKZe/lGlh9PrDX/L4oKEhHMbe8Iq0ku2uG50m
         IkcOrJY0xCfUDn28Jty5HyF6bijBINRQ4r66ldmrML9qTFpLxOzfneNcaoBgFa3orkcY
         la3dmfa4/iN+j4IC6ZCvWcRUcie8YzFD5dIt/uiknn+QvipART8a5aVqpzEcJj9+Lv3R
         FmKPPRP4oNAhDkxkdMGYAbBNwtJ8r2a4d1htgbh50qKY/Gi7TnI0Jda53wtchFIk7GhU
         7XYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733860005; x=1734464805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0dTmTZsOI9hQmaca48zwWtaCXiY2ZalD73VTkV/Wfc=;
        b=w9I4lhLm6Njsdaa9e5V0bb/C4838oJjmOHHN1rNr+N1+k7yGuWwUugzhRzDMHf6Tzh
         BKhY8riLv7nRbTmfqwkMSOfHWH0/knzwApSDbcjDjhjErk+6Li6Mhl3yWHf2Byfvyjyr
         8m8yzq3yIzjCBNBzIgvmcpLc79MOQ0J8/cyTUCgPAj3ZASUHHzAWp3vVYO/s93oofNlo
         FEk5Je3viMDlXh6ABRlOM6S6iyXtieCMy2HPBNkQ3JXCIZq1OauqhukHIY/vAEN62btg
         droHQpTCShTKHlgclHHO1a8ESo7S7sUhyAL0AP0EoI9WHBF6ZfeCvE1FQDUztlqjRRhe
         LLjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjC+Asu+metsJmnFX3qQNcfIXR6uvKRQly5ygoPkdMwQJX4SRhKh3lvStOzBBJWMQ/fevg2DA9cJpGF8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9dQsFLQrFoSi2cC0qEXVWmRToX1dNCXUYdUItUrq41RkQYG2y
	Zb2NMf8dtkx8DPvjt7NunbmfAgBsiVWnzV+YUDTpF9dP1craAT6pftQIbPslBmVOCf23LgyQ71T
	DrQ==
X-Gm-Gg: ASbGncvsld00ts04q4LdUl6cus2CJs6PW4X0eVs8lKLPjpnMZkm9vQ966iBPPT5A2VS
	/pSw98SdPonci+zmAaSYii0fpHPb6Rek7DtXDiYZ6HMTA8n8ULpl+kKoeqg5gST3yKjsXH2k0ls
	xUiq5RHTEUkP8QUKaRfrUfQbMBgwXYfglaA8962N4c/hoykBep67LsZaMFC4hasQAoF2m/adzJz
	vwG730xeUJEefUDNoYV16sYQrnry0LhUXKvvsqBFbs714rgDYOMWth+3IfyKDgoLYwkCUUClfOB
	1Tqj5d+VuPvv
X-Google-Smtp-Source: AGHT+IF8OXUsJlvVq2WfJtUgUFxuNR6rqta58L0bNZagCkPdnarHQO7ASCTfCCHZ8UICmUNDGta8LQ==
X-Received: by 2002:a17:907:7819:b0:aa6:ac19:b579 with SMTP id a640c23a62f3a-aa6b11eb111mr4655566b.26.1733860004764;
        Tue, 10 Dec 2024 11:46:44 -0800 (PST)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa692e4e9d5sm296409866b.129.2024.12.10.11.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:46:44 -0800 (PST)
Date: Tue, 10 Dec 2024 19:46:41 +0000
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
Subject: Re: [PATCH v2 15/18] KVM: arm64: Introduce
 __pkvm_host_mkyoung_guest()
Message-ID: <Z1iaof2DgZfZxc4l@google.com>
References: <20241203103735.2267589-1-qperret@google.com>
 <20241203103735.2267589-16-qperret@google.com>
 <CA+EHjTzOjwNyUkS5_zSUiAbiCauLKKgkKU6TM_-+Wsh9A0FdRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTzOjwNyUkS5_zSUiAbiCauLKKgkKU6TM_-+Wsh9A0FdRQ@mail.gmail.com>

On Tuesday 10 Dec 2024 at 15:14:03 (+0000), Fuad Tabba wrote:
> > +int __pkvm_host_mkyoung_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu)
> > +{
> > +       struct pkvm_hyp_vm *vm = pkvm_hyp_vcpu_to_hyp_vm(vcpu);
> > +       u64 ipa = hyp_pfn_to_phys(gfn);
> > +       u64 phys;
> > +       int ret;
> > +
> > +       host_lock_component();
> > +       guest_lock_component(vm);
> > +
> > +       ret = __check_host_unshare_guest(vm, &phys, ipa);
> 
> While I'm bikeshedding some more, does the name
> __check_host_unshare_guest() make sense? Should it be something like
> __check_host_changeperm_guest(), or something along those lines? (feel
> free to ignore this :) )

I understand the comment, but not a huge fan of 'changeperm' as that
sounds like we're only allowing permission changes while we use this
all over the place. Maybe __check_host_is_shared_guest()? Naming is
hard, so happy to take suggestions :-)


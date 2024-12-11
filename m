Return-Path: <linux-kernel+bounces-441136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23B79ECA2A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69ADC160F12
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D07C1EC4E6;
	Wed, 11 Dec 2024 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KXq+rqQp"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96D61A8413
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733912330; cv=none; b=ZNmzmDLcxgsMWQuEAV9nf+AJarOpb9u9m6i5TRzYjv8huZWjH3c3n/tHy4uPM+mOPJj1OalmoLeUUks0hETRVFTIYbncqS6PIxEkLitPmndmiIOapTMB0CP6SYnirkacNdL8mxzbKas7KTKBC/ZQ8Une3nayJt6+EUd3Q8RY5pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733912330; c=relaxed/simple;
	bh=meUvehoP0pPXR9PXhZw/v2e/9k24os0TrmSI4rVMEys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWu8jVzNw5ciXue9Pgk8gYYuGFI2OiR4eLhydeUyjUN3Ie8sbCjtF9i835+mAKrNNav3ddCzzetS06MUx+hx+S0gg5m5+9b31CTMfcLplHBPxR0Gk0jAbAnu4eclks8XbjegncC/z32Qd4rLNYSpYaP1fWLfz/TW9lxfrcl8wgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KXq+rqQp; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa6332dde13so931072366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733912327; x=1734517127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ihYDcY3LWn4CcltGS+7wcqEJGOYARfyiPsaNarrTPi4=;
        b=KXq+rqQpRb1y4iLwn33ZCsTiA/bRrxN/cqlUV+JH1JpA8Nb0sKLY8IGgZjmDO3BYyO
         xwQAsWbKp+G9RtV1HF+9noPY664pym37h1JM8Fq45UyCidwtjSqII2qwOrHd0sn9w09d
         24k028PMEL9NFSBVGBXrHPPMbWjh5VywojMisZXB4JyRrDJjB/emhi2rCNpNcnnTGGC8
         uX0msFG+BE7nivp6c2RNygRxN/9Pk+4lX5ziIiv/wNSvHvngRoMF0r9VjHvcrMJhWKXJ
         A78e6XOMG9+Bbr20VAzJehoXiZxGD+S67cGInOZRs8lZODzKAWNqSvL3DFNHwjOCqhyr
         pm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733912327; x=1734517127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihYDcY3LWn4CcltGS+7wcqEJGOYARfyiPsaNarrTPi4=;
        b=LX0MuT7UjRym3ajGcLXoPSzFXk5Ua60HzZsplC1PuB7UD8Xbs8tHFnD2hQd8GSKZ5c
         5P/pE/ZkRZNo5uzt2JGFIYJKtfQmmpWEs2emfBCKE7LFFAomTHVOnDVjoPANetzU8eSc
         O4Rsg2M7OR85c3T6pPrC3n4zCYH/soCC7BgEquMiRwwKE7+8I18LVGvZTqO1fvsCrchY
         ES2qKBYuvJXjnemZnurefqbc54c95537lpG11SJtRUevK/srWDA4748mcJ5YCKzMYaeh
         7vVcaUaM/h4BOb+bhkSXgFLlokqmN4W2BdFv+Fd5nL/3wGvPtAf59p2tNIotKggnYTwK
         6O/g==
X-Forwarded-Encrypted: i=1; AJvYcCXQhnHDtgplv3BidFvA01MxeYO4xcERK1xwUcueMPmCdPvvDQ80HblP5SUyVBYfh5JhUN6RTZfhSTQ+wio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6lDzRTTOPoAZl/1FUakRp47PJdvgj9q3gKhOQSCAzoALdEDI7
	UuWWLyoLZYrOFtspuwy+DfTJ7Y0p7hwdJOuLqhNIYOfAlwoSNoAoxu6rVAdZKA==
X-Gm-Gg: ASbGnctgliErdsgmjVnmV0uR7L3JE4Q9QzuehVABE7ZWLP5M9YrWhQGIs6QQIp8hzwV
	zzHvixiUE5YgVE8OzLaQ6AoWYnsG+Zly70ijFuWf6EzBJS3hKe5EoOKYoeNEJwnD/HMOSn9MfMM
	GgXJ3WYVfCYJvPu9aTuA2yrPHVN47R2U/n0tRuZPddZVDi/a5fyqviPoKn7U78qHT2Drge2wcfx
	PFq2Q0B5cI/mH2bZRGujZIso5llPpcrNHwhnjo7g3G1muhtcsf5V45PJh/h+ZqyBsuVvIMau8VX
	D8WcQFZMsiQ1
X-Google-Smtp-Source: AGHT+IHm02VkP/5m/qDW5G8yxXRC3oyr+fzt3izQJU/H+8B1ChDswIr+GMq6gipyIZLTGIZO6CUeqA==
X-Received: by 2002:a17:906:3cb1:b0:aa6:66eb:9c06 with SMTP id a640c23a62f3a-aa6b1141c94mr206656266b.5.1733912327068;
        Wed, 11 Dec 2024 02:18:47 -0800 (PST)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa665119a06sm641148666b.121.2024.12.11.02.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 02:18:46 -0800 (PST)
Date: Wed, 11 Dec 2024 10:18:44 +0000
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
Message-ID: <Z1lnBDBNq_PKKN4l@google.com>
References: <20241203103735.2267589-1-qperret@google.com>
 <20241203103735.2267589-16-qperret@google.com>
 <CA+EHjTzOjwNyUkS5_zSUiAbiCauLKKgkKU6TM_-+Wsh9A0FdRQ@mail.gmail.com>
 <Z1iaof2DgZfZxc4l@google.com>
 <CA+EHjTyzh_tqH-M4zSDEQ9meK_W_c-sQDvJ6H4kBd4e_MCmLfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTyzh_tqH-M4zSDEQ9meK_W_c-sQDvJ6H4kBd4e_MCmLfA@mail.gmail.com>

On Wednesday 11 Dec 2024 at 10:11:17 (+0000), Fuad Tabba wrote:
> Hi Quentin,
> 
> On Tue, 10 Dec 2024 at 19:46, Quentin Perret <qperret@google.com> wrote:
> >
> > On Tuesday 10 Dec 2024 at 15:14:03 (+0000), Fuad Tabba wrote:
> > > > +int __pkvm_host_mkyoung_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu)
> > > > +{
> > > > +       struct pkvm_hyp_vm *vm = pkvm_hyp_vcpu_to_hyp_vm(vcpu);
> > > > +       u64 ipa = hyp_pfn_to_phys(gfn);
> > > > +       u64 phys;
> > > > +       int ret;
> > > > +
> > > > +       host_lock_component();
> > > > +       guest_lock_component(vm);
> > > > +
> > > > +       ret = __check_host_unshare_guest(vm, &phys, ipa);
> > >
> > > While I'm bikeshedding some more, does the name
> > > __check_host_unshare_guest() make sense? Should it be something like
> > > __check_host_changeperm_guest(), or something along those lines? (feel
> > > free to ignore this :) )
> >
> > I understand the comment, but not a huge fan of 'changeperm' as that
> > sounds like we're only allowing permission changes while we use this
> > all over the place. Maybe __check_host_is_shared_guest()? Naming is
> > hard, so happy to take suggestions :-)
> 
> I've gone and done it now :) I almost like that, it's the *is* part I
> don't like since it implied a boolean return. Maybe just
> __check_host_shared_guest(), no is?

Deal!

Cheers,
Quentin


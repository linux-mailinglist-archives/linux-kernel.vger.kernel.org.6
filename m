Return-Path: <linux-kernel+bounces-364206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5243C99CCE2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3078B217E4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FFF1AAE2C;
	Mon, 14 Oct 2024 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="LzaSsIXX"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F05F1A76C4
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728915973; cv=none; b=EqJ8w9n56TU+jWbv2eILP1mlf0SC8E4xSUP4izhxURc7G3tZ9PoQtkMHFL/wCbScd+yf2acpI/v3PQ3Xb0uwF2qqPkHKRCUkUS2hmxh6HG3zoAcZCu+I9LW9QMQ09HBHQoHxFbipQFZgezN6zXY1TvWtDTWHQlVCA9iLW2/P2dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728915973; c=relaxed/simple;
	bh=IphyibEvJqicqtn5z2qmf4IvI1HTy/PWUHq69F7X2So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKLBYHwlGN8tXr2nK9QhUepWb35jw5VR1nTJk3dXhgGfVWx4GGUIPRvmofPJXbvOkEI2wGlHcj36kb2m3OJqRKRPBjpTkGWcl/e3KSfnXj0pbQmDX53pNo2F8ZMo7xeX8+E29gHe6xtj5ZP2Ysh82clovC+Bu7pMAqIwaGIJsv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LzaSsIXX; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cbe700dcc3so33902646d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1728915970; x=1729520770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=anv9z4HoBbgTwjW9gAOi/r1vARKs2+DF0HVNB5McWeI=;
        b=LzaSsIXX6nEyuP7sInybmAisBsaZmfs3G4rmY1T/gdsiqEiuZBR3JLGaHHoQmboC4k
         0wIYCfSzCZrUThAYJJWHEelIF3qi5/nT4Btu+Wb3qWP//KOjFdibM+jiuqKKfzTYJWaC
         BIWbvGqXIG/R4sOcPUthcELw0+9TA/fLDiglYpM53mI63l0j9gSB+XoInn/ZaoxKUh9P
         sE2xdQuQ0nj+QczYTF42n0F6n1LkNo4b784DeAVWAI07wIHY1B5l0lWwTaIxt0CZpZgg
         uu6g1ILqILmXZ60jpXxlqAMzdpo/VomPkYgZx5MJDMvM0reu0oQ6k2eYO+lxrNS2oG5n
         MykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728915970; x=1729520770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anv9z4HoBbgTwjW9gAOi/r1vARKs2+DF0HVNB5McWeI=;
        b=Cpmfhjx2kfSCcQUjOqJcnK7mrk3qvbjDnTe7E9uixAWX1d7T6oaOIB7bJokYhlTakp
         b7Y0XSniVC9cD5R+/cVdB60ivmcz45vgtK2MZQKgk6LxvgS13O6aneIGuRU7ukkHOhFQ
         Zo7BaiO9EEr2wQ/aVvM+RJCgXGBZKXx+EuTpzQSZi577VF6uDSG7Y2E8a2nqlAGdc0uV
         buV/loCbPSS6FXIS08J2Hdbm8yBljtEb0W1b/WN/k9yPnbBN4DzpwAj0zcPLJvCcHx08
         x8+576AeOHH8/9Oe6H2vk6E//vKx7G7LwTYwGa4S5fmnydlS2HY5GUggQEVLY0RRLuLF
         LviA==
X-Forwarded-Encrypted: i=1; AJvYcCUAnVUDeXL8wTUvewqTLLcuhtsW96jSaOZg/kAzFkMuIsAQWOfGX5y09vABXRCVp0/zbWxhQwYg8hV9NNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT85kYiFDpDU9jQFNZVeqq2UJQRytMy7K/zgqsHDz+ifRQsbDd
	7buoo4cdSOAczeR91YdaUXz2mY9cMOIHpCDK891ga9p//fwo856bXYLhCNhC9Fs=
X-Google-Smtp-Source: AGHT+IFxwrq0IX7iujFFTia13QSgyyrVvlmERbSC45tKLbajzwfSC6P8rE18RQITkbME9o3sDxgBcw==
X-Received: by 2002:a05:6214:3110:b0:6cc:42d:bb6 with SMTP id 6a1803df08f44-6cc042d0cbamr84258196d6.16.1728915970271;
        Mon, 14 Oct 2024 07:26:10 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85b79f6sm45970486d6.51.2024.10.14.07.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 07:26:09 -0700 (PDT)
Date: Mon, 14 Oct 2024 10:25:51 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: linux-cxl@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	osalvador@suse.de, gregkh@linuxfoundation.org, rafael@kernel.org,
	akpm@linux-foundation.org, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, alison.schofield@intel.com,
	rrichter@amd.com, terry.bowman@amd.com, lenb@kernel.org,
	dave.jiang@intel.com, ira.weiny@intel.com
Subject: Re: [PATCH 1/3] memory: extern memory_block_size_bytes and
 set_memory_block_size_order
Message-ID: <Zw0p7-7ymn-0bPiC@PC2K9PVX.TheFacebook.com>
References: <20241008044355.4325-1-gourry@gourry.net>
 <20241008044355.4325-2-gourry@gourry.net>
 <039e8c87-c5da-4469-b10e-e57dd5662cff@redhat.com>
 <ZwVG8Z3GRYLoL_Jk@PC2K9PVX.TheFacebook.com>
 <d3203f2c-eff6-4e84-80cd-3c6f58dab292@redhat.com>
 <ZwVOE6JRS8Fd9_a8@PC2K9PVX.TheFacebook.com>
 <2c854e5e-c200-4ed9-bf21-778779af7e5b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c854e5e-c200-4ed9-bf21-778779af7e5b@redhat.com>

On Mon, Oct 14, 2024 at 01:54:27PM +0200, David Hildenbrand wrote:
> On 08.10.24 17:21, Gregory Price wrote:
> > On Tue, Oct 08, 2024 at 05:02:33PM +0200, David Hildenbrand wrote:
> > > On 08.10.24 16:51, Gregory Price wrote:
> > > > > > +int __weak set_memory_block_size_order(unsigned int order)
> > > > > > +{
> > > > > > +	return -ENODEV;
> > > > > > +}
> > > > > > +EXPORT_SYMBOL_GPL(set_memory_block_size_order);
> > > > > 
> > > > > I can understand what you are trying to achieve, but letting arbitrary
> > > > > modules mess with this sounds like a bad idea.
> > > > > 
> > > > 
> > > > I suppose the alternative is trying to scan the CEDT from inside each
> > > > machine, rather than the ACPI driver?  Seems less maintainable.
> > > > 
> > > > I don't entirely disagree with your comment.  I hummed and hawwed over
> > > > externing this - hence the warning in the x86 machine.
> > > > 
> > > > Open to better answers.
> > > 
> > > Maybe an interface to add more restrictions on the maximum size might be
> > > better (instead of setting the size/order, you would impose another upper
> > > limit).
> > 
> > That is effectively what set_memory_block_size_order is, though.  Once
> > blocks are exposed to the allocators, its no longer safe to change the
> > size (in part because it was built assuming it wouldn't change, but I
> > imagine there are other dragons waiting in the shadows to bite me).
> 
> Yes, we must run very early.
> 
> How is this supposed to interact with code like
> 
> set_block_size()
> 
> that also calls set_memory_block_size_order() on UV systems (assuming there
> will be CXL support sooner or later?)?
> 
> 

Tying the other email to this one - just clarifying the way forward here.

It sounds like you're saying at a minimum drop EXPORT tags to prevent
modules from calling it - but it also sounds like built-ins need to be
prevented from touching it as well after a certain point in early boot.

Do you think I should go down the advise() path as suggested by Ira,
just adding a arch_lock_blocksize() bit and have set_..._order check it,
or should we just move towards each architecture having to go through
the ACPI:CEDT itself?

Doesn't sound like we've quite hit a consensus on where the actual
adjustment logic should land - just that this shouldn't be touched by modules.

~Gregory


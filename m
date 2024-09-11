Return-Path: <linux-kernel+bounces-325370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0479758B0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC34F1C22398
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEB81B1417;
	Wed, 11 Sep 2024 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SW6kvqpg"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8138619E999
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726073214; cv=none; b=n6jmoIDUA4WIARPOtJbKl1EYhmiini1iwBELx9tWVhnc3IlI7jGCpXk1jG959R7HeIoLCX4UwNlBkLN6wulmyyWCV1SkjZkPJDRxzkodRPcRmuzk7tT8mVNeURUVBUg3aPFeKfs5om70AEBMr947wowRWLvtuYhWh6uD/BgTml8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726073214; c=relaxed/simple;
	bh=v5i3tcMXD82m2UtcDzrNr0/SxRvDW7RqJOHOWsWBNvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qId+saVWjuJypVKuMiz0iWTWrGSSuAlaUP9qZkX8zCSdeBYwicRUFa+nqdmn2VHVpaj2c9LHeGZr7vCcTJ3JVxaXM8L5WuLGaAEo+BpsnzB2cXEoP4hLU9j2tygUVhrIFXPzJ9FdvgeDPUVhqq38DB9AClf2GXZyV678v7FzfVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SW6kvqpg; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a9ac0092d9so2857085a.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1726073211; x=1726678011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eZ0xCLn9RINPzVaUjP7gK7Lrf8o6X9P3y5mlw1qgCZo=;
        b=SW6kvqpgAqxWEewPAt13NCBTz+cL30Kn3D304RqtXF48hL1GV/OVquO1DwIYP+EMDr
         +Bn6AYM6HToh9isxoIG0KRltm7hZtDVm9kGUbrdJ1ODK5XOhLEzmxm3/GQeSZFVSNcle
         aBgVh6UQvLuY9YvLbJgl6BZfiHoMV7IFtys6eogR9nuNmGZay+Qu3wFMOe1cb109lkIK
         3v/zlU71for9pS+g1PCrqCIlE2r2q0kVF4YjAKS0BwWu+Znk1BWoh2YbE0cXUz1VMpsG
         x4gcvmmCBG4L8Y6elb3j+xGA0uBSpecDM6ZgA2LAoeFmMuJMQXYF94s0LTzOcTqp9zhP
         HKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726073211; x=1726678011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZ0xCLn9RINPzVaUjP7gK7Lrf8o6X9P3y5mlw1qgCZo=;
        b=fswIqB4aXEE0myBrfKatT9Dw0+emQFR2crjF+CbEQRa+5y5EbLRr9zhtIlKA8cUiTn
         N5Q05AeleVyHmmcNaz40CD+6vYB4tPXL9rW2349gYZ762cPOfLp4HVEGKe+b5v6izXg6
         ul1MVpBufFQK/uyoJje2arouCDOC0tkgyYbWU+AFZX7MUecfHrh3e1dL2KSuIaE1j1wg
         cZq+abhEHEMym2vYage6B1wVLqZCBQ+as7uH3Xke7QnhNWLKJICkweXgAg7q0kbpFwh5
         ouwZMjabUiGE3YWzw5XORiB2Zxh+KaJl+lbQ3Ttkm8M0hQpHAaY9WthmE/EjmnXB7MqL
         erSA==
X-Forwarded-Encrypted: i=1; AJvYcCWiTaF2Iv9ni/XDiM+av/eMvUZPPnWQo09esbWvgdIL5vzHNwr30UbVhDmo6Ms0ScBVsVUc3jbdIthUUXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXV8yeODOXRMYqicq7APXvhlssqF5DUhIfyQP8EY2MfBpY11rB
	XENnVNLF0E4R/pe+JyP4Qn+UN3wEuRoys9j62EyiLanwhRRHWoKsbg0PPGdHHJk=
X-Google-Smtp-Source: AGHT+IE8IioPFY0oap5Ik4qWQT8uxzCEi9QNcrxryw8pTyfDkJT+rrffjUq7GmwJA2oBINLwWFrFwg==
X-Received: by 2002:a05:620a:40d6:b0:7a9:b618:16aa with SMTP id af79cd13be357-7a9e5ee5348mr3005085a.10.1726073211272;
        Wed, 11 Sep 2024 09:46:51 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7a04667sm440189185a.75.2024.09.11.09.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 09:46:50 -0700 (PDT)
Date: Wed, 11 Sep 2024 12:46:08 -0400
From: Gregory Price <gourry@gourry.net>
To: Ackerley Tng <ackerleytng@google.com>
Cc: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk,
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com,
	rientjes@google.com, fvdl@google.com, jthoughton@google.com,
	seanjc@google.com, pbonzini@redhat.com, zhiquan1.li@intel.com,
	fan.du@intel.com, jun.miao@intel.com, isaku.yamahata@intel.com,
	muchun.song@linux.dev, mike.kravetz@oracle.com,
	erdemaktas@google.com, vannapurve@google.com, qperret@google.com,
	jhubbard@nvidia.com, willy@infradead.org, shuah@kernel.org,
	brauner@kernel.org, bfoster@redhat.com, kent.overstreet@linux.dev,
	pvorel@suse.cz, rppt@kernel.org, richard.weiyang@gmail.com,
	anup@brainfault.org, haibo1.xu@intel.com, ajones@ventanamicro.com,
	vkuznets@redhat.com, maciej.wieczor-retman@intel.com,
	pgonda@google.com, oliver.upton@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-fsdevel@kvack.org
Subject: Re: [RFC PATCH 04/39] mm: mempolicy: Refactor out
 policy_node_nodemask()
Message-ID: <ZuHJUN4GDw7vU3Vv@PC2K9PVX.TheFacebook.com>
References: <cover.1726009989.git.ackerleytng@google.com>
 <9831cfcc77e325e48ec3674c3a518bda76e78df5.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9831cfcc77e325e48ec3674c3a518bda76e78df5.1726009989.git.ackerleytng@google.com>

On Tue, Sep 10, 2024 at 11:43:35PM +0000, Ackerley Tng wrote:
> This was refactored out of huge_node().
> 
> huge_node()'s interpretation of vma for order assumes the
> hugetlb-specific storage of the hstate information in the
> inode. policy_node_nodemask() does not assume that, and can be used
> more generically.
> 
> This refactoring also enforces that nid default to the current node
> id, which was not previously enforced.
> 
> alloc_pages_mpol_noprof() is the last remaining direct user of
> policy_nodemask(). All its callers begin with nid being the current
> node id as well. More refactoring is required for to simplify that.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

> +/**
> + * policy_node_nodemask(@mpol, @gfp_flags, @ilx, @nodemask)
> + * @mpol: the memory policy to interpret. Reference must be taken.
> + * @gfp_flags: for this request
> + * @ilx: interleave index, for use only when MPOL_INTERLEAVE or
> + *       MPOL_WEIGHTED_INTERLEAVE
> + * @nodemask: (output) pointer to nodemask pointer for 'bind' and 'prefer-many'
> + *            policy
> + *
> + * Returns a nid suitable for a page allocation and a pointer. If the effective
> + * policy is 'bind' or 'prefer-many', returns a pointer to the mempolicy's
> + * @nodemask for filtering the zonelist.

Technically it's possible for nid to contain MAX_NUMNODES upon return
if weighted interleave is used and the nodemask is somehow invalid
(contains no nodes, including the local node). I would expect this to
be indicative of a larger problem (i.e. should functionally never happen).

Now that I'm looking at it, it's possible the weighted interleave path
should default to returning numa_node_id() if node == MAX_NUMNODES, which
would not require any changes to this patch.

> + */
> +int policy_node_nodemask(struct mempolicy *mpol, gfp_t gfp_flags,
> +			 pgoff_t ilx, nodemask_t **nodemask)
> +{
> +	int nid = numa_node_id();
> +	*nodemask = policy_nodemask(gfp_flags, mpol, ilx, &nid);
> +	return nid;
> +}
> +
>  #ifdef CONFIG_HUGETLBFS
>  /*
>   * huge_node(@vma, @addr, @gfp_flags, @mpol)


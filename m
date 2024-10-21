Return-Path: <linux-kernel+bounces-374590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8469A6C8F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D055D282B8A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1691FA275;
	Mon, 21 Oct 2024 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lX+2oORL"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A9C1F6698
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729522000; cv=none; b=nqF2XFsPyOCwSV7MuQALTM+GkYftxBl9uKbO9jMDuOVkLJ8J78zxuXVPfmGPEKoQEnagZoWcnqYhjvRi16AqeSMZknyEJ0LKJV4qphE3gPPvEGaItR3xBT3SAC76po6F40g84KXWeBwxuoZPt898PkOex8/Zh+KfCo+A9KvmO24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729522000; c=relaxed/simple;
	bh=NFEW57wJosw4fJhz81851BpImyvdoSNe0DrxK+h+/fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEQnUhCTXa+Ol4rLGbQwyWoXl5OI1ayRkTjh3/0Vmgug40Wd+Q6R3KqBhaTaRbdeB9P1EpIzuDQMcxUkC9PWHJOH21YajDiLCRuah1HtuSNCzyf5yWWt07UpD8khCoCvH1Gi5va/HPCdnuEfxEzigLydJtVxzcYylNbYau1YM9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lX+2oORL; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ebc1af9137so598728eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729521998; x=1730126798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MsDignzYuKlqXw/v8Zg5uk4bZz/6JufrnHpxYgN6eVQ=;
        b=lX+2oORLH1bU+3/ji0V0s/L9AT999UCEGG4SPsz4oIWRXpCeXlcza29CV6V7hksj3W
         QVl3nW4Ytrn1pYKA7T+CIJAXcY+qhqndR9/95FMgFqQZClMF4T0/yP57CVTyvVXHnU/p
         4m3r8/xHix0SUiVLEwB6wJpyxdPebphooiGPGux2zSfnWKrLgnwcJnGKGzQNn6kSeu8F
         wpMYXZI+QFxlLrCedDLpTfMXUiCNcX4ED64RR1ORiLPE/KgOgGnDLn1ToSLi8erWmY1Q
         4++WmKIDwBjTDMRJkFC+zjGxwKs4Zxf3ltmeqOmfZD9MVTfkTus/VKqOmU+/KiMLmz/S
         MVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729521998; x=1730126798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsDignzYuKlqXw/v8Zg5uk4bZz/6JufrnHpxYgN6eVQ=;
        b=VlobgAQ43A2LxZkUhR5Wa4M96W6MviyfQuFtxMLuS2ElAmpctLmsAPRFxwHcMbFuwf
         Zz3UoTBFro/9jCEs/+x43fsMuS3KNPQtX58B7QvqCLqgdaJhsKZRpSMU9OHAQ9ZRcX4l
         QLMhYXR+heZRpw1q6k9DfXSiIPyn2E4d1VltiEuLrvGzNRx0p99EVFcxDrrT3xH1y7uK
         OCkENHYEx10VpDx9xVxhNYXfNvqVrH0UxxSUJw3Z7zUo/jgeg4D3iPDebYVZNSsITpvT
         ogemNmLm3diBDIfkv1R88nZVQR3ilaNXnfA4hL9famZkfqAVp8wHOfud3pWRzUK/aQAw
         Z2bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiW4CJ5JE/5Uif/EyUU+20rwZk+7GB7Ab7mD8szm4khJUFcSt/GiKEJRB6vNeXhM78NPOHSVJAJGS29Js=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfnJ5/hN//sifjH2ci7Kt95xtOR01cE5+HKs4X1ZTxkFCwFFGF
	AOKhb4moZLXjariOfI87p78PREe23nwYDKHHJFuuM0DKbkgrzvWx1mn3cB4svNI=
X-Google-Smtp-Source: AGHT+IH8bF+r1trizhxlQoSSNxbPm2L6fElkRzftR2yQOQVb1awE/KpRqJZ24oBCNJAQNVwu6op3pw==
X-Received: by 2002:a05:6359:5e1b:b0:1b5:e9e2:cbe5 with SMTP id e5c5f4694b2df-1c39e025e0amr247022555d.20.1729521997686;
        Mon, 21 Oct 2024 07:46:37 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a61e6bsm172745285a.77.2024.10.21.07.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 07:46:37 -0700 (PDT)
Date: Mon, 21 Oct 2024 10:46:38 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	dan.j.williams@intel.com, ira.weiny@intel.com,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	rafael@kernel.org, lenb@kernel.org, rppt@kernel.org,
	akpm@linux-foundation.org, alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com, rrichter@amd.com, ytcoode@gmail.com,
	haibo1.xu@intel.com, dave.jiang@intel.com
Subject: Re: [PATCH v2 2/3] x86: probe memblock size advisement value during
 mm init
Message-ID: <ZxZpTlnhYPqg-tGh@PC2K9PVX.TheFacebook.com>
References: <20241016192445.3118-1-gourry@gourry.net>
 <20241016192445.3118-3-gourry@gourry.net>
 <7b877356-f5c5-4996-904b-6c3b71389255@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b877356-f5c5-4996-904b-6c3b71389255@redhat.com>

On Mon, Oct 21, 2024 at 01:12:26PM +0200, David Hildenbrand wrote:
> 
> 
> Am 16.10.24 um 21:24 schrieb Gregory Price:
> > Systems with hotplug may provide an advisement value on what the
> > memblock size should be.  Probe this value when the rest of the
> > configuration values are considered.
> > 
> > The new heuristic is as follows
> > 
> > 1) set_memory_block_size_order value if already set (cmdline param)
> > 2) minimum block size if memory is less than large block limit
> > 3) [new] hotplug advise: lesser of advise value or memory alignment
> > 4) Max block size if system is bare-metal
> > 5) Largest size that aligns to end of memory.
> > 
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > ---
> >   arch/x86/mm/init_64.c | 16 ++++++++++++++++
> >   1 file changed, 16 insertions(+)
> > 
> > diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> > index ff253648706f..b72923b12d99 100644
> > --- a/arch/x86/mm/init_64.c
> > +++ b/arch/x86/mm/init_64.c
> > @@ -1439,6 +1439,7 @@ static unsigned long probe_memory_block_size(void)
> >   {
> >   	unsigned long boot_mem_end = max_pfn << PAGE_SHIFT;
> >   	unsigned long bz;
> > +	int order;
> >   	/* If memory block size has been set, then use it */
> >   	bz = set_memory_block_size;
> > @@ -1451,6 +1452,21 @@ static unsigned long probe_memory_block_size(void)
> >   		goto done;
> >   	}
> > +	/* Consider hotplug advisement value (if set) */
> > +	order = memblock_probe_size_order();
> 
> "size_order" is a very weird name. Just return a size?
> 
> memory_block_advised_max_size()
> 
> or sth like that?
> 

There isn't technically an overall "max block size", nor any alignment
requirements - so order was a nice way of enforcing 2-order alignment
while also having the ability to get a -1/-EBUSY/whatever out.

I can change it if it's a big sticking point - but that's my reasoning.

> > +	bz = order > 0 ? (1UL << order) : 0;
> > +	if (bz) {
> > +		/* Align down to max and up to min supported */
> > +		bz = +		/* Use lesser of advisement and end of memory alignment */
> > +		for (; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
> > +			if (IS_ALIGNED(boot_mem_end, bz))
> > +				goto done;
> 
> This looks like duplicate code wit the loop below.
> 
> Could we refactored it into something like:
> 
> advised_max_size = memory_block_advised_max_size();
> if (!advised_max_size) {
> 	bz = MAX_BLOCK_SIZE;
> 	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)
> 		goto done,
> } else {
> 	bz = max(min(advised_max_size, MAX_BLOCK_SIZE), MIN_MEMORY_BLOCK_SIZE);
> }
> 
> for (; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
> 	if (IS_ALIGNED(boot_mem_end, bz))
> 		break;
> 
>

this is better, will update.

> 
> -- 
> Cheers,
> 
> David / dhildenb
> 


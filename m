Return-Path: <linux-kernel+bounces-374725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C837A9A6F04
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57A23B23B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B751DF754;
	Mon, 21 Oct 2024 16:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="OCjT4gO+"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FE31DACA1
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729526665; cv=none; b=EtOCMNTUNO8suu/xKO1yT+9pxAeEBNw7m3YcB9nRzMRkGleGv3HHjlnbIovMqyy6SBxV/v1kMimPmecfEqprZO/x/4Semfg/6lAEpIjkSdkTre/EEDBih8goh9tQSgfyNkJ9F4WlWMxpKFTwjbgAIWmFt7hu+aPCNrHmCAALR4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729526665; c=relaxed/simple;
	bh=fgBxXU6/mvfxSEzp9Z5Mz10C8iq6DE4jqzKSltRUPVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ncf9VWcv8lTTTkElQQxH1utsUh5ahidEi3wcsyrWeOKLB4LKc8gZysHid/y1H5XTKmJe9qSLby8Qm/VMZfNglIZbeyOvFJUKmaGvpbVrprAb0JxcI/uvvaOIFFdixtbNYZuOgmcK4SkhaGMjIezY1Vp8nAeq51EieKD8ySwmMko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=OCjT4gO+; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b15d330ce1so242817985a.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 09:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729526663; x=1730131463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l84e0UnSnb5/wXRcsEl1eXO6u1LE4VmYmgz6RFMIs3w=;
        b=OCjT4gO+WfiDnOM3STiAoLa60z9lfEK9rQuCCSM4G+KTOg/XBQghr8x1UcELjQY+p+
         eF15xtpLLHKALJsNR1rOhZzdwZC03Rs9RObEEI9yGnaVjbGyCwS+xTo9uj90biPeCSf2
         OxUzV2LTTRKG0xR8SYJL+CzrmAc+opbkvN5zHNs6RhDzwf0Oo3VbP5js6oF4ubd6VFcF
         MEvh77msnmZiu3muh3OgqDOTD3QzPElbQjLQJvIt08TaQYx1tLUob359JeHLj4mTSStQ
         cPQsbEJu9jprMRvUYdv/OpHo1Aqr48Ab4RSVNb+98+MLAFZ9rqdJtYg3mQHvMkZqzA8/
         GaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729526663; x=1730131463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l84e0UnSnb5/wXRcsEl1eXO6u1LE4VmYmgz6RFMIs3w=;
        b=QDQ99UygbXz1V6PfNjohLddWdizH5sYOE2MwqRPPIJYKNyvgWBfU77DO9C1O9/MEov
         zNBjp062R247MhtluFu5zE6L9f/RS/UVGqkhsdUZ+xM/HVU7usSJHQvVRT2egbMnAAbs
         eFzfxe4ED3TO4bl+MJHVPvZ2r+6QGHLKcSmswSw6d8I360CRkrUlYtppewN0A3LzABEg
         cafRVHP6y8msQggKAdk8qco6hFSe1aPgZatd6NNl+uR+Tsd6BhwduyyF8AWuHkua7UOJ
         I1B+mQgdI3znxtZFsI+xI+UXFoTB7X/MyU5qsye1myHnnpYzChWdIZP8JO11LpVM52DG
         jXZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3CPoeC96JLKkefsGzua5pT88/NMS1s228v/2dO6xiQh5YpNMMzYnCZeXWlbKRPsDWucs2/U/Xb46fV+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLBQaZ+E3pBwZs7Je+fcTbLkv6zL1qYqgkIwwcSAo22VQez+23
	+nZXHkRldZpg/LKv2KvsmXVDx0W+z24SBmmkixMpwePSqyCOd9QqNP2YP9CgDjM=
X-Google-Smtp-Source: AGHT+IF6+iVm5LbiJbyoiX1o00pqae4N2gKWe1rpx48Z3dEJTuR25irME1treebcR3ivdgDlUf6STg==
X-Received: by 2002:a05:622a:47ca:b0:458:4e4c:b692 with SMTP id d75a77b69052e-460aed8cb72mr174768891cf.36.1729526662589;
        Mon, 21 Oct 2024 09:04:22 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3d71664sm19231821cf.71.2024.10.21.09.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 09:04:21 -0700 (PDT)
Date: Mon, 21 Oct 2024 12:04:23 -0400
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
Message-ID: <ZxZ7h335O9hgB20l@PC2K9PVX.TheFacebook.com>
References: <20241016192445.3118-1-gourry@gourry.net>
 <20241016192445.3118-3-gourry@gourry.net>
 <7b877356-f5c5-4996-904b-6c3b71389255@redhat.com>
 <ZxZpTlnhYPqg-tGh@PC2K9PVX.TheFacebook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxZpTlnhYPqg-tGh@PC2K9PVX.TheFacebook.com>

On Mon, Oct 21, 2024 at 10:46:38AM -0400, Gregory Price wrote:
> On Mon, Oct 21, 2024 at 01:12:26PM +0200, David Hildenbrand wrote:
> > 
> > > +	/* Consider hotplug advisement value (if set) */
> > > +	order = memblock_probe_size_order();
> > 
> > "size_order" is a very weird name. Just return a size?
> > 
> > memory_block_advised_max_size()
> > 
> > or sth like that?
> > 
> 
> There isn't technically an overall "max block size", nor any alignment
> requirements - so order was a nice way of enforcing 2-order alignment
> while also having the ability to get a -1/-EBUSY/whatever out.
> 
> I can change it if it's a big sticking point - but that's my reasoning.
> 

maybe change to

memory_block_advise_max_size
memory_block_probe_max_size

but still take in / return an order?

~Gregory


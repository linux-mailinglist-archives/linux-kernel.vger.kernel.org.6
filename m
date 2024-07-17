Return-Path: <linux-kernel+bounces-255543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A25E9341FC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11691F21CF2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D175379D2;
	Wed, 17 Jul 2024 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cG1mJRg4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5B47470
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721239832; cv=none; b=VhYGZpCIT16y82o8WRYa9WwCnnq1f/KjC4S6Z7AHlcEofAFiW5H+kITykKWYKDsNjiB9eAmXd+0y/GBJABBGoEK/Wf0uJyuNiI1Eoafm4h45K/RB+Ebb8+h5AKZ7omwfl+g5hIxM6Dh42gAOOcwii2RaL/K2Kjv5WPAyLzRJYq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721239832; c=relaxed/simple;
	bh=69HJCzsP7y7BhzGXRul4nvmZXDVS05XVYhxqbB/Fxfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPkP5Lv7e/i4n9nL3LNWwnvqSz7thcWL8kEjrDlcAhS6T9W7tqHeMq8dT8+50+9OTZlIEpg78+8RWczC/5W+GFDJcVkFysIMllZdpEw8+tTB6nVn27NCDpSjmua9J8BhvVdCTWDDZ3xc2+v9meaGVXRKkwr2jdWIAm/F9qr0Dcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cG1mJRg4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721239829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XdILWDpsCDSoW2G5wLGtJwqP7KLoKEtOgvidIoe0/j0=;
	b=cG1mJRg4IzgCxDP4gXvzRgBEmsruvfxtdFP8VmuFdQqmUwPSFc11kiZnNYHcfmmbRVnGMk
	9vhklGPKKM3TKTS/Rs50nFE3m5iEmMT3p9fc1YZ5/cyWEj7WHfUVBHDPXLw6XgxW3RhUUu
	hFWpdx9Lo0GDmaYuAV7OP0t+1YJ0dHo=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-yC-KdauTNVib-gviSLwfSw-1; Wed, 17 Jul 2024 14:10:27 -0400
X-MC-Unique: yC-KdauTNVib-gviSLwfSw-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5c696b8e759so125088eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721239827; x=1721844627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdILWDpsCDSoW2G5wLGtJwqP7KLoKEtOgvidIoe0/j0=;
        b=KHWFzzLT9ul627n/BqxOk2MSTVN2gV7GuC86KCPmGgTXngzeIhJl4oOzGLXHGFxYHF
         qbiAz4VmV2T1r4jetGH4+iJl/QQQbcH/fSEHTdcP3lbtiYjh+Pplxyle8V00yjJee6Mg
         DwGGuQpBna45uTq1y25967ZOSzrbrzzRaKZqrvdsEXV/uBvSubioZtAgdDme3elD+zjp
         7ILRCVp6AyN2T8ynA3WnhcP1fFyfQVULq/LFFhAPs3dQeH6oAWrEkASnb0woxd17u+NS
         PRRjQf1J8C7ENUK5K+z4lwtGr5eSE22c6h14yrUNgX+d51yJWxMX6AcIDmrcTgyEN5XJ
         P7ag==
X-Forwarded-Encrypted: i=1; AJvYcCXw727hBJHzXrwZwAae+TRx4ZqZhS23wvWHw2JzIyiubbAIFgMVHr9BLP/LPhc+wcqZ0rTk7PJcOTJzqusf/0eP7zf47Kp+CgV7iHrF
X-Gm-Message-State: AOJu0YxY2aBkV9Ju7qeG894un625+fW9rdU51J6t3HgR6j4GBYmqKKO2
	oExbdjNDeIRM06j/jxc4IYPvZduqF9SF1SGyrP0bJgfscUaCrylO5q8K4uE5EajMM7QPqO3sYpF
	S9p1tKo3V4j8QzVO8s0dR54gEhefJT4t2H20ps8f7UER8EWVb6+72xikTqLzb2g==
X-Received: by 2002:a05:6820:810:b0:5c6:6aae:b5f5 with SMTP id 006d021491bc7-5d416357f02mr2270256eaf.0.1721239827138;
        Wed, 17 Jul 2024 11:10:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjcUX1q+2rOEkj/PltU6LP9up/Pim26cnYrvjthRosahbP02nv/53iGAEYPNWh6a3mYWvy/g==
X-Received: by 2002:a05:6820:810:b0:5c6:6aae:b5f5 with SMTP id 006d021491bc7-5d416357f02mr2270227eaf.0.1721239826780;
        Wed, 17 Jul 2024 11:10:26 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b79c4d18f1sm924356d6.19.2024.07.17.11.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 11:10:26 -0700 (PDT)
Date: Wed, 17 Jul 2024 14:10:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	"x86@kernel.org" <x86@kernel.org>,
	"Tian, Kevin" <kevin.tian@intel.com>, Pei Li <peili.dev@gmail.com>,
	David Wang <00107082@163.com>, Bert Karwatzki <spasswolf@web.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
Message-ID: <ZpgJD_LAYomCIk4a@x1n>
References: <20240712144244.3090089-1-peterx@redhat.com>
 <ZpTLCscCFGtsrEjC@yzhao56-desk>
 <ZpUyZ9bH1-f5y5XG@x1n>
 <ZpY5uU2NyOoMVu5A@yzhao56-desk>
 <ZpbDnoQxGubegtu-@x1n>
 <116ca902-103d-47cb-baf0-905983baf9bb@redhat.com>
 <Zpfxm_Nj9ULA0Tx6@x1n>
 <20240717163154.GF1482543@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240717163154.GF1482543@nvidia.com>

On Wed, Jul 17, 2024 at 01:31:54PM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 17, 2024 at 12:30:19PM -0400, Peter Xu wrote:
> > On Wed, Jul 17, 2024 at 04:17:12PM +0200, David Hildenbrand wrote:
> > > I'd be curious how a previous truncation on a file can tear down a PFNMAP
> > > mapping -- and if there are simple ways to forbid that (if possible).
> > 
> > Unfortunately, forbiding it may not work for vfio, as vfio would like to
> > allow none (or partial) mapping on the bars.. at least so far that's the
> > plan.
> 
> vfio doesn't support truncation? Or does that means something else
> here?

Here I meant VFIO can explicitly zapping pgtables via vfio_pci_zap_bars(),
irrelevant of any form of truncations.  I suppose it'll have the same
effect where we may need to stop assuming PFNMAP vmas will always have
fully installed pgtables.

Thanks,

-- 
Peter Xu



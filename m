Return-Path: <linux-kernel+bounces-286757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5FF951EA3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340A01F2315B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A516E1B4C54;
	Wed, 14 Aug 2024 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TS5uH/UV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8873A1B4C40
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723649683; cv=none; b=FETe552vZvDUG/la7PlIffzNI4Mm/uhfIzvlDr9vqdQBUDOtZug0tr+gNagkeZMS7NreQdHwwoGUUkphmRGY0KF9loB11/5JHbsm5nJUeyDDiXNbsTvedC1fKm86MxTLhHOrGiVtClbONrp/1z+IUODxwintet/zrCU2gy7zpPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723649683; c=relaxed/simple;
	bh=ZPBXF/+MELEff5QAxFQnJUQAtBmg2u3E1V+zco4K/vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmYbuwMIIZSS+7WquZS3gKdK/oZhzyqL8EEtEsXqvkIWfcTiBYfz3EeIXf5M9Rlh6j8ybvFgGtaf0YnteI1sp3hpOmVC9yOzfV7XStZgLzFiyRm+hW20SUc/SpNPqKRsKJaNEPlbscnkNmYSGmhMDPOZYcZ8VPTjkVl5mXf7X0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TS5uH/UV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723649680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qd3L17EBGdmTNYKdWop5YhqCOAOZ9OC4Gj60Xq+yFMc=;
	b=TS5uH/UVIhoo1xsqIjyOL1re6F/m4Da5tENHeu/ao6NsoX1NVgYvVklrnNkrJrA+Sh9cQQ
	hg0XhPjOwdvIVtIIhyYGkYcQAQrLHzUwP+fmTL9Ctc7s4Ntvp9DeGvRbwFQa6B69DfY/mX
	aaHoutqs5Gz924JaptRFV98x46DJ6sY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-AAPDsIbIOi2FR7Su5wiJUg-1; Wed, 14 Aug 2024 11:34:38 -0400
X-MC-Unique: AAPDsIbIOi2FR7Su5wiJUg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b79ccc1504so708466d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723649678; x=1724254478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qd3L17EBGdmTNYKdWop5YhqCOAOZ9OC4Gj60Xq+yFMc=;
        b=df8t3c2ej7XjkQ/ctEUKbgUrRIdNwdwHCfh490dO/DIo0IKENwBgr+khvrhlDDD/W4
         6UiYsFWZgskbLjo0aN+0Ep7PyXzRIp6h9AG1z4gBvCPZMmdM2OaOtfNh7Btson+IbNAw
         q+Y+dFi67oMfNhmniZ6GgtD7wB4lhhbu3RpEmSBSlO4S52BGRTFkinnHBoJPonfj0u9M
         3jNhyiRVpDCbjrg+rlzDFsj2a1tiKn1tbH8pCjdOVGqx8tpyw58SjGxE96zrZCWE+G2b
         gtJnGI9b/QUjaFQUW4L54TNDUwfx58CLp0rX7Jk6FBbxYqzQr/VMYHAjnDwega+95h0W
         PqmA==
X-Forwarded-Encrypted: i=1; AJvYcCXAHfMf27tXguti8JeIIaLoGIwfqksatyf3Js8YcydvqUqBV8l3G8sw7LRgV/Bn97WLFB0afj12VZRQc+5+FkBtibRWdLm5fUAGlNJb
X-Gm-Message-State: AOJu0YxgnedFGCvwsbBemX+Yc0KzIWbMa+SLV3h3v+w3bqRM3x/XY3te
	Y74AB8tFfakDabo8np9sCqjH7KuDTbBkKToWdsljFXV/v0z8GmTKgT3bk7N8AbcpG5bKEGCn5gN
	+a3yJssincCQ2OkrFs3mS2ULJbTYQUP4x8ja4tyAMM2VHFVYMGOprQzRitYJr8g==
X-Received: by 2002:ad4:5fc8:0:b0:6b9:5c25:c41e with SMTP id 6a1803df08f44-6bf5d1751admr20508986d6.3.1723649677985;
        Wed, 14 Aug 2024 08:34:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYJFXpQReML2ilodNHAhAn+3jsYwBR7OSYAxKuBRWJs3Oa71h5lhZj6qtdRaoMOC1R9brKfg==
X-Received: by 2002:ad4:5fc8:0:b0:6b9:5c25:c41e with SMTP id 6a1803df08f44-6bf5d1751admr20508656d6.3.1723649677661;
        Wed, 14 Aug 2024 08:34:37 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82ca73c5sm44588296d6.69.2024.08.14.08.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:34:37 -0700 (PDT)
Date: Wed, 14 Aug 2024 11:34:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Axel Rasmussen <axelrasmussen@google.com>,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH 05/19] mm/gup: Detect huge pfnmap entries in gup-fast
Message-ID: <ZrzOi1Xj2gJ2GYzP@x1n>
References: <20240809160909.1023470-1-peterx@redhat.com>
 <20240809160909.1023470-6-peterx@redhat.com>
 <67d734e4-86ea-462b-b389-6dc14c0b66f9@redhat.com>
 <ZrZK_Pk1fMGUCLUN@x1n>
 <20240814124228.GG2032816@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240814124228.GG2032816@nvidia.com>

On Wed, Aug 14, 2024 at 09:42:28AM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 09, 2024 at 12:59:40PM -0400, Peter Xu wrote:
> > > In gup_fast_pte_range() we check after checking pte_devmap(). Do we want to
> > > do it in a similar fashion here, or is there a reason to do it differently?
> > 
> > IIUC they should behave the same, as the two should be mutual exclusive so
> > far.  E.g. see insert_pfn():
> 
> Yes, agree no functional difference, but David has a point to try to
> keep the logic structurally the same in all pte/pmd/pud copies.

OK, let me reorder them if that helps.

> 
> > 	if (pfn_t_devmap(pfn))
> > 		entry = pte_mkdevmap(pfn_t_pte(pfn, prot));
> > 	else
> > 		entry = pte_mkspecial(pfn_t_pte(pfn, prot));
> > 
> > It might change for sure if Alistair move on with the devmap work, though..
> > these two always are processed together now, so I hope that won't add much
> > burden which series will land first, then we may need some care on merging
> > them.  I don't expect anything too tricky in merge if that was about
> > removal of the devmap bits.
> 
> Removing pte_mkdevmap can only make things simpler :)

Yep. :)

Thanks,

-- 
Peter Xu



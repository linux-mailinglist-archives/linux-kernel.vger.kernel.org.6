Return-Path: <linux-kernel+bounces-283629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5A294F70F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460A8281488
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C867F18E03B;
	Mon, 12 Aug 2024 18:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SA/QspGr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B9918953F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723489095; cv=none; b=P/RtAZzFSjKKaYXafqlcgUb0Yn5yLwYk5/5SAbT06P39COCyQF8cQ9dsDpO+HuzfSzLtAVYlddLuFaQ9AWT3GfpRXPz4P/fkT48rkNRR5I+5GMqskew/y/wTgaQJEOjErVMhltItJdEP9uc08i6qZ3aU0bD4kPtHqL8sE81jDEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723489095; c=relaxed/simple;
	bh=LfPOpidqehegUt+tof4iurxTgEAidoDbHKOZE2NlWB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mb6peutcXwnRVujSfhqCx2Y5DxnDxAc1gMtlshvYBY/NfJTsQ6oRulCYVJ2Z8P/+RKrbeLo/i1vTHbSqiK3P86L9N9kxcXlPskrBn65lxcWwud7dJRWth1llm+tAvOGtKgcGccJ4Gjtem5VUU34ituW2w+bc5g1olAVNlZKKl2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SA/QspGr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723489092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CS/foRtcZMYFWa8Ji2iV8cMwHHCfkc9T1S0QgRlZmIU=;
	b=SA/QspGrAn+5OeRX3LupCnXgZF37EB/xbzo+WF0BhiWbvxbpbBkW/DLTqcxPBYrkGSUS/O
	cGMUBeG3Esg1LMWRzwcaQitvdWTO8sFV21PZQUKz3uFwHa0AsfSffdvwuHS46W/Xg5KrOW
	T3MaUD2S5KPqZ1ec7a7+fek0gY01Jyw=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-OwiND_znMImpyCYZ5Ela8Q-1; Mon, 12 Aug 2024 14:58:11 -0400
X-MC-Unique: OwiND_znMImpyCYZ5Ela8Q-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-4f5111f666fso204223e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 11:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723489091; x=1724093891;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CS/foRtcZMYFWa8Ji2iV8cMwHHCfkc9T1S0QgRlZmIU=;
        b=B75VrNEJZQx2XrHDEwZenH1hS9Ib9XjbFt0QnQ1z2wOyW9TCf1NzQSocpWDFuHpwvv
         V27jkhYoWbVS+CUmkAg5Jvo3taiBvdhHPDbZ6195aDiU489zptqGZcBcC5WP7kSfwR8B
         2fAqHM58n/5uCrazvruO9NYEsd7OK6y94tlflHVUAncJ8xEay8D47sZCvHOJS51t5C94
         qdI4hmN5P6NB5itwhuJn98ejuRh9aEbjg6VIOM3PGdfun9hMgF+Lq9xJQzoc2rzoVdtW
         bhiuEL7FgOtTlCQlPA+/D5Le7ANnk4ZZUjs4uU5+jl4IJlDlfoNGgDXqybFLlCxIsKA9
         NW/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7kWtG/Go+DPpvW1Jj6VP6X9Nwnb63OzH21DZBU1gu6BBNkhrEtct2m296Z14zrZeoD698OOZgp96OGdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YypFDzcE0M4e+he3+XBNAF3kmNrD3x0xmp1tYwNP0v1LMB1Ofwi
	AWkcAXazDIXfygWFTe5GwNT+s8JfK7wPltdivJHC9W+yu9VrWdXOCkhpy1N/PLsI7lZEpFQ3HDc
	zBByNT6JLneEaXbuOIvQSvWyTcv/R2pDtPfZxsTb0CXaM9MvQJNzBUtbmsrAvYw==
X-Received: by 2002:a05:6102:509f:b0:48d:aced:abff with SMTP id ada2fe7eead31-49743942d92mr923690137.1.1723489090936;
        Mon, 12 Aug 2024 11:58:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEepDCRiassfXhH0DrId4yrgbBwPcT6rwZlyon1JDzVmoNGkXNaVZAYMSjbHfXIwNLjo/ZC3Q==
X-Received: by 2002:a05:6102:509f:b0:48d:aced:abff with SMTP id ada2fe7eead31-49743942d92mr923659137.1.1723489090577;
        Mon, 12 Aug 2024 11:58:10 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-841367f32besm801295241.40.2024.08.12.11.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 11:58:10 -0700 (PDT)
Date: Mon, 12 Aug 2024 14:58:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Borislav Petkov <bp@alien8.de>,
	David Hildenbrand <david@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH 10/19] KVM: Use follow_pfnmap API
Message-ID: <ZrpbP9Ow9EcpQtCF@x1n>
References: <20240809160909.1023470-1-peterx@redhat.com>
 <20240809160909.1023470-11-peterx@redhat.com>
 <CAJHvVciF4riGPQBhyBwNeSWHq8m+7Zag7ewEWgLJk=VsaqKNPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJHvVciF4riGPQBhyBwNeSWHq8m+7Zag7ewEWgLJk=VsaqKNPQ@mail.gmail.com>

On Fri, Aug 09, 2024 at 10:23:20AM -0700, Axel Rasmussen wrote:
> On Fri, Aug 9, 2024 at 9:09 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > Use the new pfnmap API to allow huge MMIO mappings for VMs.  The rest work
> > is done perfectly on the other side (host_pfn_mapping_level()).
> 
> I don't think it has to be done in this series, but a future
> optimization to consider is having follow_pfnmap just tell the caller
> about the mapping level directly. It already found this information as
> part of its walk. I think there's a possibility to simplify KVM /
> avoid it having to do its own walk again later.

AFAIU pfnmap isn't special in this case, as we do the "walk pgtable twice"
idea also to a generic page here, so probably not directly relevant to this
patch alone.

But I agree with you, sounds like something we can consider trying.  I
would be curious on whether the perf difference would be measurable in this
specific case, though.  I mean, this first walk will heat up all the
things, so I'd expect the 2nd walk (which is lockless) later be pretty fast
normally.

Thanks,

-- 
Peter Xu



Return-Path: <linux-kernel+bounces-568937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62446A69C43
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE9B8A13B2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2752B21C9E8;
	Wed, 19 Mar 2025 22:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhBC3rG8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04CC1E521A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 22:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742424405; cv=none; b=h+X/F7hjZoAxhK4q8owJ7I0h5C4y+/u6SRpDJ9XRhP9gAiIajAe4paUhwQgS11CCErGLRuuy8ol4KKP8ohSIUq/u3ekpUhQboqSfrXBOnr1axbYXZ5gwrpIAJy9E+dozAQ8d/aMTvRJiho8prAWacLzAI0FZJ+VGF0IGCa87kqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742424405; c=relaxed/simple;
	bh=bWwwTw53iGMdQjWhFpPpRcdxkNkBr9cpl6cenki4Ur0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1pi67dzXlP6cYT5TApe+zgyq4EJNFPFGW9Rtc6w7430fTCSnmziIlwhUkAYH67McpQ6DKLciDm34csRExU30eJyeo3kBh9PyLLy/FAYPaW5CXPGMSYO/8EQA48aiIVf3bQv4WYVyNSxorLpWTvIRCjy/Gp59NBhrTzRuFUSVeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QhBC3rG8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742424402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Axll5Mi+5wEaWyklP7NmIivlU8IChwyIqobsotZaqY=;
	b=QhBC3rG8cmAwUuiItBR34NUuTrw7CTbt4fmvG3VVuT1kiQdVDZ7wQkuJeeLOtwOgqKfyJK
	CDKcxNpj+767wPRU4PpPJ5BdtbqWI0aSKzSLK9KKHC+4iXYPNL15RBnP70X4Mp+kO7JZcy
	9nwNK+gkuzxleA1VRnwWpIMueAcquq4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-N-3D-D1zMFGH7JQ_CWMNOg-1; Wed, 19 Mar 2025 18:46:41 -0400
X-MC-Unique: N-3D-D1zMFGH7JQ_CWMNOg-1
X-Mimecast-MFC-AGG-ID: N-3D-D1zMFGH7JQ_CWMNOg_1742424401
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c543ab40d3so33366385a.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742424400; x=1743029200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Axll5Mi+5wEaWyklP7NmIivlU8IChwyIqobsotZaqY=;
        b=qHrQKs1XlHS/kEFpbjP+LUW/nUOU9zDSc4D8m1o5NYeVIFjVx1noghS9AU74bEZ3Q6
         4Aye/17OC8Z8pughrx8zynYk9BCuxz/m9ojw6dfY3oO/7mEvO5ESIDpBbxfEh17/Qk8k
         /2KIi0dbk1Cq6jjkpnH022YNRn7fdG8neBvHuaWgJjW3zX4jlKSWWdxdcrZhlcvuErrp
         uj7VFNxIxaxDxqMuKHz+tTyozQ5F7KUOpiM1HopLyCP5RwSDdk3aZVwYtQc93xA8xiKi
         Me69yD8ZKoV3o9nwHoCRcZ4NcJR/f0cgpO8581aTaq5Ue5Shd2e1cSmB5Y03ENlhvQfF
         TfyA==
X-Gm-Message-State: AOJu0YzwRZidEY5URsVnAXW+cPVgVkGjhlROdN5f5yPVCK3JVEzWKaTl
	8O+zQmR0sujrgxDabOJTjjb8jhDcbSxdNa1j0XKAyxIPv3ofCvMW9iBqm1QfOIC7m/zjRUl4eiK
	5aWlb4aeFtPl6PcvK7vw/+tKJbCQkxGqY5zD2F8Ukk4jvXv+G8VwWAA2SGTYU5g==
X-Gm-Gg: ASbGnctMimhUDZTnOL+XilyL5MZvCt2sN4lvb7aLTGU8uWWWv+Q+TdUHdCaCwRqWsoZ
	g3MGEwGHCI0toB31M2Gi4d8q4bsfo6GrzB8QzLxQeSA+K9PBgAmNhyNUsq7NiZ0i9NSnPsnyJrt
	jlt+1EhAv/QbZLe3eA2nJFMWC1Kc4sRr3Rv5VTxNxdnTXXIKzCXYVR7nivNxQWUlYTzNmepyvzy
	KPKbr8jhr1HUOlkPpmw98yR+S/AspOsERlNoQjC/AwE4Y9KCl8IMVV4sCwGOkNEy5s8iCXs0ZdI
	sETK9r0=
X-Received: by 2002:a05:620a:46a3:b0:7c5:3b52:517d with SMTP id af79cd13be357-7c5a84d9048mr821828385a.54.1742424400695;
        Wed, 19 Mar 2025 15:46:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHVqyT+WlTFMbuzlij17W/8zZbsASQKuVXERgdl8uzrUKPSgGPykK/7AJobATtMc4xtw1MMQ==
X-Received: by 2002:a05:620a:46a3:b0:7c5:3b52:517d with SMTP id af79cd13be357-7c5a84d9048mr821825685a.54.1742424400401;
        Wed, 19 Mar 2025 15:46:40 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d6fbbasm920353785a.78.2025.03.19.15.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:46:39 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:46:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Gavin Shan <gshan@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alistair Popple <apopple@nvidia.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sean Christopherson <seanjc@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Jason Gunthorpe <jgg@nvidia.com>, Borislav Petkov <bp@alien8.de>,
	Zi Yan <ziy@nvidia.com>, Axel Rasmussen <axelrasmussen@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yan Zhao <yan.y.zhao@intel.com>, Will Deacon <will@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 18/19] mm/arm64: Support large pfn mappings
Message-ID: <Z9tJMsJ4PzZk2ZQS@x1.local>
References: <20240826204353.2228736-1-peterx@redhat.com>
 <20240826204353.2228736-19-peterx@redhat.com>
 <Z9tDjOk-JdV_fCY4@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9tDjOk-JdV_fCY4@kbusch-mbp.dhcp.thefacebook.com>

On Wed, Mar 19, 2025 at 04:22:04PM -0600, Keith Busch wrote:
> On Mon, Aug 26, 2024 at 04:43:52PM -0400, Peter Xu wrote:
> > +#ifdef CONFIG_ARCH_SUPPORTS_PUD_PFNMAP
> > +#define pud_special(pte)	pte_special(pud_pte(pud))
> > +#define pud_mkspecial(pte)	pte_pud(pte_mkspecial(pud_pte(pud)))
> > +#endif
> 
> Sorry for such a late reply, but this looked a bit weird as I'm doing
> some backporting. Not that I'm actually interested in this arch, so I
> can't readily test this, but I believe the intention was to name the
> macro argument "pud", not "pte".

Probably no way to test it from anyone yet, as I don't see aarch64 selects
HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD, which means IIUC this two lines (before
PUD being enabled on aarch64) won't be compiled.. which also matches with
the test results in the cover letter, that we only tried pmd on arm.

The patch will still be needed though for pmd to work.

I can draft a patch to change this, but considering arm's PUD support isn't
there anyway.. maybe I should instead draft a change to remove these as
they're dead code so far, and see if anyone would like to collect it.

Thanks for reporting this.  I'll prepare something soon and keep you
posted.

-- 
Peter Xu



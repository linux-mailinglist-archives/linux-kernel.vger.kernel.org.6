Return-Path: <linux-kernel+bounces-286777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B389C951ED1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C82BDB232A5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3891B5811;
	Wed, 14 Aug 2024 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISF0kBo5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCDB1B4C42
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650195; cv=none; b=sk3JytKyJHWsY8x6nsBDdfY9zMksicPBTIu+Z4jsSJznw+csIwES7WIIY0acdgRah0Gxg7fcm1PHHwYmXXMfvI4IDUbZgjCmFKPYSDlT+fT1FaghtaCwYOczYfg4xhA7WSIBGDX32xOehJyFzT4e+P22cP+egCfltYYse5qFjrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650195; c=relaxed/simple;
	bh=5jNNP4J3iRDusoNj6f1v6htvMRdKOmxlTHHzIfa/yOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijS8QAtmC53vTYgmBJLOXaqLUOtg872zNKuD+6qKsOJK2SMJkxLUvVXKX87SON0GEhTwVRyUzx9WuOW1wPD5S8Qfuqhr3fRbTiWb4gj5wtyBdKdBk6szj4i5Xu3O2YpOhYxwjirEAuX0zx7kxCvxddrLF2+w1oaBusfL98TdjxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ISF0kBo5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723650192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wp3RgWPkdUCFzuPHgIrGTTZ3GUOXugzLWnj/fmKQBpI=;
	b=ISF0kBo539jLEWcAPnCvwkworbu+GGOnbD8d6392qPlKMsEMu+ICcOjngXvvWTVOyMalwm
	PkRXDNHae99exBxInXY/oNAyWEurTNYcFmn6q4ltQZj68igrxdq/UGGcU/H4OaCU5yaeaF
	X4eBkZ3mZb5x+W3h5O3xtoksDRD3jn4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-S8aoYJSTOf6U2MpxYQKw5A-1; Wed, 14 Aug 2024 11:43:11 -0400
X-MC-Unique: S8aoYJSTOf6U2MpxYQKw5A-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6bf6a978302so723946d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723650191; x=1724254991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wp3RgWPkdUCFzuPHgIrGTTZ3GUOXugzLWnj/fmKQBpI=;
        b=hty/GSTZn3BiNv4CKsED7/ma2m7Wh4CZBsL6xlkR2SbWJJRVr90pVto1a865tvCl7O
         ItSIlIlHaFjCV3uMBzapZusoOgkbBSSr6BNUV/VooqqtUWz3nDs7m3UF35AObJe3vVPj
         DrwALWIoyvcle4V4hy9DLWSuEO2c5Xz3wuGKxgh6ybyqLzhAK/GlMpxzdfFPz285MnIB
         NxXzMtE2cM4w0GBCnmcgmeq7AI11IP21YSJcei6jsdejVa3/KMuOX7Xg/zbAqlcds77O
         H34YQ9jnPAf5Jwm0bqEY2uOroEorcv4CXzR9wmAqGvt/xXQDjEu8h7k4U6ceVsWJnWKM
         oSrg==
X-Forwarded-Encrypted: i=1; AJvYcCUEkeZkBNFmw8nHYBzWefq3jOCAR9MvyWvdxLNmfUPC4ONzA+ypp8C5CiQAf3U0bU8ONzZXuKO29mCH51gTTlf4yo2imIl0fEC/Vzdx
X-Gm-Message-State: AOJu0YzU5t4B4ClHdoePt/JoApXItjQmMaEUXY2CJWeFbGd8D94aSgrj
	hD+JJwJ6tTGhfVuyaAmQNRwNGKaaPQQWXOVU9kre0Hr+j7qJ4ITcLDaLyAPKUDnhj8ARr2mKib+
	vYlH0uhl0lNzqJxb/rmEzzaTqjYkNDsd+m1Y3WBW6359NPI7yKHT5Go8mNGFkyw==
X-Received: by 2002:a05:620a:3704:b0:79f:44d:2b8a with SMTP id af79cd13be357-7a4ee3907bdmr238903685a.5.1723650191073;
        Wed, 14 Aug 2024 08:43:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYXNGxrMlqiMBIZ5ST7AxhHtA/FbXaG+GaqvRqPuCV6WzqEPOJp/I4t+RerfXsa1wlbiNflw==
X-Received: by 2002:a05:620a:3704:b0:79f:44d:2b8a with SMTP id af79cd13be357-7a4ee3907bdmr238901485a.5.1723650190692;
        Wed, 14 Aug 2024 08:43:10 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7e051d4sm448353485a.123.2024.08.14.08.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:43:10 -0700 (PDT)
Date: Wed, 14 Aug 2024 11:43:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
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
	David Hildenbrand <david@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH 08/19] mm: Always define pxx_pgprot()
Message-ID: <ZrzQjEJG3rEZhLTE@x1n>
References: <20240809160909.1023470-1-peterx@redhat.com>
 <20240809160909.1023470-9-peterx@redhat.com>
 <20240814130915.GI2032816@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240814130915.GI2032816@nvidia.com>

On Wed, Aug 14, 2024 at 10:09:15AM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 09, 2024 at 12:08:58PM -0400, Peter Xu wrote:
> > There're:
> > 
> >   - 8 archs (arc, arm64, include, mips, powerpc, s390, sh, x86) that
> >   support pte_pgprot().
> > 
> >   - 2 archs (x86, sparc) that support pmd_pgprot().
> > 
> >   - 1 arch (x86) that support pud_pgprot().
> > 
> > Always define them to be used in generic code, and then we don't need to
> > fiddle with "#ifdef"s when doing so.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  arch/arm64/include/asm/pgtable.h    |  1 +
> >  arch/powerpc/include/asm/pgtable.h  |  1 +
> >  arch/s390/include/asm/pgtable.h     |  1 +
> >  arch/sparc/include/asm/pgtable_64.h |  1 +
> >  include/linux/pgtable.h             | 12 ++++++++++++
> >  5 files changed, 16 insertions(+)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > index 7a4f5604be3f..b78cc4a6758b 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -384,6 +384,7 @@ static inline void __sync_cache_and_tags(pte_t pte, unsigned int nr_pages)
> >  /*
> >   * Select all bits except the pfn
> >   */
> > +#define pte_pgprot pte_pgprot
> >  static inline pgprot_t pte_pgprot(pte_t pte)
> >  {
> >  	unsigned long pfn = pte_pfn(pte);
> 
> Stylistically I've been putting the #defines after the function body,
> I wonder if there is a common pattern..

Right, I see both happening in tree right now and I don't know which is
better.  Personally I preferred "before function" as it makes spell checks
easy to match macro/func names, and also cscope indexes both macro and
func, so a jump to any of them would make me look at the entry of func.

I'll keep it as-is for now just to make it easy for me.. but please comment
if we do have a preferred pattern the other way round, then I'll follow.

Thanks,

-- 
Peter Xu



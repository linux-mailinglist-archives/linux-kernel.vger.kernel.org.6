Return-Path: <linux-kernel+bounces-285148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCFD9509D5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF3D281810
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407241A2C02;
	Tue, 13 Aug 2024 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWwo8k9x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D03F1A256B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723565177; cv=none; b=ZBX2nHt6PTN5ZEXnobPnuzC35tDO4zJnfD1vfflP1m7ZgCao/dDTdxzucR5uHPjsjkR4JiM3yMG09Bj5N+3PImMh1NqcNN9uysmJSnKPjAi6dL1Gg4Dugtbu/rSltBRKqV200/y764sMYLDKoDubnbD44NQLRKFtuIO4PDct7ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723565177; c=relaxed/simple;
	bh=2NCEv6hUIsh8tZhTMKpZg3LUw3cbUAt7s7S1FYZYFw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blXqe4qUPl2vmZCL5PNEQ2lHZReRI+O9+P0ByBNO1Igl+HuEZCSvR4LEKPM1Lt89c5uKbWyfes3vlhLdgGCituGyd5QvDYtK+yrxiSGBbERgQygL3OHoNMQPg8rYbXztaVN3TBJYlQ6mrZSWsQYXFpppjwQsgYfKX9a0I0laeWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWwo8k9x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723565175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ngm8li87jva0MeGPwBLbq3/xV5MA2uvy1j63HC/7xUw=;
	b=XWwo8k9x2UKtWzNq24M9sWF93v4ee2PnrWh7k4XJRxFShrzZK9HPjRe/uAdJYzF28hVAZC
	hZ3CXR1RuDFOOW4JSUOfOBLEjOtNEyxewnQz3fp2piFqnc1CUp2XZXTKoePmQPpnfsDp/o
	WOQdBa0Dq55Kad3crcwE3j9bNs23rZs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-w6niKfvlM9Wef04-jBN4ug-1; Tue, 13 Aug 2024 12:06:13 -0400
X-MC-Unique: w6niKfvlM9Wef04-jBN4ug-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b95c005dbcso15581336d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723565173; x=1724169973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngm8li87jva0MeGPwBLbq3/xV5MA2uvy1j63HC/7xUw=;
        b=TawuA1Ti2sUh10pgYZvcZ/ujeyM5kTQZq5N3TSXRlPX1vBql1emoUNLmkceak6OQzW
         ynEv2+Xp0sgFfCeBsDmHxy1VxJv16bdku3kjwySB5qySC9aCnEE/2vrZOUcDgog9Z8jj
         VuCyIAQuST2KNdgqSNx60uFpwcmDHVcJgpJp6FlkWBkOH/J8m3AmTRq8rOFtldmRFzhK
         YP6hu2UZeUzfqSXWgTHfP/uQcxiRn46WHnaAXdfTI6VOe9BAWl4vFGrubtfeH89YhRJn
         L3oJldG4e3tjLdGg4OlPTFqHGlYDivamusJBBlhyAR5lK4GlEXZ3NyqqfEO/AEzKk1Yg
         nCXA==
X-Gm-Message-State: AOJu0Yzf+bvReuSl7WYBciJBv7op7F62UVf07PFROBauXw2S5XrKaarW
	eOQB0F+GgxH/WPiA6wJp1tu1YWKTyOcs2AkvcT23TPyMx4quo46+RP0hs/pacCLtyMJhVD3LZ+V
	NlXZ0h93BhRS37z5HOFwvACfOx1W71IO+Yic3GvR4b7xfhq1P0ZqX5hm1tur3MQ==
X-Received: by 2002:a05:620a:29d2:b0:7a4:cd97:2f88 with SMTP id af79cd13be357-7a4ee310ce2mr6339885a.2.1723565173432;
        Tue, 13 Aug 2024 09:06:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGbZLztqXKfgxfdmDtb4eEPXUZcOYPJmJftY5UJc57FF2tbxPHB7ckCU0WLlZvmNEOA/klIA==
X-Received: by 2002:a05:620a:29d2:b0:7a4:cd97:2f88 with SMTP id af79cd13be357-7a4ee310ce2mr6337985a.2.1723565173024;
        Tue, 13 Aug 2024 09:06:13 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7df5690sm352320985a.96.2024.08.13.09.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 09:06:12 -0700 (PDT)
Date: Tue, 13 Aug 2024 12:06:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Huang Ying <ying.huang@intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Hugh Dickins <hughd@google.com>, Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rik van Riel <riel@surriel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Mel Gorman <mgorman@techsingularity.net>, x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>, linuxppc-dev@lists.ozlabs.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Oscar Salvador <osalvador@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 0/7] mm/mprotect: Fix dax puds
Message-ID: <ZruEcHS3Yk1O9ovI@x1n>
References: <20240812181225.1360970-1-peterx@redhat.com>
 <87plqc1tab.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87plqc1tab.fsf@mail.lhotse>

On Tue, Aug 13, 2024 at 10:50:04PM +1000, Michael Ellerman wrote:
> > - Power, as no hardware on hand.
> 
> Does it need some specific configuration, or just any Power machine will do?

I am not familiar with both dax and power to be sure on the hardware
implications here, sorry.  I think as long as one can create some /dev/dax
with 1g mapping alignment (I suppose normally with ndctl) then it should be
able to hit the mprotect() path.

One can verify first without this series that it could trigger a bad pud,
then it'll be away after this series applied.  Meanwhile the mprotect()
should apply on the 1g dax range properly.

Thanks,

-- 
Peter Xu



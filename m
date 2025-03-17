Return-Path: <linux-kernel+bounces-564593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B98D5A657EC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE41F3BAAF8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A9719D8A2;
	Mon, 17 Mar 2025 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wX9qLPx+"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047D2188580
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742228680; cv=none; b=My6BPISX7O+R/sVnXUa9JDH+7YM1bpjg5HUgJyQTg/Yg/lAlf+YmFTEklL+0XFEco3b3xx9qslD+8CX2VAtuKg52S1oENPrU8Hiv9gr89CdblQb6nALWmiCa63xnCTJQLM3/3MHfnuDJYeWx4RvQRyBzBM0KN8+tMWDCg8B8H2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742228680; c=relaxed/simple;
	bh=CRQuOClBF8ibkmyDXePtmQydx5xAqg/cjacNlYfXZD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9GxEiD9YhtToUhw5CMXx3Dlv6ckH1BtBcshlKmc9pM5JJlrvXBfiqZYCyJxBvBHL808/k9PG8SQJOx9MvBiVVmogogHzn7kpRJ9PY2HuqfTBgfTYmrUwrimkV/oD78DL2Y1Mn5G8lzULggZbAHyQ9q21xG3tBYzUcEyHj4lMaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wX9qLPx+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4393ee912e1so11115e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742228677; x=1742833477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eMt6/0rjATR1bwi+k8yOxA+2RImgBsoWOOfOgx1rzkI=;
        b=wX9qLPx+2TS/AF/6ns3xXUuRtQbLR3BdeH+H855cxpZ6KGzDKyAF+N4QoRrQrAFJm+
         KqT8q6SwdH0WMeSmewaE3gbQCUE1xNe+QBJPmKQQJTiWHvKsdWNtYpjkR2KWwHcFZizZ
         11zfaUszF8Dx3vEJl6ttnUjtKvZsUP0oH/O1h4cpmp0kCQpehLUEYcw9aARptW+ewmSb
         n2A7p5Vcb4ysFiN4dxgn+/akBxXpCtgW4LlFKe6qCyB1pzUkX0M8XHXsbYWlNxQ5L74Z
         jVzSGNIY7luDrs2r5PWxtOZuiEtbXUxkm/RMKBPWrebkPd57U+A9qsf9D5H5pQ/YPcl8
         xkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742228677; x=1742833477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMt6/0rjATR1bwi+k8yOxA+2RImgBsoWOOfOgx1rzkI=;
        b=JsEaN8q2ds/egxRAOGz2oXfEuOAwYWUVvH5JnTlXQ6fdtreTwraftafl//vCNVwnHr
         ReDQQq0rANqK/1GulbH6iqTN/8TH9IScH6RdLujT/RMCTogHwDLo9IJAWtvgfVJJ8ns6
         yH01iDPJ80BO9CExcFKlYnJdxvbASfS7yrt/2+lcuMavfw+lp7pZRqpciQcI985ynRIu
         kayeWRbPcqp1oBhnkAwHRi1Df/NTXRAIIbrA3YgkVVUqdCdJCuffUJrzl950qItJrx8o
         UU5acAtFhVtITJv4chuQp2MwBok0xkj3aJtqVGJb6TDUzyezZKjifaMk7J00yBypEejD
         m+kA==
X-Forwarded-Encrypted: i=1; AJvYcCVzcJO9hU48fF55B5YZzyWIFqY1Sq37g7aMqMj+K51fQBTiyCROAz4f83BiGRHfqDSXXsBqk8JlNj+6GzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YydAdNUxndH6mQzo64hVqZmaWDvB/WE4ntiINgCrMak7VI/MqOd
	WXb+6vXaBaSN4pdBZjDB6GiOOYSdLtKkyIiDxzxE2FYmEtArgUOCVHU8k4RFjw==
X-Gm-Gg: ASbGnctpoJmcNh664cRoRjkc7zEQNT19dxTs4ybsgycuHPYKOmjBOcfxCjOXmx11mWV
	VVafMq8HBBgDCxmrxk6mUzJuaDeaqV4IfWs9jNwdA5FgD6CPE5DqPM7LTlJ+6PpEkwyHrhSNDAP
	2oCdcnavRbaGUtsr3I8DiVLrV87fV+8d5nlRs03gLkr43UNIgTpiAVwGPQ25kDzxvRlQgyiTRtU
	wTgt2wbS8QiH/hqlb7AsuDsDUtWCaYOh8BGsdIwipOT7akMF/5+iOdl8beSsAMXJa1LCDE7RgLu
	dq6b9z/4xNqrsveAW3AsWHYD0vUFWG/aQX1f99ozBxbKcmE4LrYrYRgqsrGgqG15TWCfgNqyWy4
	wTW13PWI=
X-Google-Smtp-Source: AGHT+IGX5F8BK9hIkJUun+RN+il0mFnmZHmhTvWuj/uMAcNnReRivdqAzP6qycjzG9REqfRUJe9+/Q==
X-Received: by 2002:a05:600c:5cb:b0:439:961d:fc7d with SMTP id 5b1f17b1804b1-43d251f35edmr3260325e9.6.1742228677084;
        Mon, 17 Mar 2025 09:24:37 -0700 (PDT)
Received: from google.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df385bsm15243985f8f.4.2025.03.17.09.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 09:24:36 -0700 (PDT)
Date: Mon, 17 Mar 2025 16:24:32 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Rientjes <rientjes@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>,
	Junaid Shahid <junaids@google.com>,
	Reiji Watanabe <reijiw@google.com>,
	Patrick Bellasi <derkling@google.com>
Subject: Re: [PATCH RFC 02/11] x86/mm: Factor out phys_pgd_init()
Message-ID: <Z9hMwC-GKoRLaHWw@google.com>
References: <20250313-asi-page-alloc-v1-0-04972e046cea@google.com>
 <20250313-asi-page-alloc-v1-2-04972e046cea@google.com>
 <Z9NYyW_CMoL008cK@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9NYyW_CMoL008cK@google.com>

On Thu, Mar 13, 2025 at 10:14:33PM +0000, Yosry Ahmed wrote:
> > @@ -771,15 +770,29 @@ __kernel_physical_mapping_init(unsigned long paddr_start,
> >  					  (pud_t *) p4d, init);
> >  
> >  		spin_unlock(&init_mm.page_table_lock);
> > -		pgd_changed = true;
> > +		*pgd_changed = true;
> >  	}
> >  
> > -	if (pgd_changed)
> > -		sync_global_pgds(vaddr_start, vaddr_end - 1);
> > -
> >  	return paddr_last;
> >  }
> >  
> > +static unsigned long __meminit
> > +__kernel_physical_mapping_init(unsigned long paddr_start,
> > +			       unsigned long paddr_end,
> > +			       unsigned long page_size_mask,
> > +			       pgprot_t prot, bool init)
> > +{
> > +	bool pgd_changed;
> > +	unsigned long paddr_last;
> > +
> > +	paddr_last = phys_pgd_init(init_mm.pgd, paddr_start, paddr_end, page_size_mask,
> > +				   prot, init, &pgd_changed);
> > +	if (pgd_changed)
> > +		sync_global_pgds((unsigned long)__va(paddr_start),
> > +				 (unsigned long)__va(paddr_end) - 1);
> 
> This patch keeps the sync_global_pgds() in
> __kernel_physical_mapping_init(), then a following patch adds it back in
> phys_pgd_init() (but still leaves it here).
> 
> Should we just leave sync_global_pgds() in phys_pgd_init() and eliminate
> the pgd_changed argument?

Oops, thanks. IIUC we only need the sync_global_pgds() call in
__kernel_physical_mapping_init(). We don't want to call it a second
time just because we mirrored changes into the ASI PGD.


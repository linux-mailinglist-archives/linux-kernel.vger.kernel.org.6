Return-Path: <linux-kernel+bounces-187761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAC88CD7F9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601E81C21CB0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EC51EF1D;
	Thu, 23 May 2024 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODf4A2fx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AF61CAA4
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479974; cv=none; b=lOth+4XWOpnIYjKF2YotzdI4bqOyQjA8gqc8uyFJlzn83UKyrqt3mrzNlNFwBdM/O+C0CQMANsqP+W1t8ICGaV9pQPtiqkIFMLdKZIUEOmeLVDcUbYNiJgGJC9JMiSPPZQtezlL16ZHncsmkH9Pk0Q9XsjqST9CylRXqNEBcemI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479974; c=relaxed/simple;
	bh=pA/B+a/y3U9ldxjseVE8egOj7d/OGgdF6dVVS7fWRkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoGXMLBgRY3um6WRSA9InjSQz8bq3I51J7NDbvPMmi1pDip12I0+u2Ek9StJW/cz3fAtC+6tD2fpyfnA3R3YlCUA00icvcvDqQCK/3hC7z5sUnHGfp7bDgStccA8EIc4HwqgtIGOsmuX6+DZp5gVBA/dhtUBzzVQ3WuYC/1MAow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ODf4A2fx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716479971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SFW+xu7QNxeGwrYT708qIRdLA+B0NE1DkW6W5XAywxE=;
	b=ODf4A2fxz4AIDdvXSSz+uLVIIbLr3S3qsiV/BocXp25D2VY90cN3HwwbYvB1CsK4CQyy5a
	phXaie7B6VZApKR9tB1WlsSS7WSbtPB8+XJ/5JG0xPDCU6xvXu9sEkaWaqcwG89WvCJqCi
	nwfNSWyseAPdXQM6PQopatMcXtDq25I=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-hV64mq9wMRyCLDXq9MY4Yg-1; Thu, 23 May 2024 11:59:30 -0400
X-MC-Unique: hV64mq9wMRyCLDXq9MY4Yg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6a0dc98ce3fso294766d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716479970; x=1717084770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFW+xu7QNxeGwrYT708qIRdLA+B0NE1DkW6W5XAywxE=;
        b=K2poT1lgJgSdlIUHtEu0Rg1SW8iZgIdh9pC/EPtuha4MsfNRghZaj5yxcoFM6Cq9Cd
         cQ31RqyJs6zfyU73d6SX5EO47yZDc/Nd8YJwrVPTOEmOaSyW/zT0Ke9l8sqe5rqXY7jY
         m1Wx8+PA8bOz+BAI4/YnxBYP2Xx1WJ6zkut6vdRN1P+LH34kl/mCDmUKq10WsCCTY4bv
         vhmxXkuR93GiATXjBkED0lLNrq8jhevwqtF1VDKCu2GUQWxo0Wo4R2i5vwaCVK6tZumU
         C7CdroWUAEQs5Ny9XqAcy09NeFmjEUAsgJDI4hdIpmHZ3iekSriOWpkaWkp1fhBq66Fe
         Gk3A==
X-Forwarded-Encrypted: i=1; AJvYcCUAmJKHky2xLZI0vAyFmHeiznP5fXXW9mrIVakDAv0jXVtQq2Qe1fmHoQwxv9zTDEQkfyuPslLlvCeRAlUn4Tf153DEjEViIIN+H5FX
X-Gm-Message-State: AOJu0Yx2pyNjgfEpQJQgQvlOyb2cwJB4GUB2UuFc6kmcty3zIZAA5cCt
	+XjygDGWjqtwaQK+lqjn3+ea/5p2N27mqzNvGBNFW4vpOxzD/ZWNp3k46EgWRs75roYWdAcNHCA
	enKy5pg7d1Y5bDFxtUKJ3IiuvXNvGPXUFedLro/SkOEB3nhxezpkCl9l+Des1OQ==
X-Received: by 2002:a05:6214:2484:b0:69b:1c5c:28fb with SMTP id 6a1803df08f44-6ab7f19ec6amr55473356d6.0.1716479969665;
        Thu, 23 May 2024 08:59:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfEZ/MxR7kXEObGm96kXld53lPLAn57DT2wv2+Ejd7pVHUF2vvfPDOcD/zLRIDa0eVAMCLMw==
X-Received: by 2002:a05:6214:2484:b0:69b:1c5c:28fb with SMTP id 6a1803df08f44-6ab7f19ec6amr55472786d6.0.1716479968823;
        Thu, 23 May 2024 08:59:28 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f17960csm144178206d6.25.2024.05.23.08.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 08:59:28 -0700 (PDT)
Date: Thu, 23 May 2024 11:59:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: Axel Rasmussen <axelrasmussen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
	Ingo Molnar <mingo@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Liu Shixin <liushixin2@huawei.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Muchun Song <muchun.song@linux.dev>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2 1/1] arch/fault: don't print logs for pte marker
 poison errors
Message-ID: <Zk9n3aXbOufWpAhn@x1n>
References: <20240510182926.763131-1-axelrasmussen@google.com>
 <20240510182926.763131-2-axelrasmussen@google.com>
 <Zj51rEwZeSK4Vr1G@x1n>
 <ZkPJCc5N1Eotpa4u@localhost.localdomain>
 <ZkPY4CSnZWZnxjTa@x1n>
 <ZkSMv31Cwx080no7@localhost.localdomain>
 <Zk5noUEYI4lknyJy@x1n>
 <Zk6zLRimo6Q6ZrwM@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zk6zLRimo6Q6ZrwM@localhost.localdomain>

On Thu, May 23, 2024 at 05:08:29AM +0200, Oscar Salvador wrote:
> On Wed, May 22, 2024 at 05:46:09PM -0400, Peter Xu wrote:
> > > Now, ProcessB still has the page mapped, so upon re-accessing it,
> > > it will trigger a new MCE event. memory-failure code will see that this
> > 
> > The question is why accessing that hwpoison entry from ProcB triggers an
> > MCE.  Logically that's a swap entry and it should generate a page fault
> > rather than MCE.  Then in the pgfault hanlder we don't need that encoded
> > pfn as we have vmf->address.
> 
> It would be a swap entry if we reach try_to_umap_one() without trouble.
> Then we have the code that converts it:
> 
>  ...
>  if (PageHWPoison(p))
>          pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
> 	 set_{huge_}pte_at
>  ...
> 
> But maybe we could only do that for ProcA, while ProcB failed to do that,
> which means that for ProcA that is a hwpoisoned-swap-entry, but ProcB still
> has this page mapped as usual, so if ProcB re-access it, that will not
> trigger a fault (because the page is still mapped in its pagetables).

But in that case "whether encode pfn in hwpoison swap entry" doesn't matter
either.. as it's not yet converted to a swap entry, so the pfn is there.

Thanks,

-- 
Peter Xu



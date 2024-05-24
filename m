Return-Path: <linux-kernel+bounces-189199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AB48CED0F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 01:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22417B21AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 23:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259A1158868;
	Fri, 24 May 2024 23:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COUqFr0Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B88127E1E
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 23:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716594954; cv=none; b=U4MUf9AzGJ44rd41xPANxa1/2JvHLMtKVF0bzUT8o257PY3ZXYVUTd3AseNWfJuJ2/xFPyKNpOxwevHtbapPzsFb4TYvks9YGm6SptCmNnYcNMQVQt7Mq6lpQst7bGeyIM7ct3EH4psYbvzIsfEbcM9DWC8F5i3Eo5awOo3c9ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716594954; c=relaxed/simple;
	bh=a3jcCbe/OzG+Nq7WbdaOP74sPcHqUzdvfoH3c9Qiuo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJL7Spyc4/UENG5QiBIwrttPi4ZCqnx3pLEz3ag/4g1i1CClCyvHJjYlMIZ2i63wea3d1qvUgHK5h/n8DQ4D+WEOiVo4h+RHpOnDQAHNpgfCORgUs9YI25BLbTLT0SU0QBgHvuBk723Q3K++tXJg5u+QaEXi//w2aBXEfo4TxTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=COUqFr0Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716594951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SJYbdmLwWG2mW4WyVnckXu838LCXN0AwY1i3rf08V9s=;
	b=COUqFr0QdSBwHl/z83RolW3Av+d6my9qE4aTseu4XCCKC0dWsTDUyc7HmDPB2rGey2yoH5
	/mDrtGvK2PCN1lBvIgkron/1QpikEHPE7dbXtl1CMZZCqj2/hhCnOqSW/JrJD528c+fGpL
	KF0j5+zOUbmCkFYvnfJMMysRVKw8Fcs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-nvl4330GOQS1SQZIdVS3AA-1; Fri, 24 May 2024 19:55:50 -0400
X-MC-Unique: nvl4330GOQS1SQZIdVS3AA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6ad5ebfaa68so3621916d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 16:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716594950; x=1717199750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJYbdmLwWG2mW4WyVnckXu838LCXN0AwY1i3rf08V9s=;
        b=dFBbha4LaJXozWOKhJXgyNcBV6HQ1AAEyrQeo0NKNPCTqEZZ3g5M4CTI1mBT+SDoeD
         r/1OyKuDpmVP69x0jbYySxbiNL+NS3ApShqiU8sec3XCHzvSoJh4coZZnTJZmpTND6p7
         +IOI4xEH1zOjLrYlgghy++6stidOPwAfFL8gaGg2e6pQMmB+ddudjbVix3qxdVHSi4Tq
         zNjLceJqV9s+OzC1fQbfJackiAQO+rSzfjUig94ybwzMCmsGwxwIWd5+x2dWJc/SsNNh
         /CfTzD2o8bku8v3d87Lk/6JSbW19/377y86XRq+5431AKI8xeJDKJF0e47mqjqXhYP/K
         yxDA==
X-Forwarded-Encrypted: i=1; AJvYcCU7QvOUQWYB29Esv7XwsED+iuOJB4L3MgOWSpQXt5fIkjs840jTHGBjdEq2ybaLn15+MxA3p6ZPphFzINdEL0TEVrAidWLPm6kj01MP
X-Gm-Message-State: AOJu0YxuwpooSZG6aVvfjj4jzRf0FBfFLj74ROTmsDwNZesO2/I/D+4a
	2CUeV84H2SURISJh6xto6i/tm0CnXv7sBuC1BH6F4rdXDGo0rDgTiid6Gn6TbVmeVhnB3GE2fZQ
	VMCRqkfZDu0omHSLvAaJtiEFuij6e1cHZPoYH4L1XxysS1HIzaP0+M1001apn7A==
X-Received: by 2002:a05:6214:c29:b0:6ab:8df8:b90e with SMTP id 6a1803df08f44-6aba272986amr37784166d6.0.1716594949776;
        Fri, 24 May 2024 16:55:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnwu5aSfI6m6qOi3M0v/dTrcCZEiAFepKlQxx7tBpg+46HqilMzOzDa69f7l/GkD1vqTrGcg==
X-Received: by 2002:a05:6214:c29:b0:6ab:8df8:b90e with SMTP id 6a1803df08f44-6aba272986amr37783976d6.0.1716594949087;
        Fri, 24 May 2024 16:55:49 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac162f2f35sm11667776d6.77.2024.05.24.16.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 16:55:48 -0700 (PDT)
Date: Fri, 24 May 2024 19:55:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Mike Rapoport <rppt@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Michal Hocko <mhocko@suse.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH RFC 2/2] mm/x86/pat: Do proper PAT bit shift for large
 mappings
Message-ID: <ZlEpAoNRIc1sh-xE@x1n>
References: <20240523223745.395337-1-peterx@redhat.com>
 <20240523223745.395337-3-peterx@redhat.com>
 <f19f63ba-c436-4e39-ab86-78c80b1af667@intel.com>
 <Zk_MGmfYsY9dt2Uo@x1n>
 <7b6b6430-0237-4512-b99b-9eb815b3dc68@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7b6b6430-0237-4512-b99b-9eb815b3dc68@intel.com>

On Thu, May 23, 2024 at 08:30:19PM -0700, Dave Hansen wrote:
> On 5/23/24 16:07, Peter Xu wrote:
> > Probably not..  I think I can define a pgprot_to_large() globally, pointing
> > that to pgprot_4k_2_large() on x86 and make the fallback to be noop.  And
> > if there's a new version I'll guarantee to run over my cross compilers.
> 
> I guess that would be functional, but it would be a bit mean to
> everybody else.
> 
> > Any comments on the idea itself?  Do we have a problem, or maybe I
> > overlooked something?
> 
> I think it's probably unnecessary to inflict this particular x86-ism on
> generic code.  The arch-generic 'prot' should have PAT at its 4k
> (_PAGE_BIT_PAT) position and then p*d_mkhuge() can shift it into the
> _PAGE_BIT_PAT_LARGE spot.

Right that's another option indeed.

It's just that I found it might in many cases be better when we have the
API separately properly and making the pairs matching each other.

For example, it could be clearer if pxx_mkhuge() does exactly what
pxx_leaf() would check against.

PS: I hoped it's called pxx_huge() already to make the name paired with
each other; afaict we called it pxx_leaf() only because pxx_huge() used to
be "abused" by hugetlbfs before.. now it's gone.

The other thing is we mostly only need these knobs for special maps like
pfnmaps, am I right?  OTOH we use WB for RAMs, and maybe we don't want to
bother any PAT stuff when the kernel is installing a THP anonymous?

IMHO having pgprot_to_large() is fine even if only x86 has it; it's really
like pfn tracking itself which is noop for !x86. but I'll follow your
advise if you still insist; I don't really have a strong opinion.

But if so I'd also like to mention a 3rd option, which is to have
pxx_mkhuge_prot(), fallback to pxx_mkhuge() for !x86.  That'll make
pxx_huge() untainted for x86.  I'm not sure whether that would ease the
same concern, though.

In all cases, thanks for confirming this issue, I appreciate that.  Let me
know if you have any comment on patch 1 too; that one isn't a problem so
far iiuc, but it can be soon.

Thanks,

-- 
Peter Xu



Return-Path: <linux-kernel+bounces-255411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A9E934072
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E471C227C2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE39181B99;
	Wed, 17 Jul 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUVrYDJk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC7D1CF8A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721233828; cv=none; b=rVBCHCM10PTTu27xlNpl5CuMzIM1xoO5UeY3DX+S0DgyZzayobFx9dlWMbMHSJfqNDHeZzDA25+CdZLDsDJML4r3CA49sgdRe1QDZFcwEmxbRW5AQdVlb/qoI68XWhgrECgwHpHJ70F223OrqVaeBKx6zHtSQfjsv+hZssixTZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721233828; c=relaxed/simple;
	bh=w2n3Vgmvps7jjndE3MWCxj/E3tyGzjZJwg1FQN0vKk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clzz8ncO6U2qdAVWY36iuSsRIQXT5UDHICX5u5kooR/65lBMefGgCeGph8UT/WAh7ZaKEZJeM4tvirKfoJLvD+UwDXfxYFWZaZhAHtoMwfpiDlqgh8Z+If8ZgMOS3e02YYahcPN7EcS7++i4hRWMS6ENy+024HloYLnVfL3f+kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jUVrYDJk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721233826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3oN/JgUpAeNpSBhsnKTF40nLK+IG9euM6Vd2RnlyDAU=;
	b=jUVrYDJkw1GBpFRBb2/8B57V4kw72kR8VtcABOi5baGQiQHyRchH/WmszzCbr9NRQjRPrV
	AFv4x4nDU8dWkX0LLjiadKL/lxWqghaKlr/RR/l+UU1qBCMVPHpqAdeXb/yX8kXw4KmXsE
	jMKS7gyPdGKaqqzIktPCH3pMkUAaScA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-95RBWAKPPfq6TtEWGkEZqg-1; Wed, 17 Jul 2024 12:30:24 -0400
X-MC-Unique: 95RBWAKPPfq6TtEWGkEZqg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-79f1764e192so32216085a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721233824; x=1721838624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oN/JgUpAeNpSBhsnKTF40nLK+IG9euM6Vd2RnlyDAU=;
        b=h5liyrGP+M5wZxQgsjy03C1PFmZwkG9DVaT9zlEz1m63NNVEPCLbVriRycQ0sSMSr2
         1ZJWuRTWeAuvWqBsVtYtfzk/L1+bdKMOvUt6ROI6mdOlW0pgS8PMYSTv3bNn7rgMWtBB
         fTh0JqF1P36aPuDAa33UIFw+/ttl58gcVzPNbFn0GDobKBl8FnzfLfybR+boEWcsrGIA
         vwzxDs9/OkKqlJU1yh5apez9H8h5sLnXkcBiX6tb+GZ71Qv5/cAyz21ySoW5aZj5AhZ5
         RjZ2hAHFKaOhfns/mk4mhVQDuAFq1/gyKwu9674wOSs1nNSZ2GJRQ6rszYH5EUPA1R9u
         LPEg==
X-Forwarded-Encrypted: i=1; AJvYcCW0cKlaVi3J0bjs/Uljv0drpHc8tc2SG+SktxtsOy1ssrpDV6/2NXVTQY1DrA8x3YhdGuQbk3F0J5ga/9RxfjjGj+lFYoa7haGMu3lx
X-Gm-Message-State: AOJu0YwsgVOdM6L08FoChKsiTq/vElN7Wo+4L5M6vrSKv+Lm+xRQHl9w
	SCi/HfFOidAqsJTaVm/2IpxHeizbTpyJIkSl2GFAczDkOcCbchhwx7h6bZL0I4cLQj6LolphXI/
	c6yI9qFkNVXEA+ZtQE/pFwJ0PBL7TbVceFIZWHtaIjeKtKg+vEwgx825PEXSteFYP0anZKA==
X-Received: by 2002:a05:620a:3915:b0:79f:78a:f7d6 with SMTP id af79cd13be357-7a1873fd9f6mr164211085a.1.1721233823783;
        Wed, 17 Jul 2024 09:30:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZhiVPRZh1L8OYuav3xxhQDxfwMVfDLy2Xc6dLe0gwbayV0cYW4eoXe7iXRBoQX0xhvyBaCQ==
X-Received: by 2002:a05:620a:3915:b0:79f:78a:f7d6 with SMTP id af79cd13be357-7a1873fd9f6mr164207985a.1.1721233823214;
        Wed, 17 Jul 2024 09:30:23 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160be5e7csm419700685a.63.2024.07.17.09.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 09:30:22 -0700 (PDT)
Date: Wed, 17 Jul 2024 12:30:19 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>,
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
Message-ID: <Zpfxm_Nj9ULA0Tx6@x1n>
References: <20240712144244.3090089-1-peterx@redhat.com>
 <ZpTLCscCFGtsrEjC@yzhao56-desk>
 <ZpUyZ9bH1-f5y5XG@x1n>
 <ZpY5uU2NyOoMVu5A@yzhao56-desk>
 <ZpbDnoQxGubegtu-@x1n>
 <116ca902-103d-47cb-baf0-905983baf9bb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <116ca902-103d-47cb-baf0-905983baf9bb@redhat.com>

On Wed, Jul 17, 2024 at 04:17:12PM +0200, David Hildenbrand wrote:
> I'd be curious how a previous truncation on a file can tear down a PFNMAP
> mapping -- and if there are simple ways to forbid that (if possible).

Unfortunately, forbiding it may not work for vfio, as vfio would like to
allow none (or partial) mapping on the bars.. at least so far that's the
plan.

-- 
Peter Xu



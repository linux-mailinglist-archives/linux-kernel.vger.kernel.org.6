Return-Path: <linux-kernel+bounces-255546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13903934215
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17F92830E6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A34183070;
	Wed, 17 Jul 2024 18:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AqkNAQLB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DCE180A9E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721239975; cv=none; b=LJgd2I3riyFF/PZnMeCBLZSirEkQZxQIJn97Gbqpdk1M5YofwsoqP3/lNJXNqozWZ1IiTpvs/0OPVIVT7kIJX/KBVzW2gC17aVZP2/t8ixtrj78lOs//hpPWh3b5eTCxh0XFH9n17Ize2E5eG68Y1YIst/CfgyyaytM9ITM3aYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721239975; c=relaxed/simple;
	bh=JqPCP4S0R8SrEpgbNH0yOOLVM4+X91udfOe89qax964=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EM7fteOUvMhgm1Zyhydi8FbOuLaFtKWMKxm/FfNhkXzV71nl0wIntPizYs+UQ+2A2ldizIQMuG9Q6IBfT20cd7QTLehyt4m2IkBcM2/OSWpa9ZVlajL/TsKU11jMW2U7pPqxLIGsNfnkU8elO65vygBW0rSlk7/ngNYa/Y88pl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AqkNAQLB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721239973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y76R49bWtHKdHs4PrirCvLHoiKYGnV0bukEYgnfcBm8=;
	b=AqkNAQLBSRlWepD4Hp4Ng0XyrRwibV907opao6Cb1Yw/mZqvhuJXRiwFGZk6MDpIsTW4a0
	9S3UaCzgg7GiGcfMHDJAw8fXQZg8hk0tJ//yqg2yE8ZbFb4oyiiT05XfzkQyeYafGuoUoa
	t6hvFksqrtlR656JmpZYEKMndpU5gf8=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-gN5NpCh6OmKZGh5apBNk4A-1; Wed, 17 Jul 2024 14:12:52 -0400
X-MC-Unique: gN5NpCh6OmKZGh5apBNk4A-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3dad655810eso898b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721239972; x=1721844772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y76R49bWtHKdHs4PrirCvLHoiKYGnV0bukEYgnfcBm8=;
        b=teUYMcxRfrWeyQpgi+LStAHHwOyKP9blLMJKLwtgUM42EebM+GAZnOzsYGl2QxOFpf
         KHucsG9C7EsnJS+KrL05ImQIvnal4LzTW+oweDlpcKyXeX5EGJ6CZXTFBgEWLVPhD01f
         PomFVOeKQBm0nsnEKDAHusoXk3QBewX/5uZut1IflsAtUhsh7BimKbswKKUsC6NOhhCZ
         WkzCbXI5fk/XKNi6FpdEwZbnHNox22rZSq+hObKUTACKe7iJgZfLeoR8Kfda/M/ipXI2
         S6SxcBIkHcDbgOOfIY5buPH8nLeAx/RFHmZOQ+5OUxU0e2VjFdzxeXE5d4IUEvTK+OXo
         6urQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4cgzu9CPZnieEiFWLERfQaULI73PYe4L2F3KS434arhFuwQzJJJvFNX81dohcJyGK157Gzyf3bSWp1UPd0L7GBanh2TN+4VTbefcY
X-Gm-Message-State: AOJu0YxLjlcmgV3ersK6xVApnEEFscw1/egWDLwGoOVhZAvZYMrUykfF
	Upw47i5CAVc+Sf6nVqU0tKXwJzThb5U33a0Bucy/ObHwd0mpqPDHoTTfpzl1FgtrYTwFfkFnXG2
	N75CBuVC5bbYKS2WB4F1YYADRPBnvWg59LypNJo8mqvXwQAmdPS9ZGUr9zpB43w==
X-Received: by 2002:a05:6808:2389:b0:3d9:2e52:5c49 with SMTP id 5614622812f47-3dad51d2644mr1075641b6e.2.1721239971699;
        Wed, 17 Jul 2024 11:12:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsmnwZD/bRbzexRsD9CdbMIJZwteBUMlCVRq0+0J/hRmzSTiI6gNxELyB7YbL8v+CehC7/wg==
X-Received: by 2002:a05:6808:2389:b0:3d9:2e52:5c49 with SMTP id 5614622812f47-3dad51d2644mr1075623b6e.2.1721239971401;
        Wed, 17 Jul 2024 11:12:51 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b83606asm50621701cf.70.2024.07.17.11.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 11:12:51 -0700 (PDT)
Date: Wed, 17 Jul 2024 14:12:48 -0400
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
Message-ID: <ZpgJoMC9sgUb16CH@x1n>
References: <20240712144244.3090089-1-peterx@redhat.com>
 <ZpTLCscCFGtsrEjC@yzhao56-desk>
 <ZpUyZ9bH1-f5y5XG@x1n>
 <ZpY5uU2NyOoMVu5A@yzhao56-desk>
 <ZpbDnoQxGubegtu-@x1n>
 <116ca902-103d-47cb-baf0-905983baf9bb@redhat.com>
 <Zpfxm_Nj9ULA0Tx6@x1n>
 <1dc7cf79-4c01-4b1e-be33-49eb2bdb9238@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1dc7cf79-4c01-4b1e-be33-49eb2bdb9238@redhat.com>

On Wed, Jul 17, 2024 at 06:32:05PM +0200, David Hildenbrand wrote:
> On 17.07.24 18:30, Peter Xu wrote:
> > On Wed, Jul 17, 2024 at 04:17:12PM +0200, David Hildenbrand wrote:
> > > I'd be curious how a previous truncation on a file can tear down a PFNMAP
> > > mapping -- and if there are simple ways to forbid that (if possible).
> > 
> > Unfortunately, forbiding it may not work for vfio, as vfio would like to
> > allow none (or partial) mapping on the bars.. at least so far that's the
> > plan.
> 
> I think vfio should handle that memtype reservation manually, as you
> proposed. So that shouldn't block that IIUC.

Oh, so maybe I misunderstood here.  As long as we can live with VFIO's vma
(with the pfn tracking on top, but without pgtable installed) I think it
should be fine.

Thanks,

-- 
Peter Xu



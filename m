Return-Path: <linux-kernel+bounces-534814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F450A46B72
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3D916B7B4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9B9256C74;
	Wed, 26 Feb 2025 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYcheDTj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D332561D6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 19:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740599684; cv=none; b=XNEGIlp5eXJWhk0jEU8z6a+B93N9qHViHpBwOAO3kJjKezpaerMdOFouaJpTvMrU386jiFdjrP48kokW4IlY5nMTxAjcDUfy2aW26Mk4m+kEG/XOIQv0NeKMEhTsCoqs0Z6aRLnoifVDSQ8U+FcJY3vwSfkYI/CXzqrmTmzuBJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740599684; c=relaxed/simple;
	bh=I1DgX0bKdJT4CKwl7qSHDNaLttfQs1tX87g++C7xQIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpGcAtWamENqpw87e00Kr2TnVcV36medi4fx+0/FkCNz7MvjD46xMuUqH7e626ug1JDGA01auntdz5uuJUUlbNcNjaWENqePTofTqDIZFcuWGlg65XXuQKa70aKJv1KUdiGCuPsPp7mbrpvsZlPsggJlNRuVMRTj0Oo/RIUTIr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BYcheDTj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740599681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=REreCuTx0gkwci3At+fSClZQOC45yVa1FO0Hyxdtpqc=;
	b=BYcheDTjU3wRdwrX/Nt6rAQHIMAdFtk388nKQO+XlNbXgBGxigKoZSLHa69GGIfOdfbixH
	DQlrpqBUu8sWPWrWz2FK51RUvTr/ltON8pEsLu+seWTrsbGF8z8ucoVGvxZnB19e5S7kjo
	uXYWBMsyiyrT1lI4kYy6Z3jjEagNm4c=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-s7tZUTHOM16naVeClbSVPw-1; Wed, 26 Feb 2025 14:54:39 -0500
X-MC-Unique: s7tZUTHOM16naVeClbSVPw-1
X-Mimecast-MFC-AGG-ID: s7tZUTHOM16naVeClbSVPw_1740599679
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-855b7b526fbso2737439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 11:54:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740599679; x=1741204479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REreCuTx0gkwci3At+fSClZQOC45yVa1FO0Hyxdtpqc=;
        b=SImn0kw7tNDowtVoP36SP3x9WaGaSdUOcsQiSU7udVzNJxuRYsiA/UVPO0jQbpPrIC
         uidJEWCOd8wNh4H1y3cIa9Wk//lN/S1acCcIBkdibvicZK0dWO5E62QK1mmAUEQHN6ji
         1g3vPoZufSAp5e/erxtZQes2A+hyQfOEJOd5bn+WAe0l46CaCT+/VTI8XJ7aOmBguPIe
         FUC3XQEruPao4Qsdhyg1lirk2OCw5p9qwj98h16TD4CzBtIMb+J7w7l3ATw0w3wDlGzQ
         rm3zKFvi9hvTlEv0POtbA0AgB9OFKzvoKPc8iVIJawjKjArKjH1ADDdylakSf2RvFr5s
         Wo0w==
X-Forwarded-Encrypted: i=1; AJvYcCVyjSgV1uX3qskvS3XL3ibZjTfaGRz3e/GJ0wSHposgChEdPfH3E/ObIYgth16qTdP0kmj5DRjgr+xxg/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJEjNvy2RYJ9vk0GbrWFzPtatfGq8LTN63H83zPOlWJ53ZIoYl
	ktzQy13A96XV163kOjWIHqvxHW4WcVySTobBjaNyvGyWvdTKxtviwx7nfyKkU5TPaxWN+r2+CM3
	p8RWFo5D5UKTpS19uDyM5VSRw9To+ctSpaFveaHhWxJ7F77dRqr1IqIHKaK4Fnw==
X-Gm-Gg: ASbGnct0fUHKMjFS74THJOY9LZXgRc9/q5lp+REiMPeMsBhR5z9Uq3GeeHQPznRR3A1
	u6FWmYLoGVypY/npU9F/fWgjq/l7R82HZrTfax4pUwPMPrFyHaJBMPisEEaxHM1lcpbHmR8kDKv
	HNXQNoRtQJ1ROSZjOHW6kchL7ZU79z8m4Q8yDQl8ejfaEPJNxZotJ85N6IvcYQj3wp8oJnknRoB
	EtpLLpiQyMmu03XPIJjsBO75P5tv1GFkfwruQj6HI/TyRrSTdrtfNlB/UadFsdsrJH0CAK/NDH3
	pcVQa8EheDSIGi6+xhM=
X-Received: by 2002:a05:6e02:138b:b0:3d2:b808:6af7 with SMTP id e9e14a558f8ab-3d2caf029dcmr52169155ab.3.1740599679157;
        Wed, 26 Feb 2025 11:54:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGclZdN5ci9WTASTIbwQPB6JRSCol267p3y7JPBzh5FgUw4I41vL0bfqhosjvVDmk9CT8cKjA==
X-Received: by 2002:a05:6e02:138b:b0:3d2:b808:6af7 with SMTP id e9e14a558f8ab-3d2caf029dcmr52169055ab.3.1740599678746;
        Wed, 26 Feb 2025 11:54:38 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061c513fbsm949173.51.2025.02.26.11.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 11:54:36 -0800 (PST)
Date: Wed, 26 Feb 2025 12:54:35 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, peterx@redhat.com,
 mitchell.augustin@canonical.com, clg@redhat.com, jgg@nvidia.com,
 akpm@linux-foundation.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 5/6] mm: Provide address mask in struct
 follow_pfnmap_args
Message-ID: <20250226125435.72bbb00a.alex.williamson@redhat.com>
In-Reply-To: <3d1315ab-ba94-46c2-8dbf-ef26454f7007@redhat.com>
References: <20250218222209.1382449-1-alex.williamson@redhat.com>
	<20250218222209.1382449-6-alex.williamson@redhat.com>
	<3d1315ab-ba94-46c2-8dbf-ef26454f7007@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 09:31:48 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 18.02.25 23:22, Alex Williamson wrote:
> > follow_pfnmap_start() walks the page table for a given address and
> > fills out the struct follow_pfnmap_args in pfnmap_args_setup().
> > The address mask of the page table level is already provided to this
> > latter function for calculating the pfn.  This address mask can also
> > be useful for the caller to determine the extent of the contiguous
> > mapping.
> > 
> > For example, vfio-pci now supports huge_fault for pfnmaps and is able
> > to insert pud and pmd mappings.  When we DMA map these pfnmaps, ex.
> > PCI MMIO BARs, we iterate follow_pfnmap_start() to get each pfn to test
> > for a contiguous pfn range.  Providing the mapping address mask allows
> > us to skip the extent of the mapping level.  Assuming a 1GB pud level
> > and 4KB page size, iterations are reduced by a factor of 256K.  In wall
> > clock time, mapping a 32GB PCI BAR is reduced from ~1s to <1ms.
> > 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: linux-mm@kvack.org
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > Reviewed-by: "Mitchell Augustin" <mitchell.augustin@canonical.com>
> > Tested-by: "Mitchell Augustin" <mitchell.augustin@canonical.com>
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---  
> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks, David!

Is there any objection from mm folks to bring this in through the vfio
tree?

Patch: https://lore.kernel.org/all/20250218222209.1382449-6-alex.williamson@redhat.com/
Series: https://lore.kernel.org/all/20250218222209.1382449-1-alex.williamson@redhat.com/

Thanks,
Alex



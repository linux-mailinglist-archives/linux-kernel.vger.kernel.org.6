Return-Path: <linux-kernel+bounces-313539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B2D96A6CE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6744128ADD6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602D21925AB;
	Tue,  3 Sep 2024 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gREbXCKE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C057B192588
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 18:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725389195; cv=none; b=ehOXW/gBLTrj+8oKA+7aL+HzvnCPjQPEvAmaBjH4458hIf4qQ7cko+40T3mWsT9+DsJxwgMCWrmWyua9gTlIazDKy3M7WsnVCTZiXzIEXoTXrvfAVhRSSEpH6dSA+8vyzk+zeh/TA2brQ5t9HHAHzqnnQIehjVdM8XyElhNGihs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725389195; c=relaxed/simple;
	bh=qlr0UzIGWr7ZF42VkXt/zM8XPz1u4cVgQIaq5NN9S1I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=po2n2TVS1T9kqIZkg9d4yIxSdlaTQvd5ahjc9BufNYeUCTbcJW2bU7WoyEcVR/g1AQFFnNFEznaT8IFM67mnk/9W0Ms1vBD8Gx+fQH6422DVytpg092ud3EZZFJEjms4/ZDixriJQ8KveMltW2N7T5UPguOGQbMXmC63oWASwaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gREbXCKE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725389191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TX06RE9IIMQkBQtApY9umtDfEHnu65wamVMOEuiSRS8=;
	b=gREbXCKEuF+Cjb62OxmAxfqXxJGTQiZ7hEwuQaNdYHpjER1FHtxSqlvF/RN1Cux33avb1R
	Vb010AgHSjPR2GDWja9zlrO6fyRT2gaE5IPc8I7BZcr/c2ONByNKaLjlYjFMPu472BmJhZ
	yZMjWLraervJkdVNlQbDg1q+FBCQ/G4=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-Qxx62RRTPYOnu-wxdpNehA-1; Tue, 03 Sep 2024 14:46:30 -0400
X-MC-Unique: Qxx62RRTPYOnu-wxdpNehA-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a353ef7c1so60315639f.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 11:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725389190; x=1725993990;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TX06RE9IIMQkBQtApY9umtDfEHnu65wamVMOEuiSRS8=;
        b=Pi5AjjJlOf6iWI7Ra/HL1F5GZGVI4ezmJAGWGF48fLB/XfC+0YxA9/M9gU4HF+BAGc
         pMNrTvl1BCEruRfsDwCJroPC4mG7MtvLs3da5RJq/8sl4jsWZ2udH8mSpC3UfxwOAzYj
         d7WTMbtyoe4u6ZGUKEJ7V8rtIruqrNVZcvabiwo0FQMVP+J7zlGpBxjKdVT2+7Cvlp4D
         xAg7SAITTmI/h5JsQkfCOzey8D1fHu9N4yljYCX6tX59C8mwBVT32cWi29rHDLVSEAn9
         86IovW5dbafcq/qTjK+M8s3F3jbpe8afESdsiglcWg+Z4b3NgmcTkFhpqJlFSaMe8NHV
         kVnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkRNOhzYUnCVTKVFbCuB2ItSLbh/Qt845T9id24KqY3IsAmyBNRgxWk/ZWMHUzlHbgCbKBROmvAr17Tsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQeTDKhW6mo8IY9Sbgd0wyv3fi8ozT7+eNbtuyxDQuI2ssyOme
	1Kl6vA5F7JYZ7LcaMW53NHcQJ64YPCHwhbFi8Vjy6LI43M2MsJqTHzVonM43V4B5qV80NNmxNvc
	kNAvUUPH1GVHWEfAS16nfGlWGsrMe6oKbBF5dlYBhr9bG2AhX3QozvfuhzMAWEA==
X-Received: by 2002:a05:6602:3f42:b0:81f:a783:e595 with SMTP id ca18e2360f4ac-82a26241b57mr913985039f.1.1725389189922;
        Tue, 03 Sep 2024 11:46:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoJXozVoWgLgS3JiwXYuhacpU68uFJ1d2hQDqCtvpH5J5pnX5D04SqSj6U9xQ8HdLDB3uOTw==
X-Received: by 2002:a05:6602:3f42:b0:81f:a783:e595 with SMTP id ca18e2360f4ac-82a26241b57mr913983639f.1.1725389189552;
        Tue, 03 Sep 2024 11:46:29 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82a1a42a0a9sm317624039f.24.2024.09.03.11.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 11:46:29 -0700 (PDT)
Date: Tue, 3 Sep 2024 12:46:26 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: linux@treblig.org
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio/pci: Remove unused struct 'vfio_pci_mmap_vma'
Message-ID: <20240903124626.3675ae86.alex.williamson@redhat.com>
In-Reply-To: <20240727160307.1000476-1-linux@treblig.org>
References: <20240727160307.1000476-1-linux@treblig.org>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jul 2024 17:03:06 +0100
linux@treblig.org wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'vfio_pci_mmap_vma' has been unused since
> commit aac6db75a9fc ("vfio/pci: Use unmap_mapping_range()")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index ba0ce0075b2f..2127b82d301a 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -57,11 +57,6 @@ struct vfio_pci_vf_token {
>  	int			users;
>  };
>  
> -struct vfio_pci_mmap_vma {
> -	struct vm_area_struct	*vma;
> -	struct list_head	vma_next;
> -};
> -
>  static inline bool vfio_vga_disabled(void)
>  {
>  #ifdef CONFIG_VFIO_PCI_VGA

Applied to vfio next branch for v6.12.  Thanks!

Alex



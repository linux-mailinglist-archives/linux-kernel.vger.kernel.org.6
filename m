Return-Path: <linux-kernel+bounces-288227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58719537A4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DC102821EF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F001B1417;
	Thu, 15 Aug 2024 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKG8O7LP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA28E4C69
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723737051; cv=none; b=sz78AFHhYkGctUpN2zGXGu037USbVUrSKmPCbZsQtNzCI+8f1yNjaRc3t+8JeV4cM1iqBBlizGGLQBNpzExL9OGcwpRrZzWmblseX8EhGXG9wHw3kB2hAzKxXuKcp2K2/nFUnSzfXCxyZSSwnLqakb3eGubczq5ZeP+x4eVE7AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723737051; c=relaxed/simple;
	bh=aZMMrFg1Di2xRaG2PKPTFXBs0pUsALFa/TvWiZyyiLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCvv4bH+exn0qFAgrlnss+d65HkBbkDI8LpzGRp7x9Fj0J+nEPm4V7E1UltWBfg//iWpRpXuXAGArv/SqejPkv5HC3Xi33yIaYxDzyf9LUIcb6siPlR4Ev8cPLnxob54sorWqP42MKKLOSYXa6/09dMi8BU3MQad/Y7f6Y9VRd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NKG8O7LP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723737048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PAxsRmRTyiybxBmaIn5tpwbiask6P7OilLc948K2bLs=;
	b=NKG8O7LPHh2Oc2oJcyuQMJL6/i/ePdZo8tSRvHEyTzWJF4OSOpUUThKjXH2ekINu6KdkVE
	y9qWqhNfkVkw3O2htxUBMsKUgnAWzi4/DJksFCcnZWGKDnC0PqN4YcAgfohIQDZNNnaaxe
	gjbjRPfeFaBD4Dkg8d99fnKsRf2IqjA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-T6c_JoRUPLe80tcdPvIEew-1; Thu, 15 Aug 2024 11:50:47 -0400
X-MC-Unique: T6c_JoRUPLe80tcdPvIEew-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-44ff01e344eso12431531cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 08:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723737047; x=1724341847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAxsRmRTyiybxBmaIn5tpwbiask6P7OilLc948K2bLs=;
        b=hxft57aHgqR8UhllpsLsNLrdzeMGL+9q9lcHZ66t0w+3pkINiLVj8fcgt9XuDpDefm
         zBN3/7OkpVUlQigxLSx//JPW2FCq5SKnvFX3ryf9s4TbAWMXIJD2kMsWKJKmmPhwRB6t
         O1Utp60Z2ccrZ/iMJTilD1Dcuv5ZWXR+ITbLvHShZgi3QWWIghxJgqzno804gUl1FYpp
         m65jsKkQQyi/TBjrCPSDC0kfejqGvXrKp9kPjqAVd+86sCDzkkI8PMr8RFhqZNXbfgBM
         d0VtRmzavy9weStolbyiPiP8t4Irh3XvnI3BSVvM5/iSrNT4s5N7pgROS2NT3BGbZtGc
         EUvg==
X-Forwarded-Encrypted: i=1; AJvYcCUsBHIIW9nCaIXL/n/EotRyJju+07fbSfiarz+sjvj18Kd8cVz+Q2Cdnv31pdJytyifUCUGvYJlO/zWzDfhfuSR+PSlR9zalusiJE3Q
X-Gm-Message-State: AOJu0YyQuOIC9dPrwDwkkp3YPz1SdNTBwj5RlQ1lDpqkbkL5NvRMUNyy
	o9CV1xJEsLb+oGzQ1zkKmJJy6OffCmnXzAV4bhQ6ujJF1bvAjyzD4I+AGufbWG/Ksqvcia6E2To
	wEg85T/TVsNZITPrd1vWZmKWH5OL+h8TG71+FCiHkEWbLBZg2owPPlsB8SzXamQ==
X-Received: by 2002:a05:622a:1926:b0:446:63e9:dc70 with SMTP id d75a77b69052e-4535bac5032mr64655121cf.19.1723737046847;
        Thu, 15 Aug 2024 08:50:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqP3a6s1mqzTrSrz9yk0OPDqMqwt5NymJ/RFbenIfPN48g9k3i8WzqT2MFSoGpCReyDysJ/A==
X-Received: by 2002:a05:622a:1926:b0:446:63e9:dc70 with SMTP id d75a77b69052e-4535bac5032mr64654891cf.19.1723737046501;
        Thu, 15 Aug 2024 08:50:46 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a04e4e7sm6814331cf.63.2024.08.15.08.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 08:50:46 -0700 (PDT)
Date: Thu, 15 Aug 2024 08:50:44 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix incorrect domain ID in context flush
 helper
Message-ID: <cgz2k3p6hiwsbpjszt2r6ecw3hrasqvoovymb7cxyum6f65ayu@mueqgrbehmr3>
References: <20240815124857.70038-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815124857.70038-1-baolu.lu@linux.intel.com>

On Thu, Aug 15, 2024 at 08:48:57PM GMT, Lu Baolu wrote:
> The helper intel_context_flush_present() is designed to flush all related
> caches when a context entry with the present bit set is modified. It
> currently retrieves the domain ID from the context entry and uses it to
> flush the IOTLB and context caches. This is incorrect when the context
> entry transitions from present to non-present, as the domain ID field is
> cleared before calling the helper.
> 
> Fix it by passing the domain ID programmed in the context entry before the
> change to intel_context_flush_present(). This ensures that the correct
> domain ID is used for cache invalidation.
> 
> Fixes: f90584f4beb8 ("iommu/vt-d: Add helper to flush caches for context change")
> Reported-by: Alex Williamson <alex.williamson@redhat.com>
> Closes: https://lore.kernel.org/linux-iommu/20240814162726.5efe1a6e.alex.williamson@redhat.com/
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>



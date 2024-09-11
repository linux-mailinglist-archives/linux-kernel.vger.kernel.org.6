Return-Path: <linux-kernel+bounces-324701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A309D974FE1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9E628B2BE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02514184551;
	Wed, 11 Sep 2024 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLt5eucl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE73839AEB
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051274; cv=none; b=XgfOOcowpDSlqzcJP+1yawYCF3r53lATr8Z4t5/bN42basZcUsPt6nxqmZL+vp7BueCGQqAITHYyzOdwyGKCkN2bpZiPxIM8sQ8kNI0ADVVyv6tCMVzFzPUETVwCxUjVOyp3BoA3b2SIBY40A1pWW0uAefSxDV92tJokujPVsz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051274; c=relaxed/simple;
	bh=69CUuncPUr4x5RkMCSBIuqOHTfCMa+6MvkPUSEiBThE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOb4SDwEmiaHa98Z3DLiXYyNPs1pob/LMeqaUgiXXpM1KMv0XLH/ohHMW64zR4Ryt6wokkMthX7jfBD+BWjocChN6hMAeGPBiF4ZrCV4XMktB3PVIm/doVu1XW87AuG+xhCPxoCk9l6OLvvtgHTYIawjJ465a4FpwU/OrpzkIvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cLt5eucl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726051271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mj0Pmt4+l/yoZGolZSUlxlWO/3uwqqLnEmDHKUg/JNA=;
	b=cLt5eucl2TxUzF/uKtFSn2rjbfWsns3Exw1low6cMyMA38sxtJlsofbEU40wi5BfhxK7Mw
	nMJCtJ27ZgOVfyI4HXvOMMYEwckxraB1wcHfonQXMJqBp5dxuo4ysoNpINa1HXBGyNpVMQ
	LK6rLFhErMr2nUWvBNeyQC5AAxgtGO4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-hb-UmeQJOMGSd1GroXYIzw-1; Wed, 11 Sep 2024 06:41:09 -0400
X-MC-Unique: hb-UmeQJOMGSd1GroXYIzw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a8d2e6a69b6so249670366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726051268; x=1726656068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mj0Pmt4+l/yoZGolZSUlxlWO/3uwqqLnEmDHKUg/JNA=;
        b=RDFrDzEQUR01jRKXU8tNSb1brg4gwaycjWVUV1Y+NxUq24S3NjVxYPNMnpdCVdqI/J
         AQ0nzz1cX8kB+3pBtNZ86hPzV1XMPEeXgtTjUeKTFuIbe+ja53PQP0cVr5tG3G9Ru6Ik
         7eBj+4f1n+SwURhV3d0wCJpSIw4sSeyt4rdMc4KmhNm97povg2ybPpeI6rmMD37wZkYC
         iDkA+DSz3I/qAPP+UpYcoXIfLaflhKuCxstFJOn0sTkolAKB2xtKawCvknMczxOpvLi8
         D9qpZTWoMXDWepcUfIJD0Nks/rw7hF8OK6edOMlbZwGqp3juEb0T8WC9EZt+GLXTUv9z
         O6qA==
X-Forwarded-Encrypted: i=1; AJvYcCWhYSl1icMCVlNqQJuHUJOrbjOeZPg0YnCOxjvh/QdpAfxkfWlAGelJYOBf4H68zxvgVicjLzDoDi9mtbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvqgfLgIajSszY1RrrvhSm9CSHyvjUHO2/n+GJk6a1gcaXXj0h
	QTkQEBoO7icihQFkKbYueELLQiQ45PSvxatdpDGqYVZNDx74NW0o9CQ/1fbV3NZawmrA+vsXQCy
	MfqIFGUkt/tE3nwduE16gsjjGPMwRtluwX0t1SP9GpntENAxXLPJEO3tHhqGZ+w==
X-Received: by 2002:a17:907:608a:b0:a8a:af0c:dba9 with SMTP id a640c23a62f3a-a8ffab18a03mr338951166b.16.1726051268323;
        Wed, 11 Sep 2024 03:41:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjwow7xjZyNKq+znU2sWXTqiXCHb4WnKuVlTefeDqjperl96LUtyQ71qJkBZbFAcUmvdXTSQ==
X-Received: by 2002:a17:907:608a:b0:a8a:af0c:dba9 with SMTP id a640c23a62f3a-a8ffab18a03mr338948066b.16.1726051267557;
        Wed, 11 Sep 2024 03:41:07 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:a3d1:80b4:b3a2:70bf:9d18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ceaf86sm595722166b.155.2024.09.11.03.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 03:41:06 -0700 (PDT)
Date: Wed, 11 Sep 2024 06:41:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the vhost tree
Message-ID: <20240911064055-mutt-send-email-mst@kernel.org>
References: <20240911174708.5c52b33a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911174708.5c52b33a@canb.auug.org.au>

On Wed, Sep 11, 2024 at 05:47:08PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the mm-stable tree as a different commit
> (but the same patch):
> 
>   040b4f437e17 ("vduse: avoid using __GFP_NOFAIL")
> 
> This is commit
> 
>   955abe0a1b41 ("vduse: avoid using __GFP_NOFAIL")
> 
> in the mm-stable tree.
> 
> -- 
> Cheers,
> Stephen Rothwell

Dropped it now, thanks!



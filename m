Return-Path: <linux-kernel+bounces-260900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4051993AFFD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712691C21DC1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 10:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AC3156899;
	Wed, 24 Jul 2024 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cm9Ue3O1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B253155757
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721818324; cv=none; b=RvVU5r7/hJogdU760VPJPCUTf9OlGogpm2Yt27BmKmyWztb1/JCwCLjC9lTEVPciqF5jjk4lcnoqf1nDTFXcjtdm9XwV0Cio3FFPWNp0IBRVHVBhvlJD+zlF+LjmVIhbv+ok0WVXJdeTDN3C28TNqyAj3fyZF4c9LQoai7RfrWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721818324; c=relaxed/simple;
	bh=NbHJh6RRHy684SrYZUNu5LAFgHVtJvGwtoD+uECKw/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCZxFdDvHM8KqyryBeuw/3QTD8Wbxwv7ZkkOJpfWRAhpwvez4RhrwXcMNGEwFS1H47ZaYxHpytNvsjdnPxmhGs11OBW7pgLkmYmENAtIXMWA7H+Q8PhC0xmCb0gPfm6xqiFxHee12kOurA4KbtHZ5GVwU1Gk/1kcTsI6NHAmdS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cm9Ue3O1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721818321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xn9TfjA6NiXJtkfI9W0qDv8xc0kKr5AGDpzztiNdZF8=;
	b=Cm9Ue3O1PZi7FVQDAqTcjthj7uB19RpvfOtxHthLEn6DeYgMCdU8Nj6skKIqnBzNtPM9Re
	7eZQHaa+WgHJuAu0ZOdJCXVblcqMrYpVD2qeOynbVL9UCN0wVqZJ6pUFh98QkmsSFDHtxy
	B4QvLC/q+D0CSQyriMHVTMymIIEyicQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-owcGAc7WMsCQiRxe8Ij1Qw-1; Wed, 24 Jul 2024 06:45:18 -0400
X-MC-Unique: owcGAc7WMsCQiRxe8Ij1Qw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-36831948d94so3703560f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 03:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721817917; x=1722422717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xn9TfjA6NiXJtkfI9W0qDv8xc0kKr5AGDpzztiNdZF8=;
        b=MWE7IrYtDt7HLdH9iRUwcKsKQBQGSlPgw5A2JWmd5ISNBho3N35lelXLeV4cq7LVnI
         BupxRVWnXi3T61pbghKDFvdyzKmpBXdVdVhwyHZ6bbzrCmGC3T/HdUNWQaE0wFr2U4O/
         uZ2KVY4un6/eymOfFEbXtnb5/zAPYxfdkoBp7mq/kFywDTZjU4xGGAgczlwqQZQIX3iK
         uU68npmhK8tdhho7qQ/cuHj07kjIITO0qsGTmCh1r/zzj6psMQdqLKUxb2tOx9E+35ZE
         hDkmnTMr4cQyxwlVMQLfstnnUaXC0Z98a4EVb/o9ZK2RnabXHjFdC26ELDoM6QPCF7PS
         SeAw==
X-Forwarded-Encrypted: i=1; AJvYcCWo4bzOJN81d62Ulm40l2J2TsEKPsVf2Qn++5CyplQ44a/tCinESojA1AyVuWfbvcXaWiKvEQkmUNHjwCRYhtKymGb9mbcwi4EcBuva
X-Gm-Message-State: AOJu0YxX1Jywljm+5JT7W7BgCAKzcYxAyGscvqusT6LK4xDSL85W1Q1P
	AHtvGcsgEO5w9pDBBi8MZpBiE+5frMf+/Y7WSTsGRO0jFbJxGLDCMiIm+glSDOzcFfR0HdUS0Qi
	4uFaUU/7B0lAftGSJ0KRXsV8AXR1PbKv9SUgYW6g7rsbxyoNkK1JojDUTeA+mIGfCmZQeTQ==
X-Received: by 2002:adf:eb82:0:b0:367:8a3e:c127 with SMTP id ffacd0b85a97d-369f5bb57ddmr1076830f8f.63.1721817917282;
        Wed, 24 Jul 2024 03:45:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeiMpsWcqeCFCR3YjRVhYw58gnKNcIGwvJmtVpjFuFH/aFmGbZKpc7S+Um/rqoZCaNJ3M9OQ==
X-Received: by 2002:adf:eb82:0:b0:367:8a3e:c127 with SMTP id ffacd0b85a97d-369f5bb57ddmr1076804f8f.63.1721817916632;
        Wed, 24 Jul 2024 03:45:16 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f4:6083:a67a:e8a9:2855:2683])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787ed580sm13850744f8f.112.2024.07.24.03.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 03:45:16 -0700 (PDT)
Date: Wed, 24 Jul 2024 06:45:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/virtio:Fix the wrong format specifier
Message-ID: <20240724064459-mutt-send-email-mst@kernel.org>
References: <20240724074108.9530-1-zhujun2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724074108.9530-1-zhujun2@cmss.chinamobile.com>

On Wed, Jul 24, 2024 at 12:41:08AM -0700, Zhu Jun wrote:
> The unsigned int should use "%u" instead of "%d".
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

which matters why?

> ---
>  tools/virtio/ringtest/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/virtio/ringtest/main.c b/tools/virtio/ringtest/main.c
> index 5a18b2301a63..e471d8e7cfaa 100644
> --- a/tools/virtio/ringtest/main.c
> +++ b/tools/virtio/ringtest/main.c
> @@ -276,7 +276,7 @@ static void help(void)
>  	fprintf(stderr, "Usage: <test> [--help]"
>  		" [--host-affinity H]"
>  		" [--guest-affinity G]"
> -		" [--ring-size R (default: %d)]"
> +		" [--ring-size R (default: %u)]"
>  		" [--run-cycles C (default: %d)]"
>  		" [--batch b]"
>  		" [--outstanding o]"
> -- 
> 2.17.1
> 
> 



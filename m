Return-Path: <linux-kernel+bounces-513284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440CDA34871
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB9E3ADDF7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61343199934;
	Thu, 13 Feb 2025 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z2e1pcT9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A7619D092
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739461402; cv=none; b=EA0uRATVTgto8r2a1EmZM1VkUHH7FMCdeDCmsQW/scqYNdJRwZgNpIZn+djAXFV2yDV0AsUQtra7y05Vnv0vejK9hBEi+wjF/x54JzPmjya+ZKiNjQbiW/9GSGd+3bNmC+w8JohwAGGr4SOM0pnf3IIuKDooqLN+bWERGvc4JlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739461402; c=relaxed/simple;
	bh=uLiZ1rCqYfK/j8eSgyeV2MyQP8gfHxF6rrcTwqcvaaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4CiWFx0HCsOZlHTAJiHkOtGwodJuITXSn5N4PrZ5Eh3z6yrL5XUmPj6WgtEFsiaeMhsUnroL/iZ3l9aavFtAIy050ZTb+S6hpuuSYbGJj2v2/38QKMOaJpw3ardssReWegPVGE6CDSOa8U+VIqiFBJWQZ7/Fyjsrw29ItVCZRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z2e1pcT9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739461399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yzI2r5nmEeXgT2ts1VutUTn2sHSIfm7BIbhjPpBpcIA=;
	b=Z2e1pcT9QLSy4zzIVDW3ofXOnm5acdAwkVdjALq7p2plaIKTHdoakEnIhPqiI7la+UBL4z
	wOlzpj1xxzFH3RCkKrz9J6Mm1DsUWOLFU6L+ckyAhTobB1X5q4WyFWubMX/wR/xHpnO7P0
	cVptkTilrNbw7W3vN9/zyK+pKPImiv8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-hGHDExbeNLigL3UdDDmgAA-1; Thu, 13 Feb 2025 10:43:15 -0500
X-MC-Unique: hGHDExbeNLigL3UdDDmgAA-1
X-Mimecast-MFC-AGG-ID: hGHDExbeNLigL3UdDDmgAA
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa6b904a886so91633466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 07:43:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739461394; x=1740066194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzI2r5nmEeXgT2ts1VutUTn2sHSIfm7BIbhjPpBpcIA=;
        b=wZ+1xvK/i9LIfWBwzdmf+ffcfs9iri1xQwsFC/0+SRzUfC2jArj+mEgVOFhy/qZgaE
         dHKCYBddoGdcFEe+EMBWL4zEn60frl220x4xPDNUKUS4yjns+a+HXNzEeH2n7lcBMrlz
         dnfAuMSIlUGdFzEnCvQrvO9nKk+yiToVpLif/Pc+YiZGVRGhB7cI5SKAEVJs8qJbchiz
         GsU5FQXBzVNpRysTt7DLSEtHvqIF2Ns352JyStl70bMulNty3/d3f8wrFdDHMvC+azvk
         KtcKFrJGNlui+0BVf7DmRI5K05VjFIG4M6NrGJ6fyLXBxjMoQ008tf8cYRqOT0SAOiQG
         YZ7A==
X-Forwarded-Encrypted: i=1; AJvYcCXYBVqYQIIb2Yo6db9J7S3tQUksUOvdldIkYH9kwA7oWhIMWsH+K3YU6u7zdMiMbK2I6TS/0Aub86YlbXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOzPhHjOVuxI+PYQloPk3oBnWoONT995Kp7ccAvnLNbqAAiwhY
	ZScP9K4eL/DP+uiKCXlNygwDcyH03onfXRbqvgENH0PVndQauHZ2ozAqj8pHqbKgQap+8ps+j2L
	w2jg1iPB2dF3UDCpGsXueXmpNl46lR+w7jtXebsa97jW6V8UyZ0yPtxUNQ1hNRw==
X-Gm-Gg: ASbGnctVCqs5evVN+e3H7laArjS8P+tiKUgETt9hw6DNSB6yRz1I5zBzQ4w+qtXr8U2
	Op0Wq2jaPNI+Z8SkdPTmiOK2NVeJA2sWXTVCOcEgCrcWCkhYV0wBRUoupsdTMmf2+/nTvjOykGA
	1zATsOIkTdiRvHZqCVjZo0DMss1jRh+A144+vIXs1ON0jMKSd6foiYYhFnrGoiFeckT9E1JKwTr
	v1V3yrUHI+zbx1j8tSZ//wRyVsw2eRTJrVcjsYWAyuoM8NM9MwVxYfvfRkaIetjCqZZb+zw0w==
X-Received: by 2002:a17:907:96ac:b0:ab7:cd83:98b6 with SMTP id a640c23a62f3a-ab7f336d4dcmr727680066b.6.1739461393901;
        Thu, 13 Feb 2025 07:43:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMjEK63T1Hvw2DRYuMNZ0QhIbCttTcpsK+feVhTHyAb3Qwlg1NW7Q7NJFwB80xOR6TDebhgw==
X-Received: by 2002:a17:907:96ac:b0:ab7:cd83:98b6 with SMTP id a640c23a62f3a-ab7f336d4dcmr727676966b.6.1739461393478;
        Thu, 13 Feb 2025 07:43:13 -0800 (PST)
Received: from redhat.com ([2a02:14f:171:92b6:64de:62a8:325e:4f1d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53376abbsm153403066b.93.2025.02.13.07.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 07:43:12 -0800 (PST)
Date: Thu, 13 Feb 2025 10:43:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	gur.stavi@huawei.com, devel@daynix.com
Subject: Re: [PATCH net-next] tun: Pad virtio headers
Message-ID: <20250213103636-mutt-send-email-mst@kernel.org>
References: <20250213-buffers-v1-1-ec4a0821957a@daynix.com>
 <20250213020702-mutt-send-email-mst@kernel.org>
 <0fa16c0e-8002-4320-b7d3-d3d36f80008c@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fa16c0e-8002-4320-b7d3-d3d36f80008c@daynix.com>

On Thu, Feb 13, 2025 at 06:23:55PM +0900, Akihiko Odaki wrote:
> On 2025/02/13 16:18, Michael S. Tsirkin wrote:
> > 
> > Commit log needs some work.
> > 
> > So my understanding is, this patch does not do much functionally,
> > but makes adding the hash feature easier. OK.
> > 
> > On Thu, Feb 13, 2025 at 03:54:06PM +0900, Akihiko Odaki wrote:
> > > tun used to simply advance iov_iter when it needs to pad virtio header,
> > > which leaves the garbage in the buffer as is. This is especially
> > > problematic
> > 
> > I think you mean "this will become especially problematic"
> > 
> > > when tun starts to allow enabling the hash reporting
> > > feature; even if the feature is enabled, the packet may lack a hash
> > > value and may contain a hole in the virtio header because the packet
> > > arrived before the feature gets enabled or does not contain the
> > > header fields to be hashed. If the hole is not filled with zero, it is
> > > impossible to tell if the packet lacks a hash value.
> > > 
> > > In theory, a user of tun can fill the buffer with zero before calling
> > > read() to avoid such a problem, but leaving the garbage in the buffer is
> > > awkward anyway so fill the buffer in tun.
> > 
> > 
> > What is missing here is description of what the patch does.
> > I think it is
> > "Replace advancing the iterator with writing zeros".
> > 
> > There could be performance cost to the dirtying extra cache lines, though.
> > Could you try checking that please?
> 
> It will not dirty extra cache lines; an explanation follows later. Because
> of that, any benchmark are likely to show only noises, but if you have an
> idea of workloads that should be tested, please tell me.

pktgen usually



> > 
> > I think we should mention the risks of the patch, too.
> > Maybe:
> > 
> > 	Also in theory, a user might have initialized the buffer
> > 	to some non-zero value, expecting tun to skip writing it.
> > 	As this was never a documented feature, this seems unlikely.
> > >
> > > 
> > > The specification also says the device MUST set num_buffers to 1 when
> > > the field is present so set it when the specified header size is big
> > > enough to contain the field.
> > 
> > This part I dislike. tun has no idea what the number of buffers is.
> > Why 1 specifically?
> 
> That's a valid point. I rewrote the commit log to clarify, but perhaps we
> can drop the code to set the num_buffers as "[PATCH] vhost/net: Set
> num_buffers for virtio 1.0" already landed.


I think I'd prefer that second option. it allows userspace
to reliably detect the new behaviour, by setting the value
to != 0.


> 
> Below is the rewritten commit log, which incorporates your suggestions and
> is extended to cover the performance implication and reason the num_buffers
> initialization:
> 
> tun simply advances iov_iter when it needs to pad virtio header,
> which leaves the garbage in the buffer as is. This will become
> especially problematic when tun starts to allow enabling the hash
> reporting feature; even if the feature is enabled, the packet may lack a
> hash value and may contain a hole in the virtio header because the
> packet arrived before the feature gets enabled or does not contain the
> header fields to be hashed. If the hole is not filled with zero, it is
> impossible to tell if the packet lacks a hash value.
> 
> In theory, a user of tun can fill the buffer with zero before calling
> read() to avoid such a problem, but leaving the garbage in the buffer is
> awkward anyway so replace advancing the iterator with writing zeros.
> 
> A user might have initialized the buffer to some non-zero value,
> expecting tun to skip writing it. As this was never a documented
> feature, this seems unlikely. Neither is there a non-zero value that can
> be determined and set before receiving the packet; the only exception
> is the num_buffers field, which is expected to be 1 for version 1 when
> VIRTIO_NET_F_HASH_REPORT is not negotiated.

you need mergeable buffers instead i presume.

> This field is specifically
> set to 1 instead of 0.
> 
> The overhead of filling the hole in the header is negligible as the
> entire header is already placed on the cache when a header size defined


what does this mean?

> in the current specification is used even if the cache line is small
> (16 bytes for example).
> 
> Below are the header sizes possible with the current specification:
> a) 10 bytes if the legacy interface is used
> b) 12 bytes if the modern interface is used
> c) 20 bytes if VIRTIO_NET_F_HASH_REPORT is negotiated
> 
> a) and b) obviously fit in a cache line. c) uses one extra cache line,
> but the cache line also contains the first 12 bytes of the packet so
> it is always placed on the cache.


Hmm. But it could be clean so shared. write makes it dirty and so
not shared.

-- 
MST



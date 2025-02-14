Return-Path: <linux-kernel+bounces-515062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3055CA35F4E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3464B188A050
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1626D264A82;
	Fri, 14 Feb 2025 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6pPOnDh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF15F275419
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739540092; cv=none; b=hVVCnuZh5Puay7aWLSwJtLb+VCw9yt1EguKNnda0mua/X6d7aTUqR9guQ0ZXQJEysuKfEGp358GDTuq27pI+eTSZxD/zV4RMFQKr94tPkBJsMdDpWCRJwyCFi9QT8Dg5fK0eRNvhCRlmUDF9X3Nr9lVRvdTArLSeVkydHY/ZlHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739540092; c=relaxed/simple;
	bh=1rIrvF0Jv/axJissqScQNVkSpcTz+uHX2dYGRedQ3fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGFIMVsByOKeFcJQh6qhfAttm8WBwmd+MupQAhAVuXRNkgXxck5Pb6ntvz01+L/1IcaJ+6crPliyTrKrsPyQlwvU4x7r7ovzs0wrmFcuk6kMiG/Hr0fpiWO5I29TeDamUwiqpmZuSMf0NzkpoI9oDbPxWBe+Vk6F1fPhx8tskSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K6pPOnDh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739540089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1rIrvF0Jv/axJissqScQNVkSpcTz+uHX2dYGRedQ3fQ=;
	b=K6pPOnDhV74gGzuTWg15x69yg2zSywkhIEN6WRy+QkLDIxrlqohijfLa12IuWmI0fW6pPp
	9Pp6lSmoURoTTI6sVEgJ1gxSryefOXXsVZ77sMEQhnnFOPqo1yIxO0ueoR7NuynWyqm2H9
	lgzjOoQoXQLZQEiPsB8pGGnZRoHKYmo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-P5OuhVjdOtOJoDrZNl8Tng-1; Fri, 14 Feb 2025 08:34:48 -0500
X-MC-Unique: P5OuhVjdOtOJoDrZNl8Tng-1
X-Mimecast-MFC-AGG-ID: P5OuhVjdOtOJoDrZNl8Tng_1739540087
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f2f78aee1so359977f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 05:34:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739540087; x=1740144887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rIrvF0Jv/axJissqScQNVkSpcTz+uHX2dYGRedQ3fQ=;
        b=uxpwufS0dlYvxXaiYJ0c2zWCN8aTU5Ps1X7Ihuc2x6Mqv8mYXzNqCpkXdCfI1mX4ku
         H4JIjm/iePeq8PFtxGc6m/5WB5/nUnOBImqzcqaCtj/wnnTZqKepwfEPdOaNOF/QhEt0
         SQtY1SMAfWcUVE3vhf5oPpbRbNioaEGDp09GCEdhRAfnLc+FdXs+c1qPRlNRHiBpKRWq
         PPQIqpcHHkcoOZh8FqDdsV29zX5dnVetZfQ0YX2mmmUjXZ92WfkQY2pRnwGam8vzQEJL
         1KBe1Kj0n/8g9V3sinUBAwQD+dXUeplhYqC680jn/4jLBdn7QgJUI65NEsZTAt+tn7UV
         TvJg==
X-Forwarded-Encrypted: i=1; AJvYcCVYC4fqoGEtkHOCQEGOZT+uhS4kELv7ZZlgP7oUHt6Xn0xnfvIu+VJxZ7AoRb+PS6xR2df/66RxQFfeZWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/3pfrnOcNTkboMDpLtEsfvEFUTqerhUXVMuxmMAVQJCJkOL4e
	dVBCv1McSZQEYYLzKqYo15aRYZjarwAKuJ/5fECCWp1oHw4HnrTOGJSWsLr+8lGjWiCQRA+i1zX
	DuAEsWyGaZXGx3xr2L7tENv3c85tzBFwJ+VA7e0MSg7AtzkfpBRK5oifU7M6QJA==
X-Gm-Gg: ASbGncvsmj7hWlkRqyTpiqvLtzIab9BrfVJCSybVB0xMnZI0GNZq7o4YfjcN5Qzr6iU
	ZX2EXTntevHotFDuJqcrNjajVlgZpI+NEpNH7+F6v7LHopstjNx4ghukee59smuyPMg6nXvPWHT
	JflqLZk9pz+BctkXddvvZxyeUtTmbRUgdrx14W8PcHhggcjF72Skv4ui1YcGaYl5loAN1yNmKOA
	52n/+Do1conhE21346Vn56kT0Ibbsr8zdlGTgUgc02w1zp2pG9+0GZHK1Qi1Rn2W7n15oFv/8Ee
	ZEGgSjzKzh1H+6YyqEnHhnvOsAvI2lHfxc4H2rUTMp3yymzaoT1LMw==
X-Received: by 2002:a5d:4ad2:0:b0:38d:e3da:8b4f with SMTP id ffacd0b85a97d-38f24e1bfd4mr7382215f8f.0.1739540087267;
        Fri, 14 Feb 2025 05:34:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBDfyv1SdJm7R5cH01+wLfhjW4AOVc7JnS47asJmAAjRGNm0ow+MsDNI0LRQYW/dCz7cuhNA==
X-Received: by 2002:a5d:4ad2:0:b0:38d:e3da:8b4f with SMTP id ffacd0b85a97d-38f24e1bfd4mr7382167f8f.0.1739540086611;
        Fri, 14 Feb 2025 05:34:46 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b43d4sm4600179f8f.4.2025.02.14.05.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 05:34:46 -0800 (PST)
Date: Fri, 14 Feb 2025 14:34:40 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: davem@davemloft.net, edumazet@google.com, eperezma@redhat.com, 
	horms@kernel.org, jasowang@redhat.com, kuba@kernel.org, kvm@vger.kernel.org, 
	lei19.wang@samsung.com, linux-kernel@vger.kernel.org, mst@redhat.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, q1.huang@samsung.com, stefanha@redhat.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, ying01.gao@samsung.com, 
	ying123.xu@samsung.com
Subject: Re: [Patch net v3] vsock/virtio: fix variables initialization during
 resuming
Message-ID: <7zof7x3scn2jlszxwynyaw3i5lcwfo5j3yrgw2sraq6pw545h5@zwoqaewlq2m4>
References: <CAGxU2F7PKH34N7Jd5d=STCAybJi-DDTB-XGiXSAS9BBvGVN4GA@mail.gmail.com>
 <CGME20250214012219epcas5p2840feb4b4539929f37c171375e2f646b@epcas5p2.samsung.com>
 <20250214012200.1883896-1-junnan01.wu@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250214012200.1883896-1-junnan01.wu@samsung.com>

On Fri, Feb 14, 2025 at 09:22:00AM +0800, Junnan Wu wrote:
>When executing suspend to ram twice in a row,
>the `rx_buf_nr` and `rx_buf_max_nr` increase to three times vq->num_free.
>Then after virtqueue_get_buf and `rx_buf_nr` decreased
>in function virtio_transport_rx_work,
>the condition to fill rx buffer
>(rx_buf_nr < rx_buf_max_nr / 2) will never be met.
>
>It is because that `rx_buf_nr` and `rx_buf_max_nr`
>are initialized only in virtio_vsock_probe(),
>but they should be reset whenever virtqueues are recreated,
>like after a suspend/resume.
>
>Move the `rx_buf_nr` and `rx_buf_max_nr` initialization in
>virtio_vsock_vqs_init(), so we are sure that they are properly
>initialized, every time we initialize the virtqueues, either when we
>load the driver or after a suspend/resume.
>
>To prevent erroneous atomic load operations on the `queued_replies`
>in the virtio_transport_send_pkt_work() function
>which may disrupt the scheduling of vsock->rx_work
>when transmitting reply-required socket packets,
>this atomic variable must undergo synchronized initialization
>alongside the preceding two variables after a suspend/resume.
>
>Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume")
>Link: https://lore.kernel.org/virtualization/20250207052033.2222629-1-junnan01.wu@samsung.com/
>Co-developed-by: Ying Gao <ying01.gao@samsung.com>
>Signed-off-by: Ying Gao <ying01.gao@samsung.com>
>Signed-off-by: Junnan Wu <junnan01.wu@samsung.com>
>---
> net/vmw_vsock/virtio_transport.c | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>



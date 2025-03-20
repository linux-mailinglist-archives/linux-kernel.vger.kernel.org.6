Return-Path: <linux-kernel+bounces-569383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7298BA6A21C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83F457A7FD5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608322206A4;
	Thu, 20 Mar 2025 09:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMUff2xb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F8E20E32B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461695; cv=none; b=g66cemCgKFfDXABxGKxobgh1JpuGXDZyACvvSiqBCKP4cl4PD34J/lJydLr/zGq6+vMGYATZK0iamTqb7M/Ya5bVz/xlcBtlsEhzvZC41I1dfVh6glyWIL2Zyz98HfeqJkLkDNs4p4KpiZzCA7lOO0pIXCWLQOWgrkb0KZoThjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461695; c=relaxed/simple;
	bh=5W1uHTX0JS3ybfrgNeMmG6TgEZd4dU4vl69eG6Vq4OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULBE0UJ+HCLawNMzyK7M1vx5KVB6lx0NSObRtq7k1UXu134vJqEbhs95ZHSUV5As0PA3p/BheCThHGw6FrkNnlE41wRKtT9cta5mzjgHhuFtiZcoHmeCp1dm15MC5mF592eq2sq7ZX96FxnP3RKOHZaRfgKCAbMuWSaLZnyVJOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iMUff2xb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742461693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bDTq60/uptS/vYIusNxJ/yOQlPzuUR9or0TJgSxpmhw=;
	b=iMUff2xbcMVsZUkbgKSwbBzHicSNpA5LIqYyjHnuGJdO8bVfNuw5N7PRqYJbF9hB0a46wz
	fezjH9hdKJdUs0zWGtWSu5wUfdO9uLYHtQLNTOCnPmtxwVbN5SA611RLuMBm8J95BTpr1J
	IyvZS7Dya2r8vBDAa1UNqV8ZCFvcwIA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-U7_qS4nVPOqR6RkFeWS77w-1; Thu, 20 Mar 2025 05:08:11 -0400
X-MC-Unique: U7_qS4nVPOqR6RkFeWS77w-1
X-Mimecast-MFC-AGG-ID: U7_qS4nVPOqR6RkFeWS77w_1742461690
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e6a64bd1ecso543283a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742461690; x=1743066490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDTq60/uptS/vYIusNxJ/yOQlPzuUR9or0TJgSxpmhw=;
        b=lqAFUiYnGtzkrgIFk8tcElwLkk21+cHcQ8KQ2vhlnYPCc4Adc3YiiWy194cXyrG8t5
         4s/d7dvz4pq96Rh8yzCJn0YOXe4MlSZDULl137i3bVbR4psU3oYVZJHTxFBuzYI1rtJe
         bbYFN9kUpTEdSXzuyRKSHDF+CdxcOFOV3rVgWn92UyO7761YaxFRTJkkVpCqwSo5oNRm
         gkjtlJzqWNezXGCyfQ43INls/dw6PzFNB+ZpA4TDZoQcF3i9UHfzbK5wT/eR6EWqjFmT
         +WDtqjf87a0uXj5Fn2hwqN+nNss5qR7cMmYUjmJIRq+razCThuHrRk4x6ooJ4cwvwixp
         Rtdg==
X-Forwarded-Encrypted: i=1; AJvYcCWAkPijaU0+JSQnXOlxoEFFFRBVcpW5q+yXlSKcde1+rqc5r/4Kc973pPpw2238nUaQ6c0Yuc9KKaFv6ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxshiSGTSe6AtP3ZPkZIlMKKAs2+6Y43QH1Nk49or5keJKlzyGJ
	FoEV++HFljrgUivL7I4uxLFtWV5TnnwrTWxxB4jwYvzueOc5QqyAgwN68Ou9Ri2K8axZ9cFVzqH
	OzB8qdHJ2s1rgAMEXnH5tBwem25mwh/pVmG7EstfQP0rq100bvapG8NvTqJf/Ug==
X-Gm-Gg: ASbGncuDVJoPevv90cE4GcZw6e6fDJhgv0zJA/5+BPBHq4/1BFXUDuTocgGuboWTGXj
	YEfeqkNTO4ulr85UnakWKL216Cn+Fat88BbEUHkMdBskyWL3Z4ax+MN0qZCHQBa3wO05n3QulXj
	m0lk6DNjUxsnVCH++NskuYq7kfcXM27hoI/VxJ7fi/TqoiujRHMpwKCS4lcHyH6MHbV4lk8vjVc
	1x0kHsC1LaaaqlURQO2OzmoUgqa4I0zzTmgbVW4d4c9FmxipU5u68qpWzFo1HcQnZvqLEHCFl/S
	TWc/hMy2KOqf13QoXeEMXGxRPHh0Ka4/NqCrmRlce14x2ugv7aLA96wnPYQCj2o2
X-Received: by 2002:a05:6402:13cf:b0:5e7:c779:85db with SMTP id 4fb4d7f45d1cf-5eb80cdea32mr5839726a12.4.1742461690253;
        Thu, 20 Mar 2025 02:08:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOQHfmcgMblKkiR1tHejD7TWeiNXKZXGZAyBKU76H5X4T1+QQ1dIB97fNyYdpVkDoNZIj46Q==
X-Received: by 2002:a05:6402:13cf:b0:5e7:c779:85db with SMTP id 4fb4d7f45d1cf-5eb80cdea32mr5839682a12.4.1742461689546;
        Thu, 20 Mar 2025 02:08:09 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816afeaabsm10004728a12.69.2025.03.20.02.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 02:08:09 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:08:02 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] vhost/vsock: use netns of process that opens the
 vhost-vsock-netns device
Message-ID: <nwksousz7f4pkzwefvrpbgmmq6bt5kimv4icdkvm7n2nlom6yu@e62c5gdzmamg>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <20250312-vsock-netns-v2-3-84bffa1aa97a@gmail.com>
 <09c84a94-85f3-4e28-8e7d-bdc227bf99ab@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <09c84a94-85f3-4e28-8e7d-bdc227bf99ab@redhat.com>

On Wed, Mar 19, 2025 at 10:09:44PM +0100, Paolo Abeni wrote:
>On 3/12/25 9:59 PM, Bobby Eshleman wrote:
>> @@ -753,6 +783,8 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
>>  	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
>>
>>  	vhost_dev_cleanup(&vsock->dev);
>> +	if (vsock->net)
>> +		put_net(vsock->net);
>
>put_net() is a deprecated API, you should use put_net_track() instead.
>
>>  	kfree(vsock->dev.vqs);
>>  	vhost_vsock_free(vsock);
>>  	return 0;
>
>Also series introducing new features should also include the related
>self-tests.

Yes, I was thinking about testing as well, but to test this I think we 
need to run QEMU with Linux in it, is this feasible in self-tests?

We should start looking at that, because for now I have my own ansible 
script that runs tests (tools/testing/vsock/vsock_test) in nested VMs to 
test both host (vhost-vsock) and guest (virtio-vsock).

Thanks,
Stefano



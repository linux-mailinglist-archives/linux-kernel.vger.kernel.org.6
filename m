Return-Path: <linux-kernel+bounces-568803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D18A69A98
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9D08880F2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA6A2185B1;
	Wed, 19 Mar 2025 21:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZuJfR0XL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D192165E2
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742418595; cv=none; b=B7vDfhfXR8impEQ8ILR8AiA30aDrDX66E3NUFD/HoSQ4iwx9o8v0Ehrq53UpjgC6pYZtTeumqGMbL4cEcfH+oNs6/7SHKP9vxonGDou1G1O+YRdxFKqln9Wf+V81i6Bm0x7It7JtTU8T5KBHIKY7Cy7cUgN1xHoG6gvOWSRQN6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742418595; c=relaxed/simple;
	bh=t0DQSzj76o+q28S/J/Q+aN0pxw+YPVtotQKrAVrAB6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FRWdUqun7RYe2M7E8qIuEQEeeFQBXPj/j4I0SBvgUufZQZRpinXsm8MZAtw/WzhjiYflePjTYvWavHiVwa227gWBLM/X8tcDNPPiVvi4dr9ixfCWvM890qixdxvlqOpTzAfT/2eBR5mtxCJ7spusozA7yBcORgjzZeZBZbrwdNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZuJfR0XL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742418592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7HoSvSm7GM5yXTNBY3sCZv8nsyIwGMkLSsX5gJEiNY=;
	b=ZuJfR0XL8tPr34oFameWkhYHn/iefUjtoj3DmEJQ1aBhbtvrf2H9RW6PBdsO92kJFiDER9
	ORQzErbAOc3tdjuWYGo0fM2zKvlwjiOhb65SoqD3kwv1bETOnTQhlMCC2BVm57Crr3r4CG
	xwZa9lekyWGyEKttox4gHVgIgHjRFHo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-I4YqR1z4Oi-y11PgmvgXmg-1; Wed, 19 Mar 2025 17:09:49 -0400
X-MC-Unique: I4YqR1z4Oi-y11PgmvgXmg-1
X-Mimecast-MFC-AGG-ID: I4YqR1z4Oi-y11PgmvgXmg_1742418587
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ced8c2eb7so548555e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742418587; x=1743023387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j7HoSvSm7GM5yXTNBY3sCZv8nsyIwGMkLSsX5gJEiNY=;
        b=SpOGjItTjGbhV5xcmbSQSDHo2OFxVD6xqaLcANm6cXeb5NB5OW66i977P+Bh3E5/tA
         /jOJZowzviDI+S+Of6PWiPRWERTLw0S8lfdoHDZjZv3ea7ujNcLoIsvYPW6D/pFDvLj3
         9bKav3z4/VsL9iTO1U3yGA5Bd+yehmq1xwyPD5mQUs1J3zEkvmqK6EfwTlyfMNGCXbEZ
         ncTBgdWjMakziTAEXLwYQhkwhJpE6ijxI9mE3YGT3rcRiCaKfWBNIRMoctFXRcDpwhVw
         nbutx1sw4QxpCWMe02bfl6BFOXXVDmsY/wvU0Lr41jSDlc/72ApCVNqT+WPCSUinkKEr
         TPnA==
X-Forwarded-Encrypted: i=1; AJvYcCWno45ia2cz1afe8SVvlUjQdOLAKdU1FEB+A9MzsVAtGmPztg1WMMpfcb1zQoP9v7i81AjDSVvivGu4VZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKTTnRqslOYRn3rkK7pAHq63dc2T075X4zla0w44RKs2v5BnuD
	Lx9XtlEhyY85lmWphgXyzgBvMPjmT+WrPC2J+br1vlJZIKTb4RJN0B2oU1vqVXz3dSdY/hjuM4x
	NPhpLm+DptxC+LNUvZ9ZK+fd86ptl/xhCafNYm0D6opoh0GbuBIZOA4cmFg5w8g==
X-Gm-Gg: ASbGncuOJQt1i1SPF/BaZ7OLOEXNzfFly8BzpMurZ+MBOa3vqeRYaNNL1wMjaIVDUtO
	sRmBVZP2r3szr4I1Z1XDkuMoXpwUaeV6db+V/4Q64LizbAdqSsH9ZQ2ppEZSYsWFTwOFB3puGkh
	b2XiE2MH7XnP1Lf38gOxr4Y9sB+CUD7k9iSlexIhwnC2SD5QesH9gur9KcyCA+SMkJK6hiPMxF9
	YrVn6xEOiBqjsnMiwnCinue9Idh3RXa2esQ3d8sETwR8K0zNACQzt9eWyCLxCBha+JEOjD1ajfi
	gdw5AxPV67X/guNucOBqX8LuKq+jcXmKXxv77DqpNdtCFA==
X-Received: by 2002:a5d:5f4f:0:b0:38f:231a:635e with SMTP id ffacd0b85a97d-399795c2ademr966974f8f.25.1742418587037;
        Wed, 19 Mar 2025 14:09:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUNp5m5kg5nT9dIUi3KyGpUUwGQCEZhhXoTguvu2e0VxM6ACwAq8iInQv4AfDuk3Kc6Z9FwQ==
X-Received: by 2002:a5d:5f4f:0:b0:38f:231a:635e with SMTP id ffacd0b85a97d-399795c2ademr966951f8f.25.1742418586581;
        Wed, 19 Mar 2025 14:09:46 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df35ecsm22151312f8f.16.2025.03.19.14.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 14:09:46 -0700 (PDT)
Message-ID: <09c84a94-85f3-4e28-8e7d-bdc227bf99ab@redhat.com>
Date: Wed, 19 Mar 2025 22:09:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] vhost/vsock: use netns of process that opens the
 vhost-vsock-netns device
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Bryan Tan <bryan-bt.tan@broadcom.com>,
 Vishnu Dasa <vishnu.dasa@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: "David S. Miller" <davem@davemloft.net>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <20250312-vsock-netns-v2-3-84bffa1aa97a@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250312-vsock-netns-v2-3-84bffa1aa97a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 9:59 PM, Bobby Eshleman wrote:
> @@ -753,6 +783,8 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
>  	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
>  
>  	vhost_dev_cleanup(&vsock->dev);
> +	if (vsock->net)
> +		put_net(vsock->net);

put_net() is a deprecated API, you should use put_net_track() instead.

>  	kfree(vsock->dev.vqs);
>  	vhost_vsock_free(vsock);
>  	return 0;

Also series introducing new features should also include the related
self-tests.

Thanks,

Paolo



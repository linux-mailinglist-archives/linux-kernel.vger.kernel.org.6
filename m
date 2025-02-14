Return-Path: <linux-kernel+bounces-514668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAEBA359FF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6655F3B1310
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DA322CBF7;
	Fri, 14 Feb 2025 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLRejC9i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0D122D783
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524405; cv=none; b=GdSrK9P9mBHL04oOeCKco/oOlfPdveoAqWw9FpGM+/H77Bo+0yDJI+KBUq+0BYE/Hw2iIYX3At2O+xAi6lY66yeiurvNoO0maJGAH3x48LkBvy9VHgwZK79vjXDthDd8Oh66VBRRKUZVrsK64I+O03g+YUHI9h41/EPH+zTrPTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524405; c=relaxed/simple;
	bh=du5R5OUyc41uFNnKmFDZ3ZTR4fBDivNAdBOmdVBBTyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ua1Z6Zl3c9iDlHUFXITIZrie5Z+6GNOUtWZ0mQy+vBZwb1w5GnG/yRSA3xa0mHjvHZAaLPp9n7nsE2tGWLGXsDxKhCPkjU7S3uTFiVB38Q17n7Ob02pNjKEai8MUWEnd2rxhsrI6SMwde+0LQa5cppRRZw4qVhknvs8+C+SL1nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VLRejC9i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739524401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gXpaw3tkniDHQJSqE2+DNSZa4uhMaRXAPDQGJoN00q4=;
	b=VLRejC9i13Nm7UoSm6hASP24DcYXjC7ZGF2+3RDY9NOnT1VHZ68wdBBpKemVyDQWlGW5N4
	uKRc1oD3RLoNuqhNeKfhLLcgLd69gay4iVLH+0t/5JLkWzT41D7EhekT2b2ne7mP/KMm/x
	Ac7qxYzpNqTFQwfofFHh7ne5n57Gyac=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-obJk2sItM1iZ65Mk1BtYxg-1; Fri, 14 Feb 2025 04:13:20 -0500
X-MC-Unique: obJk2sItM1iZ65Mk1BtYxg-1
X-Mimecast-MFC-AGG-ID: obJk2sItM1iZ65Mk1BtYxg_1739524399
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38dcc9653a7so976272f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:13:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739524399; x=1740129199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXpaw3tkniDHQJSqE2+DNSZa4uhMaRXAPDQGJoN00q4=;
        b=amt8cNa5VQkVDdkxQvX/Zmqpe/pjsRFMAh+AdN9+/fpVchRu8MyOyE9H3GW3FVG5zP
         ZNbU/KyS78Y2Gm/YtRuHmMybqxq+CfJLeoaWm0QLuRhKvEgvH4renlbzsVSMMVoB/wvJ
         nefw+Q5vORe9P/OTZ6UY7QOagAeKIRwQMCoeSYvf8t0wn/YvDflk3KcSAmWoieVG5xnl
         9FCVjdansknUYwv3PnjnlK65m1sJ+wnVxJ4atzktr+NO7VTweupkeM6lgIlWGasv7C2t
         tMM23jkAzJUF1j5m7irtHjL60In6CQhDwKgbYXNSZsR5msj+q+9Vle/cNaZWKV8xTgK1
         odOg==
X-Forwarded-Encrypted: i=1; AJvYcCXj/Hbq9Viv6EeV1E2GzUX/J6fUUmGy6ZO9xSDEnEfmGGJUNYeOeTbj2xC07d4M/mnJPI2a/xox8Jwwulk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3k/p3tS7l7KrtY+cM/fsrr11AWBODjkjL+xxd0BG50jA4sXlm
	NdYhLUiHlqcNOf+ZyBjQ+wgYFW6Mnc5i5YF957WKk92UzU5bxf7Q2b9T+TiWtBKj3g20y3SO1Jw
	AIfC7fkh17yE9UB0c/wlTMWciwMyBsKLUJfb4Aj2bVwIiGY1a3fkJ0OiV4kOgow==
X-Gm-Gg: ASbGncuG9Nbzp1decRV/tsO5ov91LsKKTlXdNQnnTHLYxvHhHX69GSmR/qO9cdiWwOC
	JeGRl9gs9oMJJP9/dG7543NoMWf4YyKf++qcXoQUlN2RQmxBPhGNHEr4zCbfH2ynNlLFYdTUvmM
	sJjqKtmvRzFpMkElDJEtx8elYhXBU6pnlnOFHOZevRx4EPKHqCiBRWc86yJeka4Tb516zES+Vgm
	imPUq7VIQj8aEsjhFVXbiuqSLddbBX6E6hrAxjvlbepZn0dT1XU4OoLgS6JbMVgiPT9bZLhsJJO
	Qr1jX3tw
X-Received: by 2002:a05:6000:1a85:b0:38d:e3a9:d641 with SMTP id ffacd0b85a97d-38f244dfe03mr9750131f8f.16.1739524398999;
        Fri, 14 Feb 2025 01:13:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFo1+ndYPmLLEUFSzQhsih+LtpLI3CjoSkz/apOU+mMFzHLmZCSQphrtiigXU04yGg9k2Yzw==
X-Received: by 2002:a05:6000:1a85:b0:38d:e3a9:d641 with SMTP id ffacd0b85a97d-38f244dfe03mr9750070f8f.16.1739524398608;
        Fri, 14 Feb 2025 01:13:18 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ccd2csm4202125f8f.30.2025.02.14.01.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 01:13:18 -0800 (PST)
Date: Fri, 14 Feb 2025 10:13:16 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com, 
	eperezma@redhat.com, horms@kernel.org, jasowang@redhat.com, kuba@kernel.org, 
	kvm@vger.kernel.org, lei19.wang@samsung.com, linux-kernel@vger.kernel.org, 
	mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, q1.huang@samsung.com, 
	stefanha@redhat.com, virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, 
	ying01.gao@samsung.com, ying123.xu@samsung.com
Subject: Re: [Patch net v3] vsock/virtio: fix variables initialization during
 resuming
Message-ID: <yixatl5meez3ijzumebqkhf3sywwmiicwbsuxxsfdyfeeaapw2@dq542v2lclvm>
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
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index b58c3818f284..f0e48e6911fc 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -670,6 +670,13 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
> 	};
> 	int ret;
>
>+	mutex_lock(&vsock->rx_lock);
>+	vsock->rx_buf_nr = 0;
>+	vsock->rx_buf_max_nr = 0;
>+	mutex_unlock(&vsock->rx_lock);
>+
>+	atomic_set(&vsock->queued_replies, 0);
>+
> 	ret = virtio_find_vqs(vdev, VSOCK_VQ_MAX, vsock->vqs, vqs_info, NULL);
> 	if (ret < 0)
> 		return ret;
>@@ -779,9 +786,6 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
>
> 	vsock->vdev = vdev;
>
>-	vsock->rx_buf_nr = 0;
>-	vsock->rx_buf_max_nr = 0;
>-	atomic_set(&vsock->queued_replies, 0);
>
> 	mutex_init(&vsock->tx_lock);
> 	mutex_init(&vsock->rx_lock);
>-- 
>2.34.1
>

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>



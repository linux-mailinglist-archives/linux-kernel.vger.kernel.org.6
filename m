Return-Path: <linux-kernel+bounces-274372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04411947774
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEEB2281C3E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6B014B973;
	Mon,  5 Aug 2024 08:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BGh2kCUe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E453149DF0
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722847173; cv=none; b=jCjbE79FLgw8V4TpumctyC6U70d0YhIXTuJcTk9x80vODJug9Jg19TyxHDr+9M37gTgzo90vOUtVSr8i/mRTxZ0osiNOxmLv9W/jxZooqtcKbBo0eC0OxF18ffDPN3JAI2d2xB2PgrCnDwtIXq0icXK/AML4KqvvRgKBG7vBhMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722847173; c=relaxed/simple;
	bh=2VhGFoDqNEQQcvojz0IpiTyJYqSkpD3J7Qze2aHR3fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyLZyu2lsf1AFp7L9cAo6yTdmfoW7JD/7v5x6dHNFj+SiffAbwG4TipG4ltSiadUb6ZLJZHQd8081i9jkdwFIfV0WtqFVngqbS3CWwBivfnR0dqNEKkV1MXkXOrYF0ZCNIrBErSDw/+3Dh61PPku8yrKmMnaTc4Mj1zMzSdjCWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BGh2kCUe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722847171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ea4hswH1u1nPlUlDCZA86v40saWII4j79Dw05H185hU=;
	b=BGh2kCUeQUGI9s99rChz5f8X3y+v3PM/jy/kTewUcHYolq/VSsVtj7lGBHWsCSOy/961OZ
	PnCPQ4BoGu4Cl2xQypM3KLE6L4R+et9TDpgoiYafiux0KLTIDjkW3ovgPpc6F40LurLnPL
	b08fKXebUI4In18Ck1evKTATfgEnPTs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-lW8qGXYIPSS6JdsSfgeBKA-1; Mon, 05 Aug 2024 04:39:29 -0400
X-MC-Unique: lW8qGXYIPSS6JdsSfgeBKA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42817980766so66276015e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 01:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722847168; x=1723451968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ea4hswH1u1nPlUlDCZA86v40saWII4j79Dw05H185hU=;
        b=RquG+e5WWpZIZsLVJkAm/OYhxml95fEqqW1IyG5erE88u0KwiBwwpfHUIq0xkwzsGg
         ywCRyeTT9y4sUH+rskUGWWlDr8e1n5wX2Rme334blVjCLy+oMvX/QTERNNyejdPjZiXz
         240xfTkgKrsZ+fadHnSTY9WbwZaaPQFDskuyGzQjBZqZrfGT8pB6hO2hq71pQCZKJdrS
         R+tKSlwuP3YHGzkwTFZJQE05KFmI1ZL80WHCesAhEeuB+vPi8cxhFzGdR83FFKG4iAqu
         sMUkR5PA2WcDELyKyNzUjlhsbejPBLAFDPdSSwRbqQcadMs88Qqreyr9GHL7DOhbN4WH
         chzw==
X-Forwarded-Encrypted: i=1; AJvYcCUSVxI3e6oiXbi8j4W/lSO2b4hQHFgiqHUlMjH47rtFmUarsoO2HGy53GPS81/4KI4MQ3hFRf3NNlBTlHR/Neo1ur568SOZXhsQHzdD
X-Gm-Message-State: AOJu0Yz0WWrIjI2efwSSy3rsun59qJZKynXawS/C8TRYc3ii/oYKp3MX
	TSf79YmL9IfaljHbVUnY3g3G1urPiyT/nSad532ptc7sEl/348U5wDXbBncoxw/TrKcrYTn0xrQ
	HWZL3M1LIwLr7qqON7816WEiYTPKcJN8m7HudTr8JXhwX7QM8j2IjczghesMxCQ==
X-Received: by 2002:adf:b196:0:b0:369:b849:61b0 with SMTP id ffacd0b85a97d-36bbc17132dmr7003641f8f.43.1722847168042;
        Mon, 05 Aug 2024 01:39:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM8/anathdf0+itad/SmXLJr8Ha3hpgUqxCdeZR+OeBw6j4Do78FnDxdF5vJm5uH7+QdreGg==
X-Received: by 2002:adf:b196:0:b0:369:b849:61b0 with SMTP id ffacd0b85a97d-36bbc17132dmr7003601f8f.43.1722847167114;
        Mon, 05 Aug 2024 01:39:27 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-79.retail.telecomitalia.it. [82.57.51.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd169697sm9050176f8f.107.2024.08.05.01.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 01:39:26 -0700 (PDT)
Date: Mon, 5 Aug 2024 10:39:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: luigi.leonardi@outlook.com, mst@redhat.com
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marco Pinna <marco.pinn95@gmail.com>
Subject: Re: [PATCH net-next v4 0/2] vsock: avoid queuing on intermediate
 queue if possible
Message-ID: <tblrar34qivcwsvai7z5fepxhi4irknbyne5xqqoqowwf3nwt5@kyd2nmqghews>
References: <20240730-pinna-v4-0-5c9179164db5@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240730-pinna-v4-0-5c9179164db5@outlook.com>

Hi Michael,
this series is marked as "Not Applicable" for the net-next tree:
https://patchwork.kernel.org/project/netdevbpf/patch/20240730-pinna-v4-2-5c9179164db5@outlook.com/

Actually this is more about the virtio-vsock driver, so can you queue 
this on your tree?

Thanks,
Stefano

On Tue, Jul 30, 2024 at 09:47:30PM GMT, Luigi Leonardi via B4 Relay wrote:
>This series introduces an optimization for vsock/virtio to reduce latency
>and increase the throughput: When the guest sends a packet to the host,
>and the intermediate queue (send_pkt_queue) is empty, if there is enough
>space, the packet is put directly in the virtqueue.
>
>v3->v4
>While running experiments on fio with 64B payload, I realized that there
>was a mistake in my fio configuration, so I re-ran all the experiments
>and now the latency numbers are indeed lower with the patch applied.
>I also noticed that I was kicking the host without the lock.
>
>- Fixed a configuration mistake on fio and re-ran all experiments.
>- Fio latency measurement using 64B payload.
>- virtio_transport_send_skb_fast_path sends kick with the tx_lock acquired
>- Addressed all minor style changes requested by maintainer.
>- Rebased on latest net-next
>- Link to v3: https://lore.kernel.org/r/20240711-pinna-v3-0-697d4164fe80@outlook.com
>
>v2->v3
>- Performed more experiments using iperf3 using multiple streams
>- Handling of reply packets removed from virtio_transport_send_skb,
>  as is needed just by the worker.
>- Removed atomic_inc/atomic_sub when queuing directly to the vq.
>- Introduced virtio_transport_send_skb_fast_path that handles the
>  steps for sending on the vq.
>- Fixed a missing mutex_unlock in error path.
>- Changed authorship of the second commit
>- Rebased on latest net-next
>
>v1->v2
>In this v2 I replaced a mutex_lock with a mutex_trylock because it was
>insidea RCU critical section. I also added a check on tx_run, so if the
>module is being removed the packet is not queued. I'd like to thank Stefano
>for reporting the tx_run issue.
>
>Applied all Stefano's suggestions:
>    - Minor code style changes
>    - Minor commit text rewrite
>Performed more experiments:
>     - Check if all the packets go directly to the vq (Matias' suggestion)
>     - Used iperf3 to see if there is any improvement in overall throughput
>      from guest to host
>     - Pinned the vhost process to a pCPU.
>     - Run fio using 512B payload
>Rebased on latest net-next
>
>---
>Luigi Leonardi (1):
>      vsock/virtio: avoid queuing packets when intermediate queue is empty
>
>Marco Pinna (1):
>      vsock/virtio: refactor virtio_transport_send_pkt_work
>
> net/vmw_vsock/virtio_transport.c | 144 +++++++++++++++++++++++++--------------
> 1 file changed, 94 insertions(+), 50 deletions(-)
>---
>base-commit: 1722389b0d863056d78287a120a1d6cadb8d4f7b
>change-id: 20240730-pinna-db8cc1b8b037
>
>Best regards,
>-- 
>Luigi Leonardi <luigi.leonardi@outlook.com>
>
>
>



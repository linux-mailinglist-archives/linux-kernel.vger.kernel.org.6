Return-Path: <linux-kernel+bounces-512632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FABA33BD1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0949416056F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD41A211468;
	Thu, 13 Feb 2025 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQdDti7X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22CD8489
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739440748; cv=none; b=tiZDhIxImonlD3l7HFccn3bfX+6SIeJKhhugHJ5vEpeNQUK87hXN4kDu6kHFtk9x4Fmb3M6cL58mQe3AEOER1hglFvQgz8ro08OC7epePggR2uH9oNJ4YZNu64hZYBrRY3aApqUI1l7mLg8StKug8tW5DYE4bdnoKBJ1jlEPMWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739440748; c=relaxed/simple;
	bh=mBlhcPbs/4AtW9iUm1sJpj2/mUf5xyUFvoRw2xJsEeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d69RAIVd347KlWky7a9rgHqEl9i288BDVAdv5iG0ZEJv+B4HeNTiG1lxm8ClY37OcgZQ+Rt7dYLR2jfOFgR5YiQrhHPjnm+zs4d6RLFOLJK6E+AtRIE2o8iE1PlGiKLnzPekGeL4SUCHMWshr64qaUOATz/R20BjWPMaVW8Fm4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XQdDti7X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739440744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VF9gmqLLZEfjcpfDgykC+OwEPvzUo3jEbA07776aV5k=;
	b=XQdDti7XyJxUiF88ZH2ghud2l2ljqHiaj5T9cOWrpF3+gPlf7N2M+3j0/WuGHVHNJAxa55
	JnMuioh43lRtpmC9STSHZoSKrOFrjluBF+du3tyq0CkpdDdm8WoMuuQKVsiKnCZuYmNDk6
	nzVNEbwYp8T8jrqrkwPONVCYK0Vg370=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-nZG7Vj11Nmy1RtPjczQWNA-1; Thu, 13 Feb 2025 04:59:03 -0500
X-MC-Unique: nZG7Vj11Nmy1RtPjczQWNA-1
X-Mimecast-MFC-AGG-ID: nZG7Vj11Nmy1RtPjczQWNA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43945f32e2dso4922805e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 01:59:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739440742; x=1740045542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VF9gmqLLZEfjcpfDgykC+OwEPvzUo3jEbA07776aV5k=;
        b=DvUTJuQKXd5CtmXmdciG0oGACcV2BqCc+uml4DsABx36/XUlHWHatPn9OXj2qQ9aZ5
         OmkQTLSox4EhRUeLUCGDqXgE92i/kHtM9lB3zVtCu7txjnx7/jkr3orvZl2giz3nxL+w
         gpRipxIYmmr9+9/DmXB0wETqa+x5GPa97TeOCaOG6h3VGGmLskq7CCpf3R9q43WP+97p
         0AGCiJQIQ5ohUuVByfX4aw9DXPbM5sT2xvsHEYR4w8sCL4bWrMcbFHozgcs54oSs/lN9
         e6jxBFRKYIPCVHPRXbVcZWstH4LvG2mVElwznpYKf8rt3StIeaNh/a/BiBn0lURpQXia
         mb8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRiycMUEqjoZdReOoU+ipPpz9vBUh0TyrEXU5Ug/zSYuf1qiXxxNs88DymdyS8L1BPYCNORwOt1GuUd7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTme1EamqDHeM1XTaQAosfhYIZ7OtpF3Hb02b03QG5oxLq99wB
	ccj9FDhCjmoK9Ibs7WY6Of79K/5D4ZBtKkIhcsnKJaa9XMlwGoFPv07k5exBALWH6ym/zB8OQ3l
	55aRJBZVM6fbEX1WgPKwR7r5jpcOiaqTekJYnq2T4HFMN33WQZbAYGp8BQitsWQ==
X-Gm-Gg: ASbGnctTf1pXQoP4j/gFVwPGFALlkXy/FwGwu1IS9gynlVcL/AozA0BktOYN/x4QFMD
	EE0HMNlcG6RSuFdCUKrwn0PaNS4AwPyMfgUob6FiH7js0TjwrjonqOO15q6jRV/FmmonzsXroAV
	Wwkb6l+cnfwHwrMOBcGYNQUzQP3YOlOwieBduxJ4TU9ee1bUq0u8VrlaQHiBYLdwuJhHNPOyURm
	0jFU0pje05qTm/LtOf2B9mvs60Too3lyzQ+yNM6lwUG89w7GzvyRIJ9/yIb9LhFykoxeiHhFYrO
	Ye9Bza4l33r0y4QHB1JLTDXtZW+hW1DVb87ywfvNEXwfBKl9Uoa3NA==
X-Received: by 2002:a05:600c:1d1d:b0:430:57e8:3c7e with SMTP id 5b1f17b1804b1-439601c5066mr27870435e9.28.1739440741738;
        Thu, 13 Feb 2025 01:59:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkTmfUjduSY7E+Nry3MwnwedjswLGL+/ZdG16hsINMqSePv8Ea4KoXOATlChPRGWbJhBy8nw==
X-Received: by 2002:a05:600c:1d1d:b0:430:57e8:3c7e with SMTP id 5b1f17b1804b1-439601c5066mr27870035e9.28.1739440741082;
        Thu, 13 Feb 2025 01:59:01 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04ee48sm44195805e9.3.2025.02.13.01.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 01:59:00 -0800 (PST)
Date: Thu, 13 Feb 2025 10:58:55 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: davem@davemloft.net, edumazet@google.com, eperezma@redhat.com, 
	horms@kernel.org, jasowang@redhat.com, kuba@kernel.org, kvm@vger.kernel.org, 
	lei19.wang@samsung.com, linux-kernel@vger.kernel.org, mst@redhat.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, q1.huang@samsung.com, stefanha@redhat.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, ying01.gao@samsung.com, 
	ying123.xu@samsung.com
Subject: Re: [PATCH 2/2] vsock/virtio: Don't reset the created SOCKET during
 s2r
Message-ID: <vxz37vz262nujwe6qfyorblpkuvol3ix6ikzv7lpyx5pilx76e@s2wixscnvvuu>
References: <iv6oalr6yuwsfkoxnorp4t77fdjheteyojauwf2phshucdxatf@ominy3hfcpxb>
 <CGME20250212044758epcas5p244c3add904f0ee06f669cd4c53a9e594@epcas5p2.samsung.com>
 <20250212044843.254862-1-junnan01.wu@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250212044843.254862-1-junnan01.wu@samsung.com>

On Wed, Feb 12, 2025 at 12:48:43PM +0800, Junnan Wu wrote:
>>On Mon, Feb 10, 2025 at 12:48:03PM +0100, leonardi@redhat.com wrote:
>>>Like for the other patch, some maintainers have not been CCd.
>>
>>Yes, please use `scripts/get_maintainer.pl`.
>>
>
>Ok, I will add other maintainers by this script in next push.
>
>>>
>>>On Fri, Feb 07, 2025 at 01:20:33PM +0800, Junnan Wu wrote:
>>>>From: Ying Gao <ying01.gao@samsung.com>
>>>>
>>>>If suspend is executed during vsock communication and the
>>>>socket is reset, the original socket will be unusable after resume.
>>
>>Why? (I mean for a good commit description)
>>
>>>>
>>>>Judge the value of vdev->priv in function virtio_vsock_vqs_del,
>>>>only when the function is invoked by virtio_vsock_remove,
>>>>all vsock connections will be reset.
>>>>
>>>The second part of the commit message is not that clear, do you mind
>>>rephrasing it?
>>
>>+1 on that
>>
>
>Well, I will rephrase it in next version.
>
>>Also in this case, why checking `vdev->priv` fixes the issue?
>>
>>>
>>>>Signed-off-by: Ying Gao <ying01.gao@samsung.com>
>>>Missing Co-developed-by?
>>>>Signed-off-by: Junnan Wu <junnan01.wu@samsung.com>
>>>
>>>
>>>>---
>>>>net/vmw_vsock/virtio_transport.c | 6 ++++--
>>>>1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>>>>index 9eefd0fba92b..9df609581755 100644
>>>>--- a/net/vmw_vsock/virtio_transport.c
>>>>+++ b/net/vmw_vsock/virtio_transport.c
>>>>@@ -717,8 +717,10 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
>>>>	struct sk_buff *skb;
>>>>
>>>>	/* Reset all connected sockets when the VQs disappear */
>>>>-	vsock_for_each_connected_socket(&virtio_transport.transport,
>>>>-					virtio_vsock_reset_sock);
>>>I would add a comment explaining why you are adding this check.
>>
>>Yes, please.
>>
>
>Ok, I left a comment here in next version
>
>>>>+	if (!vdev->priv) {
>>>>+		vsock_for_each_connected_socket(&virtio_transport.transport,
>>>>+						virtio_vsock_reset_sock);
>>>>+	}
>>
>>Okay, after looking at the code I understood why, but please write it
>>into the commit next time!
>>
>>virtio_vsock_vqs_del() is called in 2 cases:
>>1 - in virtio_vsock_remove() after setting `vdev->priv` to null since
>>     the drive is about to be unloaded because the device is for example
>>     removed (hot-unplug)
>>
>>2 - in virtio_vsock_freeze() when suspending, but in this case
>>     `vdev->priv` is not touched.
>>
>>I don't think is a good idea using that because in the future it could
>>change. So better to add a parameter to virtio_vsock_vqs_del() to
>>differentiate the 2 use cases.
>>
>>
>>That said, I think this patch is wrong:
>>
>>We are deallocating virtqueues, so all packets that are "in flight" will
>>be completely discarded. Our transport (virtqueues) has no mechanism to
>>retransmit them, so those packets would be lost forever. So we cannot
>>guarantee the reliability of SOCK_STREAM sockets for example.
>>
>>In any case, after a suspension, many connections will be expired in the
>>host anyway, so does it make sense to keep them open in the guest?
>>
>
>If host still holds vsock connection during suspend,
>I think guest should keep them open at this case.
>
>Because we find a scenario that when we do freeze at the time that vsock
>connection is communicating, and after restore, upper application
>is trying to continue sending msg via vsock, then error `ENOTCONN`
>returned in function `vsock_connectible_sendmsg`. But host does not realize
>this thing and still waiting to receive msg with old connect.
>If host doesn't close old connection, it will cause that guest
>can never connect to host via vsock because of error `EPIPE` returned.
>
>If we freeze vsock after sending and receiving data operation completed,
>this error will not happen, and guest can still connect to host after resume.
>
>For example:
>In suitaion 1), if we do following steps
>    step 1) Host start a vsock server
>    step 2) Guest start a vsock client which will no-limited sending data
>    step 3) Guest freeze and resume
>Then vsock connection will be broken and guest can never connect to host via
>vsock untill Host reset vsock server.
>
>And in suitaion 2), if we do following steps
>    step1) Host start a vsock server
>    step2) Guest start a vsock client and send some data
>    step3) After client completed transmit, Guest freeze and resume
>    step4) Guest start a new vsock client and send some data
>In this suitaion, host server don't need to reset, and guest client works well
>after resume.

Okay, but this is not what this patch is doing, right?
Or have I missed something?

>
>>If you want to support this use case, you must first provide a way to
>>keep those packets somewhere (e.g. avoiding to remove the virtqueues?),
>>but I honestly don't understand the use case.
>>
>
>In cases guest sending no-reply-required packet via vsock,
>when guest suspend, the sending action will also suspend
>and no packets will loss after resume.

You can try this simple example to check if it works or not:

guest$ dd if=/dev/urandom of=bigfile bs=1M count=10240
guest$ md5sum bigfile
e412f2803a89da265d53a28dea0f0da7  bigfile

host$ nc --vsock -p 1234 -l > bigfile
guest$ cat bigfile | nc --vsock 2 1234

# while sending do a suspend/resume cycle

# Without your patch, nc should fail, so the user knows the
# communication was wrong, with your patch should not fail.

host$ md5sum bigfile


Is the md5sum the same? If not it means you lost packets and we can't do 
that.

>
>And when host is sending packet via vsock when guest suspend and Vq disapper,
>like you mentioned, those packets will loss.
>But I think those packets should be keep in host device side,
>and promise that once guest resume,
>get them in host device and continue sending.

The host will stop using virtqueue after the driver calls 
`virtio_reset_device()`, so we should handle all the packets already 
queued in the RX virtqueue, because when the host put them in the 
virtqueue it doesn't have any way to track them, so should be up to the 
driver in the guest to stop the device and then check all the buffer 
already queued.

But currently we also call 
`virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);` which will 
discard all the packets queued by application in the guests that weren't 
even queued in the virtqueue.

So again, this patch as it is, it's absolutely not right.

I understand the use case and it's clear to me now, but please write it 
in the commit description.

In summary, if we want to support your use case (and that is fine by 
me), we need to do better in the driver:

- we must not purge `send_pkt_queue`
- we need to make sure that all buffers that the host has put in the RX 
   virtqueue are handled by the guest
- we need to make sure that all buffers that the guest has put in the TX 
   virtqueue are handled by the host or put back on top of send_pkt_queue

Thanks,
Stefano

>
>Thanks,
>Junnan Wu
>
>>To be clear, this behavior is intended, and it's for example the same as
>>when suspending the VM is the hypervisor directly, which after that, it
>>sends an event to the guest, just to close all connections because it's
>>complicated to keep them active.
>>
>>Thanks,
>>Stefano
>>
>>
>>
>>>>
>>>>	/* Stop all work handlers to make sure no one is accessing the device,
>>>>	 * so we can safely call virtio_reset_device().
>>>>--
>>>>2.34.1
>>>>
>>>
>>>I am not familiar with freeze/resume, but I don't see any problems
>>>with this patch.
>>>
>>>Thank you,
>>>Luigi
>>>
>



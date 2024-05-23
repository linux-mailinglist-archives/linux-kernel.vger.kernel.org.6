Return-Path: <linux-kernel+bounces-187357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190A88CD09F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB5B1C229DB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2AC142E67;
	Thu, 23 May 2024 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ifAnlEMb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B50213D29D
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 10:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716461160; cv=none; b=KsL1yrhI6x+AzFxRdgByC2iAfDO1jpu2qOHGlwkRbIixB84jYt85wz2d+zWQZJhPgSw5IjA64hfjXzI9mP2Sj/7owe8K53gUVMDifolZhXvolovschf7724XjUM9J05q5CSiMR0LEh+aHuXDjHSielupV0gYsveb/htU3vKoifw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716461160; c=relaxed/simple;
	bh=+30TEOUWzw8uVDSprmsUuB0N4ph4VHKOtlgrAVTx4Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BoM2urVwBV2lUNtdQq+ixRK7XutNrn20M3Bueq94iAmmBaQ/p/Bfj0CoSCdABk51pJtLLHgxrec685C8L0tvBk81pf9RssiBPDo+oJRDj0nfZ5VgO7C52xwDmhsilVroRzPjM/ubqXQxXPzrkVmZxGfUcVhD9w0fU+9SJjwOEvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ifAnlEMb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716461157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=juhsDEScRvI3YVyUAk4M5qNp/ka5CUgsay8JZp9KViI=;
	b=ifAnlEMbyoMp31DOIWK8UDIGPg8Zv8gzVgLYoqjan842MbeekgeYiikF4nprQyXNzfLUWU
	UHSbVvbcdAwUyck1oOZqWWqffv6IpsQD1JEGC0pPiBCe9UU/rcEfARN5Nqc1vkS/YYnHNQ
	r0iMvXz+GLczZi3vXc1NVJf5XGfN5mI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-6J_SEFLcPweIuG_YTp8PGQ-1; Thu, 23 May 2024 06:45:54 -0400
X-MC-Unique: 6J_SEFLcPweIuG_YTp8PGQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-794a0a73d75so129325885a.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 03:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716461153; x=1717065953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juhsDEScRvI3YVyUAk4M5qNp/ka5CUgsay8JZp9KViI=;
        b=c6srMMTqic6ouREedH/TZ5xkJzkeNd08RID3ThHLSxH5Pkf8cbw2KtdVFDx4ODisnX
         97jGr2+C5YX91KNvcupVTun3+UqZP31Dtxi7dg5v8RV2aquFW3lEUl0RZugYHcu+HtCf
         aY8hAGxLI6jGp4cF4HDO5gvTOQcNgS5yqHBejzaw+wI2EflgAAXtc4STAs4xsYjAmrQ/
         jw+t/LZGMdgzfchBu2aId1rfXYZRQI+pT/CdiBisJOSC8+0hDiOWRGPGxDhMo2dHj3GN
         cI1hshuqSqCf5+/1L6emz5zNsApmGB9+oSg64rACPA5q23Vu06uY5D+issJOXnRD14j6
         EQ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzjXIKp3qJ9vXj+7e9qTxmuVGd5k8Q7DrfpIiej0TfmUzexEEXfU9STcNvlR1RTkxN9KNApICjSNAlKMEu4BjpQEQSmEm5d9mvf0bR
X-Gm-Message-State: AOJu0YwXomhvwHxLgrpp9j7A4+mYva2gBkFFzgkJFZCCSelyJyyUKlKX
	QGJ+RHQD4lKF5igeeah5FaGjrJnD8Z1Bq0dt1goWX2uynU8IERvXknvKYP7cPIlDJdsEvnOUVwF
	UxV+mMC7vIIl5H/+MSEslASt2IwMXi3sD+SqDvqv6SPAJKg8CC9s+cBzbBuUaew==
X-Received: by 2002:a05:620a:270b:b0:790:c15b:e192 with SMTP id af79cd13be357-794a0a2d290mr321635685a.32.1716461153528;
        Thu, 23 May 2024 03:45:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECiVS/3SMXiEgz7MPG9qy81SLUPLSxWskDIfwdUcbJG/sFDMV5fNyBeSkgTZeUX0rHbNuuqA==
X-Received: by 2002:a05:620a:270b:b0:790:c15b:e192 with SMTP id af79cd13be357-794a0a2d290mr321631485a.32.1716461153014;
        Thu, 23 May 2024 03:45:53 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-109.retail.telecomitalia.it. [79.53.30.109])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e3818469csm103371101cf.55.2024.05.23.03.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 03:45:52 -0700 (PDT)
Date: Thu, 23 May 2024 12:45:48 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, davem@davemloft.net, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [RFC PATCH 5/5] vsock: Add an ioctl request to get all CIDs
Message-ID: <azemyxjihhrvjv6k3xufubo4wcujescrlpa5ucfbmora3cvfyv@2mi62ffijnj2>
References: <20240517144607.2595798-1-niuxuewei.nxw@antgroup.com>
 <20240517144607.2595798-6-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240517144607.2595798-6-niuxuewei.nxw@antgroup.com>

On Fri, May 17, 2024 at 10:46:07PM GMT, Xuewei Niu wrote:
>The new request is called `IOCTL_VM_SOCKETS_GET_LOCAL_CIDS`. And the old
>one, `IOCTL_VM_SOCKETS_GET_LOCAL_CID` is retained.
>
>For the transport that supports multi-devices:
>
>* `IOCTL_VM_SOCKETS_GET_LOCAL_CID` returns "-1";

What about returning the default CID (lower prio)?

>* `IOCTL_VM_SOCKETS_GET_LOCAL_CIDS` returns a vector of CIDS. The usage 
>is
>shown as following.
>
>```
>struct vsock_local_cids local_cids;
>if ((ret = ioctl(fd, IOCTL_VM_SOCKETS_GET_LOCAL_CIDS, &local_cids))) {
>    perror("failed to get cids");
>    exit(1);
>}
>for (i = 0; i<local_cids.nr; i++) {
>    if (i == (local_cids.nr - 1))
>        printf("%u", local_cids.data[i]);
>    else
>        printf("%u,", local_cids.data[i]);
>}
>```
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> include/net/af_vsock.h          |  7 +++++++
> include/uapi/linux/vm_sockets.h |  8 ++++++++
> net/vmw_vsock/af_vsock.c        | 19 +++++++++++++++++++
> 3 files changed, 34 insertions(+)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 25f7dc3d602d..2febc816e388 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -264,4 +264,11 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
> {
> 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
> }
>+
>+/**** IOCTL ****/
>+/* Type of return value of IOCTL_VM_SOCKETS_GET_LOCAL_CIDS. */
>+struct vsock_local_cids {
>+	int nr;
>+	unsigned int data[MAX_VSOCK_NUM];
>+};
> #endif /* __AF_VSOCK_H__ */
>diff --git a/include/uapi/linux/vm_sockets.h b/include/uapi/linux/vm_sockets.h
>index 36ca5023293a..01f73fb7af5a 100644
>--- a/include/uapi/linux/vm_sockets.h
>+++ b/include/uapi/linux/vm_sockets.h
>@@ -195,8 +195,16 @@ struct sockaddr_vm {
>
> #define MAX_VSOCK_NUM 16

Okay, now I see why you need this in the UAPI, but pleace try to follow
other defines.

What about VM_SOCKETS_MAX_DEVS ?

>
>+/* Return actual context id if the transport not support vsock
>+ * multi-devices. Otherwise, return `-1U`.
>+ */
>+
> #define IOCTL_VM_SOCKETS_GET_LOCAL_CID		_IO(7, 0xb9)
>
>+/* Only available in transports that support multiple devices. */
>+
>+#define IOCTL_VM_SOCKETS_GET_LOCAL_CIDS     _IOR(7, 0xba, struct vsock_local_cids)
>+
> /* MSG_ZEROCOPY notifications are encoded in the standard error format,
>  * sock_extended_err. See Documentation/networking/msg_zerocopy.rst in
>  * kernel source tree for more details.
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 3b34be802bf2..2ea2ff52f15b 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2454,6 +2454,7 @@ static long vsock_dev_do_ioctl(struct file *filp,
> 	u32 __user *p = ptr;
> 	u32 cid = VMADDR_CID_ANY;
> 	int retval = 0;
>+	struct vsock_local_cids local_cids;
>
> 	switch (cmd) {
> 	case IOCTL_VM_SOCKETS_GET_LOCAL_CID:
>@@ -2469,6 +2470,24 @@ static long vsock_dev_do_ioctl(struct file *filp,
> 			retval = -EFAULT;
> 		break;
>
>+	case IOCTL_VM_SOCKETS_GET_LOCAL_CIDS:
>+		if (!transport_g2h || !transport_g2h->get_local_cids)
>+			goto fault;
>+
>+		rcu_read_lock();
>+		local_cids.nr = transport_g2h->get_local_cids(local_cids.data);
>+		rcu_read_unlock();
>+
>+		if (local_cids.nr < 0 ||
>+		    copy_to_user(p, &local_cids, sizeof(local_cids)))
>+			goto fault;
>+
>+		break;
>+
>+fault:
>+		retval = -EFAULT;
>+		break;
>+
> 	default:
> 		retval = -ENOIOCTLCMD;
> 	}
>-- 
>2.34.1
>



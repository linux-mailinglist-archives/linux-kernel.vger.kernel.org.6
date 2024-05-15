Return-Path: <linux-kernel+bounces-180042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAA08C6938
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0081C20C89
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6250913F422;
	Wed, 15 May 2024 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RaKnAD0u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B314415573A
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715785554; cv=none; b=Te0XFLh+Kg4ZriQ3wjjqVSyxheHgjdkggfND9UbwPox2LseEWxsesnbeZ+vDkn6a2CGPbr7yT8Cj3X9HABPiwhgWm0dRk7KbX+awKHcbCC7UGxuHR3mLpNR8fhZMpnd3kda+BBjCqawblpHeCTCBeRZZN/7s3UhkB2ZCay3WDgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715785554; c=relaxed/simple;
	bh=Eqhliyv/rLaqDzkaLcjCJEDibkGNoMMtCnsez51KbII=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VxmmRbQDOuYX5BvqPWQVVrXE9YP9sdazS0SaGHSgUUfcvItPiq70AwGJKKXuxV1cs4LE+p+Aq8XU7nibTkhMVTaHZAvNBRbukwPBSvd/CVfxs/Ya+LqdM8qqJgJ97Nz3oAt7oyVyG6/h70p7AO1dTXUYENk4idBYWPlqqevpsq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RaKnAD0u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715785551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5HsQnBBLUP3Pazt+byzwwgyn37KXCpOuxjPpikdkNik=;
	b=RaKnAD0upOAnyXuKS4DHDCqG/DA2VwmPONtYPreMeE1RGJKuHlvxg6atgk/fJDos5XmdxZ
	NCXlntdxzuLkQSYxmZSsdCMlVjfDwgCllYxE0/gxYUFT5X/KEnUBhzEkmGQSLU+QGTmp38
	NCgHQbeqWEH9SSUujB5DQZoe2T8ezSs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-QwLGscl4NcKhoQVJaz8M5Q-1; Wed, 15 May 2024 11:05:49 -0400
X-MC-Unique: QwLGscl4NcKhoQVJaz8M5Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41ec8ef128fso36237795e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 08:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715785547; x=1716390347;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5HsQnBBLUP3Pazt+byzwwgyn37KXCpOuxjPpikdkNik=;
        b=Ncq9YotlzN8SuaDIO3raryLsy7I130nm0i7e48Tq5OWPwf2X82Fv5dK0DJ/uesB4EB
         KN9hjqt+IgOzx46rl51qz139jgdKL8KbgjUlZ+CEdj+CpKoMT9yz7/APMUlPFnI5lRaf
         lDzvbnYIl+K48RQfxkKmIKnMtjqxvTY2UvGzMLlvExN3GbjTre6/ADpx7ErvQx74buVX
         IaHq+tsgtwykLUinXXpNQqPv1IklL2EoL9wvSevcdKEK6rf9vhhU53ONllAZmU1FWDFX
         4Foii51x0Eo7obifxKfIu9GYjjMVzhY3xmVsccjUJs4DAuPFeJ6dLMLDuriAYr1FtS6e
         3q6g==
X-Gm-Message-State: AOJu0YzU7XZkh0q4ureYz+OpT/EyXfW8Ldz04O8fWNKnXrusNd3A9Oc7
	9hd2MFY4rRqRGrHL/4MRnUN+9J8IlqF0VMa1zzDgzFzdC3GRWWW8w1kcgyt7AD8sgYEl6Y9a8Vn
	zwyySLjY7BfVlLbvXVpWb0ncvR3YD875aHz48gOwir0Ki/OZ6OCQFa1Y3fvhyeDfeAfVVu9+X5g
	3GIXwvMLLNoxTjYw+a20c3dhaw5PA9hXrBEb2tFnw=
X-Received: by 2002:a05:600c:a44:b0:41a:34c3:2297 with SMTP id 5b1f17b1804b1-41fea93a34cmr139868085e9.5.1715785547255;
        Wed, 15 May 2024 08:05:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwcKYJU04KRN+C9m9RrjwdUumM+NzjuDj85eoasrKYaMbDWv5ZX8CZUBelGxUEWCXHzSMp8A==
X-Received: by 2002:a05:600c:a44:b0:41a:34c3:2297 with SMTP id 5b1f17b1804b1-41fea93a34cmr139867595e9.5.1715785546575;
        Wed, 15 May 2024 08:05:46 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:c01e:6df5:7e14:ad03:85bd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41ff7a840d2sm197154985e9.39.2024.05.15.08.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 08:05:45 -0700 (PDT)
Date: Wed, 15 May 2024 11:05:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>,
	Arseny Krasnov <arseny.krasnov@kaspersky.com>,
	"David S . Miller" <davem@davemloft.net>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH] vhost/vsock: always initialize seqpacket_allow
Message-ID: <bcc17a060d93b198d8a17a9b87b593f41337ee28.1715785488.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

There are two issues around seqpacket_allow:
1. seqpacket_allow is not initialized when socket is
   created. Thus if features are never set, it will be
   read uninitialized.
2. if VIRTIO_VSOCK_F_SEQPACKET is set and then cleared,
   then seqpacket_allow will not be cleared appropriately
   (existing apps I know about don't usually do this but
    it's legal and there's no way to be sure no one relies
    on this).

To fix:
	- initialize seqpacket_allow after allocation
	- set it unconditionally in set_features

Reported-by: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com
Reported-by: Jeongjun Park <aha310510@gmail.com>
Fixes: ced7b713711f ("vhost/vsock: support SEQPACKET for transport").
Cc: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Tested-by: Arseniy Krasnov <avkrasnov@salutedevices.com>

---


Reposting now it's been tested.

 drivers/vhost/vsock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index ec20ecff85c7..bf664ec9341b 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -667,6 +667,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 	}
 
 	vsock->guest_cid = 0; /* no CID assigned yet */
+	vsock->seqpacket_allow = false;
 
 	atomic_set(&vsock->queued_replies, 0);
 
@@ -810,8 +811,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 			goto err;
 	}
 
-	if (features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET))
-		vsock->seqpacket_allow = true;
+	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
 
 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
 		vq = &vsock->vqs[i];
-- 
MST



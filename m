Return-Path: <linux-kernel+bounces-537941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BAEA492BC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECFA01887DC6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B181DFE29;
	Fri, 28 Feb 2025 07:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="Gqh3G4y2"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0E41DFD9F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729584; cv=none; b=SyBKn5LVqx6FKEpNLvTPQXEnPeP0ZVX0VjPge2fDEyGsLeoSh5MvJsWzSxp+KHBnm88YdrRpSj7L1XCLWOeRgrk6YTN31G0ErdFNVQ8OAg0W3z6fETyYoCAH1PNQo2xMB/a7QPdEIC/8Rq1DDIQwjfBgvBeZKhEXecXI9qNoUck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729584; c=relaxed/simple;
	bh=efUQp3xn6WYS8yAIVpG+8nNESAbDYNoZwtefI4rJo8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=SPWj/X4DVNLVipE5UBOm8QS9DkdKvxvehpJ3fwPjLnagAIXw6uTxp0xYmOT3DOMxiC1A1jl/CKl2YJDEEgrwNWD/3riD0cLm+E0BvN62+H4tkeumCAZ8HundA/WOhyz6KUFaT33g9OWqDQ9nRnhdMPOgVjKsjBmGxgHWveq6KQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=Gqh3G4y2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223594b3c6dso27895045ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 23:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1740729582; x=1741334382; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CnuaMjhFxZ/6ziAA9dAFSZFZKEXkUeKJopwW9aMJd8c=;
        b=Gqh3G4y2yorBO/wUaz28DqJk6URfzL07YhwzAUL57IgGeCHg6O6DSkNejc9o2yZ7fH
         flsoO6pzdk3tR/aSXtXLRxfSEXnEHdItVrWOre62JaOKjXmCjTj25BAYYyjsKniEZzGS
         sNazzvKEdKrXHt1+/oWpILl0SCqG3UR+WL8Gv944EroJBOlO4mOPFnEZc5RhjbIyOlo5
         9kjqG30zibL60i3DGe7f5ZCgb7wrL8hzTA7gdHN3nS2sQwo8mG/lWFvo9IGTRP53D1aL
         DKHud9VDFXR6C9hzCivxtuJx9SZrBQJlxY5BE69XolHh6Eyb25tDGgpDOdVNapQFpG3c
         9Wtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740729582; x=1741334382;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnuaMjhFxZ/6ziAA9dAFSZFZKEXkUeKJopwW9aMJd8c=;
        b=aDtjtILZlgwB7YK/L/Cwzh100AUSf0ZQerCCWGxRIJMvX5RCoWt5t9cErkL2Ygt6ky
         63JMikNa+2f44agm2RqzkJEaUeX7rw/HpunjVDa4nkHZPckh4QqAOQe+YdoKQyUwcYfY
         6Rdxa0fTPs9uVLCFgoBJKZqwCbVc4By/QWjFUlWS4da0GvcPWUUAGfj96DS0AsBZn5nM
         s/UrjvWnNF+4Aav9Za7Lpil+I/R4ld9SDWF2+F+Ebmh3KMEvZR+dz0H+1cKnif90PWlT
         HimEDe5VfsPPzPrJ4nE9rEwcXfiLDMQGRW9n6IuHlWZkrmbEkElD1z7a2zC3NcynJ37e
         cNvw==
X-Forwarded-Encrypted: i=1; AJvYcCUnmLA3WsgAGg3ybufqPc4K/a+yFFkDYJJSrqU6VMJgcv7ND1mLqQcUGEcHQ87luWcJEIrJWqup9d/bMSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHLX3RYY3mttPZwlWD+XFH9nCQGonCXi3l9pMXaWtGvZrfR8Xq
	tsLTkPDQfJqCAK15BF/7rWIs7p2XWI0gMUuZSj1Zrk2Y+sjrzsZhcJD0BrNN90c=
X-Gm-Gg: ASbGncuxPT4HvvoEi9qHiQ9NlzT7qo3/WcboLKt1BJBQpHLaymKBLAX3bPXbtwgM9UR
	tw8Kw869Risr2vru/jQFNx9QMiycqmaRAuKfF4wrBdvu8S/2KjVFa4yTypy3nvUM8iEvEywu24W
	rO58ojfwDvSKl4YoRqenJQmGLcje8+DG+XA8GaXEyAr71TXUStGPLa0zJvQ37MRn6DMxe2YPCfI
	B6tb1D5xcz7AMX58VNG7dN2xHRCWQiFUGcoDsmTsE7TgDGIWwvjc/SW9OgQxQ9pU3Pj4SXU5b5n
	lJCoFjJ7aGcouFkEouli6uKCAvNOIw==
X-Google-Smtp-Source: AGHT+IEHq9KgafAA2Kp/V3wkg5JFswjExpfT3tDMSfV41fmOxWgxIOQNfI70dD7nhe9dRE8LZJt4RQ==
X-Received: by 2002:a17:902:ce91:b0:223:64bb:f657 with SMTP id d9443c01a7336-2236922352bmr33953935ad.46.1740729582283;
        Thu, 27 Feb 2025 23:59:42 -0800 (PST)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2235050f18bsm27632835ad.213.2025.02.27.23.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 23:59:41 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 28 Feb 2025 16:58:52 +0900
Subject: [PATCH net-next v7 6/6] vhost/net: Support
 VIRTIO_NET_F_HASH_REPORT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-rss-v7-6-844205cbbdd6@daynix.com>
References: <20250228-rss-v7-0-844205cbbdd6@daynix.com>
In-Reply-To: <20250228-rss-v7-0-844205cbbdd6@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 Lei Yang <leiyang@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2

VIRTIO_NET_F_HASH_REPORT allows to report hash values calculated on the
host. When VHOST_NET_F_VIRTIO_NET_HDR is employed, it will report no
hash values (i.e., the hash_report member is always set to
VIRTIO_NET_HASH_REPORT_NONE). Otherwise, the values reported by the
underlying socket will be reported.

VIRTIO_NET_F_HASH_REPORT requires VIRTIO_F_VERSION_1.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/vhost/net.c | 49 +++++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index b9b9e9d40951856d881d77ac74331d914473cd56..16b241b44f89820a42c302f3586ea6bb5e0d4289 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -73,6 +73,7 @@ enum {
 	VHOST_NET_FEATURES = VHOST_FEATURES |
 			 (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
 			 (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
+			 (1ULL << VIRTIO_NET_F_HASH_REPORT) |
 			 (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
 			 (1ULL << VIRTIO_F_RING_RESET)
 };
@@ -1097,9 +1098,11 @@ static void handle_rx(struct vhost_net *net)
 		.msg_controllen = 0,
 		.msg_flags = MSG_DONTWAIT,
 	};
-	struct virtio_net_hdr hdr = {
-		.flags = 0,
-		.gso_type = VIRTIO_NET_HDR_GSO_NONE
+	struct virtio_net_hdr_v1_hash hdr = {
+		.hdr = {
+			.flags = 0,
+			.gso_type = VIRTIO_NET_HDR_GSO_NONE
+		}
 	};
 	size_t total_len = 0;
 	int err, mergeable;
@@ -1110,7 +1113,6 @@ static void handle_rx(struct vhost_net *net)
 	bool set_num_buffers;
 	struct socket *sock;
 	struct iov_iter fixup;
-	__virtio16 num_buffers;
 	int recv_pkts = 0;
 
 	mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
@@ -1191,30 +1193,30 @@ static void handle_rx(struct vhost_net *net)
 			vhost_discard_vq_desc(vq, headcount);
 			continue;
 		}
+		hdr.hdr.num_buffers = cpu_to_vhost16(vq, headcount);
 		/* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
 		if (unlikely(vhost_hlen)) {
-			if (copy_to_iter(&hdr, sizeof(hdr),
-					 &fixup) != sizeof(hdr)) {
+			if (copy_to_iter(&hdr, vhost_hlen,
+					 &fixup) != vhost_hlen) {
 				vq_err(vq, "Unable to write vnet_hdr "
 				       "at addr %p\n", vq->iov->iov_base);
 				goto out;
 			}
-		} else {
+		} else if (likely(set_num_buffers)) {
 			/* Header came from socket; we'll need to patch
 			 * ->num_buffers over if VIRTIO_NET_F_MRG_RXBUF
 			 */
-			iov_iter_advance(&fixup, sizeof(hdr));
+			iov_iter_advance(&fixup, offsetof(struct virtio_net_hdr_v1, num_buffers));
+
+			if (copy_to_iter(&hdr.hdr.num_buffers, sizeof(hdr.hdr.num_buffers),
+					 &fixup) != sizeof(hdr.hdr.num_buffers)) {
+				vq_err(vq, "Failed num_buffers write");
+				vhost_discard_vq_desc(vq, headcount);
+				goto out;
+			}
 		}
 		/* TODO: Should check and handle checksum. */
 
-		num_buffers = cpu_to_vhost16(vq, headcount);
-		if (likely(set_num_buffers) &&
-		    copy_to_iter(&num_buffers, sizeof num_buffers,
-				 &fixup) != sizeof num_buffers) {
-			vq_err(vq, "Failed num_buffers write");
-			vhost_discard_vq_desc(vq, headcount);
-			goto out;
-		}
 		nvq->done_idx += headcount;
 		if (nvq->done_idx > VHOST_NET_BATCH)
 			vhost_net_signal_used(nvq);
@@ -1607,10 +1609,13 @@ static int vhost_net_set_features(struct vhost_net *n, u64 features)
 	size_t vhost_hlen, sock_hlen, hdr_len;
 	int i;
 
-	hdr_len = (features & ((1ULL << VIRTIO_NET_F_MRG_RXBUF) |
-			       (1ULL << VIRTIO_F_VERSION_1))) ?
-			sizeof(struct virtio_net_hdr_mrg_rxbuf) :
-			sizeof(struct virtio_net_hdr);
+	if (features & (1ULL << VIRTIO_NET_F_HASH_REPORT))
+		hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
+	else if (features & ((1ULL << VIRTIO_NET_F_MRG_RXBUF) |
+			     (1ULL << VIRTIO_F_VERSION_1)))
+		hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
+	else
+		hdr_len = sizeof(struct virtio_net_hdr);
 	if (features & (1 << VHOST_NET_F_VIRTIO_NET_HDR)) {
 		/* vhost provides vnet_hdr */
 		vhost_hlen = hdr_len;
@@ -1691,6 +1696,10 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 			return -EFAULT;
 		if (features & ~VHOST_NET_FEATURES)
 			return -EOPNOTSUPP;
+		if ((features & ((1ULL << VIRTIO_F_VERSION_1) |
+				 (1ULL << VIRTIO_NET_F_HASH_REPORT))) ==
+		    (1ULL << VIRTIO_NET_F_HASH_REPORT))
+			return -EINVAL;
 		return vhost_net_set_features(n, features);
 	case VHOST_GET_BACKEND_FEATURES:
 		features = VHOST_NET_BACKEND_FEATURES;

-- 
2.48.1



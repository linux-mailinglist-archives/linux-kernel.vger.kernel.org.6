Return-Path: <linux-kernel+bounces-242300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6401392866A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E532282D6D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DE01482FD;
	Fri,  5 Jul 2024 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gEqF0Wvv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5433F147C82
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 10:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720174146; cv=none; b=fU/Su9iNuFj0bGul4A5RscotcGvsAVqug0KGgU9w2mJhv0VzpabOF9L+M18uvzedINY+Xe981N568r8iquy5d7hmtUr8I2uNoT32VqPCQXTURztCCky2bbjsgtNv+sHw1jUSHhSyvkvZqhcLVP5Mx61xGPAd8RzyekLHwShX27A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720174146; c=relaxed/simple;
	bh=rMLjExNgz/IU1O7Z+G9luUh0k8XaToBZvPbBUK3llI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWbNhPxqcmVML/JmcwFFsr6ZCdM8VRDyFD6K6gjCYjYq4qMnmyMlO45g+rfi093H96efScP+pZsoAqrQvo/4QDQ7irWO4a6Z96i/pVPtUjadtwiYEkbVxxGYlYwUH4wealenBrdCXvV/pbYQYUurI1DvrvTMTmgpeKKHO79rNec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gEqF0Wvv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720174144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e2G39rZ+nqGSoo1qiWSSlqDlIEz6QAAgqtld8n+Pdxs=;
	b=gEqF0WvvlmMg/vhnTTJ8SkGjrskUC7xdlZEx15jDaugV+CIKVszEEpk69uwCnx8430XeLf
	7xR5RI8TqFWnSw1jh1NRHLgTEF+V8M5m+OO3czdatZbcB+cZlkMBx0TgaMKnk0DlfPKWFm
	xr1sCvvDeZat4MCJMjaNwc8z+MiAUec=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-MJ6DwY4VNSSRiyRGwO97eA-1; Fri, 05 Jul 2024 06:09:03 -0400
X-MC-Unique: MJ6DwY4VNSSRiyRGwO97eA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3678fd1edf8so1353692f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 03:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720174141; x=1720778941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2G39rZ+nqGSoo1qiWSSlqDlIEz6QAAgqtld8n+Pdxs=;
        b=RqxIsYeyWZctofTAiydtwzfbKJVn59E9Df+wPRM2XOGQo0SVtezmQ3U3no7pKlSYgT
         eCEsNrMTWKXqpmtSuwO08nHqa7+r50SMEWu3Jtx6WJLmj6k8eelKvlsd716ex2zbC3g2
         lJRfqMGxEh36umT7WSgiu5fxSrcuJODeQWFYhGBVzZ37ZW3BXrSStF8KcEvMwGDGWo5M
         e98+BWQQ+gvWsRpg6Ov10pVg6we/Fi5IjkdNLPvYiruaP3i+eyc5CKgfsMJNtGV7ZZwT
         /hq5aqOY5+w0mkDHsJi0PUUpkMT210/M6tXiNYahLYpddxp3wndgiCZMpHOA2uTDXATl
         /fdA==
X-Gm-Message-State: AOJu0YyhsoUU8agL46mGDp1fsdbAtGeCCOacp0SOS+s3Cg5jxTIHjcT/
	j2BqwTcw2SIazMkUVW+TzBJdWDajS6jJVu/OVPR+3AfomQS1hegzmB914oCI/Vp/jA9nwqM+uR+
	gQZI0a7wJPdYTFzE6TixD2Sp+R31+fy4wlA6DHDLbOs8jLiSrlWaLIsdKjf2zqRVoP/1mGJ5dFV
	X/eArqY5LHN1dXB+2AF/z3A8yL7T8Fz20epiajnPY=
X-Received: by 2002:adf:f8d0:0:b0:367:8fe2:7d8b with SMTP id ffacd0b85a97d-3679f76fd93mr3949989f8f.31.1720174141133;
        Fri, 05 Jul 2024 03:09:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMAgWFq4fXL1Je4jdABy0qUuf3ABlgDmJ2qvyznosNn3i9WEJUQp3T1tA9aMRJHM7r/dA6jg==
X-Received: by 2002:adf:f8d0:0:b0:367:8fe2:7d8b with SMTP id ffacd0b85a97d-3679f76fd93mr3949954f8f.31.1720174140593;
        Fri, 05 Jul 2024 03:09:00 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:a185:2de6:83fc:7632:9788])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d0bd6sm55952075e9.8.2024.07.05.03.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:09:00 -0700 (PDT)
Date: Fri, 5 Jul 2024 06:08:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 1/2] virtio_balloon: add work around for out of spec QEMU
Message-ID: <14b1a2a1acfcaf6d519db8c67f6f207d7cdd7c3b.1720173841.git.mst@redhat.com>
References: <cover.1720173841.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720173841.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

QEMU implemented the configuration
	VIRTIO_BALLOON_F_REPORTING && ! VIRTIO_BALLOON_F_FREE_PAGE_HINT
incorrectly: it then uses vq3 for reporting, spec says it is always 4.

This is masked by a corresponding bug in driver:
add a work around as I'm going to try and fix the driver bug.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 9a61febbd2f7..7dc3fcd56238 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -597,8 +597,23 @@ static int init_vqs(struct virtio_balloon *vb)
 
 	err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
 			      callbacks, names, NULL);
-	if (err)
-		return err;
+	if (err) {
+		/*
+		 * Try to work around QEMU bug which since 2020 confused vq numbers
+		 * when VIRTIO_BALLOON_F_REPORTING but not
+		 * VIRTIO_BALLOON_F_FREE_PAGE_HINT are offered.
+		 */
+		if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING) &&
+		    !virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+			names[VIRTIO_BALLOON_VQ_FREE_PAGE] = "reporting_vq";
+			callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = balloon_ack;
+			err = virtio_find_vqs(vb->vdev,
+					      VIRTIO_BALLOON_VQ_REPORTING, vqs, callbacks, names, NULL);
+		}
+
+		if (err)
+			return err;
+	}
 
 	vb->inflate_vq = vqs[VIRTIO_BALLOON_VQ_INFLATE];
 	vb->deflate_vq = vqs[VIRTIO_BALLOON_VQ_DEFLATE];
-- 
MST



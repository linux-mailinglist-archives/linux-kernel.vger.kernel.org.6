Return-Path: <linux-kernel+bounces-223201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C577911043
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8E96B24854
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012DE1B373C;
	Thu, 20 Jun 2024 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4DectiFN"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A501B0115
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 17:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718905940; cv=none; b=UgeUbhk2HK66nqSpFIzdeZB+Pp3AcHkxh82A48RIufMkAHnjL6y4hzEDOLgisdvzekIbnQ3VJtCKCzeBVtxxHUWLWAn9HfeRicMBpgegwkXHNRk3bdgbjnEBo7WKx12eo+VsqFdgzmakkWC4WZ+A/ghkySxZpolAHgCsrmD8tps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718905940; c=relaxed/simple;
	bh=TLEjZsKdmpxVXXLteU7nv3fBpHDmfyE0TGvbdCsV6pk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SJYjFG3m4d2gd2Mw7Y5fP0jMNruWl1jOUmIT+sLWhA53rRyT10HRH7u1gDvUvOtEae9ubaib/SxH5q1ih7BCwPeLHVMHW2egx5e0NU7oDhI1UbVnz9xUgj1HYuQGv8L7FKk65aIF0XC+1ynR5MVOJi7gv/X1nmq2nIkSU7pne24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rkir.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4DectiFN; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rkir.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62f43c95de4so21802737b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 10:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718905938; x=1719510738; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sm2gpa6hcQ4RATrD54TnpEVi32e1itP79MJvvCbKJQU=;
        b=4DectiFNIO4pJddMnodVmQYM+WjIJBV2wUKaW1hGj8dOzakhgB6X6r6M0Y08Q/lkuL
         OMy0L+ED8slxcFVV/jRfLbIkdc0bWX5CnJvx9FPVtCQhaZudylWb0I1KRFL3NPgcl0gD
         +I2YU69jBqUySHxDIXMHm8bYNWwxXcalbFdEL7cchsRxGgge6bWulAZcCL9/G3viznA/
         iOW/BavgnrqMpa7DefW9yHydHAdwrTSM00BppRI/vy8kislFiOJt59hcKQIV2uBOO+JG
         cE6rwsVJIyZezlDG84Gn6O4zVEDEhIUq5l+k+wYgt3peUj04Xi7j3U8AHFv0U5By8ISc
         j8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718905938; x=1719510738;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sm2gpa6hcQ4RATrD54TnpEVi32e1itP79MJvvCbKJQU=;
        b=QMsuo9sEOF8TaEs3p5tGC0kii+i3iauTFl7j4cb1hSnRvR3ytXEOL3n9OKPxOB9THq
         6U/6VzQ+NwxNi8HuYcKqqWeFzKb2prhhWHmA8qvUNwFMbwr/kFQyS8dXzvuzZ2SlzmTA
         9/Yas0DaO24DHvQQkPRIijvYC6pv1hEGE17v8Z28u1/7kI9XOGp31y9M4ThKjCXQlY18
         1Pd5PPPnj00LIRQ1JHyyEf5J0BD1emrmx49zRi94Fm4a/5Y0VLKcrOrDeb/GlQZTLrc2
         8OfzmXzxp/7E7lkLCwPzDlVX4kUhPp9IfknSjtcjOsfsUzp+gn/O+D6N+2i0wOZSako4
         Bn3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNSv5D02X+T6SkzKrM2oCTSZfelzokblD2zjH8ekmjpASK4eaG/w8587Kp87xcUwPKMff+mVA23Uajh+Z+wT4iD5AlRZlTeMyZ8faN
X-Gm-Message-State: AOJu0YwdWnEnA560NUo2UVP1h1tKOVlpLZOWagunLJf87Gd6oK2v6SYo
	s/MbSdmRSSEuC0CapYpbreZJQoxN8eT4fCp8kPCahOZE1b3QSSEPsET7CYQzyYCzygCfqA==
X-Google-Smtp-Source: AGHT+IFuWlbIslAeTyNzbjywNAP+777MiMdKK+WPP+r9rQlqEuhXFSUkwwTiQkmcp9ClrNjd1fkYkL4d
X-Received: from rkir98.kir.corp.google.com ([2620:15c:7d:4:df4:7552:4ba4:9441])
 (user=rkir job=sendgmr) by 2002:a05:690c:ec4:b0:61b:e689:7347 with SMTP id
 00721157ae682-63a8dc08e63mr14852627b3.2.1718905937949; Thu, 20 Jun 2024
 10:52:17 -0700 (PDT)
Date: Thu, 20 Jun 2024 10:52:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240620175214.515211-1-rkir@google.com>
Subject: [PATCH] UAPI: Make virtio_ring.h C++ friendly
From: Roman Kiryanov <rkir@google.com>
To: mst@redhat.com, linux-kernel@vger.kernel.org
Cc: jansene@google.com, mett@google.com, jpcottin@google.com, 
	Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"

virtio_ring.h is an UAPI files which could
be used by code outside of the linux kernel
which could be written in C++.

Google-Bug-Id: 331190993
Change-Id: Ib27c1e57c273ec5613b4e745a3ab4d53bdde5aac
Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 include/uapi/linux/virtio_ring.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
index f8c20d3de8da..be88871d512b 100644
--- a/include/uapi/linux/virtio_ring.h
+++ b/include/uapi/linux/virtio_ring.h
@@ -199,11 +199,13 @@ struct vring {
 static inline void vring_init(struct vring *vr, unsigned int num, void *p,
 			      unsigned long align)
 {
+	struct vring_desc *desc = (struct vring_desc *)p;
+
 	vr->num = num;
-	vr->desc = p;
-	vr->avail = (struct vring_avail *)((char *)p + num * sizeof(struct vring_desc));
-	vr->used = (void *)(((uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
-		+ align-1) & ~(align - 1));
+	vr->desc = desc;
+	vr->avail = (struct vring_avail *)(desc + num);
+	vr->used = (struct vring_used *)(((uintptr_t)&vr->avail->ring[num]
+		+ sizeof(__virtio16) + align-1) & ~(align - 1));
 }
 
 static inline unsigned vring_size(unsigned int num, unsigned long align)
-- 
2.45.2.741.gdbec12cfda-goog



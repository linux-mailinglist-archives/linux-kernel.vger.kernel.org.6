Return-Path: <linux-kernel+bounces-549282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D848A55046
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B05A7A6740
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A51211466;
	Thu,  6 Mar 2025 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+TqtizB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBDC211A14
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277437; cv=none; b=eG6FFADt74dzoj62Djug7dnoVmzi3aZsl6y2Bftv8YLtz1Sfsj3pDeRsWq+Edn+FkCjU/O3Eb+TMB1NrU74hUDHbi/nJe64T4Kk41r8Yvs/HVxvebT6LgYts9vNYvYSz7shTA4LZol98V6SDR7XZ7bSti3A7sw1OvOIankZPvQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277437; c=relaxed/simple;
	bh=Pt96Uovd1mpbJtnbuJAU2P1Aa68DKtd8BuptUSAoifY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QCoHQmGy0zFAe2U50W1wzySibhwuHlWIJ8gvONPoBKHYeaOHiZaHYFyinvkktNegnJHLo9oMOjPaQOG009YSCiQ5zzh65KL5gz3uRrFn0U8A0ArUwMWSssi3Wmz7GCWs7FSl1yl961fc1ZpoTLk45aht/bgZY41OCQJ+s+7W+ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+TqtizB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741277434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TFLrlOS+5ld0nvFR1DksJ9cDKB3+2CeK8laqLKQbEAA=;
	b=C+TqtizB6yY3DnXD/6TlAD8uz4eG1/X1/ZF7z9st59ASkuEgavxYvmc5Zn7mDLArJF0cLy
	EaUpTic/DHQLCrJ3Qz193G26y3dU6sbQHsNsBKINBQzAFohjXsnUMVBKg+t/o3mhOuglHm
	JESP75B1lZEhvMxCGSTQAa1AT0zBMzY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-SN9CoHOCOgye9MyNMRA4Bg-1; Thu, 06 Mar 2025 11:10:32 -0500
X-MC-Unique: SN9CoHOCOgye9MyNMRA4Bg-1
X-Mimecast-MFC-AGG-ID: SN9CoHOCOgye9MyNMRA4Bg_1741277431
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4388eee7073so10793485e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 08:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741277431; x=1741882231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFLrlOS+5ld0nvFR1DksJ9cDKB3+2CeK8laqLKQbEAA=;
        b=HSVXbMlYpb4OhJ3FkzHpnnP0hbCTG1ELVmAGq7aQH2QwhlR0LE8Cc2ACHc0ts7lMaV
         YWm051wk8sa/zzYKCMmZ6yFab/T3qTrJixkDcu5se8sXILcWXPLmyKPuYf0NhJlBHNBS
         qUwRXALmhz93WEctedf+76eGrw7nW8NKgz89ACQDp3d5gm2T8GVBWxeiao4fxqjgyJmd
         WCd2TubJf93QYG1FqJsBDuST5cBWm2DKq3MBFl+iBVrB7/sZByrNWWrUmVTTcHur8iZz
         GAWK+Xby+enfJpxQmGU+U2KEslOuf4Yk4a+Ikg398ZIRKVxVdZhfs8K5iGFxHRAYDDRZ
         gfdw==
X-Forwarded-Encrypted: i=1; AJvYcCVHJt3hkZtbQuMZtrPG0+xj+TnSrS6980K2D/Ch1FkkblTRfld2jKzwbDxcTE2nADNWoM2skHSO7MqdBjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDo7id07Olt5gowxftVUuFr0LF76qyOeEhkb+lkl8YagmOfEa1
	WSfEYLZskyIKVxet0qP75OPbZDZU0GCAYbxpC4TnTBqbNU4/EpSmAcj33JluAk8TnrL9fxEFkgI
	8zM1jFrBzjFgBaCrkfTTL/8ATmeAlaljqnbvLydsQ/o2KTL2gf946H+FRsorAMbkofDBH8xjwRx
	4z7SZFk8W7I81UBvxj2cLX96zABO6St/3AXUu4Trha0EWaZw==
X-Gm-Gg: ASbGncu7ZO2O4OoQJLcW5naj6Qb/3nLJJ1xObwBKHaUUe/gqPY6p7z443Mv9aeMYgfy
	b2AcUEZaAI+YrtO9zQPqKcdA9AHIQ1GcHRArnkreX6jxyTtcA7TcZX4ZoX45HDve3jVlsBw6rf+
	YfFlwR6+uxSEgw1MDUCKwKBfonJ5djqhNdnJ5vCywROkFs5cnllucx7NAoxPyREIXWnJWEzv0BQ
	J9d3qxXNX/smXI4szM4Fr4qFw8tIcnjqn3MPlJMe/pBFK4ebwvMGANheQ3w6QLCDg3xAaF3q3lu
	/CzzHjiYDVgJhRChBn+ODk6BZP/yRtg7EoLKuLD3SN1q
X-Received: by 2002:a05:6000:1842:b0:38d:b52d:e11c with SMTP id ffacd0b85a97d-391320a39c5mr75424f8f.15.1741277431154;
        Thu, 06 Mar 2025 08:10:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdg1mu+YRP1IQFJUy+MGaPyfw9bRzO4/4jxtF7UGS83/MvazwuQz4R3F7VzC0vThUykW3fnQ==
X-Received: by 2002:a05:6000:1842:b0:38d:b52d:e11c with SMTP id ffacd0b85a97d-391320a39c5mr75368f8f.15.1741277430721;
        Thu, 06 Mar 2025 08:10:30 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb ([151.29.33.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01cd31sm2477950f8f.52.2025.03.06.08.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:10:30 -0800 (PST)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Thu, 06 Mar 2025 17:09:32 +0100
Subject: [PATCH net-next 1/2] vsock/test: Add new function to check for
 timeout
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-test_vsock-v1-1-0320b5accf92@redhat.com>
References: <20250306-test_vsock-v1-0-0320b5accf92@redhat.com>
In-Reply-To: <20250306-test_vsock-v1-0-0320b5accf92@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2

Add `timeout_check_expired` function that returns true if the timeout
counter has expired.

This is useful in situations where a timeout does not necessarily mean a
failure.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 tools/testing/vsock/timeout.c | 7 ++++++-
 tools/testing/vsock/timeout.h | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/vsock/timeout.c b/tools/testing/vsock/timeout.c
index 44aee49b6cee07deb9443e3c2595ef680b726053..d6c69b14a0385befa6204a311c0a7f0c148ab021 100644
--- a/tools/testing/vsock/timeout.c
+++ b/tools/testing/vsock/timeout.c
@@ -18,7 +18,6 @@
  */
 
 #include <stdlib.h>
-#include <stdbool.h>
 #include <unistd.h>
 #include <stdio.h>
 #include "timeout.h"
@@ -43,6 +42,12 @@ void timeout_begin(unsigned int seconds)
 	alarm(seconds);
 }
 
+/* Check if timer has expired */
+bool timeout_check_expired(void)
+{
+	return timeout;
+}
+
 /* Exit with an error message if the timeout has expired */
 void timeout_check(const char *operation)
 {
diff --git a/tools/testing/vsock/timeout.h b/tools/testing/vsock/timeout.h
index ecb7c840e65ae5d40419bf5f9ca57fdf4051aa41..cbb183e3a73784b82b2139fbf7a00fd62521ad77 100644
--- a/tools/testing/vsock/timeout.h
+++ b/tools/testing/vsock/timeout.h
@@ -2,6 +2,8 @@
 #ifndef TIMEOUT_H
 #define TIMEOUT_H
 
+#include <stdbool.h>
+
 enum {
 	/* Default timeout */
 	TIMEOUT = 10 /* seconds */
@@ -10,6 +12,7 @@ enum {
 void sigalrm(int signo);
 void timeout_begin(unsigned int seconds);
 void timeout_check(const char *operation);
+bool timeout_check_expired(void);
 void timeout_end(void);
 
 #endif /* TIMEOUT_H */

-- 
2.48.1



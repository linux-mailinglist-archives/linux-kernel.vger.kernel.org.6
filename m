Return-Path: <linux-kernel+bounces-393009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2287C9B9ABF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 23:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBFB628207B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 22:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E751EB9F9;
	Fri,  1 Nov 2024 22:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MmQKJi8n"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCFC1E7C37
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 22:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730499445; cv=none; b=GGLlZRghaSIlbmyFkmw0Rj6VUQ5xNGTa8wv/kOWAltEd3Neo899L/fYqZGNb4cjS7fB85Yr5c+fsxfY96qcv5lDK0RUqG/9wgVYMdSzTo+lR9vBfft/aZMsPgY4eQWGGO0Gbc9Z+13K3GXKJXHaJSnBZSkF3GN1CUnQUSw3C3Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730499445; c=relaxed/simple;
	bh=howDg03PUqT5uHKdURne7uP61TjoAOHxS8hGuGevvVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S2EYj0LtIRkFTB8WaxsjgPdpnvrsCNxxk9vuwPYSiNXvFv0J7nGte+QsE50FgzBfi/qH2AQejSQXi7E0KId/Rrd8/1KuJwgviZ+niDgPy/32s26soRhLarrNFg1VhBuRyc2LQHHezekhSw3NyVIOPFmArgmD+gpWCHrTI0PLbVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MmQKJi8n; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7181285c7c4so1236100a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 15:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730499443; x=1731104243; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5Y1tvObaqLtYvvCPOD8mS69Ek9mYQwEF5EMFUWXabY=;
        b=MmQKJi8nIJpLcpBz+K6jwSaeBBtOIw/xPY5q/R6ClpR9Cws5eSGT5o4qyxTrCyZJEd
         +YmYst5qZd4MetlcQu+332IXj3dTfIs31oXx403HwmfJYJkAm1c8Conn65MHHX7JVQ83
         3c4mj/f4T+RMgaitEum7Sdp/mS5Pa9eWtgZxrbxTyMVUMI5P5gVgZNOSt1ZUZN5I0eUy
         hfG97IhQZF/i6fV9H6JI4aIBBuGM3CwJKw/bb7G/ymqBHewbNANjh8TdEFMpvdzvRmUG
         YaYs69+m7efsKPQYvJMCmbirCSFFzYriKX3zLRuCJK+BOU82fypGX2Ynw60fclpJ3vS1
         3lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730499443; x=1731104243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5Y1tvObaqLtYvvCPOD8mS69Ek9mYQwEF5EMFUWXabY=;
        b=mHWEt63uPWTK1FR81LILPxKgkLAollcHNn7unolbn3fr3B59lPaRmQEjjjY9eB97P8
         TLIKN4KX9RGkZrqhGKMwUNQJP7QOlyayMyZlRioEdUIyXFhLF5RYZcBlcG4X2wB5f0XI
         A10QEx9+Ir653FHOvpXmJZGmHhyG2UsUkPqn1Jt1UAaWtzbyDjHdKCd408iUSWvXszLk
         LzMocaD5VE+YAXfjvEixiy74Cu22JJuRSO802wucVgomFQCsn44tWvbe/AjxwMJ1CyU8
         oMQUsHi2MayQ8k/Pagedd5UHVi7sWkJsl6IkQJFRD3hYvO1GBFxNT9PfpIntHrV2chDW
         9zRA==
X-Forwarded-Encrypted: i=1; AJvYcCXbF7ZiXsRONTPCem4BEXRidV4fyB27mTnIHuAbYlQxe2rcl1cEgWA7T9HFdsUtewfvkSiQIE/5eNk7+zE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1R9hYbYxCdW8zt5lXJIPGhlXfJ7sYwX7r783lUvk9rfWq8OGj
	zlUQfq73MRE5GpvkWJ/lrrlYIRxxMLh1aSilpgvY9at+2BcEVE4jp8TnhxYvTaA=
X-Google-Smtp-Source: AGHT+IFwkbWKQ4IGA+r9HW9czIJ7AoQH9s1W0J0JftvMv3EZw3NwVqMe4Cj+MED97B4IZFL9AP8xkQ==
X-Received: by 2002:a05:6830:3748:b0:718:9c7c:2b33 with SMTP id 46e09a7af769-719ca2472b6mr5863742a34.23.1730499443202;
        Fri, 01 Nov 2024 15:17:23 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec70698049sm789817eaf.48.2024.11.01.15.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 15:17:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 01 Nov 2024 17:17:10 -0500
Subject: [PATCH 3/3] iio: events: make IIO_EVENT_CODE macro private
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-iio-fix-event-macro-use-v1-3-0000c5d09f6d@baylibre.com>
References: <20241101-iio-fix-event-macro-use-v1-0-0000c5d09f6d@baylibre.com>
In-Reply-To: <20241101-iio-fix-event-macro-use-v1-0-0000c5d09f6d@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Make IIO_EVENT_CODE "private" by adding a leading underscore.

There are no more users of this macro in the kernel so we can make it
"private" and encourage developers to use the specialized versions of
the macro instead.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/iio/events.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/iio/events.h b/include/linux/iio/events.h
index eeaba5e1525e..72062a0c7c87 100644
--- a/include/linux/iio/events.h
+++ b/include/linux/iio/events.h
@@ -10,7 +10,7 @@
 #include <uapi/linux/iio/events.h>
 
 /**
- * IIO_EVENT_CODE() - create event identifier
+ * _IIO_EVENT_CODE() - create event identifier
  * @chan_type:	Type of the channel. Should be one of enum iio_chan_type.
  * @diff:	Whether the event is for an differential channel or not.
  * @modifier:	Modifier for the channel. Should be one of enum iio_modifier.
@@ -19,10 +19,13 @@
  * @chan:	Channel number for non-differential channels.
  * @chan1:	First channel number for differential channels.
  * @chan2:	Second channel number for differential channels.
+ *
+ * Drivers should use the specialized macros below instead of using this one
+ * directly.
  */
 
-#define IIO_EVENT_CODE(chan_type, diff, modifier, direction,		\
-		       type, chan, chan1, chan2)			\
+#define _IIO_EVENT_CODE(chan_type, diff, modifier, direction,		\
+			type, chan, chan1, chan2)			\
 	(((u64)type << 56) | ((u64)diff << 55) |			\
 	 ((u64)direction << 48) | ((u64)modifier << 40) |		\
 	 ((u64)chan_type << 32) | (((u16)chan2) << 16) | ((u16)chan1) | \
@@ -41,7 +44,7 @@
 
 #define IIO_MOD_EVENT_CODE(chan_type, number, modifier,		\
 			   type, direction)				\
-	IIO_EVENT_CODE(chan_type, 0, modifier, direction, type, number, 0, 0)
+	_IIO_EVENT_CODE(chan_type, 0, modifier, direction, type, number, 0, 0)
 
 /**
  * IIO_UNMOD_EVENT_CODE() - create event identifier for unmodified (non
@@ -53,7 +56,7 @@
  */
 
 #define IIO_UNMOD_EVENT_CODE(chan_type, number, type, direction)	\
-	IIO_EVENT_CODE(chan_type, 0, 0, direction, type, number, 0, 0)
+	_IIO_EVENT_CODE(chan_type, 0, 0, direction, type, number, 0, 0)
 
 /**
  * IIO_DIFF_EVENT_CODE() - create event identifier for differential channels
@@ -65,6 +68,6 @@
  */
 
 #define IIO_DIFF_EVENT_CODE(chan_type, chan1, chan2, type, direction)	\
-	IIO_EVENT_CODE(chan_type, 1, 0, direction, type, 0, chan1, chan2)
+	_IIO_EVENT_CODE(chan_type, 1, 0, direction, type, 0, chan1, chan2)
 
 #endif

-- 
2.43.0



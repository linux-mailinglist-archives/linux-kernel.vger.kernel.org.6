Return-Path: <linux-kernel+bounces-526214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDF6A3FBD9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4BB882829
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D8C20CCF4;
	Fri, 21 Feb 2025 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NY8vt4qD"
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83E0209669
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155705; cv=none; b=cfNdBBspZYbPWHtauCchzDGdPlNzHuOkdBGBqYY+NUmn8GGnqx/ueNigigK2vL77w4OVt4WfCcSYnS763Ct7KJQNDLDF62j7bQ/aEqwpqBWIcvICw4BQY2pNIkUkNQX/GYEaygQZWfyzk0S60Ia+NO2tUiffs3PVBLAxX/6Xp7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155705; c=relaxed/simple;
	bh=fpeqhpGWkHurwYKTB1xKAEQUJ9Ttk3Bi42IWr/pT15I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lrhm86IKj9df9L7i7w+UAhfsbPUmIuZB85MqnvCxNmdzMMy3tAbjkvSUJG7I6HklhPPNhL0MtpBg/81sYA63j365Wj25rAJ/rOGkplZg0tsW+xBZQm1lh2xCl7unA2WauvZiV0b+jaQ86MFBcxZqFlkH2LiW70pzMihSZyiFwFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NY8vt4qD; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-220d601886fso36125515ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740155703; x=1740760503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AsR67bqF+fqYAZ1L+J2XlKEArNOWP27kWrQCUz/8HA=;
        b=NY8vt4qDF4TxFFDXpnBTIUfXUnZ/DTT9IQGvcLzoq6I6Au3SjuZ5BoRZcjBVKBglEL
         SQS/eEYIYFhF/rtVxFfFiKa4WRVne5hJKYlBxpkFAYRdb3cyRB9D97F8IvO4SV22mpWg
         1xZINT45e83cSHRMbHtlRWtpzlI8mMKcWn0adJVuHNzXVCajCBPKN5Ju9pucDofPv9I+
         7MtaWdn3JtbEnlmW38pXL77KdCU77cjq7P11GwcgIlvDEGPQRS0JY1a5K6jm7Uh3VYKp
         CHv8G7XvDWQjTUyoK5V/Ucjd3zBjNfDXdj88I8qKaB6SWDX9thXXgj9FRVub4fqWwkmY
         LIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740155703; x=1740760503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AsR67bqF+fqYAZ1L+J2XlKEArNOWP27kWrQCUz/8HA=;
        b=bpliJm/wE1FzI8VzqL6XLANXsWCPRASO4r+0yKK8LPJHEfV/p9KsMYMaphQxgFsY1g
         cw/SDtYko9QoLSt+lelwrep0h1mlyq3pmadV74WgU4ggp3hWyIyzEMVoSbJpIP3QTKXy
         EJGin6l2UeP4XR3ONXq7SREAKG1LL/WN9cOQiubI9TlLRq7aDcsdoL+ZVd1jHTMo/CR+
         svdp9PgUQlpZ2J3YTsURzimpHVA1duvcm/E+JU/nZ5MgZlS19+uWVR4kBHfxDKA8UNqI
         ZiVMcv1CIaFrE28kxglwt8GNmi68/OdbRikYz7zscvALT/FXnhtFXgkFEGaV3EHOOVeU
         H0Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVua4Uf40TiC3OL3z1M52YMMlhDEgeBwcgw/lXf1ZcMwF+wVpUnzGQoZvCKTC4t4cq8Wrth7ZygH1efRmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7GmeeLZtLy1CSAKFtYaNovnPFQXOsKwpSGfVbZEFiXgHzUfyz
	Y2k+UFGTsFvNYoatA1LYoBrZ/kabO8YGpQPTdqT7WBdN9D/7BAqK
X-Gm-Gg: ASbGncu5rarGOa/RWoqaaMJ8fKMyiyj/RG1VRV2TBfYNDbB/6/a9gQ63j+L2/YI1L+f
	RuCXNJjAugISFbC+jBL7w9lrKayOZmUGfwDHHH666U963BKiTtzHSYNjVklTS9tPWHX4ECvoCcH
	gSYeCFxVV9IjINk2uE5Yi6/DV1YPado0dMba6tDJ7fhdu6SXfE4S9V5JLqVkSNMVCT44zuPluz+
	EB7IoyT7IjGtYS0HldJ+C7qD5/y2VUCwZSZJKqABQKQqNKJ6MJGMQj3OnFS5/IpjLymtI5jcQQ4
	FD4/pun2vE76xHNR94T3r2iIoB353//tEVss
X-Google-Smtp-Source: AGHT+IGctPnJHG4Of691gOP5YNdzGWLI1p5+EWLvVFReLXo7Ywxv+0S0bElzEnW04iePSBpgf4qHFg==
X-Received: by 2002:a17:902:c950:b0:220:e1e6:4457 with SMTP id d9443c01a7336-2219ff5e979mr56553245ad.26.1740155703134;
        Fri, 21 Feb 2025 08:35:03 -0800 (PST)
Received: from localhost ([2409:4066:d04:319e:1d76:db25:b6bf:4f52])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7326a52f865sm11737379b3a.80.2025.02.21.08.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:35:02 -0800 (PST)
From: Ravi Kumar kairi <kumarkairiravi@gmail.com>
To: parthiban.veerasooran@microchip.com,
	christian.gromm@microchip.com,
	gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Subject: [PATCH] staging: most: Remove unused spinlock from most_video_dev
Date: Fri, 21 Feb 2025 22:04:26 +0530
Message-ID: <20250221163444.57492-3-kumarkairiravi@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221163444.57492-1-kumarkairiravi@gmail.com>
References: <20250221163444.57492-1-kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>

The `list_lock` spinlock in struct most_video_dev is never used
anywhere in the codebase. Since it serves no purpose, remove it
to clean up the structure.

Signed-off-by: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
---
 drivers/staging/most/video/video.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
index bd51125698..83b46476ca 100644
--- a/drivers/staging/most/video/video.c
+++ b/drivers/staging/most/video/video.c
@@ -33,7 +33,6 @@ struct most_video_dev {
 	bool mute;
 
 	struct list_head pending_mbos;
-	spinlock_t list_lock;
 
 	struct v4l2_device v4l2_dev;
 	atomic_t access_ref;
-- 
2.48.1



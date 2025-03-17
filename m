Return-Path: <linux-kernel+bounces-563353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47B5A63F66
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DEB3A5750
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 05:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB38218E82;
	Mon, 17 Mar 2025 05:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR4Weys+"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F2C218AA5
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 05:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742188801; cv=none; b=S4sFVVpugyxHr3wo0hzzEt4DH4PpdvQWRlWWHau696YyiLCubgNWi5lJAlVncuTTqGLEFXy3GB3MyqTEoHKgUrdMKtnKTEgcw5r/Wpq1nB7QHg6qo+WAbE06R2DkauCdzY6+/iWpDbkirUjqlZncpERgdINUHusAjKTEfBY81cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742188801; c=relaxed/simple;
	bh=QDlARu+d9zQMAzpj8Wxu49XYTGOg89oarS2O06Aif40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CXNSaCAAZ4R8jfO76Zy5PUvpjpZpAhVokc4TRs3Pd8Qp7l2oMccquzh6RfLpb6TQhrkSddLggx6lKKkbG4ezS8gBXKbhA+1GFo4Fh9n8iVH68wC8MAWKmEJ0836ZH17TJtLqGn4VsyL528bnRlNSiBL6AxAw9rEqPvnpkWEgDVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IR4Weys+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22401f4d35aso70680185ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 22:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742188800; x=1742793600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hHpeaAz642MIL/iezdA9kA+qz/7ACYSpLAAklsJNG0=;
        b=IR4Weys+n+dh+SeueHBjTP20QK3D+/V6d2fO2Ri4KRVgqCGd1XxauaJyIsh1g/JRsV
         X0Z+uAUTtQ5RdY7s+uh6pR0wZ7s5LW1k/9ZmW4MqN2ISOBvKR0wTxg8bpKMv1HFpEGhV
         tnOcnmHcfJYGivn9ufKGOeUKatdE++HisShdeiRnEtZNuJBrljMkxsV5bU8qaY60LWjE
         tujxxnb71rlqZ28i37woMwZsAxtFWFBO464cvbUyEARnUAEQYKVSXQazK6iMe2yryoLm
         EnIyTjHjcd5Cmoi11U/EjuDFrB7hVgfhb6PubRARoaTKxNyZJLzKvyDeG6GOYsimvPfG
         Bb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742188800; x=1742793600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hHpeaAz642MIL/iezdA9kA+qz/7ACYSpLAAklsJNG0=;
        b=IFIlNHeaO1JX+rMTUikQWeGx4fPaCHAX9ZzG91lzAtR4RO4P0XUT/xVQIJOKYn/42W
         JOhCvB0sUQRN+7uDwk1QWNEuYQEaaYFs5LxW5L4HMFxzE6MiDkPvJWw7fFpITsifPtam
         FOWTVs25LjSaoKfMP64smpXtjd1cPq2ROZ63y/iL68cMrB8DKxE8mwH1JUvdNJNQVj56
         WdL/tvlPPb1uDYyThuoO0sXHaSuHhZacipCo6cBlcs0bitS+vSMyxGUnu+LjQFv/SNH1
         gLozcYbT6kz7sDLHxo4uS0QWYkA0nUcE6j1cGy+ag7Kh8euw52M3gfwZuA1LLE6gykIN
         XUXQ==
X-Gm-Message-State: AOJu0YxAAnWxWUquTKAORbo0pO49xg+SOd+tlw/buYl7Lc8Igxaa1rQg
	dWA61bblaEI02Ie2gRDG/DV5EKt1shXVsy/vdKAZWJKhY2mb810S
X-Gm-Gg: ASbGncs1Dvi7oZeTe2LVmf0sw+7Y5NqVWSrbmJ1vivVTMV8qWglo25Hmg+PRQrtNGaQ
	Do2RScapPpCPUeDKC+fusuhcq8YH2OiM5TzH+GRANHybueIazNy39VpStp9b+5FnOTF5t/MfvI8
	LccRI2Oxt/HWWtsib10vENGUQswqWwq4w0ZL6SPxeaGmD/VTNBMUdQ8KOFz89bP7ZH2p7Qj8Yfh
	sxr4l8C9zIUMD+ThMRhbqD+Ak2i5JYZYQhcfZmk2G12iS3JDrXljzZs6wFc3l9tflIVHAjCgWXR
	XTHWD1uyJWyJvQdEAav3yST8aS/nZEl+qcHcmSEQbMk2Q9RvBQH04gnnaeusK7/TsQ==
X-Google-Smtp-Source: AGHT+IEV6Wz5E1OsOPUft0kE2VrP4XoFNpoRQ5PM0M1BZxRJlTEp2VRWJHVmkulPVIEYr2uaQc1eAg==
X-Received: by 2002:a17:902:ce8f:b0:220:c63b:d93c with SMTP id d9443c01a7336-225e0b07523mr139991475ad.44.1742188799683;
        Sun, 16 Mar 2025 22:19:59 -0700 (PDT)
Received: from cs20-buildserver.lan ([2403:c300:df04:8817:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba721esm66029975ad.149.2025.03.16.22.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 22:19:59 -0700 (PDT)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH v1 1/3] i3c: master: svc: Fix missing the IBI rules
Date: Mon, 17 Mar 2025 13:19:49 +0800
Message-Id: <20250317051951.3065011-2-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250317051951.3065011-1-yschu@nuvoton.com>
References: <20250317051951.3065011-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

The code does not add IBI rules for devices with controller capability.
However, some target devices, such as secondary controller, also have
the controller capability.
Modify the code to add rules for devices capable of sending IBI requests.

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 1d1f351b9a85..a72ba5a7edd4 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1106,7 +1106,7 @@ static int svc_i3c_update_ibirules(struct svc_i3c_master *master)
 
 	/* Create the IBIRULES register for both cases */
 	i3c_bus_for_each_i3cdev(&master->base.bus, dev) {
-		if (I3C_BCR_DEVICE_ROLE(dev->info.bcr) == I3C_BCR_I3C_MASTER)
+		if (!(dev->info.bcr & I3C_BCR_IBI_REQ_CAP))
 			continue;
 
 		if (dev->info.bcr & I3C_BCR_IBI_PAYLOAD) {
-- 
2.34.1



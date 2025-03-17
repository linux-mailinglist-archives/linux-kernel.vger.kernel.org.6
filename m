Return-Path: <linux-kernel+bounces-563352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF7AA63F61
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6979D16E1E6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 05:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9AC21882F;
	Mon, 17 Mar 2025 05:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkodmahx"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5954A140E30
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 05:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742188799; cv=none; b=GrGlfjfoqRgSxLynM+W3OjZePkt9i/vzv3TLavMIlkhHfRb6mNNopzhysbHFZsn9VUnnqFUWFS9ifg3ZGoqtQiE2xlFkbZ9amjAUlgHmKPw/V5ekinvWLuzwoHI+0QWbTWCg4hmHVRiDRJpsRXoAjrg+EWntYtHdtNy+WIh9leU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742188799; c=relaxed/simple;
	bh=8oQghyez17aH26kMvp2RD24R4kX2f6/H/4UC7Q+V39Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FzZTFFyeM5X/S9wxIcpdEsAXphfDq07viQwEAyqPoXQHqvpkpVytFPHGtljLj1xdGC5FRK/hnPQ6MWJx2dWjAMqsxwIRLOHB7nxRbClZk6dxpjvOeoJ8E6qzQwClDQejNUhlxFjFQtD4A59VtSR3g8Q+8xobME+ypSm01qJlHRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkodmahx; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2243803b776so24400545ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 22:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742188797; x=1742793597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QQWQga54dvDSkq0vaFiXjWbUXDkOKyh1NJzeCcOJyv8=;
        b=dkodmahx1nnJATj5W/zvY3CayGOTjlWN1WCwnBMyM/3Zp1KkLEX3Xlti34CmNkzC9+
         p5J1PtZkcxKqbE1KdJtRTAWEvaHaUAbYzGJfEw9pJXJKOCoEG575Vq9DI+5yhJx6pB1H
         mjjTaAPN5RVcaVQEEwvoQvkz4fdVHdOfUF5Inf+0SBeU0CoiXZtsO+gohd1swKCQmq0Y
         +lvvUcjB0ut7KRtF9/K9n91oPT8CZ70eFNloysTVaKSsZ+a4e5aHJRqPAeG6RTJAeXqJ
         SUj3kO8jZcem/ctkFf445bEpWSA4+M5A4ZxEgSTJ/Ny2KX3mP/RDP8Y9GoIFnQOOVUqa
         N9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742188797; x=1742793597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQWQga54dvDSkq0vaFiXjWbUXDkOKyh1NJzeCcOJyv8=;
        b=VTGR4GjMdC3iQrxl8D2xmopLNSQ2/V3m5rxJOG8c9mPOD5XAbAsTxGlr+/p/mjcP9V
         OyzHdd9N5BxVuHdfRyxVlB08NWElKY6Qko/loGXbEWwCi220kz1iiad5lJoyRSkoEwgJ
         VLjA2l9A5PoADzxILy7xgNJnax23uc1PQTYqIl3Ja7JS6nRKM2HqDT/fj0u4gWsUOiJb
         XiwpWbyXsoCFWb1WBUz5N9AjznewSSLjKAIlN4o+flDtAUgPUdOQgP4Geoi39Z0cNtil
         PKJJ4Y4vIzqEoSXJ0R7JJT/9cOyxLZ61sVCn6NfZiXLfPB0s1aOWR3z1evQ0GzaQ2IUL
         Aq1Q==
X-Gm-Message-State: AOJu0Yy0QBl4xGx7UjMmbPV4xk+llVNST+LG4+dpQGD35yFoDOP8SgrY
	4JGoTJXL5BtY5oQvzUyKGVIHbyitNklmyDOdsbPofJYOOuxbDp0o
X-Gm-Gg: ASbGnct7E88sP+j4xkLwXjPzXHq1R1cdIH2PRXjVSykRCMOiABE1YAM6xohO9y4D8Rx
	3AfloPkNg4TbZIzlpcpoZSii7ohvKM2CMvB5hYUHgKpltmDVOZLqjcs1YajEaKDBrHRkFANYwWa
	tt8LHwkjImAeW3JOBok2cUjMbobejh9VOQ7oQxWSlIIvYIDWHvJNAbFJKNIwxvpNmS8rVGlc2+9
	zZ16ynN6oyNj7sK5QkslA+Vishw1fRfqSFtvhuAWQMYYIscmzleb7otwIHnvqlF9uYekoEaDA6x
	sCxHBbGWpMC2ub6wC61cy9GrLBMWuOeI6kG5b4szZZ2Kkww3RBLfnPg=
X-Google-Smtp-Source: AGHT+IFIQIiIw7BEaZAezA9tIbw376BxhXQW6CO98d0U9Z6lnqMOKr82iRgHEAdjTBiNwKG/nnfZoA==
X-Received: by 2002:a17:903:440f:b0:216:3d72:1712 with SMTP id d9443c01a7336-225e0b094e7mr173798885ad.48.1742188797484;
        Sun, 16 Mar 2025 22:19:57 -0700 (PDT)
Received: from cs20-buildserver.lan ([2403:c300:df04:8817:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba721esm66029975ad.149.2025.03.16.22.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 22:19:57 -0700 (PDT)
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
Subject: [PATCH v1 0/3] Some fixes for Silvaco I3C controller driver
Date: Mon, 17 Mar 2025 13:19:48 +0800
Message-Id: <20250317051951.3065011-1-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds some fixes for the Silvaco I3C controller driver.

Stanley Chu (3):
  i3c: master: svc: Fix missing the IBI rules
  i3c: master: svc: Use readsb helper for reading MDB
  i3c: master: svc: Fix missing STOP for master request

 drivers/i3c/master/svc-i3c-master.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.34.1



Return-Path: <linux-kernel+bounces-565493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF48A6697E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746EE17C4CA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17FD1D9A49;
	Tue, 18 Mar 2025 05:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgvRwBMJ"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D8B1A5BAD
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 05:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742276220; cv=none; b=VW+KihOaCEXeFTUR8kfechY71neq4nvRURHYnwaHNqSIpkgtyRLR2fwO3LrKl7bgUtTLhpEso+OQ0ZAXH0WeznTPN4Cpph/Hryqll6x6D05Qc+3U9t1PNWHkhPi5Z1/NyxH3FW3ilebd8OgXzFmSiF7qx2QuEFXj2YqBnVGpS3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742276220; c=relaxed/simple;
	bh=3SkWDJ1KeIVjC5cH9fvKRmhISc9NcxbCKIhvLQW49cI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JvjEXcGh1Vc3akbCD6n59uPqRKLcpaf8FlLHL+HPQ2FmBuTJjQUNDkdU6ZPwqKRRcC/n3zI/HNteeSUnC5OM1wiShHUjEmYXPHPzIKauV7/DDc1v+79JSe56UE+31fQNuhUOtrDuPPtk4MglgHw0QcwEbo91bIvFBeDMhNZ3rjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgvRwBMJ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223fd89d036so102896215ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742276218; x=1742881018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2l70gmWLq1u+RsRNabUWN7Xz1zqqPiMQOA3ywbVZDU=;
        b=ZgvRwBMJiecYRj33stNjSTPWj/wlB/n/GWhE/S8bLCjMzSKg4aEgnrD8qepBYxY/rH
         GhWNMV/oCTMW1v50HAXHoQ0nXZ7ajNZ7aEBFlzo858l6SxS/5wEKdyZub59X7z90BCS/
         UtbpOYbPukyA5EBh5Erx/Hh0tTPTOB9sDjjyeIBwwt+gO+aG4v1aMSSFr3w7dYDgDP9C
         8dS1GK74sb3X0CpRNRWfVGpfGg8WNaQcVZFoTmVHSOH4EcjGmE34HdRIkN+hlMYkSGIH
         d1GBQ985DnSXDS0dQmFbQe5lB3Ne41Pib2znZoQgUZwqrz/XjyeiwPZNkknwFJW5VZcn
         ZkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742276218; x=1742881018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2l70gmWLq1u+RsRNabUWN7Xz1zqqPiMQOA3ywbVZDU=;
        b=DHz0ATLZu0dGfi4G9e6oOtmnMd+WA+ZsnndA/i5KArJoRjn3yf4ki79EOCD/jqLac1
         fmEfrHLkzJ7j6WkrumpBwokg0mWz88lV8mFb0qK4lVfZpF3YD8zRzfJ/cl846zTCDU/F
         uGESwr5qR74fs6t0oRqEURPd40T9KEoG5y8GGV+tWTO3T7Ogshf5I5BPG7Yc67XvaykB
         ubAsVoVvcjvvHBOb82xHHx3K+u44u4AuOXFwS8oku+goKfhIkac59DEJm3uKC06sCyb4
         /okzfbFoTTXRk2XZ2R6HwioRzQtjMiQ6YC/5Arq0/puE6AlSnQ5+uSXVr8/ooZwfFbQ0
         bc1Q==
X-Gm-Message-State: AOJu0YwTxOk4oIK6Q+WPcaBj5vZKbpaNB09s/LrI+tWGLqyn8jyaAmGQ
	796nlhBvPer7gmtCGMBDXoIr0g+r3Iabpz5l0PRQTW0DYXFm6gE/
X-Gm-Gg: ASbGncsPo2tWUMALc0zuD0oCrXnfsqmlzp4+TZw6mN5JRvibfJfCMM2NIK9K6x61VNs
	UxXw6RajuYHcdT8dfkzpjyio3JE+WJKA7hkQPNOErmJpROQTQc28TOC2nW/N4PoxO/0mKBZncvG
	btqvhSc13Wc0pobFe81mjKYBkqYDuK3Y5vDfbPrrNk2VjD/HSaN7PN/9sI3oO3w7zAPYUwhSGIx
	CENZrTT5sLf6Z1Vcc/smHklU/cgFcqKWQbshXdoyTiSDCFyRGUOh2IAvirXNiUOmIqBvvpXlq5P
	1lDsonauJiHTxA3cYW6S1JKvuN8rQkJHyH8JU5Q//ceRMAWlkEgLalk=
X-Google-Smtp-Source: AGHT+IHh61jHEle2cIzLwjfMURMV6oyMDvmV3DsO5QwJwWAe5RRi+4NcIIvl2m8zXZrzfh21OGTCZA==
X-Received: by 2002:a17:902:e545:b0:224:2384:5b40 with SMTP id d9443c01a7336-225e0aa0c3fmr202843365ad.24.1742276217919;
        Mon, 17 Mar 2025 22:36:57 -0700 (PDT)
Received: from cs20-buildserver.lan ([2403:c300:dc02:2d2e:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6f09sm85299905ad.133.2025.03.17.22.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 22:36:57 -0700 (PDT)
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
Subject: [PATCH v2 3/3] i3c: master: svc: Fix missing STOP for master request
Date: Tue, 18 Mar 2025 13:36:06 +0800
Message-Id: <20250318053606.3087121-4-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318053606.3087121-1-yschu@nuvoton.com>
References: <20250318053606.3087121-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

The controller driver nacked the master request but didn't emit a
STOP to end the transaction. The driver shall refuse the unsupported
requests and return the controller state to IDLE by emitting a STOP.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 57b9dec6b5a8..e0cd3ce28b7f 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -592,6 +592,7 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 			queue_work(master->base.wq, &master->hj_work);
 		break;
 	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
+		svc_i3c_master_emit_stop(master);
 	default:
 		break;
 	}
-- 
2.34.1



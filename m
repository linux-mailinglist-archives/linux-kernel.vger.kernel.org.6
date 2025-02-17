Return-Path: <linux-kernel+bounces-517395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF87A3803C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B077E163619
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD941A5B8C;
	Mon, 17 Feb 2025 10:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkOsv2HI"
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965C7217663
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788288; cv=none; b=JEW+NnrcgQ4bTIyIKfbfPnqSdGz+CG5ZBEyJ2BU8Pu7rCLe28dDeAUzLH1tz5sgoMHXyuDUUBY4B6UYBfmCgEIlx855+1fgs451DcXAJNdkExZYtVZ6N9GNnY8FCvptVAfqI8oI1D4GhkzsPQyHw64m8YTRR7QrcgGSaefRyPFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788288; c=relaxed/simple;
	bh=eIbUoOIO/oPlM/ArywSv2GC++LTTbctguFEEFD+IOC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrWqzEUjeaKnZlJPPWeE9n7GAP7ME4EWndiJdW/NLXxJwyGqLXVgnTc3gFHR6sc7L9uxnK2DKLcu7Zh2+SRnT8D3tlEgycBdY1ql6rtxNoD+QBCTz5FH0nS/3e5AEprQHY4LzBQ/Y4uI1yeUA27f+Wd9Y1nDhTQ12nm6fir2qBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkOsv2HI; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-220ec47991aso38490395ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739788286; x=1740393086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMj86FWLmYH9fJq/mESep7lKDCa0pYdVlxGvc/mylb8=;
        b=OkOsv2HIcuIVrYNm1lAbrdP0/kTznhcuP43iN1Nl3PvrlVdUmPFudwem5O/1/EkQd8
         5mI6cVU0l0Z1bxXb2dFI0RxpudppmxI/0O4r5L5zSuLfcXZNrfCHTLAUafJ8Uhos30EP
         6+fOuTmDbkgVF8BjECRymOSBZmcyzdAi30NkpwDISQvZpflX7AKmDzKks/VGJu2qf0jy
         tdbb/fqWWKJqkRneAe1OgF0MGQJg3YolxpyNXbNkTfOZtR4wmZsZC/VjqP37mAR8Sq1d
         KvHYhrc8JrW79YV4zSXFz4TyX0iac/py5684Lz2IBdfBAAy4QOXOpG6r7ENJd7GlPYhH
         8sLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739788286; x=1740393086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMj86FWLmYH9fJq/mESep7lKDCa0pYdVlxGvc/mylb8=;
        b=IjymlmUOkVEAku6jlGG33LxaaxLahMY6d3uSh/RrhLgwgaGnwWsr+e2vG9+skAvUEx
         cYWMAplWRFwyzqwEpbGqnKjX7PJJGPxrMjR6+ncU845q8lZEM+YGZjic/0v+9SGoRtis
         hF7naxhhuLne7aHO4Xjnme8j6yeX4EP5zIVHGdyMzwkBtLxI24KpjqvwYtr4nZYJmzCJ
         c8eiwqSjF87FHFh+m4BqoTRLKNuVCeGoQ0hvoghOwbVhZnBKKQbyd4vgQgnnlW7jEFTs
         GktVsz8w9cim5JI7osGrpQ1eN2WjhJ5eUsSaKenY3TJ3vmLN/CS1IlRnFeDwzMKPzu1a
         layQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsNOVo0B/DroM8pchmOPZYIfRkizRT/mwJNu49OKdX4Zw7rLV5BrbNTuEJK3YPAu5n9h0aFaezLcKyVTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzHTGLH7FZyljiQmxTNhU0BqvD6zpYEFiYS5USo7N0kyeGOLGE
	M5r3avMtuN3Iafv9XXNCuBuQgHn16llS5U1xzH0qeEXJFeyMMldx
X-Gm-Gg: ASbGncs4HMyaOgri3WWiEavRBJock4p1L1qxp2tMVtKo5Gc+piCiA2eMCUIkTphXbXu
	XKC3OCuUQc2ltbeUA+o6q2uCFbgON5OawOjoDWx9oBwoJdDaVCOH+e9v2qPnQF6iy/Abmoopeeh
	/27r+SSz+gZkVm467pI5YZpEZgk5MApiBYMc1ZJrWretTKIfebWWxsshMnRXliQE/VgdGmt4JM0
	QEaaj7SvExSyQEFvf2m8vhTr3XU/w0lKOvuUkdvZpOhPNn++SjOSJvcoWs5ryyMFZXnKnbFU93I
	LtX5LTm1+9XhpgCiHqpi
X-Google-Smtp-Source: AGHT+IFxZBzg+LpprLkstU58txPBPKskJUnxyvWBmso/e3hDytAWFtcvj9yLj3ndKgM/HHa9AENsGw==
X-Received: by 2002:a17:902:ed03:b0:21f:7077:2aaf with SMTP id d9443c01a7336-2210409d463mr112254205ad.44.1739788286087;
        Mon, 17 Feb 2025 02:31:26 -0800 (PST)
Received: from localhost ([2409:4066:d04:319e:1d76:db25:b6bf:4f52])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d53491b3sm67938395ad.40.2025.02.17.02.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:31:25 -0800 (PST)
From: Ravi Kumar kairi <kumarkairiravi@gmail.com>
To: dpenkler@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	dan.carpenter@linaro.org,
	rmk+kernel@armlinux.org.uk,
	Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Subject: [PATCH v3 4/4] [PATCH V2 4/4] staging:gpib:agilent_82350b: Fix Indent issue with block
Date: Mon, 17 Feb 2025 16:00:38 +0530
Message-ID: <20250217103046.54294-5-kumarkairiravi@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217103046.54294-1-kumarkairiravi@gmail.com>
References: <20250217103046.54294-1-kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>

There was a empty line, which was causing the checkpatch script to think
it's a single line statment, after removing the empty line it's no
longer asking to check that line.

Signed-off-by: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
---
 drivers/staging/gpib/agilent_82350b/agilent_82350b.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
index b6871eb3c8..1d644d000a 100644
--- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
+++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
@@ -228,7 +228,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
 		return retval;
 
 	if (send_eoi) {
-
 		retval = agilent_82350b_write(board, buffer + fifotransferlength, 1, send_eoi,
 					      &num_bytes);
 		*bytes_written += num_bytes;
-- 
2.48.1



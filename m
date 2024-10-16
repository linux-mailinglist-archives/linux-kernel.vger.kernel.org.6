Return-Path: <linux-kernel+bounces-367917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 138549A085C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72AE1F23AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E01206E92;
	Wed, 16 Oct 2024 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GemkPO2I"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0653E206051
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 11:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729078221; cv=none; b=J74h51sQUdIK6HMU2AXJhWlgu286dcnQ7KXvrHj8PBHqo333zY/PgvbOvwLHHW2f4qKBpguwFQCD/2CPgQq7S5I4/tWU9LZTNDKjjOkGAlqF7WjFDQiPz/skExMzjneogqCxmU8rOpC9hnWbBwCbwxkkfwEJ6K09+df1wejVPc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729078221; c=relaxed/simple;
	bh=6mNog43tW563Jxg6ZE5L+OMs0VpPqDUyOVAWupos4Yg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hzFkczU8AsRbl5UxKQAABwba+TqIsftZUYQc6sqIzbjZXYwUzow+5+H4VyPWBZUkwn9fYrA3CO6TelOVQK1ix7drLORlYHSlL+EaRIp9eEJzBSscJz2kr1LgqNyPeui85JObxN3qJMoohf3QoveyFGysX6DkgVpFj+4abdxVk8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GemkPO2I; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c803787abso6382515ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 04:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729078219; x=1729683019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kQl5G0/AI1StBzfhAYLo7LwBo9nukakIzwgbx3SL5HQ=;
        b=GemkPO2IZjwH8Hpju27glb2XqV4zFQ3lsa9ocg+Ezwzz1hcUoPNairjX98vK3YGqRY
         uEXRUNcLKyKPCqtVI+ulInnxpP6YjlE0b8bEJz4+BmJsomFesxixTpbkUqL6ybsBBSJ4
         WmUbFmBloNAgol6VBl9rdPduFUHmgI/c02WHJQRNHFaE+1wgrIagL3M+Nwx7qVXyi0Ru
         8mIzlN9szNqk7dT8KrLaTD5P/DCFEzPxyBcPH+JjTDtIRQ+gTVjEREq87ulKa/Gw1oFv
         ugvCdvTFY/DRNJxdvF6Cuk2UmfZ6UbEUVMUDhiEo35MxRq5w0EEtfS1AkgBR10rklTFp
         8/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729078219; x=1729683019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQl5G0/AI1StBzfhAYLo7LwBo9nukakIzwgbx3SL5HQ=;
        b=qE3ViWckQBHeDDRqCW5nXB+kHGRFkkE2eZiuGrOS7tkA3nwcM0gIeFrf2jMXps9+o7
         d8KblJ4k4V9GEoCV+LsHhTQXkLQbxXOOXNiXexMfc0IbgNS1VyUEaNY9QKV55YkNBP58
         WInrTNSS8OTPZ9YURX7CBNx8pr96X1cF/l3pXq6p8DpAXVK0qpn/7yZit5dQrjuwGaji
         eQ6hMTF5Ph5Of1pkLQIwzouo1jss1kiUE5Hiqor8RsfM6j/fe0bXI0BdJIo1rPUdu1M9
         wINGgwzKgLzgtPwxS7vaMMvzihXXUBJGoQihlK7KHtHw9d8EZDYp42luaoX0oA7iuKHZ
         HZYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY7eox6d91oBbEu+jZy7x/fQk54QXQm0rjmYuv4SiNthc5Rt/mROhUF0y4xa7M212D3nuWGlg+ucwmqn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxudoqtazAW7bYN5NBT6dMakDbtbbkl6yKSWr3WkDjw5464++h8
	17aYcc5lgqbRi0FQl3vVGWJ63W1LYDEG7JRqfLaraMhqPi2Ge40L
X-Google-Smtp-Source: AGHT+IHtcy8eg5KYhfU/Pds2Wh3IVDzktpMJO4CADGPtpjwiShD7kSqhO3e3G+Ufo21QZ5QMZb1wPg==
X-Received: by 2002:a17:902:ec87:b0:20c:b6cf:f465 with SMTP id d9443c01a7336-20cb6d002c5mr285637545ad.6.1729078219113;
        Wed, 16 Oct 2024 04:30:19 -0700 (PDT)
Received: from dev.. ([129.41.59.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1804c119sm26899015ad.190.2024.10.16.04.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 04:30:18 -0700 (PDT)
From: Rohit Chavan <roheetchavan@gmail.com>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH v2] staging: gpib: Remove unneeded semicolon.
Date: Wed, 16 Oct 2024 17:00:10 +0530
Message-Id: <20241016113010.1619275-1-roheetchavan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch cleans up the GPIB driver by removing unneeded semicolons.

Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
---
Changes since v1:
 - Make commit message concise
---
 drivers/staging/gpib/tms9914/tms9914.c | 4 ++--
 drivers/staging/gpib/tnt4882/mite.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gpib/tms9914/tms9914.c b/drivers/staging/gpib/tms9914/tms9914.c
index aa2308cf5477..6d75294412d8 100644
--- a/drivers/staging/gpib/tms9914/tms9914.c
+++ b/drivers/staging/gpib/tms9914/tms9914.c
@@ -439,7 +439,7 @@ static int wait_for_read_byte(gpib_board_t *board, struct tms9914_priv *priv)
 				     test_bit(TIMO_NUM, &board->status))) {
 		pr_debug("gpib: pio read wait interrupted\n");
 		return -ERESTARTSYS;
-	};
+	}
 	if (test_bit(TIMO_NUM, &board->status))
 		return -ETIMEDOUT;
 
@@ -473,7 +473,7 @@ static inline uint8_t tms9914_read_data_in(gpib_board_t *board, struct tms9914_p
 	default:
 		pr_err("%s: bug! bad holdoff mode %i\n", __func__, priv->holdoff_mode);
 		break;
-	};
+	}
 	spin_unlock_irqrestore(&board->spinlock, flags);
 
 	return data;
diff --git a/drivers/staging/gpib/tnt4882/mite.c b/drivers/staging/gpib/tnt4882/mite.c
index adb656a5eb2c..882cc4bc122e 100644
--- a/drivers/staging/gpib/tnt4882/mite.c
+++ b/drivers/staging/gpib/tnt4882/mite.c
@@ -82,7 +82,7 @@ int mite_setup(struct mite_struct *mite)
 	if (pci_request_regions(mite->pcidev, "mite")) {
 		pr_err("mite: failed to request mite io regions.\n");
 		return -EIO;
-	};
+	}
 	addr = pci_resource_start(mite->pcidev, 0);
 	mite->mite_phys_addr = addr;
 	mite->mite_io_addr = ioremap(addr, pci_resource_len(mite->pcidev, 0));
-- 
2.34.1



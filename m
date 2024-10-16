Return-Path: <linux-kernel+bounces-367438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C979A0247
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D357281BD3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CA11B0F22;
	Wed, 16 Oct 2024 07:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uf5OIvNE"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA375189B91
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729063195; cv=none; b=dKil2oztl882LqKaTitNbmyymeuade00pFdsZgz/BwwOeYJoCbvTCiAbhjESEZR9LdGng6Ew6ThIBo3IP3P7U0c58MpXpCQ1CWEiRKgAt9xkyS5lt+eUTDcuWutv5HaHfSxNi6CV0f1i2uJOagMXDt0+PJjx8yKSTT5qZ5qOPy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729063195; c=relaxed/simple;
	bh=20bnFoPKDbLPVMTGyYK5V3qcRiT2PJ50MaAdGYRnu8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=piWukc7E4i3TsRgWhyayh8A+NofWi3GMFt61SgIw/hBL/s2DYGhStvg/YqrallQyYdLeJoVkmEUaqfabDQFboko/U1rD/GqwovjDAjY2TFs9JSodYYDzvI6kmAhyRnTRyBEW2oGvuWaSq1ax9iflV9B48zly5DZUwsskEuOLWBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uf5OIvNE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cf3e36a76so27233365ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 00:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729063193; x=1729667993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ORRdXeranIroI87MdpV/cKKqGxHy63/cqT3DlViNNmY=;
        b=Uf5OIvNEVbomdUbUgFdZXa7Pi/rHtL/qSmu9WRoGcllF1mo4ySdCQOskRNSWGeWF/v
         K9g9ln8Ytwl6l256lJJx62d4zcI3+t4wVF3OO0LW7+M6azdrmjzkSjmtHkjlaFWP2LBq
         qyzZsgN+Q15Elh7rq6JMUMqAAXvyz5DTntmE4+wqRXz4xe4tr0ct06f+V4K+3DOPanzM
         qsuvBMMly3yCUpTonFqa9GBHgmIyIQ567phEO1gOE0NTQXUN6adJA8EaNe7yQ0I/J9vm
         +CybTdI5WazddAJjqhjE08/P0ercVxaVWLZzPaZ8hYXt2iWUo8yYp8Zvm84PXouxhcTY
         4zTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729063193; x=1729667993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORRdXeranIroI87MdpV/cKKqGxHy63/cqT3DlViNNmY=;
        b=XByME47OF8uhgDLVQgFlfywEpdb7I/KexQpNXo1GO9+CMSN/nbv3u+rxD/KIwM+XxX
         O9P/1r6pzVS+BwalqqtZKhblEdI+/lvMFgNLsfB7EqBlW7OKoztaZUW/oKiQFzmJ0Ows
         BQZWiLtGYVg7TiuBe1lP3zPzxHnnZkkeV/26XJNPisO3+ISzVxk3Y0FKE22gncc0XY0W
         mt9EvbtTII7xN90vVeDuUJjVxTyMLYH3Swx4BB4KIYfPJqwukvheokLbmf7t2z4EsH7Q
         K+2n5A0xt9j5pw5mfDjySu2nBnv6me2wBeOflbKmXg49ekcmhYsm2sy5KnJvBEe5KVYS
         utjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB+VTa/OAvkc3NTjazX5d7li5ksdaL5ufnw3vjVTi9ncsCeOnLogUvOG5uUUYWUL/8sDbZdQn0FrIhdr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVH18JE4spFwlG9x9N7DypGxsRdth3N3WZ6E9XeRKZ/8V/iKLa
	sjuphMQ9acci1aKya0SFBr/HPCRrx+7VJ4SA/lVOv79ne/1Htugm
X-Google-Smtp-Source: AGHT+IHVhO1haPkv3eqY6vBJ5eR16keLbXkNRgpzWheFvnqzrJrAhxR5Q/Kdzt/ENgq+UbGiIl29wg==
X-Received: by 2002:a17:902:cf09:b0:207:4c7c:743b with SMTP id d9443c01a7336-20ca1315ec7mr227619165ad.0.1729063193134;
        Wed, 16 Oct 2024 00:19:53 -0700 (PDT)
Received: from dev.. ([129.41.59.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f9d2ffsm23109415ad.100.2024.10.16.00.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 00:19:52 -0700 (PDT)
From: Rohit Chavan <roheetchavan@gmail.com>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH] staging: gpib: Remove unneeded semicolon.
Date: Wed, 16 Oct 2024 12:49:41 +0530
Message-Id: <20241016071941.1615135-1-roheetchavan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch cleans up the GPIB driver code by removing
unneeded semicolons.

Files modified:
drivers/staging/gpib/tms9914/tms9914.c
drivers/staging/gpib/tnt4882/mite.c

Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
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



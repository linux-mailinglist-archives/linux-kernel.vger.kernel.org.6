Return-Path: <linux-kernel+bounces-357663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 660C49973E0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984891C2340F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A9C1E1A0F;
	Wed,  9 Oct 2024 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FN6Ju+4A"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D491E103E
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496682; cv=none; b=uSFZTXcIHgojiWZ3EglJz2GsvBFM4CDTp/cRVY7A6PnTphWQVo4YBNA2m+3oYEqC77tWEW0bt6ThNBbKyPYhdSgWkc0MQT68K9IC3tq7r5TvkZNz9g99ZDH8A0wgBzfWfNPpXx+D57SM+jV7EPzxzo7xqvwrhBZVq4Riw2nxIpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496682; c=relaxed/simple;
	bh=1S9Bz1OBNCsBfE4aviNr4ZXeNfaumRaYVRvRaRjyzMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d1Ff6GPrcaujKhLOu+MBsUGz+miazrdSuMYc4TuuBtpRoR6cJgxRFv66Mn6iFgLxhqIG18vHN8GN7t+do4x2bX22rTzD4BDKSZ8gjQ9Zf+Y4xSkFBlPtAqTdnzdq8tkFsFxLLBzy/I/lCsSvA1ara/VOItYeB+GvlL7ZVh202Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FN6Ju+4A; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e3e7dcf7b3so57752b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728496680; x=1729101480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjdY2kbsntsJxkIY+YoEwppZ+eHyqiNWOeFPHP9zjwU=;
        b=FN6Ju+4AoaHj9O9VLT25L+bPwoER2tOX9P9YcoSB5Z+f7uO1Sk8vhEQwm9360ZRcys
         4kLG9dbNKpAdiW7pQBRaSsnJrKO9sCtqcVAMl+FxCTXQkZSZsarvJQOOkTO11msD3hOO
         DBSKZsm8EDbsTmIyvvh4I/ASD6X2AlKBzLjmTY9mMHEuePjdoNWeyi72ftocBqj8hj0D
         eGqyB1Fpg3k4sTJ/kU8hGZgpV2qU45ZEJnQvYVkaI39Zg1KFGMQ4WpD0BZM0Z6gLVhEw
         w8ek3e1TEUrffT9l6PFjMh4Tua12x4sKx05DnOaciQ0lu2K2sJ1DjCshTHUFQFVJeeJY
         BdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728496680; x=1729101480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjdY2kbsntsJxkIY+YoEwppZ+eHyqiNWOeFPHP9zjwU=;
        b=ZYrm+uQBM4Mtt6eO4ID8IRbZIrKnuMftb9GqiSzQjoMoOxUjj9D5llFLOZfur4qsQ5
         oo2soPWYVcHGmdhJXqgS1mq4w+e/KTk6Kfym0ao9VRpnT4kouDAIdUsfhtUoxsClOqYN
         y6nx6mmWZNLXxYuFB07UFWTV1CtA37JN+hcWIA5jKGB5G5Wwfr0zaMjZJUO5uYw9esH+
         7VrzJnoY3Lu4Uyyk1g684lFWdk4BDyFO4ZKPe6xX0Gjtd31BHair2n2CvaQDYBZ7DyuF
         rpC/LisLcp90R2KfY38U/30nmxcfnVHBrBBUdP+zJE2dAdoPQX5f8G5jjwkiCZoTCRpT
         vFGQ==
X-Gm-Message-State: AOJu0YwzBKHvOOZ24tl6JpYHnTZDfQrbUl7qce6o+I32jMPiFixcI7Hx
	LVZmfIE6OUGoqnIhDwve/VLrkpD2v4EGpB0wOJUSvxX+RCoh8J7NEc25d+S8
X-Google-Smtp-Source: AGHT+IE2oGK/MSVHYCoJinOlidq5VY3r6qCb0/MqDXQTbVF1E62v1vJwCGEoMCNIzqsr8vGUNFmhFg==
X-Received: by 2002:a05:6808:219e:b0:3e0:3b50:6fcd with SMTP id 5614622812f47-3e4d7526e1dmr367763b6e.5.1728496679791;
        Wed, 09 Oct 2024 10:57:59 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e7d711f219sm2442489eaf.9.2024.10.09.10.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:57:59 -0700 (PDT)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@seimens.com>,
	Bert Karwatzki <spasswolf@web.de>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v9 4/4] nvme-pci: Make driver prefer asynchronous shutdown
Date: Wed,  9 Oct 2024 12:57:46 -0500
Message-Id: <20241009175746.46758-5-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241009175746.46758-1-stuart.w.hayes@gmail.com>
References: <20241009175746.46758-1-stuart.w.hayes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the driver default to enable asynchronous shutdown.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7990c3f22ecf..1cbff7537788 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3597,6 +3597,7 @@ static struct pci_driver nvme_driver = {
 	.shutdown	= nvme_shutdown,
 	.driver		= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
+		.async_shutdown_enable	= true,
 #ifdef CONFIG_PM_SLEEP
 		.pm		= &nvme_dev_pm_ops,
 #endif
-- 
2.39.3



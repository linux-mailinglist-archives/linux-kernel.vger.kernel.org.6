Return-Path: <linux-kernel+bounces-357660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 428429973DC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF8E2817F5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFB51DFDAB;
	Wed,  9 Oct 2024 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6Km+tZZ"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF25A1A0AFA
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496678; cv=none; b=pWCHtbDT2apV6/9+j46cYq4JJ8HwvtJThL9fsswdBeR5hXDPNZTStmzWloyVuJZ4Awm8Iku69GRTvKNLDADlaD2GjYYSTNS99OGMOwyi0bibM4lGwKSAo7B+GOs2gCuWCMuUXB0UMFBE2dyU0Zi+rrTs6FRqdzqpOhJnGKffq5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496678; c=relaxed/simple;
	bh=ZRI2legnzyzaSoUkqUQGMtdIQqeHbvusRsqABYbjEiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N4nB81Lxeo4AiGjEzgM04xfjgho5yF9bu5E2TQeaSrtkOgPiw2xkoPXzYWunQSqceHbebxVbCqJ+qBCrYh6jVIIhlHSLcKB/wS5P2nlVnMs+LLzYpxF8agIOOzuqSm96xdhU9C3/iKmoQeOiRWOEac/0UbhjtiGmsISRYUUcZdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6Km+tZZ; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5e7f551113dso31838eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 10:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728496675; x=1729101475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPm/X+fl96wDokyJYUzE4ML1aoLjDUpa0pIP+DD6nQ0=;
        b=E6Km+tZZnx6xqg1A7wghj5JtNDTXmrcbudhDEan34pK9pFdflz8kFT37189Q/ZoMos
         A3VhiqYs36Cuiigx2uteYOg6XBw8KbwGN9S8Hs1A1NgI/8UrFoI1+5LnDof8x8OVQIbI
         Mkhax4UnQDqvp6vQi2J/kutC3dyQfFLHvLiiLep0B9Il7VBHq/Rv4egSTTT29+ngCEiw
         l8GplpYgEt5waPUFZoP/JN67Ka58ICLwWmvuyu0Om66Ha9ghB206jOOCEf6DP0UodwFx
         kI7uvW5itCOh3tOPkPxX08N+/HFZHfOx7Qvpqj0xT+ohhfSzE5TlEvj8D55L4IHl/ADp
         NMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728496675; x=1729101475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPm/X+fl96wDokyJYUzE4ML1aoLjDUpa0pIP+DD6nQ0=;
        b=BmJDUZFyfGzH/l590xMe6/shPr8Ht5W5/xPeJCHzEx+mZLBG/zOdLpohu4me4zIKLe
         5e8chuShLm3FqouZxbbA5xInEEgowTg76x07w3TBFTGvcc694hXGh4i8fO2uI7Ccu/O5
         qxLQ4urhAgC3VP9HKiZpKlkUulgXMrZbaawmetX1OhQgzz2uSYYhFXRDEX5I5D7zschY
         KimP1eit4fAVceWGeNnQkcPoyTRl+sotD9rvJup9fGsmjkB/6Zle5iHAbdaIaTYqAUAP
         9wVkw/iN5S5nXhm0y2qQqX+kKdAiWpICnPUan9JUic2SSgjdasyhT3fD8a/8PZfNjd2D
         2f8Q==
X-Gm-Message-State: AOJu0YypclQbUXDEbuE4Jj1aUeZdY6wvx3/j1J3U/Lvk7fNTXuO2SAla
	BgRhGrVI4vwmqxKlViUKLjcrQHCIASwxISmzZCYZ+6luMHez7vWqv5Y6p0TP
X-Google-Smtp-Source: AGHT+IHq3n5qVynTl8WGUVgCMZSQGlNypP2wpgIrsgNF+ymCZyRCtVqjwo6pYhcKUfn4qky9AfEi4w==
X-Received: by 2002:a05:6820:c93:b0:5e1:e748:7d2 with SMTP id 006d021491bc7-5e987a8eda4mr2540631eaf.1.1728496675654;
        Wed, 09 Oct 2024 10:57:55 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e7d711f219sm2442489eaf.9.2024.10.09.10.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:57:55 -0700 (PDT)
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
Subject: [PATCH v9 1/4] driver core: don't always lock parent in shutdown
Date: Wed,  9 Oct 2024 12:57:43 -0500
Message-Id: <20241009175746.46758-2-stuart.w.hayes@gmail.com>
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

Don't lock a parent device unless it is needed in device_shutdown. This
is in preparation for making device shutdown asynchronous, when it will
be needed to allow children of a common parent to shut down
simultaneously.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
---
 drivers/base/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index a4c853411a6b..2bf9730db056 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4816,7 +4816,7 @@ void device_shutdown(void)
 		spin_unlock(&devices_kset->list_lock);
 
 		/* hold lock to avoid race with probe/release */
-		if (parent)
+		if (parent && dev->bus && dev->bus->need_parent_lock)
 			device_lock(parent);
 		device_lock(dev);
 
@@ -4840,7 +4840,7 @@ void device_shutdown(void)
 		}
 
 		device_unlock(dev);
-		if (parent)
+		if (parent && dev->bus && dev->bus->need_parent_lock)
 			device_unlock(parent);
 
 		put_device(dev);
-- 
2.39.3



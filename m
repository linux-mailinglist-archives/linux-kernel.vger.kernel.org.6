Return-Path: <linux-kernel+bounces-169408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCEF8BC84E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77671C2040F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C43114037E;
	Mon,  6 May 2024 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="wD16Mupw"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A088C757EF
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 07:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714980372; cv=none; b=Vz1pyMsxQLz7qCWQsG0hB7mdiOfLPp8xAPUBRwJGt99YJct7YE0HyLyX9W7rYyvMLP+neWSZnWC9hxdZD1F3ta9K6swPgsgNSxV1akw3z0RRGVQJUk1RRJU7jEt2fvseK44/Wlq89Yu7mOLDgWjST64pVsWIRSElHKREHLXoL28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714980372; c=relaxed/simple;
	bh=AllLnRUfY8oVArg/OQXVQOXZddAbll/rOsq1CE5JEdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kLvnwwLUzt7DrsqH8EOkti9XDtQEJVBPnFehESYpYzwJgNkAwwGkOeE/PK0PQzhMA+7lcw479WURc/MyIA/6AUK7PiXlXy+qP/t89OH3L/x3nNon7/dPR6B9DC4l7hGPCEMqrWuDhI8MLTQh31US/bS57q4ZxlyGiKYV2H9AiyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=wD16Mupw; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59cc765c29so148643366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 00:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1714980369; x=1715585169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rIFkbCWlbzUtN5PpRfhtP4G9tKmdZ6WmQepTdXTBAk=;
        b=wD16Mupwb4so5O2zvwjNR05yJlgw6nNEVjKUpfv0ozBBMuQoOnBHAnnP8zFE9Z15Kb
         e+1EDzBORNWDJjSKgVv8nBnvUz8szlApGvd/TcrTP9lauGBT+h5spq9KixUG9/+AXJGd
         LoGFaxJC6zN+ExfU7uWdgUjeQhlGLQUyD8uM++l5n7eAvBJIS2mG/FbSMadajeV3FU03
         5DAnkHx+zRi1UBahTpHwq/dYDU2ozRUK+GParLsz2UdRN4jrp22K4t/kjMAD/tPSatMi
         UdzRnzFocrjTyJvz1EAz2V0lVaCZGlZ3/fx83slAUL9tVw4Zgu6Yki2h50p5LH5lNels
         SBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714980369; x=1715585169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rIFkbCWlbzUtN5PpRfhtP4G9tKmdZ6WmQepTdXTBAk=;
        b=J98VprahMSBC5oMhQcP8VhnWFzSDCMOMB40T2pQdbZqHhjz36x6dtbOP8B5HVSZyy0
         F0hs04vYjTHr8hlljoi6nCMScmaljoYmDvZfMr548SydhFX+M7qQ8LILdYExzkkx22oY
         aZrCArF46nQcFZBA3Ej9YPwjdBq5ZZrp8a563eKdyvk1Aa2mCnurRTo32s5c6FfAQR+4
         8vj8pf53W6gj31+UXfU7+A8CnX1h0pEk9Ty5NIV69T2oDK8ErzWZKGi0hIp7ubT4MREP
         Leww8BBfiMeZmq4dxjY9e+ijjzRoQ9yCs914OH197jpnuJGomBshcdI/GuSaQyado+5b
         rHgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr7Gm9vYo/pE/WgbsjcumpNtnibWg1iM1sA2IfL4tPD+nyhSzxNeqanBP5aDj4fUtNsu/miVxr5HzLO4WJIyRqR/AOGBZpp2JB8bke
X-Gm-Message-State: AOJu0Yzt/NC7y6KYAhbs+kKMLmq93cauWvup1ByW/grIcjSN5ud0sdw0
	hBtSQipRILmnbBZ+KAUdJONw2P88rdG3adnOvXfvUst6Vh8Ugh+x0IA9Fa4OIP4=
X-Google-Smtp-Source: AGHT+IHSvKPsrFKqw6KfE2f2jYNvVCpSGhY+PowBEX5x/SvfY5hyvV+g/7mmozBB6bOQ6w0e/lHa8w==
X-Received: by 2002:a17:907:3f1d:b0:a59:c9ce:3390 with SMTP id hq29-20020a1709073f1d00b00a59c9ce3390mr2161679ejc.30.1714980369175;
        Mon, 06 May 2024 00:26:09 -0700 (PDT)
Received: from jrc-a.. (213-47-229-24.cable.dynamic.surfer.at. [213.47.229.24])
        by smtp.gmail.com with ESMTPSA id oy17-20020a170907105100b00a599a5dec53sm3552611ejb.125.2024.05.06.00.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 00:26:08 -0700 (PDT)
From: Joel Colledge <joel.colledge@linbit.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] dm-delay: fix hung task introduced by kthread mode
Date: Mon,  6 May 2024 09:25:23 +0200
Message-Id: <20240506072523.399767-2-joel.colledge@linbit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506072523.399767-1-joel.colledge@linbit.com>
References: <20240506072523.399767-1-joel.colledge@linbit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the worker thread is not woken due to a bio, then it is not woken at
all. This causes the hung task check to trigger. This occurs, for
instance, when no bios are submitted. Also when a delay of 0 is
configured, delay_bio() returns without waking the worker.

Prevent the hung task check from triggering by creating the thread with
kthread_run() instead of using kthread_create() directly.

Fixes: 70bbeb29fab0 ("dm delay: for short delays, use kthread instead of timers and wq")
Signed-off-by: Joel Colledge <joel.colledge@linbit.com>
---
 drivers/md/dm-delay.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/dm-delay.c b/drivers/md/dm-delay.c
index 5eabdb06c649..eac166405b6b 100644
--- a/drivers/md/dm-delay.c
+++ b/drivers/md/dm-delay.c
@@ -267,8 +267,7 @@ static int delay_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		 * In case of small requested delays, use kthread instead of
 		 * timers and workqueue to achieve better latency.
 		 */
-		dc->worker = kthread_create(&flush_worker_fn, dc,
-					    "dm-delay-flush-worker");
+		dc->worker = kthread_run(&flush_worker_fn, dc, "dm-delay-flush-worker");
 		if (IS_ERR(dc->worker)) {
 			ret = PTR_ERR(dc->worker);
 			dc->worker = NULL;
-- 
2.34.1



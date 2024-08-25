Return-Path: <linux-kernel+bounces-300360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C856595E2CC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 10:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5BA281D2A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 08:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BDC6F2F0;
	Sun, 25 Aug 2024 08:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxzpFbvw"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F53F4776E
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724576254; cv=none; b=qprNOGstZUh3gRIfaIDQjD3Sf1H9qKgRcgobLYCVZ36aMcQgWcN5KdA2YEhgt2lyWFxIUXhOnXhdYO7yWLTJgge2SnuO26WGtaPiITaRFpIigBnKYCE/bnK9dZnaeZQ0sYEXgmJAgPud0Za/IP3fuG0yR4nmWBlWTTRMdTgZlSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724576254; c=relaxed/simple;
	bh=fzxxQnFRzTj1LCZS7vylnHJOzFWN68YjIzG3hjuBe2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LURr/Pvc7FC2VPQSfiY94GetkKYLqcz7VNd+9M/soAK55DctOeHgMgySvx/kRChRon78I0Q5SnGca5PCcuOeg/r87CXi4zkGvkwBik0GK1UWzlk1HPXTtbMrITD2GdeQWf4QPRzSRwMXEu5GFIupPvm/R2uw2IR0K1xrLj0re9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxzpFbvw; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-714287e4083so3009658b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 01:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724576253; x=1725181053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AWWv+v0L2sJmSk4sVkV402B/XffIijw0F0YPA7tItao=;
        b=AxzpFbvwaQIVN+1WBy78PlClr1vZN7LCp3MjSLk94sBVuTEGnoTuTBSZRPRAEiMTFS
         nRaaZbeSjoKN4kFf4yXynp9BRhlgGjA10Gk3M48vnEX4fSYByhnoV8+i+zjxf4wchrhS
         CBGyLa+wKZ1CsElFfX5WbW64yXytzCoyP8OovQDv7owViiBeNBoOkYArTxT8TURgoaz8
         GHmf263ZWdflwBUfRcdkccc0dnvE3QTjlIvxfiBxQVZo/wlbj7sc/bhPr7PZ3WKhNt8w
         JhWhCtR0shkKv/SuxVqUNya59jaRQiMy/cEaZ8IWpJClR/IK45IHGv6nCilqrCH1qpHs
         m55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724576253; x=1725181053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWWv+v0L2sJmSk4sVkV402B/XffIijw0F0YPA7tItao=;
        b=au3g/LbMPlYAjsIw5MRjNq3VKn3aXocMffmNoQJ+IfBDbBxoiyX9Xryzd9pLazEn7D
         YmoOSjUKbssIe5m3JBNglMBexge8ZUS/pz1inr49f9aw+49fYfN6mUWbD8w94QBXcXAS
         ZiDjVYoMwoqzXzXQyQOaZPWKiXfJWt9Dv1vT0oNY5jtEv27IjGUbvVA1FLNmZiI5XgGv
         /DjjJBDLDVDKqhFdQ5hrILqzXES5OgbxN+lNSkKV+Fy/gViyPyu93GKMEoX0Kj0RJ4k0
         gaRjQ+Bm9eHpIx4POZEoxLG4lm3a8OtEJtRhXhLMiZmYnwLPhlEn8mW/Nev2Se9oMswH
         6fNA==
X-Forwarded-Encrypted: i=1; AJvYcCU2NFBSXepBLwNKyVG2D9PD6KFlAvKT1raYBBU9EZTQ1Pvrvny66WayTN9rJpyuNbtada7rIvL9LAhpqIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnMf8Wj/e/lbNDivqK0kDEUBDYRPSz2GgfncuuPjD0Y06G7ChW
	9w9sLvXaXiEL3GlfEpVtfgBz6yQPi1tFQ3xNWltUr1pfMqOGYVix
X-Google-Smtp-Source: AGHT+IHzg+/b2pA7gbvhyOZD3w24rtN3pJRqXe4t8b3QptTFV14eembYAw0GCl60Bn0S/AMdAiTAqw==
X-Received: by 2002:a05:6a20:cd91:b0:1c4:c305:121c with SMTP id adf61e73a8af0-1cc8b5d88a6mr8113828637.42.1724576252339;
        Sun, 25 Aug 2024 01:57:32 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:3236:b871:d8f1:d936:dc0c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143425109asm5414348b3a.67.2024.08.25.01.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 01:57:31 -0700 (PDT)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Nishanth Menon <nm@ti.com>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH v4 0/4] Do device node auto cleanup in drivers/soc/ti/
Date: Sun, 25 Aug 2024 14:18:41 +0530
Message-ID: <20240825085714.10736-1-five231003@gmail.com>
X-Mailer: git-send-email 2.46.0.290.g4f02c709e8.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do "struct device_node" auto cleanup in soc/ti/.  This patch series takes
care of all the cases where this is possible.

Thanks Nishanth for the review on the previous round.

v3:

	https://lore.kernel.org/linux-arm-kernel/20240707055341.3656-1-five231003@gmail.com/

Changes since v3:
- s/seperate/separate in the commit msgs througout.
- 1 / 4 - "return ret" instead of "goto rpm_put" as pm_runtime was never
  enabled by the time we call pruss_of_setup_memories() in case we
  return on err.

v2:

	https://lore.kernel.org/linux-arm-kernel/20240703065710.13786-1-five231003@gmail.com/

Changes since v2:
- Split v2 1/3 into v3 1/4 and v3 2/4.  The memory setup code is
  seperated out of the pruss_probe() function and put into 1/4 and the
  actual conversion to auto cleanup is done in 2/4.
- Replace dev_err() with dev_err_probe() in the code paths touched.

v1:

	https://lore.kernel.org/linux-arm-kernel/20240510071432.62913-1-five231003@gmail.com/

Changes since v1:
- Refactor code so that it the scope of the pointers touched is reduced,
  making the code look more clean.
- The above also the side-effect of fixing the errors that clang emitted
  (but my local version of gcc didn't) for PATCH 2/3 during v1.
Kousik Sanagavarapu (4):
  soc: ti: pruss: factor out memories setup
  soc: ti: pruss: do device_node auto cleanup
  soc: ti: knav_qmss_queue: do device_node auto cleanup
  soc: ti: pm33xx: do device_node auto cleanup

 drivers/soc/ti/knav_qmss_queue.c | 100 +++++++++---------
 drivers/soc/ti/pm33xx.c          |  52 ++++-----
 drivers/soc/ti/pruss.c           | 176 ++++++++++++++-----------------
 3 files changed, 155 insertions(+), 173 deletions(-)

-- 
2.46.0.290.g4f02c709e8.dirty



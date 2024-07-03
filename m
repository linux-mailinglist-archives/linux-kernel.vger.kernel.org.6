Return-Path: <linux-kernel+bounces-238964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DB9925440
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9F42811C0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5653D1353FF;
	Wed,  3 Jul 2024 06:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0qoxDM9"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4359545025
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 06:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719989886; cv=none; b=kbXBqjamT+HgSqXS1MT0RaR0AvQjEGZndZe4ABXopGqDl9b1H5QlSFj9u3PYVyy1h4sLwhTaJxuF/39VgrrY9X9qS2NKOfbtY4ibRI6DQEY7EYxM+3fXs+OHp4L9LMC8dJUhH2FBaaVgiRsBYhFR+Ik9F+Ms8TEGfmzhHvV3qA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719989886; c=relaxed/simple;
	bh=vqJ5b2/WJ3+vwS6pNAqbMT4p93GIk+s0raaiaNJeG6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E5RzM6KZ5aVFqAQtoGpb+NiU/Buuw7Dop0lvfliN7YdMLRHIPRSQ2arR0O5V0uIcaC+pU+69qetG+zfHQGoGhOomFRjY/IuWntzHxQriRsu7WOI77BZKKIrTsDheD6F+SNyhyPNZ7JS3GJNfnhFefyrYZ7RKxKseaKAH1qYdfWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0qoxDM9; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5c46e01c9cdso497276eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 23:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719989884; x=1720594684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bQSIvRZB4ThXT5i8fNb92L+40n3G/83l+7oX5ck0BKg=;
        b=b0qoxDM9oveR+jQHdw4KTrFk7U8rJmVkzHg/20Cp74LCGCjyQgjVZ7gCxMyAvdPgL7
         fs42PDtZzP4W2c7n3ridax2a6MV+qx+21Y73eaH6Lb3YMdvPjCBXVWLDTYLSGvJ2VJ2k
         QYeFIRPP3BG646XBDNK0rHehD7YjiVQQPB4OlxlK0MIqbqhkK5XG3DoTgcww1ySUQcyX
         VvtUc7bcV5TppkPf1aAbCypzwMF7Ou5t7xJyUg3qZAbyn7sUI6rEZOg/Obz3ZyjZ7Xde
         S94GgXP2c+QIb5mUFjBYZ+za8+j1ZVLXxQCxKx/Z4qB2fLzmUlYPEkB2TJ8dNVb7JRO9
         27Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719989884; x=1720594684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bQSIvRZB4ThXT5i8fNb92L+40n3G/83l+7oX5ck0BKg=;
        b=SPNt/ONe+JBS19hs3AZ3u+OGPvtvsoJH7ft45cq4X+1drpQoRq5Obboahe1wI4ibrT
         FccYnu3NNcI5uGgp2GDV12IqUKMv53RggardBhtCNLgxW0jjPMJkqGuhBZPHx7yICpRi
         UZkb5Hsh7NoRliwi3m/9UHyhQSdrej/0cTkvwSKnENu97Fuy9/ucixmcA4PX60CK7pgR
         i8JEsf/GYwp5U7YsNnwveRmXhdPSqj8c3w7a11u1oaEyhNm5tgoc3/VLsCsElxif2J5j
         bf2JkYMtBnbmKsld5Hw3kvXSElU04Ij/7uIcPtzAy4wo/7uNwDmaQq6fOigt5VZwNDob
         Lr4w==
X-Forwarded-Encrypted: i=1; AJvYcCW6PNIpJ09fDweoESIAOPLS1vRnscEQ+oxhoysvrJU7fP/X+ItS9YbdDeJ1xhDI/J83ncEEESKQBxZIPykxF0OuXVrSJkxbjld3MEl2
X-Gm-Message-State: AOJu0YwQQ8A2XGcBsLsYyu4+IpSOyyNh+kB/4b0STdrs+icVHqIjuhbG
	VRUcPbaNWQLnDeyNcW8J1ToPdhwiz5OsSV+mcFFDAliG5ITe3gV2
X-Google-Smtp-Source: AGHT+IFxXXOs08IU3yvr3Dw27u84engVs9yE22hON8vp/HhkHuM1WNJTyKgg6TJgbQSNuhxiAoUubA==
X-Received: by 2002:a05:6358:7e49:b0:1a4:ab44:7632 with SMTP id e5c5f4694b2df-1a6acbd7376mr950041655d.5.1719989884191;
        Tue, 02 Jul 2024 23:58:04 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:312d:258c:c06c:76e7:dba9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3e818asm9973921a91.51.2024.07.02.23.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 23:58:03 -0700 (PDT)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>,
	Nishanth Menon <nm@ti.com>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH v2 0/3] Do device node auto cleanup in drivers/soc/ti/
Date: Wed,  3 Jul 2024 12:25:25 +0530
Message-ID: <20240703065710.13786-1-five231003@gmail.com>
X-Mailer: git-send-email 2.45.2.561.g66ac6e4bcd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do "struct device_node" auto cleanup in soc/ti/.  This patch series takes
care of all the cases where this is possible.

v1:

	https://lore.kernel.org/linux-arm-kernel/20240510071432.62913-1-five231003@gmail.com/

Changes since v1:
- Refactor code so that it the scope of the pointers touched is reduced,
  making the code look more clean.
- The above also the side-effect of fixing the errors that clang emitted
  (but my local version of gcc didn't) for PATCH 2/3 during v1.

Sorry for sending the v2 so late.  I was busy with my semester exams.

Kousik Sanagavarapu (3):
  soc: ti: pruss: do device_node auto cleanup
  soc: ti: knav_qmss_queue: do device_node auto cleanup
  soc: ti: pm33xx: do device_node auto cleanup

 drivers/soc/ti/knav_qmss_queue.c |  85 +++++++++-------
 drivers/soc/ti/pm33xx.c          |  20 ++--
 drivers/soc/ti/pruss.c           | 168 ++++++++++++++-----------------
 3 files changed, 131 insertions(+), 142 deletions(-)

-- 
2.45.2.561.g66ac6e4bcd



Return-Path: <linux-kernel+bounces-282251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2949A94E157
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 15:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4131C20CB1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 13:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8732C13BC39;
	Sun, 11 Aug 2024 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkdsDZXm"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4533D17740;
	Sun, 11 Aug 2024 13:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723382402; cv=none; b=JKkWvqI0Xof64RtfIb8EJ4/xhuFM8zeh9DVk/CY49inKR/53rvN1CJO2URi9oQclJQDPocWaEtHRmauOyLaE04VYIYrm0vnOsvhX42ZdKKattWusMIy+QDJuJWVZO+CiN9E45Wm9WSDUe44AhRelb8gye6q2VV30LbAJbJVavss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723382402; c=relaxed/simple;
	bh=pEbcQPqRdFNJFJhjohQjToKfidRkrYKpqHMqHDIasAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VcDuqLfX1FTbVdAu5MwrSPDW8n3wWvzID8D/T/ONaE+alfpXXzJZ+JF2M+5QVZ8KicdfzFFuXdOSG9AzOJsjf0o/ydnFWzelV+LKjoO+Otk9MiyXe9R9dEboOOYS4I3VsNxetfT01hV7Cn2MLOfe7dZpi9GeF797LkJQflxRnMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkdsDZXm; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-367ab76d5e1so1595582f8f.3;
        Sun, 11 Aug 2024 06:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723382399; x=1723987199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AiVkRRBWvGz7hoofcBNV3ARACBVn7GPBnf7+7fWlslg=;
        b=JkdsDZXm/b/zg40ZBchA0Ie+1o2E5k70LVKt1Pgp3cJC/NHyZel5+tEyItnBrEvEgJ
         BtCVlCwq6+1dnhER1ek4jIimZMEfnMHHB4oqaJ6qLuFTR5E47Itqdw6TO8U4ydYe/h0O
         STez9AOwotWgQKpnPPbiC8s5gFWu9DkO5r4Ee/7XLLwjRrSTVyO24t6FB3lj7mnr2J5r
         go3PrDeijuzOxMz2lUqZR1aQHOxccj1T3uezevcVTqqpE2vJ6n2hzSQz/pYdQfk6hzlc
         lyFPAYyauHboUPtJFa0B7LEvi5mTDsaQl1xT9uNGHU9UwRnlQR4iF6uOSudNzYtcNNW2
         Wt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723382399; x=1723987199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AiVkRRBWvGz7hoofcBNV3ARACBVn7GPBnf7+7fWlslg=;
        b=rzZDJJDtYURpY+XzuM7B/ltvvv6Ye3sbdyk95U2ZNrgGC9nit/ac1/m3iRs3Jx3FG4
         7ZGEUhYQFjbJG4DQ1PiccjA3cAmWYI25K0luVXAGjg2f2qml5GyzvaznocXyVqZe5mwB
         hH/Lwy0rMfRKL+1Ree/IBsVk1VIw2NC95ThP0S1TjByyFHJBt1cFCohxMH9nPYqT1Z+8
         Zbybgd+LL195oaEns9DEjtF5M1jHwHMEWmoMy8mgudUg7oMsh0jg9zODh7gHfY4BrPV9
         /MY5UwwNvx4jolCBTyr0iGPLjx6Zu4f+u/PcXJlv0VW1n9amO6mf7u75Q2hKPRH0IsLO
         5Bng==
X-Forwarded-Encrypted: i=1; AJvYcCUDy21Qknx4/9kfR4IahoFa6QZjxCQeaUHUSnF3uYigCmtpyKk82sWXDmlQAFKuxm3NPNSG38b3j3QzOC/d19doVzMrf3ytpXRBx/Uo
X-Gm-Message-State: AOJu0Ywaoi/7+/J4yIoR3aM6IU62NVTzOuSMQdznyhvXyWk4ryyx5+Up
	0nbzqXNfAH8j1+5z5OF7zO8XMYTQnu/ddGbFBFsXwixk6CnOfPpf
X-Google-Smtp-Source: AGHT+IG9LNtbDOkzdjMZGEMWD0bBPK1A8JHRXbGvpQKjdDihIb8T5S3BDBHRZiaJYR/3l5Y+phydMA==
X-Received: by 2002:a5d:4ad1:0:b0:362:8ec2:53d6 with SMTP id ffacd0b85a97d-36d61cd3550mr6296120f8f.61.1723382399272;
        Sun, 11 Aug 2024 06:19:59 -0700 (PDT)
Received: from xws.fritz.box ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c36b874sm4959680f8f.1.2024.08.11.06.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 06:19:58 -0700 (PDT)
From: Maximilian Luz <luzmaximilian@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 0/5] platform/surface: aggregator_registry: Add Support for various devices
Date: Sun, 11 Aug 2024 15:19:43 +0200
Message-ID: <20240811131948.261806-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is basically a collection of SAM device enablement patches,
for which I only now found the time to clean them up end send them in.
It adds Surface SAM support (enabling battery status, keyboard,
touchpad, and more) for the following devices:

 - Surface Pro 10
 - Surface Laptop Go 3
 - Surface Laptop Studio 2
 - Surface Laptop 6

In addition, this series enables the thermal sensor as well as fan
(profile) control and monitoring on the Surface Laptop 5.

Maximilian Luz (5):
  platform/surface: aggregator_registry: Add Support for Surface Pro 10
  platform/surface: aggregator_registry: Add support for Surface Laptop
    Go 3
  platform/surface: aggregator_registry: Add support for Surface Laptop
    Studio 2
  platform/surface: aggregator_registry: Add fan and thermal sensor
    support for Surface Laptop 5
  platform/surface: aggregator_registry: Add support for Surface Laptop
    6

 .../surface/surface_aggregator_registry.c     | 58 +++++++++++++++++--
 1 file changed, 52 insertions(+), 6 deletions(-)

-- 
2.46.0



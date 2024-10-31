Return-Path: <linux-kernel+bounces-390072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 468EE9B7529
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14A31F250B7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAE3149E0E;
	Thu, 31 Oct 2024 07:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cGZMBBh7"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455921465BB
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730359075; cv=none; b=rSVC5n+rnGqcTmNFUNLiZTGOXcYnv2MXs9sn7uwNdGZEoXjIaTkTPlk76HZc3VUbeCrLcGG6VF0YpmgDr8B/28Fra7KrKgWWBOWLC7iVAl61Om60yvQ8s0Uyzo9U8IJAMBBqehlb7YgqioMuZMoJsZKhXQr880FUhT6r1z1mEK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730359075; c=relaxed/simple;
	bh=BnctoaThzk9TCtG6Rxw+H7YIyitDA6GU43ZIVeyO6HE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J3zGY16H1iX4MguYqbHwp8HVnER7vdzLi/sLmGS8hl7K8eIWvUkOxvyLgDCExr8FLt2/zi1xNqotclVJljm5OjtbX8YqqG4Q6r/vpiWHkZwBURCw19ZZP1HN8eDPdxU2Cwlq+ERSol2XrpQAvVHNhF6Ytd1btShNjl0SFl7vZco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cGZMBBh7; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d70df0b1aso419936f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 00:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730359070; x=1730963870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vbdfq8Je3d3l1JKu54Y52BJh8JgRsihwOk8O/lVTfe0=;
        b=cGZMBBh7q3rAMIzrVkPom8YzdLggcV+PrDTMNBOg1j82O5cUHJebHkcr9CimlZDoUW
         AD/WOgbl1Miw0kZIs+sFjXPkHZN7eARgC18LFYJgNixJLhaesW6I0Vv+E/SIW/l30BlO
         3/OdjzZ4BlkepY2h8mo6QEyfLwREF/M1VPh3fhf7ZRq0Xzu6fNNByGCIxqYfE+AWbRiq
         2BLsjN4AaKn0boDgiyRHZhOAcYNj8tbtI3rjXrh3eCEt1/zk6zsoPpOg43SSqe5JMRjc
         0RUly4Uo7GiQ2SCfpDUyyLHUzfrf7N6LS0wTZMCOm5We9k8JwQWMWV+zQkmoi2zZyU6W
         Qn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730359070; x=1730963870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vbdfq8Je3d3l1JKu54Y52BJh8JgRsihwOk8O/lVTfe0=;
        b=uQmyi17r4ogPZMrV5zlFbvhsEFE33UUOjuTS/hso/t+tvIznzOiQ886k5+Dp++1Foe
         6XYv+kpCOxy8GVpLiA+NDtiiF3SWefJUqCp7W3MUEhTj1fkrlwzalEZlncQMA3Tsihvj
         i3/2S77EI2HcKNQCp2OOL5ynz0ECyDRiCsqPzA1+FeXnRRFZiYZdQBTXKde26TkcYkw1
         f6AjG9tAUAFbRAyRPZKhXx8CgFAwUmyBI6Q36yCo3IVFA8mYvhu9wYAxe2JO5HvGy+Rb
         ds126y1EVKQtIoDlGH3pQq43pTNJjx76glPW7774I1d0TYHtvQJbKBSPvZ04fatpd4PX
         zF3A==
X-Forwarded-Encrypted: i=1; AJvYcCVGDp39vjoD7QFH1XlnzgS3OTgeM8SGDs9oWJxFUBb+COb2PA3V9Sb9kUE2UyupXY8u0aHnIS6ctAtdECc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd3Xfan3s7amdIpt6hIXoeqGs64WchdJiq/Em+CcuMTij3jhVU
	DMq5LYvXs6hjydSKkBfXbxLj0o44S9Tq048wLjo1exVBT0s80HdI897UhL3NFCc=
X-Google-Smtp-Source: AGHT+IH0ecoJmTJyGmkK2ASaEkXcOU4g+2rVZqrKqcLhxnzq14TG+MSD/Flf10ahMxtm5wkcwC2XhQ==
X-Received: by 2002:a5d:4106:0:b0:37c:d558:a931 with SMTP id ffacd0b85a97d-3806115902emr13662094f8f.31.1730359069635;
        Thu, 31 Oct 2024 00:17:49 -0700 (PDT)
Received: from axelh-ThinkPad-T450s.home (lfbn-nic-1-251-169.w2-15.abo.wanadoo.fr. [2.15.94.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e694sm1187547f8f.86.2024.10.31.00.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 00:17:49 -0700 (PDT)
From: ahaslam@baylibre.com
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Axel Haslam <ahaslam@baylibre.com>
Subject: [PATCH v3 0/6] Improvements and Enhancements for AD5791 DAC Driver
Date: Thu, 31 Oct 2024 08:17:40 +0100
Message-Id: <20241031071746.848694-1-ahaslam@baylibre.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Axel Haslam <ahaslam@baylibre.com>

These patches aim to improve on the ad5791 driver:
 - make use of chip_info / match tables, and drop device enum id.
 - Add reset, clr and ldac gpios that have to be set to the correct level in case they
   are not hardwired on the setup/PCB.
 - simplify probe by using the devm_* functions to automatically free resources.
---
Changes in v3:
- v2 is missing the version prefix. Im sending v3 just with the added review-by tag.
- Add review-by tag from David Lechner
- Link to V2: https://lore.kernel.org/all/94a03835-bdd1-4243-88c7-0ad85784fe36@baylibre.com/

Changes in v2:
- Fix probe error print using uninitialized ret.
- Add documentation for new struct parameters
- Add review-by tags to device tree bindings
- Link to V1: https://lore.kernel.org/all/CAKXjFTPwN2TYW6sq1kj3miZ0f5OqKX0aTk8eGf1sj9TBk1_e=A@mail.gmail.com/T/

Axel Haslam (6):
  dt-bindings: iio: dac: ad5791: Add optional reset, clr and ldac gpios
  dt-bindings: iio: dac: ad5791: Add required voltage supplies
  iio: dac: ad5791: Include chip_info in device match tables
  iio: dac: ad5791: Add reset, clr and ldac gpios
  iio: dac: ad5791: Use devm_regulator_get_enable_read_voltage
  iio: dac: ad5791: Use devm_iio_device_register

 .../bindings/iio/dac/adi,ad5791.yaml          |  39 ++++
 drivers/iio/dac/ad5791.c                      | 203 ++++++++----------
 2 files changed, 131 insertions(+), 111 deletions(-)

-- 
2.34.1



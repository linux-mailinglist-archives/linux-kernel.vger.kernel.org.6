Return-Path: <linux-kernel+bounces-233863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F39D691BE76
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5B5284A18
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F7D158860;
	Fri, 28 Jun 2024 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hANxHiUd"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD4D1411EE
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577480; cv=none; b=VutuEyGgcOcr0a6MLqYs98oetQzjtmzzbS53faUQpi+m1P6u+je7tT0ZOEw4UHggixN1coSULj0DVmpxUiO7mQXl0kzuF1ch5im85iav0AevdeItCc1hSP0ivn1WvPud2R7jHPbVhQpiCu5MXeyK9UK7Lg3pVCzKT4dJCjmkLQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577480; c=relaxed/simple;
	bh=lYImmeZb1rcQUO1ZbkOLTy2hjwx981+WJWr3K5IPScU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TamWOso88XIZ5FlT373hrAo087CdZnCXRYDOJ2z0ntmQ87KdIVWq2lfacTa116uTZwp85AIJQAfrxXV569EwG7B7SINzvqLfqmvldRGQEQeTMwHjdns3wuODskjBb1pBLNhC9UDX2ojELkCQaOrVIAgezvM8SxrUDJI1zGsHPJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hANxHiUd; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-36743abace4so1064246f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 05:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719577476; x=1720182276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8JMwrmhC7WvRqFi7mHLBI9deRpipHPY8SwRD9QR+2yc=;
        b=hANxHiUdXsLOUtcLJpyr77e35N5j2yrMnFyagFNUyMd+QOyM0c9hEHClAdyDXSjrv1
         w4PySuQuFvdpproxt5rrew7vqv4me0J/lo5NETJ+djNfXHwt/EYRlwJZxuFZX5JmpY6S
         rtgH/HM8qgswns8lQ2upUr5d+pgTSTO/FZvUqelb/Bso4IFqtsdmePHd7cFIGgouk9FM
         AOX1ygl2L5hMxEXp1FL8sX+XacWuwTExykxnxPyc/t7dS+8XS7hZSe0rjJuVT69vJQ+0
         NHEMBhTwE1uVudYYaTPndp0wYDyi27ynsaeA8v9SWeM3SFbZ1EohflmDJ8FFfAKKXu6g
         hiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719577476; x=1720182276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8JMwrmhC7WvRqFi7mHLBI9deRpipHPY8SwRD9QR+2yc=;
        b=eSAzmh94MNYoFTCkyOvza3pcF7duCmmVAfOzlojDch6NmqnxvUmBvov27wu0e305RG
         ZyWmay1qObl9p/4/dYnmR++WaO28YkQFYihbJBJRbt1Y2NK/QFEyPtu4ZdmIHW5oouLQ
         93pwW3YhylfxcIkSmI9/7/rtKqPhYzCGgIPU+Qkv9w2eCGzrdg9XHs4EWEhijjlDcHLg
         ecJUBfz6z608+GKGAgWvkM1tdpW9Yhun7wGhZdBLAh5GWw4ouMsZTsvAjw5GcmNrOXux
         090pQRBfXcwHdhIeLh3UIvMga5NXk8OZVgSSzGKqOnHKrJGxA+zwNsorKbEVwU9ARZMj
         BLsA==
X-Forwarded-Encrypted: i=1; AJvYcCWy/CPWCFph2n3neNsiVRLefGkvvY19972OLqqbW9w3jUf8jlHP6eTrsFwh+gKbPMaJHbaP60wGVIFq5wKM/geO9FveV3YPI4ks4ocv
X-Gm-Message-State: AOJu0Yxz97th5ifjcvZLB/s0E7DlChFCUVOWfZTaKu+YzEdC1DChpank
	Av/CYfjHjy2ucK0quE8C0nIPabBl7fT82jIdJa+u8gDQf3Gzxe+pC8VNUXbonvU=
X-Google-Smtp-Source: AGHT+IHxosN5Wqh7y8HoRZFs8ijDOVPu1NWR2Fb/8vhFJ8uvlCBsd36dHnQ4ypdnb0tz3P0qRr3DrQ==
X-Received: by 2002:adf:e58c:0:b0:362:5f91:901a with SMTP id ffacd0b85a97d-36760ab62a5mr1383724f8f.31.1719577476325;
        Fri, 28 Jun 2024 05:24:36 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:78b7:4c75:7e6e:807f])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3675a0cd623sm2179013f8f.16.2024.06.28.05.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 05:24:35 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ALSA: update sample rate definition for eARC
Date: Fri, 28 Jun 2024 14:23:05 +0200
Message-ID: <20240628122429.2018059-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

This patchset updates some sample rate definition for eARC support.
Notably it:
 * adds the definition for 128kHz
 * update the ASoC spdif codecs to include all supported rates, up to 768kHz
 * adds missing IEC958 definition for 128k, 352.4k, 384k and 705.6kHz

On that last point, as noted in the related commit description, I'd like to
stress that I have found the definitions using a testing equipement. I
do not have access to the IEC958 specification. It would be best if someone
with access to this specification could review/ack patch #2, before
applying it.

Jerome Brunet (3):
  ALSA: pcm: add support for 128kHz sample rate
  ALSA: IEC958 definition for consumer status channel update
  ASoC: spdif: extend supported rates to 768kHz

 include/sound/asoundef.h             |  6 +++++-
 include/sound/pcm.h                  | 13 +++++++------
 sound/core/pcm_native.c              |  6 +++---
 sound/soc/codecs/spdif_receiver.c    |  3 ++-
 sound/soc/codecs/spdif_transmitter.c |  3 ++-
 5 files changed, 19 insertions(+), 12 deletions(-)

-- 
2.43.0



Return-Path: <linux-kernel+bounces-174211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A948C0BB4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A524C1F23D70
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204A4149C52;
	Thu,  9 May 2024 06:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="G/VgbM0c"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117CB1494C9
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 06:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715237433; cv=none; b=rXtJUn7h9eI3Tr+M/k34VRzvrU2T3QNJEedVuFdg1QY4wz/ENQWudSe+8xCxUcWePLLIFFcTKG9+6qw/v0uItPX/qNqlZpffiC6gQDtMhWMwaBDnZFFuJLpev9afNEbd49b2spJCCIdgyyaTDTN7Uvt2tgi+ytumIwh6u0hF/zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715237433; c=relaxed/simple;
	bh=UGxdwghxCgiKyxIFDTHz3NP3FPdZfcDQAcxGu9GCCyI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NiTgTiKEUsVXOQkgM6oLF3xkfJqJ3d/2MiHN4YteowZWyaZCfMxBucpjEDPAj2+fdhrp6SEtz0Y6ksYyXPn+EyvO3ZN8m7LQB/uEDWP6Dx9/x8qRNMa5dD2avoEX1SRnuYg2Uvz7E0TqLhtjA8RJcr/8O6He1GdjV5Gq9FD+YGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=G/VgbM0c; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f4496af4cdso554584b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 23:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1715237430; x=1715842230; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JUD6JeUeqy4EDOMZvaUaU8rJSme+do2VQmFMoN9eP8=;
        b=G/VgbM0cM7PLjHeQCTj3EEaO6+kAqfkreOOQEyEselHehEtLTSp2eyxGxDtJE1g894
         yRJeOcS9sJNwX3i5BcE4MGZoQxmRk+AszWeFueQdDPyaXRz1+PnE0eKRj+kF017vZ72o
         5GsTXSUIW0B7Xww99VVyTu9G7KNjOTNkcAdxu16MYPf7xk3AEkhjMAeJEBX6spLEWWsf
         DG4v2PvNxK9eznTwVwhx3ijkIrn3jvILebiATPOcPfEY1b2pYWejuWFLPU0QfUMZlUrF
         A9Y0ciRe5fhjjse3NcxyJz/oymR7DoqL0Vc4I9b/kV/kbCD0km6m1dh6B9p8OKUXOspu
         6mWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715237430; x=1715842230;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JUD6JeUeqy4EDOMZvaUaU8rJSme+do2VQmFMoN9eP8=;
        b=D8dETJ/+qiyS3OKskXN5bJakLA0KRV2FYd41rpoImZX3fumQ/3Zxc3zfUG9CQb/952
         NQfMMOv30yIJJXtWZWvicCriZR22ztGN0XjRob9qjUqMhzeIOHgaUtqOCcY8gUnS4EwS
         AywxvhmEhVhy9mHSZEeCjI0agvKRGvHjyWA45rkXIic0WtAhCFXOBmLPBBWculQnRNRF
         MMX0/q6CAQUGtEiHr5hawoUtVQRKgLhwboXMQu2Tj+SPuqbY+Q6MKc07JBhZF9GxCz86
         jtrIWjFsRB4t45P9qLEf7wQ7Nc+KFHM9GdhvUfNd+iDjJ122Oe8YpqA9HxGy/Elyiy4d
         kDvg==
X-Forwarded-Encrypted: i=1; AJvYcCVobFgKbdw8Dk0WrG8jAUqQ9yOEuVr6KrFBdxG6SidM8XD7tkpiy2efHBaghc61LXz/hhNPeqboRr4+sMJ9TXiL/QOG/lBM/0SyGE40
X-Gm-Message-State: AOJu0YyLjTcPHGMzp45ae1A2KCSytp5SAQnwDo6Zn8LthFDnzqL+BXfb
	YN/W0d/ugDnQDEDkuGrvdpZP38PK8HYWA7qUUyBm2sb4YsMunAXAYzoN0q5pVWg=
X-Google-Smtp-Source: AGHT+IGIlroM64N0tzcOuwqZINRbt4eE7exWvM0jiOPyVjAiOkfOGMjYLCS5hbxf7kIlKYsqyYhiQQ==
X-Received: by 2002:a05:6a00:1b55:b0:6ea:7b29:3ab7 with SMTP id d2e1a72fcca58-6f49c27f72bmr4931054b3a.23.1715237430274;
        Wed, 08 May 2024 23:50:30 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a84b6bsm633939b3a.74.2024.05.08.23.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 23:50:29 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.co,
	dianders@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v1 0/2] Add starry bindings and driver
Date: Thu,  9 May 2024 14:49:57 +0800
Message-Id: <20240509064959.23550-1-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add bindings and driver for starry.

Zhaoxiong Lv (2):
  dt-bindings: display: panel: Add Starry-er88577 support
  drm/panel: starry: add new panel driver

 .../display/panel/starry,er88577.yaml         |  59 +++
 drivers/gpu/drm/panel/panel-starry-er88577.c  | 444 ++++++++++++++++++
 2 files changed, 503 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/starry,er88577.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-starry-er88577.c

-- 
2.17.1



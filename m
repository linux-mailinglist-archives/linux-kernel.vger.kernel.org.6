Return-Path: <linux-kernel+bounces-252007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D34E930CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 05:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81B5D1C20D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 03:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92975C156;
	Mon, 15 Jul 2024 03:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="ilBcOG/y"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF08A50
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 03:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721013539; cv=none; b=fUHn99xI7O1p+slZqjN9F4tUwZySdjtcYDPFOhlHLe8TXWHcrcONS4unP7Xbtig1Ss7RJhSXZQswKcXAM6qWODKhYCUDTuIolJXCrn0pwKESA7OWY1o9+rjPYKoxXIVhuK/9iPTvSJAlqqDPoXMiLm5TcekSYprMRX/T0aK3jY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721013539; c=relaxed/simple;
	bh=wjtBdPMHreyMfVcg/owj5MX/nMWnUBE/aQsKVUQYBy4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=CWMkY6insfdcgz2xcoe1vR3RTL+eA204AT+7eJa7fVdTOsJutWxklm+C5D412aoZ/tQGitdcndjx4+GuW/nAimfEeiymZxG4EfZX1MaEYNWyvCo3HuhO41P8N4B8mze0WLxmr8P8v43z1TZqgqq0X8tDtipH8E32lquIdqCS+sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=ilBcOG/y; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fb3b7d0d3aso23676465ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 20:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1721013538; x=1721618338; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ju8DrbZ6bInn88qO2FCZ8unT05Q9AQ07iShZqqDav6w=;
        b=ilBcOG/yPKL1UdO6cUva/pe8UVYOpp3MniKZ2nXoiihc1Z4wGyjfCr4r8khgH6nS8n
         osFPpgeNqUTYVwfDQgFw+tkbWqSN2kSYwDPHiKtGnp2y0svaa/G2iaratisLGQKYtpyV
         qLTjxO+3iFsXS6LVbMP0A/FCvu8zt++46cyrpy2vZ1npxpKsynj9fWBzFNA1sNseEO2B
         DAvAmZZSqgv+eHa7k80eCxJLWih9wLm6sUqOhGlT/ecoaDfVZaRe7B9LgCZy6SLl74eH
         Gpd2oMxYPY1XFPJkEa6TVrp7gEHV7OuiuAnDVeWMW4w9FYBkypPBitR8vHbbfy4qCm4N
         iWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721013538; x=1721618338;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ju8DrbZ6bInn88qO2FCZ8unT05Q9AQ07iShZqqDav6w=;
        b=OMUU5DHkhIHM6UKzRzRD9kD4cVcX6llh/oWlS9KoCaelnZTPtRSD4HeAdxouxqLyU+
         eTsaurnqvJKM0UezJrpxgZSK8xyEKA/ivIm/sKn46hsMWgAmLPO0dNZUal/s2jMWOi7o
         9HjQ22SdQCSW31p64tWiFrqR0hg54smuAi2ql398dRRahpqXby7vGrq3rqtZLGKEmZnR
         U7numKXptd94jCpwau5S4WnmCQFk9ADBRwNOi4yTed3guuHg7jkfAzDA9m8wTqFmtzTv
         muTln86udhBfUBsmpoPgexdD1yseqbPpkmliRnv2LTFxF9Hfn/kv/IjUQdOEDADlk6v0
         lZRg==
X-Forwarded-Encrypted: i=1; AJvYcCU7otvyVJQY02ApOk8Oil2RT8DrY0UzdzQ8YYpl5ODwvYGl0n7iZboO1wfzeVP8AUjXVHSArJNKzf4/PojOVXwz92us0KZuu6aREPCG
X-Gm-Message-State: AOJu0YyAnQPoYtBeQgI87hVCh/kJdZ+5lToIfxiELvkJkefaGlIDu5DK
	I2plDATFFgxdisZM80ebbKinhzQv5cc37Eo7HpGJOC3olmE2vsyVK4x9kbJ/qNw=
X-Google-Smtp-Source: AGHT+IHkwiw3EzjwMCGtmvmLnp16oQUFGBX4iFQ0TKvfa8nazIkjDovF36AKWz+RcScrp1yYyjzrew==
X-Received: by 2002:a17:902:ee54:b0:1fb:5808:73af with SMTP id d9443c01a7336-1fbb6d91566mr121255385ad.61.1721013537636;
        Sun, 14 Jul 2024 20:18:57 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc451e4sm29962635ad.247.2024.07.14.20.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 20:18:57 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	airlied@gmail.com,
	mripard@kernel.org,
	dianders@google.com,
	hsinyi@google.com,
	awarnecke002@hotmail.com,
	quic_jesszhan@quicinc.com,
	dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v1 0/1] Fix the way to get porch parameters
Date: Mon, 15 Jul 2024 11:18:44 +0800
Message-Id: <20240715031845.6687-1-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The current driver can only obtain the porch parameters
of boe-th101mb31ig002. Modify it to obtain the porch
parameters of the panel currently being used.

Zhaoxiong Lv (1):
  drm/panel: boe-th101mb31ig002 : Fix the way to get porch parameters

 drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
2.17.1



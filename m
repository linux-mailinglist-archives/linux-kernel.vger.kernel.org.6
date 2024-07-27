Return-Path: <linux-kernel+bounces-264217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BF393E047
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 19:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A84C1C20F66
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 17:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA581862BD;
	Sat, 27 Jul 2024 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKWm4i0t"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5713C17D378;
	Sat, 27 Jul 2024 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722099974; cv=none; b=Bp+aUgy/v+o9vU8yEjLAv5eNSXE2W/1gqbIZJsOJFmin2RXvC/G7SbJXd1ItEzDZMwzIqKSGkbm5g3Zw/TprG9O2C9hJz18kNjn+8UXLGnSndPf64KaDMdQGFwzyi5vID6BgujpZni7sCVDlYxTJ8B9XJwS0+7P1Kh680RX0F54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722099974; c=relaxed/simple;
	bh=oi8DPfCKMiycAeBuLa65bMPJTCuM1jjQunvzlPzdM9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fg8AuxtKeAdDvzRtCoQC0qDYx125pPPcorZ43Whn2AmlmYLsAaw9luPNRVfakXUs+sJ2wml9tJR7wNnHIhGaMv+8x34OTrnD8mNegj74AaFv5PXnBkH9iDwjbD5OkuTL2O1TDav9+c9ORJ3eQqk8cXyJwlFuEpieTi/VDVUJugA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKWm4i0t; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so33459171fa.0;
        Sat, 27 Jul 2024 10:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722099970; x=1722704770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yf7m1w06c5ympm5nw7ZZ8hcQC3rrAuWsUQ3V5EYt3IA=;
        b=NKWm4i0tnBp1Exl9VO24ZongTdbBWc6Te9+SD41QxpLxJYnayycT6fGlpf4IFoHMSw
         4XOIsQ08+q76Lsnl+CgfB5MdWfstH254bYgs+t1xYxIkwGQU9H1dAKziNQftB08AI2Uk
         hBIEKDFRShjh7WO1e0qOILBF/urWVVqXifEdJ+UcgXwf+a+S4AEvD1j1kEc5UFFmwSs/
         s3Sy/RTQLr2VxdyqXmXeHU9195SUC93EORyV8Me7rCxvJgmOzzsc/MW7S5+Wb0t9UB5i
         6Sm7BxhSsQJH/0FM8NXuZeUWdSWvARQU+tfdvGAkCZjvh0UKEodv+0aq4UQOV4tRkCZ7
         HMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722099970; x=1722704770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yf7m1w06c5ympm5nw7ZZ8hcQC3rrAuWsUQ3V5EYt3IA=;
        b=iMiXCpLKni9VnnMmup3vFQwFLcStiPrl17QEu4jMpwmFJap0TbwRqpOVnwk2B32dvt
         NDIhz1zfMShlT0h8aAco/qLgNxqtMppBlRICszRgIGTzxyRxnmYbX97AGnrheBI2znqz
         o0c+ydnepWu/wekOFnE/mbva6yOft7nE7dzaYdW0jCrBFdfMzkfAAqh6/ySSjdl33iP8
         1I1filxBsi2hydwwpsI7Q1mM87ndJaYzaM6dIaoMYv2VoosWr0NS1Lxz5UBQomCjZZxg
         pugGCRLhB2V115xO8n932mzC8TgpJ2K6KMyTvsUR933idoh60nFgqHlFvBCYplFQehs/
         sciA==
X-Forwarded-Encrypted: i=1; AJvYcCUPApicUf6WHYhPH2QqLSXP4EJ9zZNjHU6wywOuQhsM/oCSszwlpTtHP9yW5fEE91jeubHgQu3fw8Fe+mBHFK0+ZM2O+FmH0SOH4t6uvdS4EcCIANgaGnpRU02cmyMO/05bR0wAPghZjnM=
X-Gm-Message-State: AOJu0Yzf3inrJYm+dIh0V2qaKtRRQOa46DWj0emRyGkAb8bWMtvRUNz2
	ZJpok1vHDUdq5FnMbxAp0cSuhzs3fAu+A0n4NBB+QhggWysL4cjm
X-Google-Smtp-Source: AGHT+IFFAYuULwOWczPp5VsZibq3GDOYvfXb3OQO3zExmf+7IhsdE0wB7Kg1RLtq32M9R9K8+b6vUA==
X-Received: by 2002:ac2:51d6:0:b0:52c:e4cf:4f31 with SMTP id 2adb3069b0e04-5309b2ce115mr2330329e87.49.1722099970102;
        Sat, 27 Jul 2024 10:06:10 -0700 (PDT)
Received: from caracal.museclub.art (p200300cf9f1ec5003008007610402bf2.dip0.t-ipconnect.de. [2003:cf:9f1e:c500:3008:76:1040:2bf2])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a7acab4de90sm297522766b.62.2024.07.27.10.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 10:06:09 -0700 (PDT)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] (asus-ec-sensors): remove VRM temp X570-E GAMING
Date: Sat, 27 Jul 2024 19:04:51 +0200
Message-ID: <20240727170604.9149-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no VRM temperature sensor in these motherboards.

v2: Fix typo in the commit message.

RobotRoss (1):
  hwmon: (asus-ec-sensors) remove VRM temp X570-E GAMING

 drivers/hwmon/asus-ec-sensors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.45.2



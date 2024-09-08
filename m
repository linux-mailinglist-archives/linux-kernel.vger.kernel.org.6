Return-Path: <linux-kernel+bounces-320428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA86F970A2F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 23:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A97CF2820D6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 21:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C990A17622F;
	Sun,  8 Sep 2024 21:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0LN+GsE"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E2917B50F
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 21:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725832076; cv=none; b=ClsR+av+bAFFhykPctXvKCRYW+Jjf1wXAwNsyV+5tDfwHV0+nCdfKkuVS4LBd/OI5iwkx3cthMwBuhGUm8K833yfpkHBpqSqOow8RnMUgrjzoWD41/fJZ0rtlPD7AHhMWIpt/yjYuoqjZh4M9dINkqhJKg8B0MAJJAomMQzAT8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725832076; c=relaxed/simple;
	bh=XJ4CSrhgxMN9+EF0tqC13ww61yxAj9wlkBh9vifA1Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wav9K/orVQc9rU7YpUI/XNzvPvYsriwWTjHRNlAwEdgcIWEvQTC46HaM4OU971w2YTmUAvsn4R3t2+JRYSNTsmok0P2Jda+JPAahQgebLJAUW7ttBq4GE0f5ScphQsvf4tWH0IGGN60VKjPMPKzCxDRCNGN8a8si8u0EwgqC01k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0LN+GsE; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f761cfa5e6so10617011fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 14:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725832073; x=1726436873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MWck7tjojIGtA3jbkTcAOWGGnySDnERm4jXqJmtrvo4=;
        b=Q0LN+GsEVDwiD+tZJu9wZStsYolPBKYikjW8k2efpjx+WqRhY0CKMaJyDp4lZDZczK
         mWKAItKbayFjnVRWsUV3VITdJyAZfotbRVaow0aPjwUr8t1RVN/S8TouoYvm5gHC5ryK
         dhkcd+S1pkvhGxK58FQxqTJgsVXeFvfrSs97jbPc8DHR6A8UAsJXFQ0XEtqGd5vpMyEq
         qcw0ciRygnnhq+HnKwp6sZ6plPj462FY2gGcDgKdSxSwD6pKj3wutW42fjcrTgtBG7Of
         Wy4UdqIbJ2FpT191h9KP0+l6OVt5CzMfZzG1b1joQ/PepjATla4Zzuvb6KdaL2x74LiH
         J63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725832073; x=1726436873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MWck7tjojIGtA3jbkTcAOWGGnySDnERm4jXqJmtrvo4=;
        b=h098XqsdFf7tqN6s3gr3+AOLa5AGHlB0kpcJ11doXLTnYKi6hGwzcapyNijOAEKXYA
         +vhSI1hoT/4MPUuyuaIJPSdyOctVkOq04rGd35RWcWuFv2A4n0kTkXQtEWjgiKTY/Ion
         nZDlp75ajNbtSYM3KgyOVcRaCwTiTOkEO0l9JjXTxXOi/YQW2tsSRusHY4o+O5wPa0sU
         MNEx62a0vuBdgEo2J+u+6e6C/E+1HQrr/9L7YZ5tkmQWDMZn29wJTWZuu3FbYc/yajPE
         ZWeJ9/Ecp/nPhHjF0bH4G+XvR7MeOxIy9sDBP0F6NUoUJJvQ1G0TDFUWYIobcO8Kl8SA
         qzjw==
X-Forwarded-Encrypted: i=1; AJvYcCWMxIvZ9FfsXyYTAELl9mcMfCRU5lJ85X4BlOtyqm3fCvBjibvtUmpC1jzMVgcesgpPNd+5T2UDF8+3xIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywemeuddx2+BjaOrDydMj8CXfRKhYqQzEhqZy0dhlpIqRPOZChw
	Fz+87JX1r8sIA44rMyjomV/9OSLaNCpbZZSTfQngW6jAbvTmHNIB
X-Google-Smtp-Source: AGHT+IHH5LDq+cJeQo9Iu/YbHJ4F6xDRCHMrQ5Oe3uoIDa6QEvOqs9sr+epk1Zv6hklICrrZK9RnRg==
X-Received: by 2002:a2e:910a:0:b0:2f1:a30c:cd15 with SMTP id 38308e7fff4ca-2f75b930786mr28087061fa.36.1725832071787;
        Sun, 08 Sep 2024 14:47:51 -0700 (PDT)
Received: from localhost.localdomain ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f75c009a5dsm6094001fa.72.2024.09.08.14.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 14:47:51 -0700 (PDT)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Shoji Keita <awaittrot@shjk.jp>,
	Icenowy Zheng <icenowy@aosc.io>,
	Andre Przywara <andre.przywara@arm.com>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH 0/2] Fix magnetometers on PinePhone
Date: Mon,  9 Sep 2024 00:47:16 +0300
Message-ID: <20240908214718.36316-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce support for alternative magnetometer (AF8133J) used on new
batches of PinePhones and define mount-matrix for both magnetometers.

Icenowy Zheng (1):
  arm64: dts: sun50i-a64-pinephone: Add AF8133J to PinePhone

Shoji Keita (1):
  arm64: dts: sun50i-a64-pinephone: Add mount-matrix for PinePhone
    magnetometers

 .../dts/allwinner/sun50i-a64-pinephone.dtsi    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

-- 
2.45.2



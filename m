Return-Path: <linux-kernel+bounces-211639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AED959054C7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628F91F21677
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B48D17D8BC;
	Wed, 12 Jun 2024 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+9u/5sQ"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A1416FF27
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201319; cv=none; b=QPiLCBc6V8mMYaKaKj+LgN4yx+mueP06gIc3ABrNmpe29FaGPForm0KH/LvO+83Cwrce/IfW/JuDQK/gGjtN7dYiUndYsoRtgfTCPvTOFHjuGi61HmazYGmD1T3idtondOBjvTar/oiYALoMOSw9WTGUOZ7uQW7ZLogeCW35R5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201319; c=relaxed/simple;
	bh=EpvtIHS1PelMca+SvWG7puAknhHjGxVB5DFPtxmwnCs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RMmDMnZjckOE4BbBObFKe6vBZsDXcVewBXV9qKVF4FepiOcpE57UYJoqIEK1aHQUzgebx8H2mgq1qaePWks2xrTwhNaJSRVkbrv4WzAuubp4s58yiPNTuumd3AbszC1zC7fPMLDZ+B4mwSRVL8NtxYLZsqnC7w+buRcSpF3P4KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+9u/5sQ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4218314a6c7so30199405e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718201316; x=1718806116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HObF6GyKNBlnlVP2vyDjiuSpWYXmvpX4Hwsfl7m9FPA=;
        b=m+9u/5sQvyFdbyr0VcKp0pDnLCxZ7Arq7SMkQYxbzTWQkJMVAclxgaWdm1TmEooWSf
         1wgEGX5YJEBSxpPDXUHUB33vZPSxKQmciwJ/A7qgB7gJxiyMLHteUdKekUGsS4ZOX6f8
         atuAWKEbZgARDp8LH7O15UZ4yOYYWFhmBSNmjnUNq/gWgQsivyGTNqQEpBheYRtURGPk
         uw0tD50CgjX3EpqemG2cNwOkf69zjliSpNPdg4pRgabEFXp0kcGp/34+/qb09PFS7HNL
         Gi6+vGu2mm5JysYs0yqxJARorrhEhZVHT767RHN9QthDjS/C+kw/g9KJjkO4E1Ktu0vU
         qg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718201316; x=1718806116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HObF6GyKNBlnlVP2vyDjiuSpWYXmvpX4Hwsfl7m9FPA=;
        b=lbY/slkEsX4+pcw75SeyPpZORSvH2y+3zbkF0h2r2AKsHmoiL61/Xzbzu2UViXRGO4
         UBT/pUpCYLD06vBE/ZDs7M/q/uxobDKHQeyxAx9/rW00LcLFMe5UHwWHqnwcOn4pInBi
         rrooIXtRNEEkuvhzhearliL+RLvT3kMtZcJyUYHHJ9rJHXnpot1KmyBPEDwaga2xkRso
         CiXnGdUwUe1l1JdJ9HxFicbl+/QHHu4yumJ2wIfEzPLmVPiqtkKV8ndO/g/s8kWQXf2Z
         CAK3Tyb6/OSgHhCKXf8UWgQxoNhx83r8hRFfQfk/4m+PAA8RKpanwwAWQ32apKzvN/dN
         ci1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7kgF27V4BYwARzmdipBAzwvEq4fYu+IYV4Oy/xZIGqFK/8w6x60xtPQifSDJNbqKPPlAgLPrD7TDtjGvDCKkkSS44cmbbRLjjQa5q
X-Gm-Message-State: AOJu0Ywea3PAJF3kfuegOJsgJf4YBVOTSlEBwpR/JA+EjQL85ZU2Mm2N
	C3Rb2lMxEbVx3GuFniGQHY+2BpWr63Ul2HD1+Qo6u10VBkT8sMG4
X-Google-Smtp-Source: AGHT+IGtyhCbkkyE4wxl92np4Yd0e/c4iXM7sZBxzrfswg2WrQiy8hXPAmQ9iuPCrsi0sQcRtMET8A==
X-Received: by 2002:a05:600c:4e04:b0:421:29ab:1605 with SMTP id 5b1f17b1804b1-422862a7461mr17234685e9.7.1718201315631;
        Wed, 12 Jun 2024 07:08:35 -0700 (PDT)
Received: from localhost.localdomain ([31.120.167.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f2f67b5b8sm4023796f8f.12.2024.06.12.07.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 07:08:35 -0700 (PDT)
From: Teddy Engel <engel.teddy@gmail.com>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Teddy Engel <engel.teddy@gmail.com>
Subject: [PATCH] staging: vt6656: Remove line from TODO
Date: Wed, 12 Jun 2024 15:07:35 +0100
Message-Id: <20240612140735.2423-1-engel.teddy@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove checkpatch.pl line from TODO as no valid checkpatch
recommendations still present.

Signed-off-by: Teddy Engel <engel.teddy@gmail.com>
---
 drivers/staging/vt6656/TODO | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/vt6656/TODO b/drivers/staging/vt6656/TODO
index e154b2f3b247..876cdccb6948 100644
--- a/drivers/staging/vt6656/TODO
+++ b/drivers/staging/vt6656/TODO
@@ -11,7 +11,6 @@ TODO:
 - switch to use LIB80211
 - switch to use MAC80211
 - use kernel coding style
-- checkpatch.pl fixes
 - sparse fixes
 - integrate with drivers/net/wireless
 
-- 
2.39.2



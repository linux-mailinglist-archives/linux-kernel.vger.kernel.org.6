Return-Path: <linux-kernel+bounces-252140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CDC930ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402281C208FC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 07:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D62184122;
	Mon, 15 Jul 2024 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="MNMkaaUZ"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C863218309D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 07:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721028732; cv=none; b=jebAC5Tey/W/+YLdllMNlGVDfzlCPULijipSwUIFqO9CE8TwBTeVOhc/NVs6VGn0/sOLzNNX7SFxtnZWfN4YhzNW9gUs7R4FLnr86TmCq3wIH45j4Uu2cBycuOeVmeojYG93AVzubqFGbcfq8MDTW41++Zv+om9QGD68ZfOHP4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721028732; c=relaxed/simple;
	bh=N8Um/BZiDpRbAQCGRBIIhgQMzSAwLh2B1/4xdeV/dWw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=QXlwf7uMk+AYUL94BYxR8RioihOZsfHtgGR522Ves6dsKsV6cpJUHQ9XwM5X0Rz1JfLJrEme85wL7nYqc/9hrOEO49hBCvpQBIiaHcaIQfEtgddyqDrjKPJWOGB9NDX3ed+pO2rW/3N5Nns1DDWKeZskyFYpgFkEB008fMVlt/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=MNMkaaUZ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70af3d9169bso2729665b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 00:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1721028730; x=1721633530; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BU1rxmI86o5sSy9mWgyvdZfBDmEh8iUs62QhEQ70ryU=;
        b=MNMkaaUZcGqLyIE6jjP+TR5jEdblAApaF9g5wpifNDzDLPrBQLSfUZCkG4ZIVZlxNT
         1DcCt2K5yJDZTz8Kb2bSyvvaGsVfFTjGja5wp6Q6j43EWl4LPpE2/pJEJ0IHLG4JkGhe
         GwQuWzH4q0VDIgkiqbkfQQ7pRQlx5fvN3TLSTh80XwpPhmnFZsVY9Q6seJwz3lRybLZP
         SoTc+I+Fwq8N1nrjcXoQk9t5VRZelJEYPJGKRTPGexNw/rP21GzvyiedG+A/ZTVQ4sDf
         RtaAm+fxjD0x7S3rMOXPuDOuNCHCa3XEY48gLLeEhnn8+FlkcrVIUJsuZ0kWnbsSVP8i
         Bq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721028730; x=1721633530;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BU1rxmI86o5sSy9mWgyvdZfBDmEh8iUs62QhEQ70ryU=;
        b=poMzvj0AUi0jXYKJUfmyyl/puueEBD+VRpJu6Hf1nC9/a1l3q7jYgBikhqBbdWFisj
         WWVroeOYvB6clrTkMf6ChhQZF9KAh5Zqh49dYEYvISoYMH/xTav1iwyPr25qm8l8PBcE
         X6GA50EL9jhi76sQ93uu0VsfcZlPKWZPks3mDJIssJgpNRDoM1xFHxAx4AkJmK4GUhSJ
         JLFowYvjVr4MHmIV6sSCquo/v9xkGuyUYNYRsFJCYSR0oHEgTlo0KYXZ6XeAw6vNHAmY
         AK4HUYAUsBryN442Zy6rr8nYczWjzMWm5CUggKmWQo/7AISTWiG6HrF2uFxlhQPGgTzc
         wceQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYUsFYyWIqVDg+FwRL3oW6HY3nQIzcqC4dfPRN57zynBEsDHnEjjCbxGHsR/7d5tKT+7IaOKvghrH77kzBabzs6NKQqWfq+8oxubgr
X-Gm-Message-State: AOJu0YyST6mYAnlZcMe9Y65TRsRXf1cY06j2iglPSwawkOn18RCmO5xZ
	z7RH4SELLjcHU7CiTg0E7OJ50kkv6iafJltguWL486doXo19Y6JB8zAcr2fUeS4Eu8O3sFj4qgh
	abMY=
X-Google-Smtp-Source: AGHT+IFeK1zVSa0EG0mSSa/orniI/Xcso0OuomS0td75qDeaGr6wqFxmGjNYbtPS7w/xWuJR3oCwHA==
X-Received: by 2002:a05:6a00:4650:b0:706:34d2:62bc with SMTP id d2e1a72fcca58-70b435709d9mr18101468b3a.18.1721028729929;
        Mon, 15 Jul 2024 00:32:09 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eca75a6sm3654464b3a.164.2024.07.15.00.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 00:32:09 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.co,
	linus.walleij@linaro.org,
	dianders@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v2 0/2] HID: i2c-hid: elan: Add elan-ekth6a12nay timing
Date: Mon, 15 Jul 2024 15:31:57 +0800
Message-Id: <20240715073159.25064-1-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Elan-ekth6a12nay requires reset to pull down time greater than 10ms,
so the configuration post_power_delay_ms is 10, and the chipset
initial time is required to be greater than 300ms,
so the post_gpio_reset_on_delay_ms is set to 300.

Changes between V6 and V5:
- PATCH 1/2: Respin the series on top of v6.10.
- PATCH 2/2: No changes.
- Link to v1: https://lore.kernel.org/all/20240704072958.27876-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Zhaoxiong Lv (2):
  dt-bindings: HID: i2c-hid: elan: Introduce Elan ekth6a12nay
  HID: i2c-hid: elan: Add elan-ekth6a12nay timing

 .../devicetree/bindings/input/elan,ekth6915.yaml          | 1 +
 drivers/hid/i2c-hid/i2c-hid-of-elan.c                     | 8 ++++++++
 2 files changed, 9 insertions(+)

-- 
2.17.1



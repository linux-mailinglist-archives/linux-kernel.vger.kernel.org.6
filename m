Return-Path: <linux-kernel+bounces-179405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8FC8C5FD5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 899721C21778
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4FC39AF3;
	Wed, 15 May 2024 04:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="IIqB61lI"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAC82E827
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748757; cv=none; b=qh3p1df5cQGmscavF8G/AT1+Fs1LJyJ4ntazY4PWb/IN+Fdrd+wtSCJE0RkSrerypp3PxbsW+2vtKirCx15YBmQZUVeduAqVJPkW22uYye9D9LVRIb71V0HTv/Ddt4uaqPDUYNb+1Spy6gMFKZhQ8dMqXMHGEWrK36jG/uF/4lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748757; c=relaxed/simple;
	bh=wuOcB61GVi0HcjzZuCw9P+IUmYgpygNyIL+EQ9XWesI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gKQYZe7abqiyLA1X5ALTt9jucd/8dyyjoJG4JS9Bji3CafUS0uR9qFR6sO2Ru1OaxGGf6Zj1PJpA1RKjOHwFOUMpMSZPn6oVqZfm6ODkWzREOza/Nbw9ct2wtsNtPOv0Lpl7c/S63kRtTNWuYZmdtjSWHTikFJvVfLbLnUIXN7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=IIqB61lI; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c99501317bso2878706b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748754; x=1716353554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4V9hVw78xB7F0JDfubryUfKBGH6YZ1voDuXRo8G/VQ=;
        b=IIqB61lIgsKb4vXN0SbUnIRQiY/EYoIHH/x/Jqg/4cnKnkQbSMuKVXyo6V24LEU5zV
         FoFUdD3ie41Ymq83so94LNbdEPRBfpb3cxNKBQSOpTT2TZpFo+1nhUMTrb2xehe73IIm
         xHA//k0DJCVWGGq1TP5/iA1DdCjr71n2BF0QhewPOMO5PzjcaVo9XGUo4anLJVa1zend
         TkOwWt++D1gKnObpgqoIJi4K2oIUUZDuqiRvwpG/9rFTVSJhSPXAANjUu5rpoYcoeLH1
         GTEExlKXu5GjYloA8wUm/M35bqhEsjsMty4oDcxZW8ij+laLgDabYkcVsNeWWoXXApu1
         zqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748754; x=1716353554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4V9hVw78xB7F0JDfubryUfKBGH6YZ1voDuXRo8G/VQ=;
        b=iT4s5Ux3YF8itgfwvTi5tyBWgHku5s/mEjTco0pzUGWwQUhd8XgsgJafrHaKinVvZB
         MfptTJvhWAoqhhz/XI2BMZ5KGtVigYiGQlMN6IakWc/72qHgN9Eo5lw12tYw7Q3YZHwM
         UPr61Ygw1FxfN1+nJBeOSvqo/dgsSTusU75nZ4SFl0eKMra7UCoM4kAbHfBofVfpX9I1
         Ruo0xxi/maMa5zBrUsdRMQPmpjM2A7Mrnx3Yg1AXvShB9Cw1HU9C+Ie5V7ey2IeQT1ml
         AkflXcsoCA5XxW/B8rJyG08o1VBzaZqZluo+oau9kqQ5eY1MjX+O7nMtYmxFlIRzOHs5
         1AlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvytWsBHkDzr26LnXmNb54ivrWlbbclrN/wvw2DFip25hWBwkWBm6mR7cFWscIcp0GPjEeclp1WmB+kBcpbuvfDgtXMNMhgsH2FvDc
X-Gm-Message-State: AOJu0Yz85T5JxbHvrJGgf0Sv6CcOo+Z5mzlo93Fw40Fdm3digqB8sVB+
	T66fgLnX88MUUoki/puNyWhp22CZgSgrBQDobqVDpWInZ4DYHRLuY1CBmJ8PoY8=
X-Google-Smtp-Source: AGHT+IEXl45CKkJSSJb/XlUNrrYpFx2hZWsIu9WEOWiFbWsAKF8Ju8674QW6oLZKShwlfpCGbgdh/g==
X-Received: by 2002:a05:6808:647:b0:3c9:71d6:511f with SMTP id 5614622812f47-3c9970ce5a6mr15615156b6e.50.1715748754266;
        Tue, 14 May 2024 21:52:34 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:33 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 01/31] Staging: rtl8192e: Rename variable IsPassiveChannel
Date: Tue, 14 May 2024 21:51:58 -0700
Message-Id: <20240515045228.35928-2-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240515045228.35928-1-tdavies@darkphysics.net>
References: <20240515045228.35928-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable IsPassiveChannel to is_passive_channel
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index ee469c9118b8..4a0db2dfd5e9 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -2356,7 +2356,7 @@ static inline void update_network(struct rtllib_device *ieee,
 	dst->bss_ccx_ver_number = src->bss_ccx_ver_number;
 }
 
-static int IsPassiveChannel(struct rtllib_device *rtllib, u8 channel)
+static int is_passive_channel(struct rtllib_device *rtllib, u8 channel)
 {
 	if (channel > MAX_CHANNEL_NUMBER) {
 		netdev_info(rtllib->dev, "%s(): Invalid Channel\n", __func__);
@@ -2432,7 +2432,7 @@ static inline void rtllib_process_probe_response(
 		goto free_network;
 
 	if (ieee80211_is_probe_resp(frame_ctl)) {
-		if (IsPassiveChannel(ieee, network->channel)) {
+		if (is_passive_channel(ieee, network->channel)) {
 			netdev_info(ieee->dev,
 				    "GetScanInfo(): For Global Domain, filter probe response at channel(%d).\n",
 				    network->channel);
-- 
2.30.2



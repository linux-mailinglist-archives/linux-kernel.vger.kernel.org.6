Return-Path: <linux-kernel+bounces-190320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 742A58CFCD4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10DC0B2051E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8A413A268;
	Mon, 27 May 2024 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="0kUi4UFF"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20766139D12
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802084; cv=none; b=fynLJQ2UKufbz+HNmf5dPA95xkcePULcuvct6oaW0Zi97JK5k7Ing2bPQbcVz2G2ilgawOVJOg+YaEcVtvzULP0W9LYtjNlGwkNcEJLMs5z/IAPiyuus2THveEDtQGlZleYFREVNehqV0OVyvA5q0Xz5Sl4BnTMkmm7v5m+gS6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802084; c=relaxed/simple;
	bh=RFn21Fc4H5utP8qCrhUdpkQgIi3UKcY8WLssi3hKpK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FbVENgBOds/CNfXEYkjeKSoEgDFqL9h53wclDU+bM+nfO06Ynd6oprsO8CPH7gMPCrA+oPnIr0GcowisS95ekL3J7naOCjhu/u/M1wOS1Z3+RD9GTrsSYg98jnjRzsGtoHUhHMbtRTlm4zlaffDZxQr3k2JQ+LVFlSMuQRvaTJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=0kUi4UFF; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6269ad71b6so336919666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716802081; x=1717406881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J96rqICq37jL3hvLuP8uyxwpRi/d2WtSxgJtcmDal6I=;
        b=0kUi4UFFdeFP68VvcvnQZswt5tL6/TvhchrZNvYgfEaeKkNiGU2cBTLtjxgtQlly9u
         eVJot28PPTENvzTRawhhAmtw5nZ5XG2d5ALJ0FNsxCrLttxKIj9TKMa1Slfg0rzmBCYa
         RWOSamFdXM8TmYMU/sI8sYAVzXkO+GwErZT3Gr+Kf3quZphqnVScyyJ/vFDzJoAP9LM2
         JGoUqFOvJPS9H3hRz/SsfZDQ6JN9g+iSlMviQt3NBVBgiP1WkRQj1s6NlUh23qLEJEX/
         StwrtHdbk6wVN5cDgrSE3IFfc1eNW9UTLredtVceOYxzbhznxu18OqkifnPzKUWv2QZo
         v9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716802081; x=1717406881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J96rqICq37jL3hvLuP8uyxwpRi/d2WtSxgJtcmDal6I=;
        b=QLEwiUCPAsHyjcXe5MXejVJeFrg3rPe1TiFzE3jQs1xuAfzlXcjtVgzlAmicuMhc/X
         Tnj46oTDrpojYPBSOr4KVQtmG9CmpP2wmxzFGdwlmGsLJiXXOL/ZThd8YPvrE9mNNR3X
         T9A62r52u2XmBZ7uX/ED5ItIBfkG2WeWycIq0906HP0IOv+qJTr/VHSzOvVloZgOZzH1
         5/qS+bbHKMVDp+u64CVo2nn/KaPa0naG2agkIjdxEchTTV6qcMH4E5MtrHCI46C6szN5
         KpbqHHRkNk62L/OrvMWAoQoh5Ioy2c5fWfgiEv3BPWF2lXTi5u8L21u7Lvn4NSDnV457
         JAWg==
X-Forwarded-Encrypted: i=1; AJvYcCUKQCqVIs3oTT3+TxRzBYxxqf4PvuTn6Et7OxuM8+xEJFJu0Sdma6e7q7WlrPdKmrhfprDSbK7NhL0SQm7dlgb8NhmaUDHjhQlO4TIP
X-Gm-Message-State: AOJu0YyiEZ+THibQ5hVg5AVmLGeVtXr5wrcriYuZmGV4Vn8ryeAFYlbl
	wlmO9MzliGFTqLulpu/qtHc103U1u1ZcD+UKhBeGqZzV5UTgRePwt4MR/HRmwDcFucc63nQvkaR
	0+qM=
X-Google-Smtp-Source: AGHT+IGk2QJpSI8EZzi2K46AUSPOdebZwW7VoQsgcq+4bAfmeRjMLlMu7GmzLa3MPUPPvPUW1aOsZg==
X-Received: by 2002:a17:906:38d4:b0:a5a:90e9:c2a7 with SMTP id a640c23a62f3a-a62645d7504mr520143966b.33.1716802081248;
        Mon, 27 May 2024 02:28:01 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cd9fed2sm471030666b.187.2024.05.27.02.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 02:28:00 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: thorsten.blum@toblux.com
Cc: krzk@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] w1: Add missing newline and fix typos in w1_bus_master comment
Date: Mon, 27 May 2024 11:27:47 +0200
Message-ID: <20240527092746.263038-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240515101150.3289-2-thorsten.blum@toblux.com>
References: <20240515101150.3289-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Add missing newline before @return
- s/bytes/byte/
- s/handles/handle/

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 include/linux/w1.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/w1.h b/include/linux/w1.h
index 9a2a0ef39018..064805bfae3f 100644
--- a/include/linux/w1.h
+++ b/include/linux/w1.h
@@ -85,7 +85,8 @@ typedef void (*w1_slave_found_callback)(struct w1_master *, u64);
  *
  * @data: the first parameter in all the functions below
  *
- * @read_bit: Sample the line level @return the level read (0 or 1)
+ * @read_bit: Sample the line level
+ * @return the level read (0 or 1)
  *
  * @write_bit: Sets the line level
  *
@@ -95,7 +96,7 @@ typedef void (*w1_slave_found_callback)(struct w1_master *, u64);
  * touch_bit(1) = write-1 / read cycle
  * @return the bit read (0 or 1)
  *
- * @read_byte: Reads a bytes. Same as 8 touch_bit(1) calls.
+ * @read_byte: Reads a byte. Same as 8 touch_bit(1) calls.
  * @return the byte read
  *
  * @write_byte: Writes a byte. Same as 8 touch_bit(x) calls.
@@ -114,7 +115,7 @@ typedef void (*w1_slave_found_callback)(struct w1_master *, u64);
  * @set_pullup: Put out a strong pull-up pulse of the specified duration.
  * @return -1=Error, 0=completed
  *
- * @search: Really nice hardware can handles the different types of ROM search
+ * @search: Really nice hardware can handle the different types of ROM search
  * w1_master* is passed to the slave found callback.
  * u8 is search_type, W1_SEARCH or W1_ALARM_SEARCH
  *
-- 
2.45.1



Return-Path: <linux-kernel+bounces-302409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD1295FDE7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 02:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2254BB20FF2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBCB1361;
	Tue, 27 Aug 2024 00:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSaGje0y"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00EB138E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 00:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724717475; cv=none; b=dg89PBm9XakvRrpvy5XFwcWoORyuUxx1CSVQzIA6a214YyjW/B4/nXwEkOREvI5kBXPDbL3l78XvfKVzZoHTg4W688akvWhwPHWsg8CWsAUqWwXd5bOVg10cqnee3yadWokVnPqQSHq0c5Sc7BbpVqB//+8//Ut3WxMicVIwEDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724717475; c=relaxed/simple;
	bh=kXWyl0slUnO+a5sfYHnSJVT3blREh+IyY4fDehSco6g=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=gf4YFitTXYv2IGx4Hs3NO1dIYpkQBbMd4Af7rKbNNrviS1vSdCcbga7UK3DialRJlpzjTCz2IEzGFtQaSQ7p67LTTR0ezOY+7ighKTD/7wjxNShg1sFeSsByjWBifRXjv2rYjbupJNmQ/O6sJXxyh4TZDMdGmi7+PFC342E6k5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSaGje0y; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7cd9e634ea9so2896362a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 17:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724717473; x=1725322273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=k/5xpuZ3Z5HigZwmywx2n/8WWg9SbPfgJSYKo2cWfbo=;
        b=PSaGje0yRf/L9LnVvIDk/Ggy14GeWS9HQfMkuvxn85JX/0TPCLumxvPDURlcQ/UPlH
         JPuUqSF5x0aDZ3FIuCzHUzOEvhDSwcw+Vbzz8Wa1cgSVUtWpQzlI5k/zhA9rFb/d/Qwn
         2RtzsO8Uptml/M4dYKWQh7MSXSqRlzrBqepnkf13an7GsTMi3PkY/X/vT7CW6WtBIkOl
         ZiLHNly5iNC/8WUTlRUFTiNHlOny5B0oCjhSrZo/YDposv5HkMjhMZLHpMLCIQmiRZFU
         ZCKx6oRaXWojAieCyG9VudL7eAc822+EivXIJsL9JxQ6FkzAx4wzqxXorVOgtEB3MQ97
         AiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724717473; x=1725322273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/5xpuZ3Z5HigZwmywx2n/8WWg9SbPfgJSYKo2cWfbo=;
        b=tSMMdVHF76MT8jXzU3XoqLI/nGMenzXoaEBEoqi++ahG4Vz5LkfbEilTPDKhZgai3f
         QsBEldOBbG05FDOdLR1LCWhpy9XMqBcPAj9WyktBR6D1wgQOPvWl6w4Z6HZtdVONfyTd
         d/GYc9EvSXlE4X8MKKY2O6hUbJt9EHGAoWJbP7imf2wN3vjou9e3/zHS2tfnl/HTmQQG
         MbzNl3DqruG+EVZ95jl57yGYRxLncCa9RbYLVzX9m8LDZmRJ9uv11cpYmsMOnzwhWHo+
         LfkrRiVe8twSJeY+AMS3wRiSW8a1JwzrQG3bwUddhiukEogiRxhB40v4Bxbw+BkKk5hG
         XAwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV1Um+dRQlogZARzkEQMAvHEMaxBpHMp/QUIgJgFvBzqhz0kRV4DJuNr9Kb+0y/G17fhQWnWfVLQNfbmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYylRNXlAE9NxfI/snTYynRIH+VDOiATL0FqueMFIeoeZASAQH
	6eBVEsJBtfegFe+91GTXljt07bVHiO4mjw6g8ql8dtcj8RlfSJpdCOOcrA==
X-Google-Smtp-Source: AGHT+IGA7sBRy2eLjfiFC5yRgmq7NtE5n2KHyaVp7Vh+LqY+09lXe7pw53iNR7nlwPoeqgSygtmIIQ==
X-Received: by 2002:a17:90a:514f:b0:2d3:b643:8386 with SMTP id 98e67ed59e1d1-2d8257cdd17mr1307070a91.9.1724717472775;
        Mon, 26 Aug 2024 17:11:12 -0700 (PDT)
Received: from BASE-20.home ([2804:868:d047:ced3:1cc4:9ed6:b242:b7e6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613af14d6sm10457462a91.37.2024.08.26.17.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 17:11:12 -0700 (PDT)
From: Alien Wesley <alienwesley51@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH v4] staging: rtl8192e: Fix multiple assignments in rtl_wx.c:529
Date: Mon, 26 Aug 2024 21:11:07 -0300
Message-Id: <20240827001107.10641-1-alienwesley51@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separated assignments for pairwise_key_type and group_key_type
in order to silence the following checkpatch warning.

CHECK: multiple assignments should be avoided.

Signed-off-by: Alien Wesley <alienwesley51@gmail.com>
---
v4: Squash v1 and v3
v3: Fix typo in commit message.
v2: Removed two spaces in front of "=".
---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index fc8e7f73b2a4..67c4793e0fc1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -526,7 +526,8 @@ static int _rtl92e_wx_set_enc(struct net_device *dev,
 	mutex_unlock(&priv->wx_mutex);
 
 	if (wrqu->encoding.flags & IW_ENCODE_DISABLED) {
-		ieee->pairwise_key_type = ieee->group_key_type = KEY_TYPE_NA;
+		ieee->pairwise_key_type = KEY_TYPE_NA;
+		ieee->group_key_type = KEY_TYPE_NA;
 		rtl92e_cam_reset(dev);
 		memset(priv->rtllib->swcamtable, 0,
 		       sizeof(struct sw_cam_table) * 32);
-- 
2.34.1



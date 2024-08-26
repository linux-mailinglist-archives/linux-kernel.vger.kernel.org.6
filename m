Return-Path: <linux-kernel+bounces-302127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4C195FA3C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE0F28177C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA841993B1;
	Mon, 26 Aug 2024 19:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBLjoStK"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB101991C6
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 19:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724702361; cv=none; b=RbQ/S+4eAcyC/m5qR5jrIoyoj8KPRws3gLqtZl7EfexMW//usdm6TgvNRB5KauhmC/qXe9XXqSVKz9t7ms/nKVczgJ24P23LqYS8Cx16jfts2jDe4Rd7r4tAeiOef47bimG3WP0WnoP6W81pmWDGMWhT7NBiJi7sONl289MiUio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724702361; c=relaxed/simple;
	bh=Bk+2LSaj9EeE+nnXluf87TBin/vqBAk22xmDYHO3fK0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ex6Jdq9uuAlbjPoqRp5QlQ8GcilTcrNLCKbCdsG35sX+4uVo8FJjlAUlvMAvuxXxyUbQxf2V2DL38Ngf9nMByhbNKz7vfTiKWsbaKc1J27lCSVrkyBIlzv/75I04jRB1AZKwH3cIQvObbgNQfZdW9AKOpjD+h/JQgkAMeoNPPJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBLjoStK; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d3c08541cdso3696231a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724702359; x=1725307159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=X76d0qzMljxYzwZvLsGN3K4fjbk21Yj71ASVecUJ26U=;
        b=RBLjoStK5TghAHBGn/OQahsBQJ5v6EDxoYY5mBOleT+TG2eFpA9WmZ7EQb8qX3bdLK
         MzfzzXbfa5I/24AkesV244BCJ2o1lz8JvBZpFiGORfI+N4fMCszvcZXbrrdFs9vLdfoX
         4Qu6Us0gkgSrjG/JQVz7O85A3N19C55xyz+ooiB82DdFaN8g2gNNLE/YPGrQd1j1u3BJ
         29k99sQSh7mo6oIWWFDcU8mz1XeW9JRXA8HBSkPyX8j4X5z8b6/+UBQcs/CUzdBmC+oe
         QIFqcB9HEOQWRqV69P6liF/st2VnDdhBk7mgvwCDNYs+QNcouhKlisilbxbqIhK/IYsC
         QEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724702359; x=1725307159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X76d0qzMljxYzwZvLsGN3K4fjbk21Yj71ASVecUJ26U=;
        b=OjHBTu2CyFU5KBtO6/JWRIWlQ5GgcQBkN5k1jvl6cEC2/oBOT6U6csIn4i7X4lO1DP
         uGTyZe9QgMENQLR/jdKQVXgjJV82mSrwxZMCFfABEtPW4gr1/EsSCkZKiGZOIF/CjCOJ
         RpD9cd9oHjyR2CyHvnSJBDV0AxTCEN33B8hxVQfVTzZ2x/M7CD4592uceH36kqcZWvsq
         2GCzT941Vx3L04cfPzFZZQ8x9009tx1GAgyqZiLfm1BebkZ7OVzSbH5w2Lyl427Xk2XF
         1d6+U+PwnMbrVk/4NReYowHFEpmv8IOj3UN9CdzL99ENnQ+jvei5W5eTM5n2os4puCya
         EudQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUkxGDsDb0L2JhPhvYPgXaNBrFh66ol2UIj00tGkTbb8eS+ksL39+A8Tk6scRJVPb3VlRLZ0AhaMmpEn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB/vrpNAKGfWP5nF2sxGZyv6Wbc2pjK7k2l31qTH6PYZ9bWiRm
	XAsgB2QPbLvrSTuFI8x3L+8Q53P0ez7YT60DSI5n0vn4/JjNNP/r
X-Google-Smtp-Source: AGHT+IGiX8ZhUr04nVshsnC3mMx1hoI1Wbn2TiDcAGgel7EEg9ph8TOx4wkM+IrviTWoui+RMe/YLA==
X-Received: by 2002:a17:90b:3001:b0:2cf:c2da:771d with SMTP id 98e67ed59e1d1-2d646c452ebmr12658738a91.25.1724702359537;
        Mon, 26 Aug 2024 12:59:19 -0700 (PDT)
Received: from localhost.localdomain ([2804:4b0:1408:4900:9408:c7b2:31:3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613919fd2sm10424308a91.13.2024.08.26.12.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 12:59:19 -0700 (PDT)
From: Gabriel Tassinari <gabrieldtassinari@gmail.com>
To: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH v2] staging: rtl8192e: Fix parenthesis alignment in rtl_core.c:325
Date: Mon, 26 Aug 2024 16:58:55 -0300
Message-ID: <20240826195915.8494-1-gabrieldtassinari@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix parenthesis alignment in _rtl92e_qos_handle_probe_response to
silence checkpatch warning:

CHECK: Alignment should match open parenthesis

Signed-off-by: Gabriel Tassinari <gabrieldtassinari@gmail.com>
---
v2: Include the modified file in commit message
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index ad21263e725f..18739583f579 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -322,7 +322,7 @@ static int _rtl92e_qos_handle_probe_response(struct r8192_priv *priv,
 
 	if (network->flags & NETWORK_HAS_QOS_MASK) {
 		if (active_network &&
-				(network->flags & NETWORK_HAS_QOS_PARAMETERS))
+		   (network->flags & NETWORK_HAS_QOS_PARAMETERS))
 			network->qos_data.active = network->qos_data.supported;
 
 		if ((network->qos_data.active == 1) && (active_network == 1) &&
-- 
2.46.0



Return-Path: <linux-kernel+bounces-273811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 114EE946E6B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 13:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2BC1C214EE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 11:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB6A339AC;
	Sun,  4 Aug 2024 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbD9Sm1k"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723622557F
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 11:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722771198; cv=none; b=RUG90bAIhKTFLWpbZWdxwjP7/qu1hshF1g7HLGKupplUQ7lJYDkULou1Tt2Jc5D6lbz6ZocoA8b0JRG2RwKROYE8/HBwd4LO9MWkoEwK98b5uLum7M60zTISsJEbI2wa0p0/64JiniC3tyUdTvd7mVzirwVfxiQZ15U5xGaOLhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722771198; c=relaxed/simple;
	bh=A+IcJ+HJKIakiMn7+45tLRQklFu1qPuZEJp5irnmr1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RtWknV4pyewMPOghMjCJhnBNEXKXEjS9CgGAsDNA1oHf7tohIie5odJwdFE3PbaTweGlEd6YXJbiYSThUPVPuLielXvPWHWCFWMQwvRZUov0G1aEDXTOLAbPs3bep/+kVljFZ9zbR2UnSkQ1sEsxRIf/4ysTOX5Iuw3W52RjpiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbD9Sm1k; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70941cb73e9so3982921a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 04:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722771196; x=1723375996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5sdUw1gMmBexUN/QuH28jagZEeLpDRY7juKOS4D3OAU=;
        b=HbD9Sm1kmNN3XkNyM3TpZsWmGNvNDQMZUQAjlNBtYvL2hM7BF6YjxFXviOSnzCkr69
         fbO0m9Jss05Qr3QkFoxVs0wdOrrXXQ+vpsLfUQCazJlVoLcAfF5lJhfnOiJoo8tPPGSK
         R0ORRRWROTz6mmLwPsxuZY4qm6++Y+c7k0EUPuj6lnQrwRvNa+AGX2J4XiUMlUpQWMoI
         zDeJO5qRfiP080EMrPiX5JQLtWKMSjj/fU5AVwoyfsItb63e2ZqTzX5c6Yg7np5FTpw3
         tJAkK3RGFVDBgquoi3pryDuA1nIfSbFZEL66n8YfYkUGRGpmJYRLQfzjOShl7Kppadd/
         jbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722771196; x=1723375996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5sdUw1gMmBexUN/QuH28jagZEeLpDRY7juKOS4D3OAU=;
        b=v6BeKcrkqKJBYroab5GvAzI1erdZCUjHV+2yy6YFDxZC1h3m7SV3IVN8aFF/c3cI6K
         8RbxqzkTrGFT29nQRDM8ufxF2CfSWxfliL+m54PN52uHf/vBxz3vwFjoIJki9S1AsmkR
         bfiHSMbDJzM4hSWytkExtqRt+jgf4e7+tsC5PMhjFc4/uiKvIN2W7a26lIKiRIbj9A4V
         QqPNfRysAV74vKhud5EBjnfN/PX8KihPwMjzzakhppiL5GTukBjDYRKMHeL8ht7lCd6x
         57M/nD2MUQhcBTx0WFREBXISN2aHPYat9R8pXv94d0lMYB9dGjNjVHSQEHGZLbmYrI/t
         T/2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXA68LuHAIrA+d8b/7Q/xxklN7Oxr2zZ2oBg54ZynqzZGtuPJT25b/1vCkN1oRUXUVGVKD8q8QADiU8Cwx/+8A2kQ0UpX4bmzUImMpc
X-Gm-Message-State: AOJu0Yy/rtgI8oehk5EcZxdR1ZSg2B4zYvJAoXIhDkOX3JFWsE69/qit
	mg4ZSwrUPFAew51otwLSEVX6I2SVl+/vU6LCWbPJqPBXsCLvBgrvoL/hORNZ
X-Google-Smtp-Source: AGHT+IHJ9lBg/o7obPLJaYOie3oDG4dhPJu4D3RWn38vLXJEjpCzpYfl0GwzRxvSo3+epvtwdL4xAA==
X-Received: by 2002:a05:6830:6e05:b0:703:63d3:9ef7 with SMTP id 46e09a7af769-709b322e163mr16768079a34.14.1722771196377;
        Sun, 04 Aug 2024 04:33:16 -0700 (PDT)
Received: from VSUS.11svbebsuybebf4lhlhk4eftnc.syx.internal.cloudapp.net ([20.39.190.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed2d0aasm3820600b3a.206.2024.08.04.04.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 04:33:15 -0700 (PDT)
From: jiwonaid0@gmail.com
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jiwonaid0@gmail.com
Subject: [PATCH net-next v2] staging: rtl8723bs: Delete unnecessary braces for single statement blocks in xmit_linux.c
Date: Sun,  4 Aug 2024 11:32:49 +0000
Message-ID: <20240804113249.10257-1-jiwonaid0@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiwon Kim <jiwonaid0@gmail.com>

Delete braces {} for single statement blocks to shorten code.

Signed-off-by: Jiwon Kim <jiwonaid0@gmail.com>
---
v2: Fix commit message
---
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
index 1eeabfffd6d2..e0736707a211 100644
--- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
@@ -144,9 +144,8 @@ static int rtw_mlcst2unicst(struct adapter *padapter, struct sk_buff *skb)
 		psta = list_entry(plist, struct sta_info, asoc_list);
 
 		stainfo_offset = rtw_stainfo_offset(pstapriv, psta);
-		if (stainfo_offset_valid(stainfo_offset)) {
+		if (stainfo_offset_valid(stainfo_offset))
 			chk_alive_list[chk_alive_num++] = stainfo_offset;
-		}
 	}
 	spin_unlock_bh(&pstapriv->asoc_list_lock);
 
-- 
2.43.0



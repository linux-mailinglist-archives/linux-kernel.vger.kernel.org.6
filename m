Return-Path: <linux-kernel+bounces-398739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4109BF556
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 021372837CE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198A220A5F4;
	Wed,  6 Nov 2024 18:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiyvfqzM"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFC2208988
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918042; cv=none; b=QXjHpjJgW34ZbIcf7eYabHgfhyBhEKVj1tE2MQl6dSjpydgrrV5PPOozJ3rKafWO6y3hqmO0g6bgUcXzorLFGAmWRxO2+Xmv2VxGFbePm1peIZEtA7kaSVOpL0d7mxx+A5T6GFNjIa+Cbo+a30PnZ9xQdvDVvMqtiCRWRa+vBU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918042; c=relaxed/simple;
	bh=JlxoI49Tas3/+Zubaa46kNb6rA7I8AbxfBvVMi493V0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1eBBuQGZTu1xMHA1oAu0buMqnqjfy5cLzc9k3VT4+On2ocBMb+heOQhrfTJ5lEhzH5LsLB0ASTx8/Gv2sMV82kG735iPx2EGnEC0X54hTlT99nRLKLJ2ix+62oqasn5470Uh8P1QAw0SoOujtVv7c/sG8XhCAvBIUyhBzhoTu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiyvfqzM; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so5657266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 10:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730918037; x=1731522837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVKE9ffo3aYqFVj1Tqb4OUMVtzlo+x3zucLHdg40mrg=;
        b=GiyvfqzMK6n5A+Sd1RfFcxi8W9M+Crxo97GuaoFyy96G14agAtxQHwqBPwyGY9j+SO
         C3NcaAOPtD1pIQEqgLEGdx1ynFz4WsXIUvSpbGmPbGuoKatUajPWdboC54E6WqjN4uwk
         KEr3xqJGxUkjyGm2IaZB40bWRad7Eh7SLYl+TjnDxqRlpz4QblbSYAYWK1XD5okfXNJa
         M0lRIIyYwYuRrYqfVaj8JzaKwTxiXl1fy/RWL+NgdnmuelzgyKJdyyfzS3tB2clsc1RX
         ON3Hy52oZ3zEGFR1jtuMIg4Hk171sbpWqjVHSpjmQ1ZsYBhRCrOrovQH2Q1av84JM8oa
         k9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730918037; x=1731522837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVKE9ffo3aYqFVj1Tqb4OUMVtzlo+x3zucLHdg40mrg=;
        b=wEnmEB9jnAJtLzAJmrhZcLV37p0vSAS+ExrRIKK0mP3AlMKzpu/42ezJ0p+q8Y7nIx
         5G31gKzXKpYprQs8TFb2MmGghIzUjMb5Ysz6iqjQgWMDoz0nsBdnW7bgrpcvYMCd0VF+
         BfMw87NyQea1FHxMmcC3/2A9vzuoajfI7gDaWyjBNWhm+k5xapqa84avVQez97Wct+/u
         o9rqc8TUHV3fe8tVt6R+k23qDUwibSqQ4kWQTjv5Ckb9Ent/ltKKqJI+r/KPf2+Z5xUj
         AiNRSzdpRXz5mutOCO7R8+JIdXgt0ao8wbzgAquHhxvWw4oTRE5VwQgZUDArBOkwThsY
         M7GQ==
X-Forwarded-Encrypted: i=1; AJvYcCV58kW5aGwX6IZrTQ+cRtrEh6DdLqAZT+aAAsQPVXM6mPk6SrSJ4X2IX2jamH9sNx03SjTBfJxlQ7lqYCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcRrxqs0x6MFlWZW5vwi0NX6Hl94dObyGw5PyKaD8t974ETgx/
	dtKZCnRH0YgEgQ+TEUsUDfYnzgwmAf/vfH4LyVMS71JbrwUSCFXZ
X-Google-Smtp-Source: AGHT+IFoZXcQ3XgiKtwcgCf8KuC/fiFBmdTQJb6P/7cb3mAvIJDNRtneFJwAU865d74mvu0LzO5bWQ==
X-Received: by 2002:a17:906:c145:b0:a80:f840:9004 with SMTP id a640c23a62f3a-a9e6553bf86mr2141917866b.12.1730918037171;
        Wed, 06 Nov 2024 10:33:57 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb1813a07sm315298966b.190.2024.11.06.10.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 10:33:56 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 05/16] staging: rtl8723bs: Remove unused function Efuse_PgPacketWrite
Date: Wed,  6 Nov 2024 19:33:34 +0100
Message-ID: <0ef7eee047401f62256970eb3186887202ffe851.1730916582.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730916582.git.philipp.g.hortmann@gmail.com>
References: <cover.1730916582.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused function Efuse_PgPacketWrite.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c    | 11 -----------
 drivers/staging/rtl8723bs/include/rtw_efuse.h |  1 -
 2 files changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index e83daeb9303d..557f87306141 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -311,17 +311,6 @@ u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool bPseudoT
 	return bResult;
 }
 
-int
-Efuse_PgPacketWrite(struct adapter *padapter,
-				u8	offset,
-				u8	word_en,
-				u8	*data,
-				bool		bPseudoTest)
-{
-	return padapter->HalFunc.Efuse_PgPacketWrite(padapter, offset, word_en,
-						     data, bPseudoTest);
-}
-
 /*-----------------------------------------------------------------------------
  * Function:	efuse_WordEnableDataRead
  *
diff --git a/drivers/staging/rtl8723bs/include/rtw_efuse.h b/drivers/staging/rtl8723bs/include/rtw_efuse.h
index de4e5906ceb5..546f32dbd33a 100644
--- a/drivers/staging/rtl8723bs/include/rtw_efuse.h
+++ b/drivers/staging/rtl8723bs/include/rtw_efuse.h
@@ -97,7 +97,6 @@ u8 efuse_OneByteRead(struct adapter *padapter, u16 addr, u8 *data, bool	 bPseudo
 u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool	 bPseudoTest);
 
 void Efuse_PowerSwitch(struct adapter *padapter, u8 bWrite, u8  PwrState);
-int	Efuse_PgPacketWrite(struct adapter *padapter, u8 offset, u8 word_en, u8 *data, bool bPseudoTest);
 void efuse_WordEnableDataRead(u8 word_en, u8 *sourdata, u8 *targetdata);
 u8 Efuse_WordEnableDataWrite(struct adapter *padapter, u16 efuse_addr, u8 word_en, u8 *data, bool bPseudoTest);
 
-- 
2.43.0



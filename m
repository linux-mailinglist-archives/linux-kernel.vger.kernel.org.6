Return-Path: <linux-kernel+bounces-325936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D4A975FEF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842BD1F247F3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15B818A6C1;
	Thu, 12 Sep 2024 04:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSYkQNrL"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7058818BB8B
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 04:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726113886; cv=none; b=VZbI7we/b1/CWgdT04s3JGW6RteGbFDulL2tYE+aIj0pIdYv4035k71MmV9Gn1yH8fQEfdHiuBGsF5O0i+zAIUAM/MxJQDVqMygTwXdJrkpiDUi8GAGCVFl/jjR+7i66h54KmKymljv2gnfiaxxn/7Ve5j8sMeM0sqL7UO0ukXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726113886; c=relaxed/simple;
	bh=eVYB9XOWnNSbAdkz5YFJjpA5UMlyIMpazV/+I3O7IVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bll8U54Nih151Mh9dzZsJQLSLV5r/eMo9dkmKDnzTWR+WHHSYJsusY14TmtYMbDh/Zq3YW7nlHqVY0REaEzQqq12cQ4dKSu+pUUolKPFjoXVZZflJzar9MX8znhr1bwXYYixo49P/IxXnx2wryFXoGgZl6W0+oVUmqx2am6OzYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSYkQNrL; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so334650a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 21:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726113883; x=1726718683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVYB9XOWnNSbAdkz5YFJjpA5UMlyIMpazV/+I3O7IVs=;
        b=kSYkQNrL+pGoxBCKg6Ps+gBKVUZ9RaHvOvb1zYZ/1QRFx7AZ/MkY24U8VwxszM6tKn
         mhzgtYO14YURvW4o1FnHXKKIaCk0NX0scMF+LTQIQExnVO5df885Q/dWRsKNFPyEByMk
         dkNtpzgsY9zsaw+D1y+GM0OK5NYiKnc4P12oS00ioXm/v6dip6i57uVByiiDD5LWYxQ1
         qe/JHawSSjHcbsEKRZw1k05JGhi54aax0Njepl3aDJ4oVuweuhUWW8hq7rRrkrTyqimY
         mAW8iiUBv9I+msu7oeuS1GrdFaT2t2L0KvWbd2QIl2IyRSLuqmmvV83MEIt+Aot58ht3
         W7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726113883; x=1726718683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVYB9XOWnNSbAdkz5YFJjpA5UMlyIMpazV/+I3O7IVs=;
        b=prU0Jbm2g6vLgBXpgr35UbK5nOB8MY7qnh+zoY4hN+cO9tvdnvk3Eg+h58QKfrTExu
         ZzVxfPv3WRK5l424tT2yMxhhkHCji0eDHJ40xI1hiJij1o2Izky/YueJXOjKfVPu7gfW
         shlgRaWhjiNRy+10r8yNbACx1MHnF+bt+P7dLNEnarIQXUKsYp1x490oieP8ZHw67OD8
         qJuwrXS76McVTT1/AaLLmqMIFrCSnsal5bT4eczdFgYKF/s2I80PWA3GeM5rQY48fABb
         vV2+1+fPCg1JiidnKYNzoRXMk/TGDIcLMJ0BqmMe+zYqXQkxfoWVB3HB5gGm5G/RZNj0
         PUzg==
X-Forwarded-Encrypted: i=1; AJvYcCVIySm4KYVs5hKd2pYGlJBZgFEii3yXW9dn8We44mIwH0SOZL3StR4HzjTqW3DGCUFOxkQLejcxL6L3kFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCzGox9qEGyYGMEEHh7VCvQs7aZI9PtdmzbnEq60yDXlay3HYf
	4ZdqwS8dUskbTe9kl+9NiRLvmyS5BAaigWW+p4SMQKYi8dCiIGil
X-Google-Smtp-Source: AGHT+IF/vNoo9iD5Ewq0ziB2Rfx6e5KqaWAS94HQZAeLYOblZT1QjfyIFhZ2VYUaXJP8jczaYEJpYg==
X-Received: by 2002:a05:6a21:164e:b0:1cf:4dc3:a89e with SMTP id adf61e73a8af0-1cf75c7e8a6mr1883766637.9.1726113882629;
        Wed, 11 Sep 2024 21:04:42 -0700 (PDT)
Received: from debian.tail629bbc.ts.net ([2409:40c2:12a7:616d:eca9:534f:4e49:7c41])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fba469fsm768359a12.11.2024.09.11.21.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 21:04:42 -0700 (PDT)
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: linux-staging@lists.linux.dev
Cc: gregkh@linuxfoundation.org,
	guilherme@puida.xyz,
	philipp.g.hortmann@gmail.com,
	linux-kernel@vger.kernel.org,
	Sayyad Abid <sayyad.abid16@gmail.com>
Subject: [PATCH v2 7/8] staging: rtl8723bs: include: Fix trailing */ position in rtw_security.h
Date: Thu, 12 Sep 2024 09:34:08 +0530
Message-Id: <20240912040409.3315067-8-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240912040409.3315067-1-sayyad.abid16@gmail.com>
References: <20240912040409.3315067-1-sayyad.abid16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change enhances readability and conforms to the standard commenting
style in the kernel.

Reported by `checkpatch.pl`:
WARNING: trailing `*/` should be on a separate line.

Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_security.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
index 6124f2ea2431..09ed298782a6 100644
--- a/drivers/staging/rtl8723bs/include/rtw_security.h
+++ b/drivers/staging/rtl8723bs/include/rtw_security.h
@@ -240,7 +240,8 @@ struct mic_data {
 /* ===== start - public domain SHA256 implementation ===== */

 /* This is based on SHA256 implementation in LibTomCrypt that was released into
- * public domain by Tom St Denis. */
+ * public domain by Tom St Denis.
+ */

 int omac1_aes_128(u8 *key, u8 *data, size_t data_len, u8 *mac);
 void rtw_secmicsetkey(struct mic_data *pmicdata, u8 *key);
--
2.39.2



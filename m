Return-Path: <linux-kernel+bounces-367517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD16C9A0350
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E73C288E43
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DE81CC14C;
	Wed, 16 Oct 2024 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="SIazC1oH"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF2818D634
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065414; cv=none; b=a+xEY+cG1UP/Fe0tTD9rzFn8CiSzZdjICW8MteIVJrVK+zhRZLkKUqwSQEO7jWxCSCaogcntpc5l/CzW4mgr0ugdPeIMsmUoqMjwK+hhXO0Nv5ane/MHlCD8ir1b+CJi9wWpKBgqHVNn0K1eiwF9BZggWB0PcUgpaPuZHKO4q4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065414; c=relaxed/simple;
	bh=O+5lJ5Ni7lFZp26xLN1oEhYuSX0s3Lqt4VrhJx8zBsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fYKHaF/AhwXA6iP7mmXzObASL/DdlPUem26xQz4j/9xZ4oZ+CC87/MSHm2eKENhEa2RHSS0sABi+BnVOXykgCK10eVSWMJ8PaKntJN2muSvq6D3zV6Iorgxboq034PaHrLlBkyjgb4PT1fZh/SZ2gv7UveMs9aeLZLTb+Gy1o/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=SIazC1oH; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso2677507b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 00:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729065413; x=1729670213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cY1GwhXrLBAJECK/gKfBurYS+3BKFHmYqoD8mjoZOgA=;
        b=SIazC1oHou4b3Xa+uobeq0XdkLRh4R8Xf168M7x3ygC7cvgZf4H+hjkwhpuYFnmfM4
         jbX3m6y9YtQlBAV3WWvt5vVBnOyyOIxu9SdnpWoqLjPNHpG1tcwOW63253Qsi7RkcO4b
         QWIno+N9WtS0vyaulJ0yEc14C18BElwOs/h6vNosvd7UeXygfeipC8g4UjzL1hY46K6Q
         NqdLPqkovDVrNZjVrNSj0L8/rMElQae5ILUNklYPJb0Zp3QKw7nFOCnPSeX21P93IKvO
         RpnvqDMig7tlJ0vFmqZz5JX+W6QXEBJsURn0nTewKHoQ7X3tVUrK7T2UcpuUtGbfOM9a
         kA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729065413; x=1729670213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cY1GwhXrLBAJECK/gKfBurYS+3BKFHmYqoD8mjoZOgA=;
        b=op9lEir4FRI3e50nM8pyI9cQH6tCAjJvuvYvBecX+mHNxNCnI2bGjRPfE2vr9NGFLN
         jbqKjmURnsEe31kpuB22vNxQDYVktQ5EqvUSWsJFuSDqtosVfPxSqlTCNAiX0NTsPaYa
         1W5X1yikNsrpvsnNVrKwkoInnaEzIeuWub6C/eSISll8S15+L1d4jw/dr6Yl5JpF4x7Z
         TWGl3gFSnDZXI9R+0htAhO/WSERrRd/mnyFvHNXKlky+g9FqfNWTBTzC8w/nPr5Tqms4
         9zrCVFsnCCclCQr/Nit82H//HvpCgx7bEVhtGbbxsZ4xzd0mlfDmyipfZsHzc8A+3PJd
         ICIA==
X-Forwarded-Encrypted: i=1; AJvYcCXjdqVHUF6hnRRtQMv702pRqwfyFTT/dy6OXxJw3dJ488XoP9Yx3d2K+x2MKxWvEcXBkJxpP9ZxYMPr3jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKc+YDwoGTtkw7Z5lUC2hhs0Wz3n2IHavohqGZg8ghrODT8/jk
	N2Lrn6k/dubZPH7UbFfu6TxM0Tcx4E3rM/bx0/ARy6ddd/2p/naqMDCIO8dHbGc=
X-Google-Smtp-Source: AGHT+IEdKtSTNNT7pPj/NNmW0H3kFE87LSlsdU5aTzKc2Bifh4Ju1KicfbqlfaUrAdSDAmYFllUY7g==
X-Received: by 2002:a05:6a00:2da4:b0:71e:4c86:659a with SMTP id d2e1a72fcca58-71e7da48723mr5210472b3a.9.1729065412526;
        Wed, 16 Oct 2024 00:56:52 -0700 (PDT)
Received: from localhost.localdomain ([132.178.238.27])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71e77371708sm2522972b3a.32.2024.10.16.00.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 00:56:52 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: dpenkler@gmail.com,
	gregkh@linuxfoundation.org
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] staging: gpib: Remove unused value
Date: Wed, 16 Oct 2024 01:55:43 -0600
Message-ID: <20241016075544.4125-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable `complement_count` is assigned a value which is again
overwritten in the next statement.
Fix this by removing the first value assigning statement

This issue was reported by Coverity Scan.
Report:
CID 1600790: (#1 of 1): Unused value (UNUSED_VALUE)
assigned_value: Assigning value from length to complement_count here,
but that stored value is overwritten before it can be used.

Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
V1 -> V2: - Removed Fixes tag

 drivers/staging/gpib/ni_usb/ni_usb_gpib.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
index 1da263676f2a..e19e18892468 100644
--- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
@@ -759,7 +759,6 @@ static int ni_usb_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 	if (!out_data)
 		return -ENOMEM;
 	out_data[i++] = 0x0d;
-	complement_count = length;
 	complement_count = length - 1;
 	complement_count = ~complement_count;
 	out_data[i++] = complement_count & 0xff;
-- 
2.43.0



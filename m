Return-Path: <linux-kernel+bounces-543435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1582A4D587
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75435188EF59
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B90A1F8BC9;
	Tue,  4 Mar 2025 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="lEnuHSOs"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D141BF37
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075170; cv=none; b=SVbaa+yl+kfR0S2OqV0KdxxayenXIc2tW2DsViVNq565II8hLdMSBbYpftz6kIOPKXgYT1UdHBDRqjoXSperYcI9ShcktpHyRBjwb8Th7GNVaVkGu0zM1iLbG5dxbZ75meEcy6+zBHCg0SpEUGrk7ka0CG9NHbNQggmCupRzF1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075170; c=relaxed/simple;
	bh=UhYnxzjwvRCTrXKHXhPQKkRSpGC3j82Xs/9pK8fLlOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKGjF/cenOLKr0DsLshbETbMUbXK0d8Xo4KkfvKiA7e9skE3XqyXGX8bp0D3BDoJ2/4ePvmC+sTs0WfE3Me5lJ3PJ8iUiaqZvKH9upaX4qSRiZyDslSFhjk8KiDwuH0fyzUviYU5+lhPjiE4JKlW/7LunKEcCsjm2gOFPAovjTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu; spf=none smtp.mailfrom=kragniz.eu; dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b=lEnuHSOs; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kragniz.eu
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f2f391864so2906068f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 23:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google; t=1741075166; x=1741679966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQryvvyI2Rb/9+Iiv+kqTvYILdOjn2TN/fO7bcat3VI=;
        b=lEnuHSOsrwNoploszlmBUmVrERWyGOHtmO5EsvVN0zgq0qeRxJj2nAyhEizVsEW9vg
         yFCSDIlOw3d1CJjeLABy7Ur5RacVyaxhH2a9rgO7P9ar9RahSfwYGEoXoQe0G62qOpex
         fTju/UDnVlweVB4c6WM1YDgsGi1cQ2k3ggRfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741075166; x=1741679966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQryvvyI2Rb/9+Iiv+kqTvYILdOjn2TN/fO7bcat3VI=;
        b=gFISdx2qI5MXWKNU+i2kUzT9PV+5gX7u1JrPH9Dju/CyWLZbzth9wy86UlBThwf+bT
         iGdTvJO7ydFVbKKMMYg8xU4HvVJsq12+b7cfdlglMbfyE7H2qh5d2DbZ8WwDpvdyn7q3
         rWSicnLV3q9PVFuBW0fVdcApsFLUlw2aVjFTFAUHYemyIGYoOCpZLtT6MSIf5fZYdDlr
         Akqp93G59eYxj5moQy/EmExrX53bY7lzO2VR7aiof59HnwGryJ+htBR9rN3d/EqhxlQA
         Uo53xn6ROb6PyuALOudj5bzwxBm3wc1MYEmQ613HrMrgrXronlTz8Up9Pfc9jEyfsZtN
         3p+g==
X-Forwarded-Encrypted: i=1; AJvYcCXuTiuNq54Zunz7qDZ5a5PmqnVp3ZjWgIMipv2IAAeQE8ish51EzdDh2Xs5Q9LGtR37FHLZixp1JVdwk/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ8Eqp0hk4YWrJj93BUFr8tiG2By1WB/FsnYih82oL3GHmKTqi
	kMHjBCP7hDJxIKcPqqAwmKssnmW9G+PIpu2QdZiZhtMbaEJBtQ3YDlBVK0TYze0=
X-Gm-Gg: ASbGncsopM0usYH4Ioo6n2c8a3meoiS05R1JlMqaKcsGsCNA2gDTWzt7AdylcQWhCfr
	wI2Jf9ZkB4cfTLTkEvY2kuc8zuOETBIZjiRuo+eo/Gcs5JCOLwiRtlMMQtPkPiRgryi3nqo0pCw
	WQkmawSxee6sWThmFxOQG1dPHbc5V9yvASRrRFbs/1H/9lQ9LWvwqAhKQDnpLVvHejyKDyLZMGM
	UNV/yjDBC2Fc48JvWIiOfzfmjhsZWmavHeKapoxWC/oihsh/ewxr+Vj4wKh1vP43n5duWhxQaRF
	N/VRn/qQW+7HJaw26Y/9U2cE1XfwmqrNt3wef7AereKddlKAIodOw/MZ8zx/53lRPqQVaiJgJZg
	LJ/tIMA==
X-Google-Smtp-Source: AGHT+IF0HwvccvNiGHPF5xqB1vj8kOiU4HSZjDPSXE/JBr0igt1FUNYzeb5j7raRFD5j3xoDF2GMVA==
X-Received: by 2002:a05:6000:1545:b0:390:fe8b:f43f with SMTP id ffacd0b85a97d-390fe8bf590mr6944830f8f.42.1741075166645;
        Mon, 03 Mar 2025 23:59:26 -0800 (PST)
Received: from localhost.localdomain (161.26.169.217.in-addr.arpa. [217.169.26.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4796517sm16618101f8f.5.2025.03.03.23.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 23:59:26 -0800 (PST)
From: Louis Taylor <louis@kragniz.eu>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Louis Taylor <louis@kragniz.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] tools/nolibc: process open() vararg as mode_t
Date: Tue,  4 Mar 2025 07:58:17 +0000
Message-ID: <20250304075846.66563-3-louis@kragniz.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250304075846.66563-1-louis@kragniz.eu>
References: <20250304075846.66563-1-louis@kragniz.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

openat() uses mode_t for this, so also update open() to be consistent.

Signed-off-by: Louis Taylor <louis@kragniz.eu>
---
 tools/include/nolibc/sys.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index a8dca5ac6542..5d8adc778575 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -810,7 +810,7 @@ int open(const char *path, int flags, ...)
 		va_list args;
 
 		va_start(args, flags);
-		mode = va_arg(args, int);
+		mode = va_arg(args, mode_t);
 		va_end(args);
 	}
 
-- 
2.45.2



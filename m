Return-Path: <linux-kernel+bounces-366618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EF699F7DC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77FB91F21FEE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A216C1F76B4;
	Tue, 15 Oct 2024 20:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="ypIcyVTx"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3321CB9E2
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729022895; cv=none; b=lQ70IJHDwtM5avGNyWCPcvrQPSX4zkE2ioZVXPoy/coBgQe1eQpa8de7rUt/gv4VOfTGnbLD2v/iHdcUWUlOP8BDIOMGiUSvvyyEa+bWC7T4wNemLs7nTy9wT4AoemJqOPdYlRT7pZn9zTzRBzlkikALAUBwzYpqxDe0yi6ekTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729022895; c=relaxed/simple;
	bh=lcjxFfK9x7TEO3MuO7OThKx6V5XEevvEBNkBmc5yX3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TIAZy2N4txjrsPs+ik7Ydpb6Q7Y8TUPbsbyNFCw6oUL/pGhiplb09cbA2draolmlkpeEoB9ALNzNn6Sth7QtjpmucqxCOic6mtQSsddQc0ljsvo0V4ymnMIrzHCvcFo5+YPzqfZU1KrEdVcTsKPQL4E6NnBvjh+Ge4lW3KpKxI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=ypIcyVTx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c7edf2872so1570935ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 13:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729022892; x=1729627692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4OYafRWJBDNDlerw9Bp0TVpkeaRmGTgXMU5o+kqNXA4=;
        b=ypIcyVTxMzH8lXjXHcf/sHgPpGE+jY8yg4GUsMC4rlm3GHUf/ElySr6ilgd8x5QRHg
         odj4MVBvxiX6ZvQHx1h33y35bj/nFt8WKTYe78MBcQ7f4CjTCYwF8/cz8++RoyIRoL/m
         pmn0JrJdvSlhhpo1UQAmF6jKuoJT9OFuqAQTdEoyrLL/iFCZ0Y6v/AVctrFxk5Qh2Smb
         Nq3yVk2LQAm+Md+EMkoDEt53OMPCARKnfJ9OTP3k1lMTSHUg9XpfqMezAkQrvB+EnWiX
         Z9BnytC3JTQFv5tPJ9ghUAsDKz7i/F8DLs7b5ZFdWe1qPReL4jijSCQmZFPk7fHqM4TM
         K5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729022892; x=1729627692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4OYafRWJBDNDlerw9Bp0TVpkeaRmGTgXMU5o+kqNXA4=;
        b=izdvUUkGkaIS/QPWaK6WhYFZyZTVLTeDj6SPuJgB/sE32H1QFxuEx6/+cVmu58GoN5
         I5lPoxe9+J7oXQD/7IF4M4FZ+FF+C0lPcbB1PZrDrWdzEuWhh3QWhHEZ+X4BIjBj7qg2
         Tfuz8IOcPe//WvOahzNH9oTcCqqbF/KLQPiBwR3URCHcgFcpsb2OSOd1DlASiNVf+BfT
         Fzm+ThV/RNtiFtJDyBCyMlUJk6/Tlggfm+k7obqUoVnukmHXOvELzmxTv6/E83oVY1al
         zoP790Ll2F3totDQeiEDeHPUUET80SGLRmSK7FRwPifzCs2nC6STE8zFqGhsprAYKFVz
         bEcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/k8vV17ixsqWGPK98VIjKZpRgOdrSgCIZC2hiSrUwtn3uh6ORg9ZQDSk1NZfnzm9/5q9ONn9Qhlfmgkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YySz/10/CpPKmDO+VhcRres5DYxiZKsl6c8ekNP0rpuJX/CBUZ3
	+xACH3l5C4EghSUPfKhv4uNnfY1AU80mMwP6GwVB4MYA+4XsYwEoTt68e1PneBU=
X-Google-Smtp-Source: AGHT+IGPwub86v3SfluDcfN06wwLN9PL4+BcDBaaARe4qa8pfg7TiFdoeIbN6d9voDA/VPRC2aJJMA==
X-Received: by 2002:a17:902:e1c3:b0:207:1845:bc48 with SMTP id d9443c01a7336-20ca0426cb0mr178146065ad.30.1729022892036;
        Tue, 15 Oct 2024 13:08:12 -0700 (PDT)
Received: from localhost.localdomain ([81.17.122.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20d1806c72asm15852375ad.305.2024.10.15.13.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 13:08:11 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: dpenkler@gmail.com,
	gregkh@linuxfoundation.org
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: gpib: Remove a dead condition in if statement
Date: Tue, 15 Oct 2024 14:06:47 -0600
Message-ID: <20241015200655.17444-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable `residue` is an unsigned int, also the function
`fluke_get_dma_residue` returns an unsigned int. The value of
an unsigned int can only be 0 at minimum.
The less-than-zero comparision can never be true.
Fix it by removing the dead condition in the if statement.

This issue was reported by Coverity Scan.
Report:
CID 1600782: (#1 of 1): Macro compares unsigned to 0 (NO_EFFECT)
unsigned_compare: This less-than-zero comparison of an unsigned value
is never true. residue < 0U.

Fixes: 55936779f496 ("staging: gpib: Add Fluke cda based cards GPIB driver")
Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
 drivers/staging/gpib/eastwood/fluke_gpib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/eastwood/fluke_gpib.c b/drivers/staging/gpib/eastwood/fluke_gpib.c
index f9f149db222d..51b4f9891a34 100644
--- a/drivers/staging/gpib/eastwood/fluke_gpib.c
+++ b/drivers/staging/gpib/eastwood/fluke_gpib.c
@@ -644,7 +644,7 @@ static int fluke_dma_read(gpib_board_t *board, uint8_t *buffer,
 	 */
 	usleep_range(10, 15);
 	residue = fluke_get_dma_residue(e_priv->dma_channel, dma_cookie);
-	if (WARN_ON_ONCE(residue > length || residue < 0))
+	if (WARN_ON_ONCE(residue > length))
 		return -EFAULT;
 	*bytes_read += length - residue;
 	dmaengine_terminate_all(e_priv->dma_channel);
-- 
2.43.0



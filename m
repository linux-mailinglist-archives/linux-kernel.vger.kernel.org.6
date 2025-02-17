Return-Path: <linux-kernel+bounces-517392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BFEA38034
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647A83AB5EE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E340217707;
	Mon, 17 Feb 2025 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vl5sl5JN"
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D6C101FF
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788268; cv=none; b=fHJu+LIFM4B/pvU9zL4S9K3iMGmw7gXtSXokv23wDsHpagQPXLj2sAJb5m9i0UqOy55XJjiB9rIzQA7AmDmMul2BIr9nQNJffzH98K3S33gepFVpgOh4XEHZN0cx9fstODvXH+ETksa4q8090iOVdMo3t3ePpaVtE7ETnKcqK4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788268; c=relaxed/simple;
	bh=Gazg7ITlPyeapShlUJWzCmzJ5JDneJIfQIfGTf7Y54c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LaOBDWb/JazSD+kX59i+WMTnWpsmmH2EN0Jhrks8Y2LEuvHMx0VLj6HNKyX8ZMFRd229GrM8n9qHqxvUfW83psddkAbQXnCcDKCluh50TgNJwcsqR9uybaEQ9pMbJ8vBo31SjaI1s/AxPbPYvJdfUBGTFRstvH1El9cI7hscigg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vl5sl5JN; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2fbf5c2f72dso6384569a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739788266; x=1740393066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydQlzBFDch5dE0pXTfWbgAH++noP+kxMcP8vl7mV8uY=;
        b=Vl5sl5JN1glPxn+PdaerernFNGuhzAJuTKAK1kilnIVyUu1ipaLE9DIP0MXoH8upAz
         +RpHa0nJ7a07e/KFtjc9eeEAz5huXTTUgMVH0Ir6SU4+6KnAAXpMElGF0is4lfmwTrOK
         RIM0UaVMmvc/5/2N806VhMAKDHBzjjvPHwblTSJb7RGW0Uk+EE29qc0zZ+ulatdbdKBr
         K/XaqcBkZiZ6Q8H9sQrl+ZYIL8nZtNsRwfiV/qoocZUJs6BTjhTvLq5PK9KEBdSJoNpp
         fbdp1q3CzFTSlXSzN5MuowlLulDp8cH3p4F+F0MwBWFbgs/yG0fomf1oMe5WqcwsQzgi
         XFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739788266; x=1740393066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydQlzBFDch5dE0pXTfWbgAH++noP+kxMcP8vl7mV8uY=;
        b=ouU8eGffHRLSIfAm35cLTJK0y18CJ2lyJMyfRWReV9K+LyAiFz/KKoUKnSgtNbfM/k
         m9t7d+ozKy8K1HOed3Cqd6a/v7l3r0lioj/ixgiFvC2HXQvVTYWHDsm8Y4P1T23K7i+6
         gVvhFMxGFZtj6fTbzQO9j0HjQ9RC4TrqjJ7oSXLGKysDnugsFrWsdZe7Pwz284B7pYRm
         4XOC5gChTIR1wf7EztWWtbUxOKGq3JN7jMXI3uZm6Q2YXsDSeNOVdBjg1QPfxz9gLPQ/
         M5NnCuZB99GMCl9wvjt7/hNml/Fyyw2BoZL+nSpx8lZBQ3aVTWLM2uKYmSnEkOcEh5yk
         5SBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZF1RWMNr8oYsX/8VRQ89SX2+bdu6GPZS3p6qpHlBieYcTjWqm+bieStFFD2v0FEwXEvSRC9bsFT8WFFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwANLk2SBcRSGfHqrxBc1AdiD6GHSBkLObt5y9oGn+CMjrBjjn0
	tpCklmEVPi2p7DhgcbTjwxmnI25psj1s4s3zB0s6cyZGl2emMvWJiCEsAAOOfvw=
X-Gm-Gg: ASbGncsxH9HwrHWrZPOpuyMqk0bfsjFWSfSkNCqCnop/bH1vn8pIhm0IixSrf2tWEih
	J3sCB+9Er3CC1mKPqzpVU97AlrKi/8pvJA17vtARk/amkyIbKWXao92GWJjz84iXKhTOIsF8ds4
	t1NWre46Gj8tQYylFyfEs2GKbLwdoSvJBagR8zjPxqG7GkX6EWoLaBGPKmk/ypzpyylj9zcw7qP
	6xRGuHN9/tlYcTS0Z2udwSzmYUJVLUPE6Z6ryvfLf3perAySKYVTkBXxh6KWa8XyvqJQ666dcmL
	tArRdW3Q1oo0QbPwqX+a
X-Google-Smtp-Source: AGHT+IGriBuKKjdznmnIm3vXi8JBeA0sHMkbwBHu5PAMvpDBCNnAb8WFgeAwduFt/lnR9MKJSCHrig==
X-Received: by 2002:a17:90b:4f46:b0:2fa:f8d:65e7 with SMTP id 98e67ed59e1d1-2fc40d1318cmr14500264a91.2.1739788266326;
        Mon, 17 Feb 2025 02:31:06 -0800 (PST)
Received: from localhost ([2409:4066:d04:319e:1d76:db25:b6bf:4f52])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fc3281939asm3807378a91.0.2025.02.17.02.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:31:06 -0800 (PST)
From: Ravi Kumar kairi <kumarkairiravi@gmail.com>
To: dpenkler@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	dan.carpenter@linaro.org,
	rmk+kernel@armlinux.org.uk,
	Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Subject: [PATCH v3 1/4] [PATCH V2 1/4] staging:gpib:agilent_82350b: Fixed spelling error
Date: Mon, 17 Feb 2025 16:00:35 +0530
Message-ID: <20250217103046.54294-2-kumarkairiravi@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217103046.54294-1-kumarkairiravi@gmail.com>
References: <20250217103046.54294-1-kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>

fixed havn't -> haven't

Signed-off-by: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
---
 drivers/staging/gpib/agilent_82350b/agilent_82350b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
index 5c62ec24fc..5a74a22015 100644
--- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
+++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
@@ -121,7 +121,7 @@ static int agilent_82350b_accel_read(gpib_board_t *board, uint8_t *buffer, size_
 	writeb(DIRECTION_GPIB_TO_HOST, a_priv->gpib_base + SRAM_ACCESS_CONTROL_REG);
 	if (retval < 0)
 		return retval;
-	// read last bytes if we havn't received an END yet
+	// read last bytes if we haven't received an END yet
 	if (*end == 0) {
 		size_t num_bytes;
 		// try to make sure we holdoff after last byte read
-- 
2.48.1



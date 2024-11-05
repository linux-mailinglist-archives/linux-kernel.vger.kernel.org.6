Return-Path: <linux-kernel+bounces-396724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE0B9BD140
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63372282BDD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5273F166307;
	Tue,  5 Nov 2024 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfskLUUI"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4601814F119
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822299; cv=none; b=S1RpPD611acnncV4qZASouj0aQz5Rv+aFEeRYxLCeyXEq2hZgDUW3+zWTpJFob2IMki6XfCu1uApclF5cG8Bxk3DQXQ1Khbushd4dTSmMhlqGVDotcFMo207VPRsKFwaUUIIRY83MvH76ZYI+AyY+Lbl5tFD2nyONc1SUZiKRuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822299; c=relaxed/simple;
	bh=nP9SVYW0NtDtu5qNRV/8v5xBanCZdOryFj5rjlAsb9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcTl7MXUeU55+sqaE8wBdOLDwDOBxve88WDYH6XJwMx2ghKGCWH0UzZI7dIfImnzauGfuhFUaA8ch42YF6PqHyWkDNUR0/DXpEJ9rgBz+pGeAi3wzi+juh/lGc/WMAVosSZROnbf0UmwvQ2kzY9HB4uteE70P5lrI7arJ42d67M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfskLUUI; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4609e784352so37314821cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 07:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730822297; x=1731427097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/hvGge5OPILp7dIoYZGxsO1XwDNo9kO5R1IfIXXoTU=;
        b=FfskLUUItcaT40DHNquEirn9+p8rSL0CguDRLzlCz41h9aLVqHBWMjeaJHZ5HTljod
         lQOWzl1YDsnB/2CsqWUsN3Q1+HLkKsyCynUtbUz6mJZm3eAwy5AVWF6h7TQmS2TC7sr/
         fdQZ7BHPpESRgz1SpbMq4Us9APk9V3e3JNC6OaEOxj9Xq+N+ZitmHUV+1WBRo4UIBwDe
         ZQzrpOodj2y8eGGw253WHG2VhMr5oXrhpR2mCnVfPMmdOaqVWjHftvO2vUOxivY5QtrC
         QcRDp9oLdLt72tRIn1SOxlcbH+RIlAQXQX0crtOh7BnF6+EELGEi3eSwBFhN1z0t5EkH
         9JpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730822297; x=1731427097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/hvGge5OPILp7dIoYZGxsO1XwDNo9kO5R1IfIXXoTU=;
        b=kNqZDVfxUB9Zlf6qJfcsdgUDzxpZyEkZ0F3pc/V4wIuRrCt9FY/kcsHAgSjnwTIYGo
         LgRoiLIAhKXjL6SB2UBLbb1SwAJBvDFGJgABhGNck6nIPSA8r3MfoyInth32YaGkfQYF
         QLNMC5u/VwIveDC8bymMh9oFGHXhXRt8zqrPBXrxYf+dugql4vxB/dpsHmDFyRgEN+mm
         L7PXZPXUlNPbKSJYk11o0Lt48nBHMrp9M10uwHyzbBjegJ2oARzpTVgtxBrGtdbMSAcy
         U7c1EZaVtEcP9ikrzjiWhDoZM8ntXrJXNIqhX5DYjWyfHf8AomtwamGi8AR4xl3Fbst5
         mM5g==
X-Gm-Message-State: AOJu0Yym9tIaWZbKSHvZyIKQ2jntqKaNmsOywNnKmUmlhnsoXFJ+LndE
	G1sBEVfyFpbkgm4D60ieJdLXVlWZ32sq5l3QYpQSu78tQNOZ586H/M6I
X-Google-Smtp-Source: AGHT+IHAPdNsJ8C7rDc1dYEzNisX4utZGpvZ7jBDP6hK3rp1fAs7G78ZOROC4o+3PHcwAZeCmvbpUg==
X-Received: by 2002:a05:6214:3bc9:b0:6cd:eeb4:4f73 with SMTP id 6a1803df08f44-6d345fc8799mr338538626d6.14.1730822296890;
        Tue, 05 Nov 2024 07:58:16 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fc6d07sm61710586d6.44.2024.11.05.07.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:58:16 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v5 02/16] x86: Raise minimum GCC version to 8.1
Date: Tue,  5 Nov 2024 10:57:47 -0500
Message-ID: <20241105155801.1779119-3-brgerst@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105155801.1779119-1-brgerst@gmail.com>
References: <20241105155801.1779119-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stack protector support on 64-bit currently requires that the percpu
section is linked at absolute address 0 because older compilers fixed
the location of the canary value relative to the GS segment base.
GCC 8.1 introduced options to change where the canary value is located,
allowing it to be configured as a standard percpu variable.  This has
already been done for 32-bit.  Doing the same for 64-bit will enable
removing the code needed to suport zero-based percpu.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 scripts/min-tool-version.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index 91c91201212c..06c4e410ecab 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -19,6 +19,8 @@ binutils)
 gcc)
 	if [ "$ARCH" = parisc64 ]; then
 		echo 12.0.0
+	elif [ "$SRCARCH" = x86 ]; then
+		echo 8.1.0
 	else
 		echo 5.1.0
 	fi
-- 
2.47.0



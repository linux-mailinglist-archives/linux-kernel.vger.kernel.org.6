Return-Path: <linux-kernel+bounces-433114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFF89E5403
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FBC41882AED
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252EC1F471E;
	Thu,  5 Dec 2024 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+mNrPIg"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8DC1DA0E3;
	Thu,  5 Dec 2024 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398374; cv=none; b=XIijtTEQI3iZ3o3sBiIljA4EAPmYQP/E9NkUBcY+fxxOhcLct5Nnktzed+b0BUY1ggqxT/IWYwuezbGowMYMYB12bdzs0w7Ay5WQ+pnempyRTPI5b1hLRPXF7+mzt4ppsDlob1+8DRaH7pFrpS9egA+yin/am0cbrLVMlQuayrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398374; c=relaxed/simple;
	bh=qd4trRUQfQkxS8oc3Uy3RwMq56m56afdLOQIDKV643o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HIkizHSjDD0TG22MaZqI9U9M3AgmVLwR47UBc4ohFApa4KCOpLhA7vkD2OhfrRTNDGpd+02GF8VEHGjE4dOVQgcb8Ftls7RWJ/uZPiiF9ez1h4xwVNaG7TOyx9i+2SeKqws0lfLJTIDLscDwSYc9Ik08U52sDPXpAQCDVAHTc8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+mNrPIg; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53de7321675so981003e87.2;
        Thu, 05 Dec 2024 03:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733398370; x=1734003170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vhWWNL//qRNhtly2gq08UnOc6Yd7Jys95X1y4ntnJ6o=;
        b=G+mNrPIgH38LcGOBLS1nb6RYOXfZPdINuiCDmAeBILsLV6YNMhwAepY3VwYcfwpGL2
         l1LWukWTbARHmryM/tZeqbXf53mOU5eDZ7LtsgFOsv8qy8jEUQNEVaDmOZ+QwlzALc2Q
         jaZaFHVnS1/qNMvKxEHZPMTuyxfm6sRWN5PiT7ZS6fOMGloAK5gfuqXnShwfJwfnQ3+P
         +MA/ODUq4wVWuAlaSItK4DjbtW/k5kGMSAcGLss1f1x9fiMktJia21TasofkM79YwFix
         fHXo16Kay+hqCTmhahhTkX2amqkce5XNIjcVqkuuY3JgNSXjGPu9idp6r6Z4ZaJCYduO
         fSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733398370; x=1734003170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhWWNL//qRNhtly2gq08UnOc6Yd7Jys95X1y4ntnJ6o=;
        b=QBeaT6YuSbVz/ibaFoust35+0DVwgtjiTlvG4ukBp9NdgWeWpN1nLWJNG/aRJzNknC
         AJM13OVau6U3Ozbl1vhIClVBl5o+to85HbnQo1ju3PDF1+9NZ9ymyvK4nK1ig5mgN5XE
         P7c5eRd5dhO1s2wmKGH7geG3wW2LCP4A3bfz4Tqd+GqZnDrwAL6QBAVTigTg6GUGRY6U
         LA0DyCGyUUwhpGVYJ1GZY76HejAkKMYJCTyeRap42NZF8QDo/pfVsuPn8md2Km0VkvT5
         Jd32Q9ywcsCEmFrLmqgmg/S84Um8lfLEtPj5kCJ2tPyBCz15S9g3sD/mmUM2fUhAL0nb
         NciQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwGBZsyJNd4kskYDBUF6NU2DVOSZj82+VzqyABer3r9CxZRmWRrrUbdX/xlJMT/+dAQBueS4OIihfTEONY+Os=@vger.kernel.org, AJvYcCXYmw9da8OisqdldddtjVSFsa+W9J1RKraWerHih84rkya41oArarJz8hmbCtMTnVngeV9xydCJV9kiGIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoHaVxinn44rF00L6pziZIcMzssenvmb/pJoPdqS4rBIXZ+8qB
	xxUpyRSZ4SCpmRue7rDBBpefLaQfPcX+QBmdsZX9S1otV/ok5+CK
X-Gm-Gg: ASbGncv414UG67yyKc4Qy04rmLTINXWeAx2Wjrqj3pHfPw0OhVOTSU1clV6MG22cYGR
	h4iqCyBdn4ADMRyonm5Sd4IT12FP1HYaUoCRl5j2nfGQlfIdPYSPwUrkcyH/aOHDfKKIvf0GdqD
	lLnt8nZ869F9IjYsV2v8sJurafbbNfCEVQyzPGIoW0agRCpa1YbNVWiid4R6WEicTNh0Juaq1UC
	ba/cFGZ+zF8HsrsnXMgGRi7cpY8iBdMN/70ijB66JMg8MN3P8xMJcPCkt8ZcO/sc1VtAQJ+kqsL
	W/mXcgaMJZWkme2wK4M4
X-Google-Smtp-Source: AGHT+IGus/e6ZmL7m3QokmKtG/m+9qimhmVc1Ry4PhTBzywCCtWZxD9qMbm6G7bczIlHASdug9tBfA==
X-Received: by 2002:a05:6512:10ce:b0:53e:21b9:e7ad with SMTP id 2adb3069b0e04-53e21b9e868mr1461214e87.4.1733398369493;
        Thu, 05 Dec 2024 03:32:49 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229744e3sm216136e87.66.2024.12.05.03.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 03:32:48 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: daniel.almeida@collabora.com
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	rust-for-linux@vger.kernel.org (open list:RUST),
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v6 1/2] rust: error: Add EOVERFLOW
Date: Thu,  5 Dec 2024 13:32:16 +0200
Message-ID: <20241205113234.2021442-1-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trivial addition for missing EOVERFLOW error. This is used by a
subsequent patch that might require returning EOVERFLOW as a result
of `checked_mul`.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/error.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 52c502432447..cd57fac7f1f9 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -63,6 +63,7 @@ macro_rules! declare_err {
     declare_err!(EPIPE, "Broken pipe.");
     declare_err!(EDOM, "Math argument out of domain of func.");
     declare_err!(ERANGE, "Math result not representable.");
+    declare_err!(EOVERFLOW, "Value too large for defined data type.");
     declare_err!(ERESTARTSYS, "Restart the system call.");
     declare_err!(ERESTARTNOINTR, "System call was interrupted by a signal and will be restarted.");
     declare_err!(ERESTARTNOHAND, "Restart if no handler.");

base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
-- 
2.43.0



Return-Path: <linux-kernel+bounces-556634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AC2A5CCB0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B8F17AB01
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93018262D18;
	Tue, 11 Mar 2025 17:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhClNBFX"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54833111A8;
	Tue, 11 Mar 2025 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715389; cv=none; b=P4vcRWTS0h/GnGZEbAMIIiTQlkif0YpXY2gXmOBgSKg/3NFvY+Gsl45csPB9sA/lYmVz+Hu3DWfD9u4bQNgA8g/2WrNLSDjML4Osdi5KWcAOfE5lGjRFOSt6uoIfCWzOv/1+mrRSO+fQqWnGpKlbWioVij9tXtF4MAlkef3VZYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715389; c=relaxed/simple;
	bh=7EWHV9dXU2kG/xafKevv9SzG5SSqBdCFZI3L654ZQDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rk7q3fVWAoPUVtubncbOHDzvpYJZfhmMKg05vgF1ZRN/oHFFZZX7GpUWSWc8+h80cD/mt6W58vi1Ylcmw4Yvc8itPV4PuSr7wwAXmHOsV/qRNnFNhPkq5/KYxrfggs2iE0xEPsvHcriOSvaL/j2i9Wf/yyofisoqfnQUW4iT/M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhClNBFX; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5499c8fa0f3so3189164e87.2;
        Tue, 11 Mar 2025 10:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741715385; x=1742320185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QE3/EOD24kfqjSTHkaz9KRGvlEanB1hF966k3hECCPg=;
        b=YhClNBFXoj9LxAf75aF2V/d209xe8t1tVpFbie0f7O06igjMFSZ/oL/lbs9DHI5JmW
         qDEtDj5dvWbThULToPmYG5YaZcGHTOvR74Bok198f45BM6BWJT4MHSlVfgJCRRTcFHL2
         PmWLDehTu8KKa/IU0H1QUWyByn/sWCYK44kpEm96IP+7iZ0xtlUNfibU4r8YCDlb+y0S
         voUlfz7/MI2hSaWRFT1GoT4B7rjn/L87CmSZZmc6g/WSwTsnb30PFnchl4WITgwQIin8
         VO18YeS/j7V9vav6uY51c4m9LdL/k7HopBXeREt8HgbzXrnBFZHjyI23BgSUUqD1GSul
         iRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715385; x=1742320185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QE3/EOD24kfqjSTHkaz9KRGvlEanB1hF966k3hECCPg=;
        b=dsrmyyBiJ9PiuABNTJ0eAFqBrvSJOXDfM39gOiRLfkb9BjS6Q5+OmZIVYlvh/dtVXm
         E0t6cFpRUjXx19Fn25OQWwi0Y/1/gcG6lZ7b3xcf5G181ClivGHL1IJmJnxuf1lvIHXS
         0nedcC76ymE27Um+B8ZtgCn9K5VPFXaPG8SjtmV5HqMO7su5O57vvqrSWWGvC/YbcEc6
         aCxTZ5esy+XQursFqGNjlEkBq69ykIS28+SrtpZvFxJxD86jx0H0GPMMybYfdWj1KIn/
         woMS5RNh3gEJ/tlVCDni0fD0i/2sUbdzfK4Hiah+7n+3XnCedcdUBnta8go06ksjCOCt
         Wz5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwRLG37bGI5MzaRZ0NUEX6MXbRpMZG/XL+Kw9VY1f6K5w+tmBKJMVbavtlVdTfH27ibLqM5MO5cifFiKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQZP4ESL34aNjHxZ03Z90G3PQDvHne/+I4GlyZH8exhn8KxeK2
	wZ52+0fg6ERs/bax/R7RZn2bF9+EGotwoTDFMhMVrhMp/flFeQLV6mxW/w==
X-Gm-Gg: ASbGncs6xni2OBVYBgyT/TRCKuPQgX/+CaB/E67mkegHyEgSq3+xIxFKrBaLUf/bSAB
	HuOsCJr1J4AJ8x2Kf+gi/O9Hqz3oZiyIWLYw+uNyLJAKsRZFjrgBjj2lZovdkwtkUzeX1NEHOBo
	gW5NvvWcy0VI/Ly3mgBO3AL0ApDDtUaCdwcaduyjOU1w79J2U881R5ToCYJUB00cGvRuc54dUoQ
	QeBy5FtVqEwEUOsY8Fi9EHyIgji00wMwlzKJkqGjNDKPH9Gfa65792ZGw7CJW66y32wU9vS0NAp
	mBL75EmjQ5EkfwtLgu5LcnijIivFocJrP47DZu1nVO7Q3OST0j3gyk6PcfTvBKCOcIKGUcRwRTj
	PRKW3cCyY0lvsoyuVlzFIg2ZAMbR7LcIq
X-Google-Smtp-Source: AGHT+IGAyUBhOmkhRgWqS1zJpRcgVl0qeyUZAsqD0gOXKF15WXOwyBkdzw+4J241mavqQWmTSCZjWg==
X-Received: by 2002:a05:6512:3c98:b0:545:1104:617d with SMTP id 2adb3069b0e04-54990e2bd34mr6096644e87.11.1741715385113;
        Tue, 11 Mar 2025 10:49:45 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae4465fsm1921728e87.26.2025.03.11.10.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:49:44 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org,
	daniel.almeida@collabora.com,
	dakr@kernel.org,
	robin.murphy@arm.com,
	aliceryhl@google.com
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v14 01/11] rust: error: Add EOVERFLOW
Date: Tue, 11 Mar 2025 19:47:57 +0200
Message-ID: <20250311174930.2348813-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
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

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/error.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index f6ecf09cb65f..1e510181432c 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -64,6 +64,7 @@ macro_rules! declare_err {
     declare_err!(EPIPE, "Broken pipe.");
     declare_err!(EDOM, "Math argument out of domain of func.");
     declare_err!(ERANGE, "Math result not representable.");
+    declare_err!(EOVERFLOW, "Value too large for defined data type.");
     declare_err!(ERESTARTSYS, "Restart the system call.");
     declare_err!(ERESTARTNOINTR, "System call was interrupted by a signal and will be restarted.");
     declare_err!(ERESTARTNOHAND, "Restart if no handler.");
-- 
2.43.0



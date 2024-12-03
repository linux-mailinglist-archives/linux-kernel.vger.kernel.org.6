Return-Path: <linux-kernel+bounces-429912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8599E28B8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95E5282CBF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A26B1FA844;
	Tue,  3 Dec 2024 17:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxhbtP6K"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4D11F9F69;
	Tue,  3 Dec 2024 17:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733245740; cv=none; b=Ia1zv4AOJVNxq9/yZfjYZ2REO2X0+PFc+ECcnr5eo+I7ts/pzUw51g1+2Q1lkrquu6pIxKVUFmKBZ744xB7dDyLPcuqvt3XRfZyN5TcQs/RIyBvdRY8vyz0mkzmdijLyf2b0doFHKVvuC/P9Bzo+6VjvPBtz7AJwd+HH4TJ4szY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733245740; c=relaxed/simple;
	bh=7TF0D7iSdGT2magME+zHIHzqeRneKEyOSjHsh3ydk2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwHetaNe0MO7xoRdJF27m8BO6deLPTX654OOW3EVHkwVv11KeNQ60vN6ETAVkP0D5NeCIytxiPy+NElLalnDSZ2uKO6Ps9B+0kYYYXQU+evpFkn+28dmEtmJm33vcYYITOhEuGQRBxTCxMkfmNPmYXc7zJA4VegbUU80S9A0TH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxhbtP6K; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53de852a287so6494488e87.2;
        Tue, 03 Dec 2024 09:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733245737; x=1733850537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtMK3W1LybcvR677zqhzHXJkDBdRMP3ngjp2gwl/Zfc=;
        b=RxhbtP6KrFZWgTYgMBaVkwhAy+MTZHxi9LGTOQBBnvSbMqxB/4gnfZxLzKhEB9C/vC
         N9mjElXgYeS31BCrdCEMYt8GmPE3BfzRiGdZLRmv4AojRUoaBSVa0t6dLJU8ASJ07KLi
         kpIZe2agLX1EhnhfSDQGBD6Fiamv+cPLrYpb67KCIDqCJ7pifm67SyyP7FvRWLPnmV03
         Xv5v9F0y0OlbyUIxQ54ElpQhoc+3OQvpdRoYE8rT44IZCeFVYvrqUc/qgP99ocAsr66o
         u34drrojVgZ420RJCn78Y9NbqzP85UILZLJutrCZei59fJZgFBuPNHwUAGax6yATPt+X
         kjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733245737; x=1733850537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtMK3W1LybcvR677zqhzHXJkDBdRMP3ngjp2gwl/Zfc=;
        b=tfj4sH8ibo7nN0K+peilEefBRVqH1xmOBtdjPvrLlaSo4I8npudT9psBZJOTZzRMOT
         gYhs/LNMmCS/kUHmodDDmhDsh9JPhW3kOS+8nol8HuJmaWcoKL/wQwgfJC0421syCo9F
         kgs4ZvYxExYZRHt9iOc+Ju9POtInrPV4KUt58AC5lDi6jx/wELXM74DTvim2gUoB6V1L
         Sgql86aOwhQj+te7OZFOADBsq+5JSDRnyf7qlZE+k5V6ErH8deRh5DUMVH8I+NUNFM/v
         yNUTBSxaxdgZeINkxp9Njhp6WQeNQ6BDn3XDlBx/kZq+4O0HACZIF36OaS1F2PdESfPE
         aFLA==
X-Forwarded-Encrypted: i=1; AJvYcCVkt8OTpS1pFXTqppgWV19nhF7xjYiSf/ZdAABCdxHRQMU5vVioVyuJH4uRixKaf6YvsHX82qB9d356fmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5PmW2VxX+L0DTgcDWpEIjfbHlPZ+v1tvDyW3ShxiKOrVMS6Ne
	04Rz9L30Ns8ocE3ejbdylA1GiHbREK0da9fb1dXSWJM1s77Mixeqt6H/rw==
X-Gm-Gg: ASbGncvdwoxoKCu+455j1iiLaiM+IhxZHkXwUcQ7i6ye6dLp9qQOHmWbVi3brsEb72U
	rVoi2b4xJ9O7NXiUHAkcEBPpyCBb6DUqBb8ouKRrw9GSYKssFAOSH1oDMzcTVEEJYbYxqgQsITa
	TQbaw6sGuf6MeR9HhulvWODcyaikW6ol8Okr/kzgWhEAlPIpQkAQIaYDuhpI3VN5fvRyAudSRz0
	vP0EY1bEMImCcSquHUfcv7QqrhzmldlOnEaEHsDEXUgaHkpZwJr6VqH5o/ynfg9n7hOak9W0OjG
	FPocLUEmvzJcQTMKJHnF
X-Google-Smtp-Source: AGHT+IGKT8ncZs0BP4yUL9QW6s/N/Mve2dCBM9yZqZKLjTOm7noCdEwcNW5Zgom1ytAzSOeyIWx0Og==
X-Received: by 2002:a05:6512:b9c:b0:53d:ed16:7a43 with SMTP id 2adb3069b0e04-53e1b882fb2mr581462e87.17.1733245736835;
        Tue, 03 Dec 2024 09:08:56 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df644336fsm1893394e87.80.2024.12.03.09.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 09:08:55 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org
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
	Wedson Almeida Filho <wedsonaf@google.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v5 1/2] rust: error: Add EOVERFLOW
Date: Tue,  3 Dec 2024 19:07:43 +0200
Message-ID: <20241203170752.1834271-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203170752.1834271-1-abdiel.janulgue@gmail.com>
References: <20241203170752.1834271-1-abdiel.janulgue@gmail.com>
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
-- 
2.43.0



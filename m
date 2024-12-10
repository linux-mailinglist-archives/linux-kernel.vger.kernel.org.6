Return-Path: <linux-kernel+bounces-440421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9459EBDB7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C60289AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7517322C351;
	Tue, 10 Dec 2024 22:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8o8brE2"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A7B22914E;
	Tue, 10 Dec 2024 22:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733869008; cv=none; b=Q6wGuuGiyS+geKITu1FQOlK0X9q6SLoozR+YDu6kYiFJK8kVLX7V29GrXl+LzNxonAuq5NdAc75y2zAnPi4WbyaZcQjA0KlOOSuUYEKf5dSxG0gHZNKgxiEpDjNe0EspeH3Gl2YG16SRnGV0F13nOdlduYFg4JI1C1Vvj34p8yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733869008; c=relaxed/simple;
	bh=7TF0D7iSdGT2magME+zHIHzqeRneKEyOSjHsh3ydk2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtLZDfdbADA+xDyIKrYWJNpt1jhAIdGh4w0uKoAhbHz4/ylLY9ayV4jdCvxBVnB8G0D4+/LfGQEe8QidH5EjQWgkOi321W3xwYRuyqknNV3gMg+X7gmp9GsfxSMnl4khpGrelgRXShQWQ3IOE6C+WAvdK8w1PfznWIF8d10VbHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8o8brE2; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53e3a37ae07so3767568e87.3;
        Tue, 10 Dec 2024 14:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733869005; x=1734473805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtMK3W1LybcvR677zqhzHXJkDBdRMP3ngjp2gwl/Zfc=;
        b=b8o8brE2NwawQR004KTqKFHh4cgawhpji1+pBEEthkYCLqgxBotI9HcEsNVV7dFKgJ
         QbOYzL/lzGAeN+J8f+J+VGO45AQSXkw/ZJSp4FCEbhBpe2JvfYeR3IraC8p0/9gGtmFF
         g0Zsf9okIVj/W6U5tDE6BnEslrpvr/bfB/lRR8mvRZadSZr15gELqcg+GI+Esfa5Cdbw
         2udiuJLSJQF2/DycD/087XifOOPnrvRNaKnEZ38FcaSd8hC3EaH7c8IP0741klq51YJa
         /rJNqAsFlp/1f/V1InOtyo+3YSXCfwZ8A8CwnhUn9DozhBUkQa7iRirFbPdfYxZ4FiBr
         CiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733869005; x=1734473805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtMK3W1LybcvR677zqhzHXJkDBdRMP3ngjp2gwl/Zfc=;
        b=jhThHHQkqjsHhqqkg/pwCfi8ELfPKgR9wBvd7GVcJEv/qag+t7YUYXUj6hzDMnCWRt
         nEquJI/tAUwqpz/RJ09l1ADv+EgjH3HOMBSij8vukE/xR2SKNNgJ1MOn6EC1UD6CJVk/
         mWq8IWXfXwZgk+WJKZw+AtRkfDyPRDlwsJSMjEhtU1Dt9ltOGaTW+lnOEdG8wVyzroFF
         B4ERbbCgXUaAB9b/XhXvvPn1Nxjmg1CxGHQcNbe3L7SU0xoND05/i93gZF72yuXD0gdz
         sYEdZ7YFgfCJvzCNrlJkMPloa820y+hcab2yDnS79Y509JiDNk7Kej4z3ixv+AfXHPEw
         WpLg==
X-Forwarded-Encrypted: i=1; AJvYcCUdsxTnmHE/bGdpkkV1oL8rlJ+XoyPPOmpZ8+uFmkfkov6HsUB0HqHjiI5VKK+uHxsKG8L6xYQokmgwOWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymtf2W8zxyAB291PnzzALxMKRyK8mzXCmskDgtRS6kgn+199vd
	HL1DbSIOHnD+7HkPCOcqzbjWSXLlA07MpKQSK/JcIc3iKtshbFKVecYG9A==
X-Gm-Gg: ASbGncuwUTqRla7k1ByFfRwAIPW2PAvSwTxMuAxiZ8jYJbAHuxxcfZWr1gHzOdidZiA
	aQs8VG8A6fqmzjcZ+mQ8x0bCRxqDH30FMa6q/WBrwkUdMBAX4FjfMK3OF+skfVrJMvXzUDIT+Mj
	tuyK2RLVkyYFuy14vOQDOTS4k/4bFl0vp+IbCgK+D/+t5AjDsiT1L1XbJxaFc6QAPOUxnRF+mSU
	oNFeY/E4qMDf0OV5E43LdfyncXhCidxvH2pQFSjN1UyB8eX2ggonmqCzjIDzV1ZugSgfw/LeFO+
	eXoe2A2RpZxcukiV9ELriRHQ
X-Google-Smtp-Source: AGHT+IH9EfavxqA+l7UUyXjE6dD6kRiqPRIcI9r6iPLIBdfqW29TtwhZQ+79LfaDOqsi8cZ8iFLQ/g==
X-Received: by 2002:a05:6512:1597:b0:540:254b:8fb with SMTP id 2adb3069b0e04-5402a605dacmr136595e87.54.1733869005145;
        Tue, 10 Dec 2024 14:16:45 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e34a4531fsm1472694e87.262.2024.12.10.14.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 14:16:43 -0800 (PST)
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
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v7 1/2] rust: error: Add EOVERFLOW
Date: Wed, 11 Dec 2024 00:14:58 +0200
Message-ID: <20241210221603.3174929-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210221603.3174929-1-abdiel.janulgue@gmail.com>
References: <20241210221603.3174929-1-abdiel.janulgue@gmail.com>
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



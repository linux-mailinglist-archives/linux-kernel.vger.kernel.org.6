Return-Path: <linux-kernel+bounces-244067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 106C0929EAB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EB9E1C2196E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623D75579F;
	Mon,  8 Jul 2024 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M448UVm2"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EA28C06;
	Mon,  8 Jul 2024 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720429622; cv=none; b=LeA5ENOHr+VaFpzUDHP5oIvFkictGl3VdQoNjhy5j/niy+BsCUHBOjYSBj2Dsr9nmRnhJpDZ5d1uYXEf6lpouVp/9wGyGTMBv4Yv+vNHKvZDJ0wY1yydXbmx+HvSCYKUG/+0uFqlKTk27Wwi9yhRUCkUubpqvX0UX5T0ufMNxK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720429622; c=relaxed/simple;
	bh=mV1LipK/FuGq7j+gzyLCLNXhEfHp8ZALbfN4s0sw87w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Us273fE4ihRgd/QfiVi6jn3hBlxrxdxqaogDHLFR5iM+b7H77VO53Lyo3p88Pje0oU2BrmowbDbCooLdbeHZd+dTCe2gdBOAvMsrF+TW3wp2nJQh6RfacAPCwj8PTN9VedMnd8cqzjV8KR6ZgiFFFoWvbBjTmxd5zcFYAt4nYfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M448UVm2; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d9272287easo1007101b6e.2;
        Mon, 08 Jul 2024 02:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720429620; x=1721034420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sszcVanAVKdYYqxBnbm3QO7r8vp/tfxRsbR3NwzhhxM=;
        b=M448UVm2Y0/nI3SQ6es5axXPKsSv10P9jTQ+6aizWNjomeTe/cUd5RfIsj1lNkI7D/
         IKMdGB6UGjwuzr4gDCNUMRLHHKBWc1nZ7fzYlwYVS511Uh3yirbOtGRmv/6j9O4a49gT
         5ssytXWxsuo0P6G3MGvLVXs6gzig9i8Iw7NRT5G/hZ07nwctvRbToS9eDLWS2TYHio4o
         Zdve+7UhClQ3TB9JMHc6yVg9+f07lub/i0lcxjTFUWE9/pzbmWSsFaxChYMoqejgzolM
         arS2M9Ew9Vvp8KNKsXZ0JOOHtdWFnDuq95A6Yoate6pXyodz3j2+7vxU03ufGcQf5dzg
         7BAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720429620; x=1721034420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sszcVanAVKdYYqxBnbm3QO7r8vp/tfxRsbR3NwzhhxM=;
        b=hz+GCPlbFPf1iwYmwwXMQ/+TmCABS0zZ+xegJG9FWUI/OQQaAgJdZEgo5ErTm71e6c
         xPP840Xo58qIgrsCZnS2s2Pxy1WRCAmKjXwFjBHdS9LfPc+fnrRRoXqeI2ChmlqZijUk
         AJJXk+bCK3ueHIAFFsTj82shmv7JHMfVKLFL2x5AlDE9xcqz42fuZnAwQIl/4+9Q26HM
         TDL605Hk7h6Q22Ds/+mReRXkYjFtR8iPxDh4WOF6ovrHjI/S+U0rMPvVLcOf75t0YiFJ
         s1sAfJfzyxpfB20rF0Mg61mXxadDgyKYaP1vvGup9s6QEigAGVFY6YfWbF9LkBXwxei4
         sNAw==
X-Forwarded-Encrypted: i=1; AJvYcCUYslzf8Ubs4zWrHLvZ3i71mswXagbFSbLQzzBUAjJfYPnA/mBbIrH0yCxsD27NT/dVlk5U/AFgH4hCD2tqOXDhcUTrvqxP1RLTDFojeA4=
X-Gm-Message-State: AOJu0YyU5XSxzVp7WAjAfDi2DicfKa/FCRfQzOwV6L9jgEw65osYUkxS
	vSDpMzlvCscEWeeOwBtVVBU6F2UuF5UT17JZmX2v0c5xVbsXfod/0zP+hQld
X-Google-Smtp-Source: AGHT+IGCkR3C+3ZBC987fOhuAC48dnbIyUz8o1kUcoAFt73gHT0rqnuvtcV3On4BM4WUJy/9+DhKuQ==
X-Received: by 2002:a05:6808:120d:b0:3d2:1cca:77ad with SMTP id 5614622812f47-3d914c62a65mr14638845b6e.13.1720429620393;
        Mon, 08 Jul 2024 02:07:00 -0700 (PDT)
Received: from my-computer.lan (c-98-39-68-68.hsd1.tx.comcast.net. [98.39.68.68])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3d62fa4164csm3720563b6e.46.2024.07.08.02.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 02:07:00 -0700 (PDT)
From: Andrew Ballance <andrewjballance@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	mcgrof@kernel.org,
	russ.weight@linux.dev,
	dakr@redhat.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	rust-for-linux@vger.kernel.org,
	Andrew Ballance <andrewjballance@gmail.com>
Subject: [PATCH] rust: firmware: fix invalid rustdoc link
Date: Mon,  8 Jul 2024 04:06:15 -0500
Message-ID: <20240708090615.2267476-1-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rustdoc generates a link to a nonexistent file because of a extra quote

Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 rust/kernel/firmware.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index 386c8fb44785..763d7cbefab5 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -2,7 +2,7 @@
 
 //! Firmware abstraction
 //!
-//! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h")
+//! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h)
 
 use crate::{bindings, device::Device, error::Error, error::Result, str::CStr};
 use core::ptr::NonNull;
-- 
2.45.2



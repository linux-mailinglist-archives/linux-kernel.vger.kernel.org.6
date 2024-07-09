Return-Path: <linux-kernel+bounces-245031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0877192AD3E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 02:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F08282663
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70582BAF3;
	Tue,  9 Jul 2024 00:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erFUEDlK"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC5A10FA;
	Tue,  9 Jul 2024 00:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720485949; cv=none; b=YJs5O6oPQ0YrpEZWLNR4Q9FkYEWHyuFUqtYHtNFBfoPTNOC5dLW9zUPcO9SMdbbGNw84W5PmYswNEJSZZkAncf6++CkGgmn1VlcrK5CbSA6tVoOP2YEp/iqvhqSEFAgpcLP/jyde3ksGi2mQvhizPOIkyoZc/5eidMSXxBJ85lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720485949; c=relaxed/simple;
	bh=yVpmdenWty9VmRTaqVs7JI1s/mmytLE9QKXnW4wz6IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tl032WZYQ8VozQLJx+6S4kqadPloFpNFEihQ3Sxf6tmiHz68/CFssSaD/hMZ2tZZ/bk+ocdie3JJ/e8R+SzzESr+MjwmX3ew4mpL0FHLnucir2nD7xRs0eLyWbvnccgR/5cofq2GIy3LhAKozd+9UgXjRCtZYik/8wenaybeVvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erFUEDlK; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7036b87752dso883810a34.2;
        Mon, 08 Jul 2024 17:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720485947; x=1721090747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9iPtF9JSiTmGcnXmpNXmV6InuM1mMBUZC3N3YyhPMc=;
        b=erFUEDlKhRpsK9XXmOaVLp6Tei7G20+S7eIMJg6+R9D4+vQhdGliQtWPyPVmx2a/gc
         IGHiLcm4FmPxj0d3XzIGXh+zNGckPkHSVW6OScnBevLNs0PaTXML6+wjxj8EcC7etniu
         JBY8u26g40qLFxgLiUu/CD/m1viKRcB9GtH5WpTGz0M2G3cH39FBQd0+r0OlPLYJkjfJ
         W2s24etw84j6n0tVG68yoVVDA/klv/44coeB+Nib8lVY3YvU0U0y+9jlJaSWboCBSW+l
         GCJW3tZqCzMUtgM6MsJe7LaTIPL9MvYxBEHmn/+qtJj7jcf1Eo+RoPcf6gAr5C9vcEPz
         jvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720485947; x=1721090747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9iPtF9JSiTmGcnXmpNXmV6InuM1mMBUZC3N3YyhPMc=;
        b=ndDn9d32qrv5L+DTqOooSnGl+06AFeWfyDsRaSdtSHIwhUwPP+36Wf3DuYyUpJhqH/
         SPoANTumAWxBteXlKAjKghI6K71hVv3GewHqldBVMYpU8XDEHjMcKzj5z//nn8pmv16D
         f5ngio7xhXG3ZvpmyQ2c7LsyWECvuCww3MU3jOG2ML0sHgzixn/L8U6Q1v7rtSUVACvm
         XCeNv2oUmaiLhY2xu9fOuWMDnO0SXsKqAM7MVB+8bdZtGHqWqy/jnm0F3yBl4sFE+43R
         /WrjAJJPghvF9T4QwQ/zba+0ITOp0Hjke+ovrU5hPqQbkazz7sARhRkz2y8CuOgfOuHL
         b6wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs06d4MJDzpDesh4uuP/AOuJC9OkLtTAKjwEC3gaGsE+3LrvLmVZesihEd2pHmEvgatdSqqpy3n3whVNKNyw3Wd0tb2Imi/nseXgODShkW7aiIn+Y29Zmwq7RG4fdgWBzmJhJ6t1TuGYzllOI=
X-Gm-Message-State: AOJu0YyHboU+yZ7iPe84AV6uE7jVosexjt72rB85ELuX+UggiTYvceT9
	4HvDMY7nrIa9qiG8LgdBhU0DecyMkZp3G1EeHFdnCMaUAier4Goj
X-Google-Smtp-Source: AGHT+IGG1Ld6V99SNEvuuuZYWfNfTXQ3dsVI4Y2qI2ZXJjfOBhOEzhq/DHbMG1KQ5AaHayz4uRoQDQ==
X-Received: by 2002:a05:6830:1d7:b0:703:6496:b9ab with SMTP id 46e09a7af769-70375a06f35mr1332946a34.7.1720485946711;
        Mon, 08 Jul 2024 17:45:46 -0700 (PDT)
Received: from my-computer.. ([2600:1700:e42:d53f:19e4:45d8:10e5:471e])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-70374f6b5easm231026a34.14.2024.07.08.17.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 17:45:46 -0700 (PDT)
From: Andrew Ballance <andrewjballance@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: a.hindborg@samsung.com,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	andrewjballance@gmail.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@redhat.com,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	mcgrof@kernel.org,
	ojeda@kernel.org,
	russ.weight@linux.dev,
	rust-for-linux@vger.kernel.org,
	skhan@linuxfoundation.org,
	wedsonaf@gmail.com
Subject: [PATCH v2] rust: firmware: fix invalid rustdoc link
Date: Mon,  8 Jul 2024 19:44:26 -0500
Message-ID: <20240709004426.44854-1-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <CANiq72=6LSGwRsc+deE+U8H=mdgFisrKEPOYgVkZfHhGm8hwog@mail.gmail.com>
References: <CANiq72=6LSGwRsc+deE+U8H=mdgFisrKEPOYgVkZfHhGm8hwog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

remove an extra quote from the doc comment so that rustdoc
no longer genertes a link to a nonexistent file.

Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
Reviewed-by: Danilo Krummrich <dakr@redhat.com>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Fixes: de6582833db0 ("rust: add firmware abstractions")
---
v1 -> v2: updated commit message

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



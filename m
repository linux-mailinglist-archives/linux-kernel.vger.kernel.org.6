Return-Path: <linux-kernel+bounces-553651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD6DA58CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C1D87A3804
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2241E221542;
	Mon, 10 Mar 2025 07:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKvvApxm"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2713121D591;
	Mon, 10 Mar 2025 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741591860; cv=none; b=eHqP7mafwMMIaJ/p/A68EaaWoliZCKoGLJi0u0WsuA+7NHVOGvz1jedDLGO0eJWAUfR+ziUNVOP/SRQqCEAOqln4mWVCAvjdHSOolAY0Cetuo/0wU1hdWHT6jKQIaFOsFVjlmYwQ3UPygeAdnPA+FSZq1ATy9SrUTz4T5W7mQBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741591860; c=relaxed/simple;
	bh=ZWyiDX/vDGiAqA0tRjbykGLrDq3j4KxRc+K/r5na4aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVe2VMY+C3A+R9gjQYzc419Wx81mGK8BhGgc0FMv/HcS2OVgDYSvapTH7hgKN0pOdmNzMhBwTAPTIrS77nUQaeMJAzNDciCequVJGvbme5m7IaC3i5cYXWBIbfW3klW2Oqlqo5OaV/gK5TOp0lHGCgM5ABn/7HVoIY6HWSTA+7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKvvApxm; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2255003f4c6so19586525ad.0;
        Mon, 10 Mar 2025 00:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741591858; x=1742196658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbrw9fKYJUWReB0Z6L2vCwEnh6k+VDvJH5rqaU18azM=;
        b=hKvvApxm+QhoLF1gNXYPiGPy9ZUhugr68/vybN8M8SxKvur7RLZ5lBsMmoCO7oAZUV
         cI+bfD6qup+8GXuSdlLVkAqtu2j0koSj9gGbEJ2fvzyU4P9LNKMlRUEbImRIOxRwkW/X
         LFNiA018oc7oVv0asvTJEjkUj9UtXF+3FZEMqQMm1Izxqkjz7SSKwjGdR/augaSQ/IrC
         DvxYBQIon/37maaFpx7RU2dwMQJRldXm6/4hfa/YWKBeYYHbtF6K36/X2RjdW6mCW33D
         Zu64A/ePbC/KcPbrP03xoHV0YZ7bPyCKTrz13oCOaV04fLR2rGraF4v6QB5SMXNb1Z9h
         31jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741591858; x=1742196658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbrw9fKYJUWReB0Z6L2vCwEnh6k+VDvJH5rqaU18azM=;
        b=DnO5dumLVF2chxI3e+rCyTxLJIcYlYlQXTQ+knX6FupSGiVy0UCUzYF690zbdMUKGw
         F7LnUmKncT7/F+w7g+166+VBkjsjO799tPO+sUpYaVhvRWDeFAzDkgmG5vOTTyKzxSdB
         1dy6tE5Jdb//kdJHFLXL7tNFnQlVjICb/5wJbbEdaguBjjdku6cIABKdNAD9BweXuE7Y
         jeZME3qtRWDTQSk4Oy+3obE52ruiUGxKQTQ7oS7knfbbDAKJwLIz68PFVnDmZh53TTNV
         t6u/maajCLn2Ne6tPOaXwgJPJbEqE4zie16NWRlSZJn7bfmQkiA8Q04BSzIWWuOpnYIW
         BGTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/KQrWzVEJGFV+9BFQO0BtAuX2erA3YNhwOswNovf6CijA12NWAAPNIRVlONPDfkVfmRZHI/CSlWyfDdk=@vger.kernel.org, AJvYcCVshdT1DNrxiqNUdwAmTxXw9fl8qxHQTqZQWM0zwJGqh+9LrzcdO0BEymQODcAErj7Z1XqEi6dSOAYF0v/jmHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf8ytK2mH35ZUmlsEK4FZLHwayFrvNKEQa9HjhcRiGrJPjjnv/
	d8FDw7LtmV10EJvTfsyM8aFEkmikton7cQ4rUq2bPOwPgurVZhRt
X-Gm-Gg: ASbGncsO7fZrEq+Qw6PWwEQRzJdKbf4uXlvGq6cTeR/vSKi21OlihL0kK7XxqjI2S5c
	Kql7QgFnEgRsv0S9xsjfh0Ro0GPxRpa02PcZnH9EliAzlZYNIglpItoWy2BKpmd8bafkLQ8e29b
	/hb/Fsh7i/sK3SVFk1SQueKbOCGk22zI3XIoSP/QaKFz7mifcxRqqQcV40/GT/Yc07Rp9CAwt2M
	ecrIQ3Gj1LTU1sUGBAxyX5SzmHgO7+Q4f2FjWU/9NW3PV0KPTHThAds6WWow+Sok1e/PLr2aVVL
	XychNDzg1pTfB2fGokRg4+651h+QcysjAmvySV1uxa8+JOomWIeobWLCggwRhkpTPkZVKlLuDw=
	=
X-Google-Smtp-Source: AGHT+IHsKs1IEPx0zVJOtYDvg2NEVgoS3BbGZqnYfDtmOAWe1ErF1lt0JxUII7ucqC81s+4W77tleg==
X-Received: by 2002:a17:902:dacd:b0:224:2717:798d with SMTP id d9443c01a7336-22428bf725dmr181608585ad.50.1741591858392;
        Mon, 10 Mar 2025 00:30:58 -0700 (PDT)
Received: from vaxr-ASUSPRO-D840MB-M840MB.. ([2001:288:7001:2703:7ad0:37c7:5275:4b0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f773sm70840715ad.117.2025.03.10.00.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 00:30:57 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: ojeda@kernel.org
Cc: alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	jserv@ccns.ncku.edu.tw,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [RFC PATCH 1/2] rust: list: Implement normal initializer for ListLinks
Date: Mon, 10 Mar 2025 15:30:39 +0800
Message-ID: <20250310073040.423383-2-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250310073040.423383-1-richard120310@gmail.com>
References: <20250310073040.423383-1-richard120310@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently ListLinks only supports to create an initializer through
"new()", which will need further initialization because the return type
of "new()" is "impl Pininit<Self>". Not even "ListLinksSlefPtr" use the
method to create a new instance of "ListLinks".

Implement a normal method to create a new instance of type "ListLinks".
This may be redundant as long as there exist a convenient and proper way
to deal with "ListLinks::new()".

For now it's introduce for the simplicity of examples in the following
patches.

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 rust/kernel/list.rs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index fb93330f4af4..57d75ca16434 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -158,6 +158,16 @@ unsafe impl<const ID: u64> Send for ListLinks<ID> {}
 unsafe impl<const ID: u64> Sync for ListLinks<ID> {}
 
 impl<const ID: u64> ListLinks<ID> {
+    /// Create a new instance of this type.
+    pub fn new_link() -> Self {
+        ListLinks {
+            inner: Opaque::new(ListLinksFields {
+                prev: ptr::null_mut(),
+                next: ptr::null_mut(),
+            }),
+        }
+    }
+
     /// Creates a new initializer for this type.
     pub fn new() -> impl PinInit<Self> {
         // INVARIANT: Pin-init initializers can't be used on an existing `Arc`, so this value will
-- 
2.43.0



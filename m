Return-Path: <linux-kernel+bounces-399665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A85509C027D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E021C21A09
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2992028F5;
	Thu,  7 Nov 2024 10:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xhocu4RF"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DDB194C7A;
	Thu,  7 Nov 2024 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975816; cv=none; b=kaliJypCOa9M+4ivzs0tabDW50Q31kbJYSrnwf0ZuqNlXm9VUV5tE9CWH4uEHXQnXJRgIIc5JdGgJYwvMfQi9T0EzIFlgyVhfz6rew4v29ZCC4zF9kJCQcAwkp8rqrHT2nEbyyqgyiXdkAcsRxlykrRYYzURthnen4b9auCUq+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975816; c=relaxed/simple;
	bh=RrLnnEzts4OYKPhtFwS8cDUHlQU9M//D5j+x88JxFpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=upkeV3S1IgR0Ng6AdhT0YdswDwRozkjHnVSVHtni2FHsdRFAxvruRj8BDeNhdq4/RH31vlqOVJ0FzJbN6UtPQAIKGt9u7dQlQxfSw5bBJUyAJEFP5+iJbfVlVFKWbMAygJcyZoKpY56Ak+8de54JHFgJ4mYHmJnSvdT8ImSbOOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xhocu4RF; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-460c0f9c13eso7443241cf.0;
        Thu, 07 Nov 2024 02:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730975813; x=1731580613; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qJJ/2q9m7IN1WFoWz8zbCoBZWDdzsyKokuxTCKWRdM8=;
        b=Xhocu4RF5W//kbFa28bAn7e1wmqA3etXjYabZKZhaH7NlAvB+WJ7YMzh/jR3C76Wyi
         FlqxPm8qpaNqyeBlUdnM8JRBHdWaGfHnSwi4UxFxEBp2DsfUhIX2Jj4oDSPBfDIC0zVX
         yRsathZvRbb6d8nzYi2bVFt8TqVuzhfvhIKTxUZVz0w9L196H9J32dfWr21W8oLolQcs
         u6kakiEgEccUl2RwkBOpKrSDsKYQjfOhxANJD3NvwPGKaCks8dyyjDLTwjijI/3Vlc8t
         7fAhvvcZPPtKiLyTMsFPv2DkRKFf0xvItP/lqEnjHhBWYYaFUbvfHRqftvI9ruqIM9Uj
         Duaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730975813; x=1731580613;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJJ/2q9m7IN1WFoWz8zbCoBZWDdzsyKokuxTCKWRdM8=;
        b=URzGAA1rUPlMb4GJVUwmfCg92Yvz5+pleJDAq+kK5T768ZCoGdCCWwI/ydDWuGY5MP
         no422iTA/4pYLAlXSLUHPxxMNH7XZqxOUR9jcDhZNGGx7On9jIRmZnYabXsASM0AnoA/
         nXRtZNA2AVOS+m40XFsln4AnX7i2CYQxxNOfhrDSFPAENstoHbCcIyPAdCunAxC0QPyB
         30awecuPQmHOOhqcoElCYcMvbKQG/1RHn5BK5qxz9G0kqzCIpggXNr94+pvYa/UpaWIr
         0SeCEtnrUAfu62/H0JF/qtZ1X/3vF+rGN6b3EoZtt4kolsBcmR6Vjr2VDPZRZiSE2Y4f
         9M6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQaJiATv9h/MVr5/72n22sypmGyhcEGFwBZhPqR7uJb8fHVjQc0/HCZOfJmegodLAoDD5z/aasLoKvgEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkPsfjlArT0ntSwV1Zhyy298DBPqdaZVoUm7lR9nBmAcJvZFLc
	49O5mzj73q5JN13RWmqjIjwe1TefZIDQvon+Th4JKbJsAtww+rW9
X-Google-Smtp-Source: AGHT+IGkoPWAC1CKA63p5xdA73+R/tQ2SGnKgNg5dasna/m3dj2T33IUP2ywx2BbIe7ev71MmXieww==
X-Received: by 2002:a05:622a:134a:b0:462:b896:798 with SMTP id d75a77b69052e-462fb7772f3mr42597381cf.19.1730975813359;
        Thu, 07 Nov 2024 02:36:53 -0800 (PST)
Received: from 156.1.168.192.in-addr.arpa ([2600:4041:5be7:7c00:b804:d77a:4d8a:e731])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff5c97fcsm6170511cf.80.2024.11.07.02.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 02:36:52 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 07 Nov 2024 05:36:46 -0500
Subject: [PATCH v2] rust: sync: document `PhantomData` in `Arc`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-simplify-arc-v2-1-7256e638aac1@gmail.com>
X-B4-Tracking: v=1; b=H4sIAD2YLGcC/3XMQQ6DIBCF4auYWZcGKMTYVe9hXNApo5OIGmhIj
 eHupe67/F/yvgOSj+wT3JsDos+ceF1q6EsDOLll9IJftUFLbZSSRiQO28y0CxdRtBJvtjVPSw6
 hXrboiT8n1w+1J07vNe6nntVv/QNlJZRwhgh1J6mT9jEGx/MV1wBDKeULlYYY9qgAAAA=
X-Change-ID: 20241104-simplify-arc-70c3574b5fac
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Add a comment explaining the relevant semantics of `PhantomData`. This
should help future readers who may, as I did, assume that this field is
redundant at first glance.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v2:
- Reworked as a new comment (Boqun Feng, Miguel Ojeda).
- Link to v1: https://lore.kernel.org/r/20241104-simplify-arc-v1-1-a4ffc290f905@gmail.com
---
 rust/kernel/sync/arc.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index db9da352d588f65348aa7a5204abbb165b70197f..547d56766f507afe4bc733f7f1b465a55b64312a 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -127,6 +127,14 @@
 /// ```
 pub struct Arc<T: ?Sized> {
     ptr: NonNull<ArcInner<T>>,
+    // NB: this informs dropck that objects of type `ArcInner<T>` may be used in `<Arc<T> as
+    // Drop>::drop`. Note that dropck already assumes that objects of type `T` may be used in
+    // `<Arc<T> as Drop>::drop` and the distinction between `T` and `ArcInner<T>` is not presently
+    // meaningful with respect to dropck - but this may change in the future so this is left here
+    // out of an abundance of caution.
+    //
+    // See https://doc.rust-lang.org/nomicon/phantom-data.html#generic-parameters-and-drop-checking
+    // for more detail on the semantics of dropck in the presence of `PhantomData`.
     _p: PhantomData<ArcInner<T>>,
 }
 

---
base-commit: ae7851c29747fa3765ecb722fe722117a346f988
change-id: 20241104-simplify-arc-70c3574b5fac

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>



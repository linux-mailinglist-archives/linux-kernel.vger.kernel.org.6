Return-Path: <linux-kernel+bounces-562372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6E9A624D3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8C67178FAE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 02:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7641D18DB13;
	Sat, 15 Mar 2025 02:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aR6pL74v"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAE6195;
	Sat, 15 Mar 2025 02:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742006607; cv=none; b=RIXgo6PSNHcrUnk2DoKSkNYHJ1wh6DTUd5MmxADCcAa7BDehzf67w34tukwa5et1CtgRP82fbRl2pc1DXmdqOzl83DjBx5zSfunQdhbd1iDbThPTCc50brIYq3Rsd6M1R2R7YxUQ3NwYly8T9xiMIThmZE45XggbzfpGD8SR6jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742006607; c=relaxed/simple;
	bh=64fgSFwWm2hDM/YGB2UOxVjy/3SuzaG8QILzdirzqw8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODpyccCETLpnPp39X0mkiK6++PybTFNUe9gCf8S+7aT2JthPTvnqZDXFrW1TqlsBCtlLOZCFTowxQriKtblTLimu5cneEybhIXqDzFKltphmfaqRqFiB1vAPn5JkRejeFGV+/+/uNdNkqEXSK1Jn9T4JCHwIhp/PzeWXmN+yBmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aR6pL74v; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-728a433ec30so2786316a34.1;
        Fri, 14 Mar 2025 19:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742006605; x=1742611405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ozI6bHXFcVEFtJyDWKZZMCOOL14Yw6gl5milkPaugjs=;
        b=aR6pL74vhNHyufj1nBJBWL5p0WhKpmN/L2DHWzU+5f0X2+ROxgek0QbGNefrmzEc6R
         a49OVpsJpDB6dcGszAhivrCW8hjHUPyISHe05ZSLTewIXLz8RRdjeEF3NhIOyfk0SATf
         0mK1ZAvkamCXcV6Gd3cYQ0EDk+0ZXEcV4z67Nno++aXC8D+NLfF+QbLskpg0k7+tvgCO
         c2E7wQqxxdaTBB5lCFbQzWKs6/0xfZkV3chexcqVQOEW1ZYLQoONdd4F0RjJXTQZ8g/2
         peSK6XpIgkARxDqQ7iGblWlxUMs0bl6hrS91ODOPOodi+RFKUJsSsJezCmZ64/6hdfAk
         soWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742006605; x=1742611405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozI6bHXFcVEFtJyDWKZZMCOOL14Yw6gl5milkPaugjs=;
        b=EJPBrSK4BOVPjCgwWrNRy2ZIRqXl+ZemmhjDdzP+/gJD4NXDeWah0YANfhzs+4RPE5
         HDuX4E1MzeyTQYkdHQJk99GslCuABm3q7HMSW5Z0dAJ6wUcyxgdWGOh50XizQv2N0SIN
         uMaZaiOTMkG6lKXD9pW0kUOCHyX/9OrydvLomom5BJxe8jttLTqo7Ya0i+ycKd18oLhh
         65I0iYZCOqDvibfiMJM8rTSvTfFBUrN2l/dRHei1wkMMZ4ZkFbOT/X+imVpG9BCz+eus
         sCvJZgA1btm4+wrhyDph3HNQotRyPu/Tdaql4pvrDdMy3pdqjMDVo2qS1vs6RePS0mcO
         IUtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWA3h6l7LlF/rzCh2MVwj4O34vjUwUHkq9wqN3qj/XotGGHD4ATEU0WdcfaNUHaJ82t2Eg8Z5Q2D+0=@vger.kernel.org, AJvYcCWqtaOO4S3tsopI/LUryF3IO4bLRgASvRoAmNoJLk9/6S99N/5PFFbfgsRwym7ECHO5bXAz2qWc/m4iOEX5tsg=@vger.kernel.org, AJvYcCXgjWVArWeAQEXTNX5xA/AkQBKnn1kyMJXhodbG3Hm5yPi5CVEsIBUTcJZ7pG/PziQtBabnsCwJVWFUcFDV@vger.kernel.org
X-Gm-Message-State: AOJu0YyDAPl3VEwTYJ1nPvM1+cl9hup569lq6G99UrH+nFoMn/JYTyvN
	/s3XkArJ2It5abmTTjynzRAnIVVRDL+4vyqzbKtaORgiiOqvVHe5
X-Gm-Gg: ASbGncv5jWODV17DhU4h82xb9Y3r4+cFVYzFW4xpcu42FDW5k3AHWF+oM7cEp1asYnR
	x/MK9sVN94LcueDBPjtIiC/A4k/Vt/V8jYsq68q2bETqXZrSKpPVSpttw70+sDE3/0FnfUgw1ok
	fy/vZIGMt7I7SpupFcaaJ7d2sjsvIIcZAQ8juKPwJpgUu+47xWurOMLmfIZfw0GF5pdxA87lW9k
	rWq8ayNVS31DisFHkuO61xKWoHVvBYb9BazDQIQCRFcEuWe8kg0VmhIAPQiGckpnyWCxegUfUTa
	rpsvoIwD/5u8DHwXp/50F+FJS15LfTiChK7rx9ZSW0oIukYsXaLLIPN3WqkgRfP6o0h9vAM7he4
	9yBEJTP+HromMBKHA
X-Google-Smtp-Source: AGHT+IHn4T8ft66JDSAaRetx3LPtJm4QIIBG5/KyMQuMrsIYaO6ONBeR2Co+yM+xjG3i/KhZyNmJew==
X-Received: by 2002:a05:6830:8216:b0:72b:7faa:93a6 with SMTP id 46e09a7af769-72bbc48cdd9mr2033320a34.14.1742006605244;
        Fri, 14 Mar 2025 19:43:25 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-72bb26bb82dsm882990a34.32.2025.03.14.19.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 19:43:25 -0700 (PDT)
From: Andrew Ballance <andrewjballance@gmail.com>
To: dakr@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	corbet@lwn.net,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	andrewjballance@gmail.com,
	acourbot@nvidia.com,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH 2/3] rust: alloc: add Vec::resize method
Date: Fri, 14 Mar 2025 21:42:34 -0500
Message-ID: <20250315024235.5282-3-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250315024235.5282-1-andrewjballance@gmail.com>
References: <20250315024235.5282-1-andrewjballance@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

implemnts the equivalent of the rust std's Vec::resize
on the kernel's Vec type.

Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 rust/kernel/alloc/kvec.rs | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index 75e9feebb81f..cbfef2e56f9c 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -554,6 +554,31 @@ pub fn from_elem(value: T, n: usize, flags: Flags) -> Result<Self, AllocError> {
 
         Ok(v)
     }
+
+    /// Resizes the [`Vec`] so that `len` is equal to `new_len`.
+    ///
+    /// If `new_len` is smaller than `len`, the `Vec` is [`Vec::truncate`]d.
+    /// If `new_len` is larger, each new slot is filled with clones of `value`.
+    ///
+    /// # Example
+    /// ```
+    /// let mut v = kernel::kvec![1, 2, 3]?;
+    /// v.resize(1, 42, GFP_KERNEL)?;
+    /// assert_eq!(&v, &[1]);
+    ///
+    /// v.resize(3, 42, GFP_KERNEL)?;
+    /// assert_eq!(&v, &[1, 42, 42]);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn resize(&mut self, new_len: usize, value: T, flags: Flags) -> Result<(), AllocError> {
+        if new_len > self.len() {
+            self.extend_with(new_len - self.len(), value, flags)
+        } else {
+            self.truncate(new_len);
+            Ok(())
+        }
+    }
 }
 
 impl<T, A> Drop for Vec<T, A>
-- 
2.48.1



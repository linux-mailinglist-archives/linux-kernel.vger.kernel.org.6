Return-Path: <linux-kernel+bounces-564066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5199A64D19
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D459116F15E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC5E2376EC;
	Mon, 17 Mar 2025 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYtR+UQg"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C3719E966;
	Mon, 17 Mar 2025 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742211790; cv=none; b=kdYkQTUiSk1E2QUAIK/VKZysAJGGBsDY/pRnvviDBrtP4+obB2Q5CcU23LcI+TBs+ktvnvsOUwVS9iMdf0rRiuXL0+ZmOLunvWcw5VzlPmc9xzAHe2FFJKWpwaRBqy66+FHVl9PR12IXFeuyPamB5hxxDKHZyJL9RVkpiH+V/1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742211790; c=relaxed/simple;
	bh=CxSsFZxqkPfI768p+dW/LZWxZ4f/fIIDqf+WH3OVDC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=F6jv+gL/0QWZ9XDY/Id5NuUX3kCU4sFsEgq5Xvq4Ms+PI/HWld9hQ1VAjMGR8tF2OjV/+KlvBTNA9VbUUgh3auSUCJfrKXZcd77sLX8japNm0YBGO4tJHWvWwZlJuAHMku+R0cfLUvI/pQG9o4g8WUJLIrHevJe315xJT8Mz8Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYtR+UQg; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-476ab588f32so19428061cf.2;
        Mon, 17 Mar 2025 04:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742211788; x=1742816588; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8wuWNFFM7Vg/ROqOqi09Ck217ywduVgJIFfcL525qeg=;
        b=mYtR+UQgXmXcXW81atml4MhcThtJA8Gq1BP2rNqdt9imPkHUT8s4yiandhFtr+9HAI
         BgTj6M6czehBENKzGAN5Pk9qp95OCQSGx+OkkxnD/szA7BaGn20ujCrrTJohpO3mAZrC
         utieugRA3ba8jR6xVTL3UEEsOoBGIjP95utcsb0XFE+gOLZPqkmaGMFnQpPXtvpdk4kB
         qeNLxDcc9O5F3J4wAsy7awlrYV4WfCX+wA778jU5c+f38kGEXXpbkyeoi5WV2s28OkJE
         Z5R4xK14TenpiLlFsawTsMNcX02j+IqWjyBNWil+Vo2acjYp2dI/Y+7B82iA9ByBz5je
         EqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742211788; x=1742816588;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wuWNFFM7Vg/ROqOqi09Ck217ywduVgJIFfcL525qeg=;
        b=fxza9ZpJW4KG84KzLBhRSt2m6HeVh589PZ5/oVxAslUe8ncXoyPMyf/jjTcBeIBVlS
         HYtb1oX7Djt/BZxsa6K3OBVvtzvTu6qnMDBBr/8JR4DbSU+F70NfODkSm5ggRjjTeA8M
         Hx50lUx8kQZkCYNrTZvkgRhIFSM/6dgyJW01QIqMJkuf7S+dOGXnnXFNkGimd1kCjQsd
         sJDrp+AI2LGgO9qEZ1qI5IlL2veSD9B1Xhp90TYmdbOgvV0O/UsnHC17nluJIPDXn37N
         Xs+VAlm6Vri52cEe6rL/YnZ3PDcIyte2AklZJwhSPbZbGJhhsgsvszbqxmCtmHv9eRtI
         1a7g==
X-Forwarded-Encrypted: i=1; AJvYcCXDGHo+QLIa0Ie2gIV0cTvhEEBqM/FZVEaLB5O8GJ0Tex8BKS9dDecwralL4BT2Hn2TrWiQTh2v8Dc0Mt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWeBQZS6I4ZIEtpvcHTrUdvwopt6fsghf+H95av97vE9AKdcMc
	Tu7zuCh53O9GrxLxS7RQZ2ae8dFls1INemnxR1gQG1LVCbhhQO0K
X-Gm-Gg: ASbGnctTrPGRPnq/Tv52uV9xHEZJ+A04EJbokgj70JUZSHrMOK2uK+O2L71Rirx/KnK
	pz0SqZGxjKxuPD3VLrLZUn9TwbsbwzjR3zx6LY6wOIp+DMzgOZOskF5jDzYliReJt5KvG36o1Oa
	XShpB9WRBEaCnfs8nc46Hdk7RgFJJNHjEV9rdk55B0IRftp3D+fgFBDdkGeCSt6kpntRW6eA4B5
	+NlOPy8mToIBfN+FhMF4BCcieHtcWC94Rjdzr7+JPZtz1vIAGEy2XZCboqTZ33pGLha5diCYPHt
	ZDylIHKpuL4cZYkUgFSrJ4N0BhhZ71UlZrZ5x2MK52HtMIkF3PX9aH4iWLHUqrC5zUfdwf7Giw=
	=
X-Google-Smtp-Source: AGHT+IGSQ+tL8exityeUlbvv4SpMRVaqA8svsB2n7yKfO0NqSfOKkUy2Q+FasL4CBbdegX3SVkWomw==
X-Received: by 2002:ac8:5a83:0:b0:476:a967:b247 with SMTP id d75a77b69052e-476c81de06dmr170303121cf.47.1742211787842;
        Mon, 17 Mar 2025 04:43:07 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:ac75:40f2:fdb1:31e5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb660e83sm53210431cf.38.2025.03.17.04.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 04:43:07 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 07:43:03 -0400
Subject: [PATCH] rust: uaccess: name the correct function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-uaccess-typo-reserve-v1-1-bbfcb45121f3@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMYK2GcC/x2M3QpAUBAGX0V7bYsjP3kVuTgdH/YGnUUk725zO
 TUzDymiQKlNHoo4RWVdDPI0oTD7ZQLLYEwuc2VW5DUfPgSo8n5vK0dYfoKbejShKlHBkaVbxCj
 Xv+369/0AgG/1o2YAAAA=
X-Change-ID: 20250317-uaccess-typo-reserve-87f20265e6e2
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Correctly refer to `reserve` rather than `try_reserve` in a comment.  This
comment has been incorrect since inception in commit 1b580e7b9ba2 ("rust:
uaccess: add userspace pointers").

Fixes: 1b580e7b9ba2 ("rust: uaccess: add userspace pointers")
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/uaccess.rs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index 719b0a48ff55..80a9782b1c6e 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -285,8 +285,7 @@ pub fn read_all<A: Allocator>(mut self, buf: &mut Vec<u8, A>, flags: Flags) -> R
         let len = self.length;
         buf.reserve(len, flags)?;
 
-        // The call to `try_reserve` was successful, so the spare capacity is at least `len` bytes
-        // long.
+        // The call to `reserve` was successful, so the spare capacity is at least `len` bytes long.
         self.read_raw(&mut buf.spare_capacity_mut()[..len])?;
 
         // SAFETY: Since the call to `read_raw` was successful, so the next `len` bytes of the

---
base-commit: cf25bc61f8aecad9b0c45fe32697e35ea4b13378
change-id: 20250317-uaccess-typo-reserve-87f20265e6e2

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>



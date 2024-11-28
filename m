Return-Path: <linux-kernel+bounces-424981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0069DBC0C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 19:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B510B21596
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 18:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F8A1C1ACF;
	Thu, 28 Nov 2024 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiC8pk6s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D576E823D1;
	Thu, 28 Nov 2024 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732816876; cv=none; b=mnjWRvSJfeW1XADVoo2q+hemgu3o8OKiv4Pz6BGUrw0C0tddgtmd7shP5LyoqL24h5bzfd79iGjg8u0htIyYD3n6OJiL147jSUfi0jSrIxd45xK2TbAyxR7C8s7XKZHpu7kT6gICAaMHyWkQTN6oWWeAdYkWYv46VjclUQ0QASA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732816876; c=relaxed/simple;
	bh=VGzkK9Cx19+Iy7XTjKQudNjexsmrszWcJ1wKOMd4NmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MQOAn5yj9CsTfdAsEjWL3V4hZSE2pjdIgzX5ICo7VCxJ/ALoBEEoxFiOc/sa/LfAONxkG5rDTGOvmLsBqzeb/gEzVPdu1USf4A50kZWXoZFY4OIfA4INfxKjSaW8Ka5zMxuaCfJlmZ0n8QqCGP17quBWMb/W/+1Xnn3IHrDrcQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiC8pk6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49D6AC4CECE;
	Thu, 28 Nov 2024 18:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732816874;
	bh=VGzkK9Cx19+Iy7XTjKQudNjexsmrszWcJ1wKOMd4NmI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=HiC8pk6sSX+uewaE3GlthXb85b3F6f2rAFw+XikhzwLM3KQtrsp+t1bAB2oK4+jd9
	 CsiUniYmZoYSxcziFvFPTH0gvq1sPMgYDapnfpYCaPmOT7rm7mI6BRCZt8tLrVXjiS
	 2KQuEUzFrNIORaT+zYsafva+NGndNYe5fze0bTReXmMq/zlG1gDJ+Nb0yfDHf7enuu
	 9ONRExsuZuxS8vKAVtDeHSXZPSRTuOG9mxCEl3ocarNVoG8ANPs1x2ZhibaDQyEoUm
	 G6CU49pxMcDO9hl2mKXdHhJojHVVqaSEESXcC9QlEpC/p4NzKM0/3c0nkM/+h0R63+
	 pi9nZKuS+9R+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23848D70DEB;
	Thu, 28 Nov 2024 18:01:14 +0000 (UTC)
From: Manas via B4 Relay <devnull+manas18244.iiitd.ac.in@kernel.org>
Date: Thu, 28 Nov 2024 23:31:01 +0530
Subject: [PATCH] scripts: checkpatch: add check for simplifying Result<()>
 in Rust
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-add-checkpatch-result-simplify-v1-1-973603191d71@iiitd.ac.in>
X-B4-Tracking: v=1; b=H4sIANyvSGcC/x3NQQqDMBBA0avIrB0wIZbUqxQXIZk0Q9WGjJaKe
 HeDy7f5/wChwiQwNAcU+rHwd6lQbQM+ueVNyKEadKeNUrpHFwL6RP6T3eoTFpJtWlF4zhPHHW2
 gaIx9dMY+oUZyocj/e/Aaz/MCOd8+qXAAAAA=
X-Change-ID: 20241125-add-checkpatch-result-simplify-8def44860489
To: Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>, 
 Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: Shuah Khan <skhan@linuxfoundation.org>, 
 Anup Sharma <anupnewsmail@gmail.com>, workflows@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Manas <manas18244@iiitd.ac.in>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732816872; l=2172;
 i=manas18244@iiitd.ac.in; s=20240813; h=from:subject:message-id;
 bh=Yhg0Ax2bzUaeocHIPB521o3yw72SKvbWMASGFnH7NM4=;
 b=7pdOmFPyTmRUpXH4SlrO2kU0eAmnIH4h6ivizmdAaUlwcZXhvpaFmQin5AAFXfxiqwxDAcvQK
 U27/BjXyUknCyY2ygzRyg/raLgXHDrGZc+SVGtL6d3jgsK4+cVnoyzR
X-Developer-Key: i=manas18244@iiitd.ac.in; a=ed25519;
 pk=pXNEDKd3qTkQe9vsJtBGT9hrfOR7Dph1rfX5ig2AAoM=
X-Endpoint-Received: by B4 Relay for manas18244@iiitd.ac.in/20240813 with
 auth_id=196
X-Original-From: Manas <manas18244@iiitd.ac.in>
Reply-To: manas18244@iiitd.ac.in

From: Manas <manas18244@iiitd.ac.in>

The type Result<()> can be rewritten simply as Result, as default type
parameters are unit `()` and `Error` types already. Thus keep usage of
`Result` consistent throughout codebase.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1128
Not-yet-signed-off-by: Manas <manas18244@iiitd.ac.in>
---
Note: The blockage due to my Signed-off-by tag is being resolved in
private. For now I am adding Not-yet-signed-off-by tag.
---
 Documentation/dev-tools/checkpatch.rst | 10 ++++++++++
 scripts/checkpatch.pl                  |  9 +++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index abb3ff6820766ee0c29112b256bcc44ce41fffba..7bf1fc7d4d7b490b32b8863365afe12a6732d6c1 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -1018,6 +1018,16 @@ Functions and Variables
 
       return bar;
 
+  **SIMPLIFIED_RESULT**
+    simplifies Result<()> in Rust codebase as Result because default type
+    parameters are unit and Error types::
+
+      fn foo(x: Result<()>) -> Result<()> {}
+
+    can be rewritten as::
+
+      fn foo(x: Result) -> Result {}
+
 
 Permissions
 -----------
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9eed3683ad76caffbbb2418e5dbea7551d374406..ddc943fd4a62d58cee92f8723e7634af4ca69e32 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3574,6 +3574,15 @@ sub process {
 			}
 		}
 
+# Check for Result<()> usage in Rust code
+    if ($realfile =~ /\.rs$/ &&
+        $sline =~ /^\+.*Result<\(\)>/) {
+      $check = 1;
+      if (CHK("SIMPLIFIED_RESULT", "Result<()> can be rewritten simply as Result\n" . $herecurr) && $fix) {
+        $fixed[$fixlinenr] =~ s/Result<\(\)>/Result/g;
+      }
+    }
+
 # ignore non-hunk lines and lines being removed
 		next if (!$hunk_line || $line =~ /^-/);
 

---
base-commit: 1dc707e647bc919834eff9636c8d00b78c782545
change-id: 20241125-add-checkpatch-result-simplify-8def44860489

Best regards,
-- 
Manas <manas18244@iiitd.ac.in>




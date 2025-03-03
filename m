Return-Path: <linux-kernel+bounces-544963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F41F0A4E9A1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873A18E3A11
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1814A29B217;
	Tue,  4 Mar 2025 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zot24OU+"
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77AF29614F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105766; cv=fail; b=P0TAu/0mc+zTF8HS4jmMUwSqav5IN0QhiVik+jX2IxIF4EQm42WyJO8NISbwUWpXkYgESFgnRY4vVK+i+rAeX7DYxmVeIDqtkkpVz6Exh4E6rvzH3bWuOB+pY9koJe0+pEkwTYouirPCSyhnmchF6J/IeEV8pOz/b92mcj3PP+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105766; c=relaxed/simple;
	bh=El90SxtaTrUNStwf60IvTjvawdEi0/pk+ae55w6rytc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G9vNzSHo+Fu3914EWgb9HJOueG2t0EG4Y/lozMlGLiOg04TED2eCICqdbcRsBt6VFWZrANotqzrd6wiLYVRanlhm7swuqO//zC0ZqB4Q67r6+Bl7otVEW4yil60+EhxS46u48jZrT9LyKxTp/6IiN43IHcV76mF7JzqbOUIY/40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zot24OU+ reason="signature verification failed"; arc=none smtp.client-ip=10.30.226.201; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id ED90840F1CEA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:29:22 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Zot24OU+
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6h156RFQzG3P0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:27:37 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 6C73E42721; Tue,  4 Mar 2025 19:27:27 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zot24OU+
X-Envelope-From: <linux-kernel+bounces-541278-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zot24OU+
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id D3A7C433EB
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:33:29 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 8DB6F2DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:33:29 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8410F170DA6
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851821F130D;
	Mon,  3 Mar 2025 09:33:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29D1EC4;
	Mon,  3 Mar 2025 09:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740994391; cv=none; b=NiPv1PwMB8LpO+QkLoMMgUM1clrRNYC677k2+6Ru9ESBDOZFIJ67FX2LJveO/m64vGhc15hXltOhFT/gzXoqDwcC4tTgFNUf3k+rBxEFQzAmVxcbDNGOKFiwRJuLyhRQwry/BBFBJebHbLro99Fey6JagYHRtQEfdO+YM+BAGK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740994391; c=relaxed/simple;
	bh=uxWb5weZnx4w75c+cNd9geof+3mOOtF83ztdgamkHZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bw8nVXWp3rynnNr5wgMScj+rpi0MXrSNlRY6bK6POlCnqDt0iwMlosR4r0uF9O8o3pISRLaP0zNU8wjjVLAlhvV1nnZQ6Qla7gGvpS8Juy0fQeY4lKZWzEErtXZfp5wdlx8lE6U8bUf5EkzWffj8GLaKseVMlNWSFofb2xktZko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zot24OU+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E6CC4CED6;
	Mon,  3 Mar 2025 09:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740994391;
	bh=uxWb5weZnx4w75c+cNd9geof+3mOOtF83ztdgamkHZc=;
	h=From:To:Cc:Subject:Date:From;
	b=Zot24OU+Kr3IVKlNxS8Ms3Pi6PvMwu9DHSIsqRFgjxP7aaO6HBF+zxguPxwkhaO2a
	 xrdRh9uBrtzK+Ykgl393iwGLK8grS93jXMrw/M0Jj0oWxBTRY58YtHO+mmTaRseX2I
	 bwx01tB5PVV+suC6VLbWhT09Tqr1VNPpdd3/9dK4QlGfahn05Hh3Kp5xbqtzv3xwhm
	 O65rL/CJBPtzWDzv1AOWI5Q5YPz+w3dHiYps7UNc3zVcLGycvh5U026fbDNLbGuWdj
	 Bnj8SfZx8IFw+vKyH2xq2DVorZGK5IOZDXsua4NUVPxKkq4g9T8Y1Rw4H+/nn9pxqK
	 tcLnUaY4LNqEQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: Jocelyn Falempe <jfalempe@redhat.com>,
	=?UTF-8?q?Thomas=20B=C3=B6hler?= <witcher@wiredspace.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH] drm/panic: clean Clippy warning
Date: Mon,  3 Mar 2025 10:32:42 +0100
Message-ID: <20250303093242.1011790-1-ojeda@kernel.org>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6h156RFQzG3P0
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-SpamScore: sssss
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741710471.43906@LHV8BuHuukxeemQ/egMEvg
X-ITU-MailScanner-SpamCheck: spam

Clippy warns:

    error: manual implementation of an assign operation
       --> drivers/gpu/drm/drm_panic_qr.rs:418:25
        |
    418 |                         self.carry =3D self.carry % pow;
        |                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ help: rep=
lace it with: `self.carry %=3D pow`
        |
        =3D help: for further information visit https://rust-lang.github.=
io/rust-clippy/master/index.html#assign_op_pattern

Thus clean it up.

Fixes: dbed4a797e00 ("drm/panic: Better binary encoding in QR code")
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 drivers/gpu/drm/drm_panic_qr.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_=
qr.rs
index 62cb8a162483..3b0dd59781d4 100644
--- a/drivers/gpu/drm/drm_panic_qr.rs
+++ b/drivers/gpu/drm/drm_panic_qr.rs
@@ -415,7 +415,7 @@ fn next(&mut self) -> Option<Self::Item> {
                         self.carry_len -=3D out_len;
                         let pow =3D u64::pow(10, self.carry_len as u32);
                         let out =3D (self.carry / pow) as u16;
-                        self.carry =3D self.carry % pow;
+                        self.carry %=3D pow;
                         Some((out, NUM_CHARS_BITS[out_len]))
                     }
                 }

base-commit: c0eb65494e59d9834af7cbad983629e9017b25a1
--=20
2.48.1




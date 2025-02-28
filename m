Return-Path: <linux-kernel+bounces-538776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E22A49CF4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6023BBB87
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB83C276045;
	Fri, 28 Feb 2025 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCF8J9u1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B681EF38B;
	Fri, 28 Feb 2025 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755495; cv=none; b=D4/55hxDpXXciPQoJmJnPi0/0trHCxE7Lx1vUqjpoF0QOtoli4lQdlPgtyQqkM60YBngZEimkzbiB4a9TtVyA3gizQEkBeXp1axw9IFF/rr/0Xku5cSTKZ/hEoGKtKjJ5ySUAN7E5u1hq6ucxGO2sUXIu+Rp8Q+Sim6NAZM1Azg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755495; c=relaxed/simple;
	bh=9ZJqhfxxUVKNn9pQ4sEtXI4UMBqewViPBr/PTvTjPN4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OBS/ksDGdZiZTyWeAPyf2iRDWZkLmXDLXYGm93bNKas6iDzOIPJxrzmYb2NZYmFIR1DfbTSwa4zRjLq42O0PmD+tBZKVhDt5dTfitrVRYpp9SD6V8T5bXtud8eKuHRxTU13ho5Tyemc3Sl9nw/7XDqY0ES3Ykn8eKy6KXabO/D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCF8J9u1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26C7AC4CEED;
	Fri, 28 Feb 2025 15:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740755495;
	bh=9ZJqhfxxUVKNn9pQ4sEtXI4UMBqewViPBr/PTvTjPN4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cCF8J9u1MMhIxliRHBG9j3Ogm5sTJcKO6u/9GgChK0cvg5l7FLen9lBwWGPssBj53
	 y2fS0CB842jWuJmQoq0LRT7bOIAXom6LJ6hdrKCnEEiGMS1o6NljHl9jpd+Hg9xTt0
	 Exb4NnnXvzBjFidHpNmc5lJroDc2LYBi8wgUfsiWBvd2h/eKjcHFYJiiS7NeG2I1DN
	 T4TNqGxA03Klhfr6YOIkJoRs58YmYtZa9ot4hI0Ou3DfCXcQ6QJA6svXPavyjL7tEw
	 dqdb6qKP03fW9C+8gIuezxzYcyFHH+0U5WoqP9U5TSQkowUwnYX41e2aRW5vQ+nnRw
	 oHPK0+Btj/AuA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB20C282D0;
	Fri, 28 Feb 2025 15:11:35 +0000 (UTC)
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 28 Feb 2025 16:11:23 +0100
Subject: [PATCH v3 8/9] usb: storage: sddr55: Use const for constant arrays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250228-misc-const-v3-8-09b417ded9c4@posteo.net>
References: <20250228-misc-const-v3-0-09b417ded9c4@posteo.net>
In-Reply-To: <20250228-misc-const-v3-0-09b417ded9c4@posteo.net>
To: Alan Stern <stern@rowland.harvard.edu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740755487; l=1301;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=dyKVA5pPyRY7TuBL1KemWvR3umAVS5JkAQpDbS4Ydg8=;
 b=BA2AmNdIfge2Df+JYGIJv5vw589dHvWjgpw9g3g4XAmSw0hlylN9Cwos695Ecbek4xyDO25CK
 YPc4LO4ulNyCW2RrB7XQ6aT4rULx/eUV2vZE8BRKGz3BpojbZOU/8sn
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: Jonathan Neuschäfer <j.ne@posteo.net>

These arrays are only read, not modified.

Declaring data as const makes it easier to see what's going on, and can
prevent unintended writes through placement in a read-only section.

Signed-off-by: Jonathan Neuschäfer <j.ne@posteo.net>
---

V3:
- elaborate why const is a good idea

V2:
- new patch
---
 drivers/usb/storage/sddr55.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/storage/sddr55.c b/drivers/usb/storage/sddr55.c
index d5cdff30f6f31f98d3d58ffcdd2426d7cd385cbb..b323f0a3626031905b946ce64ddf04539a6e3232 100644
--- a/drivers/usb/storage/sddr55.c
+++ b/drivers/usb/storage/sddr55.c
@@ -775,11 +775,11 @@ static void sddr55_card_info_destructor(void *extra) {
 static int sddr55_transport(struct scsi_cmnd *srb, struct us_data *us)
 {
 	int result;
-	static unsigned char inquiry_response[8] = {
+	static const unsigned char inquiry_response[8] = {
 		0x00, 0x80, 0x00, 0x02, 0x1F, 0x00, 0x00, 0x00
 	};
  	// write-protected for now, no block descriptor support
-	static unsigned char mode_page_01[20] = {
+	static const unsigned char mode_page_01[20] = {
 		0x0, 0x12, 0x00, 0x80, 0x0, 0x0, 0x0, 0x0,
 		0x01, 0x0A,
 		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

-- 
2.48.0.rc1.219.gb6b6757d772




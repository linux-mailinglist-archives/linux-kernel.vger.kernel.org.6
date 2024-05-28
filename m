Return-Path: <linux-kernel+bounces-192223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EDE8D1A49
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76EA9B26066
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B4716C856;
	Tue, 28 May 2024 11:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUNRaBey"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF40A16ABC1
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897126; cv=none; b=WvB42MZie09y/bOV4mPXBgEezxe1QTSZKqv27JoeQaq9DHcRJ3IiSCq4lhh78DaWEJkIZNLwl1CjcEPtyJDCbsRG4fQnbTumU2IBm7Z5QBwuB/BY/aTHa5JvVLEtNebglXHIiUdyq/CdklH1FIJNVZp3ECiLqsejEe55R4bVhOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897126; c=relaxed/simple;
	bh=TcxjokVtWXmJOGhnJW9abbtWL0y6hS0Uwog6v9HcmCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o6tlIjSZd9rFlwDjd9FWMC7ZtSxr6LbQE3YB09bBKFrXwWpMCbU2etrLFsF3Odd1ZXrhSjZ2/zZvejB1Cx3JCz3drnEUEmqLhAXelIR2dH5GtxZzZUby3xQh04djlCiBpTa6GDWKnp6GdwRZ7xWh804RvpdDskpB5iWfK3ql8JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUNRaBey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F038C32782;
	Tue, 28 May 2024 11:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716897125;
	bh=TcxjokVtWXmJOGhnJW9abbtWL0y6hS0Uwog6v9HcmCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AUNRaBeyx6rMagKw2XMqLf9UxVbVUCTU2rz+d4rU4OCqWKbmh5yZKOeCTs6WLWIE0
	 DZTfDaO43bdToSAa9iTrSUiL8kN6YtVzvgiRhYsxN5MTAEdf/0xSLI3xh6N6sDT9g6
	 HGUmkVieB7F5nkqMDWqn5t82+8xOjPQJ1oaexjat73SuPNkBc+4Yh/jZwZ1u3xeDxo
	 ZWInPMfjVS6gn1zkEmqaXBrNQLCu2aWuHvqzTHBYQnwRo45PfdxW86GYzN0tNMqvqN
	 q77+16Lt9PwE7NVgG0TGTg0/9+IgY6NjTaey2/yGcr2KpcRjlIeXqlz5B+07KCe7PW
	 8XiA2fM2c7dmQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Roman Li <roman.li@amd.com>,
	Mounika Adhuri <moadhuri@amd.com>,
	Martin Leung <martin.leung@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] [RESEND] drm/amd/display: fix graphics_object_id size
Date: Tue, 28 May 2024 13:51:19 +0200
Message-Id: <20240528115146.2870032-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240528115146.2870032-1-arnd@kernel.org>
References: <20240528115146.2870032-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The graphics_object_id structure is meant to fit into 32 bits, as it's
passed by value in and out of functions. A recent change increased
the size to 128 bits, so it's now always passed by reference, which
is clearly not intended and ends up producing a compile-time warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_factory.c: In function 'construct_phy':
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_factory.c:743:1: error: the frame size of 1040 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

Add back the bitfields to revert to the original size, while keeping
the 'enum' type change.

fec85f995a4b ("drm/amd/display: Fix compiler redefinition warnings for certain configs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Originally sent as https://lore.kernel.org/all/20240418083421.3956461-2-arnd@kernel.org/
---
 drivers/gpu/drm/amd/display/include/grph_object_id.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/include/grph_object_id.h b/drivers/gpu/drm/amd/display/include/grph_object_id.h
index 08ee0350b31f..54e33062b3c0 100644
--- a/drivers/gpu/drm/amd/display/include/grph_object_id.h
+++ b/drivers/gpu/drm/amd/display/include/grph_object_id.h
@@ -226,8 +226,8 @@ enum dp_alt_mode {
 
 struct graphics_object_id {
 	uint32_t  id:8;
-	enum object_enum_id  enum_id;
-	enum object_type  type;
+	enum object_enum_id  enum_id :4;
+	enum object_type  type :4;
 	uint32_t  reserved:16; /* for padding. total size should be u32 */
 };
 
-- 
2.39.2



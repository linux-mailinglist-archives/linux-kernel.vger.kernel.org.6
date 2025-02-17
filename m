Return-Path: <linux-kernel+bounces-510766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 244E0A321A3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBAD616449A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82797205AB1;
	Wed, 12 Feb 2025 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfWFGAgX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BCD1E7C07;
	Wed, 12 Feb 2025 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739350894; cv=none; b=n0JELsx5Uo6RNYJiFP4ygHsFfOu/9Uy/bw4KJxQA5RHomhUo3wPastsceCqeo4VJ4TUzBxJ5MXVQS9nCkTscay1k1EEnl39rWz1N1raHeXngGvwEVfl+ejaSYG/Rej8Ah2qAESf2wdsEmQFOAOaXG2RPPIBjJNbHNyLwdmsoJDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739350894; c=relaxed/simple;
	bh=3/UIVXsG7x9oAteqLxLTRTxpjiQwjEFuHlky2GH5oyM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uRvSQp45jqKaW/bMIHYxFAgdcyrzwhkgsIHEvThOxnS70hoc6Pff14ZQfN/KxkpevdC7knUxW2LrFBSfYFDpbjd1IGP0SdI43aGqY2kcSLY7mbyTnoE9pu+iS7Tq7Ixb5lx//8omF/c685zKFM1CBY0cV4YLOR7EMaU3Ajsk18U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfWFGAgX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605CEC4CEDF;
	Wed, 12 Feb 2025 09:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739350894;
	bh=3/UIVXsG7x9oAteqLxLTRTxpjiQwjEFuHlky2GH5oyM=;
	h=Date:From:To:Cc:Subject:From;
	b=jfWFGAgX6WCuUqsFUu1z/EWkSY3Sufm5KvM3olaizPHZ25m6I0e++p6xESyDH/Tjd
	 wZkNWC62tBTZYHeQkZ7XDaq2qAZ4uIc+LJpoXSKrKKkje36jPnyF5nhtAcVx1IScPi
	 P61NQKPr7DM5tiMalx7eMlIz9KtO5yz5T4mm3dXOaD4TG2TLKBKeEaQW18adUWoMRc
	 EErOdFjq1WHl4zB32n+Vyt7GpSe2mqqOIh/pxpbvQghZG+bM4Cf/H5fYN/c18fuWpK
	 xGPe4iLGH/O4QNbYtiH/xq+sEvrbnNppnWXk+uqrT/HZ5kmCKIWZ5v4ewxz9OzFzo1
	 mWMZ8TGKsTHsg==
Date: Wed, 12 Feb 2025 19:31:26 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] drm/nouveau: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z6xjZhHxRp4Bu_SX@kspp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

So, in order to avoid ending up with flexible-array members in the
middle of other structs, we use the `struct_group_tagged()` helper
to separate the flexible arrays from the rest of the members in the
flexible structures. We then use the newly created tagged `struct
nvif_ioctl_v0_hdr` and `struct nvif_ioctl_mthd_v0_hdr` to replace the
type of the objects causing trouble in multiple structures.

We also want to ensure that when new members need to be added to the
flexible structures, they are always included within the newly created
tagged structs. For this, we use `static_assert()`. This ensures that the
memory layout for both the flexible structure and the new tagged struct
is the same after any changes.

So, with these changes, fix the following warnings:
drivers/gpu/drm/nouveau/nvif/object.c:60:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/gpu/drm/nouveau/nvif/object.c:233:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/gpu/drm/nouveau/nvif/object.c:214:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/gpu/drm/nouveau/nvif/object.c:152:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/gpu/drm/nouveau/nvif/object.c:138:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/gpu/drm/nouveau/nvif/object.c:104:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/gpu/drm/nouveau/nouveau_svm.c:83:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/gpu/drm/nouveau/nouveau_svm.c:82:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/nouveau/include/nvif/ioctl.h | 32 +++++++++++++-------
 drivers/gpu/drm/nouveau/nouveau_svm.c        |  4 +--
 drivers/gpu/drm/nouveau/nvif/object.c        | 12 ++++----
 3 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/include/nvif/ioctl.h b/drivers/gpu/drm/nouveau/include/nvif/ioctl.h
index e825c8a1d9ca..00015412cb3e 100644
--- a/drivers/gpu/drm/nouveau/include/nvif/ioctl.h
+++ b/drivers/gpu/drm/nouveau/include/nvif/ioctl.h
@@ -3,25 +3,30 @@
 #define __NVIF_IOCTL_H__
 
 struct nvif_ioctl_v0 {
-	__u8  version;
+	/* New members MUST be added within the struct_group() macro below. */
+	struct_group_tagged(nvif_ioctl_v0_hdr, __hdr,
+		__u8  version;
 #define NVIF_IOCTL_V0_SCLASS                                               0x01
 #define NVIF_IOCTL_V0_NEW                                                  0x02
 #define NVIF_IOCTL_V0_DEL                                                  0x03
 #define NVIF_IOCTL_V0_MTHD                                                 0x04
 #define NVIF_IOCTL_V0_MAP                                                  0x07
 #define NVIF_IOCTL_V0_UNMAP                                                0x08
-	__u8  type;
-	__u8  pad02[4];
+		__u8  type;
+		__u8  pad02[4];
 #define NVIF_IOCTL_V0_OWNER_NVIF                                           0x00
 #define NVIF_IOCTL_V0_OWNER_ANY                                            0xff
-	__u8  owner;
+		__u8  owner;
 #define NVIF_IOCTL_V0_ROUTE_NVIF                                           0x00
 #define NVIF_IOCTL_V0_ROUTE_HIDDEN                                         0xff
-	__u8  route;
-	__u64 token;
-	__u64 object;
+		__u8  route;
+		__u64 token;
+		__u64 object;
+	);
 	__u8  data[];		/* ioctl data (below) */
 };
+static_assert(offsetof(struct nvif_ioctl_v0, data) == sizeof(struct nvif_ioctl_v0_hdr),
+	      "struct member likely outside of struct_group()");
 
 struct nvif_ioctl_sclass_v0 {
 	/* nvif_ioctl ... */
@@ -51,12 +56,17 @@ struct nvif_ioctl_del {
 };
 
 struct nvif_ioctl_mthd_v0 {
-	/* nvif_ioctl ... */
-	__u8  version;
-	__u8  method;
-	__u8  pad02[6];
+	/* New members MUST be added within the struct_group() macro below. */
+	struct_group_tagged(nvif_ioctl_mthd_v0_hdr, __hdr,
+		/* nvif_ioctl ... */
+		__u8  version;
+		__u8  method;
+		__u8  pad02[6];
+	);
 	__u8  data[];		/* method data (class.h) */
 };
+static_assert(offsetof(struct nvif_ioctl_mthd_v0, data) == sizeof(struct nvif_ioctl_mthd_v0_hdr),
+	      "struct member likely outside of struct_group()");
 
 struct nvif_ioctl_map_v0 {
 	/* nvif_ioctl ... */
diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index b4da82ddbb6b..fc64c3d3169e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -79,8 +79,8 @@ struct nouveau_svm {
 #define SVM_ERR(s,f,a...) NV_WARN((s)->drm, "svm: "f"\n", ##a)
 
 struct nouveau_pfnmap_args {
-	struct nvif_ioctl_v0 i;
-	struct nvif_ioctl_mthd_v0 m;
+	struct nvif_ioctl_v0_hdr i;
+	struct nvif_ioctl_mthd_v0_hdr m;
 	struct nvif_vmm_pfnmap_v0 p;
 };
 
diff --git a/drivers/gpu/drm/nouveau/nvif/object.c b/drivers/gpu/drm/nouveau/nvif/object.c
index 0b87278ac0f8..70af63d70976 100644
--- a/drivers/gpu/drm/nouveau/nvif/object.c
+++ b/drivers/gpu/drm/nouveau/nvif/object.c
@@ -57,7 +57,7 @@ int
 nvif_object_sclass_get(struct nvif_object *object, struct nvif_sclass **psclass)
 {
 	struct {
-		struct nvif_ioctl_v0 ioctl;
+		struct nvif_ioctl_v0_hdr ioctl;
 		struct nvif_ioctl_sclass_v0 sclass;
 	} *args = NULL;
 	int ret, cnt = 0, i;
@@ -101,7 +101,7 @@ int
 nvif_object_mthd(struct nvif_object *object, u32 mthd, void *data, u32 size)
 {
 	struct {
-		struct nvif_ioctl_v0 ioctl;
+		struct nvif_ioctl_v0_hdr ioctl;
 		struct nvif_ioctl_mthd_v0 mthd;
 	} *args;
 	u32 args_size;
@@ -135,7 +135,7 @@ void
 nvif_object_unmap_handle(struct nvif_object *object)
 {
 	struct {
-		struct nvif_ioctl_v0 ioctl;
+		struct nvif_ioctl_v0_hdr ioctl;
 		struct nvif_ioctl_unmap unmap;
 	} args = {
 		.ioctl.type = NVIF_IOCTL_V0_UNMAP,
@@ -149,7 +149,7 @@ nvif_object_map_handle(struct nvif_object *object, void *argv, u32 argc,
 		       u64 *handle, u64 *length)
 {
 	struct {
-		struct nvif_ioctl_v0 ioctl;
+		struct nvif_ioctl_v0_hdr ioctl;
 		struct nvif_ioctl_map_v0 map;
 	} *args;
 	u32 argn = sizeof(*args) + argc;
@@ -211,7 +211,7 @@ void
 nvif_object_dtor(struct nvif_object *object)
 {
 	struct {
-		struct nvif_ioctl_v0 ioctl;
+		struct nvif_ioctl_v0_hdr ioctl;
 		struct nvif_ioctl_del del;
 	} args = {
 		.ioctl.type = NVIF_IOCTL_V0_DEL,
@@ -230,7 +230,7 @@ nvif_object_ctor(struct nvif_object *parent, const char *name, u32 handle,
 		 s32 oclass, void *data, u32 size, struct nvif_object *object)
 {
 	struct {
-		struct nvif_ioctl_v0 ioctl;
+		struct nvif_ioctl_v0_hdr ioctl;
 		struct nvif_ioctl_new_v0 new;
 	} *args;
 	int ret = 0;
-- 
2.43.0



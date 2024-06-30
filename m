Return-Path: <linux-kernel+bounces-235352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C3591D46C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1201C1F2132E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034558287A;
	Sun, 30 Jun 2024 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="o451Qel7"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9D6824BD
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786585; cv=none; b=cxxQE2po+zq9N+UtHimMYzD/gEoYGNxKJ2rRGlp/ltdVMd1135Np00BrzoDH06nFUFCvxbnBdOFLXWB2QKABvbu6ZnPaiEGkpwqT/6EDElJHSVxWDX0a/5QBgWqr2+tFxFycUPEmfgMC9heyeKoOUui+FB842BT+GJWlL8eJNYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786585; c=relaxed/simple;
	bh=dDiGBPCAQEK/rp6dQdTV7xtINLfjg+YnC8BV9wYuO2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlZORMqsOMa6F7ABRQI+tz3dqc80I3cW5Opv+QgSML7QQbKoC/9xC5mFr6E6lkrtOtivKBEQPwE0JAD1PDAWsYeKNGsYTCELhxlV54nf/0c3mjBGsaDBkM9wQvvJQ3UJe3Vt50P9qJjrGMcvlX36KuPhT4omFT67rJrHW4cdoyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=o451Qel7; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3kv2v4Tzll9fK;
	Sun, 30 Jun 2024 22:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786579; x=1722378580; bh=9aCrw
	KWni5rvLaQGrIw3vS4S/k4RbwUh+dOx+o3MTw8=; b=o451Qel7z7Sbs7psTVIY7
	ksv9+t44lOLJqQ8AEhmki5EyAxUwDI5I/epIxLT1KkBqUY4rAyVK4ZxZh01IhS+i
	SCCqejC3xz1wG5O5mGcb52fEI74R3H+zTnK4QBe2hnU9dtU05gIYXOCN1q90bXz+
	NeFyiNKvtAmN1S+DhWgxOwG/0x0C6LkzkrpuLAmMEMKB2sSZdhypoUQpsp3OrMR/
	A1QB7e58whB0jILXvK/l3q6jWulHoCEMjaYwrzNHz8LTkW0P7TnHw1x8xzWZxjpv
	ZbBErvSeEATle8ieU2nxYhnHiRjwyCftlFFSnR9gzeODRuWAM9UBO3a7+6V/kOyZ
	A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Rs2RHDQyKnIM; Sun, 30 Jun 2024 22:29:39 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3kl00WFzll9f8;
	Sun, 30 Jun 2024 22:29:34 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Sunil Khatri <sunil.khatri@amd.com>,
	Shashank Sharma <shashank.sharma@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Subject: [PATCH 03/53] drm/amdgpu: Switch to create*_workqueue2()
Date: Sun, 30 Jun 2024 15:26:21 -0700
Message-ID: <20240630222904.627462-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240630222904.627462-1-bvanassche@acm.org>
References: <20240630222904.627462-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for removal of the create*_workqueue() macros.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_reset.c
index ea4873f6ccd1..6ed3af1286fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -131,7 +131,7 @@ struct amdgpu_reset_domain *amdgpu_reset_create_reset=
_domain(enum amdgpu_reset_d
 	reset_domain->type =3D type;
 	kref_init(&reset_domain->refcount);
=20
-	reset_domain->wq =3D create_singlethread_workqueue(wq_name);
+	reset_domain->wq =3D create_singlethread_workqueue2("%s", wq_name);
 	if (!reset_domain->wq) {
 		DRM_ERROR("Failed to allocate wq for amdgpu_reset_domain!");
 		amdgpu_reset_put_reset_domain(reset_domain);


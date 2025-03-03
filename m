Return-Path: <linux-kernel+bounces-541934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F450A4C394
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30E967A1AA1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662FD2135CB;
	Mon,  3 Mar 2025 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="rlZZuBnk"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1731FAC4D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012772; cv=none; b=ss0yK/wys7cgYlgZQmGF5fwa2n80lVrx3+GXPmSEdhra6oekuKdGO3GMUDOZcxiQCNWqePBca6XX2Mlqpj/vpHC+5gfSPFTVl+fN79cxEkiEmaZVXwyPdIPFxPo1kCkKHRXwzkWK6Qtc6F1pBBht7+FR8KUyZVF56sTfuARn09U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012772; c=relaxed/simple;
	bh=lAs3NA0uKrcszg6+DqY96fPmkb6rDQ24C4lgsIDav1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFVtUt4mjfDI96TPGrR2zE9A5RSYGavhXh6yG4RxrtWrfDlosTp8/OXxKWla7A1yn1amLnBclaBQW6ArnEuwxNXJQ9wHM61gcuVZphj9LmWy3o+rwtMCj0uMQvgTcdqouljbOavrXcnRviT4Jbp4H+xeBka9I2tEZHK02d+qaM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=rlZZuBnk; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=txe/FCPWRDijIRM2J14dylswI3oOXHv8ky3SGbNbIgE=; b=rlZZuBnkzyt7ZRBK
	UJhcYmaIGcN34uExHJWZiEVDTy9IHDpVje+oEdAM8PhH79alsdHMRT+fVVpuaIE6DLYc5Sfjvm1kF
	4KnE766bfqoojTDSnSvfGxO3PvF9m81LqFUhnC0MzyJ5Nr4Jvz1zLkpDqlQD8siA2+MQ6GDv7t7gF
	weVDLqeVVmJ81AHpd+7B6nWuCReFEqgHK3VMuqtya3eXvRUmQojn2mqc8NNe8lg+SpBc1WsYkdL35
	ZnJLQcs8xYs9yYmVpxqj2tGOl5axCuxNh78fHJc5OEw4nyaZBpVGMEjNkOghGporvJ5NTH9uxq5VD
	O6QuHGamPTtU2PirEg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tp6x5-0028PG-1c;
	Mon, 03 Mar 2025 14:39:27 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	austin.zheng@amd.com,
	jun.lei@amd.com,
	kenneth.feng@amd.com,
	linux-kernel@vger.kernel.org
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 5/6] drm/amdgpu: Remove unused print__rq_dlg_params_st
Date: Mon,  3 Mar 2025 14:39:21 +0000
Message-ID: <20250303143922.36342-6-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303143922.36342-1-linux@treblig.org>
References: <20250303143922.36342-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

print__rq_dlg_params_st() was added in 2017 by
commit 061bfa06a42a ("drm/amdgpu/display: Add dml support for DCN")
but has remained unused.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../drm/amd/display/dc/dml/display_rq_dlg_helpers.c   | 11 -----------
 .../drm/amd/display/dc/dml/display_rq_dlg_helpers.h   |  1 -
 2 files changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c b/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c
index 412e75eb4704..12ff65b6a7e5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c
@@ -122,17 +122,6 @@ void print__data_rq_misc_params_st(struct display_mode_lib *mode_lib, const stru
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 }
 
-void print__rq_dlg_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_rq_dlg_params_st *rq_dlg_param)
-{
-	dml_print("DML_RQ_DLG_CALC: =====================================\n");
-	dml_print("DML_RQ_DLG_CALC: DISPLAY_RQ_DLG_PARAM_ST\n");
-	dml_print("DML_RQ_DLG_CALC:  <LUMA>\n");
-	print__data_rq_dlg_params_st(mode_lib, &rq_dlg_param->rq_l);
-	dml_print("DML_RQ_DLG_CALC:  <CHROMA>\n");
-	print__data_rq_dlg_params_st(mode_lib, &rq_dlg_param->rq_c);
-	dml_print("DML_RQ_DLG_CALC: =====================================\n");
-}
-
 void print__dlg_sys_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_dlg_sys_params_st *dlg_sys_param)
 {
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.h b/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.h
index ebcd717744e5..2bc64c4081dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.h
@@ -35,7 +35,6 @@ void print__rq_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dp
 void print__data_rq_sizing_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_data_rq_sizing_params_st *rq_sizing);
 void print__data_rq_dlg_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_data_rq_dlg_params_st *rq_dlg_param);
 void print__data_rq_misc_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_data_rq_misc_params_st *rq_misc_param);
-void print__rq_dlg_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_rq_dlg_params_st *rq_dlg_param);
 void print__dlg_sys_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_dlg_sys_params_st *dlg_sys_param);
 
 void print__data_rq_regs_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_data_rq_regs_st *rq_regs);
-- 
2.48.1



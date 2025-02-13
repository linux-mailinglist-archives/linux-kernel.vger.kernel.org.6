Return-Path: <linux-kernel+bounces-513869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2678DA34FA6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C194164F58
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF402661B8;
	Thu, 13 Feb 2025 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XbvIBsV6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDBA245B0B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739479492; cv=none; b=Wp+i80KZ/2ZC4mb6O0AJaIqFmg3y5kFsrNeajqeYUQDpeYkwY2uTG44rk7QUdE1I/bQHzrFVybyZZNPFW54dUS0i6uS53SFFwki7bJYL20CUs45w0yipaOpnjZ7uZTMvahSwo/TfXODYWu7hlhN5SU2OybSbrTn1dTjbFUN9xGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739479492; c=relaxed/simple;
	bh=QzprqE2C44X1KOE0XUFJu13L65fC6w2iGs4m83Aba5Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eTyfH07qJaiIJpfUEa6//DpzHD0J9+p++O761U1Cf+YN3Zvr+rGeVovIMwHC87qZtYQJizZQ+j8Ugx0WwyKXFVLyxPh8Yv4Lv6aTR0duzrXvD70yS0y6d/OzHgnp/yWQOwgFoqPwE7zEKSfzsRb3rwy2JrVUNz8DlgD9IPAgLqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XbvIBsV6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739479489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=isX0Zk53fvD6JFbwdZ7+vlVS1AxCy9ofy9qp1lQ7s44=;
	b=XbvIBsV6y4K3oatLQFkxNykxuDrTk+yo1U5xc+9Isbw/UmG6C7R7Q7CZ61sSF4t695MZ85
	MqVjor4JsdZfuNJgc+6KMPgDA86P/Hz0lLN9PWHbFdG6K1LUtVVyaN3AhvMXrQFj+u7KCc
	QPmHvMpnwTQufYIUHsKRusIAhQh+Cu4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-FeOJ-VlJOyKinyXcffKzwg-1; Thu,
 13 Feb 2025 15:44:45 -0500
X-MC-Unique: FeOJ-VlJOyKinyXcffKzwg-1
X-Mimecast-MFC-AGG-ID: FeOJ-VlJOyKinyXcffKzwg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24F121800983;
	Thu, 13 Feb 2025 20:44:42 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.199])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A2CA919373D9;
	Thu, 13 Feb 2025 20:44:36 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Subject: [PATCH 00/20] drm/panel: Move to using mipi_dsi_*_multi() variants
 when available
Date: Thu, 13 Feb 2025 15:44:17 -0500
Message-Id: <20250213-mipi_cocci_multi-v1-0-67d94ff319cc@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKJZrmcC/x3MSQqAMBAF0atIrw0k7bDwKiIibasfnEhUBPHuB
 pdvUfVQUA8NVCUPeb0QsK0RLk1Ipm4d1aCPJrZcWHbOLNjRyiaCdjnnAybPbTe4grNSmGK2ex1
 w/8u6ed8PNreHA2IAAAA=
X-Change-ID: 20250211-mipi_cocci_multi-440af15236c2
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Joel Selvaraj <jo@jsfamily.in>, Ondrej Jirman <megi@xff.cz>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Jianhua Lu <lujianhua000@gmail.com>, Robert Chiras <robert.chiras@nxp.com>, 
 Artur Weber <aweber.kernel@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Anusha Srivatsa <asrivats@redhat.com>, 
 Douglas Anderson <dianders@chromium.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739479476; l=5140;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=QzprqE2C44X1KOE0XUFJu13L65fC6w2iGs4m83Aba5Y=;
 b=FWW8woLXHn1vwdB+32n46DbnFsZH/tGlb3sef4LNzA13nGgkrQx/Afi6wPKkoZHUWYMv83ZMM
 gqzGJ1wEm+gAjjv+0zsf2sxleeFS1ZES9GuhwspX38TMvRSV1h5IDmD
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

A lot of mipi API are deprecated and have a _multi() variant
which is the preferred way forward. This covers  TODO in the
gpu Documentation:[1]

An incomplete effort was made in the previous version
to address this[2]. It removed on the mipi_dsi_dcs_write_seq()
and mipi_dsi_generic_write_seq_multi() with the respective
replacemts and not the rest of the API.

The Coccinelle patch used to mkae changes:
@rule_1@
expression dsi_var;
expression list es;
identifier jdi;
@@
static int jdi_write_dcdc_registers(struct jdi_panel *jdi)
{
+struct mipi_dsi_multi_context dsi_ctx1 = { .dsi = jdi->link1 };
+struct mipi_dsi_multi_context dsi_ctx2 = { .dsi = jdi->link2 };
<+...
-mipi_dsi_generic_write_seq(jdi->link1,es);
+mipi_dsi_generic_write_seq_multi(&dsi_ctx1,es);
-mipi_dsi_generic_write_seq(jdi->link2,es);
+mipi_dsi_generic_write_seq_multi(&dsi_ctx2,es);
...+>
}

@rule_2@
expression dsi_var;
expression list es;
identifier jdi;
@@
struct mipi_dsi_device *dsi0 = pinfo->dsi[0];
struct mipi_dsi_device *dsi1 = pinfo->dsi[1];
+struct mipi_dsi_multi_context dsi_ctx0 = { .dsi = dsi0 };
+struct mipi_dsi_multi_context dsi_ctx1 = { .dsi = dsi1 };
<+...
-mipi_dsi_dual_dcs_write_seq(dsi0, dsi1, es);
+mipi_dsi_dual_dcs_write_seq(dsi_ctx0, dsi_ctx1, es);
...+>

@rule_3@
identifier func;
identifier r;
type t;
expression list es;
position p;
@@
t func(...) {
<+...
(
-mipi_dsi_dcs_write_seq(dsi_var,es);
+mipi_dsi_dcs_write_seq_multi(&dsi_ctx,es);
|
-r = mipi_dsi_dcs_exit_sleep_mode(jdi->link1)@p;
+mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx1);
|
-r = mipi_dsi_dcs_enter_sleep_mode(jdi->link1)@p;
+mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx1);
|
-r = mipi_dsi_dcs_set_display_off(jdi->link1)@p;
+mipi_dsi_dcs_set_display_off_multi(&dsi_ctx1);
|
.....//rest of the mipi APIs with _multi variant
)
<+...
-if(r < 0) {
-...
-}
...+>

[1] -> https://docs.kernel.org/gpu/todo.html#transition-away-from-using-mipi-dsi-write-seq
[2] -> https://patchwork.freedesktop.org/series/144446/

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
Anusha Srivatsa (20):
      drm/panel/xpp055c272: Move to using mipi_dsi_*_multi() variants
      drm/panel/visionox-r66451: Move to using mipi_dsi_*_multi() variants
      drm/panel/asus-tm5p5-n35596: Move to using mipi_dsi_*_multi() variants
      drm/panel/boe-bf060y8m-aj0: Move to using mipi_dsi_*_multi() variants
      drm/panel/dsi-cm: Move to using mipi_dsi_*_multi() variants
      drm/panel/sony-nt35521: Move to using mipi_dsi_*_multi() variants
      drm/panel/ebbg-ft8719: Move to using mipi_dsi_*_multi() variants
      drm/panel/himax-hx8394: Move to using mipi_dsi_*_multi() variants
      drm/panel/jdi-lpm102a188a: Move to using mipi_dsi_*_multi() variants
      drm/panel/jdi-lt070me05000: Move to using mipi_dsi_*_multi() variants
      drm/panel/novatek-nt36523: Move to using mipi_dsi_*_multi() variants
      drm/panel/raydium-rm67191: Move to using mipi_dsi_*_multi() variants
      drm/panel/samsung-s6d7aa0:Move to using mipi_dsi_*_multi() variants
      drm/panel/s6e88a0-ams452ef01: Move to using mipi_dsi_*_multi() variants
      drm/panel/samsung-sofef00: Move to using mipi_dsi_*_multi() variants
      drm/panel/ls043t1le01: Move to using mipi_dsi_*_multi() variants
      drm/panel/ls060t1sx01: Move to using mipi_dsi_*_multi() variants
      drm/panel/sony-td4353-jdi: Move to using mipi_dsi_*_multi() variants
      drm/panel: Remove deprecated functions
      Documentation: Update the documentation

 Documentation/gpu/todo.rst                         |   19 -
 drivers/gpu/drm/drm_mipi_dsi.c                     |   56 -
 .../gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c   |    6 +-
 drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c     |   75 +-
 drivers/gpu/drm/panel/panel-dsi-cm.c               |   44 +-
 drivers/gpu/drm/panel/panel-ebbg-ft8719.c          |   45 +-
 drivers/gpu/drm/panel/panel-himax-hx8394.c         |  389 +++--
 drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c      |  141 +-
 drivers/gpu/drm/panel/panel-jdi-lt070me05000.c     |   81 +-
 drivers/gpu/drm/panel/panel-novatek-nt36523.c      | 1678 ++++++++++----------
 drivers/gpu/drm/panel/panel-raydium-rm67191.c      |   60 +-
 drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c      |  101 +-
 .../drm/panel/panel-samsung-s6e88a0-ams452ef01.c   |   63 +-
 drivers/gpu/drm/panel/panel-samsung-sofef00.c      |   54 +-
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c    |   28 +-
 drivers/gpu/drm/panel/panel-sharp-ls060t1sx01.c    |   34 +-
 drivers/gpu/drm/panel/panel-sony-td4353-jdi.c      |   71 +-
 .../gpu/drm/panel/panel-sony-tulip-truly-nt35521.c |    6 +-
 drivers/gpu/drm/panel/panel-visionox-r66451.c      |  156 +-
 drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c   |  138 +-
 include/drm/drm_mipi_dsi.h                         |   47 -
 21 files changed, 1432 insertions(+), 1860 deletions(-)
---
base-commit: febbc555cf0fff895546ddb8ba2c9a523692fb55
change-id: 20250211-mipi_cocci_multi-440af15236c2

Best regards,
-- 
Anusha Srivatsa <asrivats@redhat.com>



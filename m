Return-Path: <linux-kernel+bounces-328796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B079788FF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0F31C21BFE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0379148FF7;
	Fri, 13 Sep 2024 19:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b="fx1uk+4I"
Received: from sonic308-20.consmr.mail.sg3.yahoo.com (sonic308-20.consmr.mail.sg3.yahoo.com [106.10.241.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5D114883F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 19:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.241.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726256005; cv=none; b=fDS2tleEoOoP/HzYIv+SLDgKur0B972pYZA06Uxd8u+DzROjybSbImBFEQ3m21P1AtM8brRRT1K+enGkOozPwlxjhctWUidF/IgF47s7DXESS8OkzD44LCyEi/vCWJgxHrYXeveWGktZ+XzpwpqBU6Efujo8TRNIOQrsVIJ40S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726256005; c=relaxed/simple;
	bh=Yw3776WKS9ia5etI8DbaKho23ePP64KPB8wqyVoPAT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=ewbZ8CivCgJVsqEH+If4+CppKpU79/3wX/Z72uceOulCg48Y6N2t+/qttnNpymAO+vbpw3/tsil46RX6uNYWIBcMdYgdey2qSMvgM7zTg4Q7uljGe3F/HkDmQn77co7p5kNKjd/xyjUqPmrNjsPDa1B8YzV8UOJygkT4bXhTjuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com; spf=pass smtp.mailfrom=myyahoo.com; dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b=fx1uk+4I; arc=none smtp.client-ip=106.10.241.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=myyahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myyahoo.com; s=s2048; t=1726255996; bh=DRskhHXVllGtD1jjaKx3voZH0LlbhZ3PTYPp3M4Mee4=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=fx1uk+4IL557ZQzmSLCbXPi71eOLMmPkp/sGq3duBICFYuI6endSISOv7vngtKbavONXvHmz3FMRVuaFZ4OASHaQuXX9GFsLao9B/GZC/d2fsSzqVdJIQ6gdMGXS6R8M2lB3aGxzF+IOnJlBeV7qnXMiyMDP2B4JAuj3IXztaKL+LzNpIv/sPVfDuaITnYlzl23I0LuJetFexGrslvz6hlKxuq3QMvVOrElwU1jlLoMzDoW74zHXcdkrYrhCSAG8Io9ThyFShxr0F0q+jxbn6LVn+S3i3/QsZWpcNqXxWgRD5NylUXNrZQscFGH4Pmjl5CB4wJroqPtK8xjVwTDGwQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726255996; bh=Osvm9adnvC9uydBape1+7kP2uYovEWZqcP1yt6y/dYD=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=jdaTrAc2TYGevbFbFR6lxJLE6S/frCUtSBzXtRv/lJkvT3oIvbPFgZber+Wb/h13gv5RZKi8brFuMKhYQ2neXWZ24C8cH7gdE2ZpyOtbPKiKn6gn47cPxmo2r5XCAqG5VtqRqVM8baPTGny9uNtgv77h6UL3CeFS6ppcJ5KBtVkPnNQXeY/b7/fQRwE9BAF4PiDBqBEho6W0aUmgOLVUCGs/drio/NOvSNmmd9L5Jtn7Ab/j4NAGr0bKH/hxo0BgrnLuQJ5/0eJDE9NTNeMGD9ui+8r83faTfnx66cLmAcTPbWEsGz2v139EdgGh5nB7n4MzINIYIMWPUQ9f1SrH5A==
X-YMail-OSG: b7v6AUEVM1n8eWHC9tAYUc.EeVkD7o8T5vrLtoJMruikpx.KpMqIcvVUzdvnGZi
 X6sgIeBY2ZTMSj.shEhitbAfXw8lVD0O97RBb6GwXycBsx.WcsgwZHDn88EqpmI_gyESQMGCGqIM
 z2YA7GLXJKF3yJNap6cp3HDLk0WfPHvHpUDSqM20aPRcXBp8AbmVVaVRa4_TbGdUAjA9EyXwD9Ea
 xyKmse1NM83K79BcUZcX10dRmAep0YnxIrnJRsNUTkdJTCN2qDlRt2D44P0vOm8uhw5X8F3uqH.E
 VCyn5ZeWjyIW4XqRtrXcg.3ixZWGvFo7EnvLOxHYVR1.o2HPOKjk4TfRa5p2kFqUzTXdt5Ucb_hS
 q7Ym4IosqM8FPkV5RUWwy76TyS2idTKcFaFMtxWE1cQnSWtabpQyBy2FQXecnIdt2tBr70rkoQZJ
 bpCAhiVx_vuO_CJ3ktE8sciLrJ8czlLQP.mGzhw3c_uKulBmE86_q5aXZ8fskgvgUo1QAE7sesPQ
 IvFEjoEQ0q1rRDxYOqj5LcG508wJvZ7iDmbRKT25o4Y98kHNUSRA_XtGMQaNxARqyW_V13wuBOWg
 GRNg2u4RNF8qD6gmonQaoJfqSrnfoh_LDOQ9JzGdkohDfICUUbOISz8gaQ8eZ28vv4LkV2CX.DGR
 64YxsKjYNQpp8zB.fGnbVC3VQ3JcntdnjzHYFJy5FbBgCKfmtyb1.xuijgEn.8x7AV27zFaSOzlf
 GCQgberL0UpI3PH9qNsdVm6foqCZgCUGj2Lz35DAD0fXnmgwjZEk58QwAn3QE8oAR9vV_FVSRyyC
 0cV1HUcZ4n0m4noE0nEK6GWlGREx.4yqTNLm9I_yqCIDXqqRxp9VWeVbqmuN5EzLdmUraxSeMEBj
 MU8iHi_GDVq8Kt9PdYh_8.u6GU0xyOTuQy4.qc3NfNDD3hTVmnnMNxKv3h2wbTsGXyRNm3VSGI05
 Fz3GPH9iMfyAYaWA51iofih4eM9IoJ.K8y5q.J4_QoEhPCuBBS_oRx_EHEzUz2GlPJqz2D.GvX7H
 C2gSAqh2E6BeLxbIaoxtErv2IhzvmXf0uUFETigUewffRAzPNf9_X3zPA45M3soSJ0NTDgN6hm0c
 lEQPsJX8orNmCEO5vEjZMGlsURGf3bKsWBV8Zd2V5RZqc0PrwZIl9WD6JVFErjRsEYh.dsUaIunj
 tFu5XvdwqFtLR0gnS.KjsC2GCrtInAMTVJ_HRLbvAHrKV5MhvZhEz1LnWjRMKuto2yvzl4i8.9np
 13yR72Q8Dl8HDmqx1Mdo.i5opBN_O.DB1MWikydEpcPbpWA8_s.ZgroW01BoTMrMBKlqDLU5Kx65
 NRJbPSxtvzvzJa5iJctFRbhRALf4E1Fivy8pU8dvjcoUqlHzror_qmvtAAfnii0688aDDusE3vNi
 0fXLgbFeYgvDhMuCiTIcjs_6TmAig6Vq1EulS1SHEJGHwnj.ityXvAUouSrcBdUz9D9ihXWrB21M
 ca.5sfJkewEAFBU8ZTWvHJmVs71WMGWILLSm6KHjVcqWyiEEMBymu9ERx8DkSLpvR0mS4qoICVuK
 dl70fEsghjAigjOrvAz7gs_OApXKULzQvHGGgwojvZ0ZjZyGZh0zGagtUtScvIwz5KJxnAwgcjVR
 rLpPc0u0efTOQc2fvzWIsAPzz7MBl3hT2lCIvHjUR6eG4icG_CxLaQ71YvyQ57A9WXy7XTYjN7jk
 E72Sf8YbcNVYLCxan11lIv7zjiArx07lJc0v98IJlpPz4dRYwfSh4iFmx3HKuHRDd1QJEShykm2Y
 bJLgKGcaI6a_xdHks8hhlTc7Gvh8GKrJwRIoYuoOX6l2jyxhQkWUaqzlqjT3qin_FoO8vzevnVTF
 JSq3P0ftOYF8drahukZPY9Tva400oplwIgws0ZfTbhsF1EErEJXH1QAbke2dSt0h0ZRTypn1PN30
 h0AihJOL6XXZOgeoWIzb6WbjIfi_BgVzzJxcdmbFx.NkwteG6xYW_I9aiA.9hMsIn9oPb6obC.K_
 tqLz4hHMz0Saux1A1AgRndjrJK.MkMMCQWEwVJWOJXCE7_FFda40bnW7Xbhv4PNqxd52ttAQWLHX
 uFZyl2.x_cUS6RXxex5f7WcxeXD_jN9ImY33169pBAuMwMoQQ0t5z_s4QgN3ikGYWsHlRpGKedkO
 58UsikBQi8aiMJIXb0m2Q0ACxl.DU.VkskqwWYueNd.QF4DSWJekJLVJe.GojtDQcWiXI.tw_WkD
 DPqF6CK5T7XHAA15FsdCESXtu.9rEoAvAlPsf5X5uSFOGY62.VDJWTyDnFiMSNA--
X-Sonic-MF: <abdul.rahim@myyahoo.com>
X-Sonic-ID: c3f43d41-eb64-4ccd-82cc-425d2756e797
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.sg3.yahoo.com with HTTP; Fri, 13 Sep 2024 19:33:16 +0000
Received: by hermes--production-sg3-fc85cddf6-9p6n9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5341d66e59e0ab8320caf088ee6b6923;
          Fri, 13 Sep 2024 19:12:55 +0000 (UTC)
From: Abdul Rahim <abdul.rahim@myyahoo.com>
To: rafael@kernel.org,
	christophe.jaillet@wanadoo.fr,
	rui.zhang@intel.com,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abdul Rahim <abdul.rahim@myyahoo.com>
Subject: [PATCH] ACPI: thermal: Use strscpy() instead of strcpy()
Date: Sat, 14 Sep 2024 00:42:49 +0530
Message-ID: <20240913191249.51822-1-abdul.rahim@myyahoo.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20240913191249.51822-1-abdul.rahim.ref@myyahoo.com>

strcpy() is generally considered unsafe and use of strscpy() is
recommended [1]

this fixes checkpatch warning:
    WARNING: Prefer strscpy over strcpy

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
---
 drivers/acpi/thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 78db38c7076e..6671537cb4b7 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -796,9 +796,9 @@ static int acpi_thermal_add(struct acpi_device *device)
 		return -ENOMEM;
 
 	tz->device = device;
-	strcpy(tz->name, device->pnp.bus_id);
-	strcpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
+	strscpy(tz->name, device->pnp.bus_id);
+	strscpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
+	strscpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
 	device->driver_data = tz;
 
 	acpi_thermal_aml_dependency_fix(tz);
-- 
2.46.0



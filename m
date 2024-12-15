Return-Path: <linux-kernel+bounces-446548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFEF9F25F9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 21:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ABF4161CCF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 20:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A57F1B9831;
	Sun, 15 Dec 2024 20:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CjIkw8iE"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECA6175BF
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 20:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734293059; cv=none; b=tpeYu1FUiU3b1uAEEL03XGD+Q25+9hyVkrWGmQFtHKaF1jIHbdwtglNghcWLYFbos0XSIWCLiONBeoZ6efb2Fy8rLSarZwm03FJ2ZqCZx7jcJgh7u+ynpOTTZZsBFbvUNM1tZ+2kNZ+xzruBSExZZYsp2D0irSa4JGB4q7zvceY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734293059; c=relaxed/simple;
	bh=eLHtqR5A9wpX6zbeuRVIgqm9V748jbpbrIaWzgxiUGk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OBfBc/moHHRXFMGAaw1GGiE0Pcx6rOPPr9uEKbEAxDOBHrW7y3YKXgq7FgC2YpKRyO+gn7Wv/WAvVc+ZVsKi/JdtCiocaJ6qDuiRDkf5xasNZbKsr6H5Xq0wYhp6/6GC5OraPto8CKMQ0ggBYQV6JpIW+AYvzSUPVmr1Bj/HQFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CjIkw8iE; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43582d49dacso29880265e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 12:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734293056; x=1734897856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YwBupfT+fyxXmEmly7oBmZ1BClZCHwQUt9Ls+vVmCiA=;
        b=CjIkw8iEYjnI9Lo0Fd5nGoyoKicyWtmAD3lFtYPt0HZLpw5fvIuivFsQwAWePvqDHt
         KFJ4kkMY1ZEEx91tYu8kAkAiLTK6luMkGhdvllk53Lie12/e1kTm9PFtThs1QTpJGQzf
         GlBQlErhf5Z2Hh6FUvYlfls4WoE35JBTs6O9vtUt/LrbGJB7BJCh/5PO+1GSMTLObwhI
         4cDh+SfX6JkIlTMF9jtIM+IvkxR4iSmf6KzHB1ZFEnWtggbfJGBCMPDV6z4L/RIgPWwg
         dLwKBfiW+rmDZafmP5jO3OkOF+XsnxkV1Wu70dBSDvoMJ/i+HyNYwYFNONx7I17G+Ov3
         Kudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734293056; x=1734897856;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwBupfT+fyxXmEmly7oBmZ1BClZCHwQUt9Ls+vVmCiA=;
        b=MwkxiC/z26fI9ExlmMm+yd5belTtIZ6HacWWo0tzS6wkZIyczZGyn1UjkeEJlpPCoF
         9RQf/c7QUrR7mUn3VLW5O1QsZjEEFJe62V1eNeroBQ8Rul9zmUmGx5b9JldodBhNxVy4
         QKwL13cHJTBCL/gwAXqWstXVV7aDva0eGnJxozwDgxMnmIqWFZkeJFWwrnbg9/MxpAs4
         z4sfOMkWIcuUL4ViwgEOO6FUhE+qetrbEIYfECme+R9hf57RReXFg5qDY2ntB4eRNk94
         Y9BZAxzgMdxQvMn9YcFbuQqi3vsgmUiYpc2QO1SiNNUV2gyxi0YA/4+/JptbKnekiSMb
         H8RA==
X-Gm-Message-State: AOJu0YzT9EqnuCNpUO6LmhO6WreWq+OM2g3Qf5zKf8xtW73yVuETrczC
	yTu8GVBXzcBaDTappaiBJRQWyIUxPUVpnkGmCTgs4mX4HKGsAr2xXBegcEPIIcd+iimAqVVKRov
	G47mOm1/BjEVHbZ53XK6m7bK2mJz+Sf5XqB3U/6HsHrx2oxPJBOwTtsFyX067JP0++czUtqHR6n
	01oKPwe5ZAgYPFO2QqK2rX3X4gAAvbW5khNtXtKg8eLUu7NsLn3lY=
X-Google-Smtp-Source: AGHT+IFZBtol4MC3NA/MQiwAphEXkZPoxFlwPmucl0GZUYpBLZ8Bn8rpWMLd0hZKVOn4cpUk5W+HN7MQj3EJUQ==
X-Received: from wmaz22.prod.google.com ([2002:a05:600c:6d96:b0:434:f173:a51])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1e87:b0:432:cbe5:4f09 with SMTP id 5b1f17b1804b1-4362aa113f1mr83361525e9.4.1734293056465;
 Sun, 15 Dec 2024 12:04:16 -0800 (PST)
Date: Sun, 15 Dec 2024 20:04:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241215200412.561400-1-smostafa@google.com>
Subject: [PATCH] iommu/io-pgtable-arm: Fix cfg reading in arm_lpae_concat_mandatory()
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I messed up the newly introduced function arm_lpae_concat_mandatory()
where ias/oas are read from the io_pgtable_cfg copy in arm_lpae_io_pgtable.

However, this copy is set later in alloc_io_pgtable_ops() after alloc()
function was called.

I didn=E2=80=99t catch that with my selftesting as arm_lpae_io_pgtable is
allocated from kmalloc, which was caching old configs.

While at it, fix a couple of spaces.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.=
c
index c1b62c7d81ba..7e53ee51270b 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -232,12 +232,13 @@ static inline int arm_lpae_max_entries(int i, struct =
arm_lpae_io_pgtable *data)
  *   c) 42 bits PA size with 4K: use level 1 instead of level 0 (8 tables =
for ias =3D oas)
  *   d) 48 bits PA size with 16K: use level 1 instead of level 0 (2 tables=
 for ias =3D oas)
  */
-static inline bool arm_lpae_concat_mandatory(struct arm_lpae_io_pgtable *d=
ata)
+static inline bool arm_lpae_concat_mandatory(struct io_pgtable_cfg *cfg,
+					     struct arm_lpae_io_pgtable *data)
 {
-	unsigned int ias =3D data->iop.cfg.ias;
-	unsigned int oas =3D data->iop.cfg.oas;
+	unsigned int ias =3D cfg->ias;
+	unsigned int oas =3D cfg->oas;
=20
-	/* Covers 1  and 2.d */
+	/* Covers 1 and 2.d */
 	if ((ARM_LPAE_GRANULE(data) =3D=3D SZ_16K) && (data->start_level =3D=3D 0=
))
 		return (oas =3D=3D 48) || (ias =3D=3D 48);
=20
@@ -1033,7 +1034,7 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *c=
fg, void *cookie)
 	if (!data)
 		return NULL;
=20
-	if (arm_lpae_concat_mandatory(data))  {
+	if (arm_lpae_concat_mandatory(cfg, data)) {
 		if (WARN_ON((ARM_LPAE_PGD_SIZE(data) / sizeof(arm_lpae_iopte)) >
 			    ARM_LPAE_S2_MAX_CONCAT_PAGES))
 			return NULL;
--=20
2.47.1.613.gc27f4b7a9f-goog



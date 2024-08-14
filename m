Return-Path: <linux-kernel+bounces-286386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B3E951A4E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53E8282B89
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28D71B9B4D;
	Wed, 14 Aug 2024 11:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Rg+VbWJ3"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F331B8EA2
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635705; cv=none; b=QiQYaRqNXGRtRHC+TV1GgMBAm9y95OFX9tva9FnWFFByNYk3zckyHrKbj4aWSw8aaKyfAUfbgfeJL+lRmrBq7n2oJSbC62YPnWCJznBQvo55xfCt8GyhsRIkX/f58tRHniySHJfgermVu3O/y6DfDsQbYlrpeBgtsT3PvVXVra4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635705; c=relaxed/simple;
	bh=AYEAerKkLpmYgBzqRigBShCxCtiDnWAQEM03p6Pjgd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=abrf6LM5/Ox/WF2tyP6BfFQOIqlP9XWp0zXa4VaDuLL4Pzg1MaZLlnnlGaWSzL855SudUd4GBQmhyhhmM6NQK16a5ehhAOC3gHxUQU5D6phHwv3IsgT0Zx7h817YsQo9ePCi16mOSnbLvL/dhG1i30JuaI/LFabhdcigD8Hie7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Rg+VbWJ3; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4F9A1421F8
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723635702;
	bh=BMXgySWvbec+2JD6o4seP2DJpr4vHPmjXo1CkaHyEdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=Rg+VbWJ3Fd1VYi7E8IfDU9blFklvK/H8/ABfRhgEMeMKe9leuN5RSE11S0teEYDc/
	 WKhxRF/aOhE8hAHMMQsKgay0mAg2jQMR009veOKy84MzAmFD9fWndIbHoKIorYESZA
	 TYG2ooeUITzP1E+alOXJysPUH+4dWdzp86He+crGpjnI6O9qmAudL3a9ZFigMDeC2u
	 kxlHjZ5G+dqNWLcPqBotxipdSsykLDdt1SQgdf4KITbSqNWwBWIM9EqM0ecQuJoQ0u
	 9htkmfogvavvzwFOAWWUwi+kAY56QYX0/yHVz/B2kn68/fWru7Tz5ZIDzmgAERWEoR
	 ut/AF/mZQCqXA==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a7a8d5ad9bcso468136866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723635702; x=1724240502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMXgySWvbec+2JD6o4seP2DJpr4vHPmjXo1CkaHyEdA=;
        b=HnVbfEFVTbrx3jm7eHwb+D0/ZAU8t2JGH/gvXB7mF/rGGU6IrhG1nbT4Aj3BlM2ECy
         o6TchtEz8uDePgkHOKoeo0zC3z0/4yObEyzMzzGKmmA1G4akTYR9IcuCyJnbZy99hXy+
         gpr0UxzOpOQzu8jhfLMNSSa4OwN/t1/3JsCc5oWUmhq1aqsjv0KkbDwb3q0l94aX2kCY
         6InHV2IGS6gjHDK3Sik7Oud4B58ffN95I+sxNfbe7F4moMnte6kqrMfHc+3GdJMBs4Qi
         cEBROZoFgd2LFuji9XmeiIgt125kBJWVzBHra+oRldoG+US0Hdju72ZqDvFPVlVtaDTJ
         QSPA==
X-Forwarded-Encrypted: i=1; AJvYcCVlGOGMJmtFfXX3QuNp6WQElu3ptlVikDNV+19y5niwQReJVurYceDxWerKrnsEehpxklSLh8zR0JpYhtsOLdBK0a21DssdDTTB9UMe
X-Gm-Message-State: AOJu0YxDI1tD2ur+aNokKQJus7xrQnjOmEkIei7m6AkO0r4gybXFeVM8
	IydsREVD01aVqSfZJhsXuyDdmLYfwhM0OFwOI2WhuvoNVjw39oksV4wD2NMEGFNigVAsOHF+FSD
	YXtfgrRRrpuigsopuTjpxTpNbEM2ut54V4GlUVOTEMyEF1Yrf9oxAoc+8mS/rLa7qFV+zxfuain
	mPvw==
X-Received: by 2002:a17:907:e697:b0:a7a:a2e3:3734 with SMTP id a640c23a62f3a-a8366d4424fmr160210866b.28.1723635701796;
        Wed, 14 Aug 2024 04:41:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY+L+0zpcMxZ0FBkn3BMW+g/GgV8SZkKdvktwTfQoiwXcU482wpOHRCoifda++ee12gpLk/Q==
X-Received: by 2002:a17:907:e697:b0:a7a:a2e3:3734 with SMTP id a640c23a62f3a-a8366d4424fmr160209566b.28.1723635701387;
        Wed, 14 Aug 2024 04:41:41 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa782csm162586166b.60.2024.08.14.04.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 04:41:40 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/9] fs/fuse: properly handle idmapped ->rename op
Date: Wed, 14 Aug 2024 13:40:33 +0200
Message-Id: <20240814114034.113953-9-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814114034.113953-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240814114034.113953-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support of RENAME_WHITEOUT with idmapped mounts requires
an API extension for FUSE_RENAME2.

Let's just forbid this combination for now. It's not
critical at all as it's only needed for overlayfs on top
of fuse/virtiofs.

Choice of EINVAL is not random, we just simulate a standard
behavior when RENAME_WHITEOUT flag is not supported.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index c50f951596dd..0cd01f25251f 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1111,6 +1111,9 @@ static int fuse_rename2(struct mnt_idmap *idmap, struct inode *olddir,
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
 		return -EINVAL;
 
+	if ((flags & RENAME_WHITEOUT) && (idmap != &nop_mnt_idmap))
+		return -EINVAL;
+
 	if (flags) {
 		if (fc->no_rename2 || fc->minor < 23)
 			return -EINVAL;
-- 
2.34.1



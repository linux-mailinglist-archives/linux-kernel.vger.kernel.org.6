Return-Path: <linux-kernel+bounces-565437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C3DA66820
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB263BA302
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD83819F47E;
	Tue, 18 Mar 2025 04:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSPAgjj4"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0411922D4;
	Tue, 18 Mar 2025 04:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742271199; cv=none; b=Us14cjFrb64DYe0aLqNg+AFqUmGibVPXinWYDz7dAyuaS8XIu4oIKuwviWVAXFc6DqVkIAHKz6u2TAx1tntJGtGdx9OqzFpJglumOZatirxT4ZDqNLF45Q3TZKRSfh21rUfU2al7eZvLCArrhoRI9fXJntsFJwbEziR365da8QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742271199; c=relaxed/simple;
	bh=8dCtmz2yXgM9CnphZEsnvImZQ243Xw/h/PBMrWAsHAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hhlZI9JWPLDn/KJEhLontfK9NBuQk3EJR4wvKogsyZjPJAKyEYbbQ1N6rmZtsuPpSRPlUryxTSbjhv45KpLnbhu8Coi+KwETi8WOYmCRSRFczQjucbZzkktYYT6s709mOisIu21ijBAb4sNr8QFPZkUyK1Jx+DLgIUAq6/gLXH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSPAgjj4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2235189adaeso87673385ad.0;
        Mon, 17 Mar 2025 21:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742271196; x=1742875996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oW5RGZBsAsxOiN0J4s9yrYTbdtJ8eIVDFBUiSb/g7VQ=;
        b=gSPAgjj4UwTM2IDUAElsVSZFk1jCLFqIBtXaioKSpINHFC62wmr0W3kg/Eo1zMibXh
         4hSBwlT0viL+h0fib+ujEk+FLy6K4oed0/EePjS5lCRTPWsZmDMmPA5dVhn3ZYGIywrd
         QavFkCIZk1Lbu4kd9SH9+mIl9kY3rQNxOvKgyHRxI2ddJXBcBpZCStnaA7vsXGKWEGmL
         E9FqVRuM/wfYHcOjr7c8DHydw5kPBWUzphX4JUvBFcIe9OH6O3s2by6UZsfbuBeC9utn
         pS7VCxgRQSwaucpzZ76SUTbd+HQFNYr3FwxCXJtj9oEOrFyBGwYcUUF/KF/xCoFP8oLG
         trJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742271196; x=1742875996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oW5RGZBsAsxOiN0J4s9yrYTbdtJ8eIVDFBUiSb/g7VQ=;
        b=AEw904oSzH7/X5FuLp5Pvq+n1QT4AuuZgtFckFFPxOKwhQdhqFLpxY4HpHJn32Y1lz
         P+cln3TGHkEJ76r63jx04r+Lxfo7WBTm8WiYeezeHkpzlR7ecck1fzduYiRWYcnH2S01
         YbL5/MZcfHR2n0cPFo2eCr+H6hwC1IMMrAJ2FZkJC0BjGbWQSlBd8W3AOTXEtqkRefS0
         dpyKlS4BKVkEWUfuLJHt/E0LhFVnwDyKo2g0i99YhwUEP2tzyoTiTnr5Gx+PpWbaDsge
         UXcreudgpCB7rKPlZ4WIoS9gb1gor8l8spZ4pkbfTHAC28nKk9NfPkUjfnYyMF9u3xez
         CI8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmy18fTSsUzP7C7WzqXO1pY10LGIezEp6KnKDKPLDVrGnEHoKzdi/ajXhc2d7t3iWZ3Ql+MpsjlrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiUVZNS23MxF4kRTL81BpYnVBdGcpTrSRvIfPkjWOZ8euSCMpE
	SoYGYqMohq3O41GzldU1IC85pHPeFoqUZ+7DsGrNLb99SOvmJ3Gy
X-Gm-Gg: ASbGnctEL2ztMRVeQHti7okc3MscoGm06+4ZTNV6oy9lTojpMcOTYy6YRXUxx9YtGe4
	VF8LMkLB7I1gBMZWouefwgYCZLGH3zXPQClwFAFzAuMZmsvV2MrJ3ydiKVu9oALFGET66bwTZuF
	CjhzOXl8P9AED+fbmTRGk94lZuR/3ak0kYHQGNpbhJwdoPEXWCbDNHmVgN93jxy6p9NwrPr7rId
	k7wKDfUiU9d/R8E4kaKbs0OyEndMMzMrhHrRUh06dV2Nt63M0dfHGMMtK4uRmetdGICds6K4OTG
	rmBd+wm2XjT2lj0ZlrAmEmuVqEuFS0HIXkU8Gl9fy9EN
X-Google-Smtp-Source: AGHT+IGPmpk4oIUqmS4CZZDYTqHSJT6W7E3MXJzNmcqtOfI14NXzO1fkk9NNspJ1OnJYLNP7FHPj0w==
X-Received: by 2002:a17:902:f70c:b0:21f:1348:10e6 with SMTP id d9443c01a7336-2262cad0236mr33092535ad.13.1742271195760;
        Mon, 17 Mar 2025 21:13:15 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-226325521ffsm3417935ad.22.2025.03.17.21.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 21:13:14 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 1A8214235AE6; Tue, 18 Mar 2025 11:13:11 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH] Documentation: vgaarbiter: Fix grammar
Date: Tue, 18 Mar 2025 11:12:50 +0700
Message-ID: <20250318041249.20786-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2476; i=bagasdotme@gmail.com; h=from:subject; bh=TMk7woRvm74Jgrml6gtFyOKWr5koYQjbV4e6YMnEz6c=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDOk3Pu1q73GafMVezkOvgkFb5gLHZJFa+RJj11sPv3afP Vs/M9C6o5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABNRYmX4nyqX6fXCjfPmbDZx YbnJTTYrZvUnzWKc8trv29+eyeei2xj+Cq/Qn3do3qf8l3xNrJ/zvus6vrm6ssAspnTj59/f/7G J8QMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

From: Pranav Tyagi <pranav.tyagi03@gmail.com>

Correct grammar issues:

- Fix "co-exist" subject-verb agreement
- Correct plural form of "server" in context of more than one legacy
  devices
- Use passive mood for intro sentence of libpciaccess section

Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Link: https://lore.kernel.org/r/20250220164946.18007-1-pranav.tyagi03@gmail.com
[Bagas: massage commit message]
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---

I have to carry the original patch [1] because DRM maintainers doesn't seem
to apply that AFAIK. Jon, would you like to apply this patch before the
merge window in case DRM people don't apply this either?

This patch is based on docs-next as gitlab.freedesktop.org is in migration
maintenance.

[1]: https://lore.kernel.org/linux-doc/20250220164946.18007-1-pranav.tyagi03@gmail.com/

 Documentation/gpu/vgaarbiter.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/gpu/vgaarbiter.rst b/Documentation/gpu/vgaarbiter.rst
index bde3c0afb0590f..d1e953712cc293 100644
--- a/Documentation/gpu/vgaarbiter.rst
+++ b/Documentation/gpu/vgaarbiter.rst
@@ -11,9 +11,9 @@ Section 7, Legacy Devices.
 
 The Resource Access Control (RAC) module inside the X server [0] existed for
 the legacy VGA arbitration task (besides other bus management tasks) when more
-than one legacy device co-exists on the same machine. But the problem happens
+than one legacy device co-exist on the same machine. But the problem happens
 when these devices are trying to be accessed by different userspace clients
-(e.g. two server in parallel). Their address assignments conflict. Moreover,
+(e.g. two servers in parallel). Their address assignments conflict. Moreover,
 ideally, being a userspace application, it is not the role of the X server to
 control bus resources. Therefore an arbitration scheme outside of the X server
 is needed to control the sharing of these resources. This document introduces
@@ -106,7 +106,7 @@ In-kernel interface
 libpciaccess
 ------------
 
-To use the vga arbiter char device it was implemented an API inside the
+To use the vga arbiter char device, an API was implemented inside the
 libpciaccess library. One field was added to struct pci_device (each device
 on the system)::
 

base-commit: 5b8f85d081da449ab35e4bd009d7c00afaab2fab
-- 
An old man doll... just what I always wanted! - Clara



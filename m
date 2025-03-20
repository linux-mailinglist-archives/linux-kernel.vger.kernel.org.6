Return-Path: <linux-kernel+bounces-570225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D44C7A6ADFA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CACEB46758A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E001222A4D1;
	Thu, 20 Mar 2025 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmCOq7h2"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB954233702
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496825; cv=none; b=jdtBDr1Q5eDr/lRQJi4oS9951efYiKUhBL9voR81aYV6NsG4CHQWNlSJ4eNG5FpJ2gAbQVESAaLdiKNrChF9+PLWyCb8ypynWtEl6/JWEyv+N+j9ADj1wU3MdK8dr+6c3pkJbhxTTgFc/l9HzM0AVEbDBoxqKgSKDIFLVT/7sus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496825; c=relaxed/simple;
	bh=mdgz+S+uF4EaXpsKTHXdFabSwUaakZ7Py0nyHL5TVzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/UxyEW2kazHD/MzwpIHOzyfkkbhvalmXyjloyUFtzB7yvdxpuax0fXH1JYV8P510V0rRw80w1dGSi2eZ9vs9LxL6DxVx6jZ5tUGIYyfYWQvg/xqJ8TWiRLyU2qMBotCRAPwGYV6l1snSprPebrwU3jUY83/DVvid22ILHzbH8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmCOq7h2; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-85b3f92c866so15958339f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496823; x=1743101623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAdNrl6o4nlJGGBk/KZ03CeLYIHiGo9zImsUibhTTyU=;
        b=HmCOq7h2KkqvCKvr8kR0tzxO+odlBQL5oJlktqBkUx6zESaqdMRuHEmfWpulbxlD2f
         tRXJQvXjYenBOVuebgdDzFsrWh1aOi2AVpts/dGp6f3wQB3sMExB6Z57I8oQXyFE+hg7
         /pXG576m250HjtQvFi5ByNhs+RH1Be5HFB0bdx2WAUddb5SsXqYK/IbyoQ4W8CmjiTT4
         oY8bheIIJwupxU5CXuXOTH0VxvEqnUlXn4A4lr2WyAAww/HVU6u6XU45+DsJwQTYr7Yw
         /q3MMlCSQ1BU4qUMpMvM57FEDRdEvb2ieHjEeBSpwv/RgfRUOSVye7bfO0f1L00lZhiH
         oO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496823; x=1743101623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAdNrl6o4nlJGGBk/KZ03CeLYIHiGo9zImsUibhTTyU=;
        b=QXNx9Gw+JR2W4Ibke30VSO8gv0mMArttfKJOUTaza1V+RsxyBIgRwyLFXD4cvazgFM
         F9mSwyoytl6korPQQBugxLCC9/1lVMcO79BsjIKgEFQcFf18yp0AkdjxQrvoncXlyZAn
         RApye56s7GbaoJoGvBsI9S4E1WrEwM/6tpUQlVq6Ms1zsjJPgKwgqJ2IDn0hR/uW2iq2
         IAVdVZgnp3b5vo/Us7ujjfg/Qpgvv/C0/yFKh7LIMaWbg3oxKYkGoOzvqKRn0wB267Fa
         KOJnc082yZeu0z8YoTNKICeN2OJR6g3MWiRO6LfIjpAKEhELuj5JH+FXpXOgvz4Tn4Ie
         gOIQ==
X-Gm-Message-State: AOJu0YxYR/rPdrrEWlsvBnpNxuYBxJs0wIB/SrU0cv63AlAga/6PIZkk
	iH0rkMGhx50CjiMKPvxsI6ELL9usOcBWKV2AdfcDur1UX3PrvnXIFaqi5miD
X-Gm-Gg: ASbGncv5ChcDoFyv/czArkgQECZmuD21APaTtGNkvVzY7kI1UoQPUb5zBbZWuRZiLVU
	e0VWD3ZdLRltXvAAZsLFNQi0OurdFgXc2nwMQgvQcn8c0hto5ZnVrJEG6uTOSBG1s5iEpg70h27
	pAGRTrILZ0q0OYNPi+6bX3UhdaolGFyKN8+cA/oKGbXwi7pig1kCkO8bEK2e0QK/WNvrmW/9nY/
	2PaiTYs99/IQPYUl7SC59YG9Z4m/7VYegmyQacR7dibC8hqjYDGiZsFLp+Y3suWdiilqjwSc/r1
	GudHQkpIRKsuD1lphttpFmWT699uEBzOguB3USH+7avcp430MjwIbiTri168Ut6r1Pdyhpd0n1P
	k8w==
X-Google-Smtp-Source: AGHT+IEnonEy983P248xMfxfk4/ahHSFdlmfHVC5Vin/zWCCx+HHiKMw3js9r1od9l49MZlN3oIx4Q==
X-Received: by 2002:a05:6602:2748:b0:85b:476e:ede2 with SMTP id ca18e2360f4ac-85e2cb39bf9mr41321139f.13.1742496822840;
        Thu, 20 Mar 2025 11:53:42 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:42 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-gfx-trybot@lists.freedesktop.org
Cc: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2 34/59] checkpatch: dont warn about unused macro arg on empty body
Date: Thu, 20 Mar 2025 12:52:12 -0600
Message-ID: <20250320185238.447458-35-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320185238.447458-1-jim.cromie@gmail.com>
References: <20250320185238.447458-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

we currently get:
  WARNING: Argument 'name' is not used in function-like macro
on:
  #define DRM_CLASSMAP_USE(name)  /* nothing here */

Following this advice is wrong here, and shouldn't be fixed by
ignoring args altogether; the macro should properly fail if invoked
with 0 or 2+ args.

cc: Andy Whitcroft <apw@canonical.com>
cc: Joe Perches <joe@perches.com>
cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7b28ad331742..0c4f578ea6e7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6037,7 +6037,7 @@ sub process {
 				}
 
 # check if this is an unused argument
-				if ($define_stmt !~ /\b$arg\b/) {
+				if ($define_stmt !~ /\b$arg\b/ && $define_stmt) {
 					WARN("MACRO_ARG_UNUSED",
 					     "Argument '$arg' is not used in function-like macro\n" . "$herectx");
 				}
-- 
2.49.0



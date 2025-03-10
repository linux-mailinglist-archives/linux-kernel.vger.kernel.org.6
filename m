Return-Path: <linux-kernel+bounces-554891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7E3A5A320
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E4B3AF43F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B0722FAF8;
	Mon, 10 Mar 2025 18:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgQZueVg"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92230234970;
	Mon, 10 Mar 2025 18:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631671; cv=none; b=ozsbhf9MYriMyV2nPxlHlCeY+YHXu+XuKN7kvKABmc6cUr++9z0MrIBGnW4ZVS66ibbtyTLTjU9aRRZ0qnVWGqxwpuGoBMYb2uD1JwmHhKb2co46s4JxyPvgqp0yssPmpvK2zdvCPfinWWxLvU/6VOWgSe1SO32QBidYVTvnzls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631671; c=relaxed/simple;
	bh=/W2lfrmzDmAKnppEcTfcNpT/cFN/uegbkn0BHi6gUUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zs0GJIvkDn+e4CWwSvrWLhLB7hsogT/gxeeiM/3HCo+Gou7eYGcRo1NNsL6iaVJVH4bo4v0MIEoVv+xTzenUcGeJQayH1mgyxNf74eTbc9fKCYJVjIEXSE217uc81Qo8VUP17oRXVRt4TUGm2o1P5TY0YgqPVdHUtxfJNc25N2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgQZueVg; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22398e09e39so84442245ad.3;
        Mon, 10 Mar 2025 11:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741631669; x=1742236469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kXHTh7I/mRgEaJneAkHgQi8aR3fLt8UCUliwudcDsl4=;
        b=JgQZueVgv44YXbxQBHWS4aE9IGhNUzqVgmomTb3152/jtbTkvZve1QGLvfssL3Ys9b
         AmZ/nsXXMLtHv0iNZPB5YhHQwvEcw2URBStOYwtwN//eo954G+frzqusx5WA3k4thajs
         mEGGjIYLqbHysRrOOw9Sfb67jnnnTdifTKVkSf6APM/JePOfSFqQPxvRsToQALBA1f6R
         PCIJkD80eacOAc1EJ5vgCco/AcDq+i6XUK/aYw6Gg/TkSC2cWIM8zMfMtBUWSeQ4Da3y
         hJRaEtyvgjVXvjHkEpM0jYdtS4/2rhZXaH8U4xFGtvTpE8tFhXKHFUGna6RpSfg485Tc
         lJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741631669; x=1742236469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kXHTh7I/mRgEaJneAkHgQi8aR3fLt8UCUliwudcDsl4=;
        b=vv3ZBSWy3Eoep+iqKTGrPs9fuvoCAqvC+L1k1AKG8EZn/Lse/k9PMHiz7muZL9Moob
         lLzetdoiNSU9Ar1mKubSgULNh1gkVeNtZ78e0JvtFeTJ/e9OiPjWVGE0mSw7uePeLrYM
         o1wqxEyCw62lgXzz7hqEdLUzU2xr8gbsSJFF/yU7GwsFhkEiID/6N8yUMHhOodcNeoBc
         OeO8qMLd5FP9GyVi87ZSnrphiiPjiAWZ7niLD95Te/HlbS/SSOW6eUHG3PTinZ/o5tiT
         ykI97+fRKmBd5On/BYt4gMBjpfQUhWVhZ0XbJW/yuem0Sxs8YkksbSWqcOsTleUpgogp
         q0eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd8wS4M1gJVS68sK+0Uh2NB9mneL25F8HOr+bl58wTJCnQvbH4Pax9pBf9CbYOG+gMgXkilh29hYlpi2Uk@vger.kernel.org, AJvYcCXV6MheiMdniQIMIYgVhnp9p6k5fuu7qEhkTCDCqk0rhn96CjmsKlFNJ3ANnZLsieUxCWSM67r9bzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmDHrsnrS1nHM9YbR7NYBKKRox1zqSAeVzvsoREU/h0GIhzHJt
	a9x5gkFw7qjpeszCdRdvX67q3/R0YpFDke/HwMcEY17HKjYXeEUV
X-Gm-Gg: ASbGncsO0KjiAuid+narG9Y0MgwY/Sn7m7j4nmMXn84eJn4X33WRUzcf6cSFkq5NkBl
	KUQ7qfmDlsLO8lOA0HhdtKkp0Coi26sn8GHTDWllL1Wc0AfL7lp4aHU2wTxomG6NAiOp8aBOvc6
	gyQtffTrOZn62xicneT+TqnDjsbos2M/y3gjXhtmEjHtNe14IdJ/SRJao85Bo5cidaUy5qi/2sq
	0SE/jIRJi9Q+itzgTcAkGX4V8ywPIiDsMqAQo1d9jUGDcXIb33sUuNrlOk4ZCzDzLQQT/owHX56
	2Gfsu/nC7LvcpBLjr80xvPd0NltzmTLynSrCGyidmLeD
X-Google-Smtp-Source: AGHT+IGuwJ4gBSQ8mC66f3ZNlELs5twuXESiljrZEL7164A7B8IaoRu6usWP4AuvYsUTSuGUSN/5CQ==
X-Received: by 2002:a17:903:32ce:b0:223:39ae:a98 with SMTP id d9443c01a7336-22428a98102mr257906745ad.22.1741631668412;
        Mon, 10 Mar 2025 11:34:28 -0700 (PDT)
Received: from arch.lan ([103.6.150.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f717sm81618925ad.111.2025.03.10.11.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 11:34:27 -0700 (PDT)
From: kth <kangtaeho2456@gmail.com>
To: corbet@lwn.net
Cc: kangtaeho2456@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs: Fix typo from smpfs to smbfs in filesystem documentation
Date: Tue, 11 Mar 2025 02:34:20 +0800
Message-ID: <20250310183420.324958-1-kangtaeho2456@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation incorrectly reffered to 'smbfs' as 'smpfs'. This change corrects that typo to ensure the documentation is accurate and not misleading.

Signed-off-by: Kang Taeho <kangtaeho2456@gmail.com>
---
 Documentation/admin-guide/highuid.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/highuid.rst b/Documentation/admin-guide/highuid.rst
index 6ee70465c0ea..9239067563a1 100644
--- a/Documentation/admin-guide/highuid.rst
+++ b/Documentation/admin-guide/highuid.rst
@@ -64,7 +64,7 @@ What's left to be done for 32-bit UIDs on all Linux architectures:
 
   Other filesystems have not been checked yet.
 
-- The ncpfs and smpfs filesystems cannot presently use 32-bit UIDs in
+- The ncpfs and smbfs filesystems cannot presently use 32-bit UIDs in
   all ioctl()s. Some new ioctl()s have been added with 32-bit UIDs, but
   more are needed. (as well as new user<->kernel data structures)
 
-- 
2.48.1



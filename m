Return-Path: <linux-kernel+bounces-346575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3346298C61C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648A11C21A50
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C96F1CC899;
	Tue,  1 Oct 2024 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfE4fXxb"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F3A1CC174
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727811273; cv=none; b=BDQw4lcLe1IC9yfnqim84IwXu1ayim8wyV890Bxi8MN0dU2b+LwqigQygVGpxbza5ZD7rYsH9yM3e8EOGTmmL0PGHuKz3bxG47KmFKxR5BLv4GXYTWRJWVwvoA0+xhBZ4qiU/pciafixeh5fM4LvD82FVEKDEX/aXUye4ml/atM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727811273; c=relaxed/simple;
	bh=tqJxxbhu5wJr+APMNoKDs22ybCn90Q1Xih4u7lpDNVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HU9ycj9Qjg4fUxzP9+NhejiU8v2to5oxwJyqmDnHdLzSN5RlUcz80LnBEzMEyVkMZl8Rb1Yc3tNoSyZU+Jia9xIRU+Gei9ubnrkZKUNs3T/MwKBRhj0mrEKhgOkMZMZ2UpLUs/MyUndqX9yMiJx/8r8MwqIZP9WTBrnXd52zyyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfE4fXxb; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b7eb9e81eso29313915ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 12:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727811271; x=1728416071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pyt4q+ngnTfPL0EePEe3mroM5xwEeLqpftMu6tlwTbA=;
        b=HfE4fXxbuTId4+UlrcLuG3jNcJZEwie517gOI8YclX8r9XBjxN5g2z8Slil0svIzwu
         md3uNuapet/Gy9es8nv0M4qocMVCqkZ6ZvdsSw9qyJLEkfo5zde6KORRPKUVixqDrznD
         Af2jFrM5eRBHYOVV/zlSxbUtGMVkLkioTAsG91J0RaNVxgXZwNzKcwJDG5IEXN+D+Eh5
         93HGwg9VtO+d1C2TiYhaOp6/8etkVsrGEO3t/uTMdu9yUiW+GzQdQcFT0ZWmvV3VWxF0
         dcXa3pRODkaUqygZyhlFLVKsfpZLZ7Rufrf4q9nnJfGdRUVu508OkP/8JuonPgeHi1M6
         rvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727811271; x=1728416071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pyt4q+ngnTfPL0EePEe3mroM5xwEeLqpftMu6tlwTbA=;
        b=HNZTLG/V1KDz+2jR+7eRLK+2eg41b3oWjglvhspnupvpZuSqJFl+ixWB2qRkmLBom8
         4WmRT3uMl8P8FdD4H/fCP9xFhwAHNJSAEVvbs8Ql5NpaP7PaKamnx693oK9RtB9ItaIX
         rXeALMJ8A3gfS7SD6ygOftitkOGT0P8eTTt12jhU7bgS5VsHCGOvI1AU/OLh/xRpqCro
         o7dY18haGW9X7u9ZPab+FxiCfK9/4/S8XADOr9WLVuc4+aI2njt/TnQiqaYD9eWxgcK0
         XPynZLuq52r6CJG0wbLDFL/EqkB5QKdW6NgSJOiB2UbdeNTi8WOjYVVsmEz38aTMyoJU
         TqAA==
X-Forwarded-Encrypted: i=1; AJvYcCWxB/d3WDyml09FXBZuovxaoO7j6Jt9nrB0ilHOSlpD+mayOmian9/vTejl8yrFPcoA402WzZYlHc03Vjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzDXE1SoLJsmvqsEta41EbEFCVW9fT49DEIsiojnUkb6ndNP6P
	MCXOfD+SnBhf6pZ9GvgVRUrmevIoVIFBkBRcF6Lpq6EHmiGXvnLH
X-Google-Smtp-Source: AGHT+IFdpKTfA8Zul9UmbuuldCsmt3wcWZXmxxJmWSLoj9X6L0a5KMuO0oQwGxzwdI+1wzPDj9sarQ==
X-Received: by 2002:a17:902:ea03:b0:20b:b0c1:712c with SMTP id d9443c01a7336-20bc5a1c118mr9898025ad.35.1727811271085;
        Tue, 01 Oct 2024 12:34:31 -0700 (PDT)
Received: from eleanor-wkdl.. ([140.116.96.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e32685sm72981005ad.193.2024.10.01.12.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 12:34:30 -0700 (PDT)
From: Yu-Chun Lin <eleanor15x@gmail.com>
To: apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com,
	linux-kernel@vger.kernel.org
Cc: Yu-Chun Lin <eleanor15x@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] checkpatch: handle sha1 of at least 12 hex digits
Date: Wed,  2 Oct 2024 03:33:47 +0800
Message-ID: <20241001193347.1743238-1-eleanor15x@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify the regular expression to set $id_length to 0 if the commit hash
is 12 characters or longer, which allows the script to properly handle
longer commit hashes.

Link: https://lore.kernel.org/lkml/20240921151642.60b89e86@canb.auug.org.au/
Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 39032224d504..71900eaffa06 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3228,7 +3228,7 @@ sub process {
 				$tag_case = 0 if $tag eq "Fixes:";
 				$tag_space = 0 if ($line =~ /^fixes:? [0-9a-f]{5,} ($balanced_parens)/i);
 
-				$id_length = 0 if ($orig_commit =~ /^[0-9a-f]{12}$/i);
+				$id_length = 0 if ($orig_commit =~ /^[0-9a-f]{12,}$/i);
 				$id_case = 0 if ($orig_commit !~ /[A-F]/);
 
 				# Always strip leading/trailing parens then double quotes if existing
@@ -3245,7 +3245,7 @@ sub process {
 			if ($ctitle ne $title || $tag_case || $tag_space ||
 			    $id_length || $id_case || !$title_has_quotes) {
 				if (WARN("BAD_FIXES_TAG",
-				     "Please use correct Fixes: style 'Fixes: <12 chars of sha1> (\"<title line>\")' - ie: 'Fixes: $cid (\"$ctitle\")'\n" . $herecurr) &&
+				     "Please use correct Fixes: style 'Fixes: <12+ chars of sha1> (\"<title line>\")' - ie: 'Fixes: $cid (\"$ctitle\")'\n" . $herecurr) &&
 				    $fix) {
 					$fixed[$fixlinenr] = "Fixes: $cid (\"$ctitle\")";
 				}
-- 
2.43.0



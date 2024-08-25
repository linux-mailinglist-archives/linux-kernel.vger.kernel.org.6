Return-Path: <linux-kernel+bounces-300391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC23695E323
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 13:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5717E1F2186A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 11:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C471411DF;
	Sun, 25 Aug 2024 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XU3zImJo"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83873EAD2;
	Sun, 25 Aug 2024 11:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724585832; cv=none; b=BgGGf5A/ABhiccnhj5IPHYoDmATi4kvY70/20qL6dxfEYq2bD7ErNMTt/VrNpwNgQ5JEeRDidgmd9WvHJuMLGIYOCVAPSRBNs9uE838KtXtcmtMEVM95iqbO3H2BKFVJO45WB6pCIEo60kMdFmtFHotbU2tFXwRdFInC1U7Fd5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724585832; c=relaxed/simple;
	bh=D5ZZ4RLvasyhicNOD3S4o5wh9h421fLXUKnKC0AKeq0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M4ZZ36t5dCNjo4QTtyExGSwR6iYf9jOTPaST3M8kS0vwhdjYhJ+jwzZsMxxHfhScQCvEtParHmjQYk1NaNN2H+ST9kta0nUjVCQWCBOKmjDgzNPxjbm7+q+12LedZPDMbzJ/EQ5qVLSBznXOPEGRuVEdkr8o5Opn7vdKC6ulbSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XU3zImJo; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d3d7a1e45fso2319000a91.3;
        Sun, 25 Aug 2024 04:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724585831; x=1725190631; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UnIcUBvMTw1KEUBUHA1XjYrrtx3KSJtfY2z61T9WyfY=;
        b=XU3zImJoo2bTKO2cK9yR/2HiNtuap20Dido1hG7MZcBctuHBHK/2OPE5XHF1Tu3mkj
         ZITJlzM+NpbP6ZeKjkmJJ5ZrnUw0jo7hwsq1kzttFGDKkjxS99TOUI2dZo9LpES9xbPj
         ZpthyxQj98oRlll2Zkp/8ll8qZ+lED+YNh7d4bplmKwNISivMIv8st9Xz6BKurm0FH+D
         2z8n1I/4w6QGfevcrkawWYrtyCPf/or1xZU15XXBJyhZAmCwyQShc0TOrsnvSnUUHAsE
         54l1AmRidPn72uy4hspuZYFMNv44Az+tWcOcWPsDYbc54gJ7D6Kpk8fL5RkrpP4jLemi
         C/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724585831; x=1725190631;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UnIcUBvMTw1KEUBUHA1XjYrrtx3KSJtfY2z61T9WyfY=;
        b=ww0wwa4dr+dB/Ki+EwYPpgne/iUYQz1XN8KQBlFOD4JPcGZTFBRhhZUba7qkPC3gCJ
         mBcBw9OD28b8kz0O69j5ZABqZDlzelnrGJNE2pCZyIYFqE74656iWCIkGSK06J7SVaxa
         Yn4XL+QMEH0rM2qJuzZ7f7DL/txeMwXPdrvYzxvTQHIJ7JjteolbYNnFQL8RhyQa/eIR
         u8VVZhie9EAdlfVUPzzc8PuMSf+fG41AAOgvPW/81hhgQAMVpDSM+/k8w0vweMYWWRue
         SVP5ljx2Rafj51TtCUT+8HKJa6+5qppKCxC9vyiXfHxJD7pcZlK/8mZDezD/BmFrJrMv
         dBeA==
X-Forwarded-Encrypted: i=1; AJvYcCU3sKzygZHX9JJ9+fLyvy5hLjj0LYGYFQynnO3YSs+737w0k0YjaR2jMtTgS2AAFv6dnFu7xFf6aDFI@vger.kernel.org, AJvYcCWuuuRxm6tdTufb0Y+8mNgSp0g8Qv1RFmyBpiuuGdjcQtqdHJ9l2tXEvNfVLCii8SyxlbS3CxFBkRwB0wjV@vger.kernel.org, AJvYcCXeOsiCS1AgBHuZpvOVwOURFMAvDsTsVzUKRqltdMUZIBxboYK5bj2ehqCnT3eFjsFMkV7RVgyoK+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj1dnkfgKS17F4RlhINDlSMOYhFzmL4kL2Gs1kyxWx+iOU8ALn
	SsNigU6seqixiJk59QFEBKE1vto3PAcKnyag6NZVaxcSRs4QPuH5HFYsta1y
X-Google-Smtp-Source: AGHT+IErR+scHsSfvRrogL9GgyzP91f57TnBwt+xm/79x4K2iVrmQQO6Jo46gKeJInkKwLA2lePUig==
X-Received: by 2002:a17:90a:1302:b0:2ca:4a6f:1dd with SMTP id 98e67ed59e1d1-2d646d492abmr5700830a91.41.1724585830558;
        Sun, 25 Aug 2024 04:37:10 -0700 (PDT)
Received: from localhost ([115.96.30.187])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d6136fce0asm7612015a91.11.2024.08.25.04.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 04:37:10 -0700 (PDT)
Date: Sun, 25 Aug 2024 17:03:40 +0530
From: Aryabhatta Dey <aryabhattadey35@gmail.com>
To: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: process: fix typos in
 Documentation/process/backporting.rst
Message-ID: <rd2vu7z2t23ppafto4zxc6jge5mj7w7xnpmwywaa2e3eiojgf2@poicxprsdoks>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Change 'submiting' to 'submitting', 'famliar' to 'familiar' and
'appared' to 'appeared'.

Signed-off-by: Aryabhatta Dey <aryabhattadey35@gmail.com>
---
 Documentation/process/backporting.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/process/backporting.rst b/Documentation/process/backporting.rst
index e1a6ea0a1e8a..a71480fcf3b4 100644
--- a/Documentation/process/backporting.rst
+++ b/Documentation/process/backporting.rst
@@ -73,7 +73,7 @@ Once you have the patch in git, you can go ahead and cherry-pick it into
 your source tree. Don't forget to cherry-pick with ``-x`` if you want a
 written record of where the patch came from!
 
-Note that if you are submiting a patch for stable, the format is
+Note that if you are submitting a patch for stable, the format is
 slightly different; the first line after the subject line needs tobe
 either::
 
@@ -147,7 +147,7 @@ divergence.
 It's important to always identify the commit or commits that caused the
 conflict, as otherwise you cannot be confident in the correctness of
 your resolution. As an added bonus, especially if the patch is in an
-area you're not that famliar with, the changelogs of these commits will
+area you're not that familiar with, the changelogs of these commits will
 often give you the context to understand the code and potential problems
 or pitfalls with your conflict resolution.
 
@@ -197,7 +197,7 @@ git blame
 Another way to find prerequisite commits (albeit only the most recent
 one for a given conflict) is to run ``git blame``. In this case, you
 need to run it against the parent commit of the patch you are
-cherry-picking and the file where the conflict appared, i.e.::
+cherry-picking and the file where the conflict appeared, i.e.::
 
     git blame <commit>^ -- <path>
 
-- 
2.46.0



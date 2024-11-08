Return-Path: <linux-kernel+bounces-401123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 554DB9C162D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 06:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA481F2455B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98AF1CF5E3;
	Fri,  8 Nov 2024 05:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bHq0Uo+m"
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E74194AD6
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 05:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731045092; cv=none; b=n7LnF378qXZJBvco22KE3heWCmpIOoOeiE31zkMxbqP7rrqsGTRgn+cgM75aGaGovJcwIYJ8fbtg5AwqPEQoJ801Ui+NI+ZZmh0qwA7No0F3cNk5Z/KT/WQ3renof1hd5Bdw5jqhoH9GGc0/U3JM4o1uckg/a2U3lYerVg+fVn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731045092; c=relaxed/simple;
	bh=mCm6SBZrWhEj9BkK+TF+1X3UsFI2+ZSNSSa9eNwKMhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ODNhKifFuo5Eo/pwgcPem0I0TZynhnhrGEHohklfZ+BDfVIWPAFKOGirWT1xIT3DCo1BszuxZmpZnduNnFCOYXzqcdMRArDI0escrLNWq00c4O/iJ2MDQJleNWHvRMbke0qRvFQcN4N8P/dN3KlMGUyOF8vkincApYgTk2JpLIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bHq0Uo+m; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-539f76a6f0dso1626625e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 21:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731045088; x=1731649888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C8W06lc2t9tIXnzyhc0K76SKMARK1scFjPbtxIgSIUg=;
        b=bHq0Uo+mQUR82j3Yug0jX0fh6QIZdZYSXjjpwqqzRsohO539OG6CTkEgwNqy6n81WF
         UOI7NA/QU69XGN/qcNYsynvjUeEyjDgaZTSQz9Iwpfn7S4uMGn3lzIJ9hqWPx7WeN3/I
         2j2X9G79rt2QqXuhCYnnm5uv4kHV7Nk3NelNbo/pKl4sTkQIYaqne6EbaMMzFbw7Q8rG
         +n2z3OywEpiiSAzmYq9PJS9YFjGRTj68GsaVqyTUPAtg0JYF3RvFPpaFuYEtWLCa8/Gd
         z7wrWMAdBBv70x6bL7GOlqxj2b1EV89jhr1SulwimmvYAeXg3nfHP6uzGwz133XvIyup
         XFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731045088; x=1731649888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C8W06lc2t9tIXnzyhc0K76SKMARK1scFjPbtxIgSIUg=;
        b=UBLOwHHb14+cv4vSBd6vJ3vXGe198DGuErlIcpCgc+dhfbk3E0kV1iSzgM6EYJ6R/8
         Jq93xAkcUPi2yMd9btgcpzSZCsnQ68tk5mlyELyUJ6DMY9dEEmeta967bXLTh9D0LVqD
         8ocbJlp5g8SZGAv59+ug2tYS0XRhgVNSwemonZcmMZ00GCakOtQVvb4Vg13AY5xTNMTr
         NTJ+wgL6fVXH+/XIQt5bG8xWT0JpKd2lIJrboLirzHs0buaUmKMIbHGImzjY/yVDCLZY
         FQkkj6W8UYiEv5roYcojoAtshT9A1lUSYY14PUjiltZsjnvYwBI5DHnxikDkyFdSPx7F
         gIkg==
X-Gm-Message-State: AOJu0YzsCITm2ThGo1bGznR92rNF7atSZJsHnElIGLo/8TVwnaFEtbna
	ivAD8RdzR8Y8+RB8DuhHcXY9AbtE6l+Z9jHR+iKeEmeEJxow5QwZbESWXz/yFZNN2bIgCTPHGGg
	9zLh7MfrC
X-Google-Smtp-Source: AGHT+IEoZH/FynT5NC7cHyUxVRiAOEePqm6FaAj1VvoPv2YxexuX6AIFW5aSbiyYUDtzlZjPe6B6Nw==
X-Received: by 2002:a05:6512:282a:b0:53a:40e:d55f with SMTP id 2adb3069b0e04-53d86289b09mr657317e87.15.1731045088131;
        Thu, 07 Nov 2024 21:51:28 -0800 (PST)
Received: from localhost ([2401:e180:8800:eb21:7695:a769:ff9c:3830])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e5c3eesm22663225ad.216.2024.11.07.21.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 21:51:27 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: cve@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH vulns 1/2] add a .vulnerable id for CVE-2024-49888
Date: Fri,  8 Nov 2024 13:51:13 +0800
Message-ID: <20241108055118.28631-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link: https://lore.kernel.org/all/klr4llu43s4osw4o7234no33k6eujo2wvpeyhft2z5zgib6zac@hvg72k5q7w3f/
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
Add vulnerable commit IDs as Greg previously suggested[1].

I posted analysis separately and referenced them with the Link tag
instead of including the whole analysis in the commit message. Let me
know if an alternative approach is preferred.

1: https://lore.kernel.org/all/2024102419-deserving-veneering-6641@gregkh/
---
 cve/published/2024/CVE-2024-49888.vulnerable | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 cve/published/2024/CVE-2024-49888.vulnerable

diff --git a/cve/published/2024/CVE-2024-49888.vulnerable b/cve/published/2024/CVE-2024-49888.vulnerable
new file mode 100644
index 00000000..b7b1891d
--- /dev/null
+++ b/cve/published/2024/CVE-2024-49888.vulnerable
@@ -0,0 +1 @@
+ec0e2da95f72
-- 
2.47.0



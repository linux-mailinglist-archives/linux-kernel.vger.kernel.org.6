Return-Path: <linux-kernel+bounces-289409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C78B9545E3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43DFE1F26014
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C441C13CA9C;
	Fri, 16 Aug 2024 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meElQHqM"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A804320E3;
	Fri, 16 Aug 2024 09:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801017; cv=none; b=LE83H/Beasb21JQl7NGXmMGu1F36J4hKgBtPEj8/vZoVA16n7PnEsRtducO3LkwRvWZEy78bZcYR65tsiGQaBnqzChNPFcp9vgcJjRZztzROGJTBPBNXW3O/it5O538ueKrqnxeooOD80B9tFukBEEDNIfmB5F+Edy4ipuNOmho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801017; c=relaxed/simple;
	bh=r3gmMajOMo8VTdTFYIotH7psmm327sqr/zDPwXFcatQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iFg1wTljoQzsO3QIGxjYXkad1edYjzH6yaExxO3CZzcE8OHIcFv+piBccMhuuwQpzWYj+j1C3iSg7qExdscFsvw/2liisMFUFsxYQ3QFS9MTyEGLyda/MrM08fSGYQyIqTWtTe4bXS14cRGp8Kkfeuhigw5AZWaaK3kjXsYTInE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meElQHqM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-201e64607a5so13282305ad.2;
        Fri, 16 Aug 2024 02:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723801015; x=1724405815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NdvxhlCkMHRIJStiK9mOuuQNjL800lm6joC3OBAJcWo=;
        b=meElQHqM2T6LW8uuEB+wwJEyUhqfcWN8DJaWB1BSHvVXh0NBaW0B63Py1orORKyRbl
         rzQqLWQsTurCsNJJHfefKZeX/IIHnIO146+JXScNMZ6YHLX0DraPNY3maVkLxGwOWISe
         NyrDzMF/8rwVMy6Y5NjeTqmsGKA0TwcXOPaq/zn3LaMS5Qa/JizNvNjizJsWHgnhbO4m
         oRUm95KsmmHpXRkTnssFmx50KT9wPlLVleGi+3GDmxUnKO6GqJZmKmRO3K2pj+e2FZoF
         KZf9bgOD/j54ZielTrM3SzYvjA521SZdy9v5uraxmqQcLwnmHWm1Ri0UaOyqy0URbul1
         QDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723801015; x=1724405815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NdvxhlCkMHRIJStiK9mOuuQNjL800lm6joC3OBAJcWo=;
        b=XxSWovdTMGQty4MnKxlrKKOlwZjiiWr9UAJ1wF4tmsdfcYelnXgXEaVPhEjkE5cAXA
         ryZHiOlw9Fv48y1PehggNSRHNDhjqn9kHR13XQhvhVI8KzaJiyi8e5yNc2ByyjFG0unW
         w4wgpd5R7xFqGWfO4vzKWDV64PeTVdCKnTD+cjR+ZhSD6XRsiPrG1zAMNNljeCTqLM0q
         fuiOfNrypjYc9gQh0Mc8AU7cAzrhJs60Y/Jm19aqVn/XvLOUNsaV5kz/VsmmLZpHCBcU
         Vzv8HD+Q6bWrqWLVxWKhN4mLhujX9PF7cdwjocjEdW8dc604eShUG4sYxpxFPM4tVT7/
         OaUw==
X-Forwarded-Encrypted: i=1; AJvYcCVMVHyQhCWXfaDDDLNAZlphs/p2l1KAUubnMPg8SLq/3M5+TlbKxOzW9MHMWzhdl4+pt4UsJ4Ctn2WtRJZM1gU9MKsyVdtqNhPtuEIYWB5C8HmhfuHDqV8Rg1K2a7KbsYbPT9R7vNkz
X-Gm-Message-State: AOJu0YzdQwv9C8FoeIPtn3FdIkRt6OCMNCl6K+VxPw+P2vAS22GmY8kK
	0Qhr+BFfdpGeaEYwSIfHWXL57Gc1ynxTXPJxeoBKB6hbYCRTw2wU
X-Google-Smtp-Source: AGHT+IFvZsE2iLKLxiKZ0w7O6KWuL7VWOQUBF+uBCgvhKsviF/EHYAvFR09f7ZJytsckUFN8LJ8uBw==
X-Received: by 2002:a17:902:c946:b0:202:1547:66ad with SMTP id d9443c01a7336-202154770famr1122845ad.65.1723801014717;
        Fri, 16 Aug 2024 02:36:54 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. (126-84.iitb.ac.in. [103.21.126.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031bc76sm22277545ad.96.2024.08.16.02.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 02:36:54 -0700 (PDT)
From: SurajSonawane2415 <surajsonawane0215@gmail.com>
To: linux@leemhuis.info
Cc: corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SurajSonawane2415 <surajsonawane0215@gmail.com>
Subject: [PATCH v3] docs: Fix grammar and phrasing errors in reporting-issues.rst
Date: Fri, 16 Aug 2024 15:06:46 +0530
Message-Id: <20240816093646.116091-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix grammatical errors and improve phrasing in the `reporting-issues.rst`
documentation file. These changes enhance readability and ensure the
accuracy of the instructions provided.

Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
---
V2 -> V3: Re-added the fix for the line: "That's why you might be need to uninstall the".
V1 -> V2: emoved the unwanted change to the line: "try search terms like".

 Documentation/admin-guide/reporting-issues.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 2fd5a030235a..07b2c0b20498 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -56,7 +56,7 @@ developers. It might be all that's needed for people already familiar with
 reporting issues to Free/Libre & Open Source Software (FLOSS) projects. For
 everyone else there is this section. It is more detailed and uses a
 step-by-step approach. It still tries to be brief for readability and leaves
-out a lot of details; those are described below the step-by-step guide in a
+out a lot of details; those are described below in the step-by-step guide in a
 reference section, which explains each of the steps in more detail.
 
 Note: this section covers a few more aspects than the TL;DR and does things in
@@ -299,7 +299,7 @@ face, even if they look small or totally unrelated. That's why you should report
 issues with these kernels to the vendor. Its developers should look into the
 report and, in case it turns out to be an upstream issue, fix it directly
 upstream or forward the report there. In practice that often does not work out
-or might not what you want. You thus might want to consider circumventing the
+or might not be what you want. You thus might want to consider circumventing the
 vendor by installing the very latest Linux kernel core yourself. If that's an
 option for you move ahead in this process, as a later step in this guide will
 explain how to do that once it rules out other potential causes for your issue.
@@ -472,7 +472,7 @@ before proceeding.
 Note, you might not be aware that your system is using one of these solutions:
 they often get set up silently when you install Nvidia's proprietary graphics
 driver, VirtualBox, or other software that requires a some support from a
-module not part of the Linux kernel. That why your might need to uninstall the
+module not part of the Linux kernel. That's why you might be need to uninstall the
 packages with such software to get rid of any 3rd party kernel module.
 
 
-- 
2.34.1



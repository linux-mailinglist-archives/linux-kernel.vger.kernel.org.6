Return-Path: <linux-kernel+bounces-524018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7120A3DE10
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BB02188997F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B061B1FA14B;
	Thu, 20 Feb 2025 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4Eu4rpH"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A692F1FAC30
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064461; cv=none; b=reHdnOvOaGSfc3ZkC4LQfCjrfNGn126XJVJg7qBIg3PWap9mIc8mqOtHRqmLcKgDn44WFNFI9rWpvcGzzMD8ueVJjqPK0J7CEgX9fd4iIM0jkMVmEi/bZyClel1gya4A7K8c4NvOrI0lWsCpap25JZ1Yd3h1AaJC118F4f0kQR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064461; c=relaxed/simple;
	bh=9eaCaq5y9D1r80+Z5+qGqUat+koJb6OIj9wcd+uQEiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lj+Flnu8znBnDfoRNWeajjlR/Tj9ETAlvRQ7sqEHBuz+mvI+bby5PTGuJy5HqRQ3g7hEu4kFJmpBaPW/du31E2CDuiyLkUEB8A6uDAyTDEtCNEhHN44uh52LyqL5GHzhobyUhbhdMg/yw/KFcTegGjJ4k+PSAdAM0haCv1sH+F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4Eu4rpH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220d39a5627so16712245ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740064459; x=1740669259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqQpBY4aFk+b5TA2ZFF7XiX758vlnpBYffrh3Zwz7wU=;
        b=m4Eu4rpHIU3sBybfKgfO30YkRDpuRsDF2BeERg4d8JL3oNBo+XAtwpNiL+U7oy0Sqo
         BTeswGC8T/GFzOmTZ7NCWaVIlvEppVwzajfq8+iCkmxUJhQHnI3GMjhlxBGCq1O4AvYG
         zgz6gyow6/IePWUznE9QAKrC+lZYOrTM1Id+px9FOMZdNlxRlZ7g4UPcAzTLm3NHxsyL
         +MwtAatL+yAWh8gnLVGc6awKwUZkqJivEDhMZtMvRPobOgjyM3KWVMVY6/NJyef0UCVC
         2F6OXoLs0iI6OzD8pazH+RVlen0Z23SJsZK2e7/Q7aiVxuWnbR5IV/ZRA+JRNzLF3Ojw
         pHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740064459; x=1740669259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqQpBY4aFk+b5TA2ZFF7XiX758vlnpBYffrh3Zwz7wU=;
        b=J5FCBRUrCX8NqXm5faAH7dBmaRdSbL1+bBi4QnN37ypKsDjmlXEqhPn/R7j96a2Syf
         iJA1glhU/3oDNv/LbjTDhZHhcqLAZWHjpPQUqg9p5dfG4b7ny/ehXd6lR6sK7x2ocSbh
         9bQ+kvZLXQUiM5RKKtAqcCOVp97lM0M6Wy5uW+fKDninFYGyTtaV6GWgAJk2FMvmSect
         q+8tpHGBAa/wSXx5i+gb5u7GI/vR8N0tJpEVtOWdvtPyHm2pQLXW/4lowfmreGD4labM
         6zUpp0Wif9CwLeahcQmmx+IcVhNwzMBr+PlJnTIPZ1usKc1fL6iAN+UzyOhaHeQ2ZVBF
         vSDQ==
X-Gm-Message-State: AOJu0YwZB6HJPxFn70yvCkkJ1dXVg7gYWOOqRHU32z9UF2gev8UUWrQs
	CiC4jj9p7Vtid0Oww2mqA8O6wjbnYmD/1L68f1rk/yFag0cqh6e5
X-Gm-Gg: ASbGncsD5cFqumZ8s2VxRZq+3d98FDAfRiFE5kS7oNAKuMz3Z037trKUlZ9yukxsPGr
	5pO+/AancoEk7m+RmcmlRs253wdLoJez6qFSWMQfKw2p2yNuy24r29V/FPcHCUKiiecVdEZMu4E
	sz99eroSp12ZUT9f26usoanQvrv2m+T1WhphVgeKdiSzILFyxoAaYI8beQWG7nAgm+hUEXRUCWI
	twMG1/SxtCO9p54oGOsVRJ/5pFuc7mYSeIFplVJJHnHOtFjxLRFlxxFD7+0lml+OmqJ+6pXUX+1
	IS9pcgBOimkqE9CBz5rg7L+qfQptyixwVcWfh/g=
X-Google-Smtp-Source: AGHT+IEBhHNkErGPHvUIGRDjQRfvuODqABxRCX5C2SR4N1tK6tuSLh2jC3rHExY/Aml3jqmJl8PUuw==
X-Received: by 2002:a17:903:2f8e:b0:221:2f4:5446 with SMTP id d9443c01a7336-22190639e7cmr44995675ad.25.1740064458775;
        Thu, 20 Feb 2025 07:14:18 -0800 (PST)
Received: from ritvikos.localdomain ([49.36.192.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349389sm123310255ad.42.2025.02.20.07.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:14:18 -0800 (PST)
Received: by ritvikos.localdomain (Postfix, from userid 1000)
	id 1D910E7C4B5; Thu, 20 Feb 2025 20:44:15 +0530 (IST)
From: ritvikfoss@gmail.com
To: linux-kernel@vger.kernel.org,
	ricardo@marliere.net
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] scripts/checksyscalls.sh: Add usage message, fix -Wno-error
Date: Thu, 20 Feb 2025 20:44:14 +0530
Message-ID: <20250220151414.8003-1-ritvikfoss@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220105940.5241-1-ritvikfoss@gmail.com>
References: <20250220105940.5241-1-ritvikfoss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ritvik Gupta <ritvikfoss@gmail.com>

Currently 'scripts/checksyscalls.sh' does not
provide guidance when executed without specifying
a compiler, instead it attempts to execute
'-Wno-error' parameter as a command,
resulting in 'Wno-error: Command not found' error.

This patch adds a usage message that is displayed
when no compiler is provided as parameter to
improve clarity.

Signed-off-by: Ritvik Gupta <ritvikfoss@gmail.com>
---
Changes in v2:
    - Make the script posix compliant
    - Fixed formatting

Thanks for reviewing!

 scripts/checksyscalls.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index 1e5d2eeb726d..96cba9f79249 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -10,6 +10,22 @@
 # checksyscalls.sh gcc gcc-options
 #
 
+usage() {
+cat << EOF
+Usage: $0 <compiler> [compiler-options]
+
+Example:
+  $0 gcc
+EOF
+
+exit 1
+}
+
+if [ $# -eq 0 ]; then
+	echo "Error: No compiler provided."
+	usage
+fi
+
 ignore_list() {
 cat << EOF
 #include <asm/types.h>
-- 
2.48.1



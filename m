Return-Path: <linux-kernel+bounces-355398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B899951AD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D555286793
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8811DFE24;
	Tue,  8 Oct 2024 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmR2jjcb"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FD01DFDBD
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397597; cv=none; b=Ds33fkRXeZDrWqRmlg3WajrGQAMNGaq9JG01kLNgu5itwiIlb8Zr24vaNUAcggY974zNOhS/PEEczA1sXNIfRc/MVlUg/q7ZS5JweIN9U0/8UzEBPyIkZlKtTxkmq4u3P4s3o6aRd997wixn9u6tjtpvIMuaBV/boeHnHsW1ynM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397597; c=relaxed/simple;
	bh=TmUBpUepqVlnT0qr1EwgPa94/qNFoMONwgGxzm7MGQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OYVqtUxiQtPoazf0dnx6y2klUQCBEfJRE7VPg8o8sIA7nPVSLePZmOVZvtWCVH0Y+Ti6C44zP719gjAHRRNQqqUXn+1ZexzWsui0kVayrPRm9s+NTDZKZyypODosAwsRhMY09wlsBlpg1vbdE3g+dIRskT9xSiEX1NJ1HPu0cWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmR2jjcb; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e28b75dbd6so476859a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 07:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728397595; x=1729002395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sw6CxlKnAgsfYfl3XBxMutIKXdxiAngOK+rc8wr9wbw=;
        b=QmR2jjcbLpS7bkwnuWwjp200dlO7xnXi5wrUzYJw8BFpaDmwOYQ7K1a+sLb7+p2pHT
         XAT9d53bhgg6dxL1oc99mbb3Zgo2jc0BYS0BBg7fAZ19aC9PDBU5uC+c70sjy2BGsqEj
         QlArVCVhWSXLsNxQ6gUga+R6odmzxDSro/U3NaCPDwqqzAY6sdMi32e813oaXKb1Zi+C
         KClmmlGxXCsCyVBY7nMoYpwr3WSqv3sBF8/diGb88IAe5gCZ8UgQK+rwEis7vOrfnKLN
         GcdX7qXfqxe42U0EaUsharoNCN9wjN6kPlo9+KqKogyPkqEPCOVcRQlbw/YWT3O3fl1m
         k7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397595; x=1729002395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sw6CxlKnAgsfYfl3XBxMutIKXdxiAngOK+rc8wr9wbw=;
        b=QWlT30jmf4o8K2yqgFcozAzofVZFCvlxlypXcV66ygOYW4z4ILUbgCwX+iK0Rsr4bg
         0zsDKDy1DYp+WiHTsrhUyosRGrNLVrKOksb4hEsHo/Avq9h8ku4XQAdxqS7nZb6NhoHr
         7EraMg71Zrl2fm4A1sHo4/a9nHwaAbYgYhnseb6H80dXcqUDADii3A9QSAKVdKO47tbC
         WQ/xC+AhhKbwkVIMXxMixzUHhiZBDMtoSZqCfKodcGtJOqtEccyqnjZpQFYVvGBPIK8n
         45/vJn+sllYBqUrMHZESUsBWmQDb4LGqgrNykdJbiLCyfpf0824r+g73Cq/Lbc7642wr
         4RTw==
X-Forwarded-Encrypted: i=1; AJvYcCXut6IeemJ1gPuHslr49rIbl8sukUd0rW6b8upMZeuwIVlKpR9j5VYgheya4E3BTr8Cu2Ozpf13Dn4l0r0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtHejknX5WC+aEvE6OLTTGrLq2hQvIBHrfp+waPr6A3l4zM4JD
	M8XqXp8/HObJGYovroO7VGAQ3p5EQ3m/IMpnuIHkcj7wFTazDDSJ
X-Google-Smtp-Source: AGHT+IGqXokPPs2Icz7ZcX1duypmdWZe/qqNphwyXaTrf5WJLHGd0tx0q9aJG/3O3M1pPlrWFp7ckg==
X-Received: by 2002:a17:90a:d991:b0:2e2:8bce:3d02 with SMTP id 98e67ed59e1d1-2e28bce3e7fmr2151126a91.30.1728397595170;
        Tue, 08 Oct 2024 07:26:35 -0700 (PDT)
Received: from fedora.. ([106.206.105.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2848d28f4sm1720997a91.24.2024.10.08.07.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:26:33 -0700 (PDT)
From: Devaansh-Kumar <devaanshk840@gmail.com>
To: tj@kernel.org,
	void@manifault.com
Cc: Devaansh-Kumar <devaanshk840@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: Documentation: Update instructions for running example schedulers
Date: Tue,  8 Oct 2024 19:56:20 +0530
Message-ID: <20241008142622.3601647-1-devaanshk840@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the artifact paths for tools changed, we need to update the documentation to reflect that path.

Signed-off-by: Devaansh-Kumar <devaanshk840@gmail.com>
---
 Documentation/scheduler/sched-ext.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 6c0d70e2e27d..7b59bbd2e564 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -66,7 +66,7 @@ BPF scheduler and reverts all tasks back to CFS.
 .. code-block:: none
 
     # make -j16 -C tools/sched_ext
-    # tools/sched_ext/scx_simple
+    # tools/sched_ext/build/bin/scx_simple
     local=0 global=3
     local=5 global=24
     local=9 global=44
-- 
2.46.2



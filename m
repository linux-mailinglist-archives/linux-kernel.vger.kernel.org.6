Return-Path: <linux-kernel+bounces-520503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7ECA3AAC2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0308016AA92
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF641C8617;
	Tue, 18 Feb 2025 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGqbSZ7r"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297EB1C5D7C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 21:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739913708; cv=none; b=o7GwYIzkRTZrdUgg3XfFmU/x2u0mB93NWC5lkq/nVwWYEW/wf4ShZb6EFzxid4G9UmXR17tX9OaWNzsU68Ps/v2oy8/pr6SvgTde/GYXrMc1hH/WCyvCnhsFVwI3o8R4hwz9mymVmGepcvR2J1ltvqsiiuHTBGCXhI0sa7GhPF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739913708; c=relaxed/simple;
	bh=9ZXR/UegNSYFkVyBV3mAl6h0OC8oO7OjCk7UEoajhQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nLIvqZheHchxdU9mXRveCF0gvI3jFd0ieyD4Dz4aemIPZNk9lsPPyLJfd2wbjsvMZPnITmsvtqJhLhIcxJ4A2fcaSVvz9PAs+2JneEtRnDTdcY5dWhbXDDxZlka/p0BvNTghQmNov/QXY6uf1glBkYpzLCO47BTDyB2qEYYdnhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGqbSZ7r; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f2339dcfdso3098885ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 13:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739913706; x=1740518506; darn=vger.kernel.org;
        h=content-transfer-encoding:signed-off-by:mime-version:message-id
         :date:subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0YgGSnITBh/OY5xM1TqoNGaQf6WlJBBaRc6tj0P3/bI=;
        b=MGqbSZ7rB3OUglyY1BmM8iw1gIXY+ejJhKUW5YMOZR5EnLMzNxO7qQQ7/9ScwxsANT
         Bkol0442vJAaAppO/CfYUpkKxbE17mc/9ALpboXzmmm1BV8wrff6LpIuN2GMKT8Taws4
         IH7WAUKGvnwk59SG2IiVx8Mql1seKPFpu3MxwApFrn4g0yqXyhAwjKjevFSWcaCW/3RY
         uADEuuhTTcFFBKj74w5IowNDOwrxtfQ4XPrXd1KFhwm4/oIz1q3NRkf4N+oXrreFskmh
         kDSYlg3YqbjWdEF+HIYmOto9atXINuJwFVOCgNqm9qLQyqcc3etAr2kdb9/Eb/pYRBTf
         iHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739913706; x=1740518506;
        h=content-transfer-encoding:signed-off-by:mime-version:message-id
         :date:subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YgGSnITBh/OY5xM1TqoNGaQf6WlJBBaRc6tj0P3/bI=;
        b=v1AkxRFPOttkG/O/mNL2xqYJPQ+73Siyi52MgsG6ZIxhL/M0KhZlXyQLhRk/u15wct
         Fy8Z9hRI+mG4i+XUxJPqgFRCckkLvlCYJSNoxnHAU4hWfthE411uFc5Lw7Btass6IAW7
         4SKIjDqgzdaFcrvVCnYsP01keBu66xI/inGCAgMcxYv8B5OqEkKHscjKyQxLvW5PExbv
         31nUe144dk7gcF7e9awo71OZDZ4jNhMy+S0LZuwWL4MOCdmP7yeGEg03lUZ6eQBH/e3I
         quorNC/UEXat5H4h5lC2e17btB85EJ+J5/Trm70p7jYBY1IMW1mwdr82DBfNmM53CTMS
         6+Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVnkuTXQ5xGCiB2MG4vre0rz364aRDcr7DJHiypzaZtray/+uk+mScwFsAEAUWCbXiG2T02r+JMghRCsuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzplhWYKfVJQCJ5YiEPr9XOPgciCD2G2bEono02muwJVfbgoyWx
	XyaKcB63mz9iWQygcew1++29xWyP00NxqCzOdAvSxVrGcMd7WbE6
X-Gm-Gg: ASbGncs4qB53DO82kSUyO4TlLxfwp7VDb2CYvkTV7rLhJVUxG7bLOUmv+v/UclK99C/
	VC8FDVsWDfDgzcaXr2wUf1boK4rQQC9ConHhkCV3cS8V3B6sYkAcXImqkQvS2WRrvFBBsg8bAhk
	EL8nL8KhJkDkNdaPQ+lB+SIkazsWZveTn0ptmwlsOIMLJOvpckSAG7KAc18MN8kVW39J/pZFAhB
	cHpZL9ET467rREMkEmvcFtWkFDJm5HR9Z2qUhtrcyshhFf5d+9H0u6WHn+1pYcM7FsaFncAzvbs
	E62O8IHYHhn7oprQf2MJf88H3Ts7YEjJmu0srUhyCGPh2K/Cyp3JJTi3FQFDbNezwvxhAzt74w=
	=
X-Google-Smtp-Source: AGHT+IF2W1k1ssg9MXvqdUOe3nsa1g98vCJTND8J+en8nWqJOgcrQ9879nPUGUgQic8mHvktCGTP+g==
X-Received: by 2002:a17:902:ce0f:b0:220:fe36:650c with SMTP id d9443c01a7336-2216f11a1eemr22367835ad.23.1739913706310;
        Tue, 18 Feb 2025 13:21:46 -0800 (PST)
Received: from node0.suho-242436.threadtune-pg0.utah.cloudlab.us ([128.110.217.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545cf6bsm93394715ad.123.2025.02.18.13.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 13:21:45 -0800 (PST)
From: Sumya Hoque <sumyahoque2012@gmail.com>
To: skhan@linuxfoundation.org
Cc: linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sumya Hoque <sumyahoque2012@gmail.com>
Subject: [PATCH] Documentation:FS:Fix minor typos in filesystems/f2fs.rst
Date: Tue, 18 Feb 2025 21:21:42 +0000
Message-Id: <20250218212142.557462-1-sumyahoque2012@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Signed-off-by: Sumya Hoque <sumyahoque2012@gmail.com>
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index fb7d2ee022bc..412b0949143b 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -310,7 +310,7 @@ nocompress_extension=%s	 Support adding specified extension, so that f2fs can di
 			 nocompress extension will be treated as special cases and will not be compressed.
 			 Don't allow use '*' to specifie all file in nocompress extension.
 			 After add nocompress_extension, the priority should be:
-			 dir_flag < comp_extention,nocompress_extension < comp_file_flag,no_comp_file_flag.
+			 dir_flag < comp_extension,nocompress_extension < comp_file_flag,no_comp_file_flag.
 			 See more in compression sections.
 
 compress_chksum		 Support verifying chksum of raw data in compressed cluster.
-- 
2.34.1



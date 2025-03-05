Return-Path: <linux-kernel+bounces-547107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D6DA5031A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959DA173B07
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9101E24EF7B;
	Wed,  5 Mar 2025 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7wjWBGn"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4237A24C68D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186841; cv=none; b=DltbsSQO4BXTnYdMfvFBVTuAeLOpF9UzsMXvs4V0gEtAO43ab4NEbth2hJlDhAPbHF2o28UmCtJG7MNR4pXSW2gOnFFOdNEeK1FLm21cMBCzTlAHTiT4nc74Ax/0Ga1J3dkpIHcO7dC/UyuaCfglcszTVlPEzeQMoBobG948d2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186841; c=relaxed/simple;
	bh=bzbnqVocaCxfmALbCmAFbfMJej/qbh3rRgH5YqAiY6s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fOIY7I7uwfPr+YeHCBx1HfEJZnLpDQchLo5kP8gAtKhlxYNhHL6kPOl/xGS8ovA1VZ3GRqMlXh4Mgy2kHESokzF6L+JJILQPoxwLVOkI1kN1mx3Z1j9HBDDrbACvPwZI+GU7nNrgX11QopwHuScmK8dxclTAns/veo7mKbyuKJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d7wjWBGn; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-390ec7c2d40so5155971f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 07:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741186837; x=1741791637; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZANWTEPPVCS7kbn+yeIU+DKraUb8OGsxxymaQwr00e0=;
        b=d7wjWBGnWEfdZMQX83pknwfXpvJb9TOzUAXH+ePFdPLwwbRRDJhWLNzuR4vtL2nvj9
         Z5hwOxP+MFBb4oZphkrzRBYjrswbIpIgjcGkJfDZHos9Bb4GaPNe2B+PEBTszF1+sfmD
         aPpqH7vPNeto+CPUlpPUj2J9agfHAzaLQy8aNRx+/J3JCnqdTgIelrhtqtq0NW53IatX
         wOlIc7loNNok0ADehUxn+DR4xroTuOR7/zN5QEc4hubRrfXhldUdEDrlqI2bO4QsgtqJ
         qENvTi/iGebdCBgs/AhK7KHYKj/x5L3Tmlw25f5PPx9ZpSQ9KnQF+9zyIj9qNFq/+Tpu
         ZDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741186837; x=1741791637;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZANWTEPPVCS7kbn+yeIU+DKraUb8OGsxxymaQwr00e0=;
        b=pg0wd8Zjp5+ypRKUlCWOrL6PRDF0KjN/44x8e4eYoADEdSCIHxpkgHIJV4n2iXkpOT
         1wgh1i2OGNCi/s6A2e0is+AaaO+eiMI1VG+p9w0QQ0Z/aB0vluDMyf9/XGh9xNWIsNSi
         yOIyMZtQADSDQNkYiOtwo/AhhpmB2GcUjAdbvi88iPFwhvTRNbJ8lCcEg8wTYHVnmmnS
         HCyJbVQmNHIZoUqSy1bjKV6HBeafuOGKcVVLb443URFHo2WPA7CkU4fUWS0MViSnfX8E
         tirir9W4xWUhN/B0wKzYF7rcurvjvsIO6YYWhfzlQt/viPXO/JGXBGlt34R7M6WuKmnR
         0l4g==
X-Forwarded-Encrypted: i=1; AJvYcCV2N/JCObWjvTdOep8vdzZf6nOw2mcgSWXjimRPqKOGQzV4+mjo9YzXTNMSyucN0WrV7FTMZ6zD+TUaCIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHwSlK2Y8QVWt4Bas5BC0utmRkSL4p2EbOzFq9aN8sWsR2CvI/
	ek6sXMsU8dQ8x3wJvKWbfKz7cL31R7Dk1y2R+2I2Nj8bwaukvM1615nlCmHGwWU=
X-Gm-Gg: ASbGncsD+laSu7HTWmw5iy/S08ULKtbp9mJTi9kEbwG8BP7ope3BCt0/jmgECHVIwJp
	y52iUOmS1kX+FbCbOPRTjdfy007/9GIdE70OmxFCseB025P4XToG1ch188USZiEJ3diiLf6SLs3
	nKPvETr10aeg61a9FpgN5IpJ+38wG8WxEh5aUEpGmq/7mWbzaTjMr0k/O4NMG3Rqn2ZgRrcVktT
	RYGSu24x270LZepmEK3gaqFPEGLS+QGax0Kr6cFQJSkgDQtYsKJlJQNP9B5uAvCDiPW35n0zdCU
	NP1ro4o93/lsalM1STSE61tHqhmZiS7I/jH2Sa2S+WgrCMxhJA==
X-Google-Smtp-Source: AGHT+IHaXShFpWUZrnjuQ9xahJkrprzqmBEW+AnaFKuI1m235GQthfy1Zavq4gvhC9Eeze/MbuNM3w==
X-Received: by 2002:a5d:6d07:0:b0:38f:3224:660b with SMTP id ffacd0b85a97d-3911f7377fdmr2631065f8f.22.1741186837476;
        Wed, 05 Mar 2025 07:00:37 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e485e61csm21592653f8f.98.2025.03.05.07.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:00:36 -0800 (PST)
Date: Wed, 5 Mar 2025 18:00:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] afs: Fix error code in afs_alloc_cell()
Message-ID: <26a4651e-b56c-4350-8f9a-e0e2a2a3b452@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Return the error code if idr_alloc_cyclic() fails.  Currently it
potentially could return either -ENOMEM or an uninitialized variable.

Fixes: 72c52e46a517 ("afs: Change dynroot to create contents on demand")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/afs/cell.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 9f6b7718836c..dc56b0203b53 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -200,8 +200,10 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 	atomic_inc(&net->cells_outstanding);
 	cell->dynroot_ino = idr_alloc_cyclic(&net->cells_dyn_ino, cell,
 					     2, INT_MAX / 2, GFP_KERNEL);
-	if ((int)cell->dynroot_ino < 0)
+	if ((int)cell->dynroot_ino < 0) {
+		ret = cell->dynroot_ino;
 		goto error;
+	}
 	cell->debug_id = atomic_inc_return(&cell_debug_id);
 
 	trace_afs_cell(cell->debug_id, 1, 0, afs_cell_trace_alloc);
-- 
2.47.2



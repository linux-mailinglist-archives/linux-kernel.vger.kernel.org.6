Return-Path: <linux-kernel+bounces-347165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E3F98CED8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB2F1C213EC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13393195F3B;
	Wed,  2 Oct 2024 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iqbyeiEZ"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EDE12C491
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727858246; cv=none; b=RF2I8nQ+K8CPZSmH25R+DEUxI2FbfTMfVcQSymfx6nTjATCdfZnkfMdH7i4hZ8lFV1X09h73AbboWzFE5RJFyK7xdusIf5JVUbakPL8qF4I9pQ6+ss0OjU69PhmqqjwHH0dU5KUbRFzBdR1gwoiXDfzUMpkzDScFON5tKdqE0Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727858246; c=relaxed/simple;
	bh=5UtmpKTC6s7aR/Kx7xCErhbOSCRB0a7wTRFcnUYaloY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KpXhrbYL1TB2e9rq3mpYhFZg45abls4dfhfAdway/5zz1eS3uTKrxv+YGeY9V/v1mgArZtuxSsvmlk45S+1EZFJGdW1w+trs7AAHv08gAZTD+zHI0W34lEg7GrTiL3pu1Ew7MksGyYcwhc32MrWud1CYdtT4lkYrIBfMPCrMObA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iqbyeiEZ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so78900235e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 01:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727858243; x=1728463043; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lwtFbtkd183rpnaZw+BKnFd/0fPS/fmbq3h2h43pXac=;
        b=iqbyeiEZFXBxw1hoXA3arK3nDN/3FxlivC5bGLMnr2BOfVj9JDIiBP2v+TX/t840FL
         4FZmSCxPdz4QJ3O8REfIfN5gaUjxgGa8w8NQ6rkKEjh/dleVHhYJV/GI6SaQf3x1+A04
         zuVQI9GLbKquUA67/LdM9haUl67hUKHAtf4cG/kEZCX36ZFyRMK/dUDM1o3rejr63xFi
         rVM3qejR33B7nEctG6TxkTrCK5XOYzu6sOgQIwDq55KBqo51LLP3kwImmH4CLaFTX135
         qyEU30b2zMEXTP1iFdKTZyw7rND1dfDpTtZU28c1C9LsBEhBgX5CjfCL65mQc4ErQJuH
         Wz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727858243; x=1728463043;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwtFbtkd183rpnaZw+BKnFd/0fPS/fmbq3h2h43pXac=;
        b=PqzWPEBYqCBhQhdns83cBXRZqijY600lcjAQVFb5asQRmGOdUOK4525/wqRP2gZ2+n
         u6raARm4trtJ3l/+LrghCH5Ga9VviMvfDhpWHDFDGiA8SFO62idj4TFCuyU9Nfh00b5W
         SLP26Ny+37frMLrF/piNdDItvQFc+Lrw+gGVj4278ZSsR/E58SLGYoam7zY3UySMzkUm
         DKzvIHhek2Y2QscHtnLmzQXpN/xczB3nnB8edvhNWSy1aulF1EEE4l0XdRGMOLBxaYQn
         NYgBs4IsG8tZe0e42Op4Yr2syahgz0aUWxeWewpbR1DZTKZFzJJahType041IlEdtdLo
         kOwA==
X-Forwarded-Encrypted: i=1; AJvYcCVxv0ROtL0hHgid7i4FptgAtTHgHgbkJoWRy58jc8RxkCRP0XqlSqoflWwgorme/ez8QI1JPlFMuVMhZhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUGlfr2EVHmomb8xrun5IkZ3iSpm0ZgDe3Kwk2TAxTfb44FtcU
	r4r8JW/UaQq4RrtI6FujIOtPwfovE2Hqhh9BKHyE0rPUWIpxmkjBnAgvoc6GoOk=
X-Google-Smtp-Source: AGHT+IFyXIGgjS4nrzyGishoIwlJ0/HhWx4Q7ZAnaJaIoZpCox8FMcIDZsRd08onTWLvZez1AhemTw==
X-Received: by 2002:a05:600c:350f:b0:42c:b8c9:16b6 with SMTP id 5b1f17b1804b1-42f777b1f87mr21363975e9.2.1727858243109;
        Wed, 02 Oct 2024 01:37:23 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79c67c5csm12578895e9.0.2024.10.02.01.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 01:37:21 -0700 (PDT)
Date: Wed, 2 Oct 2024 11:37:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Dave Kleikamp <shaggy@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] jfs: Delete a couple tabs in jfs_reconfigure()
Message-ID: <12768f55-47e6-4bfa-aa63-0a82b911e098@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This is just a small white space cleanup.  The conversion to the new
mount api accidentally added an extra indent on these lines.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/jfs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 223d9ac59839..508666d4ed01 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -389,8 +389,8 @@ static int jfs_reconfigure(struct fs_context *fc)
 
 		if (!ctx->newLVSize) {
 			ctx->newLVSize = sb_bdev_nr_blocks(sb);
-				if (ctx->newLVSize == 0)
-					pr_err("JFS: Cannot determine volume size\n");
+			if (ctx->newLVSize == 0)
+				pr_err("JFS: Cannot determine volume size\n");
 		}
 
 		rc = jfs_extendfs(sb, ctx->newLVSize, 0);
-- 
2.45.2



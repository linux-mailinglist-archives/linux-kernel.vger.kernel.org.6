Return-Path: <linux-kernel+bounces-174562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A17F08C10C9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5774D1F22EA9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA4915E203;
	Thu,  9 May 2024 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TFX7njie"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41B015B57A
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715263378; cv=none; b=hsubOzPXqkfYfC/kMIFuR1cPQLTyrqwvRdigx/8SrKRI7eXdRqW3bhW2pMMGAEGd8G6ILhy3r5LnPV7urLUyrMqDvqQ6cwNMh5hxhRivfUJEqOpuDORpHieho1hvO2YxK17NrnWDVKH8RNh96L0FneyrrjdlOLSoeelCNxhHml8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715263378; c=relaxed/simple;
	bh=Zrya0cLCaHTIuELWgr/YU9F71gFAmb/XIFZi25lG1IE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JmTNq1M0tuMq5WsgENFEnY79srinmTsUVm+8NSqZ4dmEo3eMN7EAOyGDj1yBEvm7V9zXOIWS0eV1eAKti1nRpaoovXZHymT6OBc2baHuWAPxXF6wdtY0jXB2vaRCc+q3C3R+dUYUS+6pCZhpc0SFMTrnqTOyZSHXAfeYkKAwWnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TFX7njie; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7e18fe3164eso7540439f.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 07:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715263375; x=1715868175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufpbLodsc5WaXfeBOdS0WL27KMSEA0vI+DAfiOcwlwA=;
        b=TFX7njieFmrgmDYbyMoFiB/A/z4GsadDMdr+bCifWUOQ7VT6Fb9LHIBfwL9OGHxZVC
         QgvDHwV9gWXOerzwxu8JBv3PmJaXvQyzM4tEu2i7+xmSHy8QLfTQNWALwBr+qPgBpTUH
         8r5uCZLMcRBbXQG/lbB7WSPfXIW/7EuFFOicstTEdzYzLULq45fnQShp2nyL3BsD6a0U
         Or6dCa/e9QBHDgiUrYuMVgKaC8oX1BN9JW7sXcC7Sz+HINVeVv8QSqHOTcQBLdt22bo3
         ou95/TrpswTkxuJpt2QdUj2gc3m3YEe+X8RwzzHu8Nz3Ki/kUR0aiZJeL3IXq/EXBwPC
         AhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715263375; x=1715868175;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufpbLodsc5WaXfeBOdS0WL27KMSEA0vI+DAfiOcwlwA=;
        b=C5xfMR0ez1rwWTi2mFgpojsl87Q7hV0UnRmak2wnBi7jm7GdQLbu+4ABETheEu7aXP
         EMtYAaXa7ChHZVllmyUbfv7JBwt1TykYV12DBjLQL9ebYnPKLinrQelb+7qA/NVKXFul
         63T1oiM1Tk+CFFCa7sWsY7Ta7ne47BceURqyArmFWmjzb/cIu99oQYS0+bLJeSwwSSzh
         Oe6MnAcW4pPtQkmXw3b8W++BjXLELFFtT2tBxb0KBjEbmIfCO9qpn6+tXwhN9wzH3g3c
         h87/qP5mblqXi6Vy7Oq/7Bg7pHZzwLfYUGjKO8bPwsXoAKmlhHrGnKUOTS6v1edCFyY2
         GTig==
X-Forwarded-Encrypted: i=1; AJvYcCVMF70HmfYqchNTlmmpmxgLBtN4j1xO/wI7HCp3QTRb2qprcaoHtITjx766pKmSnYYTBrxlwjEhbGg7te+sDAKTH6j9mgzn7WhEFD9K
X-Gm-Message-State: AOJu0YzubLakL04ygSAr+ASPvr6Vx+OkLlu69ptjiJ/CUTcesUoij7Vb
	mMbBdFlnRqfv73h67N+vbo2tji/5jcES9BqBu+RHNsQE1x8ZPecy6bl0nVTHHwqcP3SDLkexrlJ
	Q
X-Google-Smtp-Source: AGHT+IEawoo9hWTqQm/T2m38iKn3A3hDEkv//CtPbk54RYHBwdvBENkXLi3LZfeVu+Fh9LJT1Y7Q+Q==
X-Received: by 2002:a05:6602:4f4f:b0:7de:b279:fb3e with SMTP id ca18e2360f4ac-7e18fd85e4dmr568382239f.1.1715263374782;
        Thu, 09 May 2024 07:02:54 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489376fb1f1sm371961173.163.2024.05.09.07.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 07:02:54 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20240509123825.3225207-1-yukuai1@huaweicloud.com>
References: <20240509123825.3225207-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH RESEND for-6.10/block] block: add plug while submitting
 IO
Message-Id: <171526337415.20280.2523884400522839177.b4-ty@kernel.dk>
Date: Thu, 09 May 2024 08:02:54 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 09 May 2024 20:38:25 +0800, Yu Kuai wrote:
> So that if caller didn't use plug, for example, __blkdev_direct_IO_simple()
> and __blkdev_direct_IO_async(), block layer can still benefit from caching
> nsec time in the plug.
> 
> 

Applied, thanks!

[1/1] block: add plug while submitting IO
      commit: 060406c61c7cb4bbd82a02d179decca9c9bb3443

Best regards,
-- 
Jens Axboe





Return-Path: <linux-kernel+bounces-232623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1571591ABFA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00A71F223E1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6AF199239;
	Thu, 27 Jun 2024 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fuk1xnbq"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553211991C2
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719503742; cv=none; b=Y3BoU/L5I+lnq1vOBDyjvobKP4dtnkQ3tjI9Ec9Onyjr/9Ywgkzkg0sCs7MC3IAsGkdykhqmtoRA3obO+8XDwz/6CRlISuid8U0IIYqs40zyEv3elQshzoWfC8FDtykRL5KBBs+FqaBBUbq6HnKP8R+GJ4SnxUjYJLc3B/Gj1I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719503742; c=relaxed/simple;
	bh=a5EXa5AIoXgs+7OGu67HbaGGuGx+FZTfR9iFz+PH/mQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kK5CE7ds7oGqu+ipQzopswjZDMOH8qlSfVY+XGvMDk2CR1nBm47BaSOdpczRt06fMCH8O7LlBb2KJOLtDfYr3Q+RQqaaUOZgomUhqxcp9anEuUz1uHlZkGvDwNF9lTVGnwa/3sMkoza47ZQaVy/YYgYZAxPS0Dc7nHDCbmdF3hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fuk1xnbq; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f9c4ec8e04so3579645ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 08:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719503739; x=1720108539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56oXuAFY10ag5uJ3pg/ISq//+a8g92sraucL2mJFEYk=;
        b=fuk1xnbqaBj5yJWu0kEByURU0xzp/DUeaHY8tE3kF1KKmDJzbme0Ovw0ooaUBXxsSh
         UH8X3VAQu6/gwB2oOzssaoIp2FWtoSICwlVMix57X7O2rKwd6sL6v9glLRbRn9Vj26hb
         9Ir4A+wOOT3hWxZwwObNOuNGOODphV5h84CTvfTrTyBqBxk5XrycufAtyPap/Owty1Nz
         9BAVZYs+g4q2aUS/vYf2b2Q7qcrA/VH2qO0ttP69tFL3VB0zJ/gIKsmtLjqvXSnnk436
         WaCg2LteBKDOU/LFtcSo6cziSDKTs+pqmd5EXRBAdY2dJ3YV0WVZ5xjyYEtWz/MHGZk4
         Xa/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719503739; x=1720108539;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56oXuAFY10ag5uJ3pg/ISq//+a8g92sraucL2mJFEYk=;
        b=lvL+Qu5+xYNtd7pLGz8bW0G/WgFB3xqSznA1GT+ucqa89ITAkKeEGSc9vbpDPpRN7V
         t3onPltk0ZfBlEXC6aymhwuVM6jWw+7QQ12snfA793/6l/eiMXuKmx6y9BUjPXgiaDSc
         dupF2C/4M81XQG7VXFCMr/ShTHew5+p36X/FmTc3w7Sy/vxhBadQprg1mwBoLlScoFYz
         nfv5i9AqSA3C3f5amGNbRk4f1tSiv6mGtP6fGIiwrH9GgKOhP42Wb4kneDne6DzAWxg/
         Ik+FB2+c/3+gY365I2g4kI9K/3fdynzgplDynfYgMx2Q5QRhL2xwq1wondkOLpWtGCYL
         Z/gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnBaU25Nx2Kh67VJZieAKvWIFHGbOfNew8dnv6SlgWTdmgZAMvOh+OPepzvkNR18qf+U2VnMqT7rAWgnr2Zr45DcLaueiWUQsh612R
X-Gm-Message-State: AOJu0YwtxsiowDvF6xcEYwAcvkBij8w+ZB3JIbDLLpnnTlopb2HgqnYl
	zvfd6tb7TDISuOOZZgQaRZpqTPwyvgE5hXmmVUc7IV0QDaKkbAhTi7GM9UdwBAtQZPepLwh/5a+
	/vXI=
X-Google-Smtp-Source: AGHT+IFbSTTfwFHFdl0iuWEaJ/3Gnh+NeRphNIwjci4f7UloiWVtdW13YW0ru1IJTJ/xGwQnMc650g==
X-Received: by 2002:a17:902:e888:b0:1f8:6e3f:9e7 with SMTP id d9443c01a7336-1fa09d94a65mr168670355ad.1.1719503739336;
        Thu, 27 Jun 2024 08:55:39 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac8e06e7sm14965665ad.6.2024.06.27.08.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 08:55:38 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linan666@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de, 
 yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com, 
 yangerkun@huawei.com
In-Reply-To: <20240625115517.1472120-1-linan666@huaweicloud.com>
References: <20240625115517.1472120-1-linan666@huaweicloud.com>
Subject: Re: [PATCH] block: clean up the check in blkdev_iomap_begin()
Message-Id: <171950373822.862512.1110840409079088646.b4-ty@kernel.dk>
Date: Thu, 27 Jun 2024 09:55:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Tue, 25 Jun 2024 19:55:17 +0800, linan666@huaweicloud.com wrote:
> It is odd to check the offset amidst a series of assignments. Moving this
> check to the beginning of the function makes the code look better.
> 
> 

Applied, thanks!

[1/1] block: clean up the check in blkdev_iomap_begin()
      commit: e269537e491da6336776b5548a3c73f62273aa15

Best regards,
-- 
Jens Axboe





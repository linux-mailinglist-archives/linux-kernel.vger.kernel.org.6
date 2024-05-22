Return-Path: <linux-kernel+bounces-185659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC698CB885
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9951F239B9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595996AB6;
	Wed, 22 May 2024 01:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VuXbFkfn"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B26A4A32
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716341910; cv=none; b=L/97B1XZDJmAQTBzSyyONBa52+ocS6MEuU7Cf0O+Qsx9MX7ugUxdDETgAGBD7KZFbbB7gzqaUp/XobcK4OPD1HePjzToiMNk6nRlsn3mCgJnbXh/fzorNF0JlGFIdAlaKsf58QBxp6c7unG1QsGX+EJRF7Yt0nNee9hvJ46uTGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716341910; c=relaxed/simple;
	bh=+mlG5M6yipBkInLeQL1LC41ZZD598ahquvQkC9kLD6I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Dr39KlV0kcZ8e06EZZZHcJLS38g6Fjjy/mTnnpjGem9dv+nZbU43GbpH8v9AO7HwkBCy/vSUVrx9VYhQCYOOprVxvD6Tbb0/TzaVM5flMgH3edfx+3B1QNXZYsnTm/LNLUjvnYPw+LDA9PmmD4P6vcUH7Pt/Jzz6ks3scOcr1Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VuXbFkfn; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ba0bbc7302so386706a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716341908; x=1716946708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+9UGtSjh9xn0Me1z2qK9sQ4BQmIY9y6+8dvOoPm3tY=;
        b=VuXbFkfnFkyQyzaLqBbpBE3z3xgqva2pUJRxaBEIvBFg2TOH1DeiY7sdv2olwW1Msx
         6cMU5jJO/oVU20QgyD9dQKq2+M7s42DMr8fhPioGtz/wIlRMQPmbe2/Ap67Q9stAs6j0
         n3UdLNCRbxkSb/XwGDlaIUwyFK/UJL2VnWCVcbvpHJfej52NyQUNWHD7mVqxmIU2DZqq
         bx2DuPOPyNL2zqercQGgkf9H7QrCep2fNWkyEF+8k4c4eOJJNmT778RIabVB2YAZGoq3
         cQbq+9mseuzDRiU1WP9YDRqiTKXFZnhLE3tGIO1MPctMNhDOQqRD9lk+knSfB/zuQD50
         hvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716341908; x=1716946708;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+9UGtSjh9xn0Me1z2qK9sQ4BQmIY9y6+8dvOoPm3tY=;
        b=xB6Tsv5w4nkwPxXDiO75OHLWZuIIl0LKDKPu0uGpyI3iNYthDM8rtMh85ZRA9ybIra
         HUdtuZDlgkbIPhCTm9MrbTLhi1ZuNtz5uN715zoG3G9KfVmRzLluJ2L0Us6homO2QnPt
         h4OSdwmIVM9kthGg/gzI0xX88G6YTB4aYunGkoRH2QHf405ucyALpi4praeDe9+oxmPZ
         SJh7/MV0Rp1Ek+G825BsXJhkdFJuDYgSjF2SI8APkKkoKb50m9YlPxIglu3zOOs88oCw
         j9C9Et2Tsy8xuyFRmaaLOXrREJbaPFZKDX/pOoWJmF1Wi+s9+LrWPWFFCmNT4+vLmNiA
         ei5w==
X-Forwarded-Encrypted: i=1; AJvYcCWH2wPpNzr8Zn7s83Z5OGuuM9ASfoR0hPFJy8yg0niNMYYqBdD6uoZGNrC+W4b4BmxNhK6JQUny2lM641A50pN64LZdZROS0kzA0ECw
X-Gm-Message-State: AOJu0Yw/iBp+aMK3CtyNxXr7m3eQ9h2rjnwZOpZNrjczovFULhFxylHY
	bfYjYXZLXQzz9Zz+wFznNl+vEnkNG6wKwYX60ySt/8Q+TLd8Rxw+hOaGe6yJVEo=
X-Google-Smtp-Source: AGHT+IFfJ5agvxxUiwDDs5QIeTouHgFowXo7ajcP1fcRKYdmn7iofjWVDqVqIe5tZ1vqC/9UAh/M6Q==
X-Received: by 2002:a17:90a:a617:b0:2b5:fce8:59ef with SMTP id 98e67ed59e1d1-2bd9f454b53mr781733a91.1.1716341907727;
        Tue, 21 May 2024 18:38:27 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bd99fce5a7sm778694a91.12.2024.05.21.18.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 18:38:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: czhong@redhat.com, xni@redhat.com, yukuai3@huawei.com, 
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20240521200308.983986-1-yukuai1@huaweicloud.com>
References: <CAGVVp+UZ4stcktsHw0r8ks8LCfXvYJyT+zv93wEfGuuLswArnw@mail.gmail.com>
 <20240521200308.983986-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next] block: fix bio lost for plug enabeld bio based
 device
Message-Id: <171634190662.41601.17421238883193009305.b4-ty@kernel.dk>
Date: Tue, 21 May 2024 19:38:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 22 May 2024 04:03:08 +0800, Yu Kuai wrote:
> With the following two conditions, bio will be lost:
> 
> 1) blk plug is not enabled, for example, __blkdev_direct_IO_simple() and
> __blkdev_direct_IO_async();
> 2) bio plug is enabled, for example write IO for raid1/raid10 while
> bitmap is enabled;
> 
> [...]

Applied, thanks!

[1/1] block: fix bio lost for plug enabeld bio based device
      commit: 9a42891c35d50a8472b42c61256867b4dfcc1941

Best regards,
-- 
Jens Axboe





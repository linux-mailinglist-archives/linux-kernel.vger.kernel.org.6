Return-Path: <linux-kernel+bounces-323954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6401997460C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 00:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D47A2B24E76
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0BD1AC42B;
	Tue, 10 Sep 2024 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JrPRhMlj"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D901AB506
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 22:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726007978; cv=none; b=kUxugwavM1A81bWZLk1kILtGK1Xv4W/WEkNjIN3pl4jRNxX7ppdDDCwtz15BSnaI+5k/FSGmaq9U9YYZQ4MovVZd2gw7ZlNxCBZQwr3Z9U2P+wE/PYH3RmAW/sOtBsNLI1H1tmFI3DzwVTYdgnFnMGhH0R5nHl9OHpNM10DoaHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726007978; c=relaxed/simple;
	bh=pjZtiX3I24/dylwpsaxDdsLg57zYZcJN9pg9emc6ADk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qWfWDybH8ntqMl2Wdv1ZYFVOkTHF1JWMop31LIbGmvwjpcdX/wyWHgbl1lyOfHK4blPnoKWgbYPdma7Qa8tpIAscx+3b5yDGcWMGtSFSy+3f5d/b6WTTxIjdahcxClVNbSCjdJToxrHg6sYwPelOU5ntWZgJIUEAJfOdABhz0og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JrPRhMlj; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d87196ec9fso3911154a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 15:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726007976; x=1726612776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FigzNtvrWKZXxuePOe6tACCaPjx0X2YKNkQWmTB03Mg=;
        b=JrPRhMljpOk+QH14/2bwp976jpU8RrjFhUmzL6BJMeAcC/y/2p8I/C8OzUh6VWoLaK
         frOGbppGi8m4kT3yF3XCVIzZEKjnrv+DceePQ+GdNPYmfYwZPqoFrRmg/fF6V9BkOEA9
         0Kdv9TT77fpVu0Jd2nsiSE0PVLT3AeB+mrgftohzqV4in5QAc6/D/nJNYRYNzw28el0I
         sDgkl8Q1NhzFS34xqRuOrKfsZCuYORwQz6JqfcG+PTTFGn5NbFCu72CHSKm7hH3bDhCm
         jeNRXuxBAv3SKJRKLalvA8cfwvXBssYjKKeJRfB+fIdMQ32f/h4+nzi6kOWJmVtkBrvo
         ac5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726007976; x=1726612776;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FigzNtvrWKZXxuePOe6tACCaPjx0X2YKNkQWmTB03Mg=;
        b=dgne3R/BCH2mGs1NTwvvUbKy2IVe5wOLSDsMybC8+fe7a//NHzsklcQHohq1PEY6H1
         YmhN/ZVhTQIjAh3tHLwi1t5HNLS8GlXZACS6MmW1sPp5vCyqOex4PFbcfar4dsiLZzMo
         +SEPjZs5FjfGhRhhQ9ykzlyq+vtJZAMbLoe1KqBugTV9FSZiLFT0qT9UeKHBMswHwQ3X
         wSVyFyG6/uzhfFFp2HT6fulpfGICcuM+9dfqomc+OsYSWnopfN2Vya9g8PSdYRTk9wIX
         2L9mY6Gs29erT6umNrNPbFPPpSe+VwblagFeW51FpwF02k90SbwR9twmRrSA4lSwfEnf
         3ISg==
X-Forwarded-Encrypted: i=1; AJvYcCV66hxdRvJnPwUgPKntrLAZ+niXh02hBfH8ds7vK6GQZDXYeaF5z/lMcFRCmJ3FBZT63lw7oPP38ItsyEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaxnY2iMHEku61I87B+hc6iJxgWH0+79rDGZfCpZf4tGLoY/RK
	KQy9w73KZXfCNfqw/4QLTcFuUwVpYxzAltV10soLNlHb4AcNIHahR9dI9pZIsuY=
X-Google-Smtp-Source: AGHT+IF0GR1i0sQ5Ook6LfpBSmPCQc8y7EcbXQCHLNWwVcaj/n7ugGPsvdjl+SA0g3BIZABPUKDddg==
X-Received: by 2002:a17:90b:1c03:b0:2c4:b0f0:8013 with SMTP id 98e67ed59e1d1-2dad4efdf95mr16206730a91.11.1726007975834;
        Tue, 10 Sep 2024 15:39:35 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc127c5bsm9023783a91.52.2024.09.10.15.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 15:39:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, josef@toxicpanda.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
 yangerkun@huawei.com
In-Reply-To: <20240903135149.271857-1-yukuai1@huaweicloud.com>
References: <20240903135149.271857-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH for-6.12 0/2] blk-throttle: support prioritized
 processing of metadata
Message-Id: <172600797465.158663.18224445908631477542.b4-ty@kernel.dk>
Date: Tue, 10 Sep 2024 16:39:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Tue, 03 Sep 2024 21:51:47 +0800, Yu Kuai wrote:
> Yu Kuai (2):
>   blk-throttle: remove last_low_overflow_time
>   blk-throttle: support prioritized processing of metadata
> 
> block/blk-throttle.c | 69 +++++++++++++++++++++++++++-----------------
>  block/blk-throttle.h |  2 --
>  2 files changed, 42 insertions(+), 29 deletions(-)
> 
> [...]

Applied, thanks!

[1/2] blk-throttle: remove last_low_overflow_time
      commit: 3bf73e6283ef0bae4e27dad62309e50e3bf7ee88
[2/2] blk-throttle: support prioritized processing of metadata
      commit: 29390bb5661d49d10424ad8e915230de1f7074c9

Best regards,
-- 
Jens Axboe





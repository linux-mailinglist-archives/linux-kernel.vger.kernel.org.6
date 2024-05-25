Return-Path: <linux-kernel+bounces-189436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BA68CF005
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 18:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8B7281D2F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 16:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F95185953;
	Sat, 25 May 2024 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SC81kv07"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDE21DFFC
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716653384; cv=none; b=EiSh0OT6lX2vcw94aBl8OymY+k8mTW0byP99C3tG/GMT8vA9cTEAr665aFml7hnc6tW53GeXtpwadZsRlFH+juAbQ5iT+BuI3wpKb7r17MuHuCD+b0yzhjnhE6u1jdAs656RcAxbEXTQLW2C+UqZPKf/aB0WXiGhm4UQoPW3QFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716653384; c=relaxed/simple;
	bh=OPficxHWk8bwHHYtAKscq/o1og6MmtSjXjhRJMxGzYg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bsrQ89CbI+W3W8opgyl9T9LeTcg9qoTERan/4MNbks6a4COHRpQ/68wkqcLubC9lxJYVuDqXdImQwhaQruDVPZ7QvHOu4/uAOn7M3LPkcWmlFjb2VeMvw6gDPg5WlgMuDsz6cZZc0kloTGyhXlfVhqpfd0FXBgsw7ononpnNnA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SC81kv07; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f44b500032so321525ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 09:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716653382; x=1717258182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OBzotavdEJ1R+hPrLpZfVYcvCmreaa9Jw4a7xc6rwA=;
        b=SC81kv07fVEXtcz3Na3bo70tfDl6JaBqJlkXaJksnh25B8wfmg2s+ys3PVrq49EmQa
         5klry6HIW3RLclQrZ46RLap0M4cqUiDvaJMd4xcXHz1uA+eUbO/JPEMOhraUseudTvZv
         aDCZ7GO6B/4U+9bjXyhwaLQxoD681XhJmGkZ4ERNB9L3DKoBn82WrK47fmFqGANaXzfO
         EqrlrJsArvrQtPOvwdN3VZTDWj74dYOW5eKl15t969/MJkrgsEfkMi38o5+FB67mQR1Q
         YjDMHQEyBwqZp2qtuVDyP0Q9U7A2Dlyyd0Ob/hpKbPhqSOHQ4LRfsXst2OfRfVbYZ1Ow
         Fj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716653382; x=1717258182;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OBzotavdEJ1R+hPrLpZfVYcvCmreaa9Jw4a7xc6rwA=;
        b=iKDP5aTzd13aVWYQttYDp/1aQXy82Ql610HUAyq0qzraNdjyXGdZ1QVhWCCLXWCvDy
         guVRmyMBw91dYpNYHIdNRSeqcWaUFmWSy4gRhicgtJqOpNlKnXFl3OGOjsMQBYEJu5GB
         Fp72YPFE6t8+1qI4RdK4QyUt2S7vBc27No0aPwQBXX4TaMb5JfWCoyIMUQ8oyIPg2GRb
         /H8/Srh6vHWKpiO+HriJg5Ul28M1VbafEjTdXVP0Ho0XrgL+kWB7PmrWB8iGXucKgyQz
         05NF0O7+h++4564MOhwD4IrPQY7CuSM20zMnyU6NSPtCHtELUam+/j4dQCUN528iFgsY
         dG0A==
X-Forwarded-Encrypted: i=1; AJvYcCUQYl3sAKMDe9VSBNPYMBaNxc+5PB8yTrnr5RufkZU/QL9q+99kwWlT5NKg0jxrpQmazmajac0Agzqx8iSoZdlDOVK5p1jiYilIlxYS
X-Gm-Message-State: AOJu0YyfBPizlzTAnuHK8dwXn4j3LrtVJCDMEKoS6Eu1iOdh3nfYZPCg
	n9/Kklx7Nx2Ul5KORjfWpv8bdHZ1IzjqSYCtTiuNkBHt4sYrkTC8rgHMX1LodSY=
X-Google-Smtp-Source: AGHT+IG/V6epI7I8Utje/XCe2cdaWrcaMvGwnulElISoQFT9atBOBYGM72rEYRjmT7cxt2h4C/6dVw==
X-Received: by 2002:a17:903:22cb:b0:1f3:889:ee2 with SMTP id d9443c01a7336-1f4486b07c9mr57455445ad.1.1716653382055;
        Sat, 25 May 2024 09:09:42 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c96ccfasm31974765ad.147.2024.05.25.09.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 09:09:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: yi.zhang@redhat.com, dlemoal@kernel.org, hare@suse.de, 
 johannes.thumshirn@wdc.com, kch@nvidia.com, zhouchengming@bytedance.com, 
 yanjun.zhu@linux.dev, bvanassche@acm.org, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20240523153934.1937851-1-yukuai1@huaweicloud.com>
References: <20240523153934.1937851-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v2] null_blk: fix null-ptr-dereference while
 configuring 'power' and 'submit_queues'
Message-Id: <171665337969.160479.8933222085761129078.b4-ty@kernel.dk>
Date: Sat, 25 May 2024 10:09:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 23 May 2024 23:39:34 +0800, Yu Kuai wrote:
> Writing 'power' and 'submit_queues' concurrently will trigger kernel
> panic:
> 
> Test script:
> 
> modprobe null_blk nr_devices=0
> mkdir -p /sys/kernel/config/nullb/nullb0
> while true; do echo 1 > submit_queues; echo 4 > submit_queues; done &
> while true; do echo 1 > power; echo 0 > power; done
> 
> [...]

Applied, thanks!

[1/1] null_blk: fix null-ptr-dereference while configuring 'power' and 'submit_queues'
      commit: a2db328b0839312c169eb42746ec46fc1ab53ed2

Best regards,
-- 
Jens Axboe





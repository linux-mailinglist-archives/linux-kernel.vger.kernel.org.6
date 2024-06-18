Return-Path: <linux-kernel+bounces-219740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C117590D7A3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7496BB3812D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4FD39AE3;
	Tue, 18 Jun 2024 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iTzjZ7pG"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323F22C87C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724198; cv=none; b=qw81P8sGTeGCqLRJBrJ7IZkx0pSpswHksoLUarC79B+w/JEczqCjjD14pOGeQbZkKq3SwoVDG8CNbgxcpJsYQ6EfZGx99eW+2rnAszQ+hLZY7dOnhXdJEbBD6LOSLr4GanxwobJz8bIalD3t3JrkkzKea66ch5Ty/DCqzq5o7+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724198; c=relaxed/simple;
	bh=+UaewZqjCk5jggLlt8A+UFHLlspuoZhO4dFuoF9TpFM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cItdY6P7Hk0CiGJrZu6/AowIP2B2ZWaTfkIAsHzJnXkC/GKcQ3I/HAH42tNAPMhIptzLnnFHhRVisxzJoNtZlM6UeuSc9vE2IeswpsLQXLiE7kO15ivUtvWqRJHwPvYE1tMtLKXeh1VmMsmI7MM1jksS/WpQNCSAFhAu0pBghJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iTzjZ7pG; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-254976d3327so433306fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718724195; x=1719328995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6B91qQWLpG+1qHBWfrmUdTmQo/hqZ9PHbgMbp3vqmw=;
        b=iTzjZ7pGwvyEpR7l+YBlSWG2eTwTEkabaTn/t/Yl13KhBBsSqepKBmYuKnaqrwJXkY
         Ulq68qJU+I7MMa+TQ3eyP+30xvypFj+KUJStruDvOH3boEIgp3m5nshVj7W6AwfXa5j3
         hUAgAxeNiREJzTtvpoD9mQCxkPftGdT5G/NRxjaNfgeacRzcIfleqxiutRhAm9i1RC74
         dOrK7uqqvmsaBE9wBsbU2Of2Qpsx2QeNpOEJN3SFTT8B8IYTG7f3ftkKkBHjEU04j6d5
         C9hJHxSbQMgIii5vDU5x0KLzspaVKaU++vMEsZOEiB2FNPqpaJCJqFVQ9puuVBCFtO7c
         PHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718724195; x=1719328995;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6B91qQWLpG+1qHBWfrmUdTmQo/hqZ9PHbgMbp3vqmw=;
        b=T188grgEX8RBkOL6L/5FwjNygEMJC+BaIHOK/0yuWyrFicog816b8OOX87pt9NdnTp
         saGYtkI9hdcICmuKzaKpHQVhGc0/OGon1yIuRr4PH1W2m3JroeEecx2iL2G5UkIohRcg
         epkAW95Bji1B3AjMyTBrG089ZHvjA3+HGWLrxOqplA296nJr8MHxXXoF70xF4pZVDzZf
         LehcGVb2t/XY0BfFCEoJWnYPd9FYXl5bokF4Q9H1VwXnONRl15c38f2MhkrM3viQbeCw
         0OgzDqAIH40tXhZsIeY6fZEw+SaAemnXtPTjTHaMS8orNoqVe88MryhNqoj7gSwDzEOe
         YHXA==
X-Forwarded-Encrypted: i=1; AJvYcCWEa/38psfRBb367XvC4VdxKc4IL3ZXQ/J49M887WdCe/0bb7iG5sKXfxMTYh33jzTPpWXkvJVfRhveqpquVjFRwycV2Y4HAxLlLJ5G
X-Gm-Message-State: AOJu0Yx+DZ+xWn+CeMYVIleQI+3XZ1f5fnFu5xyGqU+c1KMgfHNdVAb4
	V9o2m9TFr7ZML5k9uurKm93VklC8h+hnVyXlUjXJhgM5+v/Qo5MGp2WmINwnm6I=
X-Google-Smtp-Source: AGHT+IGFP+kdLoxpKQx3u24Cy0x7mExeMSZbDQat0SWP9aQxiPjEJWd4R1hjeoSMC4kDIYRzSdOcQg==
X-Received: by 2002:a05:6870:1649:b0:254:a5dd:3772 with SMTP id 586e51a60fabf-25c94dd4630mr96618fac.4.1718724194955;
        Tue, 18 Jun 2024 08:23:14 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb5afaa06asm1862377a34.6.2024.06.18.08.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 08:23:14 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: jack@suse.cz, paolo.valente@unimore.it, tj@kernel.org, 
 josef@toxicpanda.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org, 
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
 yangerkun@huawei.com
In-Reply-To: <20240618032753.3502528-1-yukuai1@huaweicloud.com>
References: <20240618032753.3502528-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next] block, bfq: remove blkg_path()
Message-Id: <171872419391.44295.6483908119531238372.b4-ty@kernel.dk>
Date: Tue, 18 Jun 2024 09:23:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0-rc0


On Tue, 18 Jun 2024 11:27:53 +0800, Yu Kuai wrote:
> After commit 35fe6d763229 ("block: use standard blktrace API to output
> cgroup info for debug notes"), the field 'bfqg->blkg_path' is not used
> and hence can be removed, and therefor blkg_path() is not used anymore
> and can be removed.
> 
> 

Applied, thanks!

[1/1] block, bfq: remove blkg_path()
      commit: bb7e5a193d8becf3920e3848287f1b23c5fc9b24

Best regards,
-- 
Jens Axboe





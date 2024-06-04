Return-Path: <linux-kernel+bounces-200795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B09458FB508
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 428FAB2440A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAD3179AF;
	Tue,  4 Jun 2024 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qYNTVHS4"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEE66FD5
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510642; cv=none; b=bkbNIEFetXiXzlEdYj/oVSkYKGvVXLnIuP21PTu7tR46Dg2F0KPL/NnGQCv7YHWEbFM5l7Cy4ZFPkPSn06LlTJE9NVBA5R9Z8hJ+as31Ykt04ThUZvQDQlx4YhaNJTco8ZrFoa5vwQZthe/M8qtkjdK/jq+2qUAgUNsj/fLTdkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510642; c=relaxed/simple;
	bh=huLSRBNy5PxQ3jwYLVFn/vcVsswN30JmnD1cxehH2D0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bO09Vw4Dl5QcZKsxnoVj/UL9/q+JPJ8QNOX1F0oGy894B+wp7KTmF2IykVkmZJXMmfVylz5hoeiDJmdH9gTkuQLEKtg99YqM9DxF20g+9pxr2uhe+CtqF0GGVTAD5/sQ9vOlN5Fe84PHkadEAMV8b3+ziigMPZlskAO687tvOW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qYNTVHS4; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f676798c13so86314b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 07:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1717510640; x=1718115440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkJ21ZkyQafe4wcLOoZRQCL0rFCtk91xN44Tj1tR6SQ=;
        b=qYNTVHS4IvdAf4mB2t4QLTaLfal+ni0NqtTk62hOgg1gLnOdvFw7NxzEm1AwB2dyp+
         BmbaIKjBP7SZN2pvldD2ljj7NeSKPzqL8OkG8JKwA7THp+HnF32CxrwCs/qUf0pXZucR
         xDMvTFNMc1n/r8xSJzsgi0UJPo+8+lmas54ZCLPT4/nvpeYXMMcfnLlNFvN/Mtk9Uoay
         Z2NGe6hXfJ1Z4yAmUFN9pbw/qOjVFsE3xKGiQOGprhy5lLe4S6UZgqQSSIFai+L/mQv9
         AqOIWvej78YbbUB9ZGevziDh8slWidamJ1YpKGeoG/OxiwZwaH0fci0wzLUmwY6lGJWf
         hapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717510640; x=1718115440;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkJ21ZkyQafe4wcLOoZRQCL0rFCtk91xN44Tj1tR6SQ=;
        b=WQXYSjerqenT/OpWEFPkgZiKin2nw6ey2gfQ+rpUvO57wU/1fiE6flXE4A23Mkjff3
         qh50+jv0JOw9MPMn6Og6NR0Q2Ohho/RdfRDYciZscgvBec6GGRtD8SfwSXYWoAgtGUgD
         1c3py3NSsdCDGvXvpF0BwXbce8lpqKsoR1DBoeTpHGoWytXcC7NC9wvuoi1DN0KlQ/sw
         RTA5q6X8z34NYyr1wSukao0YDpObG8H8S+jad7ibnXLXWudJCIBVvSgB0qFM08gxgFNj
         u8erMjsmkW6vwf4RFwhDARwZJoE0Y8PZXN3rrHUj+ImbHm0wlHs1a0RA+9dGyxazbao8
         JecQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWqdWzCABFgtYNMefOUmZPNcorXd04c2vQBGeQsPRhdvxCtmHEtRUxu/5T/4654lItHSeFyTSaBVrcrvSI+AoGBRlRcAknBpIU3GzF
X-Gm-Message-State: AOJu0YxrZUT8o+nXHuAtNI46dTrih8P2O6x+R+b9uF9PnBBwRTV556C1
	pLkM/a35wY4aJi6TOGSFyXxCgnZvmoc7X2rclTMskAFB/WCbh8Fd172JTHxtuLY=
X-Google-Smtp-Source: AGHT+IEBqulbCLQzbATvm9efh4+qHDny10+2m/uVMwoiB0wI78fd61USIWTQx0er3QwGUHB3JAc4cQ==
X-Received: by 2002:a62:e116:0:b0:6ec:ee44:17bb with SMTP id d2e1a72fcca58-70247899e76mr12225845b3a.2.1717510639671;
        Tue, 04 Jun 2024 07:17:19 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702541eeadcsm5396462b3a.150.2024.06.04.07.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 07:17:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: ming.lei@redhat.com, hch@lst.de, f.weber@proxmox.com, 
 bvanassche@acm.org, Chengming Zhou <chengming.zhou@linux.dev>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com
In-Reply-To: <20240604064745.808610-1-chengming.zhou@linux.dev>
References: <20240604064745.808610-1-chengming.zhou@linux.dev>
Subject: Re: [PATCH] block: fix request.queuelist usage in flush
Message-Id: <171751063844.375344.3358896610081062168.b4-ty@kernel.dk>
Date: Tue, 04 Jun 2024 08:17:18 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 04 Jun 2024 14:47:45 +0800, Chengming Zhou wrote:
> Friedrich Weber reported a kernel crash problem and bisected to commit
> 81ada09cc25e ("blk-flush: reuse rq queuelist in flush state machine").
> 
> The root cause is that we use "list_move_tail(&rq->queuelist, pending)"
> in the PREFLUSH/POSTFLUSH sequences. But rq->queuelist.next == xxx since
> it's popped out from plug->cached_rq in __blk_mq_alloc_requests_batch().
> We don't initialize its queuelist just for this first request, although
> the queuelist of all later popped requests will be initialized.
> 
> [...]

Applied, thanks!

[1/1] block: fix request.queuelist usage in flush
      commit: a315b96155e4c0362742aa3c3b3aebe2ec3844bd

Best regards,
-- 
Jens Axboe





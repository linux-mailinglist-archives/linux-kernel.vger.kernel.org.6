Return-Path: <linux-kernel+bounces-211957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA583905962
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643DD284F66
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F37183075;
	Wed, 12 Jun 2024 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VQL6jN6w"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D45D1822DE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211635; cv=none; b=fDvpy3CB04ED6mspk53WHnXag+xtTTxs0Ilk07FKP+GT8HQYPP5zbnN0gsMgSeVrhsweSjG4evogCJD8vypm76G5o8FG0lIT9LCJpE/7MjsTeYhhzA23aYFw417bncgrY6rrgND3BK9ApY0mNJEDBY4uGVo+0an9loB74hzw5l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211635; c=relaxed/simple;
	bh=z7OSESrLBJWD8/2P+n6PssT3cGyqehX+NT08g2ul/ak=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RfR5Q4EPo3BK5qC0hEEG3jG0OqlIfSKd+Y5mJFkKvEPxT8s5mbRiN/wnDG52Hy6fQRGRzKbKMAKSQzgTDAvpzfNr580f+TkzWrgC1tsVcfzGhnySJ/fqIW3kI4XuUyRFgmo9XBCyYdN2OL9I7ZjLmhsqKJXBdY4L7eVu9bMS9kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VQL6jN6w; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d21cb3833cso510463b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 10:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718211633; x=1718816433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIIMrgyJCYaT/orKY6h7hla5hxEimOF+QR3n0b8qkwQ=;
        b=VQL6jN6wXII+0/GTI8ADCcDokINenQqRRIV3nL7RCIfeGDvpujUgG/wRDNTADE5Z7z
         xTFtwoTr+rBrxNivi6StBO3hXeuL5eP5Eo4YEiK0kIhc24+NFULNS3S4EZGiB6CzKQTF
         rIpeVRTMScffnIFXcB+TLOrWIbLwUqsg3qlTSQLAeFks43TixsGSCtT9/k8REK81oPI3
         rRCx7/ZEgl4x2eVd7MgXOhdQTW+Melf0OITzrZIC8Ld4Z3O9XH8QHv/Ru2ImZB69Espr
         tX5vd9oZSqGZ3YJsNDBrBF2DcwgrThhRC613+YcmTarhXcNNRGEo1xt+hZVPe2S2Bmee
         QQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718211633; x=1718816433;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIIMrgyJCYaT/orKY6h7hla5hxEimOF+QR3n0b8qkwQ=;
        b=DadyRhTbJ/inPbNb2mfHXexvUxLo9wwesY7jJbVm104GKVyoDGcKqz6xepS6itnSb8
         IzjVu/JXDakjBiiEBc2q9XHpuS2AN7Vc9Kvr76yeHQT3uMonOSSveXmhoEPvoFdZS+81
         TP9jQ/Sinuk8yrDvrFIvTttnsxEUArhKpWkCVJN0L4IT3uyB2jLoaD7IW8lUskD96XTm
         Vc4G1G3FwHynpsBlxuKTCGwgLCYsqEEn7wGRm14l7FjSUUbljeiWIDOqGhLBtwbwxrbN
         OuyvHacl5X/QFAEo8jZRbAIVVFIpaiXIn3WhJt6lVqZ0uM/sokSPIsaNdiV0gIWnhG7g
         HOJA==
X-Forwarded-Encrypted: i=1; AJvYcCUb371vDIzCMCjBpTOy6BjBkBcs2rFl5uEnwGUlbp2fkH+1fpOY2oDr/gKTsY4yw0kGeQ+7Abj5i000mvOCW4MP47aiz+WM/2AXqmh3
X-Gm-Message-State: AOJu0YzibA9l/4MFF9pgb/oH8ppLbAeKKNB/rrV0gzSnac0TrhJ31I4o
	yLCZCouGTQaDSA51esoo3n2M3PfTykhmgzrr+ETtMSMMaVL56Id5ueofZ5HtpZw=
X-Google-Smtp-Source: AGHT+IFXpy0/wkthwrMNmOsZve5zPcmpq79rWCq5ChB1WBkOzd5P+ePWJWqvxcVOmqaENKj4ouM+4w==
X-Received: by 2002:a05:6808:d4d:b0:3d2:1b8a:be58 with SMTP id 5614622812f47-3d23e17b4b3mr2893332b6e.3.1718211631029;
        Wed, 12 Jun 2024 10:00:31 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d242affa88sm115841b6e.1.2024.06.12.10.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 10:00:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: ming.lei@redhat.com, hch@lst.de, f.weber@proxmox.com, 
 bvanassche@acm.org, Chengming Zhou <chengming.zhou@linux.dev>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com
In-Reply-To: <20240608143115.972486-1-chengming.zhou@linux.dev>
References: <20240608143115.972486-1-chengming.zhou@linux.dev>
Subject: Re: [PATCH v2] block: fix request.queuelist usage in flush
Message-Id: <171821162990.49689.4088473696825322669.b4-ty@kernel.dk>
Date: Wed, 12 Jun 2024 11:00:29 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Sat, 08 Jun 2024 22:31:15 +0800, Chengming Zhou wrote:
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
      commit: d0321c812d89c5910d8da8e4b10c891c6b96ff70

Best regards,
-- 
Jens Axboe





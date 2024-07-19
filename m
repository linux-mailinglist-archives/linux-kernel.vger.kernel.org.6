Return-Path: <linux-kernel+bounces-257440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8193B937A15
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 17:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36551C215AD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 15:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5776A1E4AD;
	Fri, 19 Jul 2024 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hGRntHaX"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64185145A05
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721403695; cv=none; b=pYrH8zezZnXnH5sDqjEw0eEGZ6G98THZhEPN7HN4mEItuhhcy9luPjwZedZDHCRynuOZP0T/5lhnu+yXhBFO1yK5tq8zV6yIvQAVrbX8ccODTdtKxl0byDacRmdBCtG8scv8xTL5Ya7MLLAq8Qk4vaZ9oVVhyghJRKaQ1l6Ph4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721403695; c=relaxed/simple;
	bh=QQoq6N067yrt/y8qeQyfNuF0R8Ry1rABV4f6knZiZqQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S/LPxMOohgX0qRv5zzJRaNLfzAlUuHm3bAxNIe+2+zm7mVI7LW+rJtebvNPa2sUKejPHLYU3mWo5SBSTEW+1FaNHVKIora9TJ8CSMlNDULnX9LrAABIrgrEG8gxl76j+dUsrtbYFKDh/dTrpNA1yqvPtJ6jBvsHg96eLKLs7Brw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hGRntHaX; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70afb93cfe9so51745b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 08:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721403694; x=1722008494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZWKVNt73AG90ek9S3k9hOscFljMGUkenJRmULy2xfM=;
        b=hGRntHaXYutPqYCtAEtV0MjB+bYk2bSQROLetr+74/u0D+L6GqYahFe8vHA3J/1m7U
         G+9uxy4s2qJ5wCDcyCPY2aTj3UahlyRWO1CuvwX7HVqssL+pw/bJpoLEoE3SYxmpNNrU
         vJnsQm7Ego3P7Daw+nd0aIeaI9LMVfL7LXAzruv1Lsg18GO3DR9t/VIKOzf2SnlPX8iZ
         wdW1nidNNNT2RfjdjavxywUWVd/tUWWu4vdyO8gQMz4I7upBQyg9DrNapWoaiGBjn0HA
         YIsWlfWGu2uE8D621g2VqiuHIU2/4HY2R3k3KmkiQlEyi5l3X3dbuY6xxOJg2DyHjBNG
         f3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721403694; x=1722008494;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZWKVNt73AG90ek9S3k9hOscFljMGUkenJRmULy2xfM=;
        b=wdB15gv4y8XeE4nwhydS8e76Gi4CTQKzvphEesaoFKKlPneOkr+lOZormxYrl/SJM/
         MdhJxJLQS4GT+wHmLuCAeZmv+LdfpnrjYe7GOSdbATqZ90Eu3TgdzP8hBv6/487KHhIw
         Xtz95WMqdLzvs1vxVy0KeJix8jPQzjj9RDUQu86KXFbiczC7B5A8DzOgbjURvKxk6jmn
         16Qh6YZC3zRWK6poXMON39p9nlQ1FHSnv8G7QglTjg8pwdI5PeFxdTBD3+mM3iBoGMiz
         97037EJjtUGVGjlgrGh09lMRQpnDndFvSqn/DiSGuKfAP+x1QkOlSyQdGzc8tqgiebNp
         gRVA==
X-Forwarded-Encrypted: i=1; AJvYcCW1U79602OZSNyWEfcBjoy4EVkGpvUeJcGMAnGUx68p5KZ0EzP8qtaSD+n+y1uR8MqTVOoXM4pUIzTlKmc1hSUbRlyKds+djqvegk12
X-Gm-Message-State: AOJu0YwIAHpm5p6bCpsV8vKnr8GpUYbM8so4naoA+BgTu2lm333fkHnh
	h9x01sKHd9Pyt9mZqJAfaxyPqhJXM9lhIkzKbvoXYEauTNV6IIyBI4qVm+kPOWg=
X-Google-Smtp-Source: AGHT+IGCPJf4uACUKwnddKZTp8XxBr73j8zaLpJGjhGEWSOurNMxyXPvSNi6Rqi6ya+v0VPj3gPgvw==
X-Received: by 2002:a05:6a00:391b:b0:704:173c:5111 with SMTP id d2e1a72fcca58-70d08635b76mr242254b3a.3.1721403693595;
        Fri, 19 Jul 2024 08:41:33 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff49164bsm1380338b3a.18.2024.07.19.08.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 08:41:33 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, josef@toxicpanda.com, lizefan.x@bytedance.com, 
 hannes@cmpxchg.org, mkoutny@suse.com, Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240716133058.3491350-1-xiujianfeng@huawei.com>
References: <20240716133058.3491350-1-xiujianfeng@huawei.com>
Subject: Re: [PATCH v2 -next] blk-cgroup: move congestion_count to struct
 blkcg
Message-Id: <172140369204.12552.9366107896766797330.b4-ty@kernel.dk>
Date: Fri, 19 Jul 2024 09:41:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Tue, 16 Jul 2024 13:30:58 +0000, Xiu Jianfeng wrote:
> The congestion_count was introduced into the struct cgroup by
> commit d09d8df3a294 ("blkcg: add generic throttling mechanism"),
> but since it is closely related to the blkio subsys, it is not
> appropriate to put it in the struct cgroup, so let's move it to
> struct blkcg. There should be no functional changes because blkcg
> is per cgroup.
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: move congestion_count to struct blkcg
      commit: 89ed6c9ac69ec398ccb648f5f675b43e8ca679ca

Best regards,
-- 
Jens Axboe





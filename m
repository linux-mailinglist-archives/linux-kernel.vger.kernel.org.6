Return-Path: <linux-kernel+bounces-368476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F25B9A103C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913C61C210CE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6902A20FAAB;
	Wed, 16 Oct 2024 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="B9Z+ffod"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A2616FF5F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729097994; cv=none; b=oiqz8c8ItvGbRx/jztTdZVTYEZO1Q92ZLsqjT5oE8Z5Pghen8+mVbkKJbT/GTC8rMZWuUy7Fm/hVXx58DspdgRaWBeIapSzTUuUzBXqLD7je5GZMa25yDD/uvCbRUk5/wSGPO0LSc5Ed76IcxmYLuTj8lX4kCjFcBCmHWRtzLuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729097994; c=relaxed/simple;
	bh=xSIImeFEygj5y9E9o8GWTHfMUhwjbY68nmw1P3u05eU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VAas7Yxlnp9CE92ezuso/YjlVBJsn1ZZBa0r9i2PhE7Lq7YX719lGzk99jdo2c0Lp/OeRTwm58dGL5lYOOt4VquYtK9Im5yUuH+b+paYBw3jkqw9Bf/QpgwJmUYkwXGOU8nc0Pi7HugN04WIv38vNe+IW7gOFnaBq9YQuMcmfSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=B9Z+ffod; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8354cecdfd3so278689339f.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729097993; x=1729702793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XTXN8MMXBXH+WCyjCMYr89UD/xwa7PuNDWgb/DeL7c=;
        b=B9Z+ffodUFIpc3zQ/qes5JsU0lFNKiF9lzofCORi0ZhZDCk/nxplZMoyZNtak8+liI
         +sOmrsK3xyxrTKf/qhjqgKbTjH93vykub90buPYO1wQ3RKLFcdXt9L/t1FKXE81X9Fdj
         +BncwQ+9Of4rqAMB+cSsalVqU6m/AUcGgxSXJP/ctoQ/2gZZyIcC7MeLIZnoogoHvAKJ
         +lgipjGcPhD9dRg9kKeOR+yGcy5T9d/fBnRYJCr7a+y4groTf3p1nZCxujjeXOVU8toE
         LeAnQBuTA/o+62vUZtp6L1IbbcFUteCVawYPE98TEO84LDPOG0Yc4KJU+ye5OZjtJ7V8
         PUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729097993; x=1729702793;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XTXN8MMXBXH+WCyjCMYr89UD/xwa7PuNDWgb/DeL7c=;
        b=Ei2D0/x3HTTeuewfi2JQBvLINvT0deoX19HNN4e+0D63ikQve1UJgffodoIWLf0AOv
         Kov7GfrtQ3fa6eLQA1kFvBNfD8DVAgi3twnl9MofEaZkYs3kwUkdx+NesFOVzKvceb7U
         eAW9B4km1AnrMZkccdMeUSPTHR9ARuA7ITJ4/gS2u/VgwWRNReGYa6jMog14a4aePlhv
         YxpIHCq8UUpp4chNSer/AIgSfXyz3IXQnR47nmV9jGQIsGslPT1ZsydQHMf4t/YtHWkp
         PsXvwRarUMZ1OU0r49x1qGIlVcgkr2ZeXyCiw+oc7bY/YFfMcrNLH0RTWoP+O2E5fQp1
         cF8g==
X-Forwarded-Encrypted: i=1; AJvYcCW8vV9Q0zt3vlZO6svbT8afijNEeMMu8cNwiiSakyVnXIgcL5guqEOdd0N3L/h49h6bvD4U98YMBgSApoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEMgf47Tf/jeD/JE7fBZX0IZq7ORKGaVjYLpk+Xk+2F9VtQwi6
	i61ktxAy4uYaVs3lN4DRycxKXXbHFGT0d4qRkv98MPErK1VuaP3lgdHSaPKwBF544e7pdpxHFb3
	o
X-Google-Smtp-Source: AGHT+IHQU/ynDyUYszAyL0NN+5GAINKYxm3zsvKajiuil1Zt1kx193TwmJPWE+nlOlV49q1uIQ257Q==
X-Received: by 2002:a05:6602:6d18:b0:835:40af:c45b with SMTP id ca18e2360f4ac-83a9447a320mr494479139f.7.1729097992679;
        Wed, 16 Oct 2024 09:59:52 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83a8b28c0cesm85576539f.3.2024.10.16.09.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 09:59:51 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: ming.lei@redhat.com, Muchun Song <muchun.song@linux.dev>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 muchun.song@linux.dev
In-Reply-To: <20241014092934.53630-1-songmuchun@bytedance.com>
References: <20241014092934.53630-1-songmuchun@bytedance.com>
Subject: Re: [PATCH RESEND v3 0/3] Fix some starvation problems in block
 layer
Message-Id: <172909799069.38573.9078542205672825920.b4-ty@kernel.dk>
Date: Wed, 16 Oct 2024 10:59:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 14 Oct 2024 17:29:31 +0800, Muchun Song wrote:
> We encounter a problem on our servers where hundreds of UNINTERRUPTED
> processes are all waiting in the WBT wait queue. And the IO hung detector
> logged so many messages about "blocked for more than 122 seconds". The
> call trace is as follows:
> 
>     Call Trace:
>         __schedule+0x959/0xee0
>         schedule+0x40/0xb0
>         io_schedule+0x12/0x40
>         rq_qos_wait+0xaf/0x140
>         wbt_wait+0x92/0xc0
>         __rq_qos_throttle+0x20/0x30
>         blk_mq_make_request+0x12a/0x5c0
>         generic_make_request_nocheck+0x172/0x3f0
>         submit_bio+0x42/0x1c0
>         ...
> 
> [...]

Applied, thanks!

[1/3] block: fix missing dispatching request when queue is started or unquiesced
      commit: 4bddfec1a0fb837f66b403a11ee1834769df2330
[2/3] block: fix ordering between checking QUEUE_FLAG_QUIESCED and adding requests
      commit: 542c1c1b4cca00051997f4e1ad330a518e727c79
[3/3] block: fix ordering between checking BLK_MQ_S_STOPPED and adding requests
      commit: 1936f2e6981297621deed9afcdc9063c1964fc5b

Best regards,
-- 
Jens Axboe





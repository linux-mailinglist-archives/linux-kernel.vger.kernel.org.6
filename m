Return-Path: <linux-kernel+bounces-236284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AE191DFF2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF371F222C8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C717215B971;
	Mon,  1 Jul 2024 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UWtvXleh"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785DB15A85A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719838412; cv=none; b=A6s/k5oPiVEK/yhcG9DYqU4fiQAYy+FejN2p0f1JpkV2CKi7xkxSuxG4cxSDeAR9+FlRtFerAYx0OBe73N5a4meX/UYtHFH7hPADKEj6OIvut4E9TlF/Yk765h9X5bDPfo52Skgr+CyQrBOBRrfLGjMx3QKo2vQM/IyhUiOzuZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719838412; c=relaxed/simple;
	bh=iNdACzRnqWV6o26iA8YMl8W7ZhHYHmRDuQG9UN8LULA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NMcOCWqSdyP7luOch/V8pN9cKo2MSLyRs6KgODaKXP7671+2Rx6mnntyXViBkEgKaycIJucFMZs7lZim8g9xhKYzZRUXrI4Ip8MIeaoUKIX29r2C9i3WLiyQkIilx5HH2V5qWONjOJgkKMM0UBvZAz6UXoQlecurSEt9SkasyZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UWtvXleh; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c7cfba36f8so578361a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 05:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719838408; x=1720443208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xi+/E5t7Fv1CZfZkmvN2/N6mRMqWoIMfCdGwFhupD4=;
        b=UWtvXleh2YzGs2wCSx8BxA0ga2x5Oz/k8ntOCfDoe/xX76DsaTrq5yjisf+cg9+x9L
         Zsl1HJAV5bTRa9hMkV3j2fpa0xfl4iBwa055mugXXq37s+SsiOxAZ6qf81UEr/mTxbTt
         PXKCDDg0QcUIL/dstMHu0r4RuXaEG4ibOkGYQB65Jymg+hQnu7LwlAAPmNiZWVyx/sHe
         Pp92YG0J5ufOdWdfmZO2HERkc2IOfm271ezpU4gKfIXJdLU8lLTohlMn27YD7AmWy24A
         0fbIFvfR6KXQKpR1iRKqeyOntgJBNJneEL/D6GL9Tj6uT6ROQTGCxJtUb5U0BjLjpO0Y
         knzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719838408; x=1720443208;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xi+/E5t7Fv1CZfZkmvN2/N6mRMqWoIMfCdGwFhupD4=;
        b=S/VNhJcTECxFrYB3f6sz0N3dR8Hof41L2djbCYmIXj367pPq1uuR9H119sPUkJr0BS
         0Le4KZtPZlmVhKJmMJCx7NN9+4WAJbdRW9EVRz58tygPdhn8WwSVVXgA5msz1oEUSScK
         9MqNlCl19UML6XcPJHxoU+YzGtrISU/eff+DKGuTHt6qlmViYLp0tZjAroM7el6Ay1lm
         izmkUW75sW+/1E8m4EpVzHY1ZpDNjIdGHV48N/+GUeI/plKFR0h1iWW0Q1vxFP7ylvCJ
         k++Ovmbl1TUiMIdQJkQLvSJXdCFAVdoDNKPh2O8R++6sYzfna69YD5bg6ZebFOFpacn3
         jpQA==
X-Forwarded-Encrypted: i=1; AJvYcCVV5SH0krd2+gACswAchbwLGYe1nEyXx4dJavycd1onFsoyj1auJNyBX7bBkg/dgk8S0U5ElldHx58YViyL59V55GzgKUOz8sD+OO+q
X-Gm-Message-State: AOJu0Yx2gOJBaezrcCsk+Tz3+4PAK7mFtULdI+UdpqmhjDItyX2tgaZ9
	9uanpbW+f66b6hRpCuKEUgel6LiUNU5A+e9JGJcUtXtD4sPUPuqMXJN/NAznzlrLX9Z0UK/brOq
	tyqc=
X-Google-Smtp-Source: AGHT+IFO6zMUTZJul/Zew+u1DZcpq1RcIc9EFXm5RpbZ1Ey5xwB1l7yrZ/7Xc13xXh0uiwAGkJgT+A==
X-Received: by 2002:a17:90a:b886:b0:2c8:59fc:b559 with SMTP id 98e67ed59e1d1-2c93d6f284bmr5646854a91.1.1719838407990;
        Mon, 01 Jul 2024 05:53:27 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce1a292sm6648820a91.7.2024.07.01.05.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 05:53:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, libaokun@huaweicloud.com
Cc: hch@infradead.org, linux-kernel@vger.kernel.org, yangerkun@huawei.com, 
 houtao1@huawei.com, yukuai3@huawei.com, libaokun1@huawei.com
In-Reply-To: <20240604030522.3686177-1-libaokun@huaweicloud.com>
References: <20240604030522.3686177-1-libaokun@huaweicloud.com>
Subject: Re: [PATCH -next] blk-wbt: don't throttle swap writes in direct
 reclaim
Message-Id: <171983840672.13284.3665627911402096359.b4-ty@kernel.dk>
Date: Mon, 01 Jul 2024 06:53:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Tue, 04 Jun 2024 11:05:22 +0800, libaokun@huaweicloud.com wrote:
> Now we avoid throttling swap writes by determining whether the current
> process is kswapd (aka current_is_kswapd()), but swap writes can come
> from either kswapd or direct reclaim, so the swap writes from direct
> reclaim will still be throttled.
> 
> When a process holds a lock to allocate a free page, and enters direct
> reclaim because there is no free memory, then it might trigger a hung
> due to the wbt throttling that causes other processes to fail to get
> the lock.
> 
> [...]

Applied, thanks!

[1/1] blk-wbt: don't throttle swap writes in direct reclaim
      commit: 4e63aeb5d0101ddada36a2f64f048e2f9d2202fc

Best regards,
-- 
Jens Axboe





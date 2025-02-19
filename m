Return-Path: <linux-kernel+bounces-521855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EBAA3C333
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92268189A511
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E851F419E;
	Wed, 19 Feb 2025 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RmpY+t28"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623371F4199
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739977747; cv=none; b=McjGPVVtqZy6Eo9wOL5RAINfr5yiccPPlMJ3yTc+7teSIZxtWP15CzYjpVjqMviIOVvwqCb+ihW4AucmEkpZ8Gyf2CqQmsEN/bR4pLsV8+Tq/ii5WxyKHbkjHLWA6nLlBPsSjIIWyNtRKdnrPiAy6qeMOLtX3Efv9PpVCXOZr9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739977747; c=relaxed/simple;
	bh=KpRZkJVpMER4ABmtHIWnu1sCwcyaQlJVM2PbewJQAHs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aSYPIxzJlDMFEeJhdXAA0ObMPMTXFy976pM91vOcUIgN7qpaXlqIMiNMGBjZI6NhCKip0NdfQVGAJ9UgsffuyojJsB1YVYAjtW15vEjtxxR8UI5ACQDuZEhmK+4+m0Fj7I+MNMEzxsIDFXz7bR1Z8LMZeUW3iS9fC9Ouo/ciRUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RmpY+t28; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-855a5aa9604so52555439f.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 07:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739977744; x=1740582544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJiPIBuxHziy6xD4QyZZewHTaEeyt9GRiu24U+QynKk=;
        b=RmpY+t28nCfbxkb7kWUvaAklOet4zESwRSWUFagB5BAbSY2a1VJbKueesXnjX8JxcV
         w8dkyXpFJJhuGZdVR5ePHaL5LQi4ZKEYv2d1h3uP6aOgUbFN0/gkKemuM7GAn3v8MWLn
         yq8EV835AOV4Xcl2MgBL6jMtNE+I1e04RrQuPRHFQhOSQ6Vh4V9ULgE3QLgZyKKcmlte
         kInf8GiBJOABv4YM+APTA3zx6p1HfozPRugnEFBiAxG6LdAe3z01m/MTrOz81CtkyPR7
         o9SkWrdE22EHffg4L9l6WLg3RPRrTCrGDxtRw63sZD8IHiyOjFrH8OHat7NcNvjDEa46
         gvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739977744; x=1740582544;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJiPIBuxHziy6xD4QyZZewHTaEeyt9GRiu24U+QynKk=;
        b=Aedtqh+XG7iCIjNb1pUtM7imjU0C62Iez01bSZy/KdpPF2egZGqGMttdPmEcBOnt+k
         Y0892F/hWaI9bVv56GjmIukF+kl+z7eZRWszlmdQRsX6oLXUXvsxbWgxxb37RRqxhH29
         OR8S3NXBdWMd78BYQVy3sVecigdaI55Cpiu+m7e18TRy1MSV+e+GucnqpistWmQ2X2uw
         tW+AhlArJUGDs0EKMRWt+Rp6chSGA27/gP35COP4ZjU1BV/wIVhtWOJBbrxp7IzWpL1e
         +O9ICcTjZk+3SI83dXy54gxy4BgiSUAZxYagcrwMhmn5spKF4U/zIXwp3bwiVbiNJQeb
         WD7A==
X-Forwarded-Encrypted: i=1; AJvYcCW0fGJBeMYcBbVI72I+9dxfTQhq9yMJ8iryU7XX8r7pVML+7VU3GAps21OI931mOhvderMLQ1echMk/GeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwyokDn4inPd1+Uty9xg2f5naKdRqLoGZCh+eJkBlX6NG5L+FD
	1R6imohi4XmnnUfV7Zm6snZhflhUEK1vLLLdP4YgCF2owTQn4YJBW5DAM2gsvGU=
X-Gm-Gg: ASbGncuxLeLfiGt4DldByfqG9cEUWu1ugNiPXmt6TtK0E7DFW2xyQFI6m69wICqifyM
	V8Vr+7+6t/ytk3szUDivlv6glsaQNT/A1z4ggFJ+AUQ2MP5/kpIkLxl9ZTIwLwNFT5KecS1DBFp
	tqLl8CK1qEBWI0eTT5FH1Cz/5HSSpwW8FptdvLyFirnDWa8IPeVg+C6eNAiwAhjOSO7Bv+zoKs4
	dvGP9f00wTnNqnEooDvh7ZCLxxQtuqtUVG81UO4O0rIvLtgThM/9RNXrr2q5TW82/I51Ym+l7kN
	SfzSXw==
X-Google-Smtp-Source: AGHT+IHYl6ZT9AhuTNpGUwh6j3kXJF8NvBTk0kQ3u8/3rbup/1cf5eYdnKcGywhE9gpaBSQ5fnD6KA==
X-Received: by 2002:a05:6602:13d4:b0:855:683d:d451 with SMTP id ca18e2360f4ac-85579fbd60amr1738963439f.0.1739977744316;
        Wed, 19 Feb 2025 07:09:04 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ee9c1a303bsm1491950173.26.2025.02.19.07.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:09:03 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <5ae387c1465f54768b51a5a1ca87be7934c4b2ad.1739976387.git.geert+renesas@glider.be>
References: <5ae387c1465f54768b51a5a1ca87be7934c4b2ad.1739976387.git.geert+renesas@glider.be>
Subject: Re: [PATCH] io_uring: Rename KConfig to Kconfig
Message-Id: <173997774341.1536543.15426787418429919089.b4-ty@kernel.dk>
Date: Wed, 19 Feb 2025 08:09:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Wed, 19 Feb 2025 15:47:58 +0100, Geert Uytterhoeven wrote:
> Kconfig files are traditionally named "Kconfig".
> 
> 

Applied, thanks!

[1/1] io_uring: Rename KConfig to Kconfig
      commit: 5b760fc6e9c5f984629c217e559005dc3725e9cf

Best regards,
-- 
Jens Axboe





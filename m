Return-Path: <linux-kernel+bounces-539742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 017AEA4A80D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 03:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C521890D03
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30391AAA23;
	Sat,  1 Mar 2025 02:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0VUi8dJk"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7863E175D53
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 02:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740795821; cv=none; b=H38JMqWcyXtWsRW5oMlaIynbnO5RDGqC2LyP8qTZtjAa9Dg0tmgz1CUjGtJdkzDrWdA2F5qhoYZxK2oeP+SgWS32e582ChWdu0TbDQLQeaFkVRv5+rJbr8AmgUFhg/4byz0tjO++gwVhtf+Dp2JiqdpGOWV/7AxQtFB4ODvW29Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740795821; c=relaxed/simple;
	bh=gwJVbUB8nQuOGaN8LbjoPuXKD0F5grY+dCQT7TNDyrI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fdC6Yrsi6UfYta3XY/L9b9+iYqrWFX3vYn1k+X/EMZpsluiS8SCuUCwVpWy392sENLUk7Nc7Dn9E9B0Q+NxvY8s4RlnPqHkoqe77GeGNUEnKHQK3rpvodJYx9rUk2mcG7rFWgzYM1H2LTWSFqN8RtL/QBVCiRyRsD5AHFHATfsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0VUi8dJk; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e4419a47887so2107468276.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740795818; x=1741400618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avdEeT2k2pMbZXLxs+RZva45RmgD9Orxh6FLQ+TRV8M=;
        b=0VUi8dJkmYQhRuBApZwmg/egbyCJwef5ogybqLfnDBI/fMWFM76lk6P5K/XzBHkVrz
         pmVTVhgOS9L+aE+GAPum4F4nU2xDy3s0Iy+Ha8WdAOjEUBGg2nrBQ89avPfp2Oo+zXVp
         NsLmbR6AtoheFY3zp17NGPBOeIGBOffci/PjItLrzsDhZofMuLsMKXANkbI8mMscYoFw
         rHsWooGFKcOCjQKEHMFjZxN6MV5gMp09SVQXy8o30H9+undrgiBxjfpfUxEdHmI7uQif
         mQre80JeHxcZKpgZAlVoZusZgsEXPuqUfMFCkMcUAL2Ruz3bJSTkUkIGDg28O7PwiHu+
         VCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740795818; x=1741400618;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avdEeT2k2pMbZXLxs+RZva45RmgD9Orxh6FLQ+TRV8M=;
        b=OJubTKexcBpMHhpqbwfCrs2SdA6cl6PdSHe9WF859EaHJFmF0cRRcM1iDfEyLVOqAD
         mqq6g+coATM/vuGCuW6YXDkNwMcsjuFS9snQOuYN//tBiVH/9bSENxxdn9ux1pl7AHAd
         clbnV3Johe5h3rwYiQ8kXK7VqQBZpzk9ACjwtTc+xFg7O4IgUYtgkzL2VLQR77+HViwr
         /BiKoqpAJz8B9ixxThcGpudvWY1swZt8PL+LtPsGY0rOGPledCgHLh6JprcB2jm7utd0
         8SmPII8qvcbUk7KYvq6fji5UEOcLdTUTssMxZLlTNiGW35pq3D+5C+MYXMsCN4YZ7Ct+
         PcsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHFdSmoTQ3W9oBslYwOxzzYeQrl6cE4HNN0gBHZUHOhdbxZKwv02btH/d/FCWlYCR7C1d7kbZTtEpcAng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ8JybGzNM4pSQ7IesVRYWVIEg/ulMWe7+iIGtTiWNQYg0PHiT
	OPQaPtzfsllNpq0r8DkYW6IQtco3njYOre4CYXXNGuVtoAYvJo5imY4KP3vUK9YUDOEiuLo5xkq
	x
X-Gm-Gg: ASbGncscjcp/4M3Ud3t/pPYmNb+Anawrb+PmnYE35J2VYqlADHHoh6r+M3c6LzssDBC
	yl7sXgJzjP6nE+cAF770C+kIXlp2R7H8fBwber6r1ZRy1YTGlLSK9yW1lt3gp9DuCGv/qEY/+sG
	lKAKvfxZSoXqznRoWVVw5C0A8b9UZGmE1trmuwqFtSnUYJCUtq3ER0BYulypJPIBaJkhfFXGOqP
	hB76AZYNLBdZUbYDb92gBtotXrVo7ws/aAJBDtqmYsSdAu8obmf7zPCfFAq2z0zsQrwVKP80Dh0
	ZFKXxVwRngodFGbHZYkoQ2XrA1ah76zjNBu+874=
X-Google-Smtp-Source: AGHT+IGShNJw9AGz5eAUilvWsKkH/s9pd+G47t95AvidWnOxtGe7WBOU3FmTPmGidlL8Q0XHZmttjw==
X-Received: by 2002:a05:690c:6f0c:b0:6fd:4521:f9fd with SMTP id 00721157ae682-6fd49f8666cmr72420207b3.4.1740795818260;
        Fri, 28 Feb 2025 18:23:38 -0800 (PST)
Received: from [127.0.0.1] ([207.222.175.10])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd3cb7e02dsm10175307b3.84.2025.02.28.18.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 18:23:37 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250228221514.604350-1-csander@purestorage.com>
References: <20250228221514.604350-1-csander@purestorage.com>
Subject: Re: [PATCH] io_uring/uring_cmd: specify
 io_uring_cmd_import_fixed() pointer type
Message-Id: <174079581706.2596794.9398482101853410174.b4-ty@kernel.dk>
Date: Fri, 28 Feb 2025 19:23:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Fri, 28 Feb 2025 15:15:13 -0700, Caleb Sander Mateos wrote:
> io_uring_cmd_import_fixed() takes a struct io_uring_cmd *, but the type
> of the ioucmd parameter is void *. Make the pointer type explicit so the
> compiler can type check it.
> 
> 

Applied, thanks!

[1/1] io_uring/uring_cmd: specify io_uring_cmd_import_fixed() pointer type
      commit: 0c542a69cbcd1fefad32c59cea7a80413fe60922

Best regards,
-- 
Jens Axboe





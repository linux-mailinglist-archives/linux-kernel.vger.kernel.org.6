Return-Path: <linux-kernel+bounces-361548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA6699A990
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF1491C22184
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280E81A08CC;
	Fri, 11 Oct 2024 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lTngIVMy"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE951A08DF
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666711; cv=none; b=hVYzvAuPLexgfjEjdKgqxIEQe/vRREiWKvtUlp4+7S/fpQSrhgjA0UWmvB9e0INlF9zT5D9C6286j1H2wOQUmakukXIfvBHW6XbhoctCZ2RFsGan4JA5ZXPWcTMzJJ0pcHecSz9ZGjW7QA2SQul4MzZ6uBk5SXveHI1lusIOblQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666711; c=relaxed/simple;
	bh=l4ybPLuzwshIo6CiUP3SYCkZBT0nRbnqGQ88b5ZHn6w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EbHAzQc6ZQjgX9L2UE+G5pI68rhJw57v/S4Sm4zDw5QIM2SKMiWkwzTf0ITy9gl6I78wBQld8u81SX7RLsG1yiOcQaPlErYKYg1NQEJRSdUhrKVRze7M5q6BOs9JAkOAuhxmzKlLlHFf74JNosHYDslnwm6TZU17no3rUMpbK90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lTngIVMy; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-836d2437852so71326339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728666709; x=1729271509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sek4vbxL3f/NlFo8Be6u5iyw5TmCpBli89Nh7BpIveQ=;
        b=lTngIVMyKD+4r/aC6k/y/iuvOr7tNnx0xFCCLGmprVWtnpxJEyGlNzc056QweGBWHb
         mWrLfYWosPlZvH2gbJk0UI1zpejMAU5r53vjRiLcJmSlivegunLDyoM+LWjxdhAZur1X
         Qi4sPdYfktMHaSpYOLaZ/ZaLFsrXGVeC5q3rYGuZIpGVhOYR9D+1077OwDoM+LmuzpRY
         c9C0JnzyRFNHEJr5EDIMGiMPFOpi9KPEji2pBt5NbF9h3u9zXCodJqgsUfPGE5i2OLJk
         xUYnpJ14dXt9oWsdYD3qjinqiX5dATY8RHlrVZpol5g6Hk/9vN8Z5nFe9dOo35N5rwQH
         jrsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728666709; x=1729271509;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sek4vbxL3f/NlFo8Be6u5iyw5TmCpBli89Nh7BpIveQ=;
        b=nrS4Jc9SZBreliPZN+/Wg2VsK/EGIspqtXqKIbA+/rfmLjGg6ufy8pipf8gdZsTd6/
         Ni9Wq0uq8iMZ+PR1lVYQb9ofidkWvFRkYALcmMYbHn9rEvZ3Zlj9JwxAkVFPELJbubh1
         BVQs3tIbwraxMg0in3ltQ9kjsmrg/cmjRfOA5k6AJi7GAfc0ztVDTIb/qYycZziGcJc5
         kXYyV6Y9yO8dFB/wJzBNSn0TDI+zlZiCS8YANLzESMqB5YARo+dgi0am3eZs7QFE222q
         hCbvftatw/ml8AGdnRW9QvkmkgJvF5QZUBet4xYIFWqQKRWr1C+3YZVtoqLnwI+/pVpS
         ZMUA==
X-Forwarded-Encrypted: i=1; AJvYcCX+bs987KukqhgTZOj96Y/BNG+bgYBa4n+gimMBopDuJ1lAiXulFY6wlRpzfcqfcC/si3Dx9elo/kKEVlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ4QhkOPBzM7ZkrACXKqZT7eGNz4s4ERbBXbAAAO6AuEt9Xtkj
	6IKc1Ycv0EgaCTcn6C/36Y6MdPu5Ohxi47aIDCpVeyS98XQiwc9dxUlJaK0m9fM=
X-Google-Smtp-Source: AGHT+IFuLm7s+TM3bvNQuo9LBJxVCafKSGcTPgBInu3ziFlc6P2leOeLbuC8vpArWI2WY/La7CZstQ==
X-Received: by 2002:a05:6602:6d06:b0:803:5e55:ecb2 with SMTP id ca18e2360f4ac-8378f64c49dmr450291539f.0.1728666709101;
        Fri, 11 Oct 2024 10:11:49 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbada846dcsm713654173.89.2024.10.11.10.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 10:11:48 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com, 
 christoph.boehmwalder@linbit.com, linux@treblig.org
Cc: drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241010204426.277535-1-linux@treblig.org>
References: <20241010204426.277535-1-linux@treblig.org>
Subject: Re: [PATCH] drbd: Remove unused conn_lowest_minor
Message-Id: <172866670811.255755.445033429638947954.b4-ty@kernel.dk>
Date: Fri, 11 Oct 2024 11:11:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 10 Oct 2024 21:44:26 +0100, linux@treblig.org wrote:
> conn_lowest_minor() last use was removed by 2011 commit
> 69a227731a37 ("drbd: Pass a peer device to a number of fuctions")
> 
> Remove it.
> 
> 

Applied, thanks!

[1/1] drbd: Remove unused conn_lowest_minor
      commit: 1e3fc2000035ffea0b1b7ec2423706715ab2e7f6

Best regards,
-- 
Jens Axboe





Return-Path: <linux-kernel+bounces-186552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB4D8CC58A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24BF1F22B99
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C2A537E9;
	Wed, 22 May 2024 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="F/1Ut54e"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEB11411E0
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716399075; cv=none; b=W8OCJY8RoRtBZnKGQBrk+gLDgqJJT78hSLK5Dtbvvkfs/aXLevZGdBIVsoB7C+hTxuGAm9Uvld8BKBzxWgYRhycLsTpEThab7ljlsKpVYbN2eooSQmjSZLbxKuhM6cNvRIxxkub3EpDR6OcTPv5ZZsLZ5Ok5kFcSOuR3+gPRAN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716399075; c=relaxed/simple;
	bh=1B9dsnoCotJxFTrkGAZwC40Nz5IzOJrheW4eFVSuLL4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r5Q0+sZImSZvIR5Ue8xUkSP5tLdLwuVQOKrGTYy8qhJxN+RvXxU4Ys7ObAe+VFlnWZq8B9VoXMrr4HXfF/H3Ee4FD42OGwO4LT+metXTFmWWfOlkdXvszglF8DNe8Z4YWM4G2RA0E6Fd6mRWcSjeoe3MPJT3+6BNKuPXC+82G5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=F/1Ut54e; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7e24aa659abso21713439f.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716399072; x=1717003872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyoQ04pME4REpApsHBdNGyO5vz5nhCeO/3yT1CYUWSM=;
        b=F/1Ut54evQVA/sNcBskksLJr3mLash2EAqtjclZRL8j9WZ1VFe8QogB2r7wBFBkEba
         C18D9ewMvCpAWMsbHKN+B3ZHQe8OYpOCZyCM7nQ3uIJ+fGieQIqYeZ2Ca7Vee1HNqGrc
         lNIQU2WnZr5mi+lRsnpOZFbMxbNby8Xy+lKR9Ogl9flW9BB6wtvAE8O1z20oU2K5CQCl
         jSzUMwDTMvxOSjO3lA0eLDPbvQbva8i7yR3/rTzyu3J83B8p/HIRZXhGCjUWFGz4xNgk
         6LS07pTxJxkb+v5MNY+2NvHOx5FpNWvgmi2K5J7bkXeMCSPV2+TzYTtZrmTKWB1AgwBq
         3BxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716399072; x=1717003872;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyoQ04pME4REpApsHBdNGyO5vz5nhCeO/3yT1CYUWSM=;
        b=w994H3dblPEoVAOycfKbFOmCGcrBNFD5oidCl+aKuWqPXymCHak4jhAkMRfmWqPDHZ
         iGjXQTrEAxAZB7hfC28oE/h/NhLshBSQPysiXaQEE1WUOc+b/9EAW47O0vYI5T+/0VGf
         2bGEeNOGLTQAfUjV7bsZ+1eQGZKNNlWTTnx4LJEo0Gn59omYmnYviNwkKUnO0tj/vQDo
         4A10gtaWD8ziPv1S49vexeLsEkOU5O6SdXpQUyngGYmtUWRrQPYdvbXwE2wmyJ3BYMbc
         fN6rvq/KROlsiwVTQDHXk3+OKKoGh9kj3BTQ3HI/Gc2QfQD7LryXei0Zge9rHFEQRNeW
         yoZg==
X-Forwarded-Encrypted: i=1; AJvYcCVAgi0iuHO4be2K4MCz/2drxFztYdlihV3GA18vsRmUzC4SDN2jWv5rt2kwBO8niRuWsfygQMbq540ydxy+wNnJn8Wf3d6rjCJaQ0PA
X-Gm-Message-State: AOJu0YwmlwcDrfH56SSC3zkFcy7d05PPnUs6Tr1RQv89pRv4sew75hlE
	b9yIE+Lv3G/d7VVVerPuAkNmgf5FimSZEvewkqMl/Wq6cnaPPr6KbN/KlU+HOELPgde1wAQMUm7
	Q
X-Google-Smtp-Source: AGHT+IF/WI1FtilI6WWcWW4/jJALodFw4CgIslzmlQd2qik5wcTeLLwZMVKIhIz6ctQZ1GF6SAn4GQ==
X-Received: by 2002:a05:6602:420a:b0:7de:b279:fb3e with SMTP id ca18e2360f4ac-7e37db353b9mr277689039f.1.1716399072236;
        Wed, 22 May 2024 10:31:12 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489375c1a86sm7626823173.105.2024.05.22.10.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 10:31:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, yukuai3@huawei.com, linux@treblig.org
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240522172458.334173-1-linux@treblig.org>
References: <20240522172458.334173-1-linux@treblig.org>
Subject: Re: [PATCH] blk-throttle: remove unused struct
 'avg_latency_bucket'
Message-Id: <171639907112.82914.16265588567608443016.b4-ty@kernel.dk>
Date: Wed, 22 May 2024 11:31:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 22 May 2024 18:24:58 +0100, linux@treblig.org wrote:
> 'avg_latency_bucket' is unused since
> commit bf20ab538c81 ("blk-throttle: remove
> CONFIG_BLK_DEV_THROTTLING_LOW")
> 
> Remove it.
> 
> 
> [...]

Applied, thanks!

[1/1] blk-throttle: remove unused struct 'avg_latency_bucket'
      commit: 4a482e691c8b8a188b1ea3d6a80180e9fa925fd0

Best regards,
-- 
Jens Axboe





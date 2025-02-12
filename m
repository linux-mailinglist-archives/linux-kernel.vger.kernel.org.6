Return-Path: <linux-kernel+bounces-511684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B4AA32E4A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141B4188AE0D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FCD25E45C;
	Wed, 12 Feb 2025 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IEwFdSHJ"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6D425E444
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 18:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384207; cv=none; b=TErtWIICOZE0bkqlx7mUUO3EpKusAVtexYG0STq5laKgU7FW/0rUWRJT6HAwYHWpJmrM/Q1PcJYFJ/qKt7CuyxmcNxHUOtvKas3JWvrupTLJ8GKT+XwoaUhhGgNhBuCwGfZU1jaTEgYg8q4pgKfY1YM31Q5U0NDkdTY84wsihrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384207; c=relaxed/simple;
	bh=nxaghZtbV8iPMZqQbj0tMPrqCnay/4K4HwCIcKOe/Xg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EUHVYS8Zg/hqw+89qkUYQrKE1RaDQ0rX7LKWZbScaFsMYpY1xr/bL2Z463hTEedheTDJkX8cDLLn4Zage0A+Sb51jGFMu4bP07ND9myu3CRYGmG9z56Qu45ThZByEFXF5M7pHs9dUFNe6j5K6XpbmY7Cokhol46DkjKuogSQgiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IEwFdSHJ; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-8552ae0fc4dso261757339f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739384204; x=1739989004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bh1w2AkubS48pkWRnoVHrva30bRn2+neydxUc1lOTos=;
        b=IEwFdSHJSQhmZC3K0QWLQHUS2LC+/25+za3ktod/wrRo+hA2xHEadNnMtnt8t6d9Hg
         x5hPdzzhezUM5X1O1dj/Cdn/rtsB8g7sWcbDsasPrsh2UpLRmItaQs9RNq9vUJ9EpmTA
         ueEYuSZmmt1FUXWOtvfBLagFdvBmOB4T7fvDKxz1v/DVaIvEKm+EXzRh8uwRH9o9Xqp4
         L4YbTlFp5o5QZY3fNc5q43bDRM/dsI0QFq9MNKa9ofKtg7o/yjnzUfzjZvEKzT9UxPFm
         HudUI+0fRUSg8DSSqxlBFgzX8BH6EBCZYFHyZMOY31sPLZW7khxanYHh9TJHg7Mt1QeJ
         OmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739384204; x=1739989004;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bh1w2AkubS48pkWRnoVHrva30bRn2+neydxUc1lOTos=;
        b=pOzrKYfmndAM1H6txzZa+0UnjEohdPoCS1C56AuayOg8UixYD4USICJgKXRJoSDmAW
         BUuwvQ1H6pM7flpph063mkLqOut5Um1UQ2m4jgZuVxqaalLG2PgFEHc6l7TK0ZVu7K3x
         vB7nvSCePg9bsOQxB6KnUe7qY9xGV2kPhNaP+A8Bz9Qq/nGOc1Y96nKOCvsPacSyKKYX
         FuXGDvCPaBi+PGkzB4NPTipCSNuKGRCyLsWCSzfibOLVN8DFakifVGtq9HtfGZOHUUuW
         ErHBHdNMvHg5X2u1dly9qYALgmnyf1W1R0kRUF+6uGBjUiv60KvCTE5dAonhg4m5Bkw9
         gWtA==
X-Forwarded-Encrypted: i=1; AJvYcCUUnp1a+AoMWT6aWi1rQf4IIpAgvYieRQU6nyr+3cOjSF8+vdXtE5E8+D+KBPXQ719qSMueVTGy6JRW5bo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7nWmx5lJ4cUkwgfwdH21KMl58rJgrTCgu0iDOZSa93uvMvXxV
	+q6JoXSanZqVSpONTQSe/i31OpBnxKLCK/xwuDGXStD3U2HknTxkvVWTi5BzmO5S8uPI7kT7Bdi
	J
X-Gm-Gg: ASbGncvk/hm+4pHq3BAyKpl9IXMoqrnVNFd4gEuY91K/DTY7bDA0QlkFXG0P592auOP
	2mIOjcgY7eIsEBKwoej+iQMWvQMebezZdTYEpFmZMCpvO3ZS7S590EfEIhm/kKmJhd01EnPSdQA
	TaLjPuybU9zxfpMK8G8rkwokQhA5EpAtMoFcii2ZHELa+zy4bi5nvVgMbwCyQsnXgSwU+sRsSox
	9jyGpEdETYvO0Hgc3vohlRMnwam3SdnizU2/pBaZ0kQSdWiJMMGYAhlSHqhRpQMkPptorwmRgPT
	ZyjMSQ==
X-Google-Smtp-Source: AGHT+IGwl3dQNpzDSqvnGXuUMLAOcppzXS11R5szrRHNzSQcgYf151afWBfFZyDrC3S06SX3T1C4Ig==
X-Received: by 2002:a05:6602:3f84:b0:844:b6bd:4b35 with SMTP id ca18e2360f4ac-855577946f3mr345091239f.0.1739384204692;
        Wed, 12 Feb 2025 10:16:44 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-854f666ba26sm328049439f.14.2025.02.12.10.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 10:16:44 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250211202002.3316324-1-csander@purestorage.com>
References: <20250211202002.3316324-1-csander@purestorage.com>
Subject: Re: [PATCH] io_uring: use IO_REQ_LINK_FLAGS more
Message-Id: <173938420370.36938.9943547252583287992.b4-ty@kernel.dk>
Date: Wed, 12 Feb 2025 11:16:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Tue, 11 Feb 2025 13:19:56 -0700, Caleb Sander Mateos wrote:
> Replace the 2 instances of REQ_F_LINK | REQ_F_HARDLINK with
> the more commonly used IO_REQ_LINK_FLAGS.
> 
> 

Applied, thanks!

[1/1] io_uring: use IO_REQ_LINK_FLAGS more
      commit: fddceb353d686cf377d8b630ff6e3cdcb69ef4fb

Best regards,
-- 
Jens Axboe





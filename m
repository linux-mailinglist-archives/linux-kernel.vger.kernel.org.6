Return-Path: <linux-kernel+bounces-511685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C115A32E4B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65A6188AE45
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B478A25D553;
	Wed, 12 Feb 2025 18:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="P+Hc0nN5"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD64B25E446
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384209; cv=none; b=UrkZn91acjXw4Sleb0Jcbh+IkpcFI9orQ6RtUPEnz9D1UiJsLvkthe6D4Kb8QGmIY9O3qI7z6fTsaupxt4HSuadZpdcNWDdVVAAjoQcre5njn9t9K3Q0oxiMsdhzNLjJLrvFhYIZuP3QZwF57mZNvD8iU1yIp/PVKqh5KW4fYOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384209; c=relaxed/simple;
	bh=1hb4KJ12VZdUmipnIFFuvIni0qBelor7VkXCwkCQbek=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FRrvcJg4z/7O80xG9DGP3NYptCc+wuIgPpeHs6dcV/gO7ziqshP07qGvfdMt2Jup2mNuy1PokzAksky848Zoel+hCzu2igO+jtu/hgkFPCDmrdZ6BLbXQ23vnkP1aMvOlU1OpOzajRCUmgtPphI9kX5e/KJCTex5TsNrzfd1Qlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=P+Hc0nN5; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-8553108e7a1so244225539f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739384206; x=1739989006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMlWPAv3J6OkYtRrXxRVeoZm3nrZH04zwlYBVDf5xD0=;
        b=P+Hc0nN5LSGeQ9iXQNxxtdV5ZYV5qg317Mk4V0LzyAsGoI4wB7woEC9eNDmSLMmWBE
         gANGBY7RuzXF0vYqCWWj68ug5h2lGFqKt+SZWztxs9E6CJvM5HrUf1Kye7cRjW/cztvF
         W/mMtB99Gb4W3oWvs/QGOQKaKS0HQfr24pXYntBbLJyjv1ackLgrmeHebgJIeFXP0ORl
         tqAFZ1UiA3I0HF+GYewsGkB18qYgMH54YvwnJOALMDJ90Yor+kS2KzSwJc7zUXr/kN4B
         Rnt4EkrRucSJmlBgnEPX+K+IWavQLbcocIs3TQzrgAcOwVK3CNJg8HHpN+iHdXhYA1gI
         Sqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739384206; x=1739989006;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMlWPAv3J6OkYtRrXxRVeoZm3nrZH04zwlYBVDf5xD0=;
        b=IyXX0XtY00Q+gaAgubxdS+gZ/RRkUJqMsZVZAG2GBaVpfEdrLoNhnluh08TaDnhNIW
         34N/Y6DvVrrdjQHERJykVF92WzSZeH7Prnj/dJ4ZK41z9EyNFV4DjW1zTTHPWtHaF9dM
         ngiu2fGqUftJdb2xvMEw1K3Ag5AmW84pq25YVPjHk/Nw1gr8poEFUEteiXHt/SlEOzxk
         gGs+g6IKW1TlMUKO1BVqVCIEm0wZDtrgOVb857dSoVxuwx7VDOvVm/b5t2ZRZUL9VpKB
         muaY2u2CPBwAZwVbECBbgSo6MGKmHvgggNBtt6tKDowfKWBNiK9cAU3sZEAIula1zDGn
         /+yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWeBQ8OnoInRiV8ruBJL+MavFcvFUhOpMVtr9HpzIUJmER77ujRyGIxzmd9/5jTpNVwhoWCcWfQBIiKE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnC9V4ilhozasOTpcWaALdqtWlOPYavjuLQN9qGSD2jxsRCx9H
	wInqfSbIttZIctvnbT2XwdwHJp3Oj5twOnnhavaOHFPBGXMjyihkvy1j79JvwT0=
X-Gm-Gg: ASbGncuNfVa439sYddSaef/PTZvFYtBOjnbhc5+ebiTAvBofKgo18lCS5qF0EPAtSHi
	NSiXZYLiJeZYgX+Gw/1PGgTDy9OpO8ldrQHpFdz+ptZO6CyzMKg9ii1JB3bwTStmO1VKe9MIHrN
	W48dcLPKvHjFk79R2FIw82vAsc+V4+TG9KwwPernCnsrHb+Rt45XxnWUdTnlaSi+kHRWHrJ/+ja
	IwYrNTBvRvdQkDVOnIc/wPnfhxMsmhuPfLiRwQNXpXChuOOB5sdnSrJVcMoDopkg+yCzzCYrNib
	O2KvMg==
X-Google-Smtp-Source: AGHT+IGVQe/1y0mKHjL8agjFLUdHgyInbDpN8Z+e22BfS+Za7kvSCaPWEA3qCdt+ZnC/iPpa1INLdg==
X-Received: by 2002:a05:6602:6081:b0:855:1c54:d0e1 with SMTP id ca18e2360f4ac-85555cbf2e8mr453678739f.6.1739384205963;
        Wed, 12 Feb 2025 10:16:45 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-854f666ba26sm328049439f.14.2025.02.12.10.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 10:16:45 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250212164807.3681036-1-csander@purestorage.com>
References: <20250212164807.3681036-1-csander@purestorage.com>
Subject: Re: [PATCH] io_uring: pass ctx instead of req to
 io_init_req_drain()
Message-Id: <173938420478.36938.14753182485522583191.b4-ty@kernel.dk>
Date: Wed, 12 Feb 2025 11:16:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Wed, 12 Feb 2025 09:48:05 -0700, Caleb Sander Mateos wrote:
> io_init_req_drain() takes a struct io_kiocb *req argument but only uses
> it to get struct io_ring_ctx *ctx. The caller already knows the ctx, so
> pass it instead.
> 
> Drop "req" from the function name since it operates on the ctx rather
> than a specific req.
> 
> [...]

Applied, thanks!

[1/1] io_uring: pass ctx instead of req to io_init_req_drain()
      commit: 5fa0beffc75910a694a90ed0425bb13674b10256

Best regards,
-- 
Jens Axboe





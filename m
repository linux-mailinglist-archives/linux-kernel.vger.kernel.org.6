Return-Path: <linux-kernel+bounces-539744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68D3A4A80F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 03:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06C03AA1DD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7F71BC073;
	Sat,  1 Mar 2025 02:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gD4T4Vuf"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1339019342F
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 02:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740795823; cv=none; b=UKZzvlA0GFbkv00Jk+HyY++ol36pHPK4bX4reEKYi9jLMy1MfXanm2u2heAEqM4lPl4yv+7nI1S1nPqWq7dhzxViiJGDdbyjOdmLGYSNRKEeMPaa7ww+Mi25JsV5nIb+wlWQTBTK4MYJEO/RDJ56oS11aF6p9rr3ISvDYIxsxDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740795823; c=relaxed/simple;
	bh=pKwkVTSQJ0aAuAlftXppJmht0Kot7MxlbY6yGzg7bVs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VYY5xyFid0oI+N5NgjJq0lE2Z/np0JAe9owCLokq9l/Fhn5CklrRRvjJauvSdVzLOutoAaO947YYViGGcVpHm2DnEsFOi0147NlUklUHyncJSJzcLJRgVxVgla3YfDrC7Q/sxQoQRkN9Dabllrf3QrUtc+ySufJ7upVi9WBjCww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gD4T4Vuf; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6fb7d64908fso24587507b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740795821; x=1741400621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BLBwQOwrrYQIN7raxU+No/2e8DfV51qZaSaJee9wDc=;
        b=gD4T4VufIzLXAfDpNNrVvusy4WZ9Vu4BbV7h18EDY/Pq7V27AuxzScRtJPvDQTZYRQ
         vJc3SD8IAUYnXO9/whnJC5v13Ue7pdLhAI97/RCSEzpTFX4wPkuopZ86Q7YuseS4OI6t
         XrnkI74oSNTWzx3NTz4j6gOX2iFgTc1mt9PbE+19m6dLNHbhmGqKdpHiNeA313z3eAki
         n3Bvk6R1RFULa2KBpxxaBXGXpWTY9EDJMz2xgDm9uNstRn0LyhRISkvWWyj2EiaVnfnl
         T4KX9kyx9GZCUuKIXT0i5/ZDl7T6YsqRwLQ4Fqf6d9XsimiPTkfW0HcvRnmeWCMfrhSI
         9Vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740795821; x=1741400621;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BLBwQOwrrYQIN7raxU+No/2e8DfV51qZaSaJee9wDc=;
        b=lu8riQsRK07+6kbsMErwUT3woBmJ31BXzGYKAWU6m/amTYHYMEQbQUrY2DtDrvjik/
         Jz3m7Xh2D+lLCQSmdn+88eh8xU4p7+3bzvD3AsnQO8wSm6BXRTs1Qx6HPXYDaQKCO3vA
         JI6UhzacTtq9WOBAFnh/Js2B7EdRU5u1WYK8y/FDKkvI3xlctw0CkG1YGxOJIZO4FV0I
         YVe2sJ4VtDSrxoiLPJAuC/uVvZGh1YbPaBfB51P8Cp7TnWrOmy3dq6LyaiCYwRBm1eUh
         KpWe+IAqDjhnhsMzYS7slc9ldC5e5zcdWOob09hbi7yU5r26ZRK6XyDL6ERF2ihOgA/o
         oTRg==
X-Forwarded-Encrypted: i=1; AJvYcCWUKUgRknI1ht/DIvZKXv/A1cHSr8keJIjcLXkQWv8lHFbJcmATbMmkrcC7kgfrEYOdCc3Miz9Bk2Zub6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YySF423QFiF+hDFfNXQ3yTbG0jV09QV+UANE1T9oXKwXeffj08n
	+RYpMn3pMzyrs2xxB4niEu3A2wLHamZxX+IVE92oE5uA0FwamZ9N2qsviHNTTDc=
X-Gm-Gg: ASbGncs2As3NThdFfMVTmvy2WxNyk8i5+vyyKZXcjHHqiDyXY/PKdCJQ/RcjPDOVcM1
	19N78b7LFOsPAkuJPCDhW1uQPHQDc39YXqT5g4vROty/KKQukWmI4QN3iUT9g3tzjbJe+M8Cvyb
	NWtvNcwEBFboAc8Fnz4eGRKkpyL5Lpa65Rn0R0CYCQjrW7CkXuDZfNPigJl1gg0kaDJX5vQPFz5
	Kg5s+I5T1BLtLeFbmqjpkEP1P+burpenPWkhK68RRzKwhyEzbYJVJX4G4dyLvwFoK6SXm34yCwd
	1FUlNxD+CeC1GZsDZtkBMRrEupqOYH00RADV6C4=
X-Google-Smtp-Source: AGHT+IEAfgFEonGI7v81NxkPZsf+pVyxnn3pBYJKAcjf3ha9OznoVu7uywfX2gEhdr3ETKKz7Ff3pQ==
X-Received: by 2002:a05:690c:5719:b0:6fd:3ff9:ad96 with SMTP id 00721157ae682-6fd4a16d0aemr55511127b3.37.1740795820960;
        Fri, 28 Feb 2025 18:23:40 -0800 (PST)
Received: from [127.0.0.1] ([207.222.175.10])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd3cb7e02dsm10175307b3.84.2025.02.28.18.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 18:23:40 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Pavel Begunkov <asml.silence@gmail.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 io-uring@vger.kernel.org
In-Reply-To: <20250228231432.642417-1-csander@purestorage.com>
References: <20250228231432.642417-1-csander@purestorage.com>
Subject: Re: [PATCH] io_uring/ublk: report error when unregister operation
 fails
Message-Id: <174079581972.2596794.14825315582480664341.b4-ty@kernel.dk>
Date: Fri, 28 Feb 2025 19:23:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Fri, 28 Feb 2025 16:14:31 -0700, Caleb Sander Mateos wrote:
> Indicate to userspace applications if a UBLK_IO_UNREGISTER_IO_BUF
> command specifies an invalid buffer index by returning an error code.
> Return -EINVAL if no buffer is registered with the given index, and
> -EBUSY if the registered buffer is not a kernel bvec.
> 
> 

Applied, thanks!

[1/1] io_uring/ublk: report error when unregister operation fails
      commit: e6ea7ec494881bcf61b8f0f77f7cb3542f717ff2

Best regards,
-- 
Jens Axboe





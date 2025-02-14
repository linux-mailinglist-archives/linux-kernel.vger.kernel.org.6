Return-Path: <linux-kernel+bounces-515755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B82D8A36897
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F761897C1D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D372F1FCCE7;
	Fri, 14 Feb 2025 22:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tCTVgANf"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBD41FC7ED
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739572832; cv=none; b=dvNAoyXzrxoNbN8k2mqMNC2NIBz6wyV+ZMB2+3Lfi9mJ3DvatixGZN0GMTpmo0fXQuW8ES3Ub4xq4iTBQizWKC+wN1uwhuI+HpuTFQZROHz+5mSq8XIN+yq5JO2Rrf86sJAGWlwH2WDPbyEU5ZrTFqKwMC703q+HJDI7akClgKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739572832; c=relaxed/simple;
	bh=ZGObRox+8WuLTA6QeatV3WsGq0mEh5JfGFT8vjpr7rU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DywPj5QV1+v1RSnDlUdrj2dJMynl5dOALQ35E3G5aRADIoIQdFaedH2hCxx8mnyBc15WgqgeYyOBC5LxN7Vih+9pRjzI9fUchxI+hQLSgAy26TDOw/meEogOxMEOnk31/EAgtQR/ujwhaNP7XQaalt3tb/80PKxZYTygGv2ElNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=tCTVgANf; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-8556adad825so157492439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 14:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739572829; x=1740177629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fa9W4XHgghBrAnH97Pbhz4mqOnDw6PjIeBtYFOVDltw=;
        b=tCTVgANfRISSBx9vJ38yf/qwrTr4/l/spAq2gzkpW1DKnBTXrT5WpnAQ7ofZO08Zo2
         F6FjriyAuDfKpoXM2HDtXqXI2f9awtmyAwb4zm5mCuS/7cP6/vSeKfEbwP5g2JEUtoc2
         K7mNU5GQc8b+lPTg5yi7LRf06CVbJJ5g5Ofs9S4MiTS7xrkq71qh41pr/zL/DAfn9bcP
         njadFNXzZ3yj3rjoWzQ5VBjMLMgMbktGERGrolXrtxLwHgUzrDTnBl3f5SMBjKrvKRjA
         RUaJylwEbUXm0aGsdf12orSQLcVHmn/hSFdk0/Pm1oG2yHAWqjWTtB9vJJAzScN7hSar
         OCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739572829; x=1740177629;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fa9W4XHgghBrAnH97Pbhz4mqOnDw6PjIeBtYFOVDltw=;
        b=cisJGvp+9ZeGBbpQi0sdAj3Q3Aj16SNbq4XGZJJdWAOPWD8kz2LKz7RjP1m69fIk+z
         EpekJY+qSaKA1OWFAExe8JjUq9I/bpqxAFEEZfRhyU/SYEpGaT/4f538EgB0Pbcr15ce
         0wdljh6S2LK3UyL0iy7oGPDE5UpwQ922wDjW0ZFxQYxGscSJ7CtdDxA8i5wd2bawr4QG
         pkGyBqMxKsqj3Xt9mcjZtVBeyXXgDeqooiMZmz659g2dapzY3wW8dTCEggG7Qm2ON09/
         D7unlD68qUUAWbTYlixQSBr7kX58rZdvj6qVIrNnwRjXIUZZJjHvOFDxb3zbPuThPzbg
         bULw==
X-Forwarded-Encrypted: i=1; AJvYcCX54r5Tjmli1Q2xWyRzI+xJDWjzCK/quvXdzs5vi+nqLgtpPgzyhk7hXkWa5E9I9EJiASnuf/dWGHtRvis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw3F9a03UlDj8BwpOVWdmvDHZ/ZkmisyP0NyAcf3UdnN0m/IP2
	BAyuVrmB3NkRKrQK6LPk3+Q6ZdkQE3NDiWldtc8mfVWzGSr2njYRrrRIiSE9QwU=
X-Gm-Gg: ASbGnctEqEUG/GbdGKQDZj3RDITERTkxWAJg2Lwk9Lf7lpaErNj/9LtPBi7gicsj/a7
	38vCP4osjf+GGqoloe3tQZLhNZpyN4MtIQ4xnrqhCPEPRjUlgNJNzZBqlNe3KUL0EkJCQfK47UV
	F6ywFK7nINx1DzpxJPT99qWLFvs+XvzMf9VqIpqi0oGmwQ3JQCi2gILUP/1jnUrMqXxOXQFCu62
	YOipllI28XCnykfvdo1QoFEzmGk1YnLwOjn1ipGSWZJCMlTqZUgKbp/jUxmD4lun1pQhsSSKglj
	STUASEI=
X-Google-Smtp-Source: AGHT+IHo/sDO3CzWbsrCfscoivDifZjkD5COpzMt+rasMWA5MnAVrwjSI6GkP5oWPdKyiGiLtlm3/g==
X-Received: by 2002:a05:6602:6d03:b0:855:7832:61fb with SMTP id ca18e2360f4ac-8557a0dbeb2mr134971339f.3.1739572829287;
        Fri, 14 Feb 2025 14:40:29 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ed282affeesm1020648173.91.2025.02.14.14.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 14:40:28 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Jann Horn <jannh@google.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20250214-partition-mac-v1-1-c1c626dffbd5@google.com>
References: <20250214-partition-mac-v1-1-c1c626dffbd5@google.com>
Subject: Re: [PATCH] partitions: mac: fix handling of bogus partition table
Message-Id: <173957282830.385288.5820409491649052216.b4-ty@kernel.dk>
Date: Fri, 14 Feb 2025 15:40:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Fri, 14 Feb 2025 02:39:50 +0100, Jann Horn wrote:
> Fix several issues in partition probing:
> 
>  - The bailout for a bad partoffset must use put_dev_sector(), since the
>    preceding read_part_sector() succeeded.
>  - If the partition table claims a silly sector size like 0xfff bytes
>    (which results in partition table entries straddling sector boundaries),
>    bail out instead of accessing out-of-bounds memory.
>  - We must not assume that the partition table contains proper NUL
>    termination - use strnlen() and strncmp() instead of strlen() and
>    strcmp().
> 
> [...]

Applied, thanks!

[1/1] partitions: mac: fix handling of bogus partition table
      commit: 80e648042e512d5a767da251d44132553fe04ae0

Best regards,
-- 
Jens Axboe





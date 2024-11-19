Return-Path: <linux-kernel+bounces-414739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C229D2CAD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABEB6281512
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473AA1D2239;
	Tue, 19 Nov 2024 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ja7JW4AE"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92691D1E69
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 17:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732037418; cv=none; b=m15ATGR+Z5XZsHb4PUnhhGJZO8WPzWXIMSMZ8yJBY4H6BWbcBJGJ1AMgIj8TZwEjjB7qASSsRQvqjPCWMnnEDcXn6y5apsrqnmPVDhBzA/Og5ZzeFPv4gJfG4tZN6ff+wFj5kt9xZMU6AhUyZg98obNPYNk637XvWEhHYzW2wHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732037418; c=relaxed/simple;
	bh=8HJq7NwqhChQyegz0sCYyZp2xmSM4MBTlZm9RLzRPyU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tFv/VtqlVyLq2YDdzw8/rCKflbTq8yJAN24EalsK4PhZvu7qBRSYpYI+j+FMc7Kyyyrwd9tYf1igkYmbiRKjW1pzBLM5yr4xs/vnuJSKgAvEOAvQEWIqlnIa1SCGY+ASe1u1V8lCOWZOGIWb43WEJUWIyd/vQZp+AzMjpPeCJ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ja7JW4AE; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-288fa5ce8f0so1292962fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 09:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732037416; x=1732642216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1XwymtzFptex07g8t0oBCz32E5vUvl6qwiNVcfZVz0=;
        b=Ja7JW4AE6B7mFJ8OwRjahcijJhgkhfgGBeOyVXVDo0IZsKir0IIFrWU7k73D+35swg
         jjvh9L7Ck3IgLSHRNFX3Ccw6Z6XZlwvUnCpISxlWQqIyL2uSDyYSQmL/JaypK+K/NRPN
         6j/wTbvQOkNhSc7C8xDUoJ/cmlGhiuYY4W49WzqvdzCpDFSj9T//N8sB4e5WM7PpCtLk
         TwoT4QryzlqhYFqIe4I9JMxYhD5XS1p4tQq8AcTce5NSCrgCJYVrrILmdchEPlxPW4Sy
         RKDizfCBPo8SwILEOO5vrWOOD0TactJwf7ozsYwFbs3wGDyjApjugkYPjfsbojQbJv0I
         X5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732037416; x=1732642216;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1XwymtzFptex07g8t0oBCz32E5vUvl6qwiNVcfZVz0=;
        b=j97mcgx+earTAM5iNAsifX7BeihHzpqs/krv4xOztx1DwLqZn3ckJ1/0CgkPeneC0Q
         bFpC5mMnV5rdzMcSMEPOJLy2JXHyjKakP0Wif7rPr0PQEePhPhT35RuHE1Pplh1HFfCi
         ICh5LHi52cA5jcMivxAJrPKXY90Vvv4u+oXsQNnJCfJfcfbe6U9D9JrFMA/j+BSPKUDB
         f+a/Lmfc47UCdYCPmjnsPlMQ3oTLuD6wUEBOcz5c9dgFzHk3MpnMJ96Ha09FuWWA1GvU
         zAMXFrgZO9JD43YTopjLNHx0CCmqauNPW0eu9gsRnVKYA713FyNt88mUVFU2KmuU/Ztw
         PhNA==
X-Forwarded-Encrypted: i=1; AJvYcCVS1p0U91QU62byRHj7zLjHx0l3t0xttT8O7+Hsxpf1vKkXYJMsFr+LaYhx6YBnp8m772P/+FxFiSs6bAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvr9YCWwRPWL6rAoeTl31zubv3F1Na9aBiNy5Aczhi8uhQR6Cu
	h6RNovUT+du3kadyGiTQJYG0nSSthBnyxa6TEtDazQQEbYervh1mC22BOqIZ20o=
X-Google-Smtp-Source: AGHT+IFbst9trImFfYVW3CX067lMGhsuhKjR8MGYTNOoJM+ovbJqMJ/SvIsnK0nojAHbjy2eogmP3g==
X-Received: by 2002:a05:6871:3a0a:b0:27b:5abb:7def with SMTP id 586e51a60fabf-2962ddd314emr15082932fac.20.1732037415966;
        Tue, 19 Nov 2024 09:30:15 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-296518bb670sm3595531fac.12.2024.11.19.09.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:30:15 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: song@kernel.org, yukuai3@huawei.com, hch@lst.de, 
 John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-raid@vger.kernel.org, martin.petersen@oracle.com
In-Reply-To: <20241118105018.1870052-1-john.g.garry@oracle.com>
References: <20241118105018.1870052-1-john.g.garry@oracle.com>
Subject: Re: [PATCH v5 0/5] RAID 0/1/10 atomic write support
Message-Id: <173203741480.120673.1977109756276902670.b4-ty@kernel.dk>
Date: Tue, 19 Nov 2024 10:30:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Mon, 18 Nov 2024 10:50:13 +0000, John Garry wrote:
> This series introduces atomic write support for software RAID 0/1/10.
> 
> The main changes are to ensure that we can calculate the stacked device
> request_queue limits appropriately for atomic writes. Fundamentally, if
> some bottom does not support atomic writes, then atomic writes are not
> supported for the top device. Furthermore, the atomic writes limits are
> the lowest common supported limits from all bottom devices.
> 
> [...]

Applied, thanks!

[1/5] block: Add extra checks in blk_validate_atomic_write_limits()
      commit: d00eea91deaf363f83599532cb49fa528ab8e00e
[2/5] block: Support atomic writes limits for stacked devices
      commit: d7f36dc446e894e0f57b5f05c5628f03c5f9e2d2
[3/5] md/raid0: Atomic write support
      commit: fa6fec82811bc6ebd3c4337ae4dae36c802c0fc1
[4/5] md/raid1: Atomic write support
      commit: f2a38abf5f1c5aeb3be8e9f4d3d815c867fff7ca
[5/5] md/raid10: Atomic write support
      commit: a1d9b4fd42d93f46c11e7e9d919a55a3f6ca6126

Best regards,
-- 
Jens Axboe





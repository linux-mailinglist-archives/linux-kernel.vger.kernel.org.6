Return-Path: <linux-kernel+bounces-551954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B75B0A5735A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964913B4F1A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5360B187346;
	Fri,  7 Mar 2025 21:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="n201nEU/"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E2F23FC41
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 21:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741381776; cv=none; b=QeqM5j+GdLl44wEU8CBN0fmN8im1zicjCdJXcs4i7z5PWH7ha7X5bshhXarU7h24hEa8pK9altCr147qwBpZ/gMoARJHP5r9fiIbuperGgpNniGBHOmN+SK4gPlb1oWRe1ppnSftFlp4MhJa7VPTDLakhWDRO+ECP8fIJvYX9go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741381776; c=relaxed/simple;
	bh=MnJqSez3QnP7+5tsjkp7EcC/2Q40YfWkuABhHyzVpPY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Jz0D+z8lwSKHll8HYUEam6J+YPjSHGs7N1kYtMLyaFXbMpuZQpldj+ZTDucLd/o/ywlE0Ad+hOQuslrpJfuJnQHCalsQClglRN+baxYFb2yyFJ8AI0vwdzZLAs4Q/W9PKElAKuDXA+KaihYBXMx7UGerPn2iRPalFPpJwHRvMMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=n201nEU/; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-85adbdf335aso70210739f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 13:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741381773; x=1741986573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YzFd4E9Lufa9FfWsHU1RBfEO6fdHd7iDybQW3EVJSI=;
        b=n201nEU/7kP/8JfXu3ECdKuBRYbJnCuqLaJwNndORwfEtzjBuFCrWe5frF/xMXD1NR
         xERJsIhZvfoHCRA9YM4ylCyXVCiQQUQo5yNt5kOKjttlt7wZB1sUzg6a/NNEl6d8FHAH
         jpMo3TTtJYMRcvnaKefBi3gFat5zCISelBs7qTkbr3syvPGv4EVnJ3glWBjJ2sCal8Qh
         DzsQFJnFD7fwfzGk71BPmPUr95bKyyrZLl1Imo+CtbY102Pt2xRQp/JiT9oTY4O9DybX
         7uieetXyjEx3ItSf42ew1GroB9CLR3yT7242MyMjm2hr0AzSLqktmjxLI7nTLR4CNLer
         8CEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741381773; x=1741986573;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YzFd4E9Lufa9FfWsHU1RBfEO6fdHd7iDybQW3EVJSI=;
        b=o/PVoEQxZglXqUyymyCH9GW2A3uKHJbhkH0IwheK8a7QB9gZLToYIVX5pqld+4z5WR
         QN8x8CrQgUGidMOVd6N5rwUqUERnu9o3e4vxQSWfbShqZiDXdGCSceGWBSNLU7PBxwri
         ciq0lHHsAk7gA7wRcniK+mS/VMj3DHsduQwhgBg7nCtOgqQptxMS9MI5/CFztAuYSGv0
         sikzZRjTo40hUXEQryRaPdiRCt/MScd6P7YmEXrhBPwaUMi3J/0/mHBALLeRHihGU/9U
         qXFbVVx7j3SU2bGvk68JJ3DqnrZLjNe4smEQ1aM2yAa2JhrAsfnf6AnZD+ZcByn+P9iz
         +VGw==
X-Forwarded-Encrypted: i=1; AJvYcCUgO0A0bZszH1HBStvrq3fa+136C07njO2hblA0RXlZ6ANa/P5z28ZL52zx9SVIkLYvJXGYYH2ZY4EL08g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxocSS2S0pdRVvLVTm1RtbTM6gHK83i6bYLfZ70RGikQgZE9upJ
	8Ir9lCrFKN1QdTmvR6UEvIfcBilBTL49Hh6BPzXgo3ksxKvjhNfNYVYEEhN2jjU=
X-Gm-Gg: ASbGncuYt9YIDUC67XM2HP3ry8qL6xgytTk/+uE+YYyZueEcTmOFxIdSc4r++7AitMq
	GnaNSbtu3O0hRf+d1H7fsMU8N5CG9rjC9r/wTdIcP7grCFYEab94U1njIAtlIpxskoW/LTrCGM7
	r4pSN8otb/Qm9JynMg676OOoKW4+aHG0oOlc9NyI7mu0HrEMsJ0yrL/lEsqSM0r1347FzxeG+5E
	iI2+wdq2BJMSeBsbnAftIHUnmosAW/MWUCU63dcaUG5NYHXsLCOWYtWDIGgD7I5hmxvao7RiLwA
	93bxzdmmuOmx1ZK+EE26Qae8xBfsElkUB23V
X-Google-Smtp-Source: AGHT+IHxrRV2S8iufrU4N6r9tmMryzLqUeJG9zpUFdFUimBoScchzmlls8eX/8sBB/9IDRhqU9ZMRA==
X-Received: by 2002:a92:cdad:0:b0:3d3:faad:7c6f with SMTP id e9e14a558f8ab-3d441933118mr54168385ab.5.1741381773699;
        Fri, 07 Mar 2025 13:09:33 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f219d8f4b8sm501688173.100.2025.03.07.13.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 13:09:32 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: asml.silence@gmail.com, Yue Haibing <yuehaibing@huawei.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250305013454.3635021-1-yuehaibing@huawei.com>
References: <20250305013454.3635021-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] io_uring: Remove unused declaration
 io_alloc_async_data()
Message-Id: <174138177254.441913.2825147745807855695.b4-ty@kernel.dk>
Date: Fri, 07 Mar 2025 14:09:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 05 Mar 2025 09:34:54 +0800, Yue Haibing wrote:
> Commit ef623a647f42 ("io_uring: Move old async data allocation helper
> to header") leave behind this unused declaration.
> 
> 

Applied, thanks!

[1/1] io_uring: Remove unused declaration io_alloc_async_data()
      commit: 30c970354ce2a4c6ad3a4c70040accd34082f477

Best regards,
-- 
Jens Axboe





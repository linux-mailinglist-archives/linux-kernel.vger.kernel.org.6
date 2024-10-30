Return-Path: <linux-kernel+bounces-388739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 428789B63C3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E28AD1F21265
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9FF1EB9EE;
	Wed, 30 Oct 2024 13:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hwMwd1xA"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF7A1E906A
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730293792; cv=none; b=U+/EVe9OcMVGQtIcVlIeEDCH9BCERClbAV/crNwfmm7dZyvEhOcPwnseGBuCmpRzV0lJASuigD1zed1yGKCPq+Ct04RBpQQQ82u0WaX4ebJzce8o3F/nsRIGPE5K3AWOpPkMCDSHuBhL31lWOk+TQ3nb4A5vV6w+Dgc/y/Y64rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730293792; c=relaxed/simple;
	bh=E5OwLTPy54ufFGgeBpt5ox7GUyM51fdd+bAxUQchzFg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XnFgGNPxnSYFMMW7H+I9Q4CicW1ORO7Spsllsw1Qj/MNpof/CjgG+apCXtSll/k85gJAZH116oNEHh4GjFmvFv3Iu456dv4St8wJghhqnmzQhSUjDPK7dJKmLoITX8JmQOhNuuLmSu5cDiXGwEOD9SXjS7gdwOs11SHtNVDRZ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hwMwd1xA; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-83aff992087so252970939f.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 06:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730293788; x=1730898588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAS1y4kZ27f1rr18cg6s15oqwDD8HYKBoo6u8v38O4g=;
        b=hwMwd1xAdjjzsa2bcepYVHhaKoyG6zIXaC0BNxmuQX1BrBMYhPWZk19ohypDhvh6d3
         UGwW02p7ozyNSltuYAp2RVuu85PVPWiax5vrjs1opSRgisRwdk78haM5usLhXhQZQVrz
         1AzIIG+u7TAcCOLYR4ZdeeC7H+SR/O2tU6Lt556LvBVKZwrJSvS/X6fex6Y3GFb9MXpM
         EQb9b6vsOnuGlHW2Lzyp7i2OEvVUdbyEJpW63gq6T63AVaHrFr2hukCaKwnwS24UKGl3
         3W7n/CJZpbowROnIgg0asRJ4qfzzLQKuG85FTpd1WcVBtic+5R4tYQBoOQCT5b5xsjZW
         nJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730293788; x=1730898588;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAS1y4kZ27f1rr18cg6s15oqwDD8HYKBoo6u8v38O4g=;
        b=JH8CJY4gC1hcbAZhVKZ3p0fZRE4GG6IhL6ak3L88SXMlJcJ+M4RYJsXGmHHbnCR74v
         3ffAEEqtJm+G5RXqGR9ugqOUM26P23fwQlsIaakAClauY6WmNZ8aH15BdEJG5USGF0A0
         0n/H7ia9zW4Ng7nLUz+LFUJBzVweB4dCNyQwZHGJa7aE3IqwgbxGF/zGN9WWfLAuphaR
         Gp3S8cQ9yUslqBb/ZtVeKzyxNxgAM8yVy/fncw8NWVTpHoKu/h2y+KoDlmXZwRiq1QqT
         8HZHEKVd/5NLlUyke4a4d7Z5UX97qDzAedBR/AaCqdKutuwGBrtGKCW9hxKjmCUHv0x1
         Hz0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSjau13/52wVTufcPo6R+9RyIzuECw8ef7ELUwL0dxDo2zgQ8xyvVmAN0P3XNn/qD/zLB5s5EO5OGvCW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZWe1MGiwzqc0ssqHajwV8PzCC6SZJMrtjWo+Q9M5rif5zcOwy
	RBEZzbqDJmVEcU5oEc7uqtK9CHYw5MNgqu4iu4+WhLvb19T+C4mBCz2EMKcSv5EM5QRuZcJ7gpD
	f
X-Google-Smtp-Source: AGHT+IENNDyNNZGII1nL/NaaQ0kx9gLki/JevI1ijapsM9JD9CCx62rACXRjzrtMV0m6Zp+z0JciFA==
X-Received: by 2002:a05:6602:1656:b0:834:d7b6:4fea with SMTP id ca18e2360f4ac-83b1c3e9fcemr1284626039f.6.1730293788122;
        Wed, 30 Oct 2024 06:09:48 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc72751298sm2872855173.91.2024.10.30.06.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 06:09:47 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <70879312-810a-49ce-aba3-fdf7f902a477@stanley.mountain>
References: <70879312-810a-49ce-aba3-fdf7f902a477@stanley.mountain>
Subject: Re: [PATCH next] io_uring/rsrc: fix error code in
 io_clone_buffers()
Message-Id: <173029378724.7840.5463253318064416297.b4-ty@kernel.dk>
Date: Wed, 30 Oct 2024 07:09:47 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 30 Oct 2024 12:55:06 +0300, Dan Carpenter wrote:
> Return -ENOMEM if the allocation fails.  Don't return success.
> 
> 

Applied, thanks!

[1/1] io_uring/rsrc: fix error code in io_clone_buffers()
      commit: 0f576012ae2ff08009ce91e2294832e2b88aba06

Best regards,
-- 
Jens Axboe





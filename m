Return-Path: <linux-kernel+bounces-191377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023218D0E71
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 21:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 707DFB218A0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 19:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AA016086C;
	Mon, 27 May 2024 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EbnoTdId"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6401CAA9
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 19:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716839936; cv=none; b=gGKMig8cKxOsAiD9nI/v3H4+KXvofQAX9YPN8Ext+A7Qv5l9Bp6RUE42x1JCRCCWjmtJyyTmZqu1+ZHPcJ9BgFzzT49D+UNkG/rQ/Gf8tRcJ0/3GxF090lHR7+Qpj4GSm8aGprkebgjj1JlpVWSELmcWSvHu/Xbk22aS0h/EIIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716839936; c=relaxed/simple;
	bh=ks7Mff04vGsMnYvo++ZgpbVUC58K1Rpct1dh+KIWgFY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mcKwGFsyoTWn3ZSlZ563TnISdBnLDbPzP5G0zgX21cxkfWDKbZ3O7NC/VK8xyLPrmUHJyau7tBrllwSObw7zWTbiqvv2acAUl/AMEtLlgkWo5tjch2ihXDWtPYwPVNbyG9GvdfdsOScrHctfsZdU2TxALToBlJHjpGmzhPh9c9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=EbnoTdId; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2bf5ba9a2c5so12393a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716839934; x=1717444734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCtCHMcHGMsYabdcrTqMbv7AnaT2U5qGwPVOFGULJ1o=;
        b=EbnoTdId3NxJG0KlUC7WP2Oo15uqEUL6PYNOytUppr4vz+EfdjnXAIClxpE2yYa6V/
         K0GFMFuoU5Oh9pCBej9q1mAemfKiVU1s1BXQIimnVIvbmfA58TvFUcjduM6dNZsP6wyH
         OUSCVQwudDowCk5GeTqilB6C6Sa3Sj45KV5EeoRLA1sgg08QyiDNpa4qKhMlv1wutC52
         VG2XPsXmCmWNop7HcujFGHcU91+ZSeYAMftkcmIE9jnIDSPJk2W73ClwxXXvEkefmwoo
         Xo6/Han2y7bo3zlh3QLpNblGWyHPfA2xECfZ2X8qv7fSqOXonbvMcOFIP52HiSWomR0j
         QNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716839934; x=1717444734;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCtCHMcHGMsYabdcrTqMbv7AnaT2U5qGwPVOFGULJ1o=;
        b=Nsng66E+K2gPCyAZZs69EKGkkGYrDdXpQBBdqjPrrxgCtNiqivNeucp0GmvOuPfn9D
         8zlP7pgMzcoco+wrgvgUaHzq4oMrddCizs280TFI6wtIwUZGQUE9MNhyiNeFWzkG1mnm
         kcSdHM3rIzjrbm735bQba7URdZdP7vylxc/oxz/E9jlOUcpw/nhanxlSl9JrL8gJsJfv
         8CBp76lT2C9VLMpmIuNvVKSfvRjH01+emL4gXRLtCuCnGCFO4zqjxMGk7PQDQFpMoZTg
         6yZmBvxFRPa5pMHLoCdFVFkJtOnjRXeoFxCtxi40wWk5nnSqAaDyTd1rfYwCIggm39xp
         OTPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH4+G2+p7eamwF5tWBKz8FxIUm9bK+lhkRJxc6szUerk3GPC6T1A8DEPlniLnsz5l7XRiM3wnIesjA5Oh23qFRV4tnPOsa4cdcHGHT
X-Gm-Message-State: AOJu0YyndF9dshBufrTU5mzFcj+tIx+qWVFCBhO0ISjVf0foiuWR7Pgg
	FprzNjDRJwVNdZkmGoH6KKdoTP2rT4swGQHUC7CG4+o6RZcW28qstpF0z9tAuTE=
X-Google-Smtp-Source: AGHT+IHwIZPGluEus19FHdXWfCpeZrfreP+zIjtoh4A1gbN0wdglgFYVjd7Dn3/nbJj/bXdL8h7oAQ==
X-Received: by 2002:a17:90a:df13:b0:2bd:7e73:6628 with SMTP id 98e67ed59e1d1-2bf5e0c1bc4mr9801465a91.0.1716839934416;
        Mon, 27 May 2024 12:58:54 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bf5e13b6acsm6218409a91.0.2024.05.27.12.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 12:58:53 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hexue <xue01.he@samsung.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240527084533.1485210-1-xue01.he@samsung.com>
References: <CGME20240527084541epcas5p17fa0a6ee3f53148ff0896703c58146b6@epcas5p1.samsung.com>
 <20240527084533.1485210-1-xue01.he@samsung.com>
Subject: Re: [PATCH v2] block: delete redundant function declarations
Message-Id: <171683993340.262308.9239565153961135856.b4-ty@kernel.dk>
Date: Mon, 27 May 2024 13:58:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Mon, 27 May 2024 16:45:33 +0800, hexue wrote:
> blk_stats_alloc_enable is used in block hybrid poll, the related function
> definitions have been removed by patch:
> commit 54bdd67d0f88 ("blk-mq: remove hybrid polling")
> but the function declaration was not deleted.
> 
> 

Applied, thanks!

[1/1] block: delete redundant function declarations
      commit: 30a0e3135f9aa14ba745f767375183b3112d7440

Best regards,
-- 
Jens Axboe





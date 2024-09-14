Return-Path: <linux-kernel+bounces-329301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4716978FC4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 11:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8466B260BE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 09:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63ED1CF2AE;
	Sat, 14 Sep 2024 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vTnNCeHW"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1A61CEAB2
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726307914; cv=none; b=AF/hw55RtczD3rKC2ybKlOjFhGUvrx3s0mu+CD5wpr2YgTTNh0IcxTitTuupdNNC0ELVculznXvUcbC2nU7pEPSi5QVqLtImS4Fqjwm+rR29wavIE5PpxxXw+7mvLaWk8hqoXHmikY9tTpUrdwexFHYfzbHgCudDiIdxVUEViZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726307914; c=relaxed/simple;
	bh=ya7/LjfmKpMsoE5aQBDX5qZQrPs7t0zo+9KUYJNQStI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KS7jn4ko/NLH8XNl9dEQ+BX7HtfWyvXiFYhI8hID5+DK0nmvL8wtLzQf4tMmUOew+FgnyQyzZmGWBncZPGu2zxxouufc3ZI1B9OLMREPlNF1I0PBADraGKdjkGYkCYSWXhimKf5fcYfUlUsiBeUpPC9ZEWrhL2uGX4nEgMpkb2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vTnNCeHW; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c251ba0d1cso3446906a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 02:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726307911; x=1726912711; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fdccIKzjZeBA+TQzTuhi7PDMeQ4nYvxBAZIlCMJ8mnI=;
        b=vTnNCeHWFAfU0LmCfnv/tvrG5P/re32LBV94Lvc/WUEXelnBWOh67l0Dkg5dvDfrZo
         tOidpEmCDf+cpmvTOdGZ5wDNnGDMW/145L2XVRcXviN39ADSZRX7ReRcpD9sn7N1gHx6
         m+MMSqcdfbUl2/vGuFzczv1z6Je3uPMizntJMkc0+JOIh20o8OMJvRsVUfJEB7o9PXKm
         Id0J6YSO6S2zWmuOtahkN3+FtZYM19sxRKxivNyWnqqLzMmXciXQ+CSV2PjXoxjRwIsk
         0sqwTyS1/acHhyUEG9/vKQjKWJPlAUeX40cQu99/v/QIvbzpTIE1ZaSF2mj61SeF0akx
         /UZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726307911; x=1726912711;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fdccIKzjZeBA+TQzTuhi7PDMeQ4nYvxBAZIlCMJ8mnI=;
        b=ntcu7djggHTS1ShSD83faHtQfZwmn10acHx04iNjuXtVBEj/kkVwcmnAIR42zA92EL
         AhX0k7kBKsCpuAl1I1jPDz1W7rddd6uipbubAhKUE+1XeIauF/kC9d7YP2Viz1yujsS0
         V4PP+mnKEQLMW+6ZM3uppkpL+CqbqrWSPqFnUtRIjw6+mBl0df4c2/2hPqiPwn1yWZaa
         QMfVviz9UeV7CJLbP4O8Fi/Kbp5V2uNtUvkU1OLyvg4zysSnbc3xh4ENEeYLQIyG6l8C
         xYCMJhlGtM0U5ANIMMkhmVsu91ImwMRUY+6E6u18cpv/XLPMP5UuCx0ThR9d1n3VMAzi
         VlDg==
X-Forwarded-Encrypted: i=1; AJvYcCXIXaI3wzVfc6lsUYGe5Cao7F9lTzZWISr1+zxRhGM3auKyBvf1LAppbE5oHLYfkYUB1iQiFXpLsheOHIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwI4PanIIefToT8vQs8Cw0nxXM2PdparCjgc8I5Ym3Cbiosimm
	gZ2iTUiY7HsiELyJW+qSiBFTsOuIP8s71st58bnO+jFpO21qxbnp/bihuFiZZ5w=
X-Google-Smtp-Source: AGHT+IFJrSTGbj6IkzPSkz0zqYy3lgixlfvOUhv6EL9dyvHz+N7B9GcrOxAec6RJljG6MrVvxkq3eg==
X-Received: by 2002:a05:6402:26cc:b0:5c4:2d7d:9759 with SMTP id 4fb4d7f45d1cf-5c42d7d9a77mr783746a12.10.1726307910740;
        Sat, 14 Sep 2024 02:58:30 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb89d44sm499739a12.70.2024.09.14.02.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 02:58:30 -0700 (PDT)
Date: Sat, 14 Sep 2024 12:58:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yevgeny Kliteynik <kliteyn@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Itamar Gozlan <igozlan@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net/mlx5: HWS, check the correct variable in
 hws_send_ring_alloc_sq()
Message-ID: <da822315-02b7-4f5b-9c86-0d5176c5069d@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There is a copy and paste bug so this code checks "sq->dep_wqe" where
"sq->wr_priv" was intended.  It could result in a NULL pointer
dereference.

Fixes: 2ca62599aa0b ("net/mlx5: HWS, added send engine and context handling")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 .../net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c
index fb97a15c041a..a1adbb48735c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c
@@ -584,7 +584,7 @@ static int hws_send_ring_alloc_sq(struct mlx5_core_dev *mdev,
 	}
 
 	sq->wr_priv = kzalloc(sizeof(*sq->wr_priv) * buf_sz, GFP_KERNEL);
-	if (!sq->dep_wqe) {
+	if (!sq->wr_priv) {
 		err = -ENOMEM;
 		goto free_dep_wqe;
 	}
-- 
2.45.2



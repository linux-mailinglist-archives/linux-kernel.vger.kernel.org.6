Return-Path: <linux-kernel+bounces-415867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B189D3D5E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2381B1F21D40
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB171A2C25;
	Wed, 20 Nov 2024 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LpmCIM6x"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9C824B28
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732112028; cv=none; b=D9hBgQ/OvCuA48nauHOUC10PzQe6yMrpvpIvFYcWGQRXRoIlSGMiCEhI4oVtSBVFGRr+QVyuxnaHOqUC9L0GAn+jX4sl3tK8NYNrN6lQU4QsgiSmFaGFWvk8HDNfCvDNDZa1zjQYayXOH+pKGmYWGbTBVB8+NBzmGZCFypQbnb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732112028; c=relaxed/simple;
	bh=fG2rtQP3i/fL3pl3U4h6EqkOrbGR5g+ma9OgPWJDVWE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CeVzA7qwpFs5uu69FDKdJasX6rdYbsaumvAggqLyC4pVY6C8FWqLzY1+AXzeDlICKFyst7N5bBiavtri/RibIBHEfdtykqIbvId2CERns3rHH09WHBd7eAka+VE9PzUKWvPMo0lG3M8hOT3z/pHjLfeza0+3jWPB+zixEFTsI+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LpmCIM6x; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-29678315c06so1817003fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 06:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732112025; x=1732716825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTi5b10WLqsSCiJUbo5/jmc+MHfUzlPQvFKPqOZIskk=;
        b=LpmCIM6x4TvKbGsPpW1de+zhTNl+wyyKhR66oMlBjtPPpyw3WK1HsH1DFSH33jlEJ8
         P+6hE07JpLLfp3Ihp3RpUSHwaZ0BVel+cr3juEEllrLYdyZkBo7EN+k2uioJir5+fsw+
         bEWB1X2l4oelgfkbfvXrgg7HmejO/cI5N/vM1+IwOR3lLzdslmAiUvR9rPbDsUIzTxPR
         i1IZLvKNdCJdYioxtTv+jyBa+ZSSvbl9a+JnYukGDIctDx0uzzf8OJZF72RYQMx36Ozv
         4PskqUECzyv4QjFUOcxc92+HQX2CnlvXIS2OjBuAmo3abvl7dOxvzMwzo4ASPXUESiAJ
         0Wgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732112025; x=1732716825;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTi5b10WLqsSCiJUbo5/jmc+MHfUzlPQvFKPqOZIskk=;
        b=ndVce66QIhJ/SmQH/qedWLu95Tqv/r10BJf/qv7RwOBchHcDoLIHw4AVY6j3zNlXJI
         FZEn7Flb9Yq7fw2NCzafkoWO+nvV2YLPHddOMwQTRHMEJKZ978/BaEBDYpousP8QFG9H
         PSQFuaQaGxc5wdh788wbeyfhQ+wJ2/vXFjpKK+rXPl4cpQne9qDl6wWi+wWT7DtJVLo8
         W6G5XOsIVU/5CGqOLPbVdMs7C98N6wSJEqcPyNpdmxQ8rPhuohRd3rRbuWFteLHfoyMN
         vASCpYr+0I57poZ8uhS5LbgYXqpSwimwHcXLSAPPt/cost3/CaHGE6vmrWzBJ2Rzw84q
         BNvw==
X-Forwarded-Encrypted: i=1; AJvYcCWG4RH9WUGa47MmJmlTjD+/f2O93UhioVJF0ayAM8AIuYdhOmITbmM+SrM62OKwhQlZiBEpZ2R5M4AJVhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8cdCrnY9IVWENjDdziTAXUDkDGB117QIcrs5L11pVxLlvJANy
	qYH3byX9cFOEEKkiBQ23H1o4Ee7+yDeIiQ5MWn3kcZEX1b84h5d9cwI+qNWkrG0=
X-Google-Smtp-Source: AGHT+IHKEqEaFV0atda3jXxRVp2Q7ZAibmbPVVSQctOYrQe4CjaraL/pBwf2ptYdMN+qn4DtUXHsLQ==
X-Received: by 2002:a05:687c:2c11:b0:296:dd44:de85 with SMTP id 586e51a60fabf-296dd44e290mr2244900fac.28.1732112024924;
        Wed, 20 Nov 2024 06:13:44 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651ac5ff9sm4185830fac.42.2024.11.20.06.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 06:13:44 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <d8ea3bef-74d8-4f77-8223-6d36464dd4dc@stanley.mountain>
References: <d8ea3bef-74d8-4f77-8223-6d36464dd4dc@stanley.mountain>
Subject: Re: [PATCH next] io_uring/region: return negative -E2BIG in
 io_create_region()
Message-Id: <173211202382.191688.16891113055939966026.b4-ty@kernel.dk>
Date: Wed, 20 Nov 2024 07:13:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Wed, 20 Nov 2024 12:15:05 +0300, Dan Carpenter wrote:
> This code accidentally returns positivie E2BIG instead of negative
> -E2BIG.  The callers treat negatives and positives the same so this
> doesn't affect the kernel.  The error code is returned to userspace via
> the system call.
> 
> 

Applied, thanks!

[1/1] io_uring/region: return negative -E2BIG in io_create_region()
      commit: 2efeb13a0e2a0a188ae85ce7d838874a4c8d135d

Best regards,
-- 
Jens Axboe





Return-Path: <linux-kernel+bounces-200796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35C98FB507
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B313284FF0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89E218028;
	Tue,  4 Jun 2024 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NNEch1Dg"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F392B9BF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510644; cv=none; b=KpP4Zq0MtT8h/hTMNubJl403l4rnUUlEZT6leI91+Ao3cwDrjtfe/jwLGlcpIdaoWRVQ0wDFwz9sr3AX5jqWBNW2YpyEUnKR1vkn0lWPz0kTGB+3qqQyPJFM9RwkTdhgYDlTBxt1CJ9vgSrfqWwUGxDkmU5NY3F9KSCd7ff8Kno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510644; c=relaxed/simple;
	bh=c0Gl5eI8FJR4mEiSN4AXwqOECr3onflNZ+UtZXW07EA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Gjqe5ayo1pD6YBrPgsNW+nPhwCDcfyi4ZhUV9N41lswUMCCWNilsoPWAhmYcTsBjJE+YlJJ4s5+L0vWIghidbcHEEk4AMw82Sevb9kFCfvVbfWA6cUfY9zrD997D2YEVbrSboFIqFdzoF6KpRUjAKf3kGs5/HX2O0GvXw3heSos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NNEch1Dg; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6c2d04b0833so498858a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 07:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1717510642; x=1718115442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBlnaVpwqtF8k8iFTOmr2O+C5Qz7ghBI0GFEvdHUNgg=;
        b=NNEch1DgJqSWZXk/3e1H8Jed8qzvQ9jwMPIZ2kDqC5EMZumTfraSZ1gTP7PqwLKm/G
         UkVy0fS5R6KFJb2iz5bkfEgu/xahcZqRp3UnqPsBEELbsULyoQVyFzNyD71TTIO7WKK1
         liRv9hQGfWVF/+TdMsGvhLw+jPozreJw8KsEVHooKYI6yX65O2aYKfNnGQCZsud9Zfxg
         Y5UVOWN3b9KZn+PRh9mLU7G2S+/FCWIifeVn3mT/jQewvMcEyITe7bR6zwBW7CmLZAng
         TKiX1EP+Hk75+fIvEj1SiYxI+mVFmKjfYUvFYtRcRMSW1eWhZbMGmORbTn3Q3KBMaleB
         29NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717510642; x=1718115442;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBlnaVpwqtF8k8iFTOmr2O+C5Qz7ghBI0GFEvdHUNgg=;
        b=INboWN9LG4AciGIcHKVhOBWY4cXzFX4im1cjcs2XgjDlt0cgkXznyZ3OMHVZq9MxEm
         OdEanhw2RCzMQ50S28zpL5JyeRfJEE9zI70Anrh9c/Ytudxfa7KU2MBz8GgancuSzP//
         PhHOOksgtJ2DSmaIgmM246ZurwWHPsXdrjbNdYE3PR/3g3rSztRPcqRXnl8SGt3L7tS1
         tDwJ8sei15e8upUtVDK3Rsit2INhamw6tLkM/sPLJGJJHvlQyPdm9ZkTWg/SouiCJS89
         Ea7hlDJpOMg3woPzTXdBnjl27KatU7Gf88GetFgRrGTZzYeo0+2wsFeU3A+ROiHBEkIY
         LyNA==
X-Forwarded-Encrypted: i=1; AJvYcCVTdQkGV+cSZfs0NflZAksTKiBxCPOH7yfTPgwS+Pk1dnm3Ioj7Xe0sVPvxDeVAPuHZwwKuu0DIboTMUvipolenUbPjmDaipsJ7Beh3
X-Gm-Message-State: AOJu0Yy8pOm7DXu6SfsJJ7eOcH/I+ecuQnB6EmWRsBe1HFxUTgAdoKbO
	Qvph6QTOxJd5r58UNomwAsXz//eotvazOrtB0rQ+s7Y+RN/Vzd+pQlT+Gk6jJuQ=
X-Google-Smtp-Source: AGHT+IG1r95h5ImX6XbMyN2ZaYG526149J0Ysh9SCb5aVD8a5Samcy0fwVuJLxocgDCwYNTe/T3aMw==
X-Received: by 2002:a05:6a21:789b:b0:1aa:68c4:3271 with SMTP id adf61e73a8af0-1b2a46a884dmr2688540637.3.1717510641596;
        Tue, 04 Jun 2024 07:17:21 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702541eeadcsm5396462b3a.150.2024.06.04.07.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 07:17:20 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, 
 Keith Busch <kbusch@kernel.org>, Bart Van Assche <bvanassche@acm.org>, 
 John Garry <john.g.garry@oracle.com>, Damien Le Moal <dlemoal@kernel.org>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240603192645.977968-1-nmi@metaspace.dk>
References: <20240603192645.977968-1-nmi@metaspace.dk>
Subject: Re: [PATCH v2] null_blk: fix validation of block size
Message-Id: <171751063982.375344.56104601455563821.b4-ty@kernel.dk>
Date: Tue, 04 Jun 2024 08:17:19 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Mon, 03 Jun 2024 21:26:45 +0200, Andreas Hindborg wrote:
> Block size should be between 512 and PAGE_SIZE and be a power of 2. The current
> check does not validate this, so update the check.
> 
> Without this patch, null_blk would Oops due to a null pointer deref when
> loaded with bs=1536 [1].
> 
> Link: https://lore.kernel.org/all/87wmn8mocd.fsf@metaspace.dk/
> 
> [...]

Applied, thanks!

[1/1] null_blk: fix validation of block size
      commit: 237e061865aa5a24c2cd960c4feb2904c8736a75

Best regards,
-- 
Jens Axboe





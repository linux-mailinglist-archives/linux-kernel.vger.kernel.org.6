Return-Path: <linux-kernel+bounces-387946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40669B5851
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35AF7B2185E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098E9DF51;
	Wed, 30 Oct 2024 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CjJDeSU3"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6175C8EB
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730247027; cv=none; b=uJuShSWIX8hoFEyD17oicq9oXh3RAN16NittO6criIddRzbtFsFby9W94r0MPEYrvAZMAuwH7gmbPzuSrndDOxyRTdhPxtUcUaPwHwWv1rgMiGy2d+ym98O2NchjBD2jX76v1UEP/vPC093H5/v06UkN/SprEuR+NX8abkJN3Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730247027; c=relaxed/simple;
	bh=q0i42hDBYEiA8jFgG2lAGqDUsGATPmNCEi8eFOlIglQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CpcZ3NQxX+/eAI8Bs2ZFINubYgHo8uyhXP2j+qHI5apuSDhsol/1ludowx2Xe8ekyBJ9FTMYDfVinDeVlvnA1bxBhFYlB3YxSUZoVl3IJxl1jnhLUhXS4JyfzihRQ0cxOgb8HfW1M2Jx1rDTvy0nq1FeErq6F7Q6UUlQcATETns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CjJDeSU3; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so4799759a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 17:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730247025; x=1730851825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1UwSQeRTLIt25NZ6/OqCii0PiMM5HRqpVvz0vZvlv8=;
        b=CjJDeSU3t9qEv5mfFGc+i2h35EtLulHnyQtzTfCHwC7LH+8K8L7ZjW0RUS4DKty0bQ
         /LP2ZFt1H6R/6GjpIW90EpEuEL0iqzw4VRjXIxSpORUa0fP8xI8R0Oj5jgJ3KVpzzs43
         l/wGxQ5L0Xaug0FoBGcICeV20cnUo02TtYus9bTtY2AYpc06ZLnLsCL45UZ1NVW000Gw
         askpAwa5L6PoRBe19iAgHHENs40IaSCQA6eURidH5gNqIFTmld+Oe3OSRJ5nbSVwcuv6
         myY1HZyIK335r2iaGp9EdqaFrS5KZgajV0oQEGZfTra1omiNEn7J4h/kFQ8je6ijM3wY
         PUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730247025; x=1730851825;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1UwSQeRTLIt25NZ6/OqCii0PiMM5HRqpVvz0vZvlv8=;
        b=g9sIxOTGptnoC32OU/3gCH+CSFtVK6kTi4mYn1rBZjhKPnsPewVbCA1vqTjRYRv1uk
         uDwTW1zR0ylpQEqHfu6lsXza5u6ibIEmUEGO/OTvAu0/pjISll32fyEX6/xY/mq2Quu6
         mTehGtHWxkFeMo1ZssgVPqVeFnv+attpv83IouFJ7hS1LzfS7/2EkFjvkLu0XkHRMcJM
         RYJ7PtCAxiOYZzrQPRgVQuz4qYj9n11sYWErjllCnrtz7TPP/wvxFvmKcA0smrZnwlOb
         T7wifKTuwXgIOEJqr0O9wNFcnmKBccZmjN7+R8Fkcc8pbH2GeIJGRnYNAxro+vLiW8B/
         Guuw==
X-Forwarded-Encrypted: i=1; AJvYcCVzGBkRCd5XE1ckX1UMW3VAcGytYz6kusXhxxU/DI8ouVHvw32XTFqirqlaKMIN8+sHN5kzYrhuBgtMOYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBPgM7sD7liy1Ribrrrx/etBE1a6y302AAzpsDmT7hkSJhJYXx
	oUhxNOG5xa1zAt65psiekJcFpRaiAOCJpwwNI/wtlZWrmL02/4LncF/DkGBZHqM=
X-Google-Smtp-Source: AGHT+IEbACN93lnbolh8qxQeLolYcCWCwnoV113Mbnno3BD8A21A9K6FH648K1KDnJt8KKCAYtbR2A==
X-Received: by 2002:a05:6a20:1d98:b0:1d4:e68c:2eb9 with SMTP id adf61e73a8af0-1d9a83cfa9amr18019722637.20.1730247024983;
        Tue, 29 Oct 2024 17:10:24 -0700 (PDT)
Received: from localhost ([97.126.177.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0b7basm8194736b3a.109.2024.10.29.17.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 17:10:19 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: tony@atomide.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, aford173@gmail.com, linux-omap@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 aaro.koskinen@iki.fi, Roger Quadros <rogerq@kernel.org>, 
 Andreas Kemnade <andreas@kemnade.info>
Cc: Stable@vger.kernel.org
In-Reply-To: <20241018214727.275162-1-andreas@kemnade.info>
References: <20241018214727.275162-1-andreas@kemnade.info>
Subject: Re: [PATCH] ARM: dts: omap36xx: declare 1GHz OPP as turbo again
Message-Id: <173024701867.1375433.4545777039452817587.b4-ty@baylibre.com>
Date: Tue, 29 Oct 2024 17:10:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cb14d


On Fri, 18 Oct 2024 23:47:27 +0200, Andreas Kemnade wrote:
> Operating stable without reduced chip life at 1Ghz needs several
> technologies working: The technologies involve
> - SmartReflex
> - DVFS
> 
> As this cannot directly specified in the OPP table as dependecies in the
> devicetree yet, use the turbo flag again to mark this OPP as something
> special to have some kind of opt-in.
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: omap36xx: declare 1GHz OPP as turbo again
      commit: 96a64e9730c2c76cfa5c510583a0fbf40d62886b

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>



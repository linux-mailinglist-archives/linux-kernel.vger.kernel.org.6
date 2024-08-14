Return-Path: <linux-kernel+bounces-286595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E213B951CE9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E426B29CE9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6981B32B7;
	Wed, 14 Aug 2024 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CLp7Izp+"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3063B1AD9D4
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645236; cv=none; b=KrXLGvO1oUCL1nDF3Za1eBHWx6KTBUnKEPXrsOStzMqWeBhF10cT0dQwHMsroljUquGPKB0mU25K2BcS7OYYw3VyXj3ZPWPLX+CZE6VZyidMxPtMr/z9TIVQVdoqYqfoXfWcRNp2ItPOEkI/pK6zHiu+CF/DckYDPrqAxrSjwkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645236; c=relaxed/simple;
	bh=kQXtCsbcW1E2mqktxyuGPlJlJ1MWdF+o/ajZNUtbKBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XpINIVVzc+2CTX0LNfS+OzuUJv8emqGE1TU87HmNcnAL2uN4pcFmPSu2mURK774bBN6MYpx51ZV+Zyhnjyes46O1iDdUpckOPpBsF4yWnwuiJpkhEMepZg5x+eWj8qpF5rVMUfGvdjRHuvs/CI9mX4AXlR7U7IAlZd9piNBHYww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CLp7Izp+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-426526d30aaso46103055e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723645233; x=1724250033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPjxl5kTZIIxJMPolljKattpkaQsrwWjxNNU7Z8L9/U=;
        b=CLp7Izp+ukPsaxrOKTHjRodgEP7CyOJ3Lp4vQFGnccC5ZkQGZG/JwyPQfqRHpszoVh
         ap+SKXmBzbMLRF57uOgpr652bD179ZiDwpxFjuiQpN+IozTns5aL27ZkQ0OZehJAFcwJ
         yd1zR3HbRGyuMnvVf+iBBfHaGDW/njPSY0flEbVmfETC1w05N1XTtWv1g/397kdXYKv/
         liTnuW4hG2AT3Vbs/DogQNfZFskdB53HsVy1FtkXNLvO6205CeBBCheh1JjETfALyV6l
         G3ZEzE37Mq1wjFsuFMmbteZsn5P11p/78rb2pJgtHcEPR311aLvBvYb/xG+B8qcwxBld
         HXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723645233; x=1724250033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPjxl5kTZIIxJMPolljKattpkaQsrwWjxNNU7Z8L9/U=;
        b=RWmtFCpY9SNIQbFJ9mWZaT8eMDmNUQCyvz2UtX9qBeWOEZhGxTDiRoaSSCTcc6jsfv
         vRhbgiTc+98pXzchgccIDjUPrKfOl++lyX74YDy38P0/8ZwiMx2QlXjg+1Z2cWTyPT5w
         8nkzmX60f8i4o2ophbwW6VlwzH4k6a7uwXnT3Y2fuq2q+EZ2PE4S1uAwTTCqFWfgsj9a
         JGdN53UryBT+XvViA8XCmfJFMWnNHD3K+3Y+oUzbWYtFNKuhHpDqE90CC91Y7iZNRVG9
         MyTYEOmQOT0wr88vzYh5EDCPp7YQTkrHcPuTFuJU7kG9cyrxvz2byCxWomgZl9SK9KY+
         CJ8w==
X-Forwarded-Encrypted: i=1; AJvYcCXaKQAAKU8AIRimA+Uvxij9ew01gGMpUYUM9iuMBIugSo6nIV+kXYm2A61+zKj3F6SWFtwXVcVG0ru0sMMrX2b7wXN0exetfYNNbOO2
X-Gm-Message-State: AOJu0YzIk4pA6l5oPNk7yW42Q7EA5uvA4CMMqQzdf1STPaf0Us6GRbLu
	XXEF+cNB/Wgzl/jgG2OOlctZndDfyE+Z0GAG25267dJTMrBJxS7H5uBQ2hA7eSs=
X-Google-Smtp-Source: AGHT+IGeTWmsPZWGcLLAVdlY2/7R56m/GeHnCL0IxTTmrXSrUbJKSfhGtU98wAypnLkpho3RDTqrbg==
X-Received: by 2002:a05:6000:b44:b0:368:334d:aad4 with SMTP id ffacd0b85a97d-371777696d6mr2139027f8f.4.1723645233409;
        Wed, 14 Aug 2024 07:20:33 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371832ea116sm282433f8f.65.2024.08.14.07.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 07:20:32 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 2/2] arm64: dts: sprd: sc2731: rename fuel gauge node to be generic
Date: Wed, 14 Aug 2024 16:20:29 +0200
Message-ID: <172364518667.95114.7859805701643557423.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <246c0c7763a432d4bebcb0e99b90dcf4cded333d.1720957783.git.stano.jakubek@gmail.com>
References: <cover.1720957783.git.stano.jakubek@gmail.com> <246c0c7763a432d4bebcb0e99b90dcf4cded333d.1720957783.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 14 Jul 2024 13:57:00 +0200, Stanislav Jakubek wrote:
> According to DT spec, node names should be generic. Rename the
> sprd,sc2731-fgu node to a more generic "fuel-gauge".
> 
> 

This also waits for something... so I grabbed it.

Applied, thanks!

[2/2] arm64: dts: sprd: sc2731: rename fuel gauge node to be generic
      https://git.kernel.org/krzk/linux-dt/c/e06e908dba9fed62c9493ea5cea2e4cbd306d23c

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Return-Path: <linux-kernel+bounces-571428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A174EA6BD05
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723EA188B7AE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D27A1D517E;
	Fri, 21 Mar 2025 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wm8zM/VL"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746251CEACB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567647; cv=none; b=fjQqA/ByIz1n+RdIFq+1Cz4JItq++09Nnhe4DvdpILqhC9D2n9GDD34ih77/xSNA6N9/5ReS+qWwXEHIJpmBPyZBp7e/mcZqcgVn/7qbJLbdOC9CdbNrax44/fFhuNLxuNJ6kIBRTo2Ib0/uwsHezscJpM4ysaWoLPKiBdm1+jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567647; c=relaxed/simple;
	bh=EqIPwfTYPPoQxL5MLxtRVL0jHROodvx6q7fDZTLOKSI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q/qvmly5nc7CWMzdojdiDVdVL9znNlKNocOZc5wzZn92Cy/qoZJK6JCaeSB+aP9Qsts7bv3xHrn8+Y307T/d80mYvLwws2T5H1R3g9oVA692JtufX+hqwIIBpPS5VFd9wEChVN72/isldgtuK4eno+hKUhMr4QRoNPVszJ94OcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wm8zM/VL; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-391342fc1f6so1683024f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742567644; x=1743172444; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QbQNjrgeARyR0EHQsfXA9zl775aTD+T4eCDtqm9UkOw=;
        b=wm8zM/VLbZKgrGbwTVnISOwb7fyc2z4U+B0ComVln+jYQWzA8kdqv9Vu94Jlvyrosu
         TNdctLI39WRX3Rqaeysek4jnfcmwGfRMVqNAx6wd6d1dl5hQyVHD6E2U/wNajGoY3uKR
         rS6/FX8NKfP3v+ca8No3ZIluciyqYL5+G861gdcsRhq758PIbb0pozOfBiAD/ERNT+L+
         +hPtKLEH58I0Jv7T1hg3/32wodZw/QRVT8CWo0VT1OZkIRGYOh2eKpMUHl0Uiyb+0XWl
         PHc9N/xrykB9dIvmet3G6TnwJpPEvwK4e0iwHadbUp5ZPX7NgP0jZy6AWWb+d0d9Po0Z
         SgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567644; x=1743172444;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbQNjrgeARyR0EHQsfXA9zl775aTD+T4eCDtqm9UkOw=;
        b=I/wAy2MA3au2dS2lKmiVlQjvoW3kBQWpmGAuGQeHfUvD4mSaWoEIdwo69QUKH1RSzV
         m7jdaGSAX+XJFTtnakJH52+14h/yBo79kK5Edjn3pn2aZatFe/FNKzVj+GKWSLgbpqyt
         t1l5/V4pGuppUbEC0O1X0s9SqnLIIT001PPL43yJxMTAFggcpOyCdiWZg8oaNU6siXN2
         VMpylzwt+0x1AB4oL4Dbu4W1Jpj8N0VhV/eR/LenxeN/hZwMupEcHpOuyHrO0bfT4L1F
         h+3amUiZmUnQN8FQv/eB4t72pwhBvC8mL5EayV5x6W96qJy9TPcUv8NjFhc/U5X7SxjY
         GR6g==
X-Forwarded-Encrypted: i=1; AJvYcCU1+9ukImmL9m/0JRmMlgKTRaI/vJ8qusb3DkkfbT8GhtyJK7XotvkXt0EbOvM7YPHrTh9OSsdSLRd1dDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIILfVPPOofHahcXJYXf6dxtsqrHAwi7HBk2FVPB0iCgRZZZxm
	bDFvqMi6gi8eY0NF9GSrZis3QSlXG9VAxWCAG7ERX7Magx8dwIubVdLVcvbKQvs=
X-Gm-Gg: ASbGncuVjXHMqmO5kEBGJfTsT/lHqL6saZy05ZYrAqRYAJlyEYswLFjDDS55+u27Ri2
	dWkGmJg/ku8PE+uwv56pyG20NAL0BUGAE3M9MNv1HHc/aMo9c5a6oRdnB2AsqXPTg2oShYX+Ao7
	/zgoEYC5VEGw6lWS9jCO5DW6QLoq8ce35//th2+XAXdpCSzlPi12uzLWSaEq5UnBjFcbId4veGH
	KrJTUExyAHKa1fWA6mMG/Ufxx6QaLqEMgURnZVYmsat6CSu1rmFK9khNonheuQ/J42+S7tBXs4H
	wIm94qMgSyTSSuPLPjacBdgwEF/8Sw5gRUeHYQYnp+IIdc4n0w==
X-Google-Smtp-Source: AGHT+IHDSdCcZoreBSspjtZNd/pom48SGiQP4YUprqdbqk51uAXoTMnzRnHPLgGT/CuHVCtYcgRaLg==
X-Received: by 2002:a5d:6c6b:0:b0:390:e535:8758 with SMTP id ffacd0b85a97d-3997f8f78b5mr3634459f8f.9.1742567643588;
        Fri, 21 Mar 2025 07:34:03 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3997f9a3993sm2542245f8f.27.2025.03.21.07.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:34:03 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:34:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 0/2] power: supply: max77705: Fix two static checker issues
Message-ID: <94f55158-1776-4f2f-9296-e307e83d569a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix some error handling and an error code bug.

Dan Carpenter (2):
  power: supply: max77705: Fix workqueue error handling in probe
  power: supply: max77705: Fix error code in max77705_get_health()

 drivers/power/supply/max77705_charger.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

-- 
2.47.2



Return-Path: <linux-kernel+bounces-226748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E04A191430B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9FB1F23DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 06:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF0938FA3;
	Mon, 24 Jun 2024 06:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lUp0ZZwz"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9B279DE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 06:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719212307; cv=none; b=eBVJ+yLK/VHGAu8FCXzt1m0KrLtzpEpK+u1y5mbRK75PGLB23al8jhQ/mg5UsxwV6Z9f8YU57J9dWB6CH7tAMCXNYHyu0cYzGTMA7MtiRSX6phrQofl0b2NB1isUWN+yXk3RY9Gv8wpKvxdqA5NRDAcJVhCZdlQX6jNKaxo+rOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719212307; c=relaxed/simple;
	bh=dd51Bi7B4iho9WSUK2ybNhdPYH2AijwKAorDmLuXRzY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SNP5rE1y5CjuTlqoeW3rQm4FnAwreqOAn4NQx44pXW/u/f68xTQ2LvNFxmmzMya5JM2GTdYFnVr3J/yEfujCvgY+1wBlpowYGGweQY1pziSWGddT49pMoZjVy2OW13KBotmEdA4LK7sP7K03l3ZUUQH4Laqn4WGvQsTA2yvuvwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lUp0ZZwz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4217136a74dso32064375e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 23:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719212302; x=1719817102; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dd51Bi7B4iho9WSUK2ybNhdPYH2AijwKAorDmLuXRzY=;
        b=lUp0ZZwzkz+YrROsaIKc6adWzkvF/gue2MiXLnyTjnL6eu6uWBMEFt0WnCpZdGaPJN
         Z0U5YxFP1ejIpGW11+l97uQNf7q2a53cizR0HcG/jbU0EZPuTVqICbSlzf1zvD5f6K7E
         X2z2o7pXVDtATrd5GSp5HeTSMpqiH1lNjLQ/DEFEFynZ2r8bU6HhuI8Z3WiiZZ8dWefi
         7RoBTufpoHF4ATsoWHK2eCaaa1KwFZpeduoN5TTVe4NREuwrEn9COZcBGs/Qo2pfnI4e
         Ku7/60LS82161psokp93cBK1ABNAipW5oILVrD/elhZI/TMbZoZ3GVktfR2MxcGhuHjS
         fggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719212302; x=1719817102;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dd51Bi7B4iho9WSUK2ybNhdPYH2AijwKAorDmLuXRzY=;
        b=hi7W221ED4z+sBsk2UaFgWWSVqIL+akM/rPdW0maoGO8zBk/1A8vtRSc+fFgi6XkOG
         CkqfCJxxcG2ZiZ9j0nEFfm/qHUsVPECre02CCIllUhUxrGoGnvOTfs27D85e105yUATK
         t/LEHLT6p7gPyumkfyoGy6ABm+2pJz0zGD5PjM4dmSU7+lCitwW3IPcLY8CFsi6vf7eP
         PZAbxjyze8to+455r/PbSeiskF1B9Bfq9+c44NbiQCI5BQESvBjl17m0p765eD8BmIeD
         nkwvebYw91M9pThUtGbHBGKoLwjfx6uNeNDEjay35HO7SxaHxDd+MLnbeJADpP30Aisb
         B+0w==
X-Forwarded-Encrypted: i=1; AJvYcCWCtsataz72ZL+ik6MMNaTWNI65aijF8yHS/Q9C2q5mIzRoZ02HHdflJDCF3nxSxbCE9R+GCda5kPr8yOokl0S+QRdKDJMjDYkbVk3V
X-Gm-Message-State: AOJu0YzBmf8ve0lzI4SHPd9V6MuGOkEnvGh+q1KUzcyhfrLtL9Bhz2fe
	t4mUGavb+sZCQze7Zb3rCYpmaD3hYsCwVMFlJgAgPJhxXOTs+Jc55BYf0T8/cdw=
X-Google-Smtp-Source: AGHT+IHzL3aUhtHKe/3Bjjj3+ND74b1Fr865qc1MmeRI2nhE716S8dlrF9T1bXooOlRfy9IW4F9mRg==
X-Received: by 2002:a05:6000:459a:b0:363:7bbf:efcc with SMTP id ffacd0b85a97d-366e96bef86mr2104770f8f.62.1719212301575;
        Sun, 23 Jun 2024 23:58:21 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:67a:d41c:43dd:a67f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0be818sm161647475e9.15.2024.06.23.23.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 23:58:21 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,  Kevin Hilman
 <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,
  linux-arm-kernel@lists.infradead.org,  linux-amlogic@lists.infradead.org,
  linux-kernel@vger.kernel.org,  kernel@pengutronix.de
Subject: Re: [PATCH] reset: meson-audio-arb: Use devm_clk_get_enabled()
In-Reply-To: <20240621-reset-devm-clk-get-enabled-v1-1-8408c7962b6c@pengutronix.de>
	(Philipp Zabel's message of "Fri, 21 Jun 2024 17:28:12 +0200")
References: <20240621-reset-devm-clk-get-enabled-v1-1-8408c7962b6c@pengutronix.de>
Date: Mon, 24 Jun 2024 08:58:20 +0200
Message-ID: <1jfrt2esj7.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri 21 Jun 2024 at 17:28, Philipp Zabel <p.zabel@pengutronix.de> wrote:

> Use devm_clk_get_enabled() to reduce a bit of boilerplate and to
> disable the clock in case devm_reset_controller_register() fails.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>


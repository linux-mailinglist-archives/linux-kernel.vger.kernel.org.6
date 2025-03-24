Return-Path: <linux-kernel+bounces-573457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC82A6D78E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4B716FD35
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D60A25D915;
	Mon, 24 Mar 2025 09:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="GWSg/mgt"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B1A25D554
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 09:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742808932; cv=none; b=HbjSr9rDatlNwQsEf26Hrf4Eln28D5UWVpMMpoyut4aqxGmLKSDHsezjB0lg1e1XCu2i229Z91hPrFgZGoLbTAJ8crQDqELCHN56bDFE2yPAOh4GgBDE3CJDkEZa7U2oD7yNMGos1oBkL6v/sR+5oDELpuGCR96r2FGEM034jDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742808932; c=relaxed/simple;
	bh=Pzo/0QjO/wS2p4Jzna7n2l/DCoFbfuVyz72x6e4Bd0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZNQ5C/zLHFntwq4ns7TORdT3/vItrWhuiBCHNJE1Pn4vWau4fXDo2fmcjY3UUGsf8wJ6xx8wLQbqqQQJxpo7y7Fa2RCyNFUdxYdURmFSAoeLyJ0mO35KoYO37JikPWG9YG3dQC7faR0yq1C+EPuEiSc/bGk9WjME4Qw93a2wklQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=GWSg/mgt; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso45371745e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 02:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1742808929; x=1743413729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeGPvHQatci2pQ5iwxhsk9xdokzqqYtZQCcW5zfA4/M=;
        b=GWSg/mgt+XApE3S1o5uwp3zcLfuXvAhKb+9RKka5kSnag65+HG4h/SOfLl7JK7onZ2
         /4aweagSeFnz/5EwxDaQ5qfcNML5ofIEEW9aPLu28s/WtQlwO4COczzl5Z04rnGb2l5g
         A9EwapKSYys1u/LtyHOtnXn89cAJ7z8R16cqMHtY0NhdqHBJ9cObZforWo8KX8PgvFfa
         /nSp+eQ6cmlrobfIC2ZHg8OTHC4Ts7Te2lheF4sLo/a/EE8RIZwLL0oZq8BFR1MuHPOY
         v77xiLCYdqsI9Wprs/ln8yBGx60n9TOVwuRX5fXTmYnATfgtRUZ4d9O0hMzbaPrFoqAR
         n2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742808929; x=1743413729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeGPvHQatci2pQ5iwxhsk9xdokzqqYtZQCcW5zfA4/M=;
        b=Wa536KUjSsBTU1EL3bW/rKia8h1N1y5rZLnnUtgH3iJOTlqyCJZdwf4GIA/9iIVviI
         IUJd5KKoL4Gh3bBD5DHuHWf5fxo0WsBYqoboDO2FmnG/uXoWGN3J05gUt0awkj9891mh
         dw9ECMY2JskRbaPv8/1F+j9SpfH/h1JUR8NNS4mh4Wm6X6il517tE6x+phASyDOqwu4Z
         re0q3qhxbuEoOQCrVNzbgaj3Lu4gDhi6+VsD5cAecrfCRw2BCasAgjGs4yP7PXRVgFYL
         Nm1MQyCeGGgQq/GsRsVcxENYpPZ/YIwOtAX6bHIEapdGErHJ049YO3pyp0Mq3SsQ0cwq
         NNGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIOif9kjOFU62qZ7AN8JErPQzFZvQQPO/xxdVJ9kt7zogbO8R5O2Is5yxWiEFRKSiWs0UF0VaYPyvWYuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtIXg34TOxf6RXj3nqhYrDjtBQn1VYUnzTqNZKp4gDGiu1L95V
	LkxbrhaGUnaI+P9nSviQAvWsImROXJ9ck8KqjAMMyEP1XMazuYIcQC2Tutbh0Bw=
X-Gm-Gg: ASbGncv+4Yuaa0eaDyroWCemDxcu3pupyTfNTq3IJfffEenBxv91hdEmyCsq4yUozvN
	nKymzY5BRdTX5NWytTsp+dF0EOZTtlw+JKDp0TpZtAcDAvkdkA5ai6TTLQFZV3tuOGqFGVoWYZo
	vl9TPj4L3IjJ3NHUHwJM3bcMGnXAacy5D2qQ5MzJE4ezXisSB4D3VZ2/2QzgqglU3t80L+XUCdH
	gIRV2BEzvum6ptmxS2UREWZoAHyvp1+lyFUNPEt1THPNhl+jBcSycwR0C5RZcIZzPeWBrBMzgi9
	NM1xGOgDQoDBXkkBcpkemKMklH1WCieZyxnGGPXTLTg=
X-Google-Smtp-Source: AGHT+IGxMwObCLUmE3BITJQ/LvSi/zYtKZtiJcPrToTVMjRfK0eeveJ4XyM4DI6LoLNEC29cFOBmfg==
X-Received: by 2002:a05:600c:3491:b0:43c:f87c:24d3 with SMTP id 5b1f17b1804b1-43d50a1d86amr118472215e9.20.1742808928735;
        Mon, 24 Mar 2025 02:35:28 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:467d:3e99:af5:c4ec])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f332adsm166466715e9.3.2025.03.24.02.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 02:35:28 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] gpio: update the TODO list
Date: Mon, 24 Mar 2025 10:35:26 +0100
Message-ID: <174280891946.9494.1789917451855355393.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321-gpio-todo-updates-v1-0-7b38f07110ee@linaro.org>
References: <20250321-gpio-todo-updates-v1-0-7b38f07110ee@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 21 Mar 2025 16:49:32 +0100, Bartosz Golaszewski wrote:
> Here are a couple proposed updates to the TODO file for your
> consideration.
> 
> 

Applied, thanks!

[1/6] gpio: TODO: remove the item about the new debugfs interface
      commit: 0c6dcc49487608e460b89ff7a6a50c084b01f3d8
[2/6] gpio: TODO: remove task duplication
      commit: 01cbfc45b48beafdab84524df14b0b4a863ea495
[3/6] gpio: TODO: remove the pinctrl integration task
      commit: c36420dc4f9e11d4e494a6182586008d7969c841
[4/6] gpio: TODO: add delimiters between tasks for better readability
      commit: 5ceb3536f2f9ec4fcbe5f83cde6766c6cb673dce
[5/6] gpio: TODO: add an item to track the conversion to the new value setters
      commit: 9ff2443b37d8db5b4712afb1cf44a1e75803407a
[6/6] gpio: TODO: add an item to track reworking the sysfs interface
      commit: af54a2fbdf45b1fd32cdcab916f422e6d097f430

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


Return-Path: <linux-kernel+bounces-311053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6530E968459
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1765A28509A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2721428E4;
	Mon,  2 Sep 2024 10:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QK8PQRz0"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFF613D8B1
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272097; cv=none; b=D98rmxA+mQiMlE0DH3PkWpVrIkyVGhRuR3DHQlcO8WQlLnMLpZC4wcI/lKvscYBUlfaFdAQoWim8wxYC/D9ewutJSoYGobwhEw6PwfovtQFFexeSrepbuwzvkpOTSh1+D5bTa0Nkm72sLjtV+hNE42AQ3cFc/BWSGYuVgKHhDXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272097; c=relaxed/simple;
	bh=NLoiJ17dLlGlaoBkSnITLquaNYkxbQYr7r+JDtYpHcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onCPEDPmg58pIaD0p/uQjCUIXjKaqIlltHHgrliR9LLBJyLNhoBiie15FM8kIOPJxcXVwwlwLGfHU/3O+5xC/BfqEuCcKCB8zXBzdfvSinMuKWLPDdo9VhKEuNkBNDqD5obdX3t3jVGQVdda5YBUDkFKbXKFhmOVpm0yQJJP+QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QK8PQRz0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42bbd16fcf2so25228595e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725272095; x=1725876895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dUUubCQTxhYKT/YP6yuTYQ1xa0NNwhTxFAA5JxSAeI=;
        b=QK8PQRz0Z+jiaFusHDUIeOGUwcS7sl9r3t2A96QDImi8X+UPpvNloc7E96EeDgdG6/
         qmY7POBqU4f/UBSV3vOYV41MPCH9xUs/AzVh3S+AMUeS0WTAgWuJaxXHhhBuCFxymRt8
         MpYrUZhxoDjgwENvQezEOYhPGpHl5YL6yBGXZGnPq/ovm/vRvOmt37YhqxguVqo0NDT2
         cZpP6PdFmQI9/M1NsbolqHFD8GK4phOGFxyZSy6gaMQHi4QGqpR9KfAOY3+/OWczANLB
         swAI9fVq6q+aYGwnw4zDVsdH7sHipdxRJ0h5MFhlojKPUyPJS/mJNYlpaC9iNxC8+n0S
         Ik2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725272095; x=1725876895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dUUubCQTxhYKT/YP6yuTYQ1xa0NNwhTxFAA5JxSAeI=;
        b=FTTsusvB7GpNW8jI3qP55N3FWzuMNzmFa4ryrpzFahSOnjaloeMH+w2gVrsHraJcvz
         8oBZVmEzChgqRmo1ZQFr1LjxMIS3BMnHPdP5tXifKX7Hmjf2NVjFRjG1tee3zefuq5wG
         aaNeIhJmKWsigAOE135Xr/1vxOn+eNaIw/JEorEcbqeYdunePjO+nl4QYhOZYOZDFj0E
         oq5NmOlNNT3/RAiJjZlbzp54GfdNilN6hCYAMq3vX06biSFxWZM4J3PNeTEbvxeMQyfZ
         M7ZdL8oHPOdoAthZz0u7yGYVm7E8iInzFF0W5UatrZgbM53EeVBxT/eduJ5kTlsGmEZW
         7p1g==
X-Forwarded-Encrypted: i=1; AJvYcCWfJKfZbSfbXgmFvgvJllbPaVxbMSZRt4U5MuucQeJOJsSHl4apx7k3IyGpXHcPC0nwpn9ICywxG8BrAFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YysR50+jtF6jdxyMoFivkkz5BXp2KO/E3xqqyOPjyuvERVr2RNb
	lyqklvmdoMnzcNRkotmHWuIQa6ZatDCLxSw+KrBMx6CBrjAcJkfLQeUmpB1oDAkyIXYC7bAwp6x
	h
X-Google-Smtp-Source: AGHT+IH14t9CWtYUnJIADTFnjvzoF+2mTuS7NOIZ/26DZ6lrSVMqJOfeXCGzCvH4ffN+oKeuo7seBg==
X-Received: by 2002:a05:600c:1c83:b0:426:6ed5:d682 with SMTP id 5b1f17b1804b1-42bb01b4419mr95541665e9.12.1725272094057;
        Mon, 02 Sep 2024 03:14:54 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b496:9e67:73c9:9f5a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba6396516sm169723265e9.4.2024.09.02.03.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:14:53 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v1 1/1] gpio: uniphier: Replace of_node_to_fwnode() with more suitable API
Date: Mon,  2 Sep 2024 12:14:52 +0200
Message-ID: <172527207758.23595.16896147913906558315.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822225629.707365-1-andy.shevchenko@gmail.com>
References: <20240822225629.707365-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 23 Aug 2024 01:56:29 +0300, Andy Shevchenko wrote:
> of_node_to_fwnode() is a IRQ domain specific implementation of
> of_fwnode_handle(). Replace the former with more suitable API.
> 
> 

Applied, thanks!

[1/1] gpio: uniphier: Replace of_node_to_fwnode() with more suitable API
      commit: 0a0d849c70de3949646b242209bcf0e3c488da7d

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


Return-Path: <linux-kernel+bounces-198790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 206A98D7D6E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B648A1F234D9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEB264CCC;
	Mon,  3 Jun 2024 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="PPY/cont"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B225BACF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717403706; cv=none; b=J5/Pn2wIWKUa91xk5TL5OB15jcYTpF3PW7oUgy3g7fN3MiytQiHD/ReV6DcXEhwQowaemqcGB3IZuCMYmdGjA+9LR9Dge3CbYWPVh+/Kx84KP/sY44DvrYJsw0+6pz3bSirWW3V3CIO1Ji/DfVX5fjHoB3pJ0Z/DZWyfIgtGaX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717403706; c=relaxed/simple;
	bh=cg5B7l/3+igtl/kKO+JJ0L5MVEaZiX/bA4lqy7Ez/Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gMf/np5dv2Qbzf25YTtRWAhW6ylczVTvHnCuObg0m1KVynmhZdVVdTiNwL0K9//v1UzfN1gZ99yLM1zAbKH93hy2625H+izdj1tbNe3ZOjMA4kaYdNhr/YcoN5wRHxehzDWcuw3u9d3zOiZcjxKs31mdbN1f2WfH3xFjV9r1EdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=PPY/cont; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42136faf3aeso8294495e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 01:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717403703; x=1718008503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWLTR6JC6K40ewGX4zHo61KjhEfsmZ8Gp4GTKS7lOrY=;
        b=PPY/contI8rVBDB4nLZOhB3m8ohaOArnLZz4pOl5PZLUZ9JmeQ1ZJi/Q8oqk+UY1S+
         wzURsXRSm3NopWnsLdCvbvuGl0bfviDIvj8vBrovdU56mFPzEmbbCARjb7fOHm+SnAhe
         X+0XhHjRRMNG1KyEW3F2OFodBB8QYCcUXRKIBJXc2AYD1yhAN88X5fC00Ciw8pTaiqb0
         ltzTXbDCk7f+xf3g5m/xw3raxsCPMJ3FIJQvOHwb2RuNanbXDcWmPEbNymGagv9NTG9L
         Nhv75BSaGeMGmg7mRKCBs89yk//1wAsiYw/5FJtGVlHKNGoro6RIv7y9PFoonb1oM7iZ
         3SOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717403703; x=1718008503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWLTR6JC6K40ewGX4zHo61KjhEfsmZ8Gp4GTKS7lOrY=;
        b=qjLOoHDaVc79lJM/fU/2GPzZlqzfEc3TKW1mf+TCKK0dEN913e07A20wh/jEMyCEKt
         +iB3nlJzVwok/68tpm7snbbrJhxAUORcJ9gz0QvvuKc5cgZSwqP/1lIWByfHhiFSSqEX
         gJn1E9KIz36YlVWEjtkewZdWh1x2hwyciMKE4UEie/UGzQa7vTI7B4Tz88/lHsMqu19q
         GArTGnngy9jp3bkHqsz02aLqeChjVDFexidg22jnQ49YfFkO/egUgOtI0W0m5ya17cH1
         lTKjCxwssYOm/rtZcUlqEonaqQCgeGhkhSputFuYoaLxf6dd+yB7jgMfwHWu+KuoT3QN
         StPw==
X-Forwarded-Encrypted: i=1; AJvYcCVYqrA1a2FERSf1cAW2bT7oonS3JjxsglMWMmOpNRHh6g7lMJq+qnVamUbmCbFXnaDj3UeWlj9JcsCdfqy/wv3jTkpcd+1ac4iBBELm
X-Gm-Message-State: AOJu0Yym4rmfJz8jXw1jbnmRrT5Qj9IjR5Pw/Deq/golB0OA6FW+MqTW
	7pDK1nzQurRNvHUN2zJCvEKV1DbCoemHYhTO/GGP4ZBhSk+JNM6S3KZWLjsMjC4=
X-Google-Smtp-Source: AGHT+IFN4XPjK4usqCfza9VDTkzx60Ym4DVYamJhOx5J6qxkiUTASW38jzri03Yq5NtKjPRPofRpvw==
X-Received: by 2002:a05:600c:1907:b0:421:20d:e3a4 with SMTP id 5b1f17b1804b1-4212e061c60mr81864775e9.17.1717403703250;
        Mon, 03 Jun 2024 01:35:03 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:5b1:48e9:27a3:7085])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04ca981sm8051707f8f.33.2024.06.03.01.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 01:35:02 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 0/2] dt-bindings: gpio: aspeed,sgpio: Miscellaneous cleanups
Date: Mon,  3 Jun 2024 10:35:01 +0200
Message-ID: <171740369951.11706.10620844731089866743.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240530-dt-warnings-gpio-sgpio-interrupt-cells-v2-0-912cd16e641f@codeconstruct.com.au>
References: <20240530-dt-warnings-gpio-sgpio-interrupt-cells-v2-0-912cd16e641f@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 30 May 2024 11:09:47 +0930, Andrew Jeffery wrote:
> This short series fixes some SGPIO-related devicetree warnings currently
> emitted by `make dtbs_check` for Aspeed devicetrees.
> 
> Please review!
> 
> Andrew
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: gpio: aspeed,sgpio: Specify gpio-line-names
      commit: a31517b11bd188527b2f8a4b8fd3e91a10f44d04
[2/2] dt-bindings: gpio: aspeed,sgpio: Specify #interrupt-cells
      commit: 3a40985960bcab918da23f8945ab0cd3be12d716

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


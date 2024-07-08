Return-Path: <linux-kernel+bounces-244137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C54929F9E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A51DB1C2134D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A7474E09;
	Mon,  8 Jul 2024 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IlOzgrDe"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0EB6BFBA
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720432459; cv=none; b=qyRGH5gyjyiigDDKFf5ZoaTlUZxZ48fvOeUYjvZTmRnZMlf6Tl70JaEm2K8Enwreqyd8ZxNs6acOO4P2JwW7cQUfg4I+3WRlfFrPBeuNvSS89S6bNw3Um1cwvxl/nNke8+2nZKJvYlSsuT49RZCGu0b+3lPnlU3EoLgH4sPX+Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720432459; c=relaxed/simple;
	bh=TEuaV52Fw3AReX5B2xdSJt9o36RSvuVuXFqTGWhfVpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aTUmhQAPsQgfjlV1jh7nn9mSrVr0iPIQuzt5CmTsTCkoJZHS66+6hUoqPYC8vyc9E6iBZDMi1MC//MsU0G8JqJsU18HXQ+oRNZqPnmLWsqs2RtDiQM3QkC+4mwi5voZpJaG5KW6H8s1amoXlN0Gcp9yVnnTbG0jUPpNWU01QtDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IlOzgrDe; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4256742f67fso26161625e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 02:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720432456; x=1721037256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjLXoVowh+lTUTYcsGJih/+hXZkO7j1LpjGmonKAPpM=;
        b=IlOzgrDe6lVxhrZPpytSjdk3s+/Jc3ZGIGBR4DVhOtAzSaDfVJxSX9iqYcKQGUOFSR
         gNZHnnMi1Quo36S91TUYybd8EdmGgJXnHDKZDl0MEd6vzkzS2or6RYQ0k21yo/1UWGlG
         NsAo1d32mmiEG0JwUxiWIiyiYYCy/98rH8BDUe0OOsD2r6tuzHCUznPzEONrD9M9tel5
         YPs1mCuYeFGVgB3CBTOvdsPb2mV3aqU5boFzdKVDhyN3b/GYCRq3FRE9KlMFMzPvWVbt
         LTXt7avF4Q/OkfF7OBmoPZ4AMHtXISMQzICFUvZPcaLnQTk4gCsPKmpyRy0W8z9ArkiT
         Eidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720432456; x=1721037256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjLXoVowh+lTUTYcsGJih/+hXZkO7j1LpjGmonKAPpM=;
        b=Tkr/nVhT11yfyZ27rLWBYwQ28OpYMU0tNeeBnzQHJYSdPLEfrvt93rCL/acbva3+tK
         +sFedTzH2FDL50iX7ZpDhVjdbHvEaTfRUWNZLJWhJRBkRLBF0i0ucxyEEFa0WGR6X65k
         WQlalG9ak9/LSfzvboYsVEp5nz5vUcDd8xOyNTZXaiJgRdzuAcLazld+nw61YcNJsjHN
         vgWUOCJ2NWin06yBqB0I6gx+NI7oY7y5ItEVzLYPxdsp1qiGqynUK/Z/S6gX6ha0tq15
         3ubguZkxoQwK9GzB7yrJ1IdnmMs90C8SZ/oRLIdkTsleI3uZi2oTYVB4eS9gUzKVwdHH
         a4wQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/849W/uo53X23to2cYPM1rr71+mjO4je4tqkZPYwZ8odspzjJqfEgr1JBvrXrh3OgpmelPHXdNQN8dUgfcWwevwzgT4z2ch2IU/Dd
X-Gm-Message-State: AOJu0YyP1VCOcFrvfQAneVfvQd5NElzj5gvZma52waXh+5tEL7xCTECL
	HFvgonvQ90YfQ8Cwlzc3FGPi8CpJQi9I+UViAQHIMMJgx9wveH0P9wOEKhvYRrU=
X-Google-Smtp-Source: AGHT+IHALUzocYPlrZWoFdTJs5DD33ZIq+V2Qy2yma1bExbYlrX6OlgqOmXWrumccKIJCVL4il+mUg==
X-Received: by 2002:a05:600c:190b:b0:426:5e91:391e with SMTP id 5b1f17b1804b1-4265e913977mr38910635e9.26.1720432456186;
        Mon, 08 Jul 2024 02:54:16 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:a2a3:9ebc:2cb5:a86a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a5a31a1asm8628598f8f.7.2024.07.08.02.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 02:54:15 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	caleb.connolly@linaro.org,
	bhelgaas@google.com,
	amit.pundir@linaro.org,
	neil.armstrong@linaro.org,
	Lukas Wunner <lukas@wunner.de>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: bus: only call of_platform_populate() if CONFIG_OF is enabled
Date: Mon,  8 Jul 2024 11:54:14 +0200
Message-ID: <172043242741.96960.2619738362693641818.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240707183829.41519-1-spasswolf@web.de>
References: <20240707183829.41519-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Sun, 07 Jul 2024 20:38:28 +0200, Bert Karwatzki wrote:
> If of_platform_populate() is called when CONFIG_OF is not defined this
> leads to spurious error messages of the following type:
>  pci 0000:00:01.1: failed to populate child OF nodes (-19)
>  pci 0000:00:02.1: failed to populate child OF nodes (-19)
> 
> Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF nodes of the port node")
> 
> [...]

Applied, thanks!

[1/1] pci: bus: only call of_platform_populate() if CONFIG_OF is enabled
      (no commit info)

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


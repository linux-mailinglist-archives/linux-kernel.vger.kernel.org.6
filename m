Return-Path: <linux-kernel+bounces-443242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C407C9EE91F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242031631D1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8302E21770A;
	Thu, 12 Dec 2024 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hoTk6hFS"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C453E222D4B
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 14:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014310; cv=none; b=BE7XO7aorfkmXgOd+JAGYasvUq5CfV7Xan+NIFunIOEwHwDl7bAmcuJw0R6eupbHatPa7HFlBjwvc1pmyVF26ENhmRZMwFAs+jujHJ2sbiVLWdS0+TkXaVE9HTereUyQAZpUZu/rZaQQx07eE6FvOyDwFD7N2Q9BwGu5u420DBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014310; c=relaxed/simple;
	bh=85oMj2fZoa9tv2lnOop9OuEYiv4tSNwyvlVAgPEcKBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DkpkhTuhleJhatLLD2hwzMsEc5ZP0zToR+CIQLkoDwerAS8zMqhrZMp3km+rYqZgWHvHMOwmHRZCyKi/lpHRwjBJaYSr6QNIHkD3HfdqFG/mvz1WBz8P7UVNV0kU3I8sKMu3xnRwG15rwAOwuCRqF+Cb6Jl4Ualr7lIUXFpslUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hoTk6hFS; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3862d6d5765so446419f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 06:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1734014307; x=1734619107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIOlizfCIWzvmSjIRb9eyhPMVHCE5sYO+dZRoNpnJeg=;
        b=hoTk6hFSQWWygcYq/RLrtyBUJM7DzMrnbCbIwefYd7Ro01Nlfe4anlx6abVHfaDBRU
         WHFxrhcfUQjZx8pp0uckNATFAB94OOgwVY+Cs9SpM2iLY2TvdUqgfWwXSmvcKcqfyYiw
         Sd4KF/jNE9Bws1L3oactSDHu0uN+67XZfPOa86SHhdq1BePl+pVesHAQshN28vfvZqJQ
         /T3TaW6V+LfXXF5ZutUq2rEWo/CAK7RPAPYo0YKRSAAVL5X82GjiUIs+3TwZmnuwWCHw
         R0Ts+cmBtlAQV2zKw5N3/NDfEvVAB8OJcdYDKm/Cr/3/paspHKFdqLbRqS9PBAlnfmW4
         SXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734014307; x=1734619107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIOlizfCIWzvmSjIRb9eyhPMVHCE5sYO+dZRoNpnJeg=;
        b=Pl8XtnDgdjaqkP3vqEW8EJaWBobLwPueCSOtLad/aavmz1I3LM03BTfJYcusdGXNXO
         0KHfI8s4w75ZMI07ALIfLwMCn3L25UUqKmx0jrb78FKfMdr2LojsJ8nDLURbRoCU7I/7
         uDfZhTc7hgDDfGGwl3ZjYeBaSiQhUJCSiNaHKIg5GeVkTFa0bbWHCCcpKbJeKkUrNQxY
         7WKx3+Y35sH5tM+F2iIs5zNDWSAn/eBlsQg7Ie2nFKieg3O3xjVu+tmZhmPhXM7Jh0nZ
         PvRU5r4IC97F7wfnZfv39qLctZZV20Y9kAm2ZXnAhdGYXDMh9YCoysAtJerI4OD2AR4B
         97PA==
X-Forwarded-Encrypted: i=1; AJvYcCWs2G7pAiTaijO/FT9XcA9uW5mcauBPBFa6hCLTMHaZVvz7+svpzVGbJiBtkrjMqHJlTXl/GQ7Rxe16faI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqfRp1INvlsK4nvqbVfpjgIS+8StgZ6VpqFEOUCnWy9Bvreay8
	xp6RMcuESNXJt1jUo/0npNiN82TqQqVhxRKkbImQ03BMp0q0XG17wdgxgbtRAYc=
X-Gm-Gg: ASbGncuM5/M7mBXDOZPQekjAQPvuixdsKE8DUQ3wTgx7tugkO6To5m1dS/L771l87ar
	3LP1+qvHoS3tswIPvq5KTa5XHBr01LVo+5pFPGG5Egtqi/xMudlgSabmU1CVI+3GLkEsm4MgN1V
	1UDlOjdn82m23GXX91IKlwDqzuU9x9XzZIfj93PXMYkFm8Vibw/UXD1I7YtdiOuoNlm10TwiuM+
	Kf+ONyWHr4OTKmYUqYytXhV8I/rv/fH//0ONr2k61mR+lbhYtYbH5d7
X-Google-Smtp-Source: AGHT+IFds6b+rb/IVEt/FaqatdXbo9IXwM0+rdLbsbHi9Vl/oF4STGa7tMC6n4HsFYumZKjKywdEZQ==
X-Received: by 2002:a05:6000:156d:b0:385:df73:2f3a with SMTP id ffacd0b85a97d-3864ce5429cmr5944931f8f.14.1734014306975;
        Thu, 12 Dec 2024 06:38:26 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:11e8:e55a:1c06:3078])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559edc3sm18681545e9.22.2024.12.12.06.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 06:38:26 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andrew Davis <afd@ti.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Kevin Hilman <khilman@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: Re: [PATCH v2 1/2] gpio: omap: allow building the module with COMPILE_TEST=y
Date: Thu, 12 Dec 2024 15:38:25 +0100
Message-ID: <173401430334.14078.3117546385632251439.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205120610.40644-1-brgl@bgdev.pl>
References: <20241205120610.40644-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 05 Dec 2024 13:06:09 +0100, Bartosz Golaszewski wrote:
> For better build coverage, allow building the gpio-omap driver with
> COMPILE_TEST Kconfig option enabled.
> 
> While at it: simplify the dependencies and drop the dependency on ARM as
> it's already implied by ARCH_OMAP.
> 
> 
> [...]

Applied, thanks!

[1/2] gpio: omap: allow building the module with COMPILE_TEST=y
      commit: 934bacb6441afdb77093a46b3138f81cbcde7d81
[2/2] gpio: omap: save two lines by using devm_clk_get_prepared()
      commit: b7bbaff8c1bccf48958e52f6f03593fc47906b5d

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


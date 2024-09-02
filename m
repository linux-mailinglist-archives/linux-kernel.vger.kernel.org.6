Return-Path: <linux-kernel+bounces-311064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC64968474
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3671C22109
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE771428E8;
	Mon,  2 Sep 2024 10:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="c2V3q49l"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC59113D502
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272325; cv=none; b=cmzDg8YuTG1Ul/fJZcEV3mR9vnurJdk6M6p4D98pc/2X0nI4XHzMOJHzqIqV2O7IYvq0SkO3UOYW3Hd1zACBEqJJFv2jxD3n3VH8mW7Ob5wY5ql6n3PU1cpInA6c/+KTalIzs47lgHl8auOMnCLOsRrTNt/a4mGnhAGerJOfeDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272325; c=relaxed/simple;
	bh=RflnJvsqvbyPsnJVt7vlZhs7pHjpfCUSnlro+8rEZWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZWeEHPwA/IMNelX5EQKWmHCDxcZCHYE8zQ+BeJhnHFdoBJ1C9Tb+hNZs9tWwyKJeUSGZsv51yvgXGyj4rLxlditEgutwVtJxrrraKgkGtWMzKjINazqRiDcGjDFysOVOUooi+LTJbsx+KmZbGbwm/L1mmzym3qlyel1rPod/6yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=c2V3q49l; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374c3400367so1000181f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725272322; x=1725877122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEqkEyJsK6t63CfY2IwDePeUQ2dHIOkDz+F80SIVFbs=;
        b=c2V3q49lof20t9knFxzHEWMMAB85kTlUjz0cLGoKiszigJ9X+cLL2xpI//HEsjbbx8
         UW3iX03CO+5aGCXt9s9/AoRZnENOrGsEt5yhaaYCHhsPJOP6VkKgYYpBfmex1uSro1+z
         QEdwiNIIyJJtlyNvk/02uFH3GRsOHbIdhh51d3eB+QXPsx/WMykezBO5QgiMrTRGU/xi
         qflyk5VgT3VzfavfiDFweBouGhkoo8MM3nvn5+9a76ltP6miErFetfPPdMTFPnvwlQrN
         L5TzrBGSqqiMv+ccRmuOwMqV/sn2Gs3PjTaDNPuPd7bm5GoAaoKNmCgoYchxeJG+OwCD
         HctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725272322; x=1725877122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEqkEyJsK6t63CfY2IwDePeUQ2dHIOkDz+F80SIVFbs=;
        b=lfsEXft+GnIZzGA4PKoP/4p8IFZHCc6Xeaa7lfcNTPQC+AgSggqJrVWgmhJQEpEUpu
         kkSKspuMmsn7hZH7uWN+jPXW5fSacJUIP3GPyo18IuqFK49TUO6+U+Ud7dItoXs07mTJ
         QV9qclk7qHGwpYOG8i/Fa3tmpenFg5nJ2kdOYpu8vxDNos0iYOEVLzzggsEh3IcHFDUN
         9GJHr+5QjVxSldqN+yQaoXDGsmqNQL7Pfle2MNgdr5yyaYXVrxNKIn3d/9l43FX8hX/s
         gvXbGRuDtT3QTFkkGpnDMf8O1nnBiECrf9D/298B29IMztVBWqFl+mzm5WQR32Vtu0JK
         N1Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVHJ6wSuL9z0e7XrMu0MwWJNYaGetywQXViJE9QlhYhj+aBKfkDtk6gzw73rsJ06xC3txzmjMq8RngBhk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuaW2tb1R2BObFu/B2KoEShbvx8Cgr+kYMNwxaNIEY2CRwquja
	3Kfjz2xD/AArkx9/V3SuUns8AaHrEMwmInSKVa9+Zd5X4XYJRNNSSeNKzcPfntI=
X-Google-Smtp-Source: AGHT+IEE/YhRRLSjjfbUlTGLBKRn7lp2Q6y9B62Yb/3D91vjsT2kxEufWNntb3mo/PomaZk8S60dSA==
X-Received: by 2002:a05:6000:d8e:b0:374:ca1d:85ad with SMTP id ffacd0b85a97d-374ca1d8830mr2230385f8f.56.1725272321552;
        Mon, 02 Sep 2024 03:18:41 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b496:9e67:73c9:9f5a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374cee38722sm1190892f8f.112.2024.09.02.03.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:18:40 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH v1 1/1] gpio: visconti: Replace of_node_to_fwnode() with more suitable API
Date: Mon,  2 Sep 2024 12:18:32 +0200
Message-ID: <172527230209.24237.1541280403906028142.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822225818.707550-1-andy.shevchenko@gmail.com>
References: <20240822225818.707550-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 23 Aug 2024 01:58:18 +0300, Andy Shevchenko wrote:
> of_node_to_fwnode() is a IRQ domain specific implementation of
> of_fwnode_handle(). Replace the former with more suitable API.
> 
> 

Applied, thanks!

[1/1] gpio: visconti: Replace of_node_to_fwnode() with more suitable API
      commit: a5874de9f214a9c603468927adcb7b51fd739862

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


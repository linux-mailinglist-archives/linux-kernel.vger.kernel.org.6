Return-Path: <linux-kernel+bounces-274483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D659478B3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C62891C21296
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F7A15350D;
	Mon,  5 Aug 2024 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YKk/InJR"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A14E10953
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722851476; cv=none; b=eA08ddtTGA/QNniVgII+XU8fSdOGwNlElaJjGlk76s4RdE3mnmK0QGXQtOREFi+cUB0um16oh3a7ELOX3UkslyeOWmNgt+9EwNhfZc7Iw6h5fhKAfM/roH9FnJhD6O7bt3VcWKRsSnqPhq00tlmo8Az97XgfGEZSfBHnddTiWUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722851476; c=relaxed/simple;
	bh=1DdmIDNX40oefqLZN7mwnrF5H1Qqr5MKStNDlGHSnFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4cdIEsGoCTgelUDamVLd3ljrBMUrRrZhj/64Tql3y/zq4YgKeRUwe2KbweAqHBZiFzZaVugBd7gnjfChGXKfPJiOGTsoaGoWwMKiejQpwrco3MN5CHnCW0GHmhlkIv4vpq965v8s9K2Wdi6/LGuSOA0Xxo4Bu3tQFvlTjB/gl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YKk/InJR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42819654737so64107485e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 02:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722851473; x=1723456273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGEl9OcyFIEUiKWt6BYBFPfZdPeiHpKqScr5AJu2U+Q=;
        b=YKk/InJRw0nGlveNd2D7ZlR4295+QO+5h/2dcagubHLVp0Boy8rkx9EddqyLm/pNoU
         ywWnDYl+duIqNRFibu+8LcDjI/0bWCCGclIhR6jwQEigN5y70eFFSLvthpKMGV7nLjHX
         MQ12uJrJxfoT7zKY0oCXIUmTRNF2OeeG3q84nUYDIb8YVH7bvMhAXEoDJpgBEsiV9C34
         lQpuLER3xb+MN2zdHDGzDpkQ4Jd0NQlrO5GEnKEoH2hohDb3Cweqj3LQBMJDUkEOMLLz
         Y/H4CLBNJml6NpgcHSFlwFPAdlad+mhJ0bnT2b842Wr1ldDhs0cxyr1Oh61p+nakwwwf
         kP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722851473; x=1723456273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGEl9OcyFIEUiKWt6BYBFPfZdPeiHpKqScr5AJu2U+Q=;
        b=WHLmTgbmRUQIGjstb+KhN93SloJ0Ww1tCxskv674UomvT4GjYJSzACFMkZ255hnqBj
         uEE6ChB3+IqIxfjsKAwmmkXoCnFird6JraKsvGyW++nQNF4E3MV/iF3vmSmabiSYGPjm
         pk2O5kL/iXyt8RsHTnTkuM5n89ZYYbMuyGUU6QrENdU2xQ/nAaVEckfauCjtzol2hsWQ
         iN2lNLlJj/poIXZC8JnX6lLgd5BkRzINrRdZxRb9w+ax8ylciomtosPtk24qAVV/cwgD
         2A18bmVHignZs9wUWoUjqtfVSvZAC8b+SC9elhAhNIvtURtoFKrHzLOe9585MMJ0OWsS
         H4oA==
X-Forwarded-Encrypted: i=1; AJvYcCXmhDMhKpv3xZr6+lK/YW+Lw0O3jG1v20Q0oFNurOrVsIqNQU4DdcyN16f3o6VvZlv9FWwIcly6V6UskrcdpCxwEAPexXSkH2vEGvrF
X-Gm-Message-State: AOJu0YwyU2DVXwtyajl6iydwzDwWCf2iNVOFFLrrJOqE3Sh9JzOVPUvT
	kowFF5mU4wwEQXi1RiilTsNu7Zxma7Gu+A4HO/ugZQx3EPVx8xrTM8g3IATKDcI=
X-Google-Smtp-Source: AGHT+IF0/0e7Q5gjFEgw/SDz6NusS0BSYhN8JYkD3AR87M6IFblZNBUcltrTMziWayX52gKU2XuSMg==
X-Received: by 2002:a05:600c:1548:b0:426:640b:73d9 with SMTP id 5b1f17b1804b1-428e6b07c59mr78756645e9.10.1722851473073;
        Mon, 05 Aug 2024 02:51:13 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:1068:b792:523c:3f73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb64006sm193582365e9.30.2024.08.05.02.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 02:51:12 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	haibo.chen@nxp.com
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	wahrenst@gmx.net,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 0/2] few small change for gpio-vf610
Date: Mon,  5 Aug 2024 11:51:11 +0200
Message-ID: <172285146797.64000.5150192348098375289.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801093028.732338-1-haibo.chen@nxp.com>
References: <20240801093028.732338-1-haibo.chen@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 01 Aug 2024 17:30:26 +0800, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> V2:
> -add PATCH 1 to use u32 instead of unsigned long, to handle 32 pins
> -only one difference from V1, use u32 mask instead unsigned long.
> 
> Haibo Chen (2):
>   gpio: gpio-vf610: use u32 mask to handle 32 number gpios
>   gpio: vf610: add get_direction() support
> 
> [...]

Applied, thanks!

[1/2] gpio: gpio-vf610: use u32 mask to handle 32 number gpios
      commit: 3e7ebf271f935a316e9593d63f495498cde22f80
[2/2] gpio: vf610: add get_direction() support
      commit: 26b95b7b588d70b5075b597ff808543503d36ac6

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


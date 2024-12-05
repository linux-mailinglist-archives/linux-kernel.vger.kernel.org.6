Return-Path: <linux-kernel+bounces-433213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5B39E5531
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9DD22854F9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3252218AC9;
	Thu,  5 Dec 2024 12:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vMSimtEa"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DA62185AB
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400930; cv=none; b=TtU2Q2PMvfJbKg6bRySzqehqigFlrFHke7QYx+CRYw+2czYSWU9kgi61jmyJekj6xZE+mmGsvJsX/3TzxG3ssZ0Ah3FLoOANLkGcp2yJnJagCHW8Oi9JBBWwp8Tt65A/RkL5TWTMrrKVr/VqwLdzYXyS3FVSzSEIFS4WOuKuNO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400930; c=relaxed/simple;
	bh=UW+ZUpvfcfWDTZpunCNNZkPbNxjdzo6HcjHvWihi3WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MXLHttXn+arjTYIRZszfFzVa0GtiiijK5HO7hdCT+RjvaCtHjF1QlWxQgd2RzjuCebHKrmir5yfaSeCRCIB+a7QeP727ANFLxCzHwIUoruwp2o4gG2AQSsQXMJtG40k/YBlPDD63L1R588Tk5i07psC0+08S9UeDjNLwfs3ch3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vMSimtEa; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385dfb168cbso441182f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 04:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733400926; x=1734005726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gY4jyriOEKZyLnJE0vGxHVVOzKfqLgdZoGmwsUcarbc=;
        b=vMSimtEahX+HpsJkMIq4mf0f0e6nAYRsHN62OJ9yvgsQYYrSHt+Dp11wonNLx2d7P6
         tafKXoplo2EsvG8Pz4BkcZA5vrvXzaFkN7Oc+9Wlzi0DlZEKi4sEhBSIjqjpSu6OtFp8
         SWnVNmiTsNHOL/GKavEyCeEuW/Qd+kkva3qgJn2tIB+EhT39kCoCBou8MuV9mPX93u6k
         l3ULPMZUnW0g+qVto4Al64ckomTPO+r9PuWMbIf3srWe/Mtxw/0kC1Kty7gwD84SVn2j
         92Z0ugXe8zm2XeucSjA7Zs9LYWevz66PSELrPINdbBtrcwtUAZto/zsg6+j/X9Q4CgJ4
         azOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733400926; x=1734005726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gY4jyriOEKZyLnJE0vGxHVVOzKfqLgdZoGmwsUcarbc=;
        b=eIXrE1DDJlwLcSYj7ekkuqYV85WnemH36PHFDduzWshLf4NoOpS/VGB9MwSQ63UY7k
         DzrjoMDWDQbK0CFWWXl7JEVzivGS5+Rd5baWSDLul2mR1nivbaPydNRyEemYMRtCg4Y4
         7u7D0cMAbuaLxGgEM0Ablhs6h1M1AsC84+y9LwMOWZ+0znhJlzLuiP/n6qRHgYEN4vRT
         TWH7aPzfPnQicRco2Y3SjAt8frKJsuS5Mp5hfJRghxl0ikGJtDg9MkLeTAisbrUDaWar
         G8derI4FVjVv2UDK9y6Ki6HaxL7ZMEjLk/bU+EoavWC9XaPSB1NVWuOrVcJgJvR/b92I
         5YYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhki50jKzxCQEQ/+FAmD5pLriWIz5jzbfoY0VCQXd0jqBIKHELF64D0OMpCTmm3TiTon0F9WFkFqdXlxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgrLHy1Nt6CJcfQi+qu10L8+9VnOl7hB+vjrly5l6v6IXb1d6t
	vZpqOo4JeCv3Ld87eAGF7hZIDPbbpFHYgVWldGOSZV32WDVfPOKhs349s6gPRLc=
X-Gm-Gg: ASbGnctkh9LMiUEC117cyo4BXDPwjuCnag1sJdQXuSgCBd9ixskpcur5MQwDIEQjXiY
	8iwXErrzr9qiRrENRXylMb6cYQlA7asVArrkvHl53V/arsNU48ll7B8zBwDzuMyoNbcJd0azyqA
	gmZQWs6JF57F4BWx6uloqsKuUlS0t0W3Q6DK0yUeLqbjuRNPPUhuTvhPgvzxBYJFD+kEBb03wuc
	1JAqjPNsNMuI+GUWNrvSHacadYpP+u3EARFHF6Fhec7u1jK
X-Google-Smtp-Source: AGHT+IFneey2lxrLoI9OQR9skYI1bQ3FNZ3tGvEDNgPi29bYBpl/TJVAwIwu1ozM/FxFCYlhT/a/9w==
X-Received: by 2002:a5d:6dae:0:b0:385:e1a8:e2a1 with SMTP id ffacd0b85a97d-385fd3c59a7mr8953328f8f.3.1733400925677;
        Thu, 05 Dec 2024 04:15:25 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b496:c2c8:33f:e860])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621909748sm1766386f8f.67.2024.12.05.04.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 04:15:25 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-gpio@vger.kernel.org,
	Rosen Penev <rosenp@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: twl4030: use gpiochip_get_data
Date: Thu,  5 Dec 2024 13:15:23 +0100
Message-ID: <173340091124.42145.941891093245304888.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203233354.184404-1-rosenp@gmail.com>
References: <20241203233354.184404-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 03 Dec 2024 15:33:54 -0800, Rosen Penev wrote:
> We can pass the pointer in probe to gpiochip_add_data instead of using
> dev_get_drvdata.
> 
> 

Indeed, looks much nicer.

Applied, thanks!

[1/1] gpio: twl4030: use gpiochip_get_data
      commit: 26a4dedc5f3cdb6e2de79371f57d12e5119f03c1

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


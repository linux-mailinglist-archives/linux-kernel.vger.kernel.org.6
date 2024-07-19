Return-Path: <linux-kernel+bounces-257396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81A493796B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24E3F1C20958
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70CF1448DE;
	Fri, 19 Jul 2024 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="CmuOcrsT"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966DF286A8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401104; cv=none; b=UP4Fca9I+6UXxtzbVTrLf/jl1zr2xlHECXTvPGdKKjyC6siQnvZHEXU179uq+UJfMQADenfijH24dNfy6aBHPbgNsTZoq6T5wRqviOUcYIiqW4WEVfa9ZWUAO/22qcIA3kUhcPAOVTl/YbObCRiqUNXCAn9QwcxVXbdtctQAQiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401104; c=relaxed/simple;
	bh=/L0E1OFBSqZHyMIzxrDbyrO/QpR+srDPOrCtc9hLQS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXMJ/iEjqKaRFLeTOP40QNLgMZ+6xsAOFUZIEcQMThptHIRY/JhlBLHIuIFIg1b1sY4zMpEDo3u6OdPoNZba8/f91FIPZ0TkaPvrkzUqZ1VYKaDVfCU9IguHUjAcH1hDD0VI74vOD36Mn3rMe1QUTcy2otnxfpoYZwoMVHLE4UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=CmuOcrsT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4266182a9d7so11830415e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 07:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1721401101; x=1722005901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQHOTm7Y3ccV/j/KO9p8hVujVUcq/9bgQV6XKF7Ad4o=;
        b=CmuOcrsTDrwAh+n2VSbkagxBqMHCsMg+FX9ycXfIPAVFr3BTp/5++c2OH2quHYmcgh
         0aoRkkUfa5GjBYu+vT3F/yunayqZhKnuf9log3ek2UlGXIhgYBnRamTfVpPLXVCvRg6l
         GeRj0ww0ugEjT4ZTJ3KtJBzgVx9/VLDhG9dJJC9NYYwxvJiMcgY2PlWquenrMIegZ5mu
         WQq1Q2sY3FvzNAMaY7zxavIlqRrhkq/mhbiCcgVrHdGivgCkTvk8KKu3pBHMBmLb/xJ4
         AXswolIhTywnNyz/ZPibVDeNkA/wi/ysVgq2EB2YIobJSsD+qR08fHz/dPeE7sKyYma2
         NTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721401101; x=1722005901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQHOTm7Y3ccV/j/KO9p8hVujVUcq/9bgQV6XKF7Ad4o=;
        b=WpKN79y7t32tMMbjW/k08a3NgYFSRCTbYzsMJgrX9ZCR2uwVl5Trlt/EU4HOLPX3Ux
         ubsqWFpgq4tEE7FkVoiuQbu99fJOU9l5JyVVcQ+NTzQ4SuHUP29X8xHPC50OLVLlALCC
         Wa8mutNpiYDhtlF0l7+Knhs1USh+R50rTneDJKYnBQYGg3XbP9VhumJ0DtXfgXBkBhjU
         w3ELbOwy6XT2VSoTR1mnQ2Nj4RbqPfBL//a7HyRiCN6ea7lWwbHvP6r5MgBf5yNLeaTr
         0J5vYp6IWV5NdbbBgexmay0bOEe+lGB/4C0z4RaFCy5/0tPkY89ZzY+gpd8u9M5eZ9Wv
         tudw==
X-Forwarded-Encrypted: i=1; AJvYcCUOPpzL/tIb/SM28mPChCwMJUZrZKAITrkWgEfjn0NLSERJMNPEtbHduHdPLwVmYhXAGm+C49QUru4C/JGuhebd/uvHpCk3hnmiec3s
X-Gm-Message-State: AOJu0YyAE5wWiGiW57wTffFc2OyHX4LpKZ7RiTuTWOS3hiPFc1UiOjso
	O3rajaCmzLtMGFdWGAgfVH792UPGfenyRiv9ghyPmwazAsT+F96qUraJBeDf9es=
X-Google-Smtp-Source: AGHT+IGntyXO3e7z599v/iJ4YjoQgBgO1EK3mOJ9D514vnBqigaXjO+6vlCUfj0E/lsC2S8/XF8d9Q==
X-Received: by 2002:a05:600c:15cb:b0:426:58cb:8ca3 with SMTP id 5b1f17b1804b1-427d7293d49mr14411955e9.21.1721401100858;
        Fri, 19 Jul 2024 07:58:20 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:2aee:948:fb51:d5a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e436sm53905425e9.33.2024.07.19.07.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 07:58:19 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Arnd Bergmann <arnd@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] gpio: virtuser: avoid non-constant format string
Date: Fri, 19 Jul 2024 16:58:18 +0200
Message-ID: <172140109528.139764.1997443396332853714.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240719144422.2082394-1-arnd@kernel.org>
References: <20240719144422.2082394-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 19 Jul 2024 16:44:10 +0200, Arnd Bergmann wrote:
> Using a string variable as an sprintf format is potentially
> dangerous, and gcc can warn about this:
> 
> drivers/gpio/gpio-virtuser.c: In function 'gpio_virtuser_dbgfs_init_line_attrs':
> drivers/gpio/gpio-virtuser.c:808:9: error: format not a string literal and no format arguments [-Werror=format-security]
>   808 |         sprintf(data->consumer, id);
>       |         ^~~~~~~
> 
> [...]

Applied, thanks!

[1/1] gpio: virtuser: avoid non-constant format string
      commit: 3ae08e47742eeebf2190900d31ddac53fdd13a5b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


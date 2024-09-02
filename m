Return-Path: <linux-kernel+bounces-311049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B49F7968450
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54A46B25C67
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E75E13D8AC;
	Mon,  2 Sep 2024 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="U+f1ZZrL"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FD613AD18
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271985; cv=none; b=rXnn0cb0slcMLrfsIosCV2kY0jr4oQga6utoeOWJDG8XJx8+wzzwa2F5CoNsQMe540T54KJtKYtPL94PZ+nM8egKdsvg8wlTcicMjkVAU0yCK6QPDid+FxHiz/rMicjJg5kq4U6HejLRNJw3xaEXETPadooKCmu2AZP1VVYNwpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271985; c=relaxed/simple;
	bh=yeZfJW74IaCXpzqVM3KRXsaCXolXFKS330brlZIHoQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XV/EnRkcIzsm29dpeg+57lelklTZQYg/mhCLA0I2fMSRxk6rQHyRWmC/+q7kDwSq3Ql+yPta1dWNr6dZdyJ0Fe0Vl/Ia4dX/Jn6PenADCp3+/9wSGucmrmOCNDebZIFo3r+1Pizw+pRwZzfJyA1RgaT+zbxQkDft0dO27CaTu2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=U+f1ZZrL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42c7a49152aso18935775e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725271981; x=1725876781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6QuFCa6faxKRcJTh+EWhCDLQ1qy+cPMdZ2uHl8UfkQ=;
        b=U+f1ZZrL5NGp6qAf9VkcXBbSr2iMmtSRHcdNXppw7gpYeBiJ/CquJEQHeZNYqdVRcx
         q/e4NoBJxFIxgV4/saZNElK1adMI4i0lRUVJ/SddkE7pJYihmag1Yt2dz6RX8UO/IzuO
         s3p1TJ0uGOBtHHT2ljkilzWM/XEDvIa0UUbLv8etA05/Bqd3b5uVlc1rvlTANsD+unu/
         uK5hWRMD042GhxBZaYIxNXhdBOt0pXgEZrnAM4LQ7oKWjp2DrURuQtbLOr75IvbP7mt4
         /DMillF2sDs1MGmk4BIKvy5suwJOsld6edpERVvMGlEgfKHsE1wr7IUpllxVGnhO/60R
         HfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725271981; x=1725876781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6QuFCa6faxKRcJTh+EWhCDLQ1qy+cPMdZ2uHl8UfkQ=;
        b=R5HkCGlh857ucQqz4I8bRLFA1Xg9KWN1Stwc6JXouEXo+4ZfPhK2isgyuuLlu24UnL
         v2uefDpbZi+fkdeRJt7C1sNlFpsxb76aKdkE/jsrQZo9jXQ2GnFT0zE/fp46d958yy49
         x/PlNATB1oNE2Blo3NEKgTNrrnG+FlKB4wATg3Dvl4JpNlrX9eWfIvMwRsZIzIQaBCMw
         x4DpHD3XtbZmavia0aW3O+AFkFGzcOpK1xFlWdDU1R12EHgrYrigGJE1yMWTDRmW1aZe
         RCA+lhx2O/eKsH8CNCh9fdSFQqbn1vNrdxgg+k4GlOvlbO8AYopiFvtqp2yfzRNoygcL
         svBg==
X-Forwarded-Encrypted: i=1; AJvYcCXBJ1Yj4qCveHtd8w8gZOacFDDdOaLG8r6DZg3mfXVZI+83PdTllhzp0zgwdNI1w1kT7Fv3kJp4v0IXxeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo1yR0N1CkGJApzspWJGM097yrupAlhSBKUpxOoA538GVuRQSr
	dHvOBxt/gM1plrfteXFzxM7xs/J4zBYPM9wCC//KaoRq5j2kitspTWltG2E5T7A=
X-Google-Smtp-Source: AGHT+IGpljPS5Q3ZoDSgr/5JetKqjM31lOX75+d9bX8iaaz/poEpVrgxZ4ugPLf5F7NMdxa+tpy2bg==
X-Received: by 2002:adf:fecd:0:b0:374:bf18:6092 with SMTP id ffacd0b85a97d-374bf1866a6mr5115122f8f.38.1725271981066;
        Mon, 02 Sep 2024 03:13:01 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b496:9e67:73c9:9f5a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee4d391sm11052415f8f.3.2024.09.02.03.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:13:00 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v1 1/1] gpio: tegra: Replace of_node_to_fwnode() with more suitable API
Date: Mon,  2 Sep 2024 12:12:59 +0200
Message-ID: <172527197741.23400.10042043019782849744.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822223845.706346-1-andy.shevchenko@gmail.com>
References: <20240822223845.706346-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 23 Aug 2024 01:38:45 +0300, Andy Shevchenko wrote:
> of_node_to_fwnode() is a IRQ domain specific implementation of
> of_fwnode_handle(). Replace the former with more suitable API.
> 
> 

Applied, thanks!

[1/1] gpio: tegra: Replace of_node_to_fwnode() with more suitable API
      commit: 842da04a99193a8385208a619fe97d0de9f3ed30

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


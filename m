Return-Path: <linux-kernel+bounces-394347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 018659BADAF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97A74B21132
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1328F1A3AA9;
	Mon,  4 Nov 2024 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="NYHZWuln"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F198918C038
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 08:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730707710; cv=none; b=Z8c11hXEVPAGee4VxDpa7yqAOoOUT1jjC9gxsdwMmtYAIRZX5wXvsRpVU9PnhMD4FmdGeCMy99YhbuZruUimUjWoQf2Pf/tkH9BHP7Y5alImkR0S2qI7RVE6OesdPo9oaMeCxUOF7tW4UPOV9N+l8ONnc2p6kwERZhFbKk+lFbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730707710; c=relaxed/simple;
	bh=3JEIP3trdWXY3OhYKZ9hDufFF7JwJ4CbZGyMOu7x8Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1EAJNDyLml2fUHJUj+ai/2cmK2yS4Wu3UuuolRczt/jKL20gZ5HIFrvZo7/U7mot+lRkP9Tk419U2wJ876y485treeQ3P7M6DrRoP5iP/mqLE+tQr459zZZedrKaBu+Eo+ElwItRQRcIMl5NpqWEZZP0Cmq+c2cP2woMm5EX0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=NYHZWuln; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d3e8d923fso2686243f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 00:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730707704; x=1731312504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouKh0m/U67plJMM8f2yCQV/CR0SvwhGX1mh7H97wvBI=;
        b=NYHZWulniFoS35L4/IGFC6jdA6kKvu2fGSSWwGXypGkVeExPCOZKgKkdAr/Y0/EO0m
         QEBPATlUUu9vTtA18DGiwP/FU2oj9p5N6rkxVWGL3uumQt5uuQemO8cSeaID5Ywes+vx
         hCQh78WctHb5tvoEXB3m/8jR9MmONuxG6ejOR19BchdppWi6BV15sSM+RIL2JiY7VJJ9
         JU7tlLXXdNmBaggd7Hi9at9Y0Q4I3AmWmcuFzkiEXxKI8cxG9OjnkW9FNfKuwJuuTwv5
         n1Axo23Kr3Olm/o4kHBgcJ/smGS2U5T2BQuBR8nPEss1I8z3H65zGMOT5bu59ZdH1JGQ
         v9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730707704; x=1731312504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ouKh0m/U67plJMM8f2yCQV/CR0SvwhGX1mh7H97wvBI=;
        b=Mf1vUOmCLixKR0TeWCBnkT5a+Y9hJybZogwUesHrRmM92iF7fNw1CpBykLsbS8CJDG
         EwFXWPjg8a/S/3anlV0LvIccuXKcejaBq/MiJwX88kQR57DdBX0YCQd+IH32vYEMAZQL
         qFOeI+xW0LEbAnQNFloRbPOzCAtQnuN7NoEBfevLfCkMZKw3wDAGTEuCorgJeQ1jqkZE
         Ellx9yoLYbC5byagbBV3BbX8tV7LHkqCUKP2/1k+E8vK/KG0O2b8GXJAjNXRGu3EiOWo
         RER4+yPqsDTEtwHJdU6irxVLk26kjIXwx7CGkpKcEwLSsC+5248nQgOxo3NWw+YFyUiS
         ukTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2s+lZClePaMKItJ2LBhrAB9R7tZEXFdQ53kBofwTGSCX7ayDO+O2sA82IScyCsB26enFirJrtQxgDLlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVvRn7sdnUHj800zNC+HBxpz0jaz6RgRgMBhXZAWGZBKRnJYts
	lGswXXKLQlqMtaTJj9YfNgQ/GATCWrhsO9eiuR2t7MAq2RGK/a29sGe/7gHxG/o=
X-Google-Smtp-Source: AGHT+IG54Q34UUUKQL4iuFFh1ouFPZXXkdCJqKConmKoPt8E/v5DXrBgiqWt4jC/95WRoUFI72oSZw==
X-Received: by 2002:adf:ce89:0:b0:37d:476d:2d58 with SMTP id ffacd0b85a97d-380611e56aemr20304274f8f.45.1730707704225;
        Mon, 04 Nov 2024 00:08:24 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:2603:7936:7734:a187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116abf3sm12492563f8f.101.2024.11.04.00.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 00:08:23 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: cdev: don't report GPIOs requested as interrupts as used
Date: Mon,  4 Nov 2024 09:08:22 +0100
Message-ID: <173070770020.10504.9321463955414503988.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241031200842.22712-1-brgl@bgdev.pl>
References: <20241031200842.22712-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 31 Oct 2024 21:08:41 +0100, Bartosz Golaszewski wrote:
> GPIOs used as shared irqs can still be requested by user-space (or
> kernel drivers for that matter) yet we report them as used over the
> chardev ABI. Drop the test for FLAG_USED_AS_IRQ from
> gpio_desc_to_lineinfo().
> 
> 

Applied, thanks!

[1/1] gpio: cdev: don't report GPIOs requested as interrupts as used
      commit: dae01ec714fbbf3a71947668cb61cee4cc320647

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


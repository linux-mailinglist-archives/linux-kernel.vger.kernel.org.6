Return-Path: <linux-kernel+bounces-533513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D41A45B7F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E123A1763E0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02A324E01A;
	Wed, 26 Feb 2025 10:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="CXc3Vro9"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C4B2459DF
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740564921; cv=none; b=UmgjA9+r80Lg9zb0KFb6n32ui/fAiRjQXUITXL/TJN8jW6WJ5nUekvwf2Twq+oEYpiXTDsjFmlt8GUCIlh0wZCXNjC+owN4Eu+oCHA/UfEIPD1h9Zh7ptckXScbuDy9W6AfNuEYsxDy5jq//0y0Uy+cRKu+WUIHPyMPwPHym/2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740564921; c=relaxed/simple;
	bh=lmaHsdIjyeoXwlxTnbkpP3HL5d/owFOlMVcngpMhhDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iNSZyllRmRSxAnDy3ZK6b3FwixYj1lg0CQUx2bX3ebWrwL1s4fEg8h3GKv+f5h7xHGkAueLHnQD8P1X7RpEw6IKIxhkZfA5ZkCOVvNqiQmyVIWYfbfY5wNxFETWW/lWGwnyCmfgAWUYaJDA8AotuUR+0xbZkt3UZbooG2JJppuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=CXc3Vro9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4399ee18a57so4203165e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 02:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740564918; x=1741169718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGbaXyM3Jpdsq99NC8sU65wH5v68rhdD4yTSLXIyXtw=;
        b=CXc3Vro91izrzt3YQpCK1JQBx/6Vew++Pzjw8KHw7u3j9hlCTZSWlyQKr9UosR6Ldy
         5NHxJPliUZH2+OQucmujYc/DH0IXAXFB8s1XMCa1v+wJd9KpXT6GzD7zy5YXx6zqIiEw
         444rSIoV4jTJf+HlvqLt/xc9meIWYkRKWEz5wH7ZHwFiAxpxMwMuVtnyg91dStWa5oH0
         B6ki0obMcW0dTTN/YO1RUNfKlW3XMOR/Msv8SSd6pDCzyIa/erAxMpc7XIYEMfpy9avB
         Cak1HrQNYuEs9weOcSUgJvyuNR28Sf8QW+FQ94T0CM5YlsHaLJ2at4tN6ZY8ogHY9h6p
         8T2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740564918; x=1741169718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGbaXyM3Jpdsq99NC8sU65wH5v68rhdD4yTSLXIyXtw=;
        b=Cj49vdC1fIbE1DTYEw16XzJ5zX2gHvv1vhjWoKS1faCJyEZM9TQvqNkaLzlPAGq8fG
         N9yOsj0wJrgak5Yl6n+jaCjwNIgZtPqWO6HIY9VEb4MkdmTMDu6PAOgEDMJkzCwSzFgO
         94PevbVYZbpFBXZgI+PwNEpIc3oOfUxZt4QS4ziWIIeI3cSZlBlTn9myH7pqp+lP5oLX
         HIAjJHRaHc6c6+XnbjF45z64mmXOrlNmpJnARpr/ELPnQWtZunChbQKOZ8MDIEb32iwm
         Tjc3i0BahNFXgYEdPfFCGS9BjWPWQ+q8ARw5lC1/+i06RfDI1tbNbNo4YU4llbYTQhdK
         VPDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8H+k25QsOyNLvpLCG7/SNuNV9Vyvw/jloPcowjO43v0HF0YsFL/BGcw2Vjsl08TqT5GzW+BTyTwq4slk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe/SfJzrvaklNlqdBVwaUUfoq7emU+mObGf8ZHREoBQu+UjcN+
	0aaIQrYQedhodlEkpDVIN06uor7rRBGeLuHTqIp7sFBUJ9TOGi+QjRDfnbx8Lm8=
X-Gm-Gg: ASbGnctSvVwkM35ggxPbJ1bOYVaTpLBf5yyyop6hvz4POIu8bORiYTMZ1MfvlSlqFe0
	bCJ7rTklevcKWWbLAtlj5EojrFsN0Zl6Ck5Xs2l8hQcta2U4QRuzD/TL1vaKWcc4lEh7PTMd3Po
	3I72iFjkknK43PagPxa8FG20byzqHDRstXuAwbLdtX3bcHAoW0J1Ir2Vbm/rMEJheA9SaH8LFrO
	xDrvGtMs5VUnOu/QMle23B+uln/l+myijpLw2k0+hXy8Y/Hw6ewHGqCKOT7yoYZ/tM0lCWQlg8V
	KdYdlvjIOaVJq2h5GZqGiq0=
X-Google-Smtp-Source: AGHT+IHJ1cyASwzwsO+YvriZVv8hoDmiSBsK+ybOnr9953bvfTy7VHWnbh89iSzieYU/NqrxhGQkNg==
X-Received: by 2002:a7b:cd8b:0:b0:435:edb0:5d27 with SMTP id 5b1f17b1804b1-439a30afaecmr221385665e9.9.1740564917888;
        Wed, 26 Feb 2025 02:15:17 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7d02:26:5770:658c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8fc1f9sm4924418f8f.88.2025.02.26.02.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 02:15:17 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v2] gpiolib: use the required minimum set of headers
Date: Wed, 26 Feb 2025 11:15:15 +0100
Message-ID: <174056490934.34383.5628472134451605193.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250225095210.25910-1-brgl@bgdev.pl>
References: <20250225095210.25910-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 25 Feb 2025 10:52:10 +0100, Bartosz Golaszewski wrote:
> Andy suggested we should keep a fine-grained scheme for includes and
> only pull in stuff required within individual ifdef sections. Let's
> revert commit dea69f2d1cc8 ("gpiolib: move all includes to the top of
> gpio/consumer.h") and make the headers situation even more fine-grained
> by only including the first level headers containing requireded symbols
> except for bug.h where checkpatch.pl warns against including asm/bug.h.
> 
> [...]

Applied, thanks!

[1/1] gpiolib: use the required minimum set of headers
      commit: 007094c83872ed33c1d9e39b3ef7168d85a3f214

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


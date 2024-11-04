Return-Path: <linux-kernel+bounces-394331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3999BAD7E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13C7C1F21E93
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3278199FD0;
	Mon,  4 Nov 2024 07:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="uFNkm4eu"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63EE189F45
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 07:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730706993; cv=none; b=IzhfyPYObQPJdXTwRvxHtEZfCTESk6EGINWqdyZeywjPgtKOTGyvtWxNfhmC8+i1r+MpcfVM8hK2Wc5MqU/SfsxfFsvsQPQNP2orbprOWJEbBO2xNs37hRrZmXC/DN0yUR8Qh39go1ETXS9r06EAUW1ZJpSzlQV/0NB+rT4VGbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730706993; c=relaxed/simple;
	bh=Y4FhluNAOh92dTJN3S7J3D8D1JgFksfWaMdnx6puF2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2I1KaBspna5enYZHew4oYwpAT8YrWvaKdfRBBQfzHxKjd9/8gSyqwnoPg39JeySBI/Fuyvaebtygr2r2XUdxh+55O17vbbRnk7hc/1t/vMj/rqZbJF2QpJJ8mZvzpXakCoSJFh3j/0HHgnQMpyRZwSBWTyFw4jtSAjUFW23ZKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=uFNkm4eu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so31464355e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 23:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730706990; x=1731311790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkuJ1rDzuYOHt5sI+K9j0dAnU8DW0XrtneA96wzoUFU=;
        b=uFNkm4euwuNF3lhfNr+lfcykGYs8MW4/XvWW1fWwVNkk59u20AoEL/XePTJOOCbnFC
         bfrFIMDmpS5lxaaeMrtQvpSglJwGuhwF0TEMvTxW/cG8DM2AxD7T07mdqIwkXBUIX821
         YYXDzyaeJj1qw3V3kaOdELUtrsHC9K3Xy7htALE+NNmAQMLQWwe0LB4voHhuaLLi0eqn
         fg8WrcVNrbe+IbW8dpE0G3i/WdasMA8grMgnIvCw4v/yuo6tVDCElkC0Otfii6d2L7z0
         QOPIyQ24ZCpxNyLUYvZPIGKydo3E2q8ro+qQ41CzIQomI4TeACelNKy5sgd1PsNHS6p9
         GzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730706990; x=1731311790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkuJ1rDzuYOHt5sI+K9j0dAnU8DW0XrtneA96wzoUFU=;
        b=Ug2OYnQ0nS0+s17ZnrGmIgu+QYH31uzrUn+nAg51cm43Yusq7sz/Gxn503PaMIDSb3
         dgOjOpckKPLs8F+fE365k7Z0BCXRbzzvJ+l1wW9bZ1EvXTCm8f43wGFEzdkuQIol8yVy
         F8UetroLSYpZRx5i307VBrvuvKaQxSmAPisbs8ds7Qz6Iz8MgktU5Ccm1/Fhsg5Z/vM6
         Q2SJKE6+kyfnSCikOQ1aCy4lSEZCDvsy91xCLlnlg6hPhBILLG8TzCqahBDIugGgImvJ
         1MQnAhFfANeThsmtlZ29DoxDCDB1tHEmmdZrth+iZVn1G3MSytMybZiVViMBc1Arpunw
         EIFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW9yOHigX1Wx2i1DR2OMReWdQ9/UwhivpTasWWN/Z21GuVxwvQjluOzJ/NFEvmf0bTZf9ZIdkhOK9Jx7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrNKxQqDcmOoyoBOhGOB+k1zDqAr32Fwp10ueoTJZjOeMTzir2
	VLjEDkqoZacmHbKfAv5MZLqjIWPZaDjCHci7Skim7SMxoZEBOhy142WfpYYq8SA=
X-Google-Smtp-Source: AGHT+IFQmaNCX8yT8LrmK45qdtHMxgMS9uqWwiYHCSKV2cfmEXHAKCq4rRV5e1II1vsfcQH/EGwjbg==
X-Received: by 2002:a05:600c:4f06:b0:431:5f1b:a7c6 with SMTP id 5b1f17b1804b1-432832965d2mr93678725e9.30.1730706989956;
        Sun, 03 Nov 2024 23:56:29 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:2603:7936:7734:a187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd947c26sm177517195e9.26.2024.11.03.23.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 23:56:29 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] gpio: sysfs: send character device notifications for sysfs class events
Date: Mon,  4 Nov 2024 08:56:28 +0100
Message-ID: <173070698546.9713.14647587307010241141.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241031-gpio-notify-sysfs-v4-0-142021c2195c@linaro.org>
References: <20241031-gpio-notify-sysfs-v4-0-142021c2195c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 31 Oct 2024 21:01:50 +0100, Bartosz Golaszewski wrote:
> This may be a total corner-case but for consistency and completeness I
> think it makes sense to also send out line state change events on actions
> triggered from the GPIO sysfs class.
> 
> The first two patches use cleanup helpers in sysfs code. The next three
> change the code to emit notifications on line export (unexport is
> already handled) and active_low & edge changes.
> 
> [...]

Applied, thanks!

[1/5] gpio: sysfs: use cleanup guards for gpiod_data::mutex
      commit: d99c980cfe9423cd1ac719a73ae52437da29a45e
[2/5] gpio: sysfs: use cleanup guards for the sysfs_lock mutex
      commit: f4af1671c28854bb0a400740a9c6ebacb8b9aa6b
[3/5] gpio: sysfs: emit chardev line-state events on GPIO export
      commit: 285678c947197b0a071328f9344b0312e5545e92
[4/5] gpio: sysfs: emit chardev line-state events on active-low changes
      commit: 5a7119e0d951fdf7ebcc25a77565ac184798639a
[5/5] gpio: sysfs: emit chardev line-state events on edge store
      commit: 7b925098c937599c8ad1bc757db80743a990f57e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


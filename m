Return-Path: <linux-kernel+bounces-311094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6CE9684C7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78BA51F235AB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB0A1422BD;
	Mon,  2 Sep 2024 10:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bhainmWD"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5636113C810
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273344; cv=none; b=kshigVCaQ07rH0XFKrMoXdx2wpG09zU6/8lG9U4GDfDc6XILhl2XIo4lkl46Z4PEJXhBMcIE6/kvAjWEvj1YbQgCX2eiWDitwu08Ypja89U9yMHr1o5pqsDI+R2ZFaw2IHbZGuZxzzcAWvq/1gPN1aNaUmpzkTmiQNNKlIR/J+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273344; c=relaxed/simple;
	bh=2pcHemRxMEGsR6Nd2qYsiBCv1Z8klqu64hI/oWG4l2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WeaNxJXRpR3K7DUlN7w34wuqSWLnrr0YiAEmTEIvA1cxes/xwe45FADVxOOx9xkj4i+f4rRhtCI1xdMYicWsZFXVZM2BIKaoLyGiUxt6OdAFTtLZ/zuRGlmz/Um8Jh3F7y+XMklLe69rvG5PgVrsG/S065FNjJAL4bKQ3IdVToc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bhainmWD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42bb9d719d4so28472835e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725273342; x=1725878142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DE/14MdbLC4vxzXLe44lleI/1CtRw0spgNwM7IUzL4M=;
        b=bhainmWDmqb7LfpcrY+b7FhrYoXEPXPa/xgCVBNgCCGMjYqL4zpXzYnGfw2Evfq30z
         jZSNnJYjzCcazPMqeq1N9qjPAxqQUE7d1LdRDWG93YrKooHF0eEV3n4hWPGp5/T8R6Ib
         fJ//XmPwhOTd4Pzq+HZKFis5VV/lpPEr2kYby+vPRSXthB82wW/3D3ojgFZuQCASeJho
         MycalRcafNMa8OC32uDmXNbHSGFnO/FOL+fFzgXiBhKAlEYOF+yapLtA8zVOPvYMpSED
         pCjFmfoJIqfv+1rC8IUNJbchWCog5SalHEVG2KDmvCKmgww7NHTEaLo6wt17tzdCkh2m
         EjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725273342; x=1725878142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DE/14MdbLC4vxzXLe44lleI/1CtRw0spgNwM7IUzL4M=;
        b=QZimrMET8r1AZ8urinEE9sk7/R9yfA8cuODSjIAlhuFXo4CxLSFE3m6LSNVTUpGVcG
         q1LOSMNLU3An4GLUB0OSOB02deaS0dbRXT8hJcl0DNeIfbnDSQ54N84AaIXP+BYGfJYk
         zgPikrclCagK/CIWDFitKlLFkhwR1K2sW2NAhnyRVL6YihXd/mBWN1w7jap4c1dLxYzZ
         P6XTBUXJsvhvKWFpoynIFDfns+eFIYfgBGYeslLmNYtrwaMWlnLEIsAa6DE2imEi5cSZ
         +IUYSCdSMWtZ+88dwLwoZmp+wX+/ijzmIk2AxZ5Emn9PyEIFqRBIRVHv01eNY6X+2jhV
         DRcw==
X-Forwarded-Encrypted: i=1; AJvYcCUvDe2JGyPMYTFX+Kwprh/j0+Qd/1l02hOYrO3uHt9TyXS/YbTxGt8usAAquqHc5DlFOiMepdSkIpgmb9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Uo81m7P8mfW+QrWN8sr3GFvV+MXpQy0meiBCSJmrqS2JrUif
	dy+ncpDxfkbLHRrqSrxwHb1BsewC9TMrwExXG5iukiehTuS6AZc2oQPTNze8el0=
X-Google-Smtp-Source: AGHT+IHk07l4+f7lrJq38Oncb+g3mW7ieoi/jIKouYwFP4SdUSoaEdFixBoaJvVJoezr/ZiTy5ESjg==
X-Received: by 2002:a05:600c:5110:b0:426:6710:223c with SMTP id 5b1f17b1804b1-42bb029371cmr107114295e9.9.1725273341175;
        Mon, 02 Sep 2024 03:35:41 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b496:9e67:73c9:9f5a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb9593c32sm120407775e9.48.2024.09.02.03.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:35:40 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Martyn Welch <martyn.welch@collabora.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel@collabora.com,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: mpc8xxx: Add wake on GPIO support
Date: Mon,  2 Sep 2024 12:35:39 +0200
Message-ID: <172527332394.26048.3193181837780714395.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820143328.1987442-1-martyn.welch@collabora.com>
References: <20240820143328.1987442-1-martyn.welch@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 20 Aug 2024 15:33:27 +0100, Martyn Welch wrote:
> The mpc8xxx GPIO can generate an interrupt on state change. This
> interrupt can be used to wake up the device from its sleep state if
> enabled to do so. Add required support to the driver so that the GPIO
> can be used in this way.
> 
> In order for the GPIO to actually function in this way, it is necessary
> to also set the GPIO bit in the RCPM. This can be done via the device
> tree fsl,rcpm-wakeup property.
> 
> [...]

Applied, thanks!

[1/1] gpio: mpc8xxx: Add wake on GPIO support
      commit: 520aa57ad7222806ebdfd05b8de07bccd0156cf8

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


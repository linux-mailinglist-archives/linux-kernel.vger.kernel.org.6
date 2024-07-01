Return-Path: <linux-kernel+bounces-235741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D4791D921
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B021C20EDF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B2275804;
	Mon,  1 Jul 2024 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="D8IRHPW6"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC447482D8
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 07:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719819553; cv=none; b=H/R4FcjL8jzhKAmbv/n4iBlhpmWMjX5UpcTyaAwgiYep/NGiPMy9Rvvsit0WRzYqAXA4jbzpaS77hOydTWaXkM+M7+MGOgDd6JSIJ2gu4gyWOrCN+fyPwlFO7VkWBOexRd6tSFoeZ7ws9esoeed8FkVDR2V+m31WKBkF9DqjvNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719819553; c=relaxed/simple;
	bh=dkYEAXIYXVQLMENqeRXWiEaGrupUhLNU8N2paeczWJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8CK9/bSMKViyp9J7b/qFmk5oYWyLzIx+jXumMYOYYRtEtJjvk4dYmaSFbZ4q97shy+ibRpK7RHcGKvPijuXDupZkChURXzyqwMOrQRqESmLOaqmcuY100sCbgzpENRYEQ8ed2JTLekR/sR8KPlh1Y5ddbW+bdq5j3bQaGGtcL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=D8IRHPW6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42563a9fa58so19491955e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 00:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719819549; x=1720424349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fgIgufC6sWYVbWr++Melz5Zaf+Cm5Y66Rpu0DCSBjw=;
        b=D8IRHPW6266MB2L5Gevthpv6l8AZb2uhApvEiT1kOEO+fMnRivnbCSpDg09QSsmQtg
         +s2BQCKPvyEcGTgD3ZuYy4N8zoqEDNHkio9yY2e2J71UJjXMDXd2aPrC98T9M8SrFju3
         OmxDXQT+tCDpqG4VEhHhz1tom0sapMjvrB9ovvLybrQoEsO2rM7pmJCk+h9I1qBL/Oj/
         X6RJZRNPGD6QHYUTvsp0ihdhXU3S4deVkt7ngtKSnb0xomjFTnhu2yRNbSrwW5USqRrl
         Cu2VIe/j9/MKMmfTawvMUufz9Tdag+8BJTtHagxigmgUJ9RrKpQl9Sohijik3HswjPyl
         XNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719819549; x=1720424349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fgIgufC6sWYVbWr++Melz5Zaf+Cm5Y66Rpu0DCSBjw=;
        b=eKs99Z6Ltr+yWPA4irfOjbvW4Af5TTXa8zIYPgYDxA0IrQddPeXyBykikuaPNmxTZD
         ML3++vlvhs1OrvsLa0OLxl0P9pkF63zz43bayIWJOrk8xgCgFY1ElgQTrEzSFlH1HPq1
         6CanAmBDtHPD58YRxYfmj2fVUbQLe2PrqKqE8ntaI0QkNPPJXP4ErnbYrLzTumPUICwB
         X84AiWBLGb0b4WQMUYZJZbVsz4cP/7ylzEtigxqUojwlGVNgrD9SJ0vDxm23Y5jZ7Hh/
         wQufe7fjed802+U9vpGCMJn9tWska4+tIc0irSfbTA6h0xKismGhe0DLYMwSCk2K3UXY
         QpVQ==
X-Gm-Message-State: AOJu0YxhyNzi9iDlM5Hc/Njij4H1nkoqcBQsEH9DVeX3gRuF7CqBYXSQ
	8m4Rs/K/BKCConBRrXr+kxs8A6MTD/NSPqgFOLUN5Zaeeg762koiVKwd8qifw8mM+8mHY9ePzor
	t
X-Google-Smtp-Source: AGHT+IHNc+7+N9eC1OCeqWD0tq/0TARqW46iTGahOqldEck4UMOaczS4cTl8rIDye8WekS0QF9nrHw==
X-Received: by 2002:a05:6000:136f:b0:367:1da6:e419 with SMTP id ffacd0b85a97d-3677571c211mr4067290f8f.46.1719819548998;
        Mon, 01 Jul 2024 00:39:08 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:1c2d:13b2:676b:59c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d9ca8sm9249029f8f.43.2024.07.01.00.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 00:39:08 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	Kent Gibson <warthog618@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 0/4] gpiolib: cdev: directionless line reconfiguration
Date: Mon,  1 Jul 2024 09:39:07 +0200
Message-ID: <171981953255.7947.3008231579681723957.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240626052925.174272-1-warthog618@gmail.com>
References: <20240626052925.174272-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 26 Jun 2024 13:29:21 +0800, Kent Gibson wrote:
> The behaviour of request reconfiguration without a direction flag set is
> ill-defined and badly behaved, for both uAPI v1 and v2.  I'll will refer
> to such a configuration as 'directionless' here.  That refers to the
> configuration requested, not the actual state of the line.
> 
> The configuration validation used during reconfiguration is borrowed from
> the line request operation, where, to verify the intent of the user, the
> direction must be set to in order to effect a change to the electrical
> configuration of a line. But that validation does not allow for the
> directionless case, making it possible to clear flags set previously
> without specifying the line direction.
> 
> [...]

Applied, thanks!

[3/4] Documentation: gpio: Reconfiguration with unset direction (uAPI v1)
      commit: e48fe75afa539d110753f7420aa398ef89f8e383
[4/4] Documentation: gpio: Reconfiguration with unset direction (uAPI v2)
      commit: 6a9c15083b1662a4b7b36e787272deb696d72c24

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


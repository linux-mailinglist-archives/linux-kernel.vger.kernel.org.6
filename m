Return-Path: <linux-kernel+bounces-211464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBF09051EE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4511C20B3C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EE016F29D;
	Wed, 12 Jun 2024 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XGWRVmxP"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A45F16F0E1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718193798; cv=none; b=jXlfFHLlC/vuPQ6C1Hb851YnYl7EVSGFrj8Wq1Gleqqc6fIgbK+J5w/YZtOA48QE3tNIEwgkkDyYllNCCq6EB6SaR/gfwtc3fP7yx8tPb9rnEOUVx0uQp/J8+8uMtTwqzl6zJIcgOVUgmuCIp+c5U7RxZopQn65LSxgJZzKLFgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718193798; c=relaxed/simple;
	bh=GaWixcRc7cLjif3vTgrTA5TxIa1tfz6d4HCIcdoIrpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/tofH2vyxVY0Ovg+IKlhLzIWkIOQ51oW3jq5WBG6uwK7yD/swEgrVlnV3n6Y4fJGYk+IubF79ywYwTYdbCRbJ/hfdwhnYXjCHXC3vD3gMhIaIGqMFCbTwCQq45+7SolTNIjl/jJIEQhDPSpJ4v79EDorcoMOUh0h/S51JvMp34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XGWRVmxP; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e78fe9fc2bso92618391fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 05:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718193794; x=1718798594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpdvA3t0LhYQ51ruF05mfpKy9nZXuP4heggj+jgSeCE=;
        b=XGWRVmxPaBy/wTZqxaUN+//+Y23IynV62syUqZLKwX32cxnLc1pYKZCdRcd3LlyC4Q
         QGdtZ2t8ty4fZjuQC6FYEac8u8X8WOi3Fqn5nRet3dMf+CHUX9I71klq4+Ycnztr3kFh
         QYp1cDAsgFEAkGqfiy4toOBmIW/6fxUosWeaYJ/Zp2b3GMWqM7BoKjmVNye+VhWwTCdX
         I/XoLi4eAKXTZjVhCVC500EjX+xIHaNGWOMT0qp/u7fnctZekDesjJ6PRxEJ0ICOMlM1
         owy/IT5HQ3Rv0KYw/LPSaE03xMPlOSgiff9QZ7c2URvil0lTzaUY7IjUoreJYSnDPduj
         Zvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718193794; x=1718798594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpdvA3t0LhYQ51ruF05mfpKy9nZXuP4heggj+jgSeCE=;
        b=KYWqJqG1T3/kd96GB5LCgH1mtz8Y4xdphwLFuLtZS80l4Kp55JCmya4UwBzrkA5POv
         scq+YI9fFmJGRCedPIm9Mrbq5ep0pPAgh51CZXyak/voaD54RN+anuJWPM0vWUxUxUby
         LF05RdP8aLRXtQFp8bSrIblgfo+vsBSZ9/iAe2IlXsvVm/AXawDIsVVcHw3gEMyspERs
         W4fnRB4XH3y5PZQG0uzsytSQK518Jxgvjxmy1vgOQeCwEDAw4c9TYg/b51MfSHNoWD+r
         za1x8Xu64Ul+jeSxPPVTg+f4TlVRncG8d7TShYXd+yXDTUD6O85bOYPdd76B74Cw6ZsD
         2EDQ==
X-Gm-Message-State: AOJu0Yw8D6je6r7+5rSul27JXMOXCWf/3AmViFeN/7AqWIoxmRTusKsE
	BXHJ5DyZMY91UIQwKZ6GZNSf/RvzL1kZo4xz4lImaaBTO/B7226mx1TNiiveKaRhj7PkucP8sac
	k
X-Google-Smtp-Source: AGHT+IEd+O1uxudQ7gtE3vp9qxZ2Su0J221EOuF2GH3ZcKozbjK871J1l8zVpbPeRgCX3nanl1tetQ==
X-Received: by 2002:a2e:b0d8:0:b0:2ea:e773:c5a with SMTP id 38308e7fff4ca-2ebfc8fecb9mr9110811fa.9.1718193794473;
        Wed, 12 Jun 2024 05:03:14 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:8d3:3800:a172:4e8b:453e:2f03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42284d1130esm11210045e9.0.2024.06.12.05.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 05:03:14 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	brgl@bgdev.pl,
	corbet@lwn.net,
	drankinatty@gmail.com,
	Kent Gibson <warthog618@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 0/2] Documentation: gpio: clarify that line values are logical
Date: Wed, 12 Jun 2024 14:03:12 +0200
Message-ID: <171819379034.33019.17199591747943340340.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240610092157.9147-1-warthog618@gmail.com>
References: <20240610092157.9147-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 10 Jun 2024 17:21:55 +0800, Kent Gibson wrote:
> The line values passed by the GPIO uAPI are logical values, and the edges
> returned are based on changes to logical line values.  While the
> documentation consistently uses active/inactive terminology to identify
> the values as logical, this is never explicitly spelt out.
> This series clarifies those points, with paricular emphasis on the
> effect the active low flag has on values and edge polarity.
> 
> [...]

Applied, thanks!

[1/2] Documentation: gpio: Clarify effect of active low flag on line values
      commit: 5ca84d416e1ca82ca068906fc1386f61a57b17f2
[2/2] Documentation: gpio: Clarify effect of active low flag on line edges
      commit: 08d94c7428680715527757585a6c4575fcf571b9

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


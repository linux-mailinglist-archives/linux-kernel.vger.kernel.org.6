Return-Path: <linux-kernel+bounces-373760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340F69A5C32
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E951C21700
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272A61D0F73;
	Mon, 21 Oct 2024 07:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DAvK2dOn"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB101D0F51
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729494882; cv=none; b=eOw6gs8VWiZBCZIKn0j1qRrqi5/99YRv/FroIoBi0wTOt+ZsaCgUJJQNQaGG6B4SLJkFHwgy27CO4HWA96tAW43Pb4cE1YjFEYNhQ3SCs8FtUi5uEuVKcJ8l0NOeJtgwqdAND/3YDI4TxOeVsVRsrI+XBCNmqr9fBomKfLROyFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729494882; c=relaxed/simple;
	bh=B/kiukLnjmLkwZ+94r2toJOSjF2D/tL5XVrmGqc1MPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N89GcBg+tBS8cQcu0S6XEaw7Db5EWMTcSBx7wk3IWeIPxiGnBI+kMz6f9EM2KY1zDoJGLS/5bz51mk43xKxxyUv07Rjc7chmwzh5aUExwJScvYMkh9mi9kaso22dFhbzTsC3KBDz/jrbGh0WPJlKB9miKLvu4WZZyHJP5pmr6Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DAvK2dOn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4314c452180so33889785e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 00:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729494879; x=1730099679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yf+ojeeNe2s2EnjRYvZ3se/a+vEw/qUmLYKHSRFy53w=;
        b=DAvK2dOnwcsqPpCaooEwW41R8LlZI5HR+W+8pXzCDpTxIBcETnx98S3WCksW1bg+/k
         QKNrz14SlW9cJ7irfMgj1vmS7l8/rrEi6R4KTsexdfMagNR6T83lTWYjgy4tRf3CR0pf
         QEN/c24UzOnNGwHevcGo2kvyDxObN/0Rpcm0+e4V0Qz7s25Mnf6Rl8FZkcLpN8ytXl8B
         Rltc04Sg1twaSRtOI6LGIc/31KU45JxfBkoembbrc4I0iXzfRPsDXxioyqXZDjgXvvec
         Woe8L0Rd34oMZjTdmkHkzbZuIW3fMF/xNePUlj0UchNImtUYMyNHE4UbM6LyMPc6sahq
         vFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729494879; x=1730099679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yf+ojeeNe2s2EnjRYvZ3se/a+vEw/qUmLYKHSRFy53w=;
        b=hbCABOiHg6em2veOT7o+WMh/bUZ/8WLrWJSnMWKQ2c1TvgAnBEu2vNIjoKOmCoAZk9
         4oCpJPfSKsciYQi3ANBQIdTehVD0cw3uiZXlA2d2T7ZR6AuMuFgNH9DR2rp86Lb02YBO
         X3JJpjixhEwQ/XXka+N6QsTXEK6LmgV/s+gMAwfrNLpoKx8iOA+hBuz3sEejdNynXHLi
         hIu1EjTTOmmSu/s1cKo3JhWJB9WCdbe9ko1rLd+7gsv1BsrogaA4zeuWiqitGcbthM5e
         Hl0eyVq86uTMDGAh1wogZz6iCvtx1valo8vW/kZZFoHWX01hRgvM9u7PokH0Ji0M34FA
         +BhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJNm+zfBlNUUlcsRbDzkG17A7HHVEzVjJsvPrSMMb/DhUHVYNQ9+bwWxvQSC7b5wTfINDMjSaTVIGMMXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHSJ5BOq1hn0numG+wv+2994AWVIe1EYRdGvzMgdueC/cGaZH7
	D4f23idesbKAhjmaq3QGmXS/12KdsZK3jlBC7uGqjyi24fpJNJyh0rheIM7lJno=
X-Google-Smtp-Source: AGHT+IEPnNFxpsQ6/0LGtCAUXpArXCe+i1x1xSkSu3b8PKwSHkfh/ReWZyvmXlCiQ3qXBkcty/eYLw==
X-Received: by 2002:a5d:5392:0:b0:374:c6b6:c656 with SMTP id ffacd0b85a97d-37ecf066385mr6551876f8f.21.1729494878922;
        Mon, 21 Oct 2024 00:14:38 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b40b:61e8:fa25:f97b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94066sm3525366f8f.71.2024.10.21.00.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 00:14:38 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Kent Gibson <warthog618@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Srikar Dronamraju <srikar@linux.ibm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix remaining rcu_momentary_dyntick_idle() references
Date: Mon, 21 Oct 2024 09:14:37 +0200
Message-ID: <172949485237.6376.15649815993285480384.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925054619.568209-1-srikar@linux.ibm.com>
References: <20240925054619.568209-1-srikar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 25 Sep 2024 11:16:18 +0530, Srikar Dronamraju wrote:
> There is one last reference to rcu_momentary_dyntick_idle() after
> Commit 32a9f26e5e26 ("rcu: Rename rcu_momentary_dyntick_idle() into rcu_momentary_eqs()")
> 
> Rename the same so that we are uniform.
> 
> 

I applied it but changed the subject as it targets the GPIO tree and not
RCU.

[1/1] rcu: Fix remaining rcu_momentary_dyntick_idle() references
      commit: a0b6594e411dcae0cc563f5157cf062e93603388

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


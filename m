Return-Path: <linux-kernel+bounces-418311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7AB9D6043
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF56DB21F6E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D5E2309B7;
	Fri, 22 Nov 2024 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EC4A2+uh"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D25171D2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732285468; cv=none; b=NbgdF1reMroerBSjlaCO+XbcjvRlH6AJNYmKjQehd7D7ogNjWDTcdkXp99mOCfX7Emn/ZauorwzntH//N1km91OJZ2bs1sZLcQv7dzlyxJSIeY0ANVAw8lJB16Wi06ESTfTLpXQG4ULL6ITI8np0Ij88v3OZSbRMQPIVLt+/ttA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732285468; c=relaxed/simple;
	bh=SZrIbYqNJooRI/8mP+lYzjg7Ex28ZYxTZhOjMiHUNPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3WWwNH7R9OXownGoqknHIODGs1R8+V3Y3R5ync/8Y4F9bZcoJ0bQpkm3YSUSHkMiD00zMxZFffKm29AMfBIHI6b7S0gBYPNZtV8lBPKxvevHwb6ot+P3uu+rJIol2E01H3m1ynAEibaglOqpo1worYNAE17/8lVbewolDOWy/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EC4A2+uh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so18774995e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 06:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1732285465; x=1732890265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Nh6Qm3+g7FvP2C/uBSg+5gQrB4CqmwHy+4OBt6kFZI=;
        b=EC4A2+uh64dTIGUT+8QIUvLnOQWEkhXvOFfncLcyFP+Gd8TNZkXX3GKaGy44KJEBEb
         EQvZb0hcASClrxmreGjVvNY9OYqiImQu0c8yxOsQhpQt2tozOYDuYXVj/VEulmmNT9jJ
         BKy4TLc7ane+8sOvuBQol/LDirhw/yE+L7mFnUPolcOSSWda1KZXb8QmbSki9CHETcVx
         kWl8ialId8mXqDhj5zbYDg1f27p/B3uMLWzF/nAjKQLHIG6wpquOY+qfuDvkL6y3ZKWH
         GnAjABsLfWlgQtcKcHIq8DAvfTtcxPlZFkdnXN7WfwFJXOxpvHSPDS5oXRbn5uQeVtyV
         syGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732285465; x=1732890265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Nh6Qm3+g7FvP2C/uBSg+5gQrB4CqmwHy+4OBt6kFZI=;
        b=Xt57WtKbvj7+rWrdQSh+PtT9hFwF7T7LQhOODBRuJcgCKiGTSPEJPUpphLTajk75WZ
         E3mnQXNoAsZM+DTEQtkFmy08y3lUm3Oz2zSpRnPI3VaDQQuUPkQtZxNOimmzFCdaoz8K
         15Z5PACj8a6jnMwO+tOPt017DY6ICInywQpijc569Dv5PYvmOO8AyQLkGHCO59l27Z12
         gjFiS21GNR1Fyu7RNKW2YUL58qg93kdcbiFCEnQJBgEPwQnnkijOE6V/vOoT4uhJyCAb
         2p4lkJugilTtyyHbm45C1PdLm8uAiY509fi6gBg+mk2LBEU0zF4YMfDt1eRZ3H3TyYKW
         mrPw==
X-Forwarded-Encrypted: i=1; AJvYcCUP6MfqyxDr/dQhw/pbHlcRIDVg2RxGd/Ur0QzD/2feq31kWa+yWIqUuNaC/ekbfjkipixUpOe41+QFkEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaidO15jnVs8u+Iu/doLq58DfbgoAOTeBbZr0WrgQREmx/07CT
	BTTZBhvH1mV5ID7/Cu/+fOZn9zWZhonYsEiNMGGzvvzGP6MVoqiRnV0z+fJ1P2E=
X-Gm-Gg: ASbGncsI6Jw+Vj0PrqO9ZP6pYAN987XyH8V80h4P3l4HGnnDsMmsZdn/jlQPfekUs9Y
	hLXjpJWiRKrLf29ohDFtzC+QSoIfprLjLYslwJNF2FqnR2sXRzLfHbRvoBycdhAAc3f93ins5TL
	B4DVXLkJ4+NTXC2OU1zD0Na9UYp4GfgvjDJ080FcT5/3A9dRwUTN0H3yxlxX81xcOIaJITG/rZe
	B979qLRktSyWuwi69+1p6YqGqEYXkP/Qlcqf5IfKdN8kiitnw==
X-Google-Smtp-Source: AGHT+IFIZ2iG2mcVpwd2xQ6e2MRIo00PE7xJ1mgrdA8y0aNVfwo7kWxoPIgftfJ9yBIuyCxe0iV2Mg==
X-Received: by 2002:a05:600c:1f96:b0:430:57f2:bae2 with SMTP id 5b1f17b1804b1-433ce4ab949mr23121145e9.23.1732285465348;
        Fri, 22 Nov 2024 06:24:25 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:1651:6ba4:e8f3:d05f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45d4ce6sm91642195e9.25.2024.11.22.06.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 06:24:24 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH] gpio: mpsse: Remove usage of the deprecated ida_simple_xx() API
Date: Fri, 22 Nov 2024 15:24:23 +0100
Message-ID: <173228543205.96444.5329013618408854886.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2ce706d3242b9d3e4b9c20c0a7d9a8afcf8897ec.1729423829.git.christophe.jaillet@wanadoo.fr>
References: <2ce706d3242b9d3e4b9c20c0a7d9a8afcf8897ec.1729423829.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 22 Nov 2024 13:45:45 +0100, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.
> 
> 

Good point, applied, thanks!

I will send it next week with other fixes I have queued for v6.13-rc1.

[1/1] gpio: mpsse: Remove usage of the deprecated ida_simple_xx() API
      commit: f57c084928661969a337c731cd05e1da97320829

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


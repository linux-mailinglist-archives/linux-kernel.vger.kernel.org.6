Return-Path: <linux-kernel+bounces-398302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02D29BEF46
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5819284867
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CA71F9EA8;
	Wed,  6 Nov 2024 13:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="usW6H5NY"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFAE1DF98F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730900507; cv=none; b=eJiiBg9wk/ojDA/GDc0Ewv/s2Vgmej5cR0oYXkq0OSGMEmilIlM4CtQjv5KOW/isWjv1jQAQoDnUX5j9rYifWIkUNUrD0IzxpB1EI5VKsgoHpZYw2NpMSi5OuDeWdAmmatqEpXOTBGL3y8Y/cuySAtieRi9xDX3PIhE4TstXgFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730900507; c=relaxed/simple;
	bh=tDPpAiA8qq4eYGg5kFCzg79MeqhLAL4jFkMT+y3ROBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ofs51j53ORZD1nqOmym62RLByNIfhYKUVAX4OUwyaug9jfU09eWu4luSoUIzBqQiLgxZYYzrXvvo+vu8j0zOQo5WoonjymeK9iMzBf7Qjig5SGzsqV8MwuFHmjeCzrVEx4eQCeHc7sARMtsyKAyHGUibh8A9kBNaiJTKKMR/7V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=usW6H5NY; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3807dd08cfcso5608150f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 05:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730900504; x=1731505304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgJxednhr3opq3LZItuuNkskAw/GzNLN+52jnrBsQ/U=;
        b=usW6H5NYlgX3E/hmuVTWJNXSd9qedmRxU11MOaHxVui/zvffXVY52aZKcKhVnmuNdW
         dJX0ob7B7oF1aRc+ZIbwiZAJihknkpDq+AvydPH4phrI/qLWznW8dfY53XkFmE7GTgTo
         +oNEvG0gnovMqrsTugm7gV6wXvLWP+CrXVsa1x0+lPrefxchzlF0Beuiva41l/F7o2ZS
         Kvt69IAusCYYJuybfsag5/0FvfeAhOEQABmtogtFblZ2b+QDLRZWOSiy+OpSG/nk0AQC
         KJZ7em/+tn3VmbgBmIVjEISuJz8WvGeIjdfJeJUH6JK+xhVV9kj9gRfCQj6hoZaCjK4O
         xWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730900504; x=1731505304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgJxednhr3opq3LZItuuNkskAw/GzNLN+52jnrBsQ/U=;
        b=Pkw1FAJliA0e6l1bjlG0Sh/Pp+Psgsl8v36C4MZehGin2dJ8+nrJEnaD5HFzcMh/ns
         qw+9IN9oGP/ADGaoXeT2WPFb9J05o70NJoRfnRH7ztXT2fSzmFiIn7utxS0fuGuO4rpn
         y4r4SE1nQRsDA/K1RzFnjf4/DUEC1pm9e/cWI6E5rDeUNe2bFhYp0l1Cl4gm/9jMgUyk
         9xDTz/WiviPZWAIBJ5fF/EEXE6KNp1vFvDRUENrPDH3YK++FFydum9RVbtNjo6Ab5rIP
         E/FdzKIXWIKSv5pRGQ3FamOLpTcLPAx8LCltVEBIYrRFFBEbtTTZFbTM7GtiCw5+vyTf
         xWsA==
X-Forwarded-Encrypted: i=1; AJvYcCXdeXrWI8tB6qV0R7kwMV933KmbxcQFX5sHBkdcnk96Hy8oGk2TKfsUXeb1ndLdeznuGtUbrATdEyLJhTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi96hWd2+5m97wJrPMvonHO15j98In6+9mRH4qZol+e1ovzusf
	9yos+UpVRAs7AodPbrrOJhQSvvyJeklx8aEZBc3ixkYnmDdsJVrnsoBjm/BWeUQ=
X-Google-Smtp-Source: AGHT+IEyaj+1sTsFmFtwwzgISgvluY1k3NLJkFphoe2OvRRtlByJCOZac64u/gC+dzPW7X5Bu9rwjg==
X-Received: by 2002:a5d:64c7:0:b0:37c:d1fb:82f4 with SMTP id ffacd0b85a97d-381c7ac46e7mr21350952f8f.36.1730900503962;
        Wed, 06 Nov 2024 05:41:43 -0800 (PST)
Received: from brgl-uxlite.. ([89.101.134.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c1168afcsm19150857f8f.91.2024.11.06.05.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 05:41:43 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Heiko Stuebner <heiko@sntech.de>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: Use of_property_present() for non-boolean properties
Date: Wed,  6 Nov 2024 14:41:41 +0100
Message-ID: <173090049917.17542.13429958441997211039.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104190628.274717-1-robh@kernel.org>
References: <20241104190628.274717-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 04 Nov 2024 13:06:27 -0600, Rob Herring (Arm) wrote:
> The use of of_property_read_bool() for non-boolean properties is
> deprecated in favor of of_property_present() when testing for property
> presence.
> 
> 

Applied, thanks!

[1/1] gpio: Use of_property_present() for non-boolean properties
      commit: c6789170ddef58d28cfbc3342933713ce1e2c860

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


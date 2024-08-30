Return-Path: <linux-kernel+bounces-308212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC859658BC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5494EB22B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D66B15747C;
	Fri, 30 Aug 2024 07:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H4m3a85/"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC5B152170
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 07:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003501; cv=none; b=fnoCxtHgwxc+DfcH9W9b4nWWeSysf8OQQ3d2+Gy6CjDtT34qtvOunMixd+qPuh1pV0gqAxb4dnh+MJiQQuVy2Dbag7nRPfopJNz6XMuFDqlpiulTtyDzD5MNq0FQwbIM7W8TfTI1BuNyihUpZ6KWzwdbfAso337n9fEutkrRtBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003501; c=relaxed/simple;
	bh=iim98PeFYn3vJGWje/LaVJf43um3zVJgFETR5s97CbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jtd+7Fa8IHUOSqbaqszUvv78smZ1yMSoiKjF8Iumnwc0QxZ0ybMYDKvg1wAeYz8f02QjHBXqTW+5E3lWbj8ImmvPW+U4f740GBed9yOqnC2/j48Scwnw6YvS2oF4g+OTrh6uSb1tBOB41xskZYi2dhY6bLCAR3gqwansk3V7jw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H4m3a85/; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5333b2fbedaso2446015e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 00:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725003498; x=1725608298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iim98PeFYn3vJGWje/LaVJf43um3zVJgFETR5s97CbY=;
        b=H4m3a85/u7BWX52cyDkS66LI5InqmTHHtpz1GwZPMAR8gwNh+7rfq7z6sm7kABoZPU
         ik4jHyeLChNI7RjnZv7FA3QWN5OdncIj+rxzquqqJycOsaimqpScqI+jJfJ2P3WZflp1
         bmFnLmSUiPMs3vuQ8/KK5rnwb0wTVr3yxUjylYMAXJ8NpOjUD5MFSGrnE8JNa8mJjQWx
         spKd+M+mYebxUkj10a6ejmtlL2PavZmCoDMxakZxmxaUpXxtRag9AZGCexrWuhRshq5N
         8X3OfbSFLa5LfzPKnjG7EP1dVQKDnaVod83/fyGm2frY7R01Yz7yL7mHcT7yx7Z/tNW7
         eEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725003498; x=1725608298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iim98PeFYn3vJGWje/LaVJf43um3zVJgFETR5s97CbY=;
        b=Q8oYf9vAlyOcUDGKNtadp80GoLP9Ibt3XXDC3b2s5Z95qGpOzZVDyOA+tvcOQNjI/u
         N1eyKI9YavPT4ged58lm2DXY0nQzU6tC++C/7HMkpzQajY39aaZFCEJeiv24jg4orqc2
         FvmmXE/S92mupHMv9eS50ewGQ7o7JO9vJl263HltE6GWfEgf0/po7EWEOUXno5n/73Kx
         x5Pm920JydGU/uFT2q2N3b627ZqJtDyids/joqlf7mXWSGSmqE7QU5HJYCiquZR7fsuA
         10VtJDL/yp+XIdLRSYnGHELXgu6FrfZQuzFO8t8NjnPH8fT4C2Gg/Sr7yRS5ijmO9jv3
         5UiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLaX58SWw9WZ9yZ6PsMKukkoEZKcqWI+IGh6QTC7/CfZi/iamFxHByG/wSYV84Wg23Ks7Pwom3pXxBtZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfjqJc5AWmF8soCS8WoAYaf4R8YwqG25PYiRWJOf10deHgGm4R
	jgYmSJubH3gp/wZrwfPbPi+fQ9wcrcYk5r+eCcsqW6/9l53ag2+BqEzxUPgcZwRopstBEnQ5Rw9
	yvPkTnkAXHQ2ixodwQB1SLLPIfRy5+sboJ2PKxA==
X-Google-Smtp-Source: AGHT+IHxkixF1ZMKDWkS6k5VuHOdkobn09eGVtFhVdrfJCoaaBQNjgvaFXgDkx6pmJaEBqWJKiLdwrLgg2PPrR/fIJA=
X-Received: by 2002:a05:6512:6c3:b0:533:4591:fbf1 with SMTP id
 2adb3069b0e04-53546b05e20mr895512e87.15.1725003497545; Fri, 30 Aug 2024
 00:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZsV6MNS_tUPPSffJ@google.com> <a2366dcc-908e-41e9-875e-529610682dc1@redhat.com>
 <ZsYu0SEy8ZUKEJqP@google.com> <0923283f-0b7a-4dcf-8d22-b55595b1ba35@redhat.com>
In-Reply-To: <0923283f-0b7a-4dcf-8d22-b55595b1ba35@redhat.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 30 Aug 2024 09:38:05 +0200
Message-ID: <CACRpkdaj73fJxU_8B8wNB_TffADNbFcQs59p9APd-YvPSzOoUg@mail.gmail.com>
Subject: Re: [PATCH] x86/platform/geode: switch GPIO buttons and LEDs to
 software properties
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Gross <mgross@linux.intel.com>, 
	Borislav Petkov <bp@alien8.de>, linux-geode@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 11:46=E2=80=AFAM Hans de Goede <hdegoede@redhat.com=
> wrote:

> Ok. I assume this is part of some bigger plan to remove platform_data
> support from either LEDs and/or the GPIO buttons ?

We want to remove any GPIO numbers from ALL platform data,
because we want them out of the kernel completely.
See drivers/gpio/TODO for details.

The large amount of platform data for LEDs and misc input devices
is indeed the bulk of that problem.

Yours,
Linus Walleij


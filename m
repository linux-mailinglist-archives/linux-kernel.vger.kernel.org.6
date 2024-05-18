Return-Path: <linux-kernel+bounces-182958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA278C923C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 22:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C80F1F218EB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 20:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E4D60DEE;
	Sat, 18 May 2024 20:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NxAvRaw6"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2F048CFC
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 20:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716064605; cv=none; b=RH5FDiNmCky1bVpqm9xK7w4Li40N3KRgF0K5AUjv2rbC6C5Lw+WHEUf86PBBXvKwGXyU/IA8TydKGJGapqDLc+DQGnwLCNufrbi9lU/AbKRNtYwCr1SBAX5n2ecCy8B7u5F3zFDuD7W0YmBgIpzdWogwM/iluA5205mdkmhvfVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716064605; c=relaxed/simple;
	bh=axTlcxEqR5hWie4B2KgVAVfPcFQmVZBZ8j+fzB3XLA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bx6md+/kksqHa0pJ4YvdeVtwcVS+7EMOrMesybbIoq58OaOf0J3RA0FjVy8dOh7KycxzFppEnjCbb2inwy+KEaU+0hFJLh/gT83d/IFzGqgPS1zbYTwfGjCqBWWS7COdm6PV/CkIaiGC4Ywa+945J+NRHZJJ+Dw5cD3xkP1udDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NxAvRaw6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1eb0e08bfd2so42795465ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 13:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716064603; x=1716669403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uYrpYXWxhgivrBCHpRYlsgoARFi6ym7CIXKVYYN00dM=;
        b=NxAvRaw6J4ZcTItRyhOV/WE51I8acFGrx7DkfWw5xb35wQT5zwYDHH/U7jXzYf3HI9
         0Tpx6uDQs30UamL9MW6/xg98UpAkey+4IuGlUc5nJKCQ9aZtVYa5l91L3oJ8eXFy9SWe
         28dcUQK2PyO3jBIMhrHqU5jh2DvybI/bGfWlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716064603; x=1716669403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYrpYXWxhgivrBCHpRYlsgoARFi6ym7CIXKVYYN00dM=;
        b=elrlBI6Ey0JV09f4edqDHISOr/bDikm2B08Tj33zEsVaTvUrh2HB7shoEmdo0zsRkH
         zeqInyDe4Qk8vaw1KbqLhrms3tPExaf0/5x5+W6E2qtRYLRRPiakzITiAEb8fWJ8aEtR
         jyxPMtZ9EfyXabNXfAUHYpZY994i6aX0F87xbMwlcsKH9EcMTvZAOOYLZ8DfFiBgHnTU
         IYM0JDSw6QJ/bLPg9O9XDAmfu7ylvGnMUE+0MyF1jCogLOIJV0RSgOwDfDNG50MpaVrt
         1IUV3Gbz+IHkn1uVPG4AQ6N/0UAhv8BJZYWSi9T8+vPd+GKKDCpylj0gVdUmpKfUYIkl
         +NjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYbhAqGc7QbQSDjskWvp8lIgiZWFDGdr2wg8wKLHAWj6ZHc5lA/V4PalVaDdf65JBquQ12xz5b2KPAXjjVqGu/+jyad6SwVCuVGPTk
X-Gm-Message-State: AOJu0YxsODIIpnvGfB15n/q/b9iBVbqZVBEsE2dHa6LHLCy7RboiYxmP
	PbAyfaqdUKo9WrwzwUivQZal964bB/KN8DBm4egfUHHHL6frTkRWxHnV90amtg==
X-Google-Smtp-Source: AGHT+IEB22jyiK+ER1tYr+UtsGjoCL8OfFoTmIVSUAsFzb1M/rFAkGvWMswdV9f9RPckApvf1uXmcQ==
X-Received: by 2002:a05:6a00:1ac6:b0:6ea:bdbc:614 with SMTP id d2e1a72fcca58-6f4e02b245dmr24104637b3a.13.1716064602761;
        Sat, 18 May 2024 13:36:42 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2aa01dasm17107542b3a.92.2024.05.18.13.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 13:36:42 -0700 (PDT)
Date: Sat, 18 May 2024 13:36:41 -0700
From: Kees Cook <keescook@chromium.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Shuah Khan <shuah@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
	linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] selftests: rtc: rtctest: Do not open-code
 TEST_HARNESS_MAIN
Message-ID: <202405181335.00B6D2F@keescook>
References: <20240518001655.work.053-kees@kernel.org>
 <20240518202354d5422c77@mail.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240518202354d5422c77@mail.local>

On Sat, May 18, 2024 at 10:23:54PM +0200, Alexandre Belloni wrote:
> On 17/05/2024 17:16:58-0700, Kees Cook wrote:
> > Argument processing is specific to the test harness code. Any optional
> > information needs to be passed via environment variables. Move alternate
> > path to the RTC_DEV environment variable. Also do not open-code
> > TEST_HARNESS_MAIN because its definition may change.
> 
> Th main issue doing that is that this breaks the main use case of
> rtctest as /dev/rtc1 is usually the main target for those tests. Having
> the RTC_DEV environment variable only documented n this commit message
> is definitively not enough, I'm going to have to handle zillion of
> complaints that this is not working anymore.

Hm, maybe switch the default to /dev/rtc1? Maybe there's a better way to
integrate arguments into a test runner. Right now the core harness code
is doing the argument parsing...

-- 
Kees Cook


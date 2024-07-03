Return-Path: <linux-kernel+bounces-238950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674729253CA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9977B1C252D9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868ED13210B;
	Wed,  3 Jul 2024 06:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xI/6RlKa"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1336313213B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 06:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719988780; cv=none; b=k/TPLQrUF8JTVt32ySm2Lo/CO1G3YQsQ0qb+cOdOdVS/F+O71g4ZvDG6PUXptTffk2MDhztHTcWi98w8jMrSM5UYmiDQ933g1FNgjqrHOhK97g16ULTaOJWvCQmsBzbyaHmTKm6Jbj1LcgzQ77Avo/lAHiAH0pmPEgxvMO3qyig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719988780; c=relaxed/simple;
	bh=2gfJcP+dPdB8Ll2+BGwToOilKKAE5E2Ikpq/CZOFF+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mOPm1zbsCREQZTmoP+BxF1W8LlDhOgPwfvAJlL4ondbhD3DdtVTifNpjMMr8Ao1EvQIOcB0sIAFvWrhj3jYrb4Ccq5Zg0cB2oXrIv0lXfWcy2S0uJPTK9gs7+/Ehdu6p4AqKVYlL6fic0iROAG8FBgBPhs/U4iiqM6bb3CXyHZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xI/6RlKa; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52ce6c8db7bso7741651e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 23:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719988777; x=1720593577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gfJcP+dPdB8Ll2+BGwToOilKKAE5E2Ikpq/CZOFF+Q=;
        b=xI/6RlKaYz5tVsdTz/fuXKnHhRs0f/SUvnte34B7w1WIbzfVRho2oLHcsaYu1M4vRW
         Tn3siMniupBYIgHjTLeN81hyWMoAOjpNxHRvmCjNxx1ipnGC5Ia7o6sRwcyFgd60Xn5M
         cFXxK5QpuYI4ufGw5EsS7f9gu4z9R778xVWOZh/QnBDDT+B6s0qK+8F3bVizqd0K9gPZ
         ySixqHO+wNgTKQBWEvTYKO7YGiKOlOtt4Pz4gnSPDC8f+VRrvxRi1qOcN5eXbX2EaHoP
         fJgRmmkOd6Ak9e8VOZu16b371nlSuIag8YzB8/EdIuDI0aXTFwcmMwqZ8oI9hjL5+5ab
         He1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719988777; x=1720593577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gfJcP+dPdB8Ll2+BGwToOilKKAE5E2Ikpq/CZOFF+Q=;
        b=poay5g8DkOkO4xi7BPn5DmJkHSoNHeOof2EKlu5ofmen/XfkgRkSEiz5TKCHXPncLq
         KQHRKHt9eX5FDu2UhkziPEeUuCV5+3wI7hIxG0KzMKF8I82oCp8buWY4MWAawuAa8l06
         PG3NOZw/SplSp+fX9K7tXtVVJ92pMrr7HDPkbjglm6UvxX3dEm0qfsB5ySqc8Yl+5wHN
         m6lJJ57V/C7USdjF/Y9McxJLAycNGrXKJoLiFdpdIRBZedrEAAcv39/rqLpKKlpP0t7f
         dijdTMPu2CMGrP3ZBspoHI6IUXd0o8vQHqNAzbnPH+s4Aj7eutzkIyQc5JjoQfxXjXRt
         lbug==
X-Forwarded-Encrypted: i=1; AJvYcCXFNngSMiYHGcvMSBymvUkJ5W+tz8NlaldVf1L8G36Dxzhk69nLmRcAuyeaJ9mpYUx4VPS+GbrknjmJDgeB1br2lkYtS7zgJLgQ4vJg
X-Gm-Message-State: AOJu0Yyr2Gv0Hh97mcgL/ywHY7IKYqjBYwpBjwjUsCyagihPd/qKDwyk
	GyB/X3UJPyQ3fZP/nC5rsp4HAC7PLSd3Yh84IZZ48+Ib5S91m/VFWF+cioQrJSnC5NO16JzZyn1
	PQdJe7VCYsGukELQgaX/qURLRAFh5WKCxTuW7qg==
X-Google-Smtp-Source: AGHT+IHU9DUx6SzBnuSCLTwk5I/hgKcSP3g1gias5lVbToL50BaDFFU6mIr8rhEcT8TXJ5tdUX9Gl+FsVBvHtHEo4a8=
X-Received: by 2002:a05:6512:3b88:b0:52c:7f42:32c9 with SMTP id
 2adb3069b0e04-52e82752b89mr6919968e87.67.1719988777074; Tue, 02 Jul 2024
 23:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZoNAWoJ12DyApZ1s@google.com>
In-Reply-To: <ZoNAWoJ12DyApZ1s@google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 3 Jul 2024 08:39:25 +0200
Message-ID: <CACRpkdbS8MDTZLwzM+OFso0-dYg6SwN1NV-tqPdD32HGs3o6qQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Alchemy: switch to use software nodes for GPIOs
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Arnd Bergmann <arnd@arndb.de>, 
	Martin Schiller <ms@dev.tdt.de>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 1:48=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Switch to use software nodes/properties to describe GPIOs for the
> ADS7846 touchscreen and the SPI controller (away from using GPIO lookup
> tables). This allows removing use of ADS7846 platform data, which will
> be going away.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>
> Compiled only, as I do not have access to the hardware. However I would
> very much like to get rid of ads7846_platform_data from the
> kernel/ads7846 driver, and this is one of the last 3 users of it.

I agree. The years of working on device properties is finally
starting to pay off!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


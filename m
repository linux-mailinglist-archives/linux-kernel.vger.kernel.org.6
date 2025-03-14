Return-Path: <linux-kernel+bounces-561156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFB2A60E23
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8DC1B60719
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8011F3B92;
	Fri, 14 Mar 2025 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KYruhNyP"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8111F239B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946565; cv=none; b=cfhgLHK3rokrpx+9rjoJNDycC7aXAD9494aC4Evmuk/BptzNeoCxEni6HDFhqlgpyOBPkLLfRCM/FXX2blk1zEzd6r2IFwnzsSRDz5iMiwR8fwCDNvDCMsxOVhLM71apoSkcRqyzlPJ25O6poENJmk+ZioKPS+uUTLbQROkjciY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946565; c=relaxed/simple;
	bh=KgDGPJH/f2nB2c+Evt/o3RF6NVVH+v37aRKEs7m2bog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VLodn2j6K3cPzfKwl8T8JJ0X+iR8+vQcpM+31fEwgpJrYikEBiJZCdM0dft92yHqIl+4akFaoJUPcFjp2RJTu+2vSEqCgj2Q+2mAYSjUTIu9JAJDUyNV3N6IKAtEczpxSILQNSe/6E3SuL7S1zoiQaRvKKHJYAURAx8VK7mNE5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KYruhNyP; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54954fa61c9so2342452e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741946562; x=1742551362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgDGPJH/f2nB2c+Evt/o3RF6NVVH+v37aRKEs7m2bog=;
        b=KYruhNyPaKwtRLVdPnqf+Ie6TyzqwTQo4N2HTgolXedNUBOxIfmaUjSniS62uHIYco
         fNNvobB60kPuTx4d7M6xAqTOqsGb9WJ99v9p0wMIk8DmEpAlNly09XZDKyKF5B1N5pG8
         7xkxwQcWNpjtiQYLoFaaTjGi4nzKHueYS6S4TSnQEIf1oCpay2deW8h3KKhbNLKGadK7
         ZUmQAnCT0MaHAyFNGIg4rwR7pHFeLkoy/xbLjN697nwY6k5VB+5eR0QpexikvFTu4D6L
         1tIeUxH0Qt1phTrn4n7YbSRRBteXIHHMS1Yg0aSIp6MP0Hkk+OpqyS4o8yDTtdRsu8hD
         SYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741946562; x=1742551362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgDGPJH/f2nB2c+Evt/o3RF6NVVH+v37aRKEs7m2bog=;
        b=PndLJKd4gzrB/ZpwTKKXJdPzzwnqwa1rbhwnfhC67ggz2smNdD6oik/wmU5ltmvYOW
         tTqs8tYl6AGhimep07UUQGSCDlCkUIO4Kfw6FMDtsFKGp/gP04SzQCtLcwetj0VWMZmb
         FlyqKSHE+OLwGHHih4sLaZTM0mzuI5qp1owX9e0gKIddoR6pBui5Uu7ObY5deXqE1L49
         ZM+gf9KRZnVjprMuUjlb3TK5o4S6RaBmGNVnADQ1piGLxI6uk/AHSZxVZi1gDhWW4Png
         hOenv8fux4nd8N3j5d2WdbiBAb3OTHqKzK1dY6wK7IrYGTaUOg77hmdi8HIjnqb6HzH7
         GjFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYhLFM1LTHMWfKC9VjVX9fhvo7qnqk7xpATvfKCemEL1OxeFIjb10+ffNMqNq5JAqwe+WQzUddPrScF8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz36z+p/bhOkVg0uxBvdEt8ZmWljctmMChDPodQnbNvUA3mMF7W
	FDYR/SJLqqocu5RVFeNIywg2no7fhGiOaDoEZRYEdXYTZ0Y1tOiNmIgkY89iFJAqXGBCC2Qj6JN
	5RqZ8t5/g3Uhz956PzxLVu/6Ke24bpXAiEVdw5A==
X-Gm-Gg: ASbGncutSEXBdPrF4B0/mAQwHx7DNVT5Yyprqodto5Bv8Ds7MLQI+BRM9ktEi/WNIEx
	7vhWYpcQDCQLcFx8wY+EHzHIJe0hSWpRwcXkPXZQ1vo4N6QtvLgnwf+5u2ppsPmlehb8OEtqbwZ
	M5SmitV0LJMF0BTswO6uSiquk=
X-Google-Smtp-Source: AGHT+IEEU7fjMObFqi/KtorNaUacAgpVCp1R7kdy9gSMkZkxP5Vzr2YrX/ekX9hw0P90QrGqnfIHas94yzAS0vLKMiQ=
X-Received: by 2002:a05:6512:2823:b0:545:5a5:b69f with SMTP id
 2adb3069b0e04-549c38f542bmr532360e87.9.1741946562016; Fri, 14 Mar 2025
 03:02:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305102710.52762-1-brgl@bgdev.pl>
In-Reply-To: <20250305102710.52762-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Mar 2025 11:02:30 +0100
X-Gm-Features: AQ5f1JoBxpl_Z6DDGsIcNQamKwhe2gdhb1zrS5tCM67ikkg1OHhuzYaOr8bu7bg
Message-ID: <CACRpkdYOVoLBwd6N9xSSjufguXzN+9y-Et2uDAQDjYvXyJftCA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: spacemit: destroy mutex at driver detach
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Yixun Lan <dlan@gentoo.org>, linux-gpio@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 11:27=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The mutex initialized in probe() is never cleaned up. Use
> devm_mutex_init() to destroy it automatically.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Patch applied!

Yours,
Linus Walleij


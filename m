Return-Path: <linux-kernel+bounces-347552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F9298D46D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A40CB20BB0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82A11D0426;
	Wed,  2 Oct 2024 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QhxxVNGH"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDFC1D041B
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875212; cv=none; b=PoDYA8l9ZcDFFmu93wbGkWpGCaiOkT+wE7KGqUTlFAbP1U+d5uab7Xg3ogk2G48EGnG2c7Wh0kWS0BTOLJz2aj0h14/+9fPaVNb1SqYauEfFsOWMf8OHupZ8GZg5j11bFuFayKl18MbVY1EZ4r08GJYKmmB11amNTrI+JAGQOYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875212; c=relaxed/simple;
	bh=/TS3YtOgDIq9KFdYt7+NiJ3dYC9S+WgkbDlinQz4MMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mEGq6jgi4YpBOltzdAMKi146QV3By7tJ6baYfclVPP0/B6pBidRNM9ySPeZ/CPEtKvGVFjeF2rwnhgSIJqfFOGfn4KLPkZV4sHAFX1zKIGmIohTwskOdepO5x43iYIZxhMdNlOE+q4lABpUUoXBR77SjMbXXkUZDoibm5/MEG3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QhxxVNGH; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e04196b7603so5969733276.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 06:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727875209; x=1728480009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TS3YtOgDIq9KFdYt7+NiJ3dYC9S+WgkbDlinQz4MMw=;
        b=QhxxVNGH/cnyKBxgk3HJ9+CtUsccZxNIL1vW6mkpeGlHfah82dlSffJ0zC8QgLTwhr
         v0rrBj1EH2YUQS9yTvqZ1mLZnCRzZKOPlbZ58Mj8S/nGuXL0D4DNHA0Nsj7fTGoeg0aj
         s/XyUimY4PpifpOEaG+uiHOJipVi7Zo1qjviPkqh1IO66N2JPN6L9odSXCigCaQmfXYj
         pTDCN0og1S78UfONpmW0dmgdbVzNDKindktUx/qIHYd9vfhnjeh1vTig5kKhs/kqVWIO
         x/YEiAPWO6Z6XhSe6DEnkw8NXNeaqlvK6DTHF8PeyDT3Wea7Ah3zBxQbXQl8NpqJV67L
         5tqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727875209; x=1728480009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TS3YtOgDIq9KFdYt7+NiJ3dYC9S+WgkbDlinQz4MMw=;
        b=ny7u0pFiEhQlwNXymifpi8RXSzVYW+xxH+7tYyMWnB7ehH7DFuYQ0dhWQOz9kx8YvT
         km8Zx/kVmgYbSSyZLM3DF6hJ8MT1ODM/lvYcx5uftlX6Mjt9ux4OTQYjC727rFudTVvY
         blMPe4RexVkcmdCPh0zieEipKCBcRgj6STuPxlcz2IDnNV9vERq2gL9Ta14i5FgiFmAj
         41dYl3bubaOCZySI6+4IaQk/pMzU9TW60TeklMz7RrxJOofOTtmmfXnSooLGMB046b7S
         utibdv+S7o6rmnuiaE/IRaJodzlb+2qEQD4AcY+o+CHElpKOL7M4wwj9xDX5O6aW8RxZ
         9Vwg==
X-Forwarded-Encrypted: i=1; AJvYcCVSbetnqTLD5YfK5Kt2LHrSt4rqk8AjJ0WCWpOPET2alaxMbVdMIm4CfPSRFONyrHadwPv3RzJivp0JD2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGAbZ1ysdy/rwH3f6O7F9CF7cuZSLvcP6nm/FONE3ncKIAORo0
	GVy3npX208ta6euw+94SVN1bJKwllyqFg9SFdmdvIJlGJZxRzSoWxAKoKRoNTC6/SCxwAAXtBb9
	4XCN0jAKSa6H5rATtXilcQYchkTO+yY/RDbbQ4Q==
X-Google-Smtp-Source: AGHT+IHEsHmLtoCSsgtwLqvuMmB1LO+BOb0QgvZi4zTxGYHrgj0s6Wseutqk0ZF/zGjWl45Ta+ftNfwhqf/dwT0NUtg=
X-Received: by 2002:a05:6902:100b:b0:e1d:94a7:4633 with SMTP id
 3f1490d57ef6-e26383bc915mr2466860276.22.1727875209707; Wed, 02 Oct 2024
 06:20:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930144804.75068-1-brgl@bgdev.pl> <20240930144804.75068-2-brgl@bgdev.pl>
In-Reply-To: <20240930144804.75068-2-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 Oct 2024 15:19:56 +0200
Message-ID: <CACRpkdYrRzg21Uc6FaZhXhqoAhYaYy4A0zqVVFz1es=CbXUi7Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: xilinx: use helper variable to store the
 address of pdev->dev
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Srinivas Neeli <srinivas.neeli@amd.com>, 
	Michal Simek <michal.simek@amd.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 4:48=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> For better readability don't repeatedly dereference pdev->dev but
> instead store the address of the embedded struct device in a local
> variable in probe().
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


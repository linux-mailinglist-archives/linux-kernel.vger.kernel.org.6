Return-Path: <linux-kernel+bounces-310852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40759968205
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB835281ECC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14821865F2;
	Mon,  2 Sep 2024 08:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jYOjl+0A"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB6B161310
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266034; cv=none; b=DW48EY+8KtcESCV4SJhrTabcrUbfzlfKMCmGZwpDZyMF0EYGL+0WnK55WdPMXPINFwiiExDAeKzzeo/v3Ch+gf7UKiK6eLq0gLYEwq5+WB8xUYGQE4v4uuhJZ7pMvcZB1ZW6DiBOG7fHqtM964W9Rv14hO/UZ3wbOfbI6AMs24E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266034; c=relaxed/simple;
	bh=zrv086Fdv9w35daxdi6hHW2giaN+qyNFa21Z0q4DoZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F41tdjB8zoxB0Dy9mk2hCZ9SoftW43VZWmaIj3pWK6MjNmak32OWy63yCboFhXkAImBe8Ho+kOI/n+ksoc78tgaJmaRCxGcNIf2gwLm9hE6UTT8QJKNYsthX25mvi17jVYp5mIyL4ubhU4MN0wrTu9HlB/0hufdmKOFkydVX7Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jYOjl+0A; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5334b0e1a8eso5182949e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725266031; x=1725870831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goZxaS9ZQb5+JNlLUTZNbTEFCx+Y5sRzY+bt3xQbfq8=;
        b=jYOjl+0AcPqri4YkwLEYNf6WxPMylAw/SUhWSkk6jJEiaXeBGDzs8bT3wtRAjLsGaZ
         2DksmifeiG9dfc/fRRuMMgZ1D6u/Qsc6En2AtUw+onzkMdNGJ4I2sDNfRS5wF2xqFHW2
         A+/84UdxjHj3DtNEcBHM84l+rp+5ZlNGt9OItWsMtzV2PtS96VRjjeOgLJVrflccPXdf
         JbsieIwJHbZ7Oyihgk/TGrvwfgJG2DyVniqomFXrtGrk12kHtXaPG46xee9OIxCJqWe7
         8iFv2crS5cN4P22OCftYdiTxqwKl0Df3RSJYhFj513qvQdWsNjI5Gn95JSk1NuRcgxiF
         It8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725266031; x=1725870831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goZxaS9ZQb5+JNlLUTZNbTEFCx+Y5sRzY+bt3xQbfq8=;
        b=k6DTcmSdL28pfDPyHIIZY+w1g6+rLdta5n1IZyBsaOCv/vuIrfirPQ4hwkQslzglrv
         xu4KSVpxLM0XDB9NiLdCSBi8apvg2n3b5Sghe6WZdBnCmciTufqx/PmXoAr8g3E0CjN1
         wfyBrJfpIJOCEjsmNhIcZqzlpmqwbslbsUYc0xIgMvRB0m/6HgQhklEzs6637wkvVyi/
         +QmBjP8ZK7wWTBXAHy72SZhg6/jZmSuTpYflaFC2xN9j/3YgEOBWb4GAYtrcOldCfl8t
         WJz1B7DzltOGFbaDqCPck+sUca+saU0kJmZmxMQm0iUQTzZk4EsntBFWjJxUNtIozPpc
         FpoA==
X-Forwarded-Encrypted: i=1; AJvYcCVDHtyXG94OXKS6g2a4AQ1C+ci5nhGWJKGq7LdkU9BwiMIbN6wN54eoM8dm2Yljqpoz1xapQFPlwPsxeMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdiHUDkV3f5wlkoJZ4MRPzvX+1nyKQtyrD68giiF9infiEC5br
	cIEwi94uZ0XJaimEmZQ+ZALaLV2eoiLvq4vSvcXOtvOeg/NEpnzktLlhCyAGa1LifmrCnld8hvl
	0lZp/XiKCds72K1R4ccm9Yi/VZ3pnuRFqRjIxa8K8edGZzHZj
X-Google-Smtp-Source: AGHT+IFKRDHwzB9Quu4PF58ILc2a/dguARhk2kJwxG3I8e6vD/m0GzTIkGdk+QIAGoeC6Hg1Qc9gjF6NjrTW5KKvYuM=
X-Received: by 2002:a05:6512:3f26:b0:52c:df3d:4e9d with SMTP id
 2adb3069b0e04-53546b8d6bfmr6080640e87.37.1725266030043; Mon, 02 Sep 2024
 01:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805-clk-new-helper-v2-0-e5fdd1e1d729@linaro.org>
In-Reply-To: <20240805-clk-new-helper-v2-0-e5fdd1e1d729@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 2 Sep 2024 10:33:38 +0200
Message-ID: <CAMRc=MdVRdy7tBcx0RiQG8uGf9gDzGTRL7XrXDtOkDxss4et4A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] clk: implement a new managed helper and add first user
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 10:57=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> I'm posting this as RFC to see if there's any interest. I noticed that
> some drivers do: clk_get() -> clk_set_rate() -> clk_prepare_enable(). I
> was wondering if it's worth factoring this out into dedicated helpers.
>
> This series adds a new such helper for the "optional-enabled" use-case
> and the first user. Let me know if this makes sense.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> Changes in v2:
> - s/EXPORT_SYMBOL/EXPORT_SYMBOL_GPL/
> - add a stub for !COMMON_CLK
> - Link to v1: https://lore.kernel.org/r/20240801-clk-new-helper-v1-0-81e9=
338b7b17@linaro.org
>
> ---
> Bartosz Golaszewski (2):
>       clk: provide devm_clk_get_optional_enabled_with_rate()
>       Bluetooth: hci_qca: use devm_clk_get_optional_enabled_with_rate()
>
>  drivers/bluetooth/hci_qca.c | 24 ++----------------------
>  drivers/clk/clk-devres.c    | 28 ++++++++++++++++++++++++++++
>  include/linux/clk.h         | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 63 insertions(+), 22 deletions(-)
> ---
> base-commit: d6dbc9f56c3a70e915625b6f1887882c23dc5c91
> change-id: 20240801-clk-new-helper-7853f662cda1
>
> Best regards,
> --
> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>

It's been a month. Any comments on this?

Bart


Return-Path: <linux-kernel+bounces-366385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E3E99F494
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656B51F22FCD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D7F1FAF1B;
	Tue, 15 Oct 2024 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KzwVth51"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1B21FAEFF
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015144; cv=none; b=GXz++MVimk47jF0a+nEwa6rcAFHyHq5H/rpTUUxAZtHA0yIquH8OLvMuNFF71GKTXmlS9iK71cxfz9WQQE3jUIME6AZrDpDNNUy4dmPto4k28V0o86rDd+CrZ4Ul5lglUrqL/a+ER3WTko86q7t2kVHUpzbfoVOuDubB1PcuNdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015144; c=relaxed/simple;
	bh=d+ea8ccZvUXgrS7wSLnvXQm/IOSNZR9uPNXAF5KAZsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tU+Wn7ogL9hi1QcWMo44kZues79umy0D7jERWe9R+68uX5GuvNhItj70AQLpwW2XM7TmO2FXSDyG9o+dXUAPSH/UY5W6oUvyHLdYV9xYlkcqqmSXGEINAqhWeMKDBm8IwS8mGhE+NrYlApdi1WD2sdOOQXWHHH+K1qofAavwBi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KzwVth51; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539f2b95775so3272390e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729015140; x=1729619940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+ea8ccZvUXgrS7wSLnvXQm/IOSNZR9uPNXAF5KAZsk=;
        b=KzwVth51Sxy/l4Z+qzzQsabdaA7hTwk6TxVEBKjBFYxc0KzwT/cYK9c/2jcvfmf9ce
         mO3rroUCsCrY8QG7YyCa5k9Wc9PsUU8KM6Xo8fpwqQvuIx3W5tgmPO44R+L4L5jDABvi
         38nI7jLnJime/8mf90JftUTv4H9/efIcDZ/6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729015140; x=1729619940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+ea8ccZvUXgrS7wSLnvXQm/IOSNZR9uPNXAF5KAZsk=;
        b=TlJOs44NpKkn7ioyS82h133HZEk7WX+H/2SuJY1KKSEyfT/vLHvdYMW2Rtq99dvlwW
         GnQPGknCJkNsd19czpinZBAeHeD5fDFKFUWDF8z1TPuT14GyakoYsLgp9bVo/doNxL3F
         A84gCpiIPWtPnpr8VhO0I3/Tin/teDTR/uXDuGPEtNuFcXty2RFLFA/t3/t0od1JBQ1a
         MqQuSwlylj9I8PQywv7RKtB+erZSnXiMaFVlmWV2qlSu4XxCSgyG2FGHRK4FUK+25IeJ
         JcMI29a9yquEiqVOE6llLZIlXC9rnTW16LLfjPNtaMsae5Z1H1AEyaTXEtYz13wTy68l
         v88w==
X-Forwarded-Encrypted: i=1; AJvYcCUDb3UZnkoQQsAnjNYUtq657irnEygxnXUm8m2PK2iBHMX1Fevhr5+ZPP8ejrNhFeC7pOy4lXgbSC8CkDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytjj4VypChwL0FzksjZx/zR32dFh4r0L5lj4Rd0QIFJZX27ClJ
	DbsalNvwxNOdUOIYI0LTK/5TmQg/gsTIyW4jVP8Xn21SMtf/a9ocI0CQ3m/9QPxZaynscDQLkQx
	Yfa1/
X-Google-Smtp-Source: AGHT+IG7AJw+61o68Q5vBxNqbMZIK62Bo3FbiSAVThdeX//8Z15jN1WbFGmBbHTI1QifoLpuEXBm0Q==
X-Received: by 2002:ac2:4c46:0:b0:533:483f:9562 with SMTP id 2adb3069b0e04-539e571d3c4mr9073744e87.42.1729015139533;
        Tue, 15 Oct 2024 10:58:59 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539fffb1ebesm225668e87.105.2024.10.15.10.58.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 10:58:58 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e1543ab8so6722043e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:58:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV65gMOyIHyswuaNuJZ7lJuRl+/BBBPNSD0Y2XpDQBhG6VPvVAWwPanCtJL69X16qqQD+s5Avako/DZqrs=@vger.kernel.org
X-Received: by 2002:a05:6512:3e01:b0:539:df2f:e114 with SMTP id
 2adb3069b0e04-539e571c9femr7438846e87.45.1729015137476; Tue, 15 Oct 2024
 10:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008073430.3992087-1-wenst@chromium.org> <20241008073430.3992087-6-wenst@chromium.org>
In-Reply-To: <20241008073430.3992087-6-wenst@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 15 Oct 2024 10:58:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vs2bekyqBN_Lro_u32Dg9WM-bjDZr_tx-KyYH_toabVg@mail.gmail.com>
Message-ID: <CAD=FV=Vs2bekyqBN_Lro_u32Dg9WM-bjDZr_tx-KyYH_toabVg@mail.gmail.com>
Subject: Re: [PATCH v8 5/8] i2c: of-prober: Add simple helpers for regulator support
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wolfram Sang <wsa@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 8, 2024 at 12:35=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> +/**
> + * i2c_of_probe_simple_cleanup - Clean up and release resources for I2C =
OF prober simple helpers
> + * @dev: Pointer to the &struct device of the caller, only used for dev_=
printk() messages
> + * @data: Pointer to &struct i2c_of_probe_simple_ctx helper context.
> + *
> + * * If a regulator supply was found, disable that regulator and release=
 it.

nit: was the double "*" starting the line above intentional?

Other than the nit, this looks good to me:

Reviewed-by: Douglas Anderson <dianders@chromium.org>


Return-Path: <linux-kernel+bounces-244140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F68929FAB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002411C21C06
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9F87346F;
	Mon,  8 Jul 2024 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tx/Eu68I"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2F953362
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720432570; cv=none; b=HGUiHjT9/VpResSqHVhDlbr4HOPjZyntI8KHMqUr2XaS61UqHDHcsS1XEIKcq2TueFIdFBo3JQQompllLzoFR53yrYvmUzvVYns5sQhg1kaPF/ceMLwe3y9yggqgGoUiW0HSFR7QdnOSi0TX3MxAsDUM9/mdluqwmJRj8VYeFvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720432570; c=relaxed/simple;
	bh=mLp3WBFRwG6lcPVCDP82jgIllOcTXUaIOucccBoUcjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYfb0upj628uve9rE3c+rxCpcfveZvSN43Xd93lgHR7xuYzVHTTuJKXJieyWaqnUH4xzYXZSd12Rzp7T5uiHWk11A+LdmpEWga0DL/LQiJDPD7vbbmfJBNNFT/zzwq8GUg0ZZoeDXmmWiiMCiRp6lPlbDf3subx6X9QxVrj1cYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tx/Eu68I; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-64789495923so29726067b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 02:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720432568; x=1721037368; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jzask05GQU8+vHRdoPweB0hXQfqpLpGhajhE6Nvpc0w=;
        b=tx/Eu68I1OGK5mQEAlvkzM9bANkmt22ZWAheYkevjgBzne+VqO3ltckvV4+7J7YVYw
         J3yc5/mSYYqeOhyh9wtwQzVamdNjTdUSbjEmDWo+kolr3JIQ3XQCPJDicls5IP0ykADc
         wR7IRT1mJH7vfcgDDUrSfeva+d3FGK9+5aepADJAkxQFMUkb3DjsVJ4SFdvdB5UkMo7k
         0Ax2fssTggtKvZVHnFw+giUE7yrDvTXsBqncBrkZXEvA/ZnGFlmNn0vj4yii5r9sxLDo
         nF52/Eb9W4GyLSR34AEw1ess3Iv8UcVis4F+YOBlEv/BzcziJ/RGkrCO9/+Dcy6mXQ/k
         DR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720432568; x=1721037368;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jzask05GQU8+vHRdoPweB0hXQfqpLpGhajhE6Nvpc0w=;
        b=QUg1MOb+zNBsm/H3xYM9tQ3acnTDh1otUVHbDqT3cENbpqmQGgT/drSsAmaIDG/WDm
         GKNVdrkuz4cCr91ONMI+dkvodvQqlNIFsdc4RITKu6THYJzDEF4ZSfekv2KhS+mgC/u4
         U1AgPWh5nIjFfL/FqoVyQdmzdFfbeT0VloMY4VYETMvKw7Q0OpLNCfW/+FJzBQKs23Aq
         +TYGn88S4y6SajXCBIcTAisMoQcuobSMp9AXxdWS1kKJZBke4wWShx8LPlnBF54OVBlO
         WmEdL/CORfeQVub2fVDGhPdXrpcs9lxk3SDs5l+JCm3eMumX/X1j8ziyY4rtsL6yuuVF
         G2bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBa8fAfdWo+OWN51Oni+jk52hwq1UZedEHXa14e6Ej0tcpMjT53MbjvXAxk6IbG3VBpXWRdP3rUSk2fI7bL3JXjaBguo6v8KUj3eCt
X-Gm-Message-State: AOJu0YxRNrDY4WwOazNekgGuEpKKFtXj32dYZJOggJ2yaHYEQ1kHTjCV
	dQV4SmuZ0/KC5bfPHNdVJA/C0pJpOR1yj4sUoTs5wjAKiVL3KHADZOmCVdoQCZDWa+jQV9Z9Hk2
	5kUGvTobvlUEZy08AoKYaIe9gxH9rJIp5n93Wxg==
X-Google-Smtp-Source: AGHT+IFjoQwu9LtRrNfNBaFbkc9SMl6CbmKGiqSj2aiwjk0wpQu4CIFn3QaaaSqZApTI7iBXbh6+zrGgoFtAav+hDMA=
X-Received: by 2002:a81:ad17:0:b0:650:9d94:7982 with SMTP id
 00721157ae682-652d7e4b048mr125673257b3.46.1720432568114; Mon, 08 Jul 2024
 02:56:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240707183829.41519-1-spasswolf@web.de> <172043242741.96960.2619738362693641818.b4-ty@linaro.org>
In-Reply-To: <172043242741.96960.2619738362693641818.b4-ty@linaro.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 8 Jul 2024 11:55:57 +0200
Message-ID: <CACMJSetUL3E4k_h6rUziRiDZCFhFk59D9EXNSoE=WLkA5ELuVw@mail.gmail.com>
Subject: Re: [PATCH v2] pci: bus: only call of_platform_populate() if
 CONFIG_OF is enabled
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bert Karwatzki <spasswolf@web.de>, caleb.connolly@linaro.org, bhelgaas@google.com, 
	amit.pundir@linaro.org, neil.armstrong@linaro.org, 
	Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jul 2024 at 11:54, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
>
> On Sun, 07 Jul 2024 20:38:28 +0200, Bert Karwatzki wrote:
> > If of_platform_populate() is called when CONFIG_OF is not defined this
> > leads to spurious error messages of the following type:
> >  pci 0000:00:01.1: failed to populate child OF nodes (-19)
> >  pci 0000:00:02.1: failed to populate child OF nodes (-19)
> >
> > Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF nodes of the port node")
> >
> > [...]
>
> Applied, thanks!
>
> [1/1] pci: bus: only call of_platform_populate() if CONFIG_OF is enabled
>       (no commit info)
>

The commit is here[1], not sure why b4 didn't pick it up.

Bart

[1] https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git/commit/?h=pwrseq/for-next&id=10a0e6c2a8fc0d4b7e8e684654e920ea55527f3b

> Best regards,
> --
> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


Return-Path: <linux-kernel+bounces-264470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 561DE93E3AF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 08:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5A7281E2D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 06:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E968C07;
	Sun, 28 Jul 2024 06:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbeN5Hy0"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769E4F9F8;
	Sun, 28 Jul 2024 06:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722146702; cv=none; b=fzsSpa96eqxYQLDK254Sc4yqAWtdu4AdH3dLChLY8O2125xhp8kCxfU3F7tz7m6NfYJAQaVf8CN4hx7Q/Jg9hQQ1Tw9BDk6+3m15VuLwo4a7zp1m8g22oYReTotqwYoL8SBaXXk/JTNV44DDyiAmY3J6vZPjz0FfFHthoxCWVn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722146702; c=relaxed/simple;
	bh=u2zfcZwYG3kul58agQUX3yzpubFbACd2Ih5AzOdGpIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5nwUnTVk4jMO5gr8GeUuaIOoRdJssr2MqJBOSZfKDg47ll+I8oiZqK0bENRoldaR8HZ+zEEI8WJVJ2ZCN14zGmXZXNCSzJntGSFFqvxwH219Kiq3gom7znqGuTkQArrbGBk1K8dNR8jEe/fKSNTwxnUtNegZfQaI5bgbLWF/pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbeN5Hy0; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5c6661bca43so1491965eaf.0;
        Sat, 27 Jul 2024 23:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722146699; x=1722751499; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u2zfcZwYG3kul58agQUX3yzpubFbACd2Ih5AzOdGpIg=;
        b=XbeN5Hy0tlRSkKrr8n/vooHCzg+5+RnkrIdrUUxGxHPNR84ZVgAKPQ8demCY0QvPTI
         5hDY2kW5xQP5jGdWmKyUk6Hld8yEVeDhS26huoTlRqstSSEelUw3w3CVcapiJ78hG9Gc
         ze23EdpJWzJLE9Dt0P/FChkfcrdtw/Vtm7cJQV6BYklS6hRjG2VVkY+Ghb9Fa4N67AS1
         EZ2F+Y2kAyTkFwiHcX6k9d23nawWc0SJSw9znYHySTt2xps/4k2eLRTBfguhgd/iyzrN
         34KCdQj76oHqUlPJVWGTVyRL3AdS5FiA3VB8gJ/qh6RWP/Bx0kVRg533ANjOad5Surg9
         snxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722146699; x=1722751499;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u2zfcZwYG3kul58agQUX3yzpubFbACd2Ih5AzOdGpIg=;
        b=gKUBl/ecSYUSefXlXQzV4DZ0wwXEYBU869sF3xN4tvQ/MTqt+H8mbU5co//lfBDYnu
         D2zChvJ+pJBamsjiqRngKtl80+jzFdd9c1z3if6ohvd6GiGcRZKUhBjF5B+uzpcdcJgE
         0LNKkehE2t2571PPs+4CWE3iaeUFD4SQneVuxrYRHXyhRIUY7WbzqcvjNc5NaSqQJfV+
         cqQemFzjHl02OrmJ03CztG46sCPsGkAj4GK0/FwkQQYxUCpFBUZvCvDiBKVocpTs47IK
         nbPvsHEkgLYcZp6Lb2k7S/V95yJhYs0ZoDdUmLp6GT0ohct0CxueuoOt4//tz/gehVKb
         +L0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyDNEDaGwszbekeDu0Fq//26CTjN3gqeUfn4tAvMVPdh4+ZlaHaizKB++ytfsIv02Zkvb/jlCXgBz6UaWup8ZY0fZ4GlAuHw63AY9Yunnll6ME24OzrXTCFYuONiYAMKxjpYPktAjmcQ==
X-Gm-Message-State: AOJu0YzwnQkqQn58SvrFrr7ibNAV3xIbNuZBlr0QrlZzl1oFlOrehe11
	MeUEjTtFsL1Xox/0Ac+xqM3FRxTKSqh5ZTgQKex0oC8+qnxT6SycV4tRTXCZvMuOgrvTLrSCl7B
	oDXo2MDLekcoZ0+8c2uszjQNoplE=
X-Google-Smtp-Source: AGHT+IHxNR5AU0pa0wceEMuoZRoYMc8O9+eA8C/hzeiyBHWGAUhjsF4WLgxtIwUZcc0wKx1vTSSIW6kF37UgziboJVA=
X-Received: by 2002:a05:6820:1ca8:b0:5d5:c3a9:4010 with SMTP id
 006d021491bc7-5d5d0f1e0a1mr4493802eaf.5.1722146698783; Sat, 27 Jul 2024
 23:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726110050.3664-1-linux.amoon@gmail.com> <880603a5-35c5-4968-8cd0-81ebd2958bce@kwiboo.se>
In-Reply-To: <880603a5-35c5-4968-8cd0-81ebd2958bce@kwiboo.se>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 28 Jul 2024 11:34:42 +0530
Message-ID: <CANAwSgTTeHvzCZ=PTVFAqPOhwcs9GeYFqRRMiog+AnbEnZgixg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] arm64: dts: rockchip: Add missing pinctrl for
 PCIe30x4 node
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jonas,

On Sat, 27 Jul 2024 at 01:37, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Anand,
>
> Sorry for no reply to your v3.
>
> On 2024-07-26 13:00, Anand Moon wrote:
> > Add missing pinctrl settings for PCIe 3.0 x4 clock request and wake
> > signals. Each component of PCIe communication have the following control
> > signals: PERST, WAKE, CLKREQ, and REFCLK. These signals work to generate
> > high-speed signals and communicate with other PCIe devices.
> > Used by root complex to endpoint depending on the power state.
> >
> > PERST is referred to as a fundamental reset. PERST should be held low
> > until all the power rails in the system and the reference clock are stable.
> > A transition from low to high in this signal usually indicates the
> > beginning of link initialization.
> >
> > WAKE signal is an active-low signal that is used to return the PCIe
> > interface to an active state when in a low-power state.
> >
> > CLKREQ signal is also an active-low signal and is used to request the
> > reference clock.
> >
> > Rename node from 'pcie3' to 'pcie30x4' to align with schematic
> > nomenclature.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v4: rebase on master, used RK_FUNC_GPIO GPIO function instead of PIN
> > number.
>
> Why this change? Only reset should use gpio function, if I am not
> mistaken. Also how come you change the internal pull-up/down on these
> pins?, and why do they differ for each pcie node in this series?
>
> Please see [1] for some discussion related to these pins.

I thought every board-specific dts supported GPIO function,
>
> """
> The PERST is for sure should work as GPIO, and the same as WAKE;
>
> for CLKREQ, only those board want to support L1SS need to work as
> function IO,
> """
Ok understood.
>
> As stated earlier only the reset pin need to be muxed to GPIO function,
> and that should also matches the only pin controlled with gpio in the
> driver, if I am not mistaken.

I will drop this in the next version.

>
> [1] https://lore.kernel.org/u-boot/6de0ee14-3d85-4fda-af9d-9be7e0057dc8@rock-chips.com/

I'm sorry, I did not read the complete email thread.
>
> Regards,
> Jonas
>
Thanks
-Anand


Return-Path: <linux-kernel+bounces-233661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 965A791BB2F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D56B1F215E1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F61314EC79;
	Fri, 28 Jun 2024 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Y7zB9kc4"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763F814388B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565848; cv=none; b=E6DU5Ix6ru28D4ZkWZ+wWSlqN7rcCIazHtR3Z5ZQN2tI1yUgsb41Jci9ALis1Z2Nidzrv7nR7EGf6H+SMUaBku6Fs2pJiPGCu9ye065Hs9+uW9r8aPmvVbTsVg5ma/lRWWwx6uNiMHMDAwRN97NBWv6in8VjC6IEW73TRahJTWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565848; c=relaxed/simple;
	bh=Y49yne1+Id5qg7r47bMdTW2UJ9Vwgb/0SrPLAcJZv7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iOTCOOS8DDzqLYH53xz/gBH0Msb7sCQGPRVZKF0d7b2vhICLfl9JuNKEtMuxTwNU5YLDlXEPZ0Sx70LxR4+5mGLmS4hNjH9TPrvUsmvLyAXXxxrVcHJDydLkXE/eAin2o6x6GIJ1ZFmlKWPPEL1K0Olp2o/Q+7fMKoXyyoVjBP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Y7zB9kc4; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3645e9839b3so272620f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719565845; x=1720170645; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ww0hI7XhMOpeyVcfMbag2lDGd/Ez+xcshxdAQFbPSo=;
        b=Y7zB9kc4zAtRbrYkxlG0maQrmxG0QPc2Gw286q19dBGbZL1YBqS5M9DujvhDB9z4QJ
         lC4+6vLW9nFPBfcZVdmEIIbDw6WIjYBS8vkcDP7qxXo/4v2OQN7bp9A9RbJ/vb/OaRFf
         0Qfg/ko5TAFf3+bmrPpzg4hRFtNPTXS2lp6gRvnpH4A4deTUKX90mvGHXUqVKw5/fsz4
         A9rqjbwfQ0xBm9tLLe/NSVou2nX4INaquMqyLb19pqp5283enfV8UHEsENA+h5CEtKzs
         bZCMfsptczS+1zrDFdIZFqP+9Bml6eGupkKVkKjYwmnDqZQOjrMJBltw8tDFwb3Gg2Bn
         pJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719565845; x=1720170645;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ww0hI7XhMOpeyVcfMbag2lDGd/Ez+xcshxdAQFbPSo=;
        b=Mn0xvqMQr1UpcaxcnZp/kCesUrS90ggAUHPXu/vjglM7r7y3+nADxQavRd09D3piVB
         Y2L3zLuqQFl0+HdVIxjPDM1RrPmGWMUo6ph1/PLe/Zm36dWPO0DY2HZ1nliKAnjKLj0n
         OCyr1ypqzWEVRWvLDAZjCB0QwHAqLiSuoa6LTGYPyFs9ebG4OD8ggFkUTVS6t67NtMEz
         +2PMRAsAVn88HVtNOkAuDswFFlQ7uido2yKyZd1eFtx9iibp8TIi1AI7PWB2qTA9J/7W
         eqmXMP7RpsrSTyxfydulxHgFVVLA/nLxXpwC7xbdr8773yaGjzWTTBGxGVY57FK3m+ii
         VGSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM2pMli+/7/t+tJPSxAT+4M2EPqmKWGecfqdqvrSS6FMAzfOCoZ+hlsqhoI2iOSsoCQP3lbhUWlk6Tbb8qs77n6N2ZYEJFPU8/RtwM
X-Gm-Message-State: AOJu0Yyj88Xr1M9cCn/l5CiaLieZhlZ9TjwO1J76+xDDsD8oxISqo9Kn
	GKzJBwE7a/nh5ES1olWln/ueHuay3e4GL+wESZpixxLPUa1Xgp6+a/dfbodo5ceqxFiUyZq2HPr
	udA8=
X-Google-Smtp-Source: AGHT+IGfaRuokgh8AwoWqD+NRn4IvomA5WN9aP0+KKJTCP84NJnYxZfzokA4lANRvxjFgX20EM79nw==
X-Received: by 2002:a05:6000:2c5:b0:366:e89c:342b with SMTP id ffacd0b85a97d-366e89c34bcmr14945201f8f.52.1719565844836;
        Fri, 28 Jun 2024 02:10:44 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:d2a2:5e83:89ff:e781])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd60dsm1652136f8f.2.2024.06.28.02.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 02:10:44 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>,  linux-kernel@vger.kernel.org,
  linux-amlogic@lists.infradead.org,  devicetree@vger.kernel.org,  Rob
 Herring <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 0/2] arm64: dts: amlogic: handle hdmi system clock
In-Reply-To: <16ec9c9a-badb-4626-9227-fb03f0ee3ee6@linaro.org> (Neil
	Armstrong's message of "Fri, 28 Jun 2024 10:10:22 +0200")
References: <20240626152733.1350376-1-jbrunet@baylibre.com>
	<16ec9c9a-badb-4626-9227-fb03f0ee3ee6@linaro.org>
Date: Fri, 28 Jun 2024 11:10:43 +0200
Message-ID: <1j7ce9xwj0.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri 28 Jun 2024 at 10:10, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> Hi,
>
> On 26/06/2024 17:27, Jerome Brunet wrote:
>> This patchset adds the setup of the HDMI system clock for HDMI Tx.
>> This is another step in cleaning HDMI Tx and its direct usage of HHI
>> register space. Eventually, this will help remove component usage from
>> the Amlogic display drivers.
>
> Thanks,
>
> Beware we will need to keep old DT with new kernel functional for a while,
> do removal of component & HHI in meson_dw_hdmi would need to wait for multiple
> kernel releases.

Oh, I'm aware of the pain DT backward compatibility will be on this one.
Situation is slightly more complex than the PWM ...

I'm not sure how keeping support both for the 'legacy HHI direct access'
and 'modern API and region' approaches will look like. It's likely to be a
mess.

What I posted so far are things I'm sure of and will not cause issue.
When I get to the controversial stuff, I'll post an RFC first.

>
> A migration step would be to add a phandle to hhi right now, so we can drop
> components earlier, then in a second time add a proper PHY and then mark
> the hhi reg as deprecated.

Giving the hhi syscon to HDMI-Tx is solving half the problem.
IMO, HDMI-TX should just get the HDMI PHY register space in HHI. Indeed
that could be added now as well, without causing issue to the existing
DTs and drivers.

The display drivers should not directly poke in the HHI bus, nor should it have
access to the whole bus.

If we are going to take the pain of fixing the DT interface, better do
it once and for all.

The 2 main HHI offenders are HDMI-Tx and vclk:
* HDMI-TX: I've got the that mostly sorted out, for an RFC at least.
* Vclk: Here it is more a matter CCF usage that HHI
  * The HDMI pll could use the regular DCO/mult-range driver from what I
    can see
  * The vclk display would need to get the DCO clock along with all the
    ODs/divider handle. Without rate propagation, it would be free to
    recreate the setups it needs. I don't have the full list and I did
    not spend much time on this yet but that's the idea.

>
> Neil
>
>> Jerome Brunet (2):
>>    arm64: dts: amlogic: gx: correct hdmi clocks
>>    arm64: dts: amlogic: setup hdmi system clock
>>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 5 +++++
>>   arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi       | 9 +++++++--
>>   arch/arm64/boot/dts/amlogic/meson-gxl.dtsi        | 9 +++++++--
>>   3 files changed, 19 insertions(+), 4 deletions(-)
>> 

-- 
Jerome


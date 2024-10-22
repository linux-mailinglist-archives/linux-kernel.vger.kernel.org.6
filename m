Return-Path: <linux-kernel+bounces-376618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DBC9AB401
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497191F22A08
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EC41A4F2B;
	Tue, 22 Oct 2024 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zXYHbkvK"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F5C1A4F1B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614578; cv=none; b=KBmAc5gMYudKeDvofhDTTSUYKCcpjmTrUnS25Cmml5TYl/jgp+TfhuuvK7gUJ+/0jXhPVOhLwHUsKpljSb909D2aQPVtm50hNGETGwwHCUiWuO7bM5+AMPKisbZvEkOZzbBGtySEw6EuqkwGXj2N/pcNYYX36tw19b+vqNbDhWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614578; c=relaxed/simple;
	bh=umO8OqxiXCS4K1sKSWan4GieQxihruZNulLEaExWkwk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Q8PYBbT7RLPsoowEZOXvFteeKVGUNsBv5TSwRPIxzopWiQBQO0DlyKfBUTyzeRwg4LLyq+pVpvvHS77eXNQt3IKu8DRZ6AkuCdcN87usfWkmtULjOC/ufBZm76q/AZUExmOPnCfLhR4wMGJ2LK05MwChbZb7RQ28pBSfiZ+1LoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zXYHbkvK; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so58636491fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729614575; x=1730219375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mYYtlzBEl7gtJfr4NTGhzUN/UYER+MKPfZjJSoq7AH8=;
        b=zXYHbkvKW93nQoBEtC0I1D52ulq2g5Thig1Sp+N5rGqogFCoqbqLPSn7CNMer2yUm+
         9D5NBpIK1ZxrOHcRlW6lYSWivd6jnO9rJDIeO25+cv1Bp9s7MH/RKR6Z4Z1AAi5P/R0j
         fjLelgrlu/58asoNZ3Xti/mWXGHBzgeayo/NFTMWOCIrSD0dYa13L3NWzKc+2yeD5y3g
         IInM1jTZ5e9MEUWbkBMaf1R04Z9A4ejH7KeObOPolXs/VHGcIYmJurJIntm2K5LHilhi
         gb8I4uNvXD5sbkgCrqzDnUrAJblF9u4U5shkPdo9WYhsXCDnspf7crVKjAIaZo+DZCU+
         NRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729614575; x=1730219375;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mYYtlzBEl7gtJfr4NTGhzUN/UYER+MKPfZjJSoq7AH8=;
        b=S2PZl5P2OkbE1iCePebz23flFR2hThpSJMu19kz4XHF2D7OJ3kBpjZEE8Bpo/IasBd
         Y1Tjhjjc+XwpHAASh+FZFNMomzBM+WsSYBLyq8c0nLIEnlnE3amLU6c7QgAcVGvb5ttE
         u5heFctkCaRBErFvob8YO+dprIdRzYAT+zp7i/pejgnLbcvN6sIDH6zhVZu3B9qKhv9X
         tNlBl5NS40BtRQAzolZASMpTIDY7vwPHP5mg/d3+n0sDCVg/59RDY2L60ad0SlSFuqfx
         GukxjvCVJXoZxsB1ORCNtAccZ24B6hEre4F/65Fv0iThUZwA6zyx/SYJ60qYM/hBc5KU
         q41w==
X-Forwarded-Encrypted: i=1; AJvYcCXX6psK2mGcO3sgtL/gIkXzIwxMVpWEmkG5MuVEtuAV+AVJ++mHGqge09a0Vmabt7yhK5vu83wUSDL5yRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbUk/kkn6uHMKDfujsqguc92cahYHJkh9BO0OOjjyPh1TblfZr
	Jj+zQzHyqUFNTA1mNIqt00CbuNWZa7XHidSy0gXrMH0/EY9JhifUEBfkCRjxKfI=
X-Google-Smtp-Source: AGHT+IHvOz3k1e6wuWl1d7INxXkLe7qNKVh7hpSRfRhY+VPPl9RorpJ0zP30B82VIJSuu4vBsY26Dg==
X-Received: by 2002:a05:6512:3e25:b0:53a:d1a:be09 with SMTP id 2adb3069b0e04-53b13a23f4emr1805356e87.37.1729614575349;
        Tue, 22 Oct 2024 09:29:35 -0700 (PDT)
Received: from [192.168.210.26] (83.11.13.124.ipv4.supernova.orange.pl. [83.11.13.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91370e91sm357269366b.123.2024.10.22.09.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 09:29:34 -0700 (PDT)
Message-ID: <2a27ed62-305d-4d41-a43f-02f58bc22e2d@linaro.org>
Date: Tue, 22 Oct 2024 18:29:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: Re: [PATCH v2 0/5] Enable HDMI0 on several RK3588 based boards
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Luis de Arquer <ldearquer@gmail.com>, Alexandre ARNOUD <aarnoud@me.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, FUKAUMI Naoki <naoki@radxa.com>
References: <20241019-rk3588-hdmi0-dt-v2-0-466cd80e8ff9@collabora.com>
Content-Language: pl-PL, en-GB
Organization: Linaro
In-Reply-To: <20241019-rk3588-hdmi0-dt-v2-0-466cd80e8ff9@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

W dniu 19.10.2024 o 12:12, Cristian Ciocaltea pisze:
> Since the initial support for the RK3588 HDMI TX Controller [1] has been
> merged as of next-20241018, let's enable the HDMI0 output port for the
> following boards: Radxa ROCK 5A & 5B, Rockchip RK3588 EVB1 V10, Xunlong
> Orange Pi 5+.

I copied changes to FriendlyELEC NanoPC-T6 DT and booted 6.12-rc3 with 
your changes on LTS variant of the board.

With my SBC monitor it complained about resolution (10.5" 1366x768px):

rockchip-drm display-subsystem: [drm] *ERROR* vp0 Cluster0-win0 
actual_w[1366] not 4 pixel aligned

And monitor told me "no signal".

/sys/devices/platform/display-subsystem/drm/card1/card1-HDMI-A-1/modes 
lists all resolutions available.

Would be nice to see system going to next EDID resolution in such case. 
1280x720px is 4px aligned.


With my 34" 3440x1440px monitor it shown some output once. In resolution 
close to original one but 16:9 instead of 21:9 one. Anyway monitor 
behaved in "I do not like that signal" way - started blinking, had 
problems with displaying even from my desktop after.


I got a feeling that 1920x1080px monitor landed on my "need to buy" list.


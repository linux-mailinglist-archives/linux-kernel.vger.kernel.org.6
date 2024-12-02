Return-Path: <linux-kernel+bounces-427119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB099DFCEA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 079DAB22206
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EBD1FA179;
	Mon,  2 Dec 2024 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="OS0gP45S"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAB81D6DB5
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733131224; cv=none; b=niFcGjwqlsY+Mlp9etJaMxN7X7N7r104dFdr+LgCVZmTZyTHazqK9RUldKfrlkS0P48g52GwuNQPAg2BHtLkT/EP3JkLS36x9au2Ufx+ogu/QjTmYCeJCIfjr3QMKYJz7cfHuFpAb0LXZOgtlGWCEPwQwylnU7TkS6hLh8gDTks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733131224; c=relaxed/simple;
	bh=SWUOtEZ62ullshonhP4jKBf2d9W2S/E8dA2lk4biI3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jo60AY4tfIiH3SHTQTAWQRTGp/nY5uZD5ZbI0I3ChQwxGxC/puqT4kSzTiKMlEXWXmHE8wDkdaH5ALwMhHTUmjhibAHv/7i3f2ZL7afwvrMVKG6eratqmfjLWWJYtrc41Q7dUFyjN6Vn9wJcyYsTH7BrOWjgNlDJpAoM5wHsRxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=OS0gP45S; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53df1d1b6f8so4392080e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 01:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733131220; x=1733736020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s1RPkwPp5r2Vbz80qntZnCN8Y+Eqnbh1zwzq5b7urfU=;
        b=OS0gP45SHpGIie39DH8Z/gOCe7mxiUA0tXy7JPmQ5Jty89gAoyKefrK58Cqvl6gK6f
         nOSgS1nDFUDxp1HDkoUBC+rKFcxl59Nioo94fAOiDzGzutP7IW5fRvriOfGm0GD/HJTq
         3kPgkmqywyHHis3JeCMZrDc4AzsysuJLxaNbfh1IYEmDhCc88LaL5V6d5vc1z4SYxAWq
         Olgmo9WZRZCxy25pmVbC4uF/GkIc3eihls2QApWdTu2PNoiQ4qhIBT8gvQxZUzqDXJNb
         TglN8C/iIKj4rj/2l3F0lTTN0GbHRUxHMSTzpLCnc2V0VgA+HP0fBj2N0JOHbegUU03o
         qO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733131220; x=1733736020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1RPkwPp5r2Vbz80qntZnCN8Y+Eqnbh1zwzq5b7urfU=;
        b=Kc5sO7MUL3Yd17pymrEfzIyHb/yjK0FqcBxXumqqA9xXSpwRu84nRruLxQZRrq4ZpA
         Q3vCQRsbuS3zELVHlPpXrfY2LjU1yWnH+1bpw+/WMuUxPYn1ulvyrCJXk7EgJt3SVKPT
         do+xPywjW2CkAXl7j1hFvJAjZrat4flrcS/IkXMU0b3x2j9F2ZeRVsYnW3OiI5ubVhlR
         TX8dtHbwbhJSTW+UqWzNUM9+q5coUg9Ru+IpiM3phGFNBpyF5Lg7ZNwIzTOHKBsz18zK
         FBLgFLDHS0U/8RgB2ffKfsP7BE8FkV/SHLTvg1gr03/LCPoJwZvadA9SsgMKG1rxagTs
         YIKA==
X-Forwarded-Encrypted: i=1; AJvYcCXYDCElYdfJ9K7mFiZEAhyRWxNFqyjXkb/d57mCvIKqntXQyK+GY/uL2hIz+d99jDxf9gYvjoapB8SpF9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Qx4K4WmZ6Eb/Qjpr8Uv9WLzwOk+twjVi6o50ibtZJb0b1fpf
	22u8sskZu2HiRSrIcFGDihWYsl2f7DN1MVxwH3PQn6CV/2a+llhm2fSh/lqVStQ=
X-Gm-Gg: ASbGncsmYjtYfNwj3M1TDsyLrrSbEjJYMsdIGPgDk7IuDjh64P3vFLOq+y9lVRuzw3a
	yEC39byx4pjzXNZc2W6LuzVXhEy7cIMJDcLlbJkNX9GaCrEKTbsfV8CY5IDoAfmPjdXlH7ZMEKy
	9iFQvdSVoc3LSS1DC3NldMf7/iEOImCiiVzd0k/VMRPP7Azja0wbtaDz6OAzycheylmhCQxYy7M
	F8cxRlQEWsDULynAFE8IyEzA+576ymBXtCTQRvwoT91J5dy5XtXk9QY1kIUDLf+E5g3Hw==
X-Google-Smtp-Source: AGHT+IE/Ktyy05BNhEHz3SvhbLMz83N6niVppt6d9zUKChiGb2UC5yIq74p4radwagwY843evl9L+g==
X-Received: by 2002:a05:6512:39d2:b0:53d:a6c8:fb94 with SMTP id 2adb3069b0e04-53df00d9d9dmr9199616e87.28.1733131220488;
        Mon, 02 Dec 2024 01:20:20 -0800 (PST)
Received: from [192.168.0.104] ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6496a43sm1386017e87.213.2024.12.02.01.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 01:20:20 -0800 (PST)
Message-ID: <73ca1492-d97b-4120-b662-cc80fc787ffd@cogentembedded.com>
Date: Mon, 2 Dec 2024 14:20:17 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: phy_ethtool_ksettings_set: Allow any supported
 speed
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Dege <michael.dege@renesas.com>,
 Christian Mardmoeller <christian.mardmoeller@renesas.com>,
 Dennis Ostermann <dennis.ostermann@renesas.com>
References: <20241202083352.3865373-1-nikita.yoush@cogentembedded.com>
 <20241202100334.454599a7@fedora.home>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <20241202100334.454599a7@fedora.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

> What's your use-case to need >1G fixed-settings link ?

My hardware is Renesas VC4 board (based on Renesas S4 SoC), network driver is rswitch, PHY in question 
is Marvell 88Q3344 (2.5G Base-T1).

To get two such PHYs talk to each other, one of the two has to be manually configured as slave.
(e.g. ethtool -s tsn0 master-slave forced-slave).

This gets handled via driver's ethtool set_link_ksettings method, which is currently set to
phy_ethtool_ksettings_set().

Writing a custom set_link_ksettings method just to not error out when speed is 2500 looks ugly.

Nikita


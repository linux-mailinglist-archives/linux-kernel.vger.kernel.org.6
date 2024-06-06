Return-Path: <linux-kernel+bounces-204795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6EA8FF3A8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66861C25C9E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8191991A0;
	Thu,  6 Jun 2024 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5ojnwxW"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69691990A2;
	Thu,  6 Jun 2024 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694771; cv=none; b=goBtAXHrTaUfgCGI1p1d7KH+fYhFJYq68zBiSxIfms1+BCGlQ90jNz0A1MuS0X3lgewhOqYo7z14ucYGv8oYuVc2faUTLX+wBhM+OXTNYfMxQvKrDL/xGOI3cmvIpx7NEMIihYefhQ01T2oSIicOQm/z43twPUTrCYAS0OY4Vc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694771; c=relaxed/simple;
	bh=VqnNKmLSC1RD6dHJs9bd0MVxv0ddr88QmVM8jgunJ+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EDdsTPXoER/oTgI3oWOXPC4Ur45+Y40fNBesXwDEj0TBlM4Yv3N7zHBtL/8AMI/A/hsTTyjbEOUshBIS3RL732vHFAH4uyEcezo7jC/qfuPpm8ej+JSxUJ46Ykd0Cq+jP5gdIk7xtYu3eSLSZVXzWaQynFZovLv0HRmSt+8iLBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5ojnwxW; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a692130eb19so136746666b.2;
        Thu, 06 Jun 2024 10:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717694768; x=1718299568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VqnNKmLSC1RD6dHJs9bd0MVxv0ddr88QmVM8jgunJ+I=;
        b=d5ojnwxWdvkyXcBrwWEJzHu5MwkasidhPfm7+vMuuGPFAQGmeooTwWu9HmkjRaias1
         ckNRxwjVWRz9bCga0m6ARIeAcaXCpRbCc0/4MLmU/2MEiET/+CSkpWuH0LoHTVpibGiN
         FvQjTNhZf8Wm8ppsmc3wAyAOVNit/X/WIVnjOvAe7wz5IiOun4Ve1mgmihLHoJvlqscU
         8Obqcf8x5f8WgC4M5MiFQ6t39MDlPcJSgJXXYh7d/s5zNfycBBZXmadEMxf8395MIO+E
         tZs6jD2jl/4GtSQZj5nRDSSrdAjIAL+qKie6Nv4lmXaQMKp5K4fTMk6P7Z1/Cdq3OVoZ
         ctfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717694768; x=1718299568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VqnNKmLSC1RD6dHJs9bd0MVxv0ddr88QmVM8jgunJ+I=;
        b=Fzw6s1YP3FPe8xwJ+2Im4JNWshMsyS2rgUPV6T9P9/rqQWYnzGjFrNjC6vTAwouPPN
         CD06s4dIdeqhPZihIe7X5zZyMJ1G+ocLqWcBoPzhCfLddWvJa9FU8lw+p7KbdkE5Xmbk
         ui0AdtoQgklzl1Q+g5g7sMq5a/yG3JcG6TLSkjK6NAZO2GJ+FEhUQFaH3R9L3pc/pa09
         8M+Yr81U5LSPWuZSuWp5ehcLJ7TLSIFqMjbnugkXhs9gtNH46bhDv8Efc6fTHEeyYusG
         PjNKjEs7XYdvGTWI4JP+Yx+NweHqzAqAWEbKZm3eV6ARRPPyQ/FamejRVffbjxLeZzAX
         AdXg==
X-Forwarded-Encrypted: i=1; AJvYcCUDxUWAmqe9rIY6ocM0ezrJBtOaxCYd5hgydE9KDfMCgvF21n6+gTPxhfG4mfgzg1Zi4k00QDaqwKsykiZJA4bHrPRIhVxjSmkMhht/ZM/t8TNsgP0ywSeuFi+4cXsbg1SPQ1eNdh47Bdth/Rfq1AMfMgozOg4vZJx+qTK/x9lRbH+tlg==
X-Gm-Message-State: AOJu0YwX84CV3Bohig25ySoq2j+SPfW/IL8mVZgJckQ/8+YRluPq2FjF
	kQYbtpq72a7SAZtc1rBegVIaqjUOvLzMj5NSjP4qt3aBYiIoFHo=
X-Google-Smtp-Source: AGHT+IEWHpUP1OjNuBxbT3hNUewpxmHFYSGB8WmlQsIDkOOC1DBOurNrQViCNgd74rDrnr8oHEdemA==
X-Received: by 2002:a17:906:446:b0:a68:cc34:87d8 with SMTP id a640c23a62f3a-a6cdbfec41cmr13492866b.67.1717694767849;
        Thu, 06 Jun 2024 10:26:07 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:ed9f:91b7:21f2:3109? ([2a02:810b:f40:4600:ed9f:91b7:21f2:3109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c805ccb11sm120939166b.78.2024.06.06.10.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 10:26:07 -0700 (PDT)
Message-ID: <1f549cba-a754-4256-aa4b-dbc630e5e451@gmail.com>
Date: Thu, 6 Jun 2024 19:26:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5 RESEND] dt-bindings: clock: rk3128: Drop
 CLK_NR_CLKS
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20240605210049.232284-1-knaerzche@gmail.com>
 <20240605210049.232284-3-knaerzche@gmail.com>
 <20240606-dispersal-buffed-27a6e7540d4c@spud>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <20240606-dispersal-buffed-27a6e7540d4c@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Am 06.06.24 um 18:09 schrieb Conor Dooley:
> On Wed, Jun 05, 2024 at 11:00:46PM +0200, Alex Bee wrote:
>> CLK_NR_CLKS should not be part of the binding. Let's drop it, since
>> the kernel code no longer uses it either.
> What about other operating systems etc, e.g. U-Boot or barebox?
For u-boot: RK3128 hasn't been switched to OF_UPSTREAM yet and it still
uses it's own (dated) copy of the dt-bindings headers [0] and besides this
macro isn't used there. Barebox doesn't support RK3128 at all and I'm
generally not aware of any other bootloader/OS does which does and
especially none which uses this macro.

[0]
https://github.com/u-boot/u-boot/blob/master/include/dt-bindings/clock/rk3128-cru.h


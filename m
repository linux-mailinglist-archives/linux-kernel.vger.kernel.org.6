Return-Path: <linux-kernel+bounces-271674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2C8945177
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD1F1C220C0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D071B4C25;
	Thu,  1 Aug 2024 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="oh8vdwfk"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77E1170A06
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722533327; cv=none; b=m5CLBleQIRurM5gvxRjyedrFmdnpRTCTjVXwPQMgGhkt1/2QdHDO+n/WHBAOeUfOwyGiPYC7rupZkzsw4FtmgHnEcjy1DkZQ7t+gBme/WAK/OeauoQilY6uU3qx5VWiQlnkL3MIQFwlZ101wqjoXcuNpSMfzeVOniR7Ujta0p54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722533327; c=relaxed/simple;
	bh=xYp1qctPQ3XCpMinrXG+jW9arJfjc0jjCGgwQ6JAppA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzV7+MStU+2XfsSG+60EVBeL/94MOhTeaV67FlW50wMoO9WnuTaEGGy1MOF0OOoiD9Jz3AefVpgRXFq/ENOaI44Uq+GEqLP7ez/2gVCjqltNAQK4c52GH8EZYoEGnXTFyB3ViraZ7pmi0RNZTDf+tFZhQF5Juos+aNQMdJm7rgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=oh8vdwfk; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42809d6e719so48822375e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 10:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1722533324; x=1723138124; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XnwjnjetY7dv9eCyx710zpOpIL7zDgItoHiS/DQyjbw=;
        b=oh8vdwfk+W1mR2x14bS68ATlOQLJ6HZMU1zdufP5d7Rg6lIs+9UDYcgIvT9WdT7nNC
         OQp+OSJqTASdPbruP/YWNgNMJNjfJQLTQkOShdz3Z0n4St/2AKtNCdxJiW8ZYo6/DI/O
         efgyLeMxmgpZ5eT/Ob0s6nK6qRnl6MwEhqbEZ2X74KpwkSpy/Klks5vPzmmmCSDsnw1o
         zO44yDnWXi7SIW4Cs4s3mlthO+DKzuR9ixrs1cd3cIWFTvNyYiKlRJdLbdcOjx/SaYog
         8WCwhDtQTxsKzz6bWK59vjPHdEfNS60L0waatMGlOsVE2FYRgZkJm3uSeA6VHPwPNpAS
         Gigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722533324; x=1723138124;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XnwjnjetY7dv9eCyx710zpOpIL7zDgItoHiS/DQyjbw=;
        b=kJT95HenCoMWwiyE1ClTIdNEjlDmDHEZvn0Or0lefaiqQxPPZ7iRNwWsNINtkC77lP
         EKorLDVe8xxJzJCF55yOeLW9IriR7vI2/thdPDfUYHjzi4kWLBsxU91E9Lm17JDI6HNC
         SY2WM0ZXA6Py80+VLNzB/W5vODmUBpkdWdggj0liTNnYgHPq0afJwzEXy8L0W9rdF32P
         AHV78xbT7zCnE7DuL6iLEcGBVuFfswx7iJasoBgI9G4SnN7JrR39SkP4ewHlzhCkQ3Je
         yXmNE5Tnm1P4Tb3cyxTji/WbAWI3L9CV3xJGvmq8tu06NEpaMu88n6S54neUBvp3PnRB
         bNDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ21DhXe5BnTEvt5F/TPBR8AgPFSgz3aa/u4ZUewnY52mVm6izgesgB4uKV8AG0QpSR3gfz0+ouBLt5Awju3EiMQ+t76fhJ27ibIZ7
X-Gm-Message-State: AOJu0YwbQWDhFzJfgdhZYnWjZsqfICbdTnfYNMc0uKIdk++x2P9rvJ6f
	Fg4RAFP1ps4/c1T7rlxKmLHVMGhHs9XWkV+1vzIrmlTUJx2L+Hj+GgaEO72L44w=
X-Google-Smtp-Source: AGHT+IHS4knhHpTTc3R8fFT40aZdqgWtj3Bjf8KF8/wk14Wl+xIhW2xqBDu0DirWFImXVhfOp8H0SQ==
X-Received: by 2002:a05:600c:3b17:b0:426:58cb:8ca3 with SMTP id 5b1f17b1804b1-428e6b07c64mr5187045e9.21.1722533323640;
        Thu, 01 Aug 2024 10:28:43 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb6405csm65736205e9.34.2024.08.01.10.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 10:28:43 -0700 (PDT)
Message-ID: <80d56236-2499-4c89-8044-6a271e47515d@tuxon.dev>
Date: Thu, 1 Aug 2024 20:28:41 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] arm64: dts: renesas: r9a08g045: Update
 #power-domain-cells = <1>
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: mturquette@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, magnus.damm@gmail.com, ulf.hansson@linaro.org,
 linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240422105355.1622177-1-claudiu.beznea.uj@bp.renesas.com>
 <20240422105355.1622177-9-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWhRRdfoqg_o6bU7jjt5_Di0=z7MJ4fMh=MJ0m8=u4tgg@mail.gmail.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdWhRRdfoqg_o6bU7jjt5_Di0=z7MJ4fMh=MJ0m8=u4tgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 01.08.2024 19:13, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Mon, Apr 22, 2024 at 12:54 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Update CPG #power-domain-cells = <1> and move all the IPs to be part of the
>> IP specific power domain as the driver has been modified to support
>> multiple power domains.
>>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Now the watchdog fixes are in v6.11-rc1, I will queue this in
> renesas-devel for v6.12.

Only the RZ/G3S support has been merged.

The watchdog fixes that allows us to use this patch were submitted as RFC
but got no input from Ulf, yet.

Thank you,
Claudiu Beznea

[1]
https://lore.kernel.org/all/20240619120920.2703605-1-claudiu.beznea.uj@bp.renesas.com/

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds


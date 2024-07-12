Return-Path: <linux-kernel+bounces-251009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC1792FFB9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74BD1C221E6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7A6172BD6;
	Fri, 12 Jul 2024 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="LzQ4is3I"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83B21DFE1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720805100; cv=none; b=L5tihcw+JFvt6R5XW5VmNc6tzmAAw5dHmXKIBP8xw00gFQjHOYu1a2xrho9zwYWj0i9GSPMtk14w+mgUFpXrOd9M4UpT4ysILcfzwpfFW0t/wNSrypYFsyEj2SOMho4443fdWkBrG+uzLI+t0nKqGnjqvG5JR0HcLq6NGXV6i8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720805100; c=relaxed/simple;
	bh=oItytILQOCwm+LxnV+klJYRd5+wEjT3G4pzPFdDn7vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4SAhRL9jWENrl5TXz+YKzlyfO/SGE6El9c+JiRrXExa5iYa5NKmtilWIFodNnnMzzg2kqRg92wcSgbRdldaYw/SbqWxc4NhjdQBZ3mwAzJ6pjy9aa59w//Q45m5MFgf0jW+7n548Nye7CZ/9GBIo0Bbr3COMBmnH9Q6C0zmaa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=LzQ4is3I; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4266fd395eeso15536365e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1720805097; x=1721409897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/kcUOj+B7ix4wFrjmiIqRB4s9K/GptfFcWjVq2YUd68=;
        b=LzQ4is3IurDoCi3XW0F4F9lk/YERMzt6QzeJ3GPRsPjE2cXMgaFewe2/YPfHkYG7DG
         GZt2zEhcIIVDxsxZEjWctCQ1VWGjOGh3O0XpdAKLeSoYyR/Amfp8fO9qvFPrxIcoOCJv
         imjVXsEz26M2lfPQGK540oY+yg0e8Yg18lJx5uNOb8ZJfMqAkjBfO8nHQJ9292vxqASp
         qIALyw/2DuYB31gv03kx16mq7Alq8iioCJ4Ac3pHChftZdI1w1N9K18HBpYzblwWCT+i
         i5gjrRf+0vHhmx4KBV9ygTA4L0pgA4eJyNSyl0YM4im0G9g5Ufdobp5djhBVSgUjvwYe
         xdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720805097; x=1721409897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/kcUOj+B7ix4wFrjmiIqRB4s9K/GptfFcWjVq2YUd68=;
        b=wkZvDxJ+8rEMdsbYzR8OpIl2qZbZfFQxeM+O2AS1BjLURKsLooEPUd0xdj1Xjto8lb
         wuBK4JOr0pUBE+ellKxiKLSF/Dc5tHcJ701x6CYQCYeRrgP4h4QDOLvIkU0y4Na6WAfw
         0BrydEC6ra3n51dtk+W3rPs1kEMbGRkQ9SaOiA3gE6cjnhVv9x3uEilJMXN2cKmWTVr7
         Gw4puMZzXlYzzGrqKXIGLnumB6VHEm8Um3VKiGs+00T6rNb2ZbyLpk7lmJynQYcGQ8xc
         6vG3X+HXYYu941d4n2kX2a0clmsvtBXRQak8tutuSWuGZGHmN6pcNLCjnqYTSpR+ZIJY
         DiOA==
X-Forwarded-Encrypted: i=1; AJvYcCW9EOItVAG4CIPzZbiAvhaFLthxjuhI0VSLgrjgZh7gQJExLHYDnaQwToMVBnWfklakPWFaCxHFtdoSxAXOZ04/Srw6B1n1V83yp6Eb
X-Gm-Message-State: AOJu0YyXWZOYWJyQ73GQfleEst3QSGHYtlbw7T9Pn2YQzoiBEgQhqPX2
	0lxKy0BADORtjr5y7cRSGZG2vZ+ybIb1j1IR8g1ALq9xC0JsvJy2TB1uYKL7sFw=
X-Google-Smtp-Source: AGHT+IEbwv2aqYJrQ4eYr+eTCvp2ZVYaXErHbWTEnoJWSTMpnS3FoLzus6WA+pYLiP74DOnPbffshw==
X-Received: by 2002:a05:600c:1505:b0:427:98b4:624b with SMTP id 5b1f17b1804b1-42798b4628bmr39930825e9.24.1720805097322;
        Fri, 12 Jul 2024 10:24:57 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367fba1b15esm4218403f8f.22.2024.07.12.10.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 10:24:56 -0700 (PDT)
Message-ID: <3ad435b0-c110-4254-9071-b2397cdc7f9e@tuxon.dev>
Date: Fri, 12 Jul 2024 20:24:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/9] watchdog: rzg2l_wdt: Add support for RZ/G3S
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
 geert+renesas@glider.be, magnus.damm@gmail.com, biju.das.jz@bp.renesas.com,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 claudiu.beznea.uj@bp.renesas.com
References: <20240531065723.1085423-1-claudiu.beznea.uj@bp.renesas.com>
 <7f99cb63-0c6b-460e-934b-4e7e8d84bb3a@tuxon.dev>
 <CAMuHMdXN7xCtjRraTu=3JS6x8GCo7iuS40PVTN_DPvhA-AMqfw@mail.gmail.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdXN7xCtjRraTu=3JS6x8GCo7iuS40PVTN_DPvhA-AMqfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 12.07.2024 20:10, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Fri, Jul 12, 2024 at 5:39 PM claudiu beznea <claudiu.beznea@tuxon.dev> wrote:
>> Can you please let me know if there is anything you would like me to
>> address for this series?
> 
> Your series was merged in watchdog/master two days ago, and is part
> of next-20240711 and later.

Didn't noticed, thanks!

And sorry for the noise.

Claudiu

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 


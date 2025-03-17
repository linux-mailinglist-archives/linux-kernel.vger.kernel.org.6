Return-Path: <linux-kernel+bounces-564140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33216A64E50
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C37037A1284
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B14A239587;
	Mon, 17 Mar 2025 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="1QvHrU7e"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A00238160
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742213476; cv=none; b=d3wKINAN/be6U+WpOrj41K/1f5sCY1GVbDc2RN2O3MNSST+cq4GsjrtlghA1U15LMdpKKQUL3fxp1n2jeYxCeTf0S+PLdfN/VxKVvbbeJkbI/q0XA0aBei3X6MHGGMDsH0BSnkhNZJMzjTck7vOoLcr8IR5Hy3dse4Pn+EhAi4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742213476; c=relaxed/simple;
	bh=rkx57oeapfLrwsTzh7bfXfL9+ooCnSJcupMTLnD1GBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kcY0rpKn0I7H0U5aPNJ/xFBzbk58p02zKQHHUciIux3ZhUqJ5PZn1SauJEn75mF3bbBzAY4Cm3X2wtJTXwhNSWk2/MlmVBYMWhy5MkvsnXsYmfmXIjvQf3+/2Q7PWrGVahr9Nd2KzT5livwzQm0IdS2gXdt6saDA67usHe3Y2Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=1QvHrU7e; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85b42db7b69so57906939f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 05:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1742213473; x=1742818273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C0AefTr+b/KmSIHJ/y0w6HkDTitHcQhMEPmgA2zTVn0=;
        b=1QvHrU7eYH8AHOZlK+y2R5oRIGUnaHWQmS3KPE2PRs1VEi+TxJ2Z/qfgZELSL44E9Y
         5mWQclJYBtadX9lFWiv7gp0sRInkhk54xxtplSs8yUefs02vae5dV4ql+H7lZuHh+2Rh
         9ywAhFbgEKKwySQB5j5wm7FsrXrlrsGGKIMclP5x38HUzpqoxIw365WmvS2wGa7FXLNC
         qg5Lpv2hIeFdxvLbkICQCqkpRws4fUbRpg8IEqONsB5/jLX4bEsHKV9a5dmuM1OE6hAh
         gWu43yw2+oF89nck0RVVnsmU8lJhu+VsEkR+VuXxH+UowXC0Hu0BNL4srekyDVsUU8Fe
         eXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742213473; x=1742818273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C0AefTr+b/KmSIHJ/y0w6HkDTitHcQhMEPmgA2zTVn0=;
        b=kO2lopzTRI9rfAwPmZDqTcaLxJsxDLchjfDWiYM7ugyEFOYiZn9EmmJnLmT3xLLSrE
         Kt9Tybi8PLz/f0eeRVOLtBHhsAg/s6ycTviGEYiPzkF1M7DZTiXKbmkn8T8G7VWjP6gV
         NMYjLpd4J+HgpXld4vF96dpFh/IRFnIrMUOoHOcb8uC+bW95LDGtg/lRGmeh1NhPrGiU
         Z/mtDonm18aIjdnX5wb9D5cjU6JO52U3YtEbAcxZptihDUYimbM2h/Cqz5UREkhTj9uL
         TM818HuRdt6trnBw1JEU5jQhppdIpfw91Ykzq5XgGIkDYV73E1MQX5i3ov+sMFzn1aRY
         XMow==
X-Forwarded-Encrypted: i=1; AJvYcCUK4xOnjlpFBVU+U6T5RjI8Jil1iqK3/4BH89X+diCgX6Q2g81f3lrRGNuBvod/RRKb3TkiFxc0iK6Dj5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5PEodciw+1bZrKlpOUubkbdvzqbb+EoU9gij22/oQkq6C8dHL
	AGFxu5FIpfAmOUBSovdp8lWz9rcYGgH0VrdiSC1yh9/mu5Z+5nq6PeDbIFDaqAI=
X-Gm-Gg: ASbGncu5yFW0XDla6+fghbQxUP8lcXcV20Ndnx1/wlF1TjdIs6hPSSev+4X85unQfyt
	UruKf+sqUwQlS+G6FHGzfw6NknD/FgPyYSqe6MI5KOVv95j0OZbylIlppCoVwkoHH7FRlaY8KGi
	Lk2ecFSS3WBJFIxzQLBrVcHg8Lgr6rmvclvMywFqvpJ+fasmpuw4xOu2H7mwpQYUCLjhlyZWrsr
	1NbfT7NK1GwlOcPMFBvnMeKBMZar+j5yyhBuY4tVcJs/Pwr/49jhg8h50s+ZcqCJVlFgqKCIwdJ
	YEQqwe4hEPnioIcSsH7YMjCuLEGKbNTlhDGjNIzFVRlF6FN7H3ab8YA8eTqHLxMMKCvThgtQzHi
	aYrIyWqIF
X-Google-Smtp-Source: AGHT+IHihbZvdnYYDfqQYS9Hgz8z5Z3z4PweP7imJlwjMD1yaS93kmhWHJcx0wBiJ8Y5JrB0JR4bZA==
X-Received: by 2002:a05:6e02:3041:b0:3d4:6dd2:3989 with SMTP id e9e14a558f8ab-3d483a88a3emr151134105ab.20.1742213473560;
        Mon, 17 Mar 2025 05:11:13 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a666583sm26051995ab.16.2025.03.17.05.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 05:11:13 -0700 (PDT)
Message-ID: <26f931a0-602b-45a9-a533-b297033655ae@riscstar.com>
Date: Mon, 17 Mar 2025 07:11:11 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] pinctrl: spacemit: enable config option
To: Geert Uytterhoeven <geert@linux-m68k.org>, Yixun Lan <dlan@gentoo.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alex Elder <elder@kernel.org>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, spacemit@lists.linux.dev,
 Conor Dooley <conor.dooley@microchip.com>
References: <20250218-k1-pinctrl-option-v3-1-36e031e0da1b@gentoo.org>
 <CAMuHMdV4xWLEuCvCC54GBfCdELE=QSHqaOyUPD-ezE0QLYRnVA@mail.gmail.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <CAMuHMdV4xWLEuCvCC54GBfCdELE=QSHqaOyUPD-ezE0QLYRnVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/17/25 3:18 AM, Geert Uytterhoeven wrote:
> Hi Yixun,
> 
> Thanks for your patch, which is now commit 7ff4faba63571c51
> ("pinctrl: spacemit: enable config option") in v6.14-rc7.
> 
> On Tue, 18 Feb 2025 at 01:32, Yixun Lan <dlan@gentoo.org> wrote:
>> Pinctrl is an essential driver for SpacemiT's SoC,
>> The uart driver requires it, same as sd card driver,
>> so let's enable it by default for this SoC.
>>
>> The CONFIG_PINCTRL_SPACEMIT_K1 isn't enabled when using
>> 'make defconfig' to select kernel configuration options.
>> This result in a broken uart driver where fail at probe()
>> stage due to no pins found.
> 
> Perhaps this is an issue with the uart driver?
> I just disabled CONFIG_PINCTRL_RZA2 on RZA2MEVB (which is one of the
> few Renesas platforms where the pin control driver is not enabled by
> default, for saving memory), and the system booted fine into a Debian
> nfsroot.  Probe order of some devices did change, and "Trying to
> probe devices needed for running init" was printed.
> 
>> Fixes: a83c29e1d145 ("pinctrl: spacemit: add support for SpacemiT K1 SoC")
>> Reported-by: Alex Elder <elder@kernel.org>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> Tested-by: Alex Elder <elder@riscstar.com>
>> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> 
>> --- a/drivers/pinctrl/spacemit/Kconfig
>> +++ b/drivers/pinctrl/spacemit/Kconfig
>> @@ -4,9 +4,10 @@
>>   #
>>
>>   config PINCTRL_SPACEMIT_K1
>> -       tristate "SpacemiT K1 SoC Pinctrl driver"
>> +       bool "SpacemiT K1 SoC Pinctrl driver"
>>          depends on ARCH_SPACEMIT || COMPILE_TEST
>>          depends on OF
>> +       default y
> 
> Ouch, fix sent...
> "[PATCH] pinctrl: spacemit: PINCTRL_SPACEMIT_K1 should not default to
> y unconditionally"
> https://lore.kernel.org/6881b8d1ad74ac780af8a974e604b5ef3f5d4aad.1742198691.git.geert+renesas@glider.be

This is interesting; what you say was what was proposed in v1
of the patch series.

I did not understand COMPILE_TEST to be used the way you say,
but I think that just means you understood it better than I do.

I think the rule is that "depends on FOO || COMPILE_TEST" alone
is fine.  But if you are going to specify a default, it should
be "default FOO" and not "default y".

Thanks for pointing this out.  I'll go respond to your patch.

					-Alex

>>          select GENERIC_PINCTRL_GROUPS
>>          select GENERIC_PINMUX_FUNCTIONS
>>          select GENERIC_PINCONF
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 



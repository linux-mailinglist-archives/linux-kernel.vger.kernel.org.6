Return-Path: <linux-kernel+bounces-432780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362D29E503F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59FB28193C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F7A1D47C1;
	Thu,  5 Dec 2024 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ZigRGVxg"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABD71D3566
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 08:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388707; cv=none; b=YTZlV9jM1L1GwV3b6ZGAW+VOGHC2mRTZ0VCzWEz35UDcT2tflHyRilq0+kFwI7RFF0YJPhcotjsuirTK7uIkvhGOqxNik2LH8e0AkNXJ2l5V5jGcETGOjxYHIpWLPmaxaZvUz7mTe4tnRWpxTpNgK/Qvgzpijwla0IbGOJq2h1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388707; c=relaxed/simple;
	bh=fiqkj+GRvZeuFOzolqiFGreSPgcdv0TDsi5dd2Towps=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=cpWAKA+x4Bxvehv7yn6UNeo6qQ1+hJRsOzMyO4HFIqCHSph/szL7r3cRiBFNBOLfykozbvQd9Q/pHTy/yaz8CLik1JvU1Xxt+RFg73CT09He/hYTgxCjkZiFY4qbh96WDzkCB3zHPXvfnHdf5rpqLtziQH7ARd42X10MBbe+jHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ZigRGVxg; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385de9f789cso470011f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 00:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733388704; x=1733993504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bu+BjISWLkOjToTmmpDVh9uIKwI+akwDpSA5Z73Jrm4=;
        b=ZigRGVxggyVTIVSZqINO1vdP34ggLGFkV9u7KMUIeTdeXZoW2BZlnIgsFhbl/kSAAf
         USWscXPqzXmunwlKidYk4SWuDx1FjSHdRgLU8YYngUNJOgBnUWXnP+35b1vkr8BrAj7C
         IdZqXctQzTyFwPpa1FC2RkArIqWsnF1Oky/SbFsl4fmL8e60a89jPjQoM4cC6mltHBrG
         YIeE0kzr4k3q72KMzOvIM6Xdl8gWOV3fVSsMQU963ygBOvGR3WzJVMhd71T0Gps6Uaij
         Sz8o/B0acJSJC3ad7kOIsTDsr9Q3/JJpWb9sGsjHE3mQQNUCNy1FV+NXeDdwR+J4MRXT
         oBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733388704; x=1733993504;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bu+BjISWLkOjToTmmpDVh9uIKwI+akwDpSA5Z73Jrm4=;
        b=AuYuIsjrHrM5gfS0On30xKh1A3ZOUhpdlRxyEi76opOenTMxEPhvSyaDDuKUkKkj9i
         x+g6Kzhf9Wl7u/Ea0q0wP4cpj/IQuBAz52h7ldrkHoSRR+EETFnr34rUuFWZmV8+0lap
         SeMMVntmeRELu798yPSzfxcu6GTYtthqVnCCwXRBCLhXzkHEl8TUqmZQ+T6ZG9dffX+1
         NDuMiix5kNi/pVdJVsfkrXxNnBfIcNoYsro9u8HlCn26SjQPzWFkqyAYdSTm8g/EG9Ri
         /E9A0gb5Mb98oOnGRL+rexKIzF4LTIy4gjvSvH4+kiBoro6eFbj1wmxXsCJIU3uLdLCg
         XWgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgn+CnBVRwzJOqLfMP1TyTnlTbrlBAoiXzgpMIoIREA1yAJUbjVru93DRhBvi7Q8HGafskOu7cWrYsVPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcc4xiPHXu0ZAa+sAg1oxKxhM3w/oIBt9tv5LdmUvDotC56uJ8
	RLcHcsp8XFcrRRiP9jZtVRkm0H4lYSO0vsezqZM48l+/YltOjI1tX5mSvsBpWpg=
X-Gm-Gg: ASbGnctbEvbnu6GRhQ3YaTUTXzKB/f1eDUQ7e/+HpSSlbLcWqZuJo41kHHNTsLFfyY1
	6Y4e87IdQ9niDAX62ml96q4WUCdThixAXD/77sCVpOMYjEcHmRcfRpB8vj+90rIngp+g6RlFTDL
	OdCv8PMKPtkINRVTPNEYjSQuzH/3rQwY1LR3qEYDegYj0zf4jxPEsQTvzZryQEV2sevoFqq1u6N
	ntit1HQwy2u0+KfmwZZiKRZx7bRGFMhMZgAv190+26T/6/74UYiZnGPqIA=
X-Google-Smtp-Source: AGHT+IEOpwQyKT2ZzfkreqlTf5liiEt9p2jfLaHmcGM387ZkeDSElvomTcEaXCXFcRKTLDZIbgydFg==
X-Received: by 2002:a05:6000:1446:b0:385:ee3f:5cc6 with SMTP id ffacd0b85a97d-385fd4395c7mr6706652f8f.58.1733388703231;
        Thu, 05 Dec 2024 00:51:43 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621fbbe50sm1326046f8f.99.2024.12.05.00.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 00:51:42 -0800 (PST)
Message-ID: <1d8ea5f9-deb1-4236-ad64-d29a69a44aa2@tuxon.dev>
Date: Thu, 5 Dec 2024 10:51:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 0/6] serial: sh-sci: Fixes for earlycon and
 keep_bootcon
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, geert+renesas@glider.be,
 prabhakar.mahadev-lad.rj@bp.renesas.com, lethal@linux-sh.org,
 g.liakhovetski@gmx.de, groeck@chromium.org, mka@chromium.org,
 ulrich.hecht+renesas@gmail.com, ysato@users.sourceforge.jp,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20241204155806.3781200-1-claudiu.beznea.uj@bp.renesas.com>
 <Z1DLyQdzUzJzRUJJ@shikoro> <b6c7b4d3-021c-4a4b-9e91-316603b348c1@tuxon.dev>
In-Reply-To: <b6c7b4d3-021c-4a4b-9e91-316603b348c1@tuxon.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Wolfram,

On 05.12.2024 10:39, Claudiu Beznea wrote:
> Hi, Wolfram,
> 
> On 04.12.2024 23:38, Wolfram Sang wrote:
>> Hi Claudiu,
>>
>>> in the following scenarios:
>>>
>>> 1/ "earlycon keep_bootcon" were present in bootargs
>>> 2/ only "earlycon" was present in bootargs
>>> 3/ none of the "earlycon" or "earlycon keep_bootcon" were present in
>>>    bootargs
>> ...
>>> Please give it a try on your devices as well.
>>
>> Will happily do so. Is there something to look for? Except for "it
>> works"?

Sorry, I noticed I missed to provide a clear answer your question: if boot
works for this scenarios we should be OK.

> 
> As this code touches the earlycon functionality, of interest are the 3
> cases highlighted above:
> 
> 1/ "earlycon keep_bootcon" are both present in bootargs
> 2/ only "earlycon" is present in bootargs
> 3/ none of the "earlycon" or "earlycon keep_bootcon" are present in
>    bootargs
> 
> One other thing, that I was currently able to test only on RZ/G3S, is to
> see how it behaves when the debug serial is described in DT with an alias
> other than zero. E.g., on [1] the debug serial alias on RZ/G3S was changed
> from 0 to 3. With the new alias (3) there were issues that I've tried to
> fix with this series.

If you can also check:
- it boots in this case and
- the serial device with alias zero and the debug serial are both working
  (tx, rx are working) after boot

then we can declare it OK as well.

Thank you,
Claudiu

> 
> Thank you for checking it,
> Claudiu
> 
> [1]
> https://lore.kernel.org/all/20241115134401.3893008-6-claudiu.beznea.uj@bp.renesas.com/
> 
>>
>> Happy hacking,
>>
>>    Wolfram
>>


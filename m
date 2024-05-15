Return-Path: <linux-kernel+bounces-179899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9718C6721
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4EF1C20E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 13:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4B612BEBE;
	Wed, 15 May 2024 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="v+12ub72"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD1412B16C
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 13:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715778824; cv=none; b=lD0fgFR0zF+2sSYA/1GHlXOHBha1qge8pdJiSHgq0QSlVeOy5xaW6qGJjwi8qXz/srmuIgv4j2KP8SGLTQYv0dyBarOfvHQjoKyGRngrBrjNSBquBi35SYKHWBV66BiV7r2kfpJ6SUt/ZuDFGWIymBFGAx0bUvStGmLmZTAliDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715778824; c=relaxed/simple;
	bh=t1GL/VLTmYGsAxw6mUtAF631CxA1tvSVOImVMs6ckaQ=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=IA5yTCK635JKoaRFZW/NSeuTW4BbE4ub2HcKiYizPr+gtIxQyNd9KERl8iDKEvWSW2dWLGnVavRZBHTu4VYS54Qe9jiplB70Ub5GW9+2f8LobbvS/OWQyJqatx4PkbLIP6fFKnZ4xTlQox4iy+x0j8QXqReXmm9IGNesfErAA58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=v+12ub72; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41fd5dc04f0so43972635e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 06:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715778820; x=1716383620; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=M91H+nHHqkLBLg1QqXRG3fezduhANXnoUy1GZJinJLM=;
        b=v+12ub72VVs+HLnmCjwXLVOm4QNJ+vIQGJbxKnI+CIv/3UgDf8KEaMYg2Zw10RQANg
         dbdoK44j3YA6VB0uX8B4fCZDIjTM3MkkuLeXBXJCk66hmWmVRIA933aPMmR66CC8gual
         PqPlepbZhzO5Hu1J7J4qhxjO3uumAmeV/zQnnFXDQJ0Q/W7CU+a4JdKCF64WJbni0NKA
         agyHdHjCcoAoTQPK81BEqxI9sUdemjYEQG1GPrLnRHEsz3CkJV6MQ+hga2bAvu/gX5mO
         HNcO3FPdueoINsncm4lK2xChJm8BgXcB3F3rtBjYfi89MDpKg8K83xfUwK3HWuOnxhsd
         iNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715778820; x=1716383620;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M91H+nHHqkLBLg1QqXRG3fezduhANXnoUy1GZJinJLM=;
        b=EJ2Jl7LfjNWob/k1485H3I0A6YgNAJVBXfebMTHEizHG1RVnVFcBpT52aj4uxLZo0y
         ED9NWHaqbKp5HGeM/KqgQ8AmHgHcEaOo+fmsuR7RJG+5Lb5bhvApLJ0RIdW0RX1xKqrw
         8eDjNvAAk31cmg4bwzxuk2//BQ2VMLsxo7HoP4W70+k0blTy1C4Nvlu+WVSe/kG2uwbM
         xlx0SWeVqkXw65SZCwYWV0FgQY8KVf81AnVFaEAdIQIwX84Ct2gpvjVRX840FR1SOM8/
         rufqoUDtrbO47rvAvgXkSwaw8sD5OJIxFaxcy0fGmL++vQI+3S/gAhiu4oudeFZK5IpB
         8Vmg==
X-Forwarded-Encrypted: i=1; AJvYcCUn/J4iGeziwh3eWf7fa14sGcYcJnefVo41/Ubv/j7pA+vo2GeY7OloNJNXQqVQOSg0TVrLAr2yQsXkgoadccq5gb81z064IIohWHJi
X-Gm-Message-State: AOJu0YyeVAe7kqdZNSdi7sr3rc1A5qaMrhmNcB2cYd468NtfhZyfXbne
	JXASbZ/sNSVsrXkPR81OXjM5AQU/EWHmvD46vBca5Hl9/eAGd0Owax8LtFXm7NQ=
X-Google-Smtp-Source: AGHT+IFGKx5BSWfW3mhzW8qqzYmSwVybzwb9nvOAxYK14fvZAmTCWSio0KnxCN2xyBvzkP9/4QqX4Q==
X-Received: by 2002:a05:600c:1c9f:b0:41f:aef0:9349 with SMTP id 5b1f17b1804b1-41feac556f1mr169219155e9.25.1715778818567;
        Wed, 15 May 2024 06:13:38 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:2893:1a8f:5988:776a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f88110fedsm270535765e9.31.2024.05.15.06.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 06:13:38 -0700 (PDT)
References: <20240510090933.19464-1-ddrokosov@salutedevices.com>
 <20240510090933.19464-2-ddrokosov@salutedevices.com>
 <1jfrulzxms.fsf@starbuckisacylon.baylibre.com>
 <20240513214728.g4isbfisifxalqxy@CAB-WSD-L081021>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, neil.armstrong@linaro.org,
 mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
 martin.blumenstingl@googlemail.com, jian.hu@amlogic.com,
 kernel@sberdevices.ru, rockosov@gmail.com,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/7] clk: meson: introduce 'INIT_ONCE' flag to
 eliminate init for enabled PLL
Date: Wed, 15 May 2024 15:12:02 +0200
In-reply-to: <20240513214728.g4isbfisifxalqxy@CAB-WSD-L081021>
Message-ID: <1jle4bxloe.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Tue 14 May 2024 at 00:47, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

>> 
>> I agree that currently that carefully reading the code clears that up
>> but it is misleading
>> 
>> CLK_MESON_PLL_EN_NOINIT ?
>>                         
>
> I have been considering this name and its derivatives, such as:
>
>     CLK_MESON_PLL_SKIP_ENABLED

>     CLK_MESON_PLL_NOINIT_ENABLED

That one accurately describes what you do.
Use this one please


Return-Path: <linux-kernel+bounces-287653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59186952ADD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C9E1F2344F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 08:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174F11B32D5;
	Thu, 15 Aug 2024 08:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGa3Bud8"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D487E176AA9;
	Thu, 15 Aug 2024 08:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723709898; cv=none; b=PxKQjnAy0+HUHsv1oQHlVaYWbh6UiuSIcT/5GcAv57/KLlP3pjRWNz/nZhuhMvrt8PIMeTDzCZhj7GysIxtteTT5G3ltMZ253p/4KYT36i9zHwzwGm7M45DaFXOYCnP7jjrDYiLFq8GZc10jWewVV2pJtWnuoDW4QJKaad2OyOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723709898; c=relaxed/simple;
	bh=SCMcZlsxOg0bWvNs9re2KNKekbWFq534OYjgFt++y9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kM4ILjrm9ZTdx3Z3cv1gdpZPc/dGpWDUf0LNy9ceODa84T7X4kq/YcbV5XJJzodC5VjS21A6q0GeaBmWYxSfMd+GaA00aKpnGen/6raSzRSJ413AZLu4bKHxeMmWaKyRvvoUlhdmVNnZWGSuaN0Z6dmEwQLWiX25V//37Fj9E98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGa3Bud8; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bebd3b7c22so426406a12.0;
        Thu, 15 Aug 2024 01:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723709895; x=1724314695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YvlAxY1bGtRdImuOWaDEOzlQq4rW/Tt8gXa2bjpqACU=;
        b=OGa3Bud8MN0IezW/IgUGaNQfBWnEZWqcOpsYP9YfKXtWvaGtXDchdOqaPD+Y17JOgC
         PLFulw9PnGZcsrCILN7IMmeiYmJQUlSc9Xb7n1GgEvoEpTQI5QbIPRax5glykIxc/JIT
         22GmggLT8aN/f15LgUw0mDC7UJZ/7SgPTsCd92bJWF3GKWY98BaFC2VptohEhtmzxGU4
         x1BUhn1qoFp0T1oe+Zzt7PeZm54Z5TWdG7N9D5ITFRtmOBCeVYKVCP0pIBc83KJXwluc
         hk6xuy5jIcRPgwFP2sJhjHd1HrOmygRrYkpCjy5jiFYvKU0XVJkUJlWQ40zH7ghk86U2
         WSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723709895; x=1724314695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvlAxY1bGtRdImuOWaDEOzlQq4rW/Tt8gXa2bjpqACU=;
        b=FmxGaJz5L9qdOBxn4oT3y0b3rqM64AjpiBaQ9XO3Pdl0u1NUNPOQ+0grlRblmhbpSh
         8CE4rAjRikJR9InJhbyJF6mT92z4JNx5kNKX8ApbrvffF7B57Cv3R6ZEmIpFJfcMhrdb
         YaYAi+g3VKfR1pmZonMwMD+yrVybSKc8JdB60AISoJl/z/H06c4rtxsJ/7V4J3Fm7j32
         YQf42Dmi0TC2T1r5I00JzYEQUCTROFg5nHZgutEvfDMFhMokvJcODPNZyrpHmrcYj9FK
         hzF2Mra+4dOGpjSJMGnEwJQOJqn6c9get1G0leIDyHcAkpD+6oX+eMnq8ulKoT1bNf4K
         /NCA==
X-Forwarded-Encrypted: i=1; AJvYcCWrSKGs2wAya59+AyfkVqy2QXMx9hSdf9qJ92p2+/cxka+xBG586126fhIDD7VZt88/7LQkc4yve5LFqNVoetEHsMJbmWIKdiFNGiEHQ/eHWfRict7ku0c4G/wJ078MVfBBhxpuD2looA==
X-Gm-Message-State: AOJu0YyhCwEZa4VWw7J4AhQ2To6qpZKgfqa/mqwZiKQJTAzhmhEL5kci
	jlvL5lZ1a2fNRfBdVs47ezHjUYgg2vssXQZwTZ5OtePHmdmmzcip
X-Google-Smtp-Source: AGHT+IE7xZlpJZIQFRTzXgIhFT/EOuGwj2l3VlFwMzZs0V9OCOaAFcKyWalP5CtpVOtB/e1kDNE0mg==
X-Received: by 2002:a17:906:f598:b0:a72:64f0:552e with SMTP id a640c23a62f3a-a837cca3904mr205621466b.19.1723709894756;
        Thu, 15 Aug 2024 01:18:14 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839342f6sm63839666b.137.2024.08.15.01.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 01:18:14 -0700 (PDT)
Date: Thu, 15 Aug 2024 10:18:12 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 2/2] arm64: dts: sprd: sc2731: rename fuel gauge
 node to be generic
Message-ID: <Zr25xAv65+fd/qHW@standask-GA-A55M-S2HP>
References: <cover.1720957783.git.stano.jakubek@gmail.com>
 <246c0c7763a432d4bebcb0e99b90dcf4cded333d.1720957783.git.stano.jakubek@gmail.com>
 <172364518667.95114.7859805701643557423.b4-ty@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172364518667.95114.7859805701643557423.b4-ty@linaro.org>

On Wed, Aug 14, 2024 at 04:20:29PM +0200, Krzysztof Kozlowski wrote:
> 
> On Sun, 14 Jul 2024 13:57:00 +0200, Stanislav Jakubek wrote:
> > According to DT spec, node names should be generic. Rename the
> > sprd,sc2731-fgu node to a more generic "fuel-gauge".
> > 
> > 
> 
> This also waits for something... so I grabbed it.
> 
> Applied, thanks!
> 
> [2/2] arm64: dts: sprd: sc2731: rename fuel gauge node to be generic
>       https://git.kernel.org/krzk/linux-dt/c/e06e908dba9fed62c9493ea5cea2e4cbd306d23c
> 
> Best regards,
> -- 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Hi Krzysztof,

you already applied this change as part of [1].

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit?id=0dcc203956537696e6f936eef886fde70e049f54

Cheers,
Stanislav


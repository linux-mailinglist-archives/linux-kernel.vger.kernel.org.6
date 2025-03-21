Return-Path: <linux-kernel+bounces-570653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6371A6B302
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 03:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6923A3AB862
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 02:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70131E260C;
	Fri, 21 Mar 2025 02:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="K/mHHBl9"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92804208A7
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 02:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742524558; cv=none; b=Namom+VG8OcEo7TZ4U53BeJZJkn/g+gqtiQ1zlqpjx8jreDPHNYj77zxKChP2Q0UmvGozyi3BSBij3/Wi0ec9H2EDLQMtL8NKrSnmVmxQ1keUU+EkU4Mqa3K4N8C2MUor9ntHrdvmiIitEVqdCRab4uNQ58B7iYHgijmfE/nvXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742524558; c=relaxed/simple;
	bh=BE8jlk33PSooCmmTKi3YitnAtNd4pRxBjaru26b720c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6e03JJeT7sJMEOoN2JQHyc9Rpwi6Dlgurro8U8iCsQCTHEeEQhgT91BQuJIxQ8R6OtLDlD/8f+s35IIZXPi1RKyTfsy0IqGYR74QFX7lmLWPD9PaiyhHjh506xvopgj8AsPmymSwX2cIj/Zt/dVXseIV8YeFCdmw14SppIwTuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=K/mHHBl9; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 56C5E3F2BD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 02:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742524552;
	bh=+59sSS/+H+AM/QNXIwPCiTuvLYKPkjZvDqMYqhJDfO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=K/mHHBl9x0EjGX1+rMZ64eM0/Wt3Jq9M7hPM3j4FrndrYmhbVQxP0jfwUOVb2Cw9V
	 EP5ESvmaLJ1Z8/GLK6lp9/dDFsWphQ3S52uYoZf0bL6d8g9U8mZPiSTAyDGwcHjKOg
	 IEf9A4n2rDWHEsCfuLLQzISIKG4Yl75C4jNvxV18svARZf7KUSnCYx1KabRNzf8F2V
	 cARttQqp0uSNy+WQRGq4CBi4KycXxglII4c8Zlt031lLMKiotEJ1Ks2suG4AzT04Si
	 tBTnDDk48PlcKpqKxAgzhf+IgFaMSTnmEZyr7fBGcT1K1BMwjTYHgRQLAh6wJ76zOU
	 AZaUUxRupA/qQ==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3011c150130so2327084a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 19:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742524550; x=1743129350;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+59sSS/+H+AM/QNXIwPCiTuvLYKPkjZvDqMYqhJDfO0=;
        b=tyRwBDGwg9l28+mD9oWg1f/DOg2ULef57OrO7MaZOWrUWip1FnDRX79QxEQbWacN7M
         1FwD6gKYlx6J9VagkR6TwOPTOAAyIhQ+nEZC10Qwxn1qcV10n0qApPKJuX3sVLwOd3hh
         pO7zzXxAKKRD3EDDjhHUHmhJT6aEYR1NBy5YihUXxJyhpPldRPoHAhKz+cgeS4ZsaUU3
         sza97nWHlA69i11oP6d4zzDazzorrXweVsDCKK/zUNWXZ5Hez8jUkmpE+tCw5hy1Y9rX
         EPjLE+Gy6ktbvskxxsdulA7X7WU5EXDTvdz5Tlp6NrAcPO2vH8ABsOS8PsJW5Z4/7xQE
         BCCw==
X-Forwarded-Encrypted: i=1; AJvYcCWoCZyT58VqzMQxMgCkaD3uCDrXfJC8HzFZpzaGbqxgCS9D0iTpHgJSm8TuiJZTbkAWwkr+5lXnW63BzWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpSH+Ha6bdH06VpjCqk2F8wlS9O9xrfw4QignVpLqtGbY1N5AB
	AuzxQOQcMyjaIvO3DVQG94eGFVgwnMDDEAAvfIhManJnLTWkswnF7ag2vCntQWo/1pEddz6Kxpp
	r06koMD1q7eYSiyYC+c1ccnLSoUyGfDNh02lBjIXxQ/z1mMczzmmsz5O8iSIVkXUcUGSMc+uYV3
	Yc3w==
X-Gm-Gg: ASbGncshrzxervI6RW9xzEoR1nU3ck5r7qL2ZI5woV+5Ef3y25Ew1H7eGs/eSNSUXgm
	GudDVbNo6jXhmXjC3r3Jpef6mSeRJSWyZAnvJA4IiTDg/8Nkvgw1Ms8tK+UAtl4TJInO9pj0+bq
	jenYQtM5fQBUR0/UwtWDGl3sCARsulhYNbtqojb5nMynKaTVUoA95cbid5S83Hl7oOHK4NwOGps
	8IHgHfVvOsOaGixNVfNBr1U/vrLEbpQ7r7+qJoSsGTsDAIZaWul39OMoDaFbeWzm280fKseELwI
	8+K+0ZQfwshuYwkrRQ==
X-Received: by 2002:a17:90b:28c4:b0:2fe:a742:51b0 with SMTP id 98e67ed59e1d1-3031002af0fmr2361492a91.31.1742524550512;
        Thu, 20 Mar 2025 19:35:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsivSswYTsxCGRVr+akOaH/124FWuyZyG9yFJTLTdUNp/4V3EIGzgEeFD5Wz4qmuJPl9nqjQ==
X-Received: by 2002:a17:90b:28c4:b0:2fe:a742:51b0 with SMTP id 98e67ed59e1d1-3031002af0fmr2361354a91.31.1742524550126;
        Thu, 20 Mar 2025 19:35:50 -0700 (PDT)
Received: from localhost ([240f:74:7be:1:2dba:1af7:27b6:24fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811e34dasm5396765ad.199.2025.03.20.19.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 19:35:49 -0700 (PDT)
Date: Fri, 21 Mar 2025 11:35:47 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, geert+renesas@glider.be, 
	linus.walleij@linaro.org, maciej.borzecki@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/9] gpio: aggregator: introduce basic configfs
 interface
Message-ID: <6mcl34zdx37gjh3a3y4lc5kgb2vv5notvs355oewiwogpgg5g7@jcuukymbifnm>
References: <20250315164123.1855142-1-koichiro.den@canonical.com>
 <20250315164123.1855142-5-koichiro.den@canonical.com>
 <CAMRc=MdOSsakJm4H5=cqVzdKDrrMFO2t-wKVWRCU83saozepxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdOSsakJm4H5=cqVzdKDrrMFO2t-wKVWRCU83saozepxQ@mail.gmail.com>

On Thu, Mar 20, 2025 at 04:54:26PM GMT, Bartosz Golaszewski wrote:
> On Sat, Mar 15, 2025 at 5:41 PM Koichiro Den <koichiro.den@canonical.com> wrote:
> >
> > ---(snip)---
> >
> > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> > ---
> >
> > @@ -90,6 +124,70 @@ static int aggr_add_gpio(struct gpio_aggregator *aggr, const char *key,
> >         return 0;
> >  }
> >
> > +static bool aggr_is_active(struct gpio_aggregator *aggr)
> 
> Series-wide: I would prefer a different prefix: why not
> gpio_aggregator or at least gpio_aggr?

Actually, that naming was intentional, but perhaps I could say this is just my
personal preference. Here is a breakdown of the function name prefixes:

  Before this patch series:
  * forwarder:        gpiochip_fwd_* + gpio_fwd_*
  * sysfs interface:  new_device/delete_device + aggr_*
  * platform device:  gpio_aggregator_*
  * module init/exit: gpio_aggregator_*

  After this patch series:
  * common utils:     aggr_*
  * forwarder:        gpiochip_fwd_* + gpio_fwd_*  <-- _Unchanged_
  * configfs:         gpio_aggr_*
  * sysfs interface:  new_device/delete_device     <-- _Unchanged_
  * platform device:  gpio_aggregator_*            <-- _Unchanged_
  * module init/exit: gpio_aggregator_*            <-- _Unchanged_

Do you still see the need to change as you suggested and send v7?

Koichiro

> 
> Other than that, looks good to me!
> 
> Bartosz


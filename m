Return-Path: <linux-kernel+bounces-571236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F61A6BAC1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A263B36C0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB30225797;
	Fri, 21 Mar 2025 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Yk85MFNm"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7D11EE7C6
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742560405; cv=none; b=jLyGgS2jNc+GaKqasAA40OkMldJbheTTTP78NakhIAt4KqYHnYrJF4uXbKJWTmfWJI38J4OpHmfjGDIHKAtu7iWJpObMgRO6sosbMcK++q1He5ctlmyUSThGa6Q8AgoegOWPngWXRFcuGMta59fE8MaLCJPCmGqUtBNDauL7D1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742560405; c=relaxed/simple;
	bh=yBmWZmP53UTI8j2igDDHeObdAJwMWLYoN999xGCve9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrAfrYB/YaRFVLUVJU8qu+x+soX69CxbdnmSk96BYsT3oUv3Md7tmCUnudmRJN/HNSmO73LC14Ix1GIoNshGwLfG8H8lMvvN8WUwJax/uyKbWAlipJCdz1ZlwGBjV9elqJuJCLRFzZw6MpiLtA2wHbOc23Zmmzo/RDspkH9cSlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Yk85MFNm; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 664633F682
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742560400;
	bh=b+qYcKK82ubSV6/PFWUwub7oSXzcshnlWJCFkhjQcKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=Yk85MFNmPuC4d6PXTfiBwCWqeY+bOxhoJTJB4DAbdCxrpOawN57aG51NCtOQt+xdc
	 2wRkulUHkYB5F7uo5H8yAHqSW1JqBumWUHULs9FF59sa8bnqsMbaHUUvf9Vdqd6K4H
	 1V2WrnzUPUteYpqUFY67Jh6ChL62DAM5YYY97iWq0xI5RUDToit5jEhnPjjURMYNVd
	 7g8BuWIr4pJ1es5U/y1ulk9dQphUv+0OuXbn3b49IcixA1AOPpmwxSfDD8Oz/R/lJY
	 AmNxunVIcUjJgPMbY84UfsUg5wj/05B/iKnshsohZ2jrXU1kpelYOJTIT5tIuV5RYX
	 ZQ2o2OBo2m2hw==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff798e8c90so3085701a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742560399; x=1743165199;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+qYcKK82ubSV6/PFWUwub7oSXzcshnlWJCFkhjQcKs=;
        b=Es+IYxkXEXLq+Xwslj6M6oVOl3oXc6SkzfcQelmQARECeZAITI5rAkzZ68+ACzhfAW
         sNo6Wx/VjbzGC1uLxzATAnNG2ZEJCcubTPSb38uljGFOaLcs2ZZNSrubbDMF8uk1mqrC
         Yf7MzUeGUptfkWJ7d/X9AjTX9i+ZTCLyBw8kOlS/UkyEZYdOfb8o2VQMSurArzft2DHz
         32pafGs7nJy14lEt9Pk2sXkluvX8MdmmnspW9PO49SeEA9gpn6ZMT/piFHFtfM4u3Nqu
         QM1ryMcYrJTkKidIDifhRqyUQCgoAjZMWpZt8ptr5gLueQgErMHMCn8yYgDCscHCjM3C
         IBnw==
X-Forwarded-Encrypted: i=1; AJvYcCUIo92PYiLIChZjXjRTAuw7FS252Go3Pi6GOp5Bs211TRYoeaEo0QQEjGUoBFMt+MLnDCfy0AX1tQyrsMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqIEQsTcMt7uD2QG1gj6hXs0ECIs9phd1uYZ8nt1rw8/xFaXWY
	EPzJ0J6IOBEZ6QwIdD30fTl/hzgN8U3J7kXbdc45slgzGGsyxe+nPflEF6cDw0xmaQTQUSod7JZ
	7/JK3Ly+1Jz7zv4Df4pF8GZtF5f7sWKP9a+rsfnR+mle+F/3jzpG/B9OEFsbrx4GvZZ2zGysEln
	z0EQ==
X-Gm-Gg: ASbGncsA8iiWXIf/0jCO/TGmgbV7EcX1mOJwx/fd5i9rPmCEJgc9dV3cKLYcJkUPT+y
	F6BA5a2IFBB2rPeJUkXTcYNdM6OxtheyZWyhO/xPWC23xnZMJA2q2fY0K+LoebWw8aJp+LcZiDT
	cOmBYOOB3U6b7xRcOwjKj3X8h9lsn/vW9s7ai0Td7Ek4Mn8Q/AT57Gzrw48PkeqQDv3RezbqbpH
	GGylUnR3EmEbQcTtyJ4OrOCHP+brDhuIqDdKEGdBM7FOmQDyZYkRpVJ1iqeLZFx1OR7TxpdEHdb
	2Ma39RLBS0oTNh609Q==
X-Received: by 2002:a17:90b:2d0c:b0:2fa:1e3e:9be5 with SMTP id 98e67ed59e1d1-3030fd769d1mr6408000a91.0.1742560398812;
        Fri, 21 Mar 2025 05:33:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs5vBj1ckmfc3WDb7h6jw+MxrxntJ6dKT2MUeNkW2OZEUjTKQbq883hHjlPKZDz+zvaOU8Zw==
X-Received: by 2002:a17:90b:2d0c:b0:2fa:1e3e:9be5 with SMTP id 98e67ed59e1d1-3030fd769d1mr6407969a91.0.1742560398483;
        Fri, 21 Mar 2025 05:33:18 -0700 (PDT)
Received: from localhost ([240f:74:7be:1:2dba:1af7:27b6:24fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf61b34dsm5886695a91.30.2025.03.21.05.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 05:33:18 -0700 (PDT)
Date: Fri, 21 Mar 2025 21:33:16 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, geert+renesas@glider.be, 
	linus.walleij@linaro.org, maciej.borzecki@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/9] gpio: aggregator: introduce basic configfs
 interface
Message-ID: <oneoncbyv3iwb54kvjvmerv4xxhixgeqp44ubeikvy4yst3az3@g5c7uxgkonbx>
References: <20250315164123.1855142-1-koichiro.den@canonical.com>
 <20250315164123.1855142-5-koichiro.den@canonical.com>
 <CAMRc=MdOSsakJm4H5=cqVzdKDrrMFO2t-wKVWRCU83saozepxQ@mail.gmail.com>
 <6mcl34zdx37gjh3a3y4lc5kgb2vv5notvs355oewiwogpgg5g7@jcuukymbifnm>
 <CAMRc=McpqUsEsMSfwo+WrzWdaW6YnMbptpj3fAoS-JfVhSm9mQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McpqUsEsMSfwo+WrzWdaW6YnMbptpj3fAoS-JfVhSm9mQ@mail.gmail.com>

On Fri, Mar 21, 2025 at 12:18:02PM GMT, Bartosz Golaszewski wrote:
> On Fri, Mar 21, 2025 at 3:35 AM Koichiro Den <koichiro.den@canonical.com> wrote:
> >
> > On Thu, Mar 20, 2025 at 04:54:26PM GMT, Bartosz Golaszewski wrote:
> > > On Sat, Mar 15, 2025 at 5:41 PM Koichiro Den <koichiro.den@canonical.com> wrote:
> > > >
> > > > ---(snip)---
> > > >
> > > > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> > > > ---
> > > >
> > > > @@ -90,6 +124,70 @@ static int aggr_add_gpio(struct gpio_aggregator *aggr, const char *key,
> > > >         return 0;
> > > >  }
> > > >
> > > > +static bool aggr_is_active(struct gpio_aggregator *aggr)
> > >
> > > Series-wide: I would prefer a different prefix: why not
> > > gpio_aggregator or at least gpio_aggr?
> >
> > Actually, that naming was intentional, but perhaps I could say this is just my
> > personal preference. Here is a breakdown of the function name prefixes:
> >
> >   Before this patch series:
> >   * forwarder:        gpiochip_fwd_* + gpio_fwd_*
> >   * sysfs interface:  new_device/delete_device + aggr_*
> >   * platform device:  gpio_aggregator_*
> >   * module init/exit: gpio_aggregator_*
> 
> Yeah, it could use some more consistency. First: there's ongoing
> work[1] on moving the forwarder code into its own library which is a
> chance to change its prefix to gpio_forwarder_. You could add a patch
> renaming the sysfs interfaces while sending v7.
> 
> >
> >   After this patch series:
> >   * common utils:     aggr_*
> 
> I'd prefer to keep gpio_aggregator_ here...
> 
> >   * forwarder:        gpiochip_fwd_* + gpio_fwd_*  <-- _Unchanged_
> >   * configfs:         gpio_aggr_*
> 
> and here.
> 
> >   * sysfs interface:  new_device/delete_device     <-- _Unchanged_
> >   * platform device:  gpio_aggregator_*            <-- _Unchanged_
> >   * module init/exit: gpio_aggregator_*            <-- _Unchanged_
> >

Actually I wasn't aware of [1]. So let me summarize: does this match what
you have in mind?

  Before this patch series:
  * forwarder:        gpiochip_fwd_* + gpio_fwd_*
  * sysfs interface:  new_device/delete_device + aggr_*
  * platform device:  gpio_aggregator_*
  * module init/exit: gpio_aggregator_*

  After this patch series:
  * common utils:     gpio_aggregator_*
  * forwarder:        gpio_forwarder_*
  * configfs:         gpio_aggregator_*
  * sysfs interface:  new_device/delete_device     <-- _Unchanged_
  * platform device:  gpio_aggregator_*            <-- _Unchanged_
  * module init/exit: gpio_aggregator_*            <-- _Unchanged_

Thanks,

Koichiro

> 
> Bartosz
> 
> [1] https://lore.kernel.org/all/20250317-aaeon-up-board-pinctrl-support-v2-0-36126e30aa62@bootlin.com/


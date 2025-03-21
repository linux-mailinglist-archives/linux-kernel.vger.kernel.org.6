Return-Path: <linux-kernel+bounces-571281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CC5A6BB4A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA6A16312F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD8022A1E1;
	Fri, 21 Mar 2025 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="A26xq9I0"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8EB1F4C9B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742561890; cv=none; b=uXU6Np1zMqFZiXo9KNbUvhR0aWTGHHhmIKCxk382LHsWJE9cWdVfStyQCUWiBQefN9uNtfmzfLmQSdpdt2X8T+Lv0hF896XbIBMhKsNif+J6GvFbzEt6KND+l5+z6x2pJQwDBJ2s5PSDEAVjq69dBTwxEN2F4wbD9eHxvdzPa50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742561890; c=relaxed/simple;
	bh=z280nvWzjqH8OYHL1W8OEOgilfnYgC2eoWxNHeg0wg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DI8scHoPvg5LnHEkxjaOCqdUfuWUEzf+IoiZEawbhB9V4MTBBfIakYKioA8mNC4sOoiqci9CO0cT69osaai4WuzqfiDqAxHgxqHiUZ35Ytm+JpvY3L7gupqHU2/1y9nmU63QxxrsG7VoEjLMoNevQZNOso5sS9f04OGqx/qkG58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=A26xq9I0; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AD90F3FCCD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742561885;
	bh=X+ZxtkB2s36Lzp8qMWZfvuM9LlrSk+y4q9/dnnBXlIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=A26xq9I0DzptTmmF3/VAvZA8wXAIxY3PK3UxIwg4osY9Sl4UcSYaSnnHE3UjYsPNE
	 iHtc175uKyJ2e+iu4QNMXISqMGAHEvFUDETsfZQNIeBYIUCMi8ZFF9BS4RnUpi5hBr
	 0JVL1cLtJYRK85Z3PLQPpQvza42VEUiw+ZS5HagkY0CJz1MU6eojDGaUn64DfIjiaV
	 rZ0NLiSNMit83ZOGuS/h29NIzAC+2+j4JTC2vd6BpJm9oEYciqJHdBNGC+88wcBV5j
	 UftkPBEsmEq/2ztOadeNID0ju2gP4OsFPkLEZoqGv3B0paykWrbLWoVo58JxbYJxyw
	 SEn8+NZ2PybqA==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3010db05acfso3097286a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742561884; x=1743166684;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X+ZxtkB2s36Lzp8qMWZfvuM9LlrSk+y4q9/dnnBXlIc=;
        b=WQ82llDYlgBOgol5U2Z7WHaqz6lKvOUV1AaHs5GqxgK32Y6S4clJaRQD0JbXdzKfAL
         s8Hgn1v4WB2GYWFULo32cAc1wUpcKz+dxDYjPscA1t3wV27YN7Hp3QoogMp1CThVXAJv
         7trMDsQz9OiMwX0czmr/rLy2nExZrvRlSF+iNO0vIx3q3oePLnf8xNCs0JG8br3kPQhX
         rn6M6pie1H/GHDBGIxZbrGPuMrSud7BmD4nVAHEXjsqBGid3qtI6olP+GLp16tNwnArV
         bqSXkivlCsUm64RNqfrUdXgbVGUE14G8twkpwTp/XAT7jH0okMgbzL6SYuvsqDhOPHO4
         vayg==
X-Forwarded-Encrypted: i=1; AJvYcCUJiLw2bPK6tuK1mUmsCM3a4gbj3NIuc/QbDQwWOVEj7Lzx/pbvTtIdiVPyacs5uQ81AP573AA6LjTabxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDvjxEPLyYUFeIZ+wopaKCpsUdGMsCilz9U0fex05u/EkmQ6C5
	kp7kDiANzVQhVtt3TQnAu62Xr0bFAdyFxcBiOkK3slayJh6QRjenrNl3MM5P2L3KSMiO1JqFvwh
	PThQcqzCAHEhTcRKxlF6APcZyU2axVY9o9AWGXzwy8rMuAPhF5lEArW7bwQS+3kgJnQE33Kezk7
	g8BQ==
X-Gm-Gg: ASbGncswff2vTtawZPc35nqo27RCl7DgEUq6xeYsDxp0CKWii7QkAKuze77TCyVPo3L
	5bRvNba72ZLvceHuE74D/CIMVZrUE/Rx/3wY/ZSyphPkfhihMRK/Hq7lagMLU0P38DXBh9PYwI6
	CC8ZYZXp0iYCCxHoHDt7n7aIFdxfL/W70AyvuGVwXQO2S8gmvWQ54VZ/4CKZKufFO1HbTws9/GC
	LW+ABueNdsqDRtV1x9P6YoLyLCoR41+9H6d9ccwfJgR0oMQxefGiWDjtVaLMmTBVkYZ3chLhTxm
	jVnPE5kHGCGVS6Tg7A==
X-Received: by 2002:a05:6a20:12d4:b0:1f5:7ba7:69d3 with SMTP id adf61e73a8af0-1fe42f2c7d7mr5640357637.15.1742561884003;
        Fri, 21 Mar 2025 05:58:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAEIXvDR9YkcYynUamT4Rrj+f3xywPdxSw4vlWDu7dDWi1/XRMEfsrj2VE7GMw5RZlAgHBMQ==
X-Received: by 2002:a05:6a20:12d4:b0:1f5:7ba7:69d3 with SMTP id adf61e73a8af0-1fe42f2c7d7mr5640313637.15.1742561883547;
        Fri, 21 Mar 2025 05:58:03 -0700 (PDT)
Received: from localhost ([240f:74:7be:1:2dba:1af7:27b6:24fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73906158066sm1770268b3a.150.2025.03.21.05.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 05:58:03 -0700 (PDT)
Date: Fri, 21 Mar 2025 21:58:01 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, geert+renesas@glider.be, 
	linus.walleij@linaro.org, maciej.borzecki@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/9] gpio: aggregator: introduce basic configfs
 interface
Message-ID: <ufka2h6gbtjdvg3fokmhx3ql5h4chrbu7cooi6ej6vhxcblrog@j4gxuzb64atv>
References: <20250315164123.1855142-1-koichiro.den@canonical.com>
 <20250315164123.1855142-5-koichiro.den@canonical.com>
 <CAMRc=MdOSsakJm4H5=cqVzdKDrrMFO2t-wKVWRCU83saozepxQ@mail.gmail.com>
 <6mcl34zdx37gjh3a3y4lc5kgb2vv5notvs355oewiwogpgg5g7@jcuukymbifnm>
 <CAMRc=McpqUsEsMSfwo+WrzWdaW6YnMbptpj3fAoS-JfVhSm9mQ@mail.gmail.com>
 <oneoncbyv3iwb54kvjvmerv4xxhixgeqp44ubeikvy4yst3az3@g5c7uxgkonbx>
 <CAMRc=Mfg1aNUQ+HeJurEH15+6e8dhmDS480SLOcmwOGP1u+iyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mfg1aNUQ+HeJurEH15+6e8dhmDS480SLOcmwOGP1u+iyg@mail.gmail.com>

On Fri, Mar 21, 2025 at 01:42:49PM GMT, Bartosz Golaszewski wrote:
> On Fri, Mar 21, 2025 at 1:33 PM Koichiro Den <koichiro.den@canonical.com> wrote:
> >
> >
> > Actually I wasn't aware of [1]. So let me summarize: does this match what
> > you have in mind?
> >
> >   Before this patch series:
> >   * forwarder:        gpiochip_fwd_* + gpio_fwd_*
> >   * sysfs interface:  new_device/delete_device + aggr_*
> >   * platform device:  gpio_aggregator_*
> >   * module init/exit: gpio_aggregator_*
> >
> >   After this patch series:
> >   * common utils:     gpio_aggregator_*
> >   * forwarder:        gpio_forwarder_*
> 
> Best don't change it in this series unless you touch the code. If you
> do, then yes, gpio_forwarder_ works.

This patch series does not touch GPIO forwarder code, while touching all
the other things to some extent. Ok, I won't change prefixes for forwarder
codes.

> 
> >   * configfs:         gpio_aggregator_*
> >   * sysfs interface:  new_device/delete_device     <-- _Unchanged_
> 
> Do change this one to also use the gpio_aggregator_ prefix.

Alright, so what you want is: everything except GPIO forwarder code should
be prefixed with gpio_aggregator_ (perhaps except for some small exceptions
e.g.  to_gpio_aggregator()), right?

Thanks,

Koichiro

> 
> >   * platform device:  gpio_aggregator_*            <-- _Unchanged_
> >   * module init/exit: gpio_aggregator_*            <-- _Unchanged_
> >
> > Thanks,
> >
> > Koichiro
> >
> > >
> > > Bartosz
> > >
> > > [1] https://lore.kernel.org/all/20250317-aaeon-up-board-pinctrl-support-v2-0-36126e30aa62@bootlin.com/
> 
> Bartosz


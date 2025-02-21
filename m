Return-Path: <linux-kernel+bounces-525256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4723A3ED28
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE067013C2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 07:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28A61FBEB9;
	Fri, 21 Feb 2025 07:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuYzFNkm"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889918F6E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740122295; cv=none; b=LqdCsYWBjlxx1aeKO6yOlfThyo6/ehVjAcvnIkeF9BJ+dI3oIWQKxog/hJemHc+S8u6eV++26GYLXTjd+SAcOvus9q1iNq2r+9QD7U9H0Ry65MeNGtflgwE8+0+qm1rwXiQK3HGVStdC6fOxp/HEFDzZ3imZotvqEE+dHw5ysv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740122295; c=relaxed/simple;
	bh=sGZIS8kj1pom1MmnGtPQKKQgU7EhhwY8lTbBpZRJ+KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2krGLQ4WVsRp0NaTJ4NjaXh+/dblyJoKcUTqPNJ3KRg2NpPms/eHUqbfwDg10qUlvMXC6lAAjC22+ZaaSTJk/pNRcUxEE3kPDzQko+Ru5iMPQKepzLWVnEagvzBPDiKOcfMyyq7aPBnVGFqZ8FrZcOwLhpKG973UvgCUAiICoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuYzFNkm; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso17349355e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740122292; x=1740727092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VA1ZRNBjqp7yscOTi3r/FHvrtvUImlYVVtC0tQYvbJ0=;
        b=FuYzFNkmYYGLlovezQiL5nn4CUaU58a0VgKtz6FHMI7+9VAFkvOCja8NrlKNbJMP3L
         qKvrVN44xy/0j/H1fEyEZzbAjoXXYLe8Kss8iAJ8462yG7+ub9Dl/JO2Gmi7VrudELRM
         Wu66ImwaEh9Sb87G0TFWWsgblbMWvbRELAyq9uHVOKVFMYWYBo4DxwLdGYPYVmp3pb9M
         u22vV3NSH8szx4EDBHeUjdccY0B6eeREGnjBN+2Vos/brladZHmDCnnQ3JtMQo2EQLHC
         KP9KEqXouVMeRsQmkss4ygJAi7tdn02xqR6bPJR5cUraMm8bCxNJlvcuexjnDSMMP4ia
         X9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740122292; x=1740727092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VA1ZRNBjqp7yscOTi3r/FHvrtvUImlYVVtC0tQYvbJ0=;
        b=p+CfqogPR5AC3XhRmlhyI0X43rNYPRTqBAhrFyXqsAnFnwUxBENZ1ASuua/udi0Qnk
         qA6luwGIFoQ9ruu8YKXXY5lmXBtUTTJcFTiNxJFwFG9+Z7ViiY/LxUOfFzAhb+RAVa7S
         S6xlMtK2Au6yERueo0EOQsrSxnLviN/kohEG9hJjsQi1WUg7xQnc6hVrKDf4ZsTI2Bi4
         mEBZyXZxDlHKnnw3+tDaC8sVwPnOxQTgdJakiBnuvm7ojlOPPqhOnYrmJj6Td5fkNpOJ
         4q2B5mrDO4HbTA3L6lU9Kjt24BuQ8uEm8KGifYPqlJeYxb9MSWbMITILrtaxTSCGEB8V
         E2zg==
X-Forwarded-Encrypted: i=1; AJvYcCXAQhRGY3orIRLslyROSNzS4AyKRaz2qoDucZGLfFYT2rJbtUpg7/GdozXYv1ftKXXEK3XI5BEEX7UMVeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+AazGLz6rqw6Bpn/uXFAIbW8d05BNoVDj7uCegZJGk4/X79rZ
	0WkE/SyIfzSVObJYqETOdKk15+1eGHUagUe1woTSampA1LgOLPig
X-Gm-Gg: ASbGncucbR7VeXXwGXhcL3T4m5uhophFI1l8DklgWne2LCNRaHC8A2m+V15AEMn2AzM
	LvCBrEyxbic/qlYDTjiVs+w4skgpuXscnxw8+WMEcMh4IXduhCsMmCmrk0jCTwWpi0Rc3YxPnD6
	uVQQl0LFi0G5V3eMD5ZtI4jTm45U5LML62zg1ZMgdF8uWCu3qov2PaWNAwh0cipibM1zr5rzaxJ
	aJh4ejEAkPG4cfLavJpzE/LoYj71V9ySZp/gSwGWp3eo15BBNL425wjxqu+1eCc2T0PTIDLM/ng
	Zcjc6Sq//vdKoX1R/ptKqi/MDNhU0Rrm24jXrahr/vbxNburGtccI576aZU=
X-Google-Smtp-Source: AGHT+IGcmqoZKLItFnykBoAs00PCywkh0iIfnYdOfG5YsRkDoJu949fdzfkiJ6sY4SF/q78XHllfvw==
X-Received: by 2002:a05:600c:1991:b0:439:9dec:b7a2 with SMTP id 5b1f17b1804b1-439ae1d7505mr15992725e9.2.1740122291572;
        Thu, 20 Feb 2025 23:18:11 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02f3e15sm8427205e9.22.2025.02.20.23.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 23:18:10 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 0F09FBE2EE7; Fri, 21 Feb 2025 08:18:10 +0100 (CET)
Date: Fri, 21 Feb 2025 08:18:10 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Valentin Kleibel <valentin@vrvis.at>, Vinod Koul <vkoul@kernel.org>,
	Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v2 0/1] phy: rockchip: naneng-combphy: compatible reset
 with old DT
Message-ID: <Z7gosm7PJMR0zCg4@eldamar.lan>
References: <20250106100001.1344418-1-amadeus@jmu.edu.cn>
 <173831716590.670164.5196739962949646746.b4-ty@kernel.org>
 <f64ee4ee-7e56-4423-813e-b87e023e893d@vrvis.at>
 <D7VJOFXU540M.2PAC1RFXAH19B@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D7VJOFXU540M.2PAC1RFXAH19B@cknow.org>

Hi,

On Tue, Feb 18, 2025 at 12:45:34PM +0100, Diederik de Haas wrote:
> On Tue Feb 11, 2025 at 2:03 PM CET, Valentin Kleibel wrote:
> >>> Chukun Pan (1):
> >>>    phy: rockchip: naneng-combphy: compatible reset with old DT
> >> 
> >> Applied, thanks!
> >> 
> >> [1/1] phy: rockchip: naneng-combphy: compatible reset with old DT
> >>        commit: bff68d44135ce6714107e2f72069a79476c8073d
> >
> > Thanks for your work!
> > We found your patch after NVMes stopped working on a rock 3A with newer 
> > kernels and successfully applied it to kernel 6.1.128 (currently in debian).
> 
> FTR: I've reported it in Debian here: https://bugs.debian.org/1098250
> 
> I confirmed it (also) broke on kernel 6.12.8-1.

FWIW, we have several users in Debian reporting the problem, so if it
can be applied to mainline and then flow down to one of the next round
of stable series down to 6.1.y that would be highly appreicated.

Diederik, if you were able to test the fix, you might contribute a
Tested-by (although as I undestsand its not strictly needed at this
point as commit should be on way to mainline and stable series)?

Regards,
Salvatore


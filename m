Return-Path: <linux-kernel+bounces-216693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB5590A342
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 942A6B21241
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 05:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE913181315;
	Mon, 17 Jun 2024 05:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5Kxh85H"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D2EC136;
	Mon, 17 Jun 2024 05:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718600989; cv=none; b=N5uhLUf1al+c7fysADAwz8XOscw9s2fc+aR32Tyf6dS6dzZKuUuFFOb5JT0Fe+SZtqlHWDq0KhcBNzpRBcCYPahvkFiGUAj8bJXM+tK5YHC5WKkFOaPE0GmXzhz2NBoIBQOuQRlfpnVFjLp3FIi3Wkwv7y2rCjanu+QYcPFvLPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718600989; c=relaxed/simple;
	bh=X8BFyKxY6wBYbNa+fiV7J1CRgSjDZN/wvZjS2640onA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKmkln+0q34izZi30w6dt3rUpWb6ro9XnbzcWtAG5Se/gygow8caJbOo7x7zepfHfkgD9/gttDE3xrXILdx3NbmYJcmTXJ3vnOzCgX+VXo5qgsRxjEMvRyRqt8k25yN/5zw/xDs/PRyZ16AjoM5dbzSYhyUHrny6UF4k7RbIWnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5Kxh85H; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52c9034860dso4895922e87.2;
        Sun, 16 Jun 2024 22:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718600986; x=1719205786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uhrm9GRzpV6wkMAL+rfDjBKgrfJOqup9MGtDr2Lv6Hc=;
        b=c5Kxh85HttXyp+Wcz4wbQfB065CDtLetra53JUMxQkSB0iePB5yspbfT3FpxbG3Cr0
         uamn80r46U8doQwe1auPYyGnyLe0CxgqbaY41R+b89Eh6FkHMkcO/nGfu8xjy1JXISoQ
         lmf7pQMnYEKGQ7bmzpTENBBN7853YZc2onP5G3wHj16OGmH/UJcTGiYIzKnXN1KxOmej
         imIuk+HvwiNIUax3N7SbTLoSTF14wIL+kfMuH/Koo7avXcSOMipP38+1nfKZncxfxCbd
         8O5E8sMd6R/c6feUlH5rkIzIQ/MFBYnJg2QLcw3tlbXJH7Ct2xNx4kcVii6dHDcAlfd4
         wSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718600986; x=1719205786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhrm9GRzpV6wkMAL+rfDjBKgrfJOqup9MGtDr2Lv6Hc=;
        b=rWFRD2DRj9NNn/5+SIOVS+XnCWotKwneHyNaeANMTJ/NEeNZ4HatpetH29I0L7pQ0d
         +pxcwY6T35pnaUx0fIu/B6B7A17OKxmpix8j1bxF5Sg3vKMFChewnQumsP4hP8vynPab
         Z5fH0BCOVKLDEjMSS0/H+jbfm+tkZ8Hg7unTQjGr8xoWkneTGSYk+RIRrykW3m4w6Rer
         0slWk05efbagIq9/0jgNkQU9oiYZMunYNISP0/xXy/RLngHW1JnB17rnVuKel3T3O1BP
         7GNvmQUEuVRQ4MGOVQGg+lG6aFvPziW0RvfBkKAI/jruqcy9fI24o4Ew8LS2gexhvgZ/
         mYgw==
X-Forwarded-Encrypted: i=1; AJvYcCXad+nzuH0HiiHCygVS/G3eaVG5BUmjr9Vlh/2SvBL9/bwF+CeYlN2+rP4azDI83pHoANZJC+7X+j9wNmdyBLX1+lC4n0+0zktQIiNguTmVbN8wjUYpsxd2f5urDCBlfU4gRr2fMEdXKw+vJfiW3RquvxPn+tsuFRxSzY3mRgsLScn8qR1D
X-Gm-Message-State: AOJu0YxWgFQLzZdqCXb3RE4mRXCyHMKsmJ5/7cVAs0omw7UFgJW0vrLz
	fhPW9u0JaSd2jeLCoK5s6uZxgYDu+ogBjjT03Yfj8390+KlJxOnF
X-Google-Smtp-Source: AGHT+IG5Y90zKuPv0zATa48fqja2SWtNAxno4Y7ZLzyPvJ5eeHYWN5Pkn02qHFc5yvESmaC+uVNOjg==
X-Received: by 2002:a05:6512:b9c:b0:52c:aea5:9e09 with SMTP id 2adb3069b0e04-52caea5a347mr7517168e87.20.1718600985478;
        Sun, 16 Jun 2024 22:09:45 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db6b0fsm477118166b.74.2024.06.16.22.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 22:09:45 -0700 (PDT)
Date: Mon, 17 Jun 2024 07:09:43 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: ti,tmp108: document V+ supply, add
 short description
Message-ID: <Zm/FF2xX/rhwmLZ6@standask-GA-A55M-S2HP>
References: <Zm8/qxGc8fvi/tuE@standask-GA-A55M-S2HP>
 <f75635d8-4199-4bbe-9fba-a1d2ed206966@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f75635d8-4199-4bbe-9fba-a1d2ed206966@roeck-us.net>

On Sun, Jun 16, 2024 at 01:43:08PM -0700, Guenter Roeck wrote:
> On 6/16/24 12:40, Stanislav Jakubek wrote:
> > TMP108 is powered by its V+ supply, document it.
> > While at it, add a short description with a link to its datasheets.
> > 
> > Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> > ---
> > Not entirely sure of the "v+-supply" name, but the datasheet only ever
> > refers to it as "V+" or simply as the "supply voltage".
> > Only other name I've seen is in the schematic for the msm8226-based
> > motorola-falcon smartphone, where it's called "V_POS".
> > 
> 
> Guess one has to praise the ability of datasheet writers to come up
> with different names.
> 
> The datasheet for tmp117 also uses the V+ term, yet the supply name
> is "vcc-supply". I would personally very much prefer to stick with that,
> but that is just my personal opinion.
> 
> Guenter
> 

I'm okay with that. I'll keep this for a few days to see if anyone else
has anything to say, then I'll send a V2 with it changed to vcc.

Stanislav


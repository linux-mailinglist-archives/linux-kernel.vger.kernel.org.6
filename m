Return-Path: <linux-kernel+bounces-577444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D75A71D1C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 313927A9502
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B06219302;
	Wed, 26 Mar 2025 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t4Wh1CsL"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DCC218EBF
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010049; cv=none; b=DrzKLHG0+5qYqI0+ECqI+jPSogTuur4R88WgqQCoTcOe0HP4zhBwV6qKeLoVbRfTATgBy+WuiJN/TMCU7jxZbZPIEmBK19DWRqEDLiIpmc9tbRcSlNe5WYtJa/vg8jCQuPra4B9PF0CFe81VpA9b6aTzH39AnJis4rYih5D3djc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010049; c=relaxed/simple;
	bh=Ia0PhGqMAWsDXOgtSFy+lOQ9RdAXbV6IFBmUJ8CCJqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gS40NOrdexdEJSehBNG/i+z4ZUUmc+k5q5xGPu2QsGPIGjp7hSfJw8LS/CUSSToI8nznZ5A4/FXsVioWJHQ1RI0L5HpQL/1b4IVgyoJkZl9VmoKVldn8+d7mCbQIwsAa0xXHHNI1NN9/TTpkfCBeY532hhC9Vj5eKQqbS6jpRUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t4Wh1CsL; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-399744f74e9so18359f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743010046; x=1743614846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AmZkparCYXGJTs69cCKzbri2rokqJs8Vn/sQzSyVbbc=;
        b=t4Wh1CsL2svvyBUuhydk+dZrq2I+hmYv3kDIUaxDDFPIXC5WwULU0szXacsRS2LFZx
         Lz/Vt2BjzrobPXRwBtnpXSFUVyWg2z53XhjxT2q+vQ8f+Ioydg6Sw9djz11LZwxCFbdo
         dy0RuahKl9h0h7XidBLRJS6KJEu6wou9qtPTQJpYeQSUYxd5dUDhyUL+pX+erwsUgqCb
         HkGvbvos2fQdl0szQZY4JTT9QmfPxw+gZtmqfxq2iFgYJ1AKFUyRfGv00WEOuu6eRanF
         2GYjlzWjnFhgY+0gcm4V5CL3ch03Nfv1d27v0LGwYfW0JZn1ujy3kZsrOZtwKS/EGR/g
         VUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743010046; x=1743614846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmZkparCYXGJTs69cCKzbri2rokqJs8Vn/sQzSyVbbc=;
        b=EylVfNHNlO9/06XdML6kWKu8VTDQcuNZN0VHKhHSNlJmHOCJk4iW7sP7AXL0Opg3qr
         zYH3hZzfc2E7EJ+Bp2R1xdOK09INZu4YHCZNC7KYhM7NFW5E6Sh22fvyDYsjtQQejW1m
         7SvtBpi0sUXnTwIZZrnE8Wi0WsMSOLe1e6tAPuEFqvxB1PKn5Foy5VL9ianQuLlhZhvS
         yFqQW7ZIzoWxuDZyHhNoNvgbbRbs+MuUGG6aVIz1RtjcM+rz4VnWSGiLC4nBpLDQkWJs
         MR6pXpdXMB0qoDNl6aMZV9uhXG1g3g6Dmx5wURXpldrTjs0XlC61f5QRmxKPuy306OhL
         OOBg==
X-Forwarded-Encrypted: i=1; AJvYcCUwuI0gfWC5hKdpgh8SY57AX1pP2SoayxiNosK2hk9BRAQtwg1YcIVuI7oz+QXn+gtfbmEK6/23cc8TdOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1sHvkhrJG/Q7eH47qxFz/enkuweabEXAO2TfXZX9aqbmF6mJx
	+2ilCJgy/E71W4jU4dtmphoxi8wVjJpzUwlrfv+FYCNTGTh0XpzsiYeNxZNX0vg=
X-Gm-Gg: ASbGncuZ0x7+qA1XZD4WqA1AHY+oSzgLmXyRhGyiDot/aHsSNTSxOIm2nG9+pDr7dkO
	CX7RFDhy5LUuZuv9ihxomy0ZP12LyWYW4tD2Xys2siupPzWx68f5P2X21PIZnqIk7hJrLxgbuCW
	dPReQcUXyuxYPw+UiwA1/tT/IarIIM73eEIMaenfa/JZ26NzBNqepasZk5MG5jNYCzySX6wZwV6
	Ukuug+HjU2MDnWt12CFGNLr/fQ03uYDsTk29Wpbh4R42F72/FIZYSkXZvObxCQvfMRBeTA6BITN
	IDgbtQBp61p0YmIoTAguu8oCf+nzmeQixoXtqPeF28aWuk5zSw==
X-Google-Smtp-Source: AGHT+IF8JYC9RlfIgQWP+kttTdJQ6dCebku0km1zLXYhnZmeNWIVC/9PMLhPpGbPN39BUDBfYGZUvA==
X-Received: by 2002:a5d:64c7:0:b0:391:49f6:dad4 with SMTP id ffacd0b85a97d-39ad176b9e5mr291880f8f.41.1743010046120;
        Wed, 26 Mar 2025 10:27:26 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d830f5f22sm8644785e9.30.2025.03.26.10.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 10:27:25 -0700 (PDT)
Date: Wed, 26 Mar 2025 20:27:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: max77705: Fix error code in
 max77705_get_health()
Message-ID: <1c61a172-f623-4698-b753-9c53af9b1275@stanley.mountain>
References: <0ea50e87-2b63-4062-8c2a-17537495f481@stanley.mountain>
 <658c41d0-734b-4397-9687-80b6a219c61c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <658c41d0-734b-4397-9687-80b6a219c61c@linaro.org>

On Wed, Mar 26, 2025 at 06:14:13PM +0100, Krzysztof Kozlowski wrote:
> On 21/03/2025 15:34, Dan Carpenter wrote:
> > Return -EINVAL if the health is bad.  Don't return success.
> > 
> > Fixes: a6a494c8e3ce ("power: supply: max77705: Add charger driver for Maxim 77705")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/power/supply/max77705_charger.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
> > index 329b430d0e50..0e347353c41e 100644
> > --- a/drivers/power/supply/max77705_charger.c
> > +++ b/drivers/power/supply/max77705_charger.c
> > @@ -285,7 +285,7 @@ static int max77705_get_health(struct max77705_charger_data *charger, int *val)
> >  	if (is_online) {
> >  		ret = max77705_get_vbus_state(regmap, val);
> >  		if (ret || (*val != POWER_SUPPLY_HEALTH_GOOD))
> > -			return ret;
> > +			return -EINVAL;
> 
> 
> I don't think this is right. First, your commit msg should mention why
> returning -EINVAL in such case.
> 
> Second, if get_vbus_state succeeded, but 'val' is not good (e.g.
> overvoltage), the callback is supposed to return 0 as success of
> retrieving the data, no? So the user-space can read 'val' and figure out
> whatever it needs to figure out (overvoltage).
> 

Yeah.  What you're saying makes sense, especially in context.  I misread
the code.

regards,
dan carpenter



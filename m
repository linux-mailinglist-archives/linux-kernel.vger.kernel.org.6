Return-Path: <linux-kernel+bounces-189089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB498CEADF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 22:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8871C21666
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5187E792;
	Fri, 24 May 2024 20:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SF7v7qAq"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DD02BCF7
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716582652; cv=none; b=Ffj/Vpn4SBjNn4CKCtsX4uWsHw481S7mn0L6K/i9DRNxNxw/e1rofxfNLsfQ8PfjCGu17UO8GUMJUrtEi+uc7TN8erBLNqk5w4P+QSHmkwcd63Vrw8XkKkESc0BwCLUH7q8XvD7IeL0RwjtvM5WDpijPW0MbipUpt2NyB1jfagE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716582652; c=relaxed/simple;
	bh=79JSiMfJ4zEQ/cmlWaELDJ0t/4llGFYxxVgs6MsioME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pw0JwuwGW+ENwsVXTtoRnteT1wf7rlFtLP1JYlgxrztlXYiY7E3WgBum0ddF0ykDwyYy+jSUDi/subTphwGY9FQsTaHFTbRZCH01cGRDnJX9yYWg2KnyPke8KYM9y8SKPhn+PR0M2cOr9vZjnd8eB4DyoS0K5R+F58fu9H/eOFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SF7v7qAq; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5238b5c07efso8850686e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 13:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716582649; x=1717187449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XOwMS9RupB4Zk7hnPB906AiOhfZXq8ykp/rcedsTEy0=;
        b=SF7v7qAqx81X+cPCRcR4KN71guGKhTM+fS6QzzgokehBtrk3Zy9tkSld0q22AXKMR0
         p3VKp3AdehbShnQu5vgLTxu1bJB1otwNeyD0/nEtOIBBMLMnt7as7cTMVSSjU3nySEtb
         dR6D2ZtCfx22Qv3kXoPQhMjnZjdreIrEPGzDzLSyva4Z3Vtz/Ypy2fdtVPgeY+AzIFZL
         /b6oYypbh0g2wueYq3beY8Vdr71uem+3/RmUAZAeXIQyOCTnSGeJCfG0N9V8lHu+ccx+
         8D/+2b+5pGgvxeCJxWEB7QKQSn+8nTbaVLpB09XaA6nUnPca2ZDj868iNJ7NDrYXwF7s
         yZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716582649; x=1717187449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOwMS9RupB4Zk7hnPB906AiOhfZXq8ykp/rcedsTEy0=;
        b=Qf0D5hheuTeuhULJZ7sL8VvhHLVP7liBSH5beT6zz2+poLWlH1YiTUwyRNSSMMDL2G
         mX7RA978jC4wmMqUTQDbxdpXN67WaeXgf26WKcixTXptVbUELdugwRKtzJOQnzHgnxvd
         JeD6NQzJfkkADbwkbjJMNqprwd+j5UDtB2aKgB1jl26ZM5f2JyFc6tuv0oVwM62E7Iku
         JVqWlkOtw2S66Ew5YtQKN95uAt1oo+Psj38d3RUCwBevR3J3bA5PyKvHtLOH5JasExEE
         IX0yw3M4PbJubcSxh5SkKEftirXF3Ud0q/vC2DjxEHEJRujXox6cu+5x9cfAOjVxot79
         LoMw==
X-Forwarded-Encrypted: i=1; AJvYcCU/GdeSFd9xGOnTxn6M2ulZ4u6zrYfbtr6VOKxgYab3SzdtvzUyelfAz0FQ2mcpm0SZHtduCWOPKfcvNjzSLz4YBxoXvZ9UpeuYGWLH
X-Gm-Message-State: AOJu0Yzg5YF6N7rmSVaFP5+yjiBDxhs9ZaU61pJrGsJ6TPnCEHsY6RAc
	Z0was5T8vMZE5/vgAIhJTEwxgxEeGTmQLjuWTfnkUSXUupr7xqpnA86P4TfjTHA=
X-Google-Smtp-Source: AGHT+IEn6vgWVGZmjSSJmxtnHf0sKpVPXkorQRcCI6P1/AiUkDQoMdH+f3BZS/PpcR8W27e4/knMBQ==
X-Received: by 2002:a19:5f14:0:b0:528:ab83:3ee with SMTP id 2adb3069b0e04-52964ca7364mr2008469e87.31.1716582648997;
        Fri, 24 May 2024 13:30:48 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5296e885cbdsm238930e87.54.2024.05.24.13.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 13:30:48 -0700 (PDT)
Date: Fri, 24 May 2024 23:30:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Cc: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, 
	jthies@google.com, bleung@chromium.org, abhishekpandit@chromium.org, 
	saranya.gopal@intel.com, lk@c--e.de, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pmalani@chromium.org
Subject: Re: [PATCH 0/2] usb: typec: ucsi: Update optional notifications for
 UCSI v2.0
Message-ID: <ory3biisuxsjdpcjxsvb42l3rjivkllnubbprjhhw4nml7v4yj@czrbcsyioj43>
References: <20240524105837.15342-1-diogo.ivo@tecnico.ulisboa.pt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524105837.15342-1-diogo.ivo@tecnico.ulisboa.pt>

On Fri, May 24, 2024 at 11:58:19AM +0100, Diogo Ivo wrote:
> Hello,
> 
> These two patches enable checking and enabling the new optional
> notification types defined in UCSI v2.0 and greater. For that, patch 1
> defines the new optional capability bits and patch 2 adds the logic for
> checking/enabling these new notification types.
> 
> Diogo Ivo (2):
>   usb: typec: ucsi: Add new capability bits
>   usb: typec: ucsi: Enable UCSI v2.0 notifications
> 
>  drivers/usb/typec/ucsi/ucsi.c | 19 ++++++++++++++++++-
>  drivers/usb/typec/ucsi/ucsi.h |  8 +++++++-
>  2 files changed, 25 insertions(+), 2 deletions(-)

You didn't declare dependency on [1], you didn't use --base when
formatting patches, so LKP has no way to know that there is a
dependency. In future please consider sending definitions together with
the patches actually using those defs.

[1] https://lore.kernel.org/all/3filrg6mbh6m3galir7ew5juakd25uvksimr7mqd7uc5td3xza@fdvxcewozqeh


-- 
With best wishes
Dmitry


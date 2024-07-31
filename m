Return-Path: <linux-kernel+bounces-269444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 903859432E0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B251C20DF1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924CD1C9EA2;
	Wed, 31 Jul 2024 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F2MaxPZu"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31DE1C8FC2
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722438576; cv=none; b=b0neACa1Fk0UBthwHq5itO0miQSeQs2HJC0spFsZTZenzLvDaeijHsPBLPAOCy2lHWRZeACqum3jZvx0+lyyT4GlQuR6QIHxeeUr83oUYAasD7BNIuNHqi+yHWG2LIV1ju1yYb1VAFlgeMJwz+OTY32N17X+XGZoU24Lym2d/Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722438576; c=relaxed/simple;
	bh=4+xcUcBY1SAwqGokAGAX9ag4OlFKDAo1lWaGTsEnSvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djtl+rsRmKIu3AQ/j/rdGUfzFIUdljTw8rSxZh6zqzpLVz3G72ITodpCs2wywEIbtU5JqTQX254KziDN0ijcTYY14HB2YSNLd8H9FShDh0eM53UexS+Srw38JTTsDIcVcUAuzxnzoBNZJ/3Io2wg68L6zVWX+E2XwntG8EJX9s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F2MaxPZu; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7aa4bf4d1eso805004966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722438573; x=1723043373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lhMpJFGGAW/mwUi5aHbvNr87SHSzddimCosWlZZ6Qfc=;
        b=F2MaxPZu+hHCZYc2Tsm0Sa9uGG0HbU/2gXxhp2p6CkeoFyuxEjz0k3vkt1lG187xtN
         yVnnvo3/QzSgxra5TPLZDXwqiz9rPmuSTRC8GMf1+5z1GpbLnmCSKjeo3RrRIvOOBQon
         bveFjvxZphx86+Gb9BGeNBJ9ouexGak9Kf+Vx4s0BNPjABzlkp7xFDgxrADrrIwZw3NV
         znTf9UiAhzx4OJ+2BTBqNA03jydRE+c699KR+jfeSzP26MKthP6Da9gImzH9x8opuUM0
         tkJjuXeSkwEgeXSL5G67/5+6kV7MIbWN63NkrAnLH7z4MclMGuoIo7xjEAiN6mvwQjAE
         yAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722438573; x=1723043373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhMpJFGGAW/mwUi5aHbvNr87SHSzddimCosWlZZ6Qfc=;
        b=uF9ymgD2fElb7umlRYflRaPIpMDmSRZ90qottIJehR7e2VCQsT34vpIWeZmHIGRjZH
         uHZBhkAg02S9NPiKukpDwyRQfJZ51j8ozDPwUdQuRuhcCQ2gRItGqxfRj2wrugEs25Yb
         N0SoGTUWTkYppbtLx0pyl5+2hrvD+ydMWrShQUGvhXs3HYH1uSG/fXfYvbAWyrmH39lp
         YgTOIVGdom2agf8hTrPeaz70QG0DVkVUbbkffdELpCHzCUmvdpxfPSL0yncQGoAFUbng
         s1HeLBO1dWM7olc7paqonXEhwSRKd2qGP9RqJFLUrmgEbEfTvIwJQ4SslmsiIaX+ctm1
         0a5g==
X-Forwarded-Encrypted: i=1; AJvYcCUC20rMuAEWWJGOQhDwto8n7Ikd3MzlItFYTCRLWa9qbUEBx7Ymydqa1+olPMNS8ZZZIi1gkSyC7jXJlIDHxThkveeyx26dbvpF6D+7
X-Gm-Message-State: AOJu0Yzlo3nPNn9/JnapOer6AqynEAnMZEY/CsCiSN4mjmg+u5ao+yz9
	cl3r3/EBx+zT/TS54H6uJQxP81VhuBXWOCYtmBvUvQ+HFnw/SFz4y/Y6ljVmw1I=
X-Google-Smtp-Source: AGHT+IFoEQcYfHOmlHKfTJe1Tt40w3DhynNVaRgYGGilbdjWsNjjCKAYHasO59FcmOydt0z2HCXKJg==
X-Received: by 2002:a17:907:97d0:b0:a6f:c9c6:7219 with SMTP id a640c23a62f3a-a7d400dbfefmr1079382666b.47.1722438573433;
        Wed, 31 Jul 2024 08:09:33 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad41b30sm775605866b.111.2024.07.31.08.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 08:09:33 -0700 (PDT)
Date: Wed, 31 Jul 2024 17:09:31 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v3 16/19] tty: sysfs: Add nbcon support for
 'active'
Message-ID: <ZqpTq19SsK7_uSes@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-17-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722171939.3349410-17-john.ogness@linutronix.de>

On Mon 2024-07-22 19:25:36, John Ogness wrote:
> Allow the 'active' attribute to list nbcon consoles.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


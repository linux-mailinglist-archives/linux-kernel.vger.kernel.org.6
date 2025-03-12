Return-Path: <linux-kernel+bounces-557907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EFCA5DF3A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFCDA16E42E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D93253351;
	Wed, 12 Mar 2025 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="afE3EVzD"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6D024DFE5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790346; cv=none; b=dUMFIQB6/mT37TS05wMq4DjeeKMA7XrQxAyUBbpfHtL9Y5zEYPCqVNOInOAWQDLFxba6db4Wuxjn9NrXBOeCy/CV16xZWYBPa/qWykMinFtC43u1uAaJeyN76gCbsW03aCG8C0b0duep1IJg29Ykj4HWMVFKTOh+RnM+fQwuMbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790346; c=relaxed/simple;
	bh=FAUfCbp/AnKGaM6PZxPP+wpMhZXTgWi6xhgNtSdDqeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNnHQkbRQU7aHq/wiFKqklgp+2fAyMKh2DEdEdtcAKFukojd8fPPctwqSBAX+On50u35oxvhxGNIA1sbtrWIxOqTANcO21yCOWuQtO+9gy7cH4l9fx6+VsArk2/6P9CpAvM7+z0KoQGtdNRYc2+72edgB8aO3+2fbOP4WJT/wys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=afE3EVzD; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3913cf69784so4860778f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 07:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741790342; x=1742395142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vWxFu9RIVsjgs6Iiq7krzb57FVJUVJFMHJiej73kumo=;
        b=afE3EVzDHXtcc7XGIm3bpfgVCWrQQ3cUPsM+ppcMkp6myi7D5v7MhmpS70T3ewpVhN
         JeqDY6EUu04JY7HOIg+d1B5qHdilej1k7L5q96IRncAorh8Er5jWBpb+266jeO/JSWow
         +ZOBF/tPMMNsxOTn6Tc23G4vCXLQmKl2qyxZMT8rxCgJyvBIYdL4jy0cSJ5WzOUEdUTz
         skltmUf0U5lr8L39EgSJl6T6MDwafT/aGZhBwKTxJAHrdB3VUTHMrFs8ErEeWy6j/iR0
         BpgW9BvKliVLP9k1dX7Tn4IzL58WHIxyusDZUCcqMYuTns5fC0ZhzJAUVGq5iirizlKw
         Wrdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741790342; x=1742395142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWxFu9RIVsjgs6Iiq7krzb57FVJUVJFMHJiej73kumo=;
        b=UsFwFAwxqVQwwMuVxKJpNUTEWuqn4KfUwFE2RTWALdzd7uZqTRHTCdLy/M5jQ+Olu9
         8ywkYgS1Eg8KqgT6cX5DGAobWbnoudo+hN0LrUIkziVN6hdqnJsTQ9UW8SnxaBlwMoE8
         yLL2xBEVEEy1RnjDUFyTS03UrKvq/bx8NgSk2w1giayuE2ZQK49wleFMY+WZFLCDQNT8
         tIAFomXkKaSnXCJbswnMmBaB0hKjZFxvqQFRolWwXY+YA0Nvnk2v5VPAFKM7jHUYtlV/
         tQDcq2h9wIqMp9QsQkI7Kr69OS0fHSSphAYWqMBvyKLd9PRjvZkycsExebYJM2oGoA/C
         OjCA==
X-Forwarded-Encrypted: i=1; AJvYcCWqooVttb6vcd+/y5J7bNFfs17kPKG/alexFF5fTYp/2DHwCqOmOb0h4PLk1vzgNTQxQ78Z5ZvCG2nCCRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXceYhD1Foq8rLo5OOCaShTnAiFHBv3r1hgK29XQvUFHqiWbse
	yd4CrPhM1c9r1CpaeX8xIdpc/RzPRkUC/IiCpXCOrnM+WcYADdOgQo/ABQMTPvg=
X-Gm-Gg: ASbGnctTCwOZGFzKKpcDIDdT+pjmERa0r3MzYW/dKUN06v265BWoBUS6MIZimKmggGm
	iHzB79G9ohEhwB+YfTnhW0chX0ddsK+ZwNVmMgc7K2gmhL2Wa4PAJQnt0SKIoQFGdoVzSu21P41
	WYt6FsknC9xqZlp1aasJMvDbZj7NbH2eMEtG8hU+y/mjhkv1gvt/AQB8p9/A29rPhaCuuj7e6Ss
	tQ2Qf8qJjs00KxTIrPkcdZCdAEHuR+KW2oiKsAvmeYcKFeB+7AO/lLhtbzhkfss9V8scDdA4IN7
	ZE7D5v4B6yXETUHJwtlOlMqM0m2lU+0b7WMOkeJpKFuN1iA=
X-Google-Smtp-Source: AGHT+IHoIOUes9t+4PJaJSOShtSoQNf8xR0sgPlf7KhTetPd4sbTmZZtiCosAgW+sL2vPrB53Y+C+A==
X-Received: by 2002:a05:6000:1548:b0:390:ee34:228b with SMTP id ffacd0b85a97d-39132d465b1mr19862228f8f.24.1741790342035;
        Wed, 12 Mar 2025 07:39:02 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e2f10sm21405272f8f.65.2025.03.12.07.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 07:39:01 -0700 (PDT)
Date: Wed, 12 Mar 2025 15:38:59 +0100
From: Petr Mladek <pmladek@suse.com>
To: adamsimonelli@gmail.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v8 1/4] ttynull: Always initialize console index to -1
Message-ID: <Z9Gcg-iMMCAhLUJf@pathway.suse.cz>
References: <20250311033133.1859963-1-adamsimonelli@gmail.com>
 <20250311033133.1859963-2-adamsimonelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311033133.1859963-2-adamsimonelli@gmail.com>

On Mon 2025-03-10 23:31:30, adamsimonelli@gmail.com wrote:
> From: Adam Simonelli <adamsimonelli@gmail.com>
> 
> This allows ttynull to be considered in console selection.

This is not true. It should be possible to register ttynull even
when .index == 0.

The .index is important only for drivers which support more devices,
e.g. the serial port or virtual terminal.

> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Adam Simonelli <adamsimonelli@gmail.com>
> ---
>  drivers/tty/ttynull.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
> index 6b2f7208b564..d8b51edde628 100644
> --- a/drivers/tty/ttynull.c
> +++ b/drivers/tty/ttynull.c
> @@ -57,6 +57,7 @@ static struct tty_driver *ttynull_device(struct console *c, int *index)
>  static struct console ttynull_console = {
>  	.name = "ttynull",
>  	.device = ttynull_device,
> +	.index = -1,

There is only one "/dev/ttynull". And its index is initialized to "0".
At least it seems to be the last parameter in:

static int __init ttynull_init(void)
{
[...]
	tty_port_link_device(&ttynull_port, driver, 0);
[...]
}

So, I believe this it should be perfectly fine to keep the default "0"
here. Note that it is special for ttynull because it is only one...

IMHO, this patch adds more harm than good :-)

Best Regards,
Petr


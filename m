Return-Path: <linux-kernel+bounces-277647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D8594A440
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75F631C2182B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFA11CCB46;
	Wed,  7 Aug 2024 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="gSTdqmA8"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7125F811E2
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 09:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022630; cv=none; b=a6QTS9dv73sBHxLc9ebFsB81KlLyZpo+uPhc9nxo1lCOkc76jAjZ7XU0nvm1Fk48YINladmE4VHdJyyuFWd7FxgfGjC6xAJsAz7RBhwKZ4GxQ6o9j0wH49RnVfYlffG83zZzWVCCbMjn1D0upfnHmubt+55JeGXSB9O4EqYpZ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022630; c=relaxed/simple;
	bh=l5Mj/BasNGyIDd8XRpsbwqmxFm681e6x+uIFItW6sOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wg1jGL2WOHN6CfJsj0TUkyQI18b7JeHPz4ARNguawrQ6NGlX4tY8mtr3Qn57WMboRNad9O9tom/2RE0OhINBaabXcSlMjUjDo6i97oVZ9by3F6IZigNaTBZtH50TtrGn9KKxZ8hMvSVYZNzH/NSxYVdQPiMeYAsjDiAy8P9VO5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=gSTdqmA8; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fd640a6454so13574855ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 02:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723022629; x=1723627429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0W3ELwTgJqrVr9YXSIirH10n9Jhjm2A/ho7Bv2qO5pI=;
        b=gSTdqmA8y2pfuGf2cFpw+4G/tuw1+be6E7TnnfZPfQ5l/fxa5Pei9mDIsGZjfNcbVm
         25MvP67eeqSVYiiacJYFDanSNSJ7QTTEu3pyjcE5i+t9Iw4KCn5ZrXzxNaWq4yITGp3F
         V2DR0Q5ukWgr7CceieDrIWiLknMzYAkmnw1uyMkuTvq8AjHbqDHgCYINZ7QDOenIbVNc
         mKoo0Lc/rFWjHxnYLttu/1dqt84qIC1Cx/Rvh/zyGRv8imtqaqZnXDHft+aRruLNgnQs
         KY9VPH4S0s5VEpHEhu+8u5WBmbwcsao0o5+XNeWniWULBaGXvxRsk/tWEY6oD6u5vCfL
         ugWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723022629; x=1723627429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0W3ELwTgJqrVr9YXSIirH10n9Jhjm2A/ho7Bv2qO5pI=;
        b=J8Iqm1iVQyupMoFDbzQyaAOblxvucjtMB6hr4nxFytFQt4dww+Pwbr9rJAq5LUGu+R
         hyjHqUjuNqk/2iD3ps9tBNE6de4W5xdPXOOlVq9gSO70oqzrU2h9Sop4uUxaSogLuU6p
         tCjkMAJC9sUYS3MmhOGzt/1tuBn/IiAM7ihbmoToBQa4mOJF4C7FMWSuV2hC2fgyD47N
         s9JE44lqDu68pAx3rybkTCD8FZo0kAi6++x3zbsLIquehhTEuM0xR+WRwd33dG2NnwfV
         MO/XIToLi7ZEdVdWg5jovimY+Nf1xQrJH+fx5f0hiXuxo6nNrWg90bYZowLKXEsXICfy
         YKQA==
X-Forwarded-Encrypted: i=1; AJvYcCXnMz5HStXVbUEV9N40MC+jbqj6ej4rzd53SC8U7tyswzjOSZphttc4OAoRHH3F2mLkCRZJ7w78SNHMp6Fr9zFrhcda1q7y1qrqKl3s
X-Gm-Message-State: AOJu0YzX0oqQaF5GC25BrSzRxHDKlj5YeqvCgQFPRuEK04WXKonXUnMq
	r/Wpr9V9eDurESa2ag7UT01lO6AUJm49DB31Spc2MOQvEd25PkRU/Hn7d41hT90vqSLb1bIenCM
	AUvk4WA==
X-Google-Smtp-Source: AGHT+IH+LveGfKWKMUa68Hj8gRwcrWvlHYa2Pnf6BOphdfXnSgszfHvPeUra7j0FqX/u6iQlXjUmSg==
X-Received: by 2002:a17:903:1247:b0:1f9:f018:6973 with SMTP id d9443c01a7336-1ff574a1e32mr185937235ad.51.1723022628595;
        Wed, 07 Aug 2024 02:23:48 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f2734dsm102294715ad.41.2024.08.07.02.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 02:23:48 -0700 (PDT)
Date: Wed, 7 Aug 2024 14:53:42 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: 8250_platform: fix uart_8250_port initializer
Message-ID: <ZrM9HlzTjX0MjbM5@sunil-laptop>
References: <20240807075751.2206508-1-arnd@kernel.org>
 <20240807075751.2206508-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807075751.2206508-2-arnd@kernel.org>

Hi Arnd,

On Wed, Aug 07, 2024 at 09:57:44AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The first element in uart_8250_port is a structure, so initializing
> it to 0 causes a warning on newer compilers:
> 
> drivers/tty/serial/8250/8250_platform.c: In function 'serial8250_platform_probe':
> drivers/tty/serial/8250/8250_platform.c:111:40: error: excess elements in struct initializer [-Werror]
>   111 |         struct uart_8250_port uart = { 0 };
> 
> Use the modern empty {} initializer instead that works on all
> supported compilers.
> 
> Fixes: d9e5a0ce2f16 ("serial: 8250_platform: Enable generic 16550A platform devices")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tty/serial/8250/8250_platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
> index c9ef988d58b3..2a3765334843 100644
> --- a/drivers/tty/serial/8250/8250_platform.c
> +++ b/drivers/tty/serial/8250/8250_platform.c
> @@ -108,7 +108,7 @@ void __init serial8250_isa_init_ports(void)
>  static int serial8250_platform_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct uart_8250_port uart = { 0 };
> +	struct uart_8250_port uart = { };
Thanks! I was not sure about this. So, I sent a patch to use memset just
couple of hours ago. I sent different fix for other ACPI_PTR issue as
well. But I think your fixes are better.

Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

Thanks!
Sunil


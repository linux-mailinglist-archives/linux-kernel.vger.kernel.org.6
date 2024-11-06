Return-Path: <linux-kernel+bounces-398072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B199BE4E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED11E1F27AF5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A961DE3D5;
	Wed,  6 Nov 2024 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZMgCjEjm"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5043B1D278C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890487; cv=none; b=J3YzcyvGcEX9Dv0uYEQ9uUdF+k8jjGrbwmuQ4isAWfOsj5czZNPb7rS28pWtch/YIZ2sPrKT3ltRN4sNgc7goHZig0LiVlIwQNqoUFG7aO9IEdKvPVmdBSh9mpKCvlBsHD4DFwNGo9DL1eHTeY9quiKK2gtxc7g2lg19uV4vbWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890487; c=relaxed/simple;
	bh=N/mfT96fJ+//zql7k0BXSP3lhvY+yTvkuqwFMCe1mzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TU3OOd4aUi4+rHgXYFYBGEGxHcuByI+vKVXZhABeHtvTNGdji4EeAgH1f6t17ndJX6gg1EqaFWfGVVeyWlHngETGOs6FmOTPDwHAd4Zxg0Jt9k/lhNIiY23afsSt5yDDocyKRXDbG+zNcMaCsUtnuBi/m38tRmNwz98lc+TkPxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZMgCjEjm; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso53344405e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 02:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730890483; x=1731495283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vDyuLzj58C6IoALVweU82QLSkgc6OnhufpYdJ1qavYI=;
        b=ZMgCjEjmsz25YdkOYL283GOB7bgTRd1XehKvyyw0ouLLbRx1bKuwRKiA2G882iX43R
         9qskoYoWjvf+vkPPZoeJiL2useIdAhxy1j5Lgvrgv5AwMAQ6GX0vIc+qPA80dr+01ujj
         +Ykaz0PPeLXZggvjqoLRxwy3kHiwNFrCVmtncslqUP89iIS9QKO5FaD4SsNcYIYgAzbb
         eVh04B7EHgbatckHsgz1xTVyePEJ7QUrWH/cjiM+hetU/PwQgBdQxjpgY6DhwtnOQBKf
         CKwMFycibNSVCa/vl6p4zTlXAZGUSIcKW5SCHoz09mVDQELHU0zvsNhI0LqTQMzOt+Q8
         8R7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730890483; x=1731495283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDyuLzj58C6IoALVweU82QLSkgc6OnhufpYdJ1qavYI=;
        b=hJeLFLDrW2liQnniO2Olaee/c1wyP6yowozxYBvo6eup4+3RS+ZSydRtRJRKsYFeK2
         IojmYAPOjBxpN3pZZDa1wv0gViq8rSOfpp2bjbunhJfub4PeU3IpBDGVRTEX8pAMaua/
         u+/Mvq4QK3wgyVVwiVGrq8sZ4ge5ZUFPRe+a9q72YEDU8beSbM2ncnXCjty9wNntA6JZ
         nvouHvBnmgQVPGC0Az8RAQ4USIF48jbhZxCmCzpwazdrEu3NpyOcuuak34ATiOW5A7y2
         ng7GiXCN8iF02mNjc/Tv5DgThwDAnpFHnmOmG6LvyXBemPwMNtepi78vXTPwzuexavrN
         JWPg==
X-Forwarded-Encrypted: i=1; AJvYcCVBv9jdIxBEAxExNib3Rgya9TRk/yIWZ6VpFTEUc0htZPbkGMnJY4vEoUz/AW5UXveMvO6VEBH4IjEMxms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxHmDDuhiRZ1gVMaXJJIKoX24Y8JDV7iG3tGbdmyl8xE5DlUk4
	UCJhp2dGsNrUKf9IXWeoiaDV0l9noz7zas8G1t5xbVb9rfHIF1AEnyYyEcM018w=
X-Google-Smtp-Source: AGHT+IFRGeHu6E+URPpjvGEsTdqLtd8SLISeViKJag+OPHvFn7/cF9Befbus7KR8aShFD/K/Gip29A==
X-Received: by 2002:a05:600c:4f15:b0:430:5654:45d0 with SMTP id 5b1f17b1804b1-4319acb104dmr361528865e9.14.1730890483618;
        Wed, 06 Nov 2024 02:54:43 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa5b5e8dsm18521635e9.6.2024.11.06.02.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 02:54:43 -0800 (PST)
Date: Wed, 6 Nov 2024 11:54:40 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Peter Collingbourne <pcc@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH tty-next v3 3/6] serial: 8250: Split out rx stop/start
 code into helpers
Message-ID: <ZytK8JzooLsn6SdG@pathway.suse.cz>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
 <20241025105728.602310-4-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025105728.602310-4-john.ogness@linutronix.de>

On Fri 2024-10-25 13:03:25, John Ogness wrote:
> The rx stop/start callbacks also disable/enable interrupts. This
> is not acceptable for the console write callback since it must
> manage all interrupt disabling/enabling.
> 
> Move the interrupt disabling/enabling/masking into helper
> functions so that the console write callback can make use of
> the appropriate parts in a follow-up commit.
> 
> This is essentially refactoring and should cause no functional
> change.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

The changes look reasonable and do what described:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


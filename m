Return-Path: <linux-kernel+bounces-171273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AD68BE20D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7C361C2357A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C9F15B140;
	Tue,  7 May 2024 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YawRCEnO"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C96158A21
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084775; cv=none; b=tubUHbZhw0EUlnkaPIMAPD0XI/sutS1QrPbXM16uE1hoyodLRz2Tw5Dl+y5Vp1vCwwZMOGc068qylDACaqqnhKMUYHBjpUk5FKTxoG3qnyFKRxV3H3qWS0M9PVt5NFsaNrzgmKehUEdAkpiW1N4zK2/TkyH1nS8+PaN12lWPttA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084775; c=relaxed/simple;
	bh=8lHEWT43b1TQQJQ7gtYNPKOiSkUZSJWBKflmzAhzO/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeYXQd++K4skNXKz+gaVnwFHQdUtP31dqZsXE6BlY/PloL3WWisn9sjf4+34XgFIkUjdrnB+quapDUlrK7vpYbYrLPuzaaZ8spF8fRpZ9uhRvzAPMF6pCEI6aSioxaCD1C+xtoNel6mW9Xz9XpKGPRkhZ5/VBGHjQoWSnkK1JtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YawRCEnO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41ba1ba55e8so19533395e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 05:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715084772; x=1715689572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yDaM1ir+QOt4ToI6xBZrtMJ0TzMiOebYUPJjumxSyiI=;
        b=YawRCEnOLgKsfBdN8UIThvrk4l+3HY9wkW43AalIn+9QaGOEjj9bLGJKSsS/U9Mo55
         HsylFph4L8jwdMqx+bvh4tSEab0tAvzYSu9FWKYgo17JhDMZbnafN4irrQZF3n7tFjHo
         n7G1XQ5eBW+7CmE8s1HMk3HvAoxKyKgqqzv2q0gI56LqIK7HpR7g0S88Rzh48CRt7pn0
         4ATYDFRnCKXHB+W4a+0FcaANqYwBuL3j+JJq4perYp03hLyJMOfCsDxz+BzV8bQHAhYH
         0iI9tmwwqQv7T9yULJCcv7S23K2fbp+JXwatHDD8xUcr0K4iWIWBD8tzkcduP0JjR7a1
         Wzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715084772; x=1715689572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDaM1ir+QOt4ToI6xBZrtMJ0TzMiOebYUPJjumxSyiI=;
        b=g19iEiW9u0lCrt3bHBu6LnIry80ZQ5PK9YONgRHdWXczZwfkhav4Ww3oviVrxAUmUa
         MkgWaAYpoqU/Czq+ZA/OEhkEA2rK5XBKNyN9+kB5a+/7VhmToGYTF/FYizY3V0VXNTv/
         1v0CjJAS4Z8PaMqhLkdtAUD1gtQF/YrI0HX2o8Abr4x0TJMPE6/yZz76DwgYQSTg84nc
         ewONT0WHdE1P4uxbVbCyhvyHH/IIzEi7NszzrT60hVrJerS7YuncLwkz58kvmpc/A2dF
         SpLiGaDSD9ellvijohKFMB5SF6F46WNHZcirIUdkjRWKDpFC9I105APTmi6tCUjFa1k5
         UMyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm0MD5GQo3gNkYcNTbnA9ebdYCa5Zqg0KmPBAmpdDKJnPc5WLXQ2Qp7suj7t9mESCobCAtyMLN3NJPzdizo1bhKS47p/y9xMBxI67q
X-Gm-Message-State: AOJu0YwH9S68dothKZfcnA8wgeAFzi03qVb/C8HJ+HmeFC1ZVzlOzIWA
	D8oNMeMuLBX5gHbP5ffBxWjlHJzjrkGaJvlqoTlL2zu6Rg44XOwxSSbXzOEiGok=
X-Google-Smtp-Source: AGHT+IH/W3h7SkQrx8dopWzH6l+ZGPqolpDYANr7C1AhRrXQ5G2FNyXCVDi9dk5ynJB/JBtFeX1vzQ==
X-Received: by 2002:a05:600c:45cc:b0:418:fe93:22d0 with SMTP id s12-20020a05600c45cc00b00418fe9322d0mr9996486wmo.11.1715084771827;
        Tue, 07 May 2024 05:26:11 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id bi9-20020a05600c3d8900b00418db9e4228sm19546930wmb.29.2024.05.07.05.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 05:26:11 -0700 (PDT)
Date: Tue, 7 May 2024 14:26:10 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v5 05/30] printk: nbcon: Add detailed doc for
 write_atomic()
Message-ID: <Zjod4hNh7YNiUj24@pathway.suse.cz>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
 <20240502213839.376636-6-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502213839.376636-6-john.ogness@linutronix.de>

On Thu 2024-05-02 23:44:14, John Ogness wrote:
> The write_atomic() callback has special requirements and is
> allowed to use special helper functions. Provide detailed
> documentation of the callback so that a developer has a
> chance of implementing it correctly.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


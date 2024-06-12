Return-Path: <linux-kernel+bounces-211418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B455905165
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296261C2150F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141D116D9A5;
	Wed, 12 Jun 2024 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eSZilDcj"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA3F155C82
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718191875; cv=none; b=a1dEgqb/U2aXt0JjRoLctGAe16TSUUdFqdMmnLX/CL3Qxr+p4wfRLw9dKhj5ISnQkwGVuAfqX1leed5wsXMUmXwAcsUisII6q5PjXkygsAK/cOlmhAshuILvm0JGfILX0fqJp8E+G7OBYXm3OTQ9gjm/+vPIoWIE9rTgOy2/poI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718191875; c=relaxed/simple;
	bh=r66wZYLmFvXt0D9cZgBfb9tuRiJPaVJy+mZp2jglOW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQRQAfpwpW5T+H0A5FhSmoVLtbvpAgeXnwsZwqDY1qA9e/cAweOThtLqNZ99nzuRUKsdnNyBMZpkt3wC3+bYCX8VvGF53Ki8srtHjrTG+5+1qLGpBp4W0z6p2thQMej8BT9Id1s+kx0hnWGEX7yGfC6/bNZaMEaYIcWaGaT4KmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eSZilDcj; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63947so3038140a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718191872; x=1718796672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ieujl4+mCZfP+jneLi96UmF3H+59EZDsz47WSP3MPbo=;
        b=eSZilDcjy/LMdcHqyV3qNCK1YTh4Z4q8LGz0y/ghYAA5BIm1pBRUHDsrjsr79fFXfD
         LEIHP5Xzi6E5rAYSNpxjz7a0IfkW6EORjQXJNgehaNkaJ1q5v5xTxhL1qo+dx2+CKzzb
         937pzZjUhB/0vDVhHnmrj4Fv2xWGxjsBOHB6IpTiyT1w5D7Ta9EzBVizXVAFuPMFuseg
         4+NzanL9bhxCjxSX9o/A5HDWJtsV/I1VEUyOjZFzl/WzceltIyw31c6iz6lgKlLuOWun
         3uSpsnUf2RpKP40XVJ4eUJAD/fUErwZ/9KSqvJmpxhob3YQxHNRHd2av93Jf+Q3Lu7L2
         tPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718191872; x=1718796672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ieujl4+mCZfP+jneLi96UmF3H+59EZDsz47WSP3MPbo=;
        b=k/RQQziFlMEOpWIDOPASU3hlPsh+/eNEc6PilHM5I2HantZHcukgamK64BJYdC9sLr
         bZPn1rBiUBXVJZQ0Er7ghBSqf24IH/IZhoqjvHMqNGV9DnawES3rZ6SA5n7tNk+9Cxh7
         Xj2dyIBxH4z1DNpiGSzXlRxJHQSWptsqL/nhs5uKi6rWxRWRtQ1h/5IgCkulLDek7jhq
         fKAu2ZEE5ISQtfF1SUHBB8CVFwtmX3/Tst64Clab+EAYNGEUv/cTIidnzNKI+EHl6Qed
         uny2dV2ssvvD/JLCVWWarPRcXAq/Qe36jp2kVF+4XJh4C3grecEKzDg2KXg++vXBwIHe
         mpDg==
X-Forwarded-Encrypted: i=1; AJvYcCXtmWvv184tL5vlix1jm8qib5TiOWS098qGPBkYXZneif5cAeG7UG/dhNTELS9Own0iqigftR91b0/60mz42uDZDPMQzC2hFUvg6qSw
X-Gm-Message-State: AOJu0Yz7ugoh9MULjheWP55enIm/Azn5wO1s3I9QyKV+BkauBYBCSx3V
	KKcdVXUPGA+NObOr7li/G29QBGeIu+pk9mbgLHz+iSkjjhPnrr6bkYFQp1e5EfAW2jxvkdguS+Y
	e
X-Google-Smtp-Source: AGHT+IFktql5pDJ89QDBzHQTvLdzWqnS/SXVFQhaj2o8PYolFJOl5+tsqLqr0bufmH0YV6RqSy84gw==
X-Received: by 2002:a50:f68b:0:b0:57c:a7dc:b0e4 with SMTP id 4fb4d7f45d1cf-57ca975695dmr1302795a12.3.1718191871664;
        Wed, 12 Jun 2024 04:31:11 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae229712sm10929059a12.81.2024.06.12.04.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 04:31:11 -0700 (PDT)
Date: Wed, 12 Jun 2024 13:31:09 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] vsprintf: add missing MODULE_DESCRIPTION() macro
Message-ID: <ZmmG_dQaTpq4TkGE@pathway.suse.cz>
References: <20240531-md-vsprintf-v1-1-d8bc7e21539a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531-md-vsprintf-v1-1-d8bc7e21539a@quicinc.com>

On Fri 2024-05-31 19:42:25, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_printf.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_scanf.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

JFYI, the patch has been comitted into printk/linux.git,
branch for-6.11.

Best Regards,
Petr


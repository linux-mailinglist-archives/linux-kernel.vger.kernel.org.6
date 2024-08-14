Return-Path: <linux-kernel+bounces-286768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9792951EC0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286E41C21471
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECB51B86C4;
	Wed, 14 Aug 2024 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vbXqN3YV"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907E41B5807
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723649929; cv=none; b=eTjDXdPVk/6SGxG8qVxdkaHQCvqhjVuC4mIL0HyeIuCJHaSZvvHmRkWibqobY0SWST101JJSjDjtizvMnnv6jaSEBvICAqwpyKT3/WyhLYiXbu+Qom+o07snoXgWg3jxDN7yUEtFq8OaBNXX5dYz1ylJ6ovy2VINXgBfnlMWUSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723649929; c=relaxed/simple;
	bh=fwRO+mn6bXwYFAMB2qFIRZLMAWPvS6P1M3+EBY6e18A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvMUYiciXHLilXawdjjmxOQHqp8+GpwqRDvnIKu5LX5JufuGp7sS7dKaEMdHR9Cqy5PbZNfVA2/Rkyj1u8TAC7K3f8yksY8HNOkomm64ZQXwXTaKpv776VYIZlGop/k3he+EKmKXo2EoKenrC112RgYoq3X3kaHbPvfhY8pBDz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vbXqN3YV; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428101fa30aso50454205e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723649926; x=1724254726; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2RlAyCTktp8Ohy45ZHsZAJWDLcmSeRRB2NVCChV9/Eg=;
        b=vbXqN3YVLzlMG8Jjy23p8b0ioR4QSoqNfZVx9xKoazzAiDRSFVMqhsxBwAZf8Pav2t
         mHJ7J1i4E/XRCBP+GnknbaT6pQWS8X1f+jPh6iNHpKA1BG0BN0dqfY0us7gEKqUFjJ8c
         21U0QlKtdZV5oZ8cNCd+0u94xJ0WYxT1A+dIs3gKv/knU9AD+Un5O2G28ndJdSG4uk72
         3LeYxi8teSwWHdxW+ZlVUtn07ti3R8gG2345oLj0Wg09EP+idAAslo+Q1u6LGZ4xk/Oc
         yj3gQ+chbgi5LMIloKodVgOMdyuxoLWCBmSXUjKqp5LS4dlbtr7wbt5HM3GvJbEZAszI
         vm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723649926; x=1724254726;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2RlAyCTktp8Ohy45ZHsZAJWDLcmSeRRB2NVCChV9/Eg=;
        b=MX1v9ikQjpREY9TWSnDf8t8P07dcuNfal7mrj4DESDadmvsCuuKc/yrcsKnx2FYCeT
         cHJjn7w/6A3S0mXy/TA20Vkw19XQ+6qPm8DFvOFGaIzfOC6rjZ8P/unT98Ar0S7eHIsS
         4L9odl6le0cj5oQiOTN0cMaMjHXm7ADF+5jcVtm/WiFDt3+xZ+4jZuGyUsMLoPpjme/i
         EQCZy1YCn+TUpXQ9d/0qDv0ccFta8dkpMaZnusediOGgIL21xag5hM+i4hHj5uLbdA+A
         fFC2HxojwBjHd7K6JI8VzXA17HY2xGlIk2KWe19ipvsS+JTlnDsq2LppHH4v6sTwywVE
         /mog==
X-Forwarded-Encrypted: i=1; AJvYcCUlHbiDZ0iY7oQguAgDH7ncn0qOosdtVDVbMqDAxfCMKopM7uppEjPGxd0puNfqEwoc9RdUW6APK3LejF4l/zfNHA9LsEiF2mJOAk2Q
X-Gm-Message-State: AOJu0YzEY0hdyruPKZieICmBS03w5fq+IrBNaTHf4DPP3+/V799Mnamv
	Dnv5ziU0jhJJ4ES6x0yGXwRpNPBgiTDPO7RMmABEa4iHZmcqU/hWlt0aRxMgbdc=
X-Google-Smtp-Source: AGHT+IH9wL7tffaLYUYk3ZHAahngdbyDa6YrmMgjASAFwrlFIshp1+vTMEOATmYfSlMQUgZivFb07w==
X-Received: by 2002:a05:600c:1da5:b0:427:abed:3602 with SMTP id 5b1f17b1804b1-429dd2603d8mr21605485e9.24.1723649925449;
        Wed, 14 Aug 2024 08:38:45 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded367ebsm23950265e9.25.2024.08.14.08.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:38:45 -0700 (PDT)
Date: Wed, 14 Aug 2024 16:38:43 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Florian Rommel <mail@florommel.de>,
	Jason Wessel <jason.wessel@windriver.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kgdbts: fix hw_access_break_test
Message-ID: <20240814153843.GA168155@aspen.lan>
References: <20240812085459.291741-1-mail@florommel.de>
 <CAD=FV=VC20PvOPSf9quqghA8SKKkCduadtU7nso4wkSwVKH3jQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=VC20PvOPSf9quqghA8SKKkCduadtU7nso4wkSwVKH3jQ@mail.gmail.com>

On Mon, Aug 12, 2024 at 01:04:22PM -0700, Doug Anderson wrote:
> Hi,
>
> On Mon, Aug 12, 2024 at 1:55 AM Florian Rommel <mail@florommel.de> wrote:
> >
> > The test for access watchpoints (hw_access_break_test) was broken
> > (always failed) because the compiler optimized out the write to the
> > static helper variable (hw_break_val2), as it is never read anywhere.
> > This resulted in the target variable (hw_break_val) not being accessed
> > and thus the breakpoint not being triggered.
> >
> > Remove the helper variable (hw_break_val2), and use READ_ONCE to force
> > reading the target variable (hw_break_val).
> >
> > Signed-off-by: Florian Rommel <mail@florommel.de>
> > ---
> >  drivers/misc/kgdbts.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Looks good. I pushed this through kgdbtest and it likes it too. I can
turn one of the XFAILs off (yay).

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Tested-by: Daniel Thompson <daniel.thompson@linaro.org>

Arnd/Greg: Are you happy to pick this up or should I take it through the kgdb
tree? FWIW right now there are zero other patches for kgdb this cycle, although
that could change!


Daniel.


Return-Path: <linux-kernel+bounces-229430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725F5916F7B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC4D286007
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03048176FB2;
	Tue, 25 Jun 2024 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W/OYHY+F"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87FE172786
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337429; cv=none; b=p3YvslBZ7JsStBU+UJHIqUDf8gnwVEbA9+ZKWRC6vQH0AYxS+nYWgIFpWRu0F+AYzGSZ55uOb1BpJ7mXZAdHgFufZeOymYflgTCo7xsCxutsIiSzTuB0pcXd4+eAFaiyM3PNVj3QrhV1ffQtTOv/upUOYT0C1iepy7Hv8EQ6v3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337429; c=relaxed/simple;
	bh=5VgSZVq02U6IsfJaYVV8DFuJwm1vUyaN05VICVFOxus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCMNa1eyvgUVpwdhKN0iqaDOFl4eA5JdG/1GR5U+l9DJ8DV2o+LVM0m905OUFJpaLjQ0RVdjCibJQ3QGyQFCpi34WIIfRbv7+7KTSCDX5iKFH0+buQY7nu5P/2s+gKvYDEak39cvF4RGuo28usmXNzfZU2c9cvoUEoIAwHpb1b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W/OYHY+F; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fa4b332645so13775ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719337427; x=1719942227; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4NkneRAeqFnNlsteKCtsOu3L6FUBOoIj11zyXycSDMA=;
        b=W/OYHY+FqOuGsUAAM/lAWLh82jL8pplO7SJnUwwrO5+kVHVMmM+qm1p0l/ljd52Tjr
         sapjoSSvANCNt13dUiMSMmpURFAWKTHL0/eackqcJ5vm31hhOZ1WcbOcaKwAg1nUQOM2
         N1A91yG5/2ThGzxAToDfafgeHDt8+cGHwTAxIb4+xXiaRzeTO+TiSavGywEsWYrP8GG5
         DpdWAwyyuRD6dqG2nTvI069vEr8suShUjKeyuxtkj4lG+aDid2BtndGi9pFpMOF2N0em
         es5rQfRY5O5lvrFryaerqqlmlWngtc1MK5jfFXTqkmEKX16BE0Rfc/YBiLMUmtx3eEHl
         +ZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719337427; x=1719942227;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4NkneRAeqFnNlsteKCtsOu3L6FUBOoIj11zyXycSDMA=;
        b=ao9c0eto6qtH256lph28qIA7xUybQfiMMbe32Rca4NSyt0qASSfk3kPbIu4lwzxGDV
         c6T0fs0IGWgsRXWW8HJ006/0b04jMaQl0s3cnGXGeATw+A92r+SoCGaqDPJCcmv/TAWu
         3Y6wsj2cjC2MEQawVD0LVObnA+ueqiK7n8ln/Q2Yc0uM8RotHKGh/VN73GAWLrkcjtYS
         7UGCdohUNK1PZrFHvIWfyAJy9vie0Xmo9RSGx6lBRb/4RQ8x/YCrPP3Li4s+thMcHblV
         4j5zd8kjoRlgJZZRzkHEUHxGlNXf777ogx1bFEV9uAyp76hm7TVMkgUvWaYL7o4vsfoA
         mhpA==
X-Forwarded-Encrypted: i=1; AJvYcCWYa9xk+31vnuqLPAmeTvvAI2Q997GejOpB8+5ss4i0d+6DIxnuQTx/Hwyw4NWbgAWrS+iy6EqoyVEyTS5K1QwAnExJLNMmkUcNcRnd
X-Gm-Message-State: AOJu0YxBNZTflWXL29Dfohi94EfDqK50MZvs8SDe2sRXF5us7kJnOmVg
	90Nh5YpHMl3mEj+1+91gOOJRbHKh/EbsIC/bauYnAJK3YdvxzOwl3oFuzPQsVQ==
X-Google-Smtp-Source: AGHT+IE3GbbrPTfGHz1QMDfN5VvYW2z9EAbtcbC6WTIkswzUwNwFll/14uYbFQbRSRjJoZ445WDIng==
X-Received: by 2002:a17:902:fb90:b0:1f8:9300:5361 with SMTP id d9443c01a7336-1fa6cae64cemr3548585ad.27.1719337426194;
        Tue, 25 Jun 2024 10:43:46 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:9a90:b76f:c388:1248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d5ad9sm84394175ad.204.2024.06.25.10.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 10:43:45 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:43:41 -0700
From: Isaac Manjarres <isaacmanjarres@google.com>
To: John Stultz <jstultz@google.com>
Cc: tglx@linutronix.de, "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	saravanak@google.com, Manish Varma <varmam@google.com>,
	Kelly Rossmoyer <krossmo@google.com>, kernel-team@android.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5] fs: Improve eventpoll logging to stop indicting
 timerfd
Message-ID: <ZnsBzfSPZlrhpB1t@google.com>
References: <20240606172813.2755930-1-isaacmanjarres@google.com>
 <CANDhNCqhJRLgvhAong-5zjsfwk2sL7pNbK0EqWsPcaA+AuzxDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCqhJRLgvhAong-5zjsfwk2sL7pNbK0EqWsPcaA+AuzxDQ@mail.gmail.com>

On Mon, Jun 24, 2024 at 11:03:43AM -0700, John Stultz wrote:
> On Thu, Jun 6, 2024 at 10:28 AM 'Isaac J. Manjarres' via kernel-team
> <kernel-team@android.com> wrote:
> >
> > From: Manish Varma <varmam@google.com>
> >
> > timerfd doesn't create any wakelocks, but eventpoll can.  When it does,
> > it names them after the underlying file descriptor, and since all
> > timerfd file descriptors are named "[timerfd]" (which saves memory on
> > systems like desktops with potentially many timerfd instances), all
> > wakesources created as a result of using the eventpoll-on-timerfd idiom
> > are called... "[timerfd]".
> >
> > However, it becomes impossible to tell which "[timerfd]" wakesource is
> > affliated with which process and hence troubleshooting is difficult.
> 
> While your explanation above is understandable, I feel like it might
> benefit from a more concrete example to show why this is problematic?
> It feels like the description gets into the weeds pretty quickly and
> makes it hard to understand the importance of the change.

> 
> Again the N:P.F mapping is clear, but maybe including a specific
> before and after example would help?
> 
> Additionally, once you have this better named wakesource, can you
> provide a specific example to illustrate a bit on how this
> specifically helps the troubleshooting that was difficult before?
> 
> thanks
> -john

Hi John,

Thanks for your feedback on this! I'm more than happy to add more
details to the commit text. I'll go ahead and add an example to
showcase a scenario where the proposed changes make debugging easier.

I'll send out v6 of the patch soon.

--Isaac


Return-Path: <linux-kernel+bounces-447471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E957B9F3301
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5B516B47C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7F6207658;
	Mon, 16 Dec 2024 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MBH0k6g4"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C42E206295
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358660; cv=none; b=rMHicMTHGjXpQPbINGmUYdWBtZDGunD0QEDiNaSY0YrsdcEv67zHFmagwXnqxw9ZDqfY8si1Kh7UdBrykw3ygA/WfdhmvSznrF2CD8iyJJ6z37gRgE1vYr9TiGdAlCWOOwv2B0ui89e9PiEDZ9MYHS+3qB5T1UNhIC4f8lODMPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358660; c=relaxed/simple;
	bh=ZKXR6f7M8q7AUD84JUe5se7Ret2cqMIgZJiJtHTUpCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pO40EQJ3CCV5X+dqjfvXpxbC1o10hOUewgOpmtjd+3N9BVmOWnWQZnYdaGfIh+eG5nurs1cPxWqx+RJefPN0LZ+HLqECABQTMaTXXfW3aWVr1RV0aa17NloA85QYN5sIb+kK86QktQw68u5Xei96B9FBk8IH6Fy0lF0isabHmh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MBH0k6g4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-436341f575fso27789825e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 06:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734358655; x=1734963455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdwqgpoC+bfLP0GpotgLw/tzkIjreKiDGChJYeu/vdI=;
        b=MBH0k6g4GU2IR/zOYqN9ueCghHulXbCvDldYD1KR7+SysWtzpkm+X6J1n2qkuVfWDh
         w65tnq6gqOe5jC+EVxrnhvPWb0396XKlZ84YF7GCGidu/ErYSt4YUz2yzJNN7lgPFCvr
         FUcCybIN/jzzA/jGAuEgdBpNJoL4WqRXU8r/orWvOZO+fj2795pLuaJYBZLqkzMENDAl
         aoAt0X3WOcA58f5MA20LazpxMt/TIrzBU6rT2G/rvbLg34VF9/Xfh2glMqg0ef1EymXp
         U/xbby/ACuFe454NqMSjTUk4SD7aIdsN5gfCfT24KW0Dy1ediFk8ohHXJEdPaUineIFA
         n/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734358655; x=1734963455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdwqgpoC+bfLP0GpotgLw/tzkIjreKiDGChJYeu/vdI=;
        b=Hdnr8UI+RIB3FJ9cKgv8y0HAH8IXq6Ca7pTQQjawYq3cPwfzbo2lo8EzclSpgIF75k
         o8Bt3NQ8VMRZQTAF05DT3Z/9awnj2GOkf0ms+zlfzH3SKpNInz9NKpaWFaUX/i7a9g4L
         McS4+LY9eAeubmhJ0/wQNDkU/Yp5RiBEqT+GPgyRWbR1hgHbvbLv2ZIOws7hMdrbe50m
         i6lbV1WhO9ed7ECFMtXCutSK8oX2SU6Ut3BSNEw9PEyV3iXX3kViId+fvOttLcFgeUvi
         WW7a5XMzvJtiG2rJG8O0RMcYqOD4710EOu0Jue6tQlF0XPf370PHnxGZdSpvDHu7p1Xn
         S6Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWP0+oSDhFNvT3vfB5xhmgRqpvW/p6n8UFKDZKXqszJ/ANGQ4MnDZTZjMNrYe10PJ1gB0Cq0a93fYy9ziE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJFkYOu1JF+pZzdj/7Pmq9xpx9mcLHrqC6buu7Ap+TNau/udQv
	aSQ/JUEXIZhiIg9eZ+5yM1xsFai//c/xerMGdUtqQ+uDsv6L9CHVBGNUVY9uwO40XYX6eipURDd
	9
X-Gm-Gg: ASbGncuguDk76crVz7ff4p2saWhtBADU1aY/YhWRlOIeCWj8uzpyXh7oXEorTL8ivWv
	ikqCQ9yQ2moas4lmnWH6tT/oUB37DEJUXrnwzRIFUTz+gNXaIyDcOF/kk/a47mkk52INIm3KBlW
	Z2bZGY7pAzz3ANVZmqMtvtjrcIkUO5YSRqz4s8VwN3ZLxQjlbC+FJ8RADZKMb4cCE+r5cPjc7sE
	JlMPQyDflOzq3ST/wXKFe/XPs2xFZ7uNM1OeQd4oPRcetf0WXUwEVhBRA==
X-Google-Smtp-Source: AGHT+IGi7Z+KCftx5o0ei7T4T2tBaC+K1y2WwdyHb0NnxRjwOTiXAiCvSBG2XGhtrNOGocu0Mxo3TA==
X-Received: by 2002:a05:600c:1da4:b0:434:f753:6012 with SMTP id 5b1f17b1804b1-4362aa509abmr124521275e9.17.1734358654734;
        Mon, 16 Dec 2024 06:17:34 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436362b6841sm85527045e9.28.2024.12.16.06.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 06:17:34 -0800 (PST)
Date: Mon, 16 Dec 2024 15:17:32 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	Rik van Riel <riel@surriel.com>, Omar Sandoval <osandov@meta.com>
Subject: Re: [PATCH printk v1 2/2] printk: Defer legacy printing when holding
 printk_cpu_sync
Message-ID: <Z2A2fHJoByYVkogM@pathway.suse.cz>
References: <20241209111746.192559-1-john.ogness@linutronix.de>
 <20241209111746.192559-3-john.ogness@linutronix.de>
 <Z1mpxhCU-WpaKJIt@pathway.suse.cz>
 <84frmu2mjk.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84frmu2mjk.fsf@jogness.linutronix.de>

On Wed 2024-12-11 17:54:31, John Ogness wrote:
> On 2024-12-11, Petr Mladek <pmladek@suse.com> wrote:
> > It might be worth adding a reference to the original report
> > to show that the problem is real.
> >
> > Reported-by: Rik van Riel <riel@surriel.com>
> > Closes: https://lore.kernel.org/r/20240715232052.73eb7fb1@imladris.surriel.com
> 
> Agreed.
> 
> >> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> >> Fixes: 55d6af1d6688 ("lib/nmi_backtrace: explicitly serialize banner and regs")
> >
> > Anyway, it looks good.
> >
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> >
> >     I could add the above mentioned references when pushing.
> 
> Great, thanks!

JFYI, the patchset has been committed into printk/linux.git,
branch for-6.14-cpu_sync-fixup.

Best Regards,
Petr


Return-Path: <linux-kernel+bounces-205095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6AD8FF6FF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE6C287C7B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D086B4594A;
	Thu,  6 Jun 2024 21:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLthqs8P"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B772F2B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 21:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717710336; cv=none; b=mcZcHul4/TwnxDafPY1KynfYaSoa2wuFcCW6n6Em+Ss6QXAGe9xygV2Ath3FvGpXcbCTaRFM1HaqlHhH1MjHyGZYyJye3YQzit8UTvH9EtBQD5zRtuZzC4GHynQ2vIY+0UdXkgnlVDUOrP//B0YRgwhw9PHEOsvYguxe4QzBQGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717710336; c=relaxed/simple;
	bh=UUSy90285ow6jvIztw82/xZjqaNg1AhPBgDu6A2+j/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fK6UGHParNe9UP7coPJl6SbfOcUyJGBR3SnLHCNR5NqUe5ayBxURwODAs5WjAy93UnEv2pcCcew3zZT+HDvDDE/Fx/raqyI3/Ix/kqHso/j3HFpDcfRFV527I1e47n1LFSZwI01X0pDDbcyPnn1D8dKw7rsy57WSnnvkF4y0dq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLthqs8P; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7024494f7daso1190411b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 14:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717710334; x=1718315134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kiVSQTKvudob+wgTBaWgUmPZvWmWUR7UARaEX9OG4ow=;
        b=SLthqs8PgAtkhuctv+yipGq7USeCr7AQCnFTZEy8lJINK9ZZZRLWjRRMyEovKqWlzu
         1ITBMBR+LlsPJV/KDcRwoqWZZP3vCV1UvqLd+82Ti9aNh7nhMmhJhXo7YFGvYmnek8/s
         MDeg+/ArC5Op6ubJYkD6HsbBK5KUjMq/m6/vemY+JXFy+7Qv/u3T0MyvXTt40f/Eoizy
         AAE/O0ZyFbgLm1T++5RpI9/N19AUkZNnN2Fu75JhwEcS79ZF610jmnPLrOidfbDyNLyr
         XxAUf6HIILVVVqJCTHCBxHJ7HqQkDMZcUlYQ/nbXy0bJjyIYPNzibFORchg6cYDc9z8p
         ccIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717710334; x=1718315134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiVSQTKvudob+wgTBaWgUmPZvWmWUR7UARaEX9OG4ow=;
        b=LZl0bNyI2ivTEMQpflc6+dxHVs4OYo1xX+ECQ1lcqVO2b/c+gnrvgWIw/jZQwI/3u3
         ebF4t6u6zuUirYQQXzhs58Guow9BdRHptQ7Kxz72T3V21nnjbHc1ozMDMaPS4XVLGrPj
         iQ4+ibVn0MVIQJtei2Ep9X06O/4dQiynMvERtPJnfywtNv+cUrpTxLOaPUKTaRTp3nKG
         sGGx4G7zVXQGl7RwRXpxhJLTxrIim7y92kQ+mtMHfTJyxc7fqZ2/0Zt0f/5CYFTuygOO
         mvfyjGASz1NKPSFYoH43HX4uczs3GzlCHdnKGogyDXGq/P+JpMh4PmgnOB45kRuGqlYI
         J7sw==
X-Gm-Message-State: AOJu0YyNCK8qOe1gdSwOeP4M6pqVI5ByxuPUTZgQGl4N6NeIzded18uz
	a93D0Wfu31VNvYwme+WtGkRcfbsBJ2g2eGVsRzsiS22ALl75qJxHMIYmMw==
X-Google-Smtp-Source: AGHT+IHqAuOFOrDc+DGzKZNablMTTYl4hjLzucgvOmFxqb2aOvQpKOh1a6++T9ogBhyphyox9stRjQ==
X-Received: by 2002:a05:6a00:2343:b0:702:56c0:299 with SMTP id d2e1a72fcca58-7040c6adf2amr848224b3a.20.1717710334056;
        Thu, 06 Jun 2024 14:45:34 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:cdcb:6470:dec1:846c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd3965f1sm1540713b3a.66.2024.06.06.14.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 14:45:33 -0700 (PDT)
Date: Thu, 6 Jun 2024 14:45:31 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] linux/interrupt.h: allow "guard" notation to disable and
 reenable IRQ
Message-ID: <ZmIt-3uiNedKxMkR@google.com>
References: <ZljAV6HjkPSEhWSw@google.com>
 <87ed9c5yp1.ffs@tglx>
 <Zl9_RsKZNYPpmGJ4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl9_RsKZNYPpmGJ4@google.com>

On Tue, Jun 04, 2024 at 01:55:34PM -0700, Dmitry Torokhov wrote:
> On Tue, Jun 04, 2024 at 08:51:06PM +0200, Thomas Gleixner wrote:
> > On Thu, May 30 2024 at 11:07, Dmitry Torokhov wrote:
> > > Drivers often need to first disable an interrupt, carry out some
> > > action, and then reenable the interrupt. Introduce support for the
> > > "guard" notation for this so that the following is possible:
> > >
> > > 	...
> > >
> > > 	scoped_cond_guard(mutex_intr, return -EINTR, &data->sysfs_mutex) {
> > > 		guard(disable_irq)(&client->irq);
> > >
> > > 		error = elan_acquire_baseline(data);
> > > 		if (error)
> > > 			return error;
> > > 	}
> > >
> > > 	...
> > >
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > I assume you want to carry this through the input tree, so you can
> > modify the drivers.
> > 
> > If so:
> > 
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Thanks Thomas. I'll stick this patch into an immutable branch off v6.9
> in case you (or someone else) wants to pull it in and start using it.

I made:

  git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git ib/6.9-disable-irq-guard

Thanks.

-- 
Dmitry


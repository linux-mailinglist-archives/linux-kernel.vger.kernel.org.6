Return-Path: <linux-kernel+bounces-513094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578D6A34163
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9256B7A26F4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339141487FA;
	Thu, 13 Feb 2025 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="j+SsLrO5"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4CE145A11
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455775; cv=none; b=MePwjJGBZom9fgsvtmuaOc4RavwtdcKcQUAfTrQRLLzM/sigVmirZoyVS4IeSYKASPPH8lX5w6+2/ZZgePlJV4kp9dhm/ovrMy31REkqBVsPS47I8Q3AI5gdIEv3Skb9k+zTxPNnL+eubyCpjYQF90G/xPNTO0pLFotQWp+XNF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455775; c=relaxed/simple;
	bh=bITAd8mMpklIAUS4JC6xN0NXMsNUvXCDm5eahLi6O7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aI/PozGTw2ru7RtcQI6j0ytGGlmlEahywcS+lXNAdlNYPCVjhqqm172eauF5AHOS7j2Teza1UvsKM8L0rSQ6CfFIOBNqAr/WpMwh9iazMQ+qkfl/nCi2DamyChTBQy0KyUbqJWyL2vom6N2j1SzVwbZyDbkAsvisWjOQaOWWg+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=j+SsLrO5; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 416943FE6F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739455765;
	bh=uT1aaGr8G8g8+cxLYkpklpbAkzbJ8av1g9g9BSJeMyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=j+SsLrO5prjZQAikljdkXfD0SRYTa3VmPG2pNML2dUz+MUD/DQdkbXRcW3FCk82xT
	 hJqsEi4LNi7FZgaa0Tk5bSFCxD06gfxC37Q9CsCYkgGf/7Kb/dr3y67bHjy5gVyRib
	 hn66GjJgiKKEjfONrm4yHRS6fx2MrYgG1Xbesu5CVn1tS/Cfno8Od80NzC5B2Gqegs
	 2DeZ6kLWQ4THBc66kVHgOwD6CALyRHtcamVX3AQ8nW7iLGdZriTf2Pii+/RtlIjcS7
	 3ydWCh7AXECFKBf/tdnAZVEjd9KNi/wY/+L7goQxc4VK3JiQD2pw/53q51z8rtuFpd
	 MZJFs8LC/rTcA==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fa3fd30d61so2166455a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 06:09:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739455763; x=1740060563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uT1aaGr8G8g8+cxLYkpklpbAkzbJ8av1g9g9BSJeMyk=;
        b=F6DQzmG1eAyLXkWl6GiSCSXZe47G4hyGLkQmxsUfCIc/mpu1V4hlcdvs5qgzL7IOqX
         nOM0F8DBtWQjTfmSXbq93mrqk161g7a+tnoVRosLe0ODA/uzMFwdBbyj4/R6/zXeiyGX
         cSgTtRwhxxyNBhHldWAo2UZym8r8ILkguK/dptOIgJRvw2JmqnJK+cnUYLB6VJm5Ni/U
         F3AP7WbgmQzh1zD/urFFHbG0Y3X1+eViqatIXpfznkA0oyjMV6vL6fntVP3TADMSPt82
         9FKcqCstXaViqzR87FpGjVIel+njVy0EGNznB5EXIprQXVp1bX+U7CCXKwktSNossNE4
         X5Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUUseMNASDkaSWhcWuqgTIpVFlRWHaY+7ckl1SnheV5U3UbzTsuQF0JF0q3BuZ8LtmICjUKJgkk8hM9NgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTgCAeQ7PvVJPEl6y8wZLsRvrzlOXfZ2elrap0Ib93zO/VAe3p
	9EHltV2sggHmuTpC5B+YJfVlXw2WZixxhYrrdhYpfk+WKvo9LDYL8Z6faRuMkfkabglRr5TeZEK
	4cOFA/DnpdLTmmVBmsUoHBm/TsAsdnz4YyMtEsAQdg0TWKm5IrasRIBxXc9Vg5+VIGYl8EO+h22
	fQWA==
X-Gm-Gg: ASbGncvlK/3WWIqeurvMu+xGYUjaleg5OWYlqFr//uEA2IqkQ3IzivqyWR6t3TcigL3
	nH/5NRMwVAcWZOKVaS3POk2ZkLp6czcfQzJoI/SadRg+vCh5uRGjByByy3VIFVoVC3v8iUk+MMi
	Fa1af06BESPTLJWU3GtCi7tFhoO7Ibu7K3oEcHwmMXWLULPRcHKhcfQ8CQHAUTo09lsXcfE+fH5
	/WUlu7hTWQ0fS5NVdIIGb/c6Pj1HyJ2+s6Jty4F//gVieCst1XVtXbvAOw+lmTGNgbIPA2svCZr
	gz7MuUc=
X-Received: by 2002:aa7:88c5:0:b0:725:e4b9:a600 with SMTP id d2e1a72fcca58-7322c5febe0mr8531715b3a.16.1739455763650;
        Thu, 13 Feb 2025 06:09:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2OC7Bly/7WjTJr49UdcU8b8bQ1YL9E84be+nLYkBfeQGCe4GDRRo2znH/scSBpDczXDVcaQ==
X-Received: by 2002:aa7:88c5:0:b0:725:e4b9:a600 with SMTP id d2e1a72fcca58-7322c5febe0mr8531682b3a.16.1739455763273;
        Thu, 13 Feb 2025 06:09:23 -0800 (PST)
Received: from localhost ([240f:74:7be:1:5439:d90c:a342:e2bb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324256f0dbsm1355536b3a.68.2025.02.13.06.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 06:09:22 -0800 (PST)
Date: Thu, 13 Feb 2025 23:09:20 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-gpio@vger.kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org, 
	maciej.borzecki@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] Introduce configfs-based interface for
 gpio-aggregator
Message-ID: <ziupltbphzkj6hngeqpjktwchqtj5ni2oum6cq5oa7agds5u2l@pwo7kdc3qiph>
References: <20250203031213.399914-1-koichiro.den@canonical.com>
 <CAMuHMdVoCf2VmgZOtNOPxhpTdYBWEWgCozLM+opaL7wOtF10_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVoCf2VmgZOtNOPxhpTdYBWEWgCozLM+opaL7wOtF10_A@mail.gmail.com>

On Wed, Feb 12, 2025 at 02:14:23PM GMT, Geert Uytterhoeven wrote:
> Hi Den-san,
> 
> On Mon, 3 Feb 2025 at 04:12, Koichiro Den <koichiro.den@canonical.com> wrote:
> > This patch series introduces a configfs-based interface to gpio-aggregator
> > to address limitations in the existing 'new_device' interface.
> >
> > The existing 'new_device' interface has several limitations:
> >
> >   #1. No way to determine when GPIO aggregator creation is complete.
> >   #2. No way to retrieve errors when creating a GPIO aggregator.
> >   #3. No way to trace a GPIO line of an aggregator back to its
> >       corresponding physical device.
> >   #4. The 'new_device' echo does not indicate which virtual gpiochip<N>
> >       was created.
> >   #5. No way to assign names to GPIO lines exported through an aggregator.
> >
> > Although Issue#1 to #3 could technically be resolved easily without
> > configfs, using configfs offers a streamlined, modern, and extensible
> > approach, especially since gpio-sim and gpio-virtuser already utilize
> > configfs.
> 
> Thanks for your series!
> 
> I gave it a try using all three ways of configuration (sysfs, configs,
> DT), and it works fine!
> 
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Gr{oetje,eeting}s,

Thank you very much for the through review! I'll reply to each of your comment.

Koichiro

> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds


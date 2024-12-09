Return-Path: <linux-kernel+bounces-436619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2569E88AC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 01:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C6B1884F15
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 00:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9019A3224;
	Mon,  9 Dec 2024 00:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="TDG5qE27"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1AB4A02
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 00:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733703181; cv=none; b=cfbIE+hnmb211V6AIkgV2JKOu82rOZZT2q9Iq06EFVC0NVPnx8f8C0UQApXz/uB+3dDYm/j2IPBgPK0JBl45EZuqJnp2i/K2G+7B1Ft2HHpqmUbOeaDZe1wTALlf3Mo582FizyNH79pDNOEnJ0JZ5bh9z2k/MCHejQ3oZaLgMg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733703181; c=relaxed/simple;
	bh=4+5cj21OXvPt8s52EbQUtIZfWKaIQ5K3J47KO0GgNTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cf9nivhF5DX7Ne+ZspOSIaeel1ZbwCNS79rUyp7h7k71C0UKfbJp+pjV7H95QLUV4JOeShyNYdS606dOkEG+H3b6JWLtanSMhh8w4MQQSKp3dfsb08XgmUia+QxLuZsgkNwBp3qX0tdcDfggNbHz0mmA77JDvDotE3cnicKO+Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=TDG5qE27; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DF6F53F763
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 00:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733703170;
	bh=/zQXzaQo3FpZ5kIyLKlZdgeHb/lvis7/2Uj2D3o32wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=TDG5qE27X5k7NlUggKUpgLr37kO7NE+5uU4VQVnKcMN3f276WAUWAOU2caPAMmAl6
	 uyaWEU3HJ1hJFnhbT4pHJ/4C0NbNbSkKDhp2OJuWXCwKVWvqrqYtovi3SS+RkFlO2Y
	 Ft7k7R8ONX1Ia1kB6QDFLxpou8VzNkhREhMgSvU5E4b8P+hJu8XRAQUMzguG7VLzyc
	 kDWA3fyoN4bsdiAYZsIPl+mfaZWmEBMrLpcOYGyU6DBAOQ3Za+aSLEE6S6H0ooPjyo
	 PCJ2S3HwqOlcYCuOsHes/V+UuK2LOmfHZnrsmOlfyR5r7PMzCeieaXi7wrjyZ4RjC4
	 qctwpH5pOxayw==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef35de8901so4243009a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 16:12:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733703168; x=1734307968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zQXzaQo3FpZ5kIyLKlZdgeHb/lvis7/2Uj2D3o32wE=;
        b=J9hxWSnTEITmD0rTeUhpz0OfUtvuMpvAKXXavVhKTSqEY4hFTU+Ldtj7ExeefWKLRA
         t9nChzL0sxzSCwdm/GRqwD5ceUXvV9bXNrthzrZwEfJFfphPWNdBy1VkHVcHfMZ4J1v3
         Z3EV0M1gKW6Mp04EsagQGOEVsKRSwsw6hkwtSO4MUdeHDTtlKkADc6r+4d184MO8dXk0
         Iet7zcio3R72WhCmf17h+koI3FiwnpR+MhZz1IipMeAXQtn+4F5XjYY3wCA3i1+eqes1
         ZPMRGsMwWT2i+bWNV0FpUUbgNWf7HDRvZmmXGOsw1lA+DJHrI51MDA+FKvA6XFh2xDjL
         4VPw==
X-Gm-Message-State: AOJu0YyHuBEbocR/77oaTAnm9p0uMhASpYici/FnI+KbtYcREXE1A/jH
	CUtH5U061OJv/3l11MkdYN6d3WuoY/2tHt0NNITgALdoBxfLoFp2SPw4Hy2mTDntgqZwvJIvRc2
	AnMrD8yX5x5KCQ72on4TLo+x8ckJwVPZA46iIDPkybGMZQ1UPzHKZ/NQaPl0ij0AzzU0ESkl1lv
	TmNUkB7HHXxA==
X-Gm-Gg: ASbGncsCzZUv5oTfJBgHcCK2oEhC0OvIvAFKu6yKG166FrcZJeg79o2A0KQJCHPmf+V
	QyrYWZAcMHkdjnVP/1f2urs67F2ONHgD+PobD0uA0kQKmAeZdvcNBBXX0BqFjl/T8zpgOjI5Nvf
	7Vc4XA+qWbRhb/40+XgVxaQb48hQxwxPRtZZGeonqhnLMPk8r4cGBZYmPNq01FAI3TUmu6vC0DC
	uiDrxXvZAjMf8EoTor387v9crMx5iFLxyjesB4uKM8zM/e0wGmE
X-Received: by 2002:a17:90b:52d0:b0:2ee:741c:e9f4 with SMTP id 98e67ed59e1d1-2ef69fffa77mr15312895a91.11.1733703167117;
        Sun, 08 Dec 2024 16:12:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHROnGo64J6iNXLNkCZEDdHXG/t0VWPu7Qo2vNQJY0GdFAicAb8TginhZ2apVF6du+bEXqe5Q==
X-Received: by 2002:a17:90b:52d0:b0:2ee:741c:e9f4 with SMTP id 98e67ed59e1d1-2ef69fffa77mr15312871a91.11.1733703166768;
        Sun, 08 Dec 2024 16:12:46 -0800 (PST)
Received: from localhost ([240f:74:7be:1:de9d:b666:2989:74a1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd3f4b77d7sm2101591a12.23.2024.12.08.16.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 16:12:46 -0800 (PST)
Date: Mon, 9 Dec 2024 09:12:44 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: Re: [PATCH] cpu/hotplug: ensure the starting section runs fully
 regardless of target
Message-ID: <j2k25hhxv42zuakbqc2miptypxee6j3vwkb5a4yz4vutj6swhv@c6ejjddjn6oq>
References: <20241207144721.2828390-1-koichiro.den@canonical.com>
 <87zfl5q5gi.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfl5q5gi.ffs@tglx>

On Sun, Dec 08, 2024 at 09:34:37PM +0100, Thomas Gleixner wrote:
> On Sat, Dec 07 2024 at 23:47, Koichiro Den wrote:
> >  static int take_cpu_down(void *_param)
> >  {
> >  	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
> > -	enum cpuhp_state target = max((int)st->target, CPUHP_AP_OFFLINE);
> >  	int err, cpu = smp_processor_id();
> >  
> >  	/* Ensure this CPU doesn't handle any more interrupts. */
> > @@ -1285,8 +1284,9 @@ static int take_cpu_down(void *_param)
> >  
> >  	/*
> >  	 * Invoke the former CPU_DYING callbacks. DYING must not fail!
> > +	 * Regardless of st->target, it must run through to CPUHP_AP_OFFLINE.
> >  	 */
> > -	cpuhp_invoke_callback_range_nofail(false, cpu, st, target);
> > +	cpuhp_invoke_callback_range_nofail(false, cpu, st, CPUHP_AP_OFFLINE);
> 
> This is really the wrong place. This want's to be enforced at the sysfs
> interface already and reject writes which are between AP_OFFLINE and
> AP_ONLINE.
>   
> It's utterly confusing to write a particular target and then magically
> end up at some other state.

Ok, I'll send v2. Thanks for the review.

-Koichiro Den

> 
> Thanks,
> 
>         tglx


Return-Path: <linux-kernel+bounces-437533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4409E947D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0AE162233
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE1E221DB3;
	Mon,  9 Dec 2024 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="VeJJq5XP"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14EB22488B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747959; cv=none; b=IP0G5+FuoXIGQiI8j4a2OU/ntDzjcVjYnuz3Wwn/2AUL9RxaeAckqvpryIxQPhPB1rOCcR183QPNeglm1YKIG2ogjFeqz2CwsoAvEMyRjf+ym6Yr15JBadNxB5LDNB0FCenlPnK7P7pEJkLQ3ph5/5eXbh6csBZ83LlwFCcdzIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747959; c=relaxed/simple;
	bh=C4keKz8hxRxEHDXnznkzy4uBaclpiPH9RkTK28F5dHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0yVY17PFxb/etDptM8PhhJwN9zUVfahrwHBlRlb6JZcEb7jlPzY7hQ1x/3mGA66zDuzqj+q9tOcSyaxXitr4b01jbRIFYeECau3g2kHPvzq7fNlcWzmXS2+UeQLAJb9WDvaZhMzJv+N9zgsfH8mkwsrGQsctSZQcEhy2pD5UI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=VeJJq5XP; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AEEAE3F42E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733747953;
	bh=hh3l5QNlWSKFvcjggc5vWn73abPFFtLpllUh9zm09pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=VeJJq5XPn9XGOcEvIDAeQmx9isOxbLgyeeOkfL00/hW5Hv3nXpnonvYcpbmlzva5p
	 zDhafCf8rI06zuCpUa5LOap2a1Z8iuiqseAq2oXut9sJKd9BdW5p8gR1dnU115qyeh
	 cgKLFIkMZwbxW9nIEWe9FksukijfCsN19LvmM3hEEpyQplitWUl3YuBsI8oikR6oL+
	 Mjq3zD7Emfu4E3Repbl6g1YNBrcJKgC1qccBiPIVXXgkXRmrtr/olqkXtxfYOMZ3Zx
	 Pi5Aoa6YiNMp9CqcYrXjsBL6RSEND9yFLLMxp+cGIsRThdvm5Kfu0xdwBj//f5ltn+
	 PxicL8JeFmgHA==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-725e4bee252so1176956b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 04:39:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733747952; x=1734352752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hh3l5QNlWSKFvcjggc5vWn73abPFFtLpllUh9zm09pQ=;
        b=e61ltbt0bBByj0n/mHixHkVsg6YKSHAGZHXB1/aYp7V3Xzk7EvYxSPTwHllhTBOMxq
         /+lY7iX8f9krTdjpV1IrZQL3X+mehPeJRgOfR4pqWRJ6WzNLIcT8dEvTvXtZl4/ixvJP
         cucdbUJtbvF4d6FfCSSLnEwW4vuyPv14RfSSvOm1UVtSkiYZpmlayzV4B/r+6Hp7+4Mj
         HGXXLvkdFuzz4sbrj+J3MQ/vzHHoR2TQcN6gSijkbSh72Xzxdxw9264W3seH32ye41dz
         YWUSSSgYKO+kZrbtB+7wFvI89+owNPaso4KsXzfMV3rAurolamKXvMgfTLvtJjb7NDFV
         GafQ==
X-Gm-Message-State: AOJu0YxyZEJwz1PjYxFyKjRvqh8YLHsvzgBubWp3P/71l55+Jl0+VGtA
	QmI1bw2AHFUVZ5njv0WKBdYFoCaQNyXgx9TGzaTVMTZmf2VgBpQdcxh6qlYgYyans7CnwF/ZAFt
	PDs9UEC1KLgR8uKrgHVE6lB4o3B49U6CgM1SG6qFytmSwBxTyLw5+FxFGpRUZhWF5GnDZuRVdCb
	VDXw==
X-Gm-Gg: ASbGncvg+WuUDrkc0f0JXgOOd/5SvzTuizNN7H6yPxW32hOkIWEqxN59oQIuZBH6vm1
	c/huLR8hK164y9fy8zSpesxiqqlyMirW3hKgf+zVpt3jL1c38uGS+9xY3ncBXBy9Sbc6eBCWDda
	NVUodxZNfSBPKLLhF+7FUEIIm3z6cw9oRgxJoA/goKOPNIPioZAUyf8Bf7uo9PXeG+mpEjFPfti
	0M8c1Z0ttekldz7j5djkQT5z8ti9ZLuvK++u7t/sVNRuQnG9QHi
X-Received: by 2002:a05:6a00:3cd3:b0:725:df1a:27d with SMTP id d2e1a72fcca58-725df1a17afmr8259498b3a.13.1733747952345;
        Mon, 09 Dec 2024 04:39:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnLDb1l3H+F0KgUMcPuC6iEGhC/Fq9tyvz2MIg6WvWr9iQEngEyn49f3AaphQhgJNCAvr2MQ==
X-Received: by 2002:a05:6a00:3cd3:b0:725:df1a:27d with SMTP id d2e1a72fcca58-725df1a17afmr8259485b3a.13.1733747952079;
        Mon, 09 Dec 2024 04:39:12 -0800 (PST)
Received: from localhost ([240f:74:7be:1:de9d:b666:2989:74a1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725eb14091fsm2119239b3a.9.2024.12.09.04.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 04:39:11 -0800 (PST)
Date: Mon, 9 Dec 2024 21:39:10 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: Re: [PATCH] cpu/hotplug: ensure the starting section runs fully
 regardless of target
Message-ID: <i6klnouskgr4btrssmyjlqlzrd2rsz6ig3okzjolrcj2srgwyx@xcbgyej4iktp>
References: <20241207144721.2828390-1-koichiro.den@canonical.com>
 <87zfl5q5gi.ffs@tglx>
 <j2k25hhxv42zuakbqc2miptypxee6j3vwkb5a4yz4vutj6swhv@c6ejjddjn6oq>
 <z7nvvzu5lpdnul2m35lrsa7wo6plx7zsunhowtog3nqydmpene@tzvb2hofjeal>
 <87wmg9oyzk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmg9oyzk.ffs@tglx>

On Mon, Dec 09, 2024 at 12:51:59PM +0100, Thomas Gleixner wrote:
> On Mon, Dec 09 2024 at 13:19, Koichiro Den wrote:
> > Now I'm wondering whether we should go further..
> > Because in PREPARE section, things are not fully symmetric, so
> > there is a problem like an example below:
> >
> >     E.g.
> >
> >     (1) writing <some state in between> into 'target' and then (2) bringing
> >     the the cpu fully online again by writing a large value leaves
> >     hrtimer_cpu_base's 'online' field at 0 because hrtimers:prepare does not
> >     re-run.
> >
> >            - hrtimers:prepare (CPUHP_HRTIMERS_PREPARE)
> >            - ...
> >     ------ - <some state in between>
> >      ^  :  - ...
> >      :  :  - hrtimers:dying (CPUHP_AP_HRTIMERS_DYING)
> >     (1)(2)
> >      :  :
> >      :  v
> 
> That got broken by me with commit:
> 
>   5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
> 
> and want's to be fixed.

I see, so let me address it while I'm at it.

> 
> > While I understand this is still a debug option, it seems to me that there are
> > several approaches to consider here. I'm inclined toward (a).
> >
> > (a). prohibit writing all halfway states in PREPARE+STARTING sections, i.e.
> >
> >      --- a/kernel/cpu.c
> >      +++ b/kernel/cpu.c
> >      @@ -2759,7 +2759,8 @@ static ssize_t target_store(struct device *dev,
> >                      return ret;
> >      
> >       #ifdef CONFIG_CPU_HOTPLUG_STATE_CONTROL
> >      -       if (target < CPUHP_OFFLINE || target > CPUHP_ONLINE)
> >      +       if (target != CPUHP_OFFLINE || target > CPUHP_ONLINE ||
> >      +           target < CPUHP_AP_OFFLINE_IDLE)
> >                      return -EINVAL;
> >       #else
> >              if (target != CPUHP_OFFLINE && target != CPUHP_ONLINE)
> 
> That's lame.

Hmm, could be. (By the way this was incorrect and I've fixed it here:
https://lore.kernel.org/all/20241207144721.2828390-1-koichiro.den@canonical.com/T/#mf6529a51167ffd1be52e1b67169442f486beb084

> 
> > (b). make all fully symmetric. (I'm not sure whether it could be possible)
> 
> There is no requirement to make everything symmetric as there are
> prepare steps which just allocate memory and do some basic
> initialization. So I rather go through the steps and keep the ability to
> invoke them fine granular in all directions (except for the atomic AP
> states which started this discussion.

Makes sense, I'm going to look carefully into every possible step and will
get back with v2 later. Thanks a lot for the review and discussion.

-Koichiro Den

> 
> > (c). add all safety catch at sysfs interface. (For the above example, once
> >      it goes down to <some state in between>, disallow to go up without
> >      once going down to a state earlier than hrtimers:prepare beforehand.
> >      I guess this would mess up source code unnecessarily though.)
> 
> That's unmaintainable.
> 
> Thanks,
> 
>         tglx


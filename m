Return-Path: <linux-kernel+bounces-355348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 649099950F8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7301F261A4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F2A1DF98F;
	Tue,  8 Oct 2024 14:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="vqbWoPWR"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049E94C97
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396286; cv=none; b=hLx8sZg64cpJDPc0jjjbH+l3DDtBhMa2b+xz/kZY0gg+0R5xi5MKdwK9yYxQ6AZaiU4I80v9FW851KxrFNmExJ/CVV70+fCW1HVO9gX+1Axf5/z6cpwCoewaD24zVfic/+/BOCazZeGVT2dXQCnq62AovQOFn5Q6r/KaMidtBTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396286; c=relaxed/simple;
	bh=TyjnE8Cl8BUiV44ccbi4F/Mx1PAYvm9DmLImjXSogU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMVlqiCCVxArEgHspzMlzzCGZKC0Om6pGvQ1q54CQ9tyLJuoOyi7lMqVFF4fiYP22TD63XJaVeqPKMAMEAC0xXtOPhvhlVbVPaIxu9j7bxHe5UCR8D787EJ30Igsm9tqrf+UyJJousc9HZ+c5fxWHRtXiwtoYShXEG5GuaMeGsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=vqbWoPWR; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7ae6f4b1f16so345135785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 07:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1728396283; x=1729001083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TyjnE8Cl8BUiV44ccbi4F/Mx1PAYvm9DmLImjXSogU8=;
        b=vqbWoPWR1x8oLFDAN6Y7ugzbPWhFXxeqy+13p50wYDbJtEg6qq6MeXfcrnJb4qy7w/
         p0zNR8x/SZPbDdrlqAJEkoMfni+zCPSiwya5sHHd7mWYd4RdT7EEpMb1yPYVoaQ0NrDc
         Tb+MLjwylCxuvySz9CNmjHm4dItSYaKpFKDGt4y0UIeRhDL9F2XJ0AoBEz8R0DfAV3VT
         B6oyRD6RSFlGje9fz4QCIADkBuma+FlYrhSw0crgC/pDwwDlQUjBmwCnRq4k11SeBOum
         hIu3cT/29a1Y5pHNdE1RGOj6ODHWguz2ewYpCDdkupv44SzaF0SRrKVz+/lhq2kC6dGb
         AY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396283; x=1729001083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyjnE8Cl8BUiV44ccbi4F/Mx1PAYvm9DmLImjXSogU8=;
        b=NbARogEwUQoGfenBbTZl1W9S2z9NAkKdptt90vlxmCBtsOQsvYq4FtKtXKLez7BGIe
         KtpwqjNgZitNC7wn79L+LwmjdX5JqN1shRHAAshQZJfGtrHR6YHXvy/7TxC4C9jTMgQq
         riIAp1Z+mbiPpFF16ozg8PA8PVT/hDJ6VurUiaXkpLuxRi0fsZYEj3TCUls5FyV8tAXQ
         XfmWlbf1s8eysjBOXRduLW+w0TS2ozZSLp6tGO4Kj3WJo+STujcijySez+cb6k6NyCAK
         llGdmteepVIrN49Z01vkpI9IrUlsCydpVmbxnIyLh3szmzjuV0Ltc7CaIxrFHqVYQTvU
         1tHw==
X-Forwarded-Encrypted: i=1; AJvYcCV/on69nF3jgT+Q3FkwP5oIWJPpeig5typatcMhwOinXndAc3eecjEdYGMNE4Awrx4xVzlAjdt0QotOUcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRjJcQWH7fQx57261bsgzsvByFyHfRXDgaxov8pQWhKbN/I76x
	Zsh5GU5zw0+VsCHRw2ULKTVmHgRNOpnJPJZDwoc7kTiR45aYoqRgDchyj0wrx4Q=
X-Google-Smtp-Source: AGHT+IFnW2G/DfWAVwb6xF3THBSDW4i0rfBOz3jsospEhAW/qdZuxZtZPhcU4bN7LYLHEFGNDDmj9w==
X-Received: by 2002:a05:620a:2993:b0:7a7:dd3a:a699 with SMTP id af79cd13be357-7ae6f421a2dmr2339888985a.11.1728396282545;
        Tue, 08 Oct 2024 07:04:42 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae7561e5d6sm356567985a.9.2024.10.08.07.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:04:41 -0700 (PDT)
Date: Tue, 8 Oct 2024 10:04:37 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, surenb@google.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] sched, psi: Don't account irq time if
 sched_clock_irqtime is disabled
Message-ID: <20241008140437.GA6937@cmpxchg.org>
References: <20241008061951.3980-1-laoar.shao@gmail.com>
 <20241008061951.3980-4-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008061951.3980-4-laoar.shao@gmail.com>

On Tue, Oct 08, 2024 at 02:19:50PM +0800, Yafang Shao wrote:
> sched_clock_irqtime may be disabled due to the clock source, in which case
> IRQ time should not be accounted. Let's add a conditional check to avoid
> unnecessary logic.

Makes sense. When disabled, irq_time_read() won't change over time, so
there is nothing to account. We can save iterating the whole hierarchy
on every tick and context switch.

> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>


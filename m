Return-Path: <linux-kernel+bounces-511233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEF6A3281E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C1F3A4D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E39E20F075;
	Wed, 12 Feb 2025 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JO8wS67u"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D69120F06D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739369478; cv=none; b=RE7zpbpKGAjTakXDoohaaz26UsPf7zjEr5BBTjG+6Oy0uIJiYGuiU1zJxXYcouTOnQzA2OJUu5+0fH3Z1sWVZqQXL5MtkgQLx8/arphHpH6zoQjJ+/8LTB+5Ub2FE4/WBSA5oZe55n6gV4Ky/uzrKp2T2Buu+V1CtfZWeYL1nQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739369478; c=relaxed/simple;
	bh=SZDQzEdFU0/q9RtREdktP8Ivyi5yYbZN3/bLAVSEb8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMMwJwjl6iweyVxJeEtwtvJVoXrq62fMNy26jw+++60UzPMXwruwNSWS//R/K0RUT6u/QZmpSF5BHKvfOj/GNq692n7jrgg5ql0qHimedYYO8+OGkRY1xl3XH6mUdcrmqKmCq+oAO+tQch1jtzOSIGHz1N8UihSX3vi9DS5VVQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JO8wS67u; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220ca204d04so3281085ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739369475; x=1739974275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stjpwGS2G5dhidrt/nQRRHComZAXCWzFNOoGsvIGoxo=;
        b=JO8wS67uTCPkZI+6Mhqu0NuD3QTAoTwwsjvZJmEiIQMUVJm/LveUryb5qpj3G13iOd
         EXV8cklKcQBvDCTxE12SDtK38DPDv7lHNStmA21xOTdwRqHnEkLtwKSDO5CrLOwKipIs
         AYGTKsTui7X+zqP2S2cTsw1A/OgNaIGVAceYIv0Ip57gmCnhWVuk9+NTIT4rAt11AVXG
         s0MOEmgrnNaAoDNHArMJwVXPfUJRhs7mCoUSBLIx7fp9evfWUa12ydvg9PsAdl8uwmrV
         X7epXvOwPsc7RaIXQ+74KU6lELCeAfEoEkWJjnm7Wp/xo/S1Ctv97SlevXzQl5+8WRRf
         +PQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739369475; x=1739974275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stjpwGS2G5dhidrt/nQRRHComZAXCWzFNOoGsvIGoxo=;
        b=U+Yj+E6Oc48z9gYTEFht5LQjsV2QpujkeAi6Vlr7u2HqSMfm32x9jvEEYITv2TemHN
         tTAB25lFjjIWr/MFKOBzU6QVnn2Nb8vE6yV3lYVlx5DYu/0LWWnaQKwANqpxrAdi2LA+
         otC2pgrLz+dD6AlyVL6KZgyqPDM1sAZ2W+GZG45xj/Wg5scn2Z9NVGxf4ewI9LqFivn1
         9lgrgLFZ3dKzrVavxQyVg01Ixisbo65jK/+xqOBp5eWBECtQcz7+gNuwrQ//7nZTjBOq
         vFgtkie2Z3jIOs2UfXulelcYJStWPlTDcxCU8kc5c/QfLo5AnBytqgUrNbkWnF0yFD1w
         Wp5A==
X-Forwarded-Encrypted: i=1; AJvYcCXWZpjllsHSnoZ/ZFO7SHMgINOPikm51A2GI3mR0kDeB4rLA+M/QwDaVlfmHY1+JSwjKMsF1CD5+KWl3DE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwykSIriho1jhf3KmYJ1kxT/JLhzBSana7SsrvNFz/9Kx0N9WTD
	lXMxQ1qAWHUJZx3ZBWImpj6uod/5HUh33+aq+FpD58tMT2THDaEK
X-Gm-Gg: ASbGncudd2TXtkTko1eXhw/uVr8Sfq1qMns/NHCB392zb9HLrXiq/KVu+mY4x99kVUg
	QxX3J2Y94MkLfyDfwyshrHADzrh2tmUEY91dRLifPBWveRqtk40yHjW27iRgUeCFduR1ev0w/BB
	oQYBdf4ZC/PD/tdhummc0AmNmsR+oAj4vDuTxZhaG3Sua6Xu6OVgqD2E/6pAvWy+RE+hl1eIxhR
	cHx8+Q/lYJV2burxqoYD3P+K57airoajTUHb7z3mXjWzNRfeDvH8Ij4ZQOf2VS9idV6smR8z3Iz
	8h7OBrWENp3hviW5XV2BQkjIIhQ/
X-Google-Smtp-Source: AGHT+IGqS5h3LITR2enOnLxAheGDNK25N/qKWi94gwDYPmAY0WnE01AlSp1naByLsZ5ToRI7b93Ucw==
X-Received: by 2002:a17:902:f604:b0:21f:85af:4bbf with SMTP id d9443c01a7336-220bbaf8ffdmr57225035ad.20.1739369475494;
        Wed, 12 Feb 2025 06:11:15 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220c8ee9dbfsm4942525ad.182.2025.02.12.06.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 06:11:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 12 Feb 2025 06:11:12 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/2] lockdep: Don't disable interrupts on RT in
 disable_irq_nosync_lockdep.*()
Message-ID: <2e997e85-fcf8-44bc-92bf-7d035c24abda@roeck-us.net>
References: <760e34f9-6034-40e0-82a5-ee9becd24438@roeck-us.net>
 <20250212103619.2560503-1-bigeasy@linutronix.de>
 <20250212103619.2560503-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212103619.2560503-2-bigeasy@linutronix.de>

On Wed, Feb 12, 2025 at 11:36:18AM +0100, Sebastian Andrzej Siewior wrote:
> disable_irq_nosync_lockdep() disables interrupts with lockdep enabled to
> avoid false positive reports by lockdep that a certain lock has not been
> acquired with disabled interrupts. The user of this macros expects that
> a lock can be acquried without disabling interrupts because the IRQ line
> triggering the interrupt is disabled.
> 
> This triggers a warning on PREEMPT_RT because after
> disable_irq_nosync_lockdep.*() the following spinlock_t now is acquired
> with disabled interrupts.
> 
> On PREEMPT_RT there is no difference between spin_lock() and
> spin_lock_irq() so avoiding disabling interrupts in this case works for
> the two remaining callers as of today.
> 
> Don't disable interrupts on PREEMPT_RT in disable_irq_nosync_lockdep.*().
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/760e34f9-6034-40e0-82a5-ee9becd24438@roeck-us.net
> Fixes: e8106b941ceab ("[PATCH] lockdep: core, add enable/disable_irq_irqsave/irqrestore() APIs")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Tested-by: Guenter Roeck <linux@roeck-us.net>


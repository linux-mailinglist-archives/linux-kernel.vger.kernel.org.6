Return-Path: <linux-kernel+bounces-511234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54241A3281F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081BC162354
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4F120F06F;
	Wed, 12 Feb 2025 14:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaztXb6H"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D30220AF62
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739369513; cv=none; b=EUIgovsDanJSqM2nGwidlY9HRcCSFWJbocvN8VdBUmSNRqK8tIyXPpQixSt69iQiQrfsueTH1BTKI1x7cpZ2n1b1mTVFhjOZWksYRiEJuyXfs634l4dYwYgdoT7e02dwmgrU5HgBcRjV2QpNRmipnQybKWEfDU9OfNzwS5ZYjco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739369513; c=relaxed/simple;
	bh=7lOc0ruExiQif30p007BjylF8cs6Vx5b/8b7quCgPYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTe++f1L+b6jLA2hKytamQAsRYHH7MnwYJEgAdDRSqosn2/X0VidTwYKXrQXmvZIb6Ok42BGP0xHlZcVNXfHSGOHjNkBmhfJ44AQJ/fBXMuVGjzfxTOoWMryBA3PXdEZ9Bq50aGESIjSBc5PLJ0pL+qg6ggnOO5NeD79bGRdYnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaztXb6H; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fa40c0bab2so8499386a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739369511; x=1739974311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u0tkLisKyCAJk/GTfjcId7DbkQwyWicb7CEmJ39+9v8=;
        b=TaztXb6HonZRSan9pkV1njAtgXCSC6fywHqdo1vtY8U9SYzQtp2Kh/bD5lnfl1F+LJ
         0NQIjX7J9MWyK3GU3yABPVQv2kqL4ihnlMBeCq1wdYtxuno4RiqbBXOHPzMBhEB6coOi
         D+Sx3WQdMQKrUod4dp8kYpXctTB9k5evSORCDvtLB0tTnkEhyeLoEPxIyUKlJPXcAp68
         bYATT+4RPtW7+HF676238w+OeTNMg6Bvl6z2tZAd3jXSp4OPMa2Wg/nH95S46iuY+3ah
         3TJ16SFnNsrgx8v3nqvjSu0VDKI7Tl+ybC943JdermjtIGgzAh2b+3VKkm94HUnoBcBg
         CtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739369511; x=1739974311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0tkLisKyCAJk/GTfjcId7DbkQwyWicb7CEmJ39+9v8=;
        b=tiR2uuNwtLRYXfWuEUSS363H90p08rAgpyd1b+Anqetlw68NzFXoCOf71hS+aBLKS2
         JhsfZ6LAAqCFhgITDBS4Nsy6tp5VVRkOb3O0G/U72X8vP+Zx6j+V5uV1XNr/V3u5nasf
         HsbN6ahPcQRQduqxvil0sXLanmoFvck8Um+BTta+tfn1dHw6oT179PsUdZrm/IT1gwEt
         3sfcmfCowbbkI9VVQ6fWO7CWQLSHwxJG0jF5qyvbz+LkYsDlws4v32bGq4jLFHZUugn2
         2QC6DLJ+Mbl7e3OxjplS/U8HkQDZfz5ME18GAtRsHSs7FUz/fMS2WixpbRwdXvE9hCJw
         nRfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD3w2C/hpnw2jD7GGAQI1CZ8j4eZD78FEQedsvRHllyf0w2ZMCUxd/y/Tx0WuYjEr2GAIwsRwqbx2vK+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWsJHDXyuXrvoNjhJ79mGqPgdROeBIXCqEn1UWDZxcRVKquS12
	q7rOHMD+UBdgNSHYxMI9hhI24loecOzz997jNYWGU+uZh022b8aJ
X-Gm-Gg: ASbGncuacR670ecreGe/nVSvEuhI+5foSRjbEex21BqZ7J43VbFPoCQFEIxf3oU0gEM
	pkKoJmzzU0KultlasnF0wVaYuuIC0dadgGRIOdkqaG9vaqMIlHeIDW+1KvWYoFjA+8SBtji67fU
	bVPKWpLPnaqu/7KkO1EaU5Q9Uzxi43XAmxcGis7MO8Zn4v15P5KIy1lBEgyymHNpFAF+OyGB8+7
	TtcSMKQBWUZcTFyIyEOJGfOsTQh9WTq5cPsl2Ri05d8U60nyM9mHgSywVP87XzsLKJZgrXQLikM
	+hXydc2GAQalpglq5oGSlIGe9F8i
X-Google-Smtp-Source: AGHT+IETXXt55AF3BS8Q/SxMhDT7/V0qdZbeRX07hF+De8jLBRthG3OBLKLNEFgHnNjV0zL6e6/Hww==
X-Received: by 2002:a05:6a00:181a:b0:731:e974:f9c2 with SMTP id d2e1a72fcca58-7322c0a00b4mr5240374b3a.0.1739369511452;
        Wed, 12 Feb 2025 06:11:51 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7321b34c003sm3317040b3a.52.2025.02.12.06.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 06:11:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 12 Feb 2025 06:11:49 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/2] lockdep: Remove disable_irq_lockdep().
Message-ID: <5c680698-2385-41bb-946c-4471f23554b8@roeck-us.net>
References: <760e34f9-6034-40e0-82a5-ee9becd24438@roeck-us.net>
 <20250212103619.2560503-1-bigeasy@linutronix.de>
 <20250212103619.2560503-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212103619.2560503-3-bigeasy@linutronix.de>

On Wed, Feb 12, 2025 at 11:36:19AM +0100, Sebastian Andrzej Siewior wrote:
> disable_irq_lockdep() has no users, last one was probabaly removed in
>    0b7c874348ea1 ("forcedeth: fix unilateral interrupt disabling in netpoll path")
> 
> Remove disable_irq_lockdep().
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


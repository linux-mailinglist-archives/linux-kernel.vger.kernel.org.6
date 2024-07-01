Return-Path: <linux-kernel+bounces-236589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E7691E473
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 394D4B23169
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8878B16D329;
	Mon,  1 Jul 2024 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NX9sB5CZ"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C3253AC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848616; cv=none; b=QKLIcnARZS75KP9Mfu3hKqrZuj0SSa+5JWy07PTCyi2PNwJ3/9FCrnSsbJOYFVjMAxSnFHM78ipm78eXkD5Ci5zsjX8wSFfbHg10jYtKZdLDY9tbPYsIWYtjoNB0hpuH8OVC/dns40Q+QUo5pWJXhSPe7LEfiMgJjf+Mt+r+Mn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848616; c=relaxed/simple;
	bh=Pszroelfb6fseP7TsvUcmdaT+1/eal5bduQrxlKvvp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEN+Yo2dE9DxEwm/SWA8ZyMjXOyN2O25ZjElDFM/ajFxxsJGMbC6beTpc52QIfYQ6QwV8Ikyb/4Lh+p5ZwnHyiaiYHSqaCxrSiI9SMe4b2J9XNuIhFpHg+BpCdDVXuy7x9m808ngfG88WR9Wd2Fa+OYU5z+XA38BoTCuvwhgeVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NX9sB5CZ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ee4ae13aabso33070741fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 08:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719848612; x=1720453412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9D4MaGdhz46XaQWXk2gMo9aiUSV0Gt3CUatckOrYrQs=;
        b=NX9sB5CZLXdF0YjtEw5IBq680/CP75pFGSQNLxIbZWB4cK6EsXIqbfP5n6APLDGoaH
         FyaYrbEvd2LIRu3zejsYuGeR5sUkB6viTulA993MX8QosUZYcid6hvUuMreKe1oCyG+N
         Tg1sEX1kYSLFLPWzw9OlVqKvA83AiCeEAPCZcuMF0OSfK9CcXEDKmp0TVmG9bedLytVP
         9t/4xAd3zgw9/uyxO5ctvG23ffP7zPN1NyGMAO4iaFD/yMaYMbjBIEiRrtx9SbfnEcxa
         +s0SHNUIXbj3qcbAMz22F/WNaM+SX7yaw5nwcvvt6qSEwMr9XoTWMB+U+zilXZl0f08R
         TAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719848612; x=1720453412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9D4MaGdhz46XaQWXk2gMo9aiUSV0Gt3CUatckOrYrQs=;
        b=vytAsMiwgebh7ewbxCbzGpRx5bfWP/WMObINU7//20et2UamFxiag3EhbRMYZlffS2
         m/0Co7HVn8VjM1qcWjdNlF/5e3j5dr9FvTx5aLZ13s/pgOFrB1l+LzofMcBfZqc9C4Ws
         PyyHRJeEFAI8s2H0FJlzloo9POJsmv8WKlS2u1kYLj9bE71Yq6igCtTuH77Ff4squgds
         rHWpiepW0i7he+RWm/YIN/TN0LloovnFrmpNvZ54L1Wtyw6I0iJL08IZLSfSPExr9txj
         p917RH7DY1fm9eJGRg81W6hrPR4uVZ8qIfbaHrLcQfj24w2fTFl9Ch8vLYDZBobLA9i4
         BARA==
X-Forwarded-Encrypted: i=1; AJvYcCX7giAEG750bTCy7qLlI2tyLeI3iNAnUIyho8nysIBCHDPOY0oe9v/wjHvvPVhhojF+Re+UuUfIJkVE9IqS4fvf4WqLKKwql7OB3D00
X-Gm-Message-State: AOJu0YxC3Offf79Z7TYNCpLCQzBfryw/ZQzV1jllx3fpORQ7hF1eeoP5
	t9f6f3kyFMWL7EV2M/vlsfI2guH/owcMKIQ0pGeLsne/Qe6v06yES9Lf50WQ/rw=
X-Google-Smtp-Source: AGHT+IHqnS0iuOO5oSlDGzivmCogKfrh/0LmHwl8kBjepSMtzVO7Sp6lxsTXVyT/1MEMjmB+cf5TsA==
X-Received: by 2002:a05:651c:244:b0:2ee:7255:5032 with SMTP id 38308e7fff4ca-2ee72555309mr5638471fa.34.1719848612020;
        Mon, 01 Jul 2024 08:43:32 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70801f5a2e3sm6664712b3a.21.2024.07.01.08.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:43:31 -0700 (PDT)
Date: Mon, 1 Jul 2024 17:43:21 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH printk v2 13/18] proc: consoles: Add notation to
 c_start/c_stop
Message-ID: <ZoLOmYR_pbXmD49q@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-14-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603232453.33992-14-john.ogness@linutronix.de>

On Tue 2024-06-04 01:30:48, John Ogness wrote:
> fs/proc/consoles.c:78:13: warning: context imbalance in 'c_start'
> 	- wrong count at exit
> fs/proc/consoles.c:104:13: warning: context imbalance in 'c_stop'
> 	- unexpected unlock
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


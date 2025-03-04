Return-Path: <linux-kernel+bounces-545277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1707A4EC52
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D9C8A2766
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D51C2780EC;
	Tue,  4 Mar 2025 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IycJjQzx"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387FE25F794
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110979; cv=none; b=WEh4iDVQV/CaYJ7wnsWMj/HSKDGaMEbkddsyIwV6Ge/hlU9wZHNSb5S6U905EEAASwUI8fHJ6NUAHh5KXIL21JeduPMCRH5SWU302wl1qTSEJ56JFMAKLOPYZ2YZm8ZhrpRgSieHEQvjfljRvmutkPajpBI6vPoLKm8xC9mtKOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110979; c=relaxed/simple;
	bh=x4YHUNQ6ugiCXy21RrSZcdByq7PRYgfIcYS0FCJIn8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEoVLXKiB0BXOIM5oE9DpL1JosqRuquidhnkGwZuI9+pxrTUNokwUEHQgcvBLES2oe5OTAYILCFPvQrdfhH6E8DS009Jc38ga+X31J3FzZ7j6FAFx5AGzQsDaP0xLf0J931khPz1AHxArp+CDsdX7NLK4XhISQ7r1pRHG2C9mJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IycJjQzx; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54958009d4dso3760732e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 09:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741110976; x=1741715776; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdovsrQ1jkNIZtQBYJyo7x4ZY0GarVCA9I3DNnH3GLc=;
        b=IycJjQzxim/i+TFwWio5rhkvICSURz7aZkof24/7tDbeLn1QZyEp5cviBx68ulWMEf
         vn9q9hEuKcRlO1VBHeFa9KiWi9G1IpU9e3nFG0Zmqr8hNMOD9tkJE52MIbVXEhn6jj6L
         5zK0Q0kwpV2Av2VpbPjyf33Ncrpt+sElAY2d1blHPgBgxUagvwa9RGobk0ybZJxicCUh
         HtHeqmk+HuTO8xyIpU3gLKaSRBsD8Rzdfb9P1JoEVGP0vhwmm8X41BowBJGzGAdlCZO2
         er8F49ODTsHzK3CrnivyW97yiAyE/9/ziUv0VqwkyP86Dre81znT/SovTX4zGFdUPX9c
         9bqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741110976; x=1741715776;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdovsrQ1jkNIZtQBYJyo7x4ZY0GarVCA9I3DNnH3GLc=;
        b=dvau0jLrB9SOqSLOUZpiHHlTGnbsVApw07vX27gXQBsdrsbTmo7TXrvRHo+Afyq48O
         upj6mBolvMpsSHWpW2TtPiTOxkaUIoxs2P1on1fACzBygfUVr/a/pYlba2NIIjG94iLg
         q6N8phW2H9uVowXnZKg6gJ5NU21HZVe9dxjQCQJPbV/RyirUh8cQ/RO4Ayam7uNu+s7w
         zDvqIfbM+HumY2A1ip2g3ssXmjTFMKkTyOsSlY2oecWNhTTOYNL0gupbs2GTtpjJI+oq
         IpPkKMThUQIgAHwBDOvn6RN9j5Fu567SX6fKv/QYPV6HpBZjY0y0qUjoGoYLnOTw/09h
         567g==
X-Gm-Message-State: AOJu0Yx966B+8y2srSmYdFZoihS+OH+jMGdsFTfy1srp4e7JzigPAPAf
	jdj0IwFSO0lxPg/vYtHsxrkA2g3nZtotwNeaXAQCp8ygd+tQDdGF
X-Gm-Gg: ASbGncsHJ6jMfyq+vhr0C1UNLSc/lXuEc50ezMA6qUyXg5kxDWcFlTAEBxbktTjr3ou
	K7tFDEQvlo3tBPzF3mT1NETL6G06rtUDuKlJtHNy+PxDTt7IuDjKbQLqwNS2IUx02PI7/c3Csju
	oMcoD92CTtVwI/HH0vMHim7oxVxPVwSmpO1SIqrRV30rNWZMV/jnOdjnFnOpfg01yTssTRalIAD
	xxNjy5ToyQULch/H2BfqWdg2EX+/LtBT5HhGvmx/MPkXOvps/5U77KIdCnVdacb5LYL/8zsEVkV
	YqsF5FPEWLoeXGU+2O9pK876+GeAlTq4iWOMndmu7MGQbQ==
X-Google-Smtp-Source: AGHT+IHQ9q9KQGCnEnd96VG+Oy1t4SiIxxYDqE6PUAV0EmgbvCJ1IgjPV0U31BiYJtV+eEJVuAjtCg==
X-Received: by 2002:a05:6512:3089:b0:545:ae6:d73f with SMTP id 2adb3069b0e04-5497d3808ebmr8272e87.46.1741110975759;
        Tue, 04 Mar 2025 09:56:15 -0800 (PST)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5495b6805ccsm1005413e87.182.2025.03.04.09.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:56:15 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
	id C72AE5A0136; Tue, 04 Mar 2025 20:56:14 +0300 (MSK)
Date: Tue, 4 Mar 2025 20:56:14 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 10/17] posix-timers: Make
 signal_struct::next_posix_timer_id an atomic_t
Message-ID: <Z8c-vvnMpPjYRvOn@grain>
References: <20250302185753.311903554@linutronix.de>
 <20250302193627.543399558@linutronix.de>
 <Z8YPQn0UpxucZLJP@grain>
 <87sentbyer.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sentbyer.ffs@tglx>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Mon, Mar 03, 2025 at 10:24:28PM +0100, Thomas Gleixner wrote:
> 
> Welcome. Some quick validation with CRIU would be appreciated.

Just tested in criu: works without problem, both modes -- with new
prctl and without it. Note that I only have ran separate posix-timers
test case, probably virtuozzo team might do more deep tesing.
---
root@fc:/home/cyrill/criu# test/zdtm.py run -t zdtm/static/posix_timers
userns is supported
The kernel is tainted: '512'
=== Run 1/1 ================ zdtm/static/posix_timers
====================== Run zdtm/static/posix_timers in h =======================
Start test
./posix_timers --pidfile=posix_timers.pid --outfile=posix_timers.out
Run criu dump
Run criu restore
Send the 15 signal to  56
Wait for zdtm/static/posix_timers(56) to die for 0.100000
Removing dump/zdtm/static/posix_timers/56
====================== Test zdtm/static/posix_timers PASS ======================



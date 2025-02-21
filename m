Return-Path: <linux-kernel+bounces-525625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB8FA3F272
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7795E17629F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521A620101F;
	Fri, 21 Feb 2025 10:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="bShylq91"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F0A1F03EF
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740134904; cv=none; b=IT9rQ/7iqE7Ux7IwhU/XwYhGkXNbRx60sVLqqobeorUByCQ62thdC4Nrqyl3mIXZDcVWY0Ar4tgQ6hsXOwJ/DA5GOiyl8AeW23nPLgnNGGLoFHi48pbf5zqomXWGusv5txZjfzKqD2Prw3K5FOeF736Poqn8fUOpiNTJC32ZKOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740134904; c=relaxed/simple;
	bh=6vR+TEiH5suPoSHJ1QLKsqeNt+6EiaZqxxQ/iGHjpSs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FVdMWno7XIkq70LPLLndI0z5XHqc8GtGpOy7A4xE+03ZG48M/IGpNYuX9MlPMZnkWEW2oN12QYkEYDh9hD4u+Ek7CBNTz6Tlgoify6oxOqYSua+hr64YLZGOgzjUos1JEfnyCysbAZzLtKAyQn7yN7uX9ZjP9HRuLkeyS5xCI+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=bShylq91; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-307c13298eeso22701961fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 02:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1740134901; x=1740739701; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6vR+TEiH5suPoSHJ1QLKsqeNt+6EiaZqxxQ/iGHjpSs=;
        b=bShylq91Xww3U2dPUsZr831raOnEXMxqm5dAGlIkcTwWQ5B4kyFY/bNcmZBsDLTjPD
         bnwgyLA/qTtjD6wDi3RNvb4S1aUaS5j3XF0tu/cPLmVrvziK+ah1+hkcE5adIUsW4v+o
         OauoHHp9WkRSyzGymyQj1bUWQ0zw5+CrsjyxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740134901; x=1740739701;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vR+TEiH5suPoSHJ1QLKsqeNt+6EiaZqxxQ/iGHjpSs=;
        b=KtSUZsPv0XXb2hxqOf/5YIGpQ2WrxBX5m/arUonGl9N3nJQrVkRwv8i3S2zOq/k1eu
         zE/tr7knSGswbfEFWBoe+PWFXgopbkaHvzDYp0Nxpk+IQmlcNECRv1sgFa+8hv/tOxpD
         bFukiTG7IU99RoOkkoDtjmnxYDAc1Wl7e3FGAaxjlUtwCFL4J26cbBPIS045mpN+U2Qk
         bp8ynL4EvcdrsIYJI3R20T5d786wEKFwNvYzfwa2TNn0WR/2CftAyzEc4WF4b56W0OmJ
         Rej775hglKfc8jrVT+3O9cia9kbK0tCfVtypDvrrbQdFB8zmjJ4AZkE7ilx0lcxLj0ko
         mwtg==
X-Forwarded-Encrypted: i=1; AJvYcCVau+8r2N4+tgdfniTYahBqvmdfnFWd8pQsAYzjGKeV69YpndC4suXMeMs0lnDWUQLCrrw01w2dP54IznU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+dB0pQa43HOmvP0acsN3KDmVQBJFN27OIYWm6lDmSCP1RrMlX
	V+JiRhW9kxW7nxmeEm+8BOReFYGxL7dT99yRJm9TwTOb1Wwql1gHsnnePaCr/52SzZ/ZCzCpWSM
	hlaOuaw==
X-Gm-Gg: ASbGnctys9ay9XeuzIplgL3dI2rAdAEdNEz+FWYwkNbCFc8hEOaU8OTZtcy7cuJ5+08
	h3mdytFTvHU/fwMK2MOqAHqLpciDP4Uvzuka+6yNYdwAvaDAjpwCmyM5I3sS890tGmibcAQY+mW
	eG1IdZqDTOPGikuV4sJHXMQYWlGbfbbKHDpKAH96aB+QqvTAEJdZxuWZlHIw9s4MrA14DLWn/1u
	Fo2VSeZ9mKJQUGgc0UidpLS/EtK24JJjKmAnC9EczrLB7nvjyaUOCujEytE0185UAx5T1GvMy4Y
	WCWFtIZG+K1EpvxCJVZH18WieUM=
X-Google-Smtp-Source: AGHT+IEuI2ueJ54VQyWBbWJeHfFpz3nm7mH8Jqru0OTTgwkkKtB2v0B9s5ZZn+FWongNN/eNaVdGaQ==
X-Received: by 2002:a2e:98ce:0:b0:30a:2b40:af0a with SMTP id 38308e7fff4ca-30a505bbbb3mr22231871fa.2.1740134901015;
        Fri, 21 Feb 2025 02:48:21 -0800 (PST)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-30a29ab47adsm17629081fa.97.2025.02.21.02.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 02:48:20 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>,
  linux-kernel@vger.kernel.org,  linux-modules@vger.kernel.org,
  code@tyhicks.com,  christophe.leroy@csgroup.eu,  hch@infradead.org,
  mcgrof@kernel.org,  frkaya@linux.microsoft.com,
  vijayb@linux.microsoft.com,  linux@weissschuh.net,
  samitolvanen@google.com,  da.gomez@samsung.com,
  gregkh@linuxfoundation.org,  rafael@kernel.org,  dakr@kernel.org
Subject: Re: [PATCH v3 3/4] kernel: globalize lookup_or_create_module_kobject()
In-Reply-To: <450e8088-c239-4738-a996-834734f770a5@suse.com> (Petr Pavlu's
	message of "Thu, 13 Feb 2025 16:59:25 +0100")
References: <20250211214842.1806521-1-shyamsaini@linux.microsoft.com>
	<20250211214842.1806521-4-shyamsaini@linux.microsoft.com>
	<450e8088-c239-4738-a996-834734f770a5@suse.com>
Date: Fri, 21 Feb 2025 11:48:19 +0100
Message-ID: <87pljbo9os.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Feb 13 2025, Petr Pavlu <petr.pavlu@suse.com> wrote:

> On 2/11/25 22:48, Shyam Saini wrote:
>> lookup_or_create_module_kobject() is marked as static and __init,
>> to make it global drop static keyword.
>> Since this function can be called from non-init code, use __modinit
>> instead of __init, __modinit marker will make it __init if
>> CONFIG_MODULES is not defined.
>
> Hm, we should later clean up kernel/params.c to use __init_or_module
> from include/linux/module.h instead of its own __modinit implementation.

Good catch, yes. Mind sending the patch?

Rasmus


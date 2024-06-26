Return-Path: <linux-kernel+bounces-231105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 612F291863D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 190E42829EB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9E418C359;
	Wed, 26 Jun 2024 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ONu2HtKR"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F13018A920
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719417032; cv=none; b=l6TvKeY4c+jmY9z0TYs4xSLX/4y2HbUoTEhxJnddAvYtbz85+0Hw2JXa+PpMOZTQduahOl3/NhrdQRNkqUoKTHCLMpwYUW1TK0CP4RbCzEYIBYpwmbZDgTClCfSVJrOWCWbRYyE2kkT6Tx0iVZBEdQZmNPGKGGAzJIkaZYFxPKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719417032; c=relaxed/simple;
	bh=37ZNP33e8+7HO0gnq2NbaftX9ElKyKSPmZLHZYCftzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJpgKGnei2WOrRM5c4kcIh0P9Of1C10tpwQBlMt9NhWcRfGSHs5++qG0jKYhC6PQZ76Fqxx1GWS2IfPTtoUUbeNzSz+Pzr8A6tHHKta7HK7HWsrBlA+WDWOAi2xn2dgEtdruaQRDjLJEuZpIaDE4hLPZi4YxCXPGF9HDxyaGtc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ONu2HtKR; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a72585032f1so460392066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719417028; x=1720021828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uzAm2VJPpaiV1Xbr7cm5GnjinWJJrnRXltU4y23jQs4=;
        b=ONu2HtKRBvxqmOD2z6rypEJiVJrI6H0sonuOSzZB5pXn7J1h1f8vSMHhvR30NOKbsl
         wdLDLhvWamIUk9BEX4MSp6rU+uPkQlvJf6miHAEeR8IRzA1R4P/qVd5INgaQLQSklg82
         yTzjbyhdjyn3jz7uAghvLAK/dq/udBrqilLFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719417028; x=1720021828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uzAm2VJPpaiV1Xbr7cm5GnjinWJJrnRXltU4y23jQs4=;
        b=enRq1yXTN97m7RmE7ufLEmOmppua8Y1xraf/B0L3yBXlN3CkK1q7Bv4g7z9Yd6aT+0
         4GpRsWWTXIHm2DwZ6TZ3fDgA8aTkIir6Uhiv+1uZVmCkPTCsvjAiurwaPHHc9EUcKVba
         4kixsX5sWSQEKFar+22+ZvsBgS0IdQahNpADR+jIQjIYez8NFjsZJQ5nG9fZI1c3G6BO
         bee7ZCakeuEcxdGFDj6S8hT7B2dYqTo4yMc/EWgNnd65eWo22Qm+lNLfX+NlgK6ed/O7
         /DBYjF0hi+kMV4PRSyGIQ0L6ZRtPQ4aNjds/fk+Se1lp8FGZmHXLAMDTX01hoDgFLAlA
         DirA==
X-Forwarded-Encrypted: i=1; AJvYcCVZAuZyVghqT6a8Exe3imbr4sqTLiu5LruPafPWSljsaabt1EV3Zy9pREJrGkRQ3PudVL08lQIIritA3177OhCHVj/4pu9eQgP8XNce
X-Gm-Message-State: AOJu0YxAe/Nw+LecR/Juc0UqRVOdAuKCsKuvDMc1GoNVwF+VlDNSDQr4
	qNu+scr5nD8+a/xFW34MaoPQMv8lj5CQJ/6/u/rhz2tvyRUzQVztsdpAILJ6x01meKFdpK44YHi
	PAmRQ1Q==
X-Google-Smtp-Source: AGHT+IG+hmu+4VsT2Ct8qtIslbTR2pL2MJQw1XkJFU/BEXnluYeaMqn69PvXD2vnchFj0LcQNP6BBA==
X-Received: by 2002:a17:907:cb88:b0:a72:75a5:bb46 with SMTP id a640c23a62f3a-a7275a5c290mr479271766b.13.1719417028325;
        Wed, 26 Jun 2024 08:50:28 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7251e3284dsm349227466b.150.2024.06.26.08.50.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 08:50:27 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a72585032f1so460385966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:50:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX6A3ky2/9cHH7/gGMRK1xeq5m18Q31UcKMsNrN8pQ8prAnFJU/E33aof740eD96Grf50ak/h/WKA2BJxOLsh3u2BAtXuHGIa8wwC4V
X-Received: by 2002:a17:906:c009:b0:a6f:af31:6e7 with SMTP id
 a640c23a62f3a-a715f94b0f4mr797666866b.32.1719417026789; Wed, 26 Jun 2024
 08:50:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625133151.GA1554@www.linux-watchdog.org>
In-Reply-To: <20240625133151.GA1554@www.linux-watchdog.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Jun 2024 08:50:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whgnEuO1+8Gk3AiWeuSeAuCoUWnkuxUvczHwfJL+juAsA@mail.gmail.com>
Message-ID: <CAHk-=whgnEuO1+8Gk3AiWeuSeAuCoUWnkuxUvczHwfJL+juAsA@mail.gmail.com>
Subject: Re: [GIT PULL REQUEST] watchdog - v6.10 release cycle (fixes).
To: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	Arnd Bergmann <arnd@arndb.de>, Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 06:51, Wim Van Sebroeck <wim@linux-watchdog.org> wrote:
>
>   git://www.linux-watchdog.org/linux-watchdog.git linux-watchdog-6.10-rc-fixes

ENOSUCHTAG.

I do see the commit you mention in HEAD, but there's no actual signed
tag referencing it.

Forgot to push out (and then didn't react to the error messages that
git request-pull gave you)?

             Linus


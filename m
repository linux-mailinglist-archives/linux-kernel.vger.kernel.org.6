Return-Path: <linux-kernel+bounces-418731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDAE9D64CB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 21:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49B7E16173E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 20:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799EB1DF759;
	Fri, 22 Nov 2024 20:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bCqQF10g"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9601CA9C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732306430; cv=none; b=F79bC0sezwpwAtuWGnKgDYJWyf8cGqzSWngKQbjfRuuu+rU5REi1WH+VABL+dePZwQoCqxJhpNHWX5BL0l/YBWAMhLFho+GgIhUxyUgDkxkvctpm8u4KYN38gdxz9La/sOxk2XCIEIjiNhnxicc/p9+bUeOvrCMpLtdh2kI8kew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732306430; c=relaxed/simple;
	bh=Al52IVYlw6WWn9uR1u24phMevEiAi09JlnRTCVOEMXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bE9gdqLnSEHzbD5J3f3PoTF+NeXmqIugNFrY3bvrp8wCryhMEIsexQiXOVVhq3uxh5m3OsNC7D1Kmb96pi+eESPXkEGtmkxWWGuHyT/jrOsX5MhTMdxYvWX8N2XzEK/FOCpJ2Ey3qtr2zQJiHbordQDSwuEYhO/o3lty1dzvwTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bCqQF10g; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso46475351fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732306427; x=1732911227; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xrOuhtHiEN5MUhidQKOtdSEF2jRNUStbCjbArbwZw6g=;
        b=bCqQF10grgyrFa6MEPlb991hug8d+kDt3ADE0PJMUDFKq29wf/pIhF+NZCCDexpk3p
         zniiis2+tyYyB047McDJ20QefFvI7SHbHodABqAh9N+wFNCBc5RQ5VwG3gEB1MrZibUJ
         tUJ6qADx9gVckULqPJKnpy1U40gO3vAlc/QbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732306427; x=1732911227;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrOuhtHiEN5MUhidQKOtdSEF2jRNUStbCjbArbwZw6g=;
        b=wAE8qcDQKsFFfJ3qVDYqVeZpVZZjW30PcmCSeun4fz7bNG2HFMzK3U+BKdLurae8Is
         ysvn5hr3l7pVLNY4ylE5Od+F9rOgcQX4yK9Nb9qvt/lgLgp7de79HJgPRiogYAQ+15nN
         i64BQOD4EkrmLjG3YdYuVhu84sfa2Bc6LzWHsCeBAs4/V3cxY15lJIJc6q+/z+4E98+q
         AqeFDfScjpjMENDRSu8YbUc02ws1ms+D38j5bkeJDLXwWQVnqQmHbLKcS2uRrnvxJKUZ
         QNCG1oIyJ2ilRnL2eORYqUCdwvhKRNB09GGuyJ5/XMhsN3ne8TQeoNNauou9w8kK9yCl
         ONYg==
X-Forwarded-Encrypted: i=1; AJvYcCWk32eJibRQLMnZtDULSjxUEtzMi/TprVH/gC1QFsjiHbdeEZZsKS/adBAC5gHvvpUcsjLx5MbUZfSoNV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+e6WgsFNLivBB0JqTVoeE9KXEwLiuRAQRZx/FT+vj+KEGC5oe
	iHFOwe8IPNgUG6eJ8rwAYmcIJ0qKt0C1eH9KJ8CjJMqInlUvYtMFlDiMjpDevz2T2BrU7ay2ndh
	+q7FQ6A==
X-Gm-Gg: ASbGncs/B2z/Z/kzNfCPN4a2NK8DKwQZEJbFADYNQi3DcJzAjxi+6cBf5du3YFrfOod
	ArQF2hKuPlwlJ3yV0s37mDAbmM78K6bQHxrDwoyXbU3jYu3qLaiNxXYTTfQ14naLyD5l+SVuwDJ
	fLP6p6n64JnkpcujfepSmJX6uhnZDhvMnFiSoeGCz2hdh6SGj+dr3CLcgqUVhtQczlGiT54StnR
	aMAkDZsP2n/Hqj7RDdycXL8CLmZeilRfzdM4Dzoor8GvnUMUux1ioYq0IzvUENwmaOoJz3GloX7
	yJXVdUUwqK/4cZaAH8HxDP/Y1gil
X-Google-Smtp-Source: AGHT+IH3ugKrH9+tyn8ca58QsMDTBJ0L2CoGaIUuQffWFrPZy9Ms7qUff69TuzPzC9EttwIma8OALQ==
X-Received: by 2002:a05:651c:2103:b0:2fb:cff:b535 with SMTP id 38308e7fff4ca-2ffa710693amr36069661fa.13.1732306426638;
        Fri, 22 Nov 2024 12:13:46 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffa4d3f5c8sm4822031fa.40.2024.11.22.12.13.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 12:13:45 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso44679441fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:13:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVKGPYQNdY5qUEAfpKl6HWeBVuUOs/OpM6+alyppFbERejQChRcM1gw5ZHzeYtoQmx7ygxjkPoocg2CEKQ=@vger.kernel.org
X-Received: by 2002:a05:651c:b0a:b0:2ff:59fa:44f1 with SMTP id
 38308e7fff4ca-2ffa70f164amr38941831fa.1.1732306423938; Fri, 22 Nov 2024
 12:13:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2411182207390.20286@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2411182207390.20286@cbobk.fhfr.pm>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Nov 2024 12:13:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiUkQM3uheit2cNM0Y0OOY5qqspJgC8LkmOkJ2p2LDxcw@mail.gmail.com>
Message-ID: <CAHk-=wiUkQM3uheit2cNM0Y0OOY5qqspJgC8LkmOkJ2p2LDxcw@mail.gmail.com>
Subject: Re: [GIT PULL] HID for 6.13
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Nov 2024 at 13:16, Jiri Kosina <jikos@kernel.org> wrote:
>
> please pull from
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024111801
>
> to receive HID subsystem queue for 6.13 merge window.

Hmm. There's something odd going on here. My mouse scroll-wheel
stopped working (Logitech MX Anywhere 3), and this pull would look
like the prime suspect.

The mouse otherwise works, so it's not that the mouse isn't found,
it's literally just the scroll-wheel functionality that doesn't work.

Oddly enough, if I remove and re-insert the Logitech wireless dongle,
the scroll wheel works again. So it's not some kind of complete
breakage - but it also wasn't a one-time fluke thing, in that it
happened twice in a row when rebooting into a new kernel.

Any ideas? Does this make anybody go "Hmm, maybe ..."

                Linus


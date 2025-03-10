Return-Path: <linux-kernel+bounces-553447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 645CDA589D2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 01:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27FD169475
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 00:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCD638DDB;
	Mon, 10 Mar 2025 00:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pvyM7dt2"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C4235976
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 00:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741568043; cv=none; b=IGG2lB9cIvjEopC4aVcOFKpPdmkn86mX8WFro/H7P5cyXzYpLAXw26wGcVWKew1I1uuH4u2wmx9gTPs0AjpCM8AnASzIu2giaapDipEJNb7vQKa8DwTTVhBo25gzdpe0I31etz5JGRCnP3x5eScDHbLLVC9JwqdLJc6L6GLIkgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741568043; c=relaxed/simple;
	bh=gNukGFOQEvF3RMbXLA/FmYPjLOTe7W5SSESuvAk89dQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IpepsscQpuwvm7PvxPQ8Bblv7AMTO5M6tep20nN7WCmcA6TQb4mWQgAAjcJfPm49cUiaAPDanqiTWDu1LLKv10dzlkLd7iRsSRq1S2D1dRS7xkY9qj+6IPP5AzxYbE0YQQfcnPgtdkmHr8RTzuu6SWai9WAJV/GubyoqE4hbPss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pvyM7dt2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2242aca53efso161355ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 17:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741568041; x=1742172841; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5aFGI7k9fvuEWSz7M+B4jyDl0IdV3U4f+IuWu0MGYns=;
        b=pvyM7dt2SSI9gCJjtqXv6GpcMpQyQbnf/13SVDA3IZQpvAIc34zzeR0A6BynCgv+3h
         LV2raS0qXvRy0Efi8B8gVE3vY8coeptvXuUJ/XzcYPN5wpku/sSfh2DEVIZZ4DJ3FCHZ
         EMwvE8HSjRktQHRinH2jm7YkWqVbmq2Yny3PxVieDjGxTzYOH26ibAzkMJXnkx1ZAafy
         UsolMxgZ8jSMSUq5HDAu7LZTgnTO4Gwxos7TZr36v1OnkS2r9queqiXXTID9GMua4m+x
         jH+2/sKnpDnLRknzOq7oVMlShZzSJanP732wCUaB5F1oLfEsb5D8ltAbLaONplt/egRe
         HGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741568041; x=1742172841;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5aFGI7k9fvuEWSz7M+B4jyDl0IdV3U4f+IuWu0MGYns=;
        b=lo5gfBA1C5HRBuAW2/w+uMdYnpmtDQWPZQzADFhmMWIxCr27sMBAknwHDpmptIGVD4
         cInFeaDOC923H3NctKvIYqFmnX98R/Dk/7JqZVJvtoosn7JQ/tUe+xXKbVPoHGGwDYj1
         vGH/NVt/8WTGIl7WoXlvTgwwuqDY4S+7IBTKf2+pH6DEOK90Qjp+kEWXmVhinI5b7ru2
         FMS/YnkA7E+VKt4mmKCnipRIQW2Nqw1/GROPlsCBHQ6EUxDfKiZy7rFjRbwfggvUX18M
         QTNN2w7rlVPuAnYq2LPUkoMUm1rSOQ1i8Hfs5nDHMDIzCcOL5JZrehiaQ/rx9HjlJ4f8
         cVaw==
X-Forwarded-Encrypted: i=1; AJvYcCUAQjhfevaGQIsSqeDXzin5sgVcjbNac/vhnkscQPOfkEoc3nShbY1t0e1V7NnaqHT8kK97fZrGq0qH34U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLhisebBtiijOHqYDnsbzrewgwxR//UclHn325YZgoVxjS/xHe
	/PfPLxOyXYf6wDLhFROVTkqrjbYdXF63NeAidSV+XueLXCZtDr1gcLNSN6d2xw==
X-Gm-Gg: ASbGncvulJV7DHwdFAB1SPCpeUiDKr4ABosIFVrwjCjo+oWWb6EM1Tv98DYUhw22mTt
	WMkPUmZ2PdOz4gFoFLnXdLPvk9p0imK9fS0GryWFrM3OXeoaAWfYmicwfTC5MtsagtZ4UhkOfu/
	HJM7VjmHldzFz8RsCMpEA6MgzxKwP57tQWfVzFQOn3+jSZ4kHfOJH+OF2I+b/n6JM/K0W84jkjm
	qmsMHzYX0HxjUXv4Dz5lUHjAifO4pEy4shyxfP8kf7U4Qqxrvg5uPYOEb+TCmnCpmKUyp1U2muq
	nL4nrOQzeR6UXxyxvSLpmsFufZKz/AfD8oxr2Y5USVhMuwEudALZQl55jLSB0Pvocrj7+rutmmP
	BFHoXFtpJLk2/MANKHRMCQDI6Ro3lKfGshAbK6yk=
X-Google-Smtp-Source: AGHT+IFA4jjQFXwsUFKTNgFJ6BtN2sXHBnTFAjW1MW82CdCiNN1rvYnOpZq7fII08zyQTfPKCm96hA==
X-Received: by 2002:a17:902:d4c6:b0:215:aca2:dc04 with SMTP id d9443c01a7336-225416ae5famr2687805ad.26.1741568040939;
        Sun, 09 Mar 2025 17:54:00 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:ee55:e440:a203:909f] ([2a00:79e0:2eb0:8:ee55:e440:a203:909f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736c7ac6e11sm2487943b3a.148.2025.03.09.17.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 17:54:00 -0700 (PDT)
Date: Sun, 9 Mar 2025 17:53:59 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Martin Liu <liumartin@google.com>
cc: Steven Rostedt <rostedt@goodmis.org>, 
    Masami Hiramatsu <mhiramat@kernel.org>, 
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
    Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
    linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/3] mm/page_alloc: Add trace event for per-zone lowmem
 reserve setup
In-Reply-To: <20250308034606.2036033-3-liumartin@google.com>
Message-ID: <611025a1-d6aa-57a9-5848-73874eee0dba@google.com>
References: <20250308034606.2036033-1-liumartin@google.com> <20250308034606.2036033-3-liumartin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 8 Mar 2025, Martin Liu wrote:

> This commit introduces the `mm_setup_per_zone_lowmem_reserve` trace
> event,which provides detailed insights into the kernel's per-zone lowmem
> reserve configuration.
> 
> The trace event provides precise timestamps, allowing developers to
> 
> 1. Correlate lowmem reserve changes with specific kernel events and
> able to diagnose unexpected kswapd or direct reclaim behavior
> triggered by dynamic changes in lowmem reserve.
> 
> 2. know memory allocation failures that occur due to insufficient lowmem
> reserve, by precisely correlating allocation attempts with reserve
> adjustments.
> 
> Signed-off-by: Martin Liu <liumartin@google.com>

Acked-by: David Rientjes <rientjes@google.com>


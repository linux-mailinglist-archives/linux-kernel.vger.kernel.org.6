Return-Path: <linux-kernel+bounces-316654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3B296D264
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643BC284851
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A93194ACB;
	Thu,  5 Sep 2024 08:42:59 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6C5188A1F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725525779; cv=none; b=IunVRca2bXuQ0Y3bgO29LogwyR6yqFUCOemF+KBbDschg5G7GmXU2ETeowkF3eUmwx8eExBqCTNsGmrDptEpxIbQrlbsnqPDdtgbrD5cSZJ1Wz+1/LTrRYSca00hNesp7mJPAdJm9QyPfKFddjRjX0neoM6AuKIxWYY+3rgHdcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725525779; c=relaxed/simple;
	bh=ChgFo9eXz1riBlmQc9b0eHc1s4jpQzKcj8FtnnMjiVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxUSv9F+pafvCDRJBR7LykAHxEnn/H0Xv/9nm9EiimTSewXEb4Vj4t+Dywe16lqHHxlrTRE1mvX165pTgVkclGOPHOjeEjKEd02+K2PJX75cYAgl5AvQ/lEw3rCFOpQBm1p4edv0H5Db4j6Vke2EluA7ugKntGK6YBabQT8/jew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6c3f1939d12so4082377b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 01:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725525775; x=1726130575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZSY7FNZtnzQvBIAg02l8scN//ySNS0tayfFTq5jNew=;
        b=YeJfHbDYuGuxaE4rm8dmQEyMsqa8BTSc6cHP0lYCkUzG9LjpU4oMwWFbXokbuol0Xg
         N1cpCLITvvctt193A5u0aqd9EhXudnuCK9Z/9dDQeO+DgBdSoZx4xhaVjF9CEk6A7vRL
         of9yPabbpzeEAfsjHpVvMNKDkHzMezVCRdkcKvFm/vIGeHtYMR4npyT3bWg0R5/WckAd
         GE3bRh8cMmDPiF3paVMqL0A1RwTzkJNpeM8C7Y6bC1qlKJuQcnBzyESwX5E+SMb/NHfc
         LRyt6XjbSBysHc7rOrHZCUV4Hpu0mZgTfnQ/r/8Ms7Paz2D1hjU8wT6xhL/mwT7o9W7n
         KJMw==
X-Forwarded-Encrypted: i=1; AJvYcCWo+2SlCbLQCzDZTmVbRrvu3EGXeeIpffOTLVo3b2IiwTXlKRydOO3tjZ1MEHMuU49gmWED2l4y5F84PiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqYEm/lkLPKedzGdPxJYVG6CG0G08oqG+EO3aJ9Orhm+sqbTrl
	Razmy3Ymm7dUQO9sZoxkZJLV7AkFRx8WC9WNCFfERt2h2PiF4jM14cagHKn7
X-Google-Smtp-Source: AGHT+IGwITUyiDFj3xF7vXmOkGMGCuCz0G/dKF4uZPY+Usw/k2jejJ+a0bGwCqs/HVblhErNRDu9uA==
X-Received: by 2002:a05:690c:ec1:b0:646:25c7:178e with SMTP id 00721157ae682-6d40d88bc97mr247109957b3.5.1725525775419;
        Thu, 05 Sep 2024 01:42:55 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d6611acadesm17910057b3.99.2024.09.05.01.42.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 01:42:55 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6c3f1939d12so4082137b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 01:42:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWPD7g3XpHkw83VTatOgw1iL/43EEvroKwm1nZ8HI8u/duwGp2vRqQ17+H/jqWTi/0JOwHm5CE6PO2RvSI=@vger.kernel.org
X-Received: by 2002:a05:690c:3386:b0:6ad:91df:8fad with SMTP id
 00721157ae682-6d40e689319mr248185507b3.26.1725525774394; Thu, 05 Sep 2024
 01:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
 <20240904-devel-anna-maria-b4-timers-flseep-v1-3-e98760256370@linutronix.de>
In-Reply-To: <20240904-devel-anna-maria-b4-timers-flseep-v1-3-e98760256370@linutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Sep 2024 10:42:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVZOKCOkrdjbDFRgAxTGdnWKHYN1a8mx=d9Q+gGU+DM9w@mail.gmail.com>
Message-ID: <CAMuHMdVZOKCOkrdjbDFRgAxTGdnWKHYN1a8mx=d9Q+gGU+DM9w@mail.gmail.com>
Subject: Re: [PATCH 03/15] Comments: Fix wrong singular form of jiffies
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, 
	Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 3:09=E2=80=AFPM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
> There are several comments all over the place, which uses a wrong singula=
r
> form of jiffies.
>
> Replace 'jiffie' by 'jiffy'. No functional change.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

>  arch/m68k/q40/q40ints.c                                      |  2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


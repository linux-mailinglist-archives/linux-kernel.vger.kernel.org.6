Return-Path: <linux-kernel+bounces-245792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F31C92B956
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A7F287485
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38C7158D72;
	Tue,  9 Jul 2024 12:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qnFfZAXd"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B042B14EC7E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720527794; cv=none; b=V8OZylO7Y8DnMlxkN33JW3oZoBVgv/kDVqxNqwOMJekHqmeCx01GFoLr1FZJjqxQ3cBbZ/wVCMitB0qOpvB7vn7/cvTPZMO7L0dFRK5265I/o05EnnDzz/Nm8NkkgSrcRUMm36MDobD0myOf53WybT9N3inMfHni6QaQIZKwqmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720527794; c=relaxed/simple;
	bh=3hx7EtNft1u++RNUMER3G1fS/fYucdBVhfI01ALgg6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+ru/IM2B/AJOVILKiEBqZrbjy4jZLWJpvFolvAtGxUjE4cBXV8tgh43sJgDj2JgqCSIYZsWw6w426qYqL3qMgJMmrrJv9W8/Z27Mq+eNjM9iWHlu862T6QP76h04Rki4pz4i0J6aiRLpmRkR6fmV0TcvmsADLPMiPKWPZXPEFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qnFfZAXd; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-58f9874aeb4so5450901a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 05:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720527791; x=1721132591; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xo8UYbec6E2ZLXNuTkqkHT1FutOwjchp6ATsVfTvLfA=;
        b=qnFfZAXddBobUkmWZ/l9lewfdswrAqLndLpZm9HkBZYHarPZcfOgGOG9cGGzqrefU0
         e7eWFO53cr+ehJNinVsqv8rKInBHMhd5kCfe48Z7lH8h+MJoBrLBJnbCcg8z5tNiZtT1
         lb55Kw6cZDF8Ju3WXA707Pm3BVrU9VmGHaFV+ADHFrOaotjDe+pw8LO9xh262laYBM0M
         465+S2MH9EnyFPk9MbUyXrf/yaiSsOcHCwJlYgkrz4bSnxyFCHDec0XD9SoPgu3l9Wfg
         mEQqHvUIyK7C2vokWjVz6x/kOrTYhLTtm0ebytTgrPqyTno61mqzb5KDDoeE6VCXomJU
         pSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720527791; x=1721132591;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xo8UYbec6E2ZLXNuTkqkHT1FutOwjchp6ATsVfTvLfA=;
        b=TuPMJaEaZ6oYv8oGjgFATCKGLp1wYsMl8mrZy2SlDPLyJxXBlZRPfKcFwv5HKc4Vfe
         7SAuNT+S3xpIFM9moEDNKljqHLuF4ldc+d4v7aCgrJeWj+ltcSyTI5YfG2vjCgFlakJC
         KBPL6dTF4uG4XkrXY9hRSpO+ZWJDeIn+MJE3O7UQAJu2KidFig2wnSSl6Cc4hON22M2Z
         avfUkaF5F7QgIW9qzQLniFFBCnKXg5x9G6unr1PenYSJdwkrAggyz69ttBLrIvr95D0T
         7l0GExx7FTxgxvXpzgqgYPqfqKMbhHleTXE2Mpe3PwlgH2841B/WcnZ4oZ6lRpA5izus
         2byg==
X-Forwarded-Encrypted: i=1; AJvYcCWoqMKegJI3C+0sMAOLPbTcYVuvZe1mDNyx0Sj7ThBm5ZJsC9tOOVkVikqugPaUUSUtonGeM3CERhdRR7oSO96twvFGlXKfg9CMt1Cl
X-Gm-Message-State: AOJu0YyllbMDggEvLdf5Q497bsme0S9O06Hmp1rVjpVWYszV5O5Ny9Dr
	HtJXQK91hY95XUOuKLHPzB8bZAYLMOaOhrimrIcVj+ozixZLCdvbc7WuUNlUNJUNndJTe7SwEjy
	a
X-Google-Smtp-Source: AGHT+IG0aIGpCzQySW4SYlwxYSifYCyNlpjHG9RRBhAFaTgQAx4j6VjuDezQ2wW6rVDfCJwHOhPcEQ==
X-Received: by 2002:a05:6402:2747:b0:57c:d237:4fd with SMTP id 4fb4d7f45d1cf-594ba98f7d9mr1901386a12.4.1720527791056;
        Tue, 09 Jul 2024 05:23:11 -0700 (PDT)
Received: from blmsp ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bb9604f7sm1005094a12.15.2024.07.09.05.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 05:23:10 -0700 (PDT)
Date: Tue, 9 Jul 2024 14:23:09 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Tony Lindgren <tony@atomide.com>, Judith Mendez <jm@ti.com>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux@ew.tq-group.com, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Kernel hang caused by commit "can: m_can: Start/Cancel polling
 timer together with interrupts"
Message-ID: <tyq2h55iyfxmebysxbdv352vops7i5fhi3avs6u7h6yinwv75j@m6wicydoobbp>
References: <e72771c75988a2460fa8b557b0e2d32e6894f75d.camel@ew.tq-group.com>
 <c93ab2cc-d8e9-41ba-9f56-51acb331ae38@leemhuis.info>
 <h7lmtmqizoipzlazl36fz37w2f5ow7nbghvya3wu766la5hx6d@3jdesa3ltmuz>
 <08aabeaf-6a81-48a9-9c5b-82a69b071faa@leemhuis.info>
 <734a29a87613b9052fc795d56a30690833e4aba9.camel@ew.tq-group.com>
 <76faeb323353b584b310f2f1b53e9b2745d2f12c.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76faeb323353b584b310f2f1b53e9b2745d2f12c.camel@ew.tq-group.com>

Hi,

On Wed, Jul 03, 2024 at 02:50:04PM GMT, Matthias Schiffer wrote:
> On Tue, 2024-07-02 at 12:03 +0200, Matthias Schiffer wrote:
> > On Tue, 2024-07-02 at 07:37 +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> > > 
> > > 
> > > On 01.07.24 16:34, Markus Schneider-Pargmann wrote:
> > > > On Mon, Jul 01, 2024 at 02:12:55PM GMT, Linux regression tracking (Thorsten Leemhuis) wrote:
> > > > > [CCing the regression list, as it should be in the loop for regressions:
> > > > > https://docs.kernel.org/admin-guide/reporting-regressions.html]
> > > > > 
> > > > > Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> > > > > for once, to make this easily accessible to everyone.
> > > > > 
> > > > > Hmm, looks like there was not even a single reply to below regression
> > > > > report. But also seens Markus hasn't posted anything archived on Lore
> > > > > since about three weeks now, so he might be on vacation.
> > > > > 
> > > > > Marc, do you might have an idea what's wrong with the culprit? Or do we
> > > > > expected Markus to be back in action soon?
> > > > 
> > > > Great, ping here.
> > > 
> > > Thx for replying!
> > > 
> > > > @Matthias: Thanks for debugging and sorry for breaking it. If you have a
> > > > fix for this, let me know. I have a lot of work right now, so I am not
> > > > sure when I will have a proper fix ready. But it is on my todo list.
> > > 
> > > Thx. This made me wonder: is "revert the culprit to resolve this quickly
> > > and reapply it later together with a fix" something that we should
> > > consider if a proper fix takes some time? Or is this not worth it in
> > > this case or extremely hard? Or would it cause a regression on it's own
> > > for users of 6.9?
> > > 
> > > Ciao, Thorsten
> > 
> > Hi,
> > 
> > I think on 6.9 a revert is not easily possible (without reverting several other commits adding new
> > features), but it should be considered for 6.6.
> > 
> > I don't think further regressions are possible by reverting, as on 6.6 the timer is only used for
> > platforms without an m_can IRQ, and on these platforms the current behavior is "the kernel
> > reproducibly deadlocks in atomic context", so there is not much room for making it worse.
> > 
> > Like Markus, I have writing a proper fix for this on my TODO list, but I'm not sure when I can get
> > to it - hopefully next week.
> > 
> > Best regards,
> > Matthias
> 
> A small update from my side:
> 
> I had a short look into the issue today, but I've found that I don't quite grasp the (lack of)
> locking in the m_can driver. The m_can_classdev fields active_interrupts and irqstatus are accessed
> from a number of different contexts:
> 
> - active_interrupts is *mostly* read and written from the ISR/hrtimer callback, but also from
> m_can_start()/m_can_stop() and (in error paths) indirectly from m_can_poll() (NAPI callback). It is
> not clear to me whether start/stop/poll could race with the ISR on a different CPU. Besides being
> used for ndo_open/stop, m_can_start/stop also happen from PM callbacks.
> - irqstatus is written from the ISR (or hrtimer callback) and read from m_can_poll() (NAPI callback)
> 
> Is this correct without explicit sychronization, or should there be some locking or atomic for these
> accesses?

Thanks for pointing these out. I started creating some fixes for some of
the patches. Not done yet, but I am working on it.

Best,
Markus

> 
> Best regards,
> Matthias
> 
> 
> 
> > 
> > 
> > 
> > > 
> > > > > On 18.06.24 18:12, Matthias Schiffer wrote:
> > > > > > Hi Markus,
> > > > > > 
> > > > > > we've found that recent kernels hang on the TI AM62x SoC (where no m_can interrupt is available and
> > > > > > thus the polling timer is used), always a few seconds after the CAN interfaces are set up.
> > > > > > 
> > > > > > I have bisected the issue to commit a163c5761019b ("can: m_can: Start/Cancel polling timer together
> > > > > > with interrupts"). Both master and 6.6 stable (which received a backport of the commit) are
> > > > > > affected. On 6.6 the commit is easy to revert, but on master a lot has happened on top of that
> > > > > > change.
> > > > > > 
> > > > > > As far as I can tell, the reason is that hrtimer_cancel() tries to cancel the timer synchronously,
> > > > > > which will deadlock when called from the hrtimer callback itself (hrtimer_callback -> m_can_isr ->
> > > > > > m_can_disable_all_interrupts -> hrtimer_cancel).
> > > > > > 
> > > > > > I can try to come up with a fix, but I think you are much more familiar with the driver code. Please
> > > > > > let me know if you need any more information.
> > > > > > 
> > > > > > Best regards,
> > > > > > Matthias
> > > > > > 
> > > > > > 
> > > > 
> > > > 
> > 
> 
> -- 
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> https://www.tq-group.com/


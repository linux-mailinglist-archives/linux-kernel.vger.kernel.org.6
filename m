Return-Path: <linux-kernel+bounces-236456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AF091E290
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE1D1C21216
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9793A16A92A;
	Mon,  1 Jul 2024 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0h3UWA4L"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9A2169AC2
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719844463; cv=none; b=aUcdmyHTSpiJivBttEazsaNQU5E4ohN/PlGD9JgrxwGSBs6Z4doGLyg6HpZz1lI3M2PgzUHjdoo16cHtdumZIrbNcsDEBCE1gVewYnM8JnJxg2/x7QbLtcP271GjDrZ7/Jd33f1cDXiQ8KYHJP4+OI4Rgww195jT9vHhHh11S6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719844463; c=relaxed/simple;
	bh=hZLVczWVYkqc2NwpQBQa0JHuez8yTDOyIZgUgtuj9/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsMuQ0msW435mV4b0Q2yTYI/IZ5hVd469V4lnFX4fcsMTwfa48eibpgxItJUdcqBbtq4Tl+0UFathYZxrOPzZTe+PyKWmuMG6+PuLtKbj0Qsa4dQyho0FKPUexm9oDPDWgQHenzCjMmbDl5psJXI2bYF9LcKtYPPVS2X97MBYTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0h3UWA4L; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so11956925e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 07:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719844460; x=1720449260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gxm2/286zsrii1K3SQifylk+j5wAvP1Kfw/1i+juyX0=;
        b=0h3UWA4Lzbf2GRKZFA4ueMIgw4AieAt1eoGbCOiLWGPFKAc9YafLtOCu3hqQXIS7Nh
         BVfWvvwv6gJFzkuVR2q490u2Yua90h645qnA0fXaIu30sq2JWYPjSY4G+NNnTRMl5mLL
         Xl+QiABQvOozNIEwoWd6r8qN24JfLwZOmUY2YLuiO0xZnYH/bHwOHFCbIpE5N458JA+l
         6cGvnnMtI+WGFctbUpOOZjYd2rNfkpQPwXXgHbVgTJDAbFnhi+etcoe9v0hwZp2fUj75
         Ayb3ef0zStw1KtEPsznFxitwskxSh61ti+rjeK7o4JPcfoq/LYaDsaX1vLFTFF2hMGSN
         faFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719844460; x=1720449260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gxm2/286zsrii1K3SQifylk+j5wAvP1Kfw/1i+juyX0=;
        b=H8On1J0U6NO96girt3LaUvpT3qob7CZRt420gnr+ZvBIL7I6NcOTAX/6OcZy0TxdMY
         3/3U05HF2bymCxTTGOVAk2KQ7zKaVwalMdnT3Aau6db1W3Rxm0kDnPrhbB7l1iq73JWq
         tcaz/ZFIhnnWgYSYNa20ea0QbpKizKwfTCMf7OYxll9lJJDzZ2IjIH2iovnr81ygqEgu
         vF5Ddsp4pKXe5xzxyL5jmObK2HVl654yx6RgWELfS+xhcfF2Ibage6YkwmYXndt4bGIa
         yDZ+5RVgHqjL3Dyd/CZnlxZfK5zucmU3mjIniR7dDMN/mYu4GG03NQQKDv7J0iMDYlGR
         F3xw==
X-Forwarded-Encrypted: i=1; AJvYcCU59LIxpti6d5roumgkQV89w5LBUswGehq9xlnGAvi2RhhWgQLx3CbLiJkZXG7rAGDxkG0HDWHXQ3eT3MebQiPQo91hnfUjzUrivpEx
X-Gm-Message-State: AOJu0YxVaDHyPqssvKgkFwG65Lrawe3HzcZ8aPelonOpohN9Vrd0kMcO
	5sAxS+rsgBzcanLvae2pfl640lIFAapM08XA8i1mqObNOljhFpBLudsQ6zxIHzw=
X-Google-Smtp-Source: AGHT+IGVYBgZ9oMxQW7NLdq5XyBXrfpX9j7PfBdVZGzczzJCDXaM89KFp5oFBhxPCvOq5UKcLe0pCw==
X-Received: by 2002:a05:600c:5129:b0:425:63b9:ae2c with SMTP id 5b1f17b1804b1-4257a02008fmr50852905e9.27.1719844460124;
        Mon, 01 Jul 2024 07:34:20 -0700 (PDT)
Received: from blmsp ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b097b82sm159225445e9.34.2024.07.01.07.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 07:34:19 -0700 (PDT)
Date: Mon, 1 Jul 2024 16:34:18 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Tony Lindgren <tony@atomide.com>, Judith Mendez <jm@ti.com>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@ew.tq-group.com
Subject: Re: Kernel hang caused by commit "can: m_can: Start/Cancel polling
 timer together with interrupts"
Message-ID: <h7lmtmqizoipzlazl36fz37w2f5ow7nbghvya3wu766la5hx6d@3jdesa3ltmuz>
References: <e72771c75988a2460fa8b557b0e2d32e6894f75d.camel@ew.tq-group.com>
 <c93ab2cc-d8e9-41ba-9f56-51acb331ae38@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c93ab2cc-d8e9-41ba-9f56-51acb331ae38@leemhuis.info>

On Mon, Jul 01, 2024 at 02:12:55PM GMT, Linux regression tracking (Thorsten Leemhuis) wrote:
> [CCing the regression list, as it should be in the loop for regressions:
> https://docs.kernel.org/admin-guide/reporting-regressions.html]
> 
> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> for once, to make this easily accessible to everyone.
> 
> Hmm, looks like there was not even a single reply to below regression
> report. But also seens Markus hasn't posted anything archived on Lore
> since about three weeks now, so he might be on vacation.
> 
> Marc, do you might have an idea what's wrong with the culprit? Or do we
> expected Markus to be back in action soon?

Great, ping here.

@Matthias: Thanks for debugging and sorry for breaking it. If you have a
fix for this, let me know. I have a lot of work right now, so I am not
sure when I will have a proper fix ready. But it is on my todo list.

Best,
Markus

> 
> Ciao, Thorsten
> 
> On 18.06.24 18:12, Matthias Schiffer wrote:
> > Hi Markus,
> > 
> > we've found that recent kernels hang on the TI AM62x SoC (where no m_can interrupt is available and
> > thus the polling timer is used), always a few seconds after the CAN interfaces are set up.
> > 
> > I have bisected the issue to commit a163c5761019b ("can: m_can: Start/Cancel polling timer together
> > with interrupts"). Both master and 6.6 stable (which received a backport of the commit) are
> > affected. On 6.6 the commit is easy to revert, but on master a lot has happened on top of that
> > change.
> > 
> > As far as I can tell, the reason is that hrtimer_cancel() tries to cancel the timer synchronously,
> > which will deadlock when called from the hrtimer callback itself (hrtimer_callback -> m_can_isr ->
> > m_can_disable_all_interrupts -> hrtimer_cancel).
> > 
> > I can try to come up with a fix, but I think you are much more familiar with the driver code. Please
> > let me know if you need any more information.
> > 
> > Best regards,
> > Matthias
> > 
> > 


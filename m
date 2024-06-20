Return-Path: <linux-kernel+bounces-223410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1BB91128B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0F6CB2796E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D541BA863;
	Thu, 20 Jun 2024 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ceUta9yT"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4302D61B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718912886; cv=none; b=pl6h2O5y1EShyWKKazA2NpilXfVqYA7YIYzxe8Bytfd0PuWZazZEtSHzwsq/IS2tboNODFQ4TaYxKoXAZsZplZB4xWuuon/gpdfhKg6Bu1WPzdIAjSe0Iwp2SHSXN64exTaDUE67fDKYBVECkhCFrQMEoN1Xpn+TROFZ0kQ3pNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718912886; c=relaxed/simple;
	bh=awUqwE93wXcTKvo7ol88UKTqegDT1C9qpGNi09weIsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZK5nezGHOM2C5AcXw6LLhpb2Co0KPZuIM+7wznpeIN2Azyq8QNSBT8uReCQS8qZ7smt2CofR1BNsCMe1ruRrSi34CGj+IKVCtgzgb3XoZ01mc6vAzzVQygPOs+fj1Id8n1juJIG/4XRK5k42L4CrF/KwFSvkgrxNByvOe0YwZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ceUta9yT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f6b0a40721so9712175ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 12:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718912884; x=1719517684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z3gaAAA9tFzbTfrmb6ppBykngzDxoq0Px2MEPQ4ymLY=;
        b=ceUta9yTbf9Mqsk+Eiz+3nzwUsvOYtrT5LSwDmxVIVCUj52gRtg0h5AKXV4Za6iUwa
         PbCxrjbyh2PIGBbIwv2MrAvhpvuROkcCatw/yuw96tijQg6VQo8nU9eZmbJNcij81DKN
         aGfgcSl8IRhW/oCfzBHEy0kqdS6uaQXTv3bZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718912884; x=1719517684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3gaAAA9tFzbTfrmb6ppBykngzDxoq0Px2MEPQ4ymLY=;
        b=qyaoriCi4ypEtR/ErbjhAwa75Xa9vyr8b1Zp9TI2rU+dJletWxf9DR3Z0iZX9SSuJw
         tkEADFKaDfqCH+WMb2a+xvqroCvS9qCjWIVS/nrjs7CWSOfOFiv42TKKa0U43dhYFqpa
         jBJVs6rCC3RyBMSgFUrF/Lmq2s7gz3fby7QjfHds3UwZau9zb/4AE61pLpCycjB6eY8T
         +CpFgGsutdLlm+H0K5422VrJZfVQD243cqYXTqLfNubzOfdrxoDlYzG++pj4ZwB5TaBb
         uDjOEPvO4Ya3CbxTNmQRmhk/frYjxVfrTRr7qrzakHp492m+RzIpsmAeaT21ZJ1+BwZw
         t0Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUhi0i0K5C3BxofUpqkMaPf1zDMlvdC5XQ8UzdFJU7LnkhCCzZGYJxAZYfEUhNbVYlJpV4DTK8h2nErO4zwsTJyAaxA4g+R1kaep7ur
X-Gm-Message-State: AOJu0YzUoL3Mk0A6H0QhBYblDSRjwnZjiBe8nT2uLIPtv/BPqysUMR/Y
	dFk7otB5GJ6NOI6g/h4I3z/LB9JVlYrr5H3rfk+fmZ9EfxrWY1wqGxiiEwIWsg==
X-Google-Smtp-Source: AGHT+IEwL8sWyeO+AO4RDSEBECQdktpgu8GHQ417gFO1L6pv/TF+6VFPQWQRBNh6mAnIj3O6xdidjg==
X-Received: by 2002:a17:902:ee86:b0:1f7:2051:c816 with SMTP id d9443c01a7336-1f9aa40521dmr60222285ad.35.1718912883581;
        Thu, 20 Jun 2024 12:48:03 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:3c9c:a224:3ec6:17d2])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1f9eb323636sm10805ad.102.2024.06.20.12.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 12:48:03 -0700 (PDT)
Date: Thu, 20 Jun 2024 12:48:01 -0700
From: Brian Norris <briannorris@chromium.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>,
	Francesco Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH] [RFC] mwifiex: Fix NULL pointer deref
Message-ID: <ZnSHcZttq79cJS3l@google.com>
References: <20240619070824.537856-1-s.hauer@pengutronix.de>
 <87wmmll5mf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmmll5mf.fsf@kernel.org>

Hi Sascha,

On Wed, Jun 19, 2024 at 11:05:28AM +0300, Kalle Valo wrote:
> Sascha Hauer <s.hauer@pengutronix.de> writes:
> 
> > When an Access Point is repeatedly started it happens that the
> > interrupts handler is called with priv->wdev.wiphy being NULL, but
> > dereferenced in mwifiex_parse_single_response_buf() resulting in:
> >
> > | Unable to handle kernel NULL pointer dereference at virtual address 0000000000000140
...
> > | pc : mwifiex_get_cfp+0xd8/0x15c [mwifiex]
> > | lr : mwifiex_get_cfp+0x34/0x15c [mwifiex]
> > | sp : ffff8000818b3a70
> > | x29: ffff8000818b3a70 x28: ffff000006bfd8a5 x27: 0000000000000004
> > | x26: 000000000000002c x25: 0000000000001511 x24: 0000000002e86bc9
> > | x23: ffff000006bfd996 x22: 0000000000000004 x21: ffff000007bec000
> > | x20: 000000000000002c x19: 0000000000000000 x18: 0000000000000000
> > | x17: 000000040044ffff x16: 00500072b5503510 x15: ccc283740681e517
> > | x14: 0201000101006d15 x13: 0000000002e8ff43 x12: 002c01000000ffb1
> > | x11: 0100000000000000 x10: 02e8ff43002c0100 x9 : 0000ffb100100157
> > | x8 : ffff000003d20000 x7 : 00000000000002f1 x6 : 00000000ffffe124
> > | x5 : 0000000000000001 x4 : 0000000000000003 x3 : 0000000000000000
> > | x2 : 0000000000000000 x1 : 0001000000011001 x0 : 0000000000000000
> > | Call trace:
> > |  mwifiex_get_cfp+0xd8/0x15c [mwifiex]
> > |  mwifiex_parse_single_response_buf+0x1d0/0x504 [mwifiex]
> > |  mwifiex_handle_event_ext_scan_report+0x19c/0x2f8 [mwifiex]
> > |  mwifiex_process_sta_event+0x298/0xf0c [mwifiex]
> > |  mwifiex_process_event+0x110/0x238 [mwifiex]
> > |  mwifiex_main_process+0x428/0xa44 [mwifiex]
> > |  mwifiex_sdio_interrupt+0x64/0x12c [mwifiex_sdio]
> > |  process_sdio_pending_irqs+0x64/0x1b8
> > |  sdio_irq_work+0x4c/0x7c
> > |  process_one_work+0x148/0x2a0
> > |  worker_thread+0x2fc/0x40c
> > |  kthread+0x110/0x114
> > |  ret_from_fork+0x10/0x20
> > | Code: a94153f3 a8c37bfd d50323bf d65f03c0 (f940a000)
> > | ---[ end trace 0000000000000000 ]---
> >
> > Fix this by adding a NULL check before dereferencing this pointer.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> >
> > ---
> >
> > This is the most obvious fix for this problem, but I am not sure if we
> > might want to catch priv->wdev.wiphy being NULL earlier in the call
> > chain.
> 
> I haven't looked at the call but the symptoms sound like that either we
> are enabling the interrupts too early or there's some kind of locking
> problem so that an other cpu doesn't see the change.

I agree with Kalle that there's a different underlying bug involved, and
(my conclusion:) we shouldn't whack-a-mole the NULL pointer without
addressing the underlying problem.

Looking a bit closer (and without much other context to go on): I believe 
that one potential underlying problem is the complete lack of locking
between cfg80211 entry points (such as mwifiex_add_virtual_intf() or
mwifiex_cfg80211_change_virtual_intf()) and most stuff in the main loop
(mwifiex_main_process()). The former call sites only hold the wiphy
lock, and the latter tends to ... mostly not hold any locks, but rely on
sequentialization with itself, and using its |main_proc_lock| for setup
and teardown. It's all really bad and ready to fall down like a house of
cards at any moment. Unfortunately, no one has spent time on
rearchitecting this driver.

So it's possible that mwifiex_process_event() (mwifiex_get_priv_by_id()
/ mwifiex_get_priv()) is getting a hold of a not-fully-initialized
'priv' structure.

BTW, in case I can reproduce and poke at your scenario, what exactly
is your test case? Are you just starting / killing / restarting hostapd
in a loop? Are you running a full network manager stack that's doing
something more complex (e.g., initiating scans)? Can you reproduce with
some more targeted set of `iw` commands? (`iw phy ... interface add ...;
iw dev ... del`) Is there anything else interesting in the dmesg logs?
(Some of the worst behaviors in this driver come when we see command
timeouts and mwifiex_reinit_sw(), for example.)

Or barring that, can you get some kind of trace of the nl80211 command
sequence, so it's clearer which command(s) are involved leading up to
the problem?

Brian


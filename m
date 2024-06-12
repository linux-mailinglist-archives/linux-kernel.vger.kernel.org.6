Return-Path: <linux-kernel+bounces-211420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6DC90516A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0962852BC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705FF16F0C3;
	Wed, 12 Jun 2024 11:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VCfcgUK6"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A5B15624C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718192036; cv=none; b=n+I9nRUGnXWWmfLVNrOOLQwcrwicQxE+atpLWrzm9U5vcVjY1VrsbqgHXHzcZRcjRif33U4nlc8UW3SqeoEfpbz3w0TFuGCtjF4CTL9iNR5a0ryzr1u7Bx5V2TcshkOgM9DYZEbemsoyMyfu7R4aOwsD5wDqbmeuoXqeewEow9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718192036; c=relaxed/simple;
	bh=CX44+b8L24MHiHfL9CxkYVC4l7UpGGIqG0JLNlbzjrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmxLpMaE/5ydm15jARUncbTpFvsv7QRZghBXhO/8YFZjPhOV/v6oEZDWtWUEyNYuqFKdsdK1rnq+cLbPCVDVKTy7/guZ+f6ZK1Ww1dwSTC79ntIHu70Mh50/FVSWPQhMqSnjKh651BYPxTbQk8NRdg/mXrwPpxmblUni3V8coBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VCfcgUK6; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57a30dbdb7fso9856373a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718192033; x=1718796833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=geuwTXbdK96ayf8sfHqB17aSNEJSUP0oKVpasPCucNc=;
        b=VCfcgUK64iz94Jpeedtui4jEXT6ul7U52LCAEEYtP8fg2D8YZSsfLvch9ajxVXL4vt
         e60DRhnEWKQVGlcN1Zae9Oppcbfp2uuoDnmF379SgG+bN34I/00NWN/bIlMMQgdO+QJg
         /rg/KYVbnPeQS/rnA03V9IINO05SBt7LQjVV7eziuN/UxPRD0NlzTc3yCo1DLVymF60r
         a+bidRIRTMCsyb6xS7rtjUd9xJmhc3+wVC2N7FvknfVBDcv1RnK8oSpWGOp08HkF3jHh
         jpejsbEWv25DuMP5VHXVTOuHmxUojnzSegbZeraeUTHOYsGXSDuBKml9VNGAwCDSYVjq
         p31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718192033; x=1718796833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geuwTXbdK96ayf8sfHqB17aSNEJSUP0oKVpasPCucNc=;
        b=q3ga3Disn1SVU7ZRJWO6jkzbxmNNc4huFXFqbt6izH2wrXmrATZUvm2K4ctmxTrCUJ
         ozkSLjWb+VaXgII06EVWygiMGZORNU9u1utpczvt8v2J3fVVTwxwTCgowXdsx9Iqr9Vw
         QgShirfi9/6VyICtzEnyq7QWkyfVjlnlCI9VEySvhEL5BS2Z4kh1fAvJaQfcxf9Z3r9B
         K3jRVTc+610CwJUPMHohM4OyablyRFF6eWq6h7RO3wLy7T2lDrC3WRnHDfiq/Zh0M9cc
         kYNQ3GWhHs9a1c8mHLQ2+V6UhB55FsTIh3hZZU9Aw2O1BqiycTcjsswRdY1mqAaMu47x
         vXMg==
X-Forwarded-Encrypted: i=1; AJvYcCXyLACKHBe7JhTpeLqvzdlNJPHQOvCna9amCBOk9AEPI192dxsKgK3FlNsCb9SYeTaodyk4mKCS7C0ebvGLZwtab9NLCA8Kf4Qe2DnW
X-Gm-Message-State: AOJu0YyF6mXk5sJu/nEN7yNQ3uHkEJcpo3hFY6LiGBautGlUsv/zYb/D
	RTQzaZz1V2cK0M7fhxP/Y3hQuVPiqf2uArR/RwBzXEKOtOypXJRJ3Mro/axirbE=
X-Google-Smtp-Source: AGHT+IGBe3SNZBZzr+84EdhPDap98cpPhcTEjHXNemhHtjivFbFNC8HBkklqN85qxdl4HKlpd7LvTQ==
X-Received: by 2002:a50:9b09:0:b0:57a:2e93:fe80 with SMTP id 4fb4d7f45d1cf-57ca9751c25mr1186154a12.18.1718192032659;
        Wed, 12 Jun 2024 04:33:52 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c76740d6asm6346843a12.7.2024.06.12.04.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 04:33:51 -0700 (PDT)
Date: Wed, 12 Jun 2024 13:33:50 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 04/18] printk: nbcon: Introduce printing
 kthreads
Message-ID: <ZmmHnvYf74LCQQ77@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-5-john.ogness@linutronix.de>
 <ZmMIOWEAMgXz4j-U@pathway.suse.cz>
 <87ed95j8yh.fsf@jogness.linutronix.de>
 <ZmhkVAC_3FMohrEr@pathway.suse.cz>
 <87sexipmrk.fsf@jogness.linutronix.de>
 <ZmlpPucSy8Topb5h@pathway.suse.cz>
 <87plsmpfy7.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plsmpfy7.fsf@jogness.linutronix.de>

On Wed 2024-06-12 13:24:24, John Ogness wrote:
> On 2024-06-12, Petr Mladek <pmladek@suse.com> wrote:
> >> > After all, I would add two comments, like these:
> >> >
> >> > <proposal-2>
> >> > 	/*
> >> > 	 * Any access to the console device is serialized either by
> >> > 	 * device_lock() or console context or both.
> >> > 	 */
> >> > 	kt = kthread_run(nbcon_kthread_func, con, "pr/%s%d", con->name,
> >> > con->index);
> >> > [...]
> >> >
> >> > 	/*
> >> > 	 * Some users check con->kthread to decide whether to flush
> >> > 	 * the messages directly using con->write_atomic(). But they
> >> > 	 * do so only when the console is already in @console_list.
> >> > 	 */
> >> 
> >> I do not understand how @console_list is related to racing between
> >> non-thread and thread. kthreads are not only created during
> >> registration. For example, they can be created much later when the last
> >> boot console unregisters.
> >
> > I had in mind two particular code paths:
> >
> >   1. The check of con->kthread in nbcon_device_release() before
> >      calling __nbcon_atomic_flush_pending_con().
> >
> >      But it is called only when __uart_port_using_nbcon() returns true.
> >      And it would fail when nbcon_kthread_create() is called because
> >
> > 		checks hlist_unhashed_lockless(&up->cons->node)
> >
> >      would fail. Which checks of the console is in @console_list
> >
> >
> >   2. The following check in console_flush_all()
> >
> > 			if ((flags & CON_NBCON) && con->kthread)
> > 				continue;
> >
> >      The result affects whether the legacy flush would call
> >      nbcon_legacy_emit_next_record().
> >
> >      But this is called only for_each_console_srcu(con)
> >      => it could not race with nbcon_kthread_create()
> > 	because this console is not in @console_list at this moment.
> >
> > By other words, I was curious whether some other code paths might
> > call con->write_atomic() while the kthread is already running.
> >
> > It is not that important because it would be safe anyway.
> > I was checking this before I realized that it would be safe.
> 
> Yes, it must be safe because it can happen at any time. For example,
> when flushing after an emergency section.
> 
> > Anyway, the information about that the console is not in @console_list
> > when we set con->kthread still looks useful.
> 
> Except that it is not always true. If boot consoles are registered, the
> kthread is created later, after the console _is_ in
> @console_list. Setting con->kthread really has nothing to do with
> @console_list.

Right. I have missed this.

> > At minimum, the check would be racy if the console was on the list.
> 
> The con->kthread check _is_ racey, but it doesn't matter. Perhaps you
> just want to make it clear that it is racey but it does not matter.
> 
> How about:
> 
> 	/*
> 	 * Some users check con->kthread to decide whether to flush
> 	 * the messages directly using con->write_atomic(). Although
> 	 * racey, such a check for that purpose is safe because both
> 	 * threaded and atomic printing are serialized by the
> 	 * console context.
> 	 */
> 	con->kthread = kt;

Yes, it sounds good.

Best Regards,
Petr


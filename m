Return-Path: <linux-kernel+bounces-346215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB18098C13A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9E21C23E36
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3001F1CB311;
	Tue,  1 Oct 2024 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cD5FYTVU"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ABE1C9DF0
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727795343; cv=none; b=bsT73ukZiQGISRFC2XB+piuMpf0WVh/dHHZITEQrsvc+xsT+anfFp44NOgNfRD6lDKdCF0E0wI6el2sRXRMVZIxRtcaEfGuGlVsdohqrW37Xx/Z/7pFckuB2uLUWNzISjsUZk2ll0s5qZKwm5tUdgRi+91mFZJ7+Xlb6nsW4Xdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727795343; c=relaxed/simple;
	bh=r41+RSC2b/s2Q76C0l+aBdmnjXI6n7tpOqBJqSvLnvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsWzRYLw5UBptcmpM0RiHay/He+PiSoO3plTHw5k7u/eL7PelC9UNkV17bK8sD+moFiRP/reT0fZgWtmxywkKDhLqaxhooZ+8V5X8HU9YfkH0TYwRzr3Wf3j3i+9qeIOhxhlI+qEToCEEJ4pybf/IUpTq+2Vt3SzjowHH/WEVKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cD5FYTVU; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so939420366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 08:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727795340; x=1728400140; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F7vJcQzD2QZVcCsZpya9Onxu5l9Trawlq3ogjwgBFrY=;
        b=cD5FYTVUzqXm/rSuecH5gDkZxw9mrWoTV84t0gonGBad/8dGFhxbr2VdpzChL/o2Yo
         BYXdGGMQtxW1uj0zbYfRHJRj7mFBUCwZbfC+kuvYoQo4/WvETNSvR4tmpVtVYwqldAoQ
         us9+MrqW5FqZKAcdfmma/UTzogKthJpxKpiea95EwRM0I+DmfwnN1b8pOTlA/3tDkWgT
         N/JZ5ZEloZxBtyeSYiOlZ75x2c5+0cFMmEY8zRWVdt7gkZsp0GP9/YLfkutX6BU+g1i6
         zmu3oW8PAaUyHImu6HSLKBYCgnUJsLZRz3eM33wplhxZ1PzqlG/K9KKtLsR2EWLka3/V
         TAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727795340; x=1728400140;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F7vJcQzD2QZVcCsZpya9Onxu5l9Trawlq3ogjwgBFrY=;
        b=wZYZQOBs9nRlMrCT35joSPNEdL7Z/HQyPbXCYlufw5yBzV0aIigsiYsl8MH7XY1VxR
         aBWhl91byMz+M/XXljG2M9eMsWwmOSHDYwSPLDg3DEuu/tzmZ6UuU+VZTeyYY7UFm9Vw
         vEUlleFd3f9JNuUoPRPynoDQ6+obi/myRMI/oBebSu42W6sIoz/ZfCYxYYMmkdPA/3gj
         5MPJZYRZ1P3ijkuvXwjWl69ieskBPble/F+cPXtQdXOQy/z8/VKPqpcJSeD970IfHDaZ
         HTzq9nhXMc3l5hWdIGA//dsHQclQvZOOmpkSAaWHInQ9Hesn64ZzlCwKFF+QLHWelBOv
         Dyyw==
X-Gm-Message-State: AOJu0YyeeCNBaKp7bVt9FjGIsrZbjhgoLOVDuAK1HYbe/pkIglp8MFMg
	wqF1BnGckx+QcKu9cumv2vpGg7NB1Om0s4WapeVqoIeq+4hVpeZxuumcz8e5/xk=
X-Google-Smtp-Source: AGHT+IGDXawUCujw6ICz+oorj2NwgKLW0vh1LrbHP2/vCFOY254dtV7s0+eTrn9bffvXfraVXHKBHw==
X-Received: by 2002:a17:907:9346:b0:a8a:9054:8394 with SMTP id a640c23a62f3a-a93c47d88e8mr1906112466b.0.1727795339756;
        Tue, 01 Oct 2024 08:08:59 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2998634sm718108066b.206.2024.10.01.08.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 08:08:59 -0700 (PDT)
Date: Tue, 1 Oct 2024 17:08:57 +0200
From: Petr Mladek <pmladek@suse.com>
To: Raul Rangel <rrangel@chromium.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Yuntao Wang <ytcoode@gmail.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] init: Don't proxy `console=` to earlycon
Message-ID: <ZvwQiSNEwD6XB0yA@pathway.suse.cz>
References: <20240911123507.v2.1.Id08823b2f848237ae90ce5c5fa7e027e97c33ad3@changeid>
 <ZuwfvyiOMAzciZX2@pathway.suse.cz>
 <CAHQZ30CVM3toTJCki_ao_+_2VkOxmB+a=BU73HF+4WCM0qRbwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHQZ30CVM3toTJCki_ao_+_2VkOxmB+a=BU73HF+4WCM0qRbwA@mail.gmail.com>

On Tue 2024-09-24 10:05:08, Raul Rangel wrote:
> On Thu, Sep 19, 2024 at 6:57 AM Petr Mladek <pmladek@suse.com> wrote:
> 
> > On Wed 2024-09-11 12:35:14, Raul E Rangel wrote:
> > > Today we are proxying the `console=` command line args to the
> > > `param_setup_earlycon()` handler. This is done because the following are
> > > equivalent:
> > >
> > >     console=uart[8250],mmio,<addr>[,options]
> > >     earlycon=uart[8250],mmio,<addr>[,options]
> > >
> > > Both invocations enable an early `bootconsole`. `console=uartXXXX` is
> > > just an alias for `earlycon=uartXXXX`.
> > >
> > > In addition, when `earlycon=` (empty value) or just `earlycon`
> > > (no value) is specified on the command line, we enable the earlycon
> > > `bootconsole` specified by the SPCR table or the DT.
> > >
> > > The problem arises when `console=` (empty value) is specified on the
> > > command line. It's intention is to disable the `console`, but what
> > > happens instead is that the SPRC/DT console gets enabled.
> > >
> > > This happens because we are proxying the `console=` (empty value)
> > > parameter to the `earlycon` handler. The `earlycon` handler then sees
> > > that the parameter value is empty, so it enables the SPCR/DT
> > > `bootconsole`.
> > >
> > > This change makes it so that the `console` or `console=` parameters no
> > > longer enable the SPCR/DT `bootconsole`. I also cleans up the hack in
> > > `main.c` that would forward the `console` parameter to the `earlycon`
> > > handler.
> > >
> > > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> >
> > It like this approach. It works well:
> >
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > Tested-by: Petr Mladek <pmladek@suse.com>
> >
> 
> Thanks for reviewing and testing! I know it takes a significant amount of
> time, so thank you.
> 
> >
> > I could take it via the printk tree for 6.13. From my POV, it is too
> > late for 6.12. I am sorry I have been busy with the printk rework :-(
> >
> 
> 6.13 is fine. As long as it lands upstream I can cherry pick the patch into
> our forks without any pushback.

JFYI, the patch has been committed into printk/linux.git,
branch for-6.13.

Best Regards,
Petr


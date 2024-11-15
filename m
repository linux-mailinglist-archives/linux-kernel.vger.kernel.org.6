Return-Path: <linux-kernel+bounces-410585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50B99CDD8F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE74280E11
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5E71B6D15;
	Fri, 15 Nov 2024 11:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TR7VEAnE"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799BE19F49E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 11:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731670604; cv=none; b=UYWD+YicQYLwZq+O3gclIORn/WkcnUl5yovJoCh2rQhpjA3+hDLLtqPyBdlVv6iCDWIeKMLZ+83R6Gaek9DJcpXUGGJpWHlCmgQcrWyzLt4BEwc9CdoaQkz3CKvdWNsZ8/EndtK0V95jkZqr2s/4o6h1+vTqXxowWfVceOkEc4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731670604; c=relaxed/simple;
	bh=crWLODjQpBqZ+m0y2RkNiyT7JqSJuT+LTuTTfY3kFqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbtU+OMX9qAD9JasPr+dnl5efEcyk//ju7Fk0D9MZzvVgmsWmPuTTcTv4rtfaAAkdIMj54OZy7jr0aq9lqs5i/Lb6tMM1Zwmsx3pc2u76nuZZZQcPthVJoLcPKcZqQ+RPzXk+li1bJs1RKZXres15BX/+WBjzwzO63UqeA6+gTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TR7VEAnE; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so14660085e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 03:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731670601; x=1732275401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WSGRTDmiyj5r7QBcQAG3/CwgNIVXzFyhUa3EYkSmiZw=;
        b=TR7VEAnEjnTZaeVSWUXWEwtHM6IfrdS0p4KLc7WfdKl/80Mw5oo0rwUpRBDYZySMmq
         Cd1/4oPnizsjBZnb/dcwnFor66v+0bqaQvPllqf9xN/v4IpYVUICSVVFilNBPL2NrKCy
         JCrDO5EUOUt0HAropgzlHIa0W+SsCw5w7hI2h9a2l2N7/puvfr00E76gQFfdEqRiV3uD
         CFFegvBT4RmDOyxZ6CX+o/0UEOF9muPCMYlsasPwQV17BACnnHMsGNQ1+/vF/5lJJk6R
         Lp/ZLEprmjVz/QcgPl6kbmK/VsIY/73WiSDrmz4HNyq8aN5c0o3sIw+sZEialIWPwHlt
         xCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731670601; x=1732275401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSGRTDmiyj5r7QBcQAG3/CwgNIVXzFyhUa3EYkSmiZw=;
        b=uOkOXDOkC87AH4X8Jkzb8L2bgJS67hO6UM5cJs4yArGKTme/RpoCwCrG0JLYAiNH+k
         Cg8cKWHKZhsfKHbG8gUrMNYS55AnP8kTPT6kw3aPLUJFbRACkqeFyFjiP87ZeblL71ka
         Oj57TrwJL2xqwOQws/VsW7BGYsNN8tsn/xkfHvldHjo1jpEkykZIENKkydtm3mkTuV5f
         bkRUIGC3ygEk0tcpMyxjvFSrKvFL6cqNQYHCJbZ0K1hhW3F+wqsedQ/o7pGZz0ez386W
         vIptDR8ZhJKt1Gk9A7iudjC6zkDSjwFD3dcjPxm3+95x767TcdQyoHKl0odj7/RHea+M
         57tA==
X-Gm-Message-State: AOJu0Yz7k5HBDeD6ehVYaKPVJ+1omBbLYmxM29cHKJx7U4edkK5/4QtF
	627TZN+G0lG2+eAqfYu+bQ8XoPGWKDyX/IFkS9JT5+bTYPcyeets3w3ZuYeHrxs=
X-Google-Smtp-Source: AGHT+IFIsSL9RT5iSe+vLSl41am/5/jhAKU+/p/ZXCUoV9GFNjOawPHjWOdevmpf3bo8t9oWVv9VFQ==
X-Received: by 2002:a05:600c:354c:b0:432:7c30:abe6 with SMTP id 5b1f17b1804b1-432df78c5c8mr16131455e9.21.1731670600745;
        Fri, 15 Nov 2024 03:36:40 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d48c731dsm50881685e9.2.2024.11.15.03.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 03:36:40 -0800 (PST)
Date: Fri, 15 Nov 2024 12:36:37 +0100
From: Petr Mladek <pmladek@suse.com>
To: Chris Down <chris@chrisdown.name>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: syslog warning: was: Re: [PATCH v6 04/11] printk: Support
 toggling per-console loglevel via syslog() and cmdline
Message-ID: <ZzcyRdf8gzx5Zkk9@pathway.suse.cz>
References: <cover.1730133890.git.chris@chrisdown.name>
 <07141a533c4071c364c4f2eda6d97a9a89797e67.1730133890.git.chris@chrisdown.name>
 <ZzYv7SznkX34Wulr@pathway.suse.cz>
 <ZzZHNIL6o0Ep1vfA@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzZHNIL6o0Ep1vfA@chrisdown.name>

On Thu 2024-11-14 13:53:40, Chris Down wrote:
> Petr Mladek writes:
> > I see this warning during every boot because rsyslogd() modifies the
> > global loglevel.
> > 
> > [...]
> > 
> > I am not sure if we have already discussed this in the past.
> > But I would prefer the compromise after all.
> 
> I initially implemented that way until v4, but during the v3 review, as I
> understood it you recommended changing it to use
> !ignore_per_console_loglevel based on the assumption that
> SYSLOG_ACTION_CONSOLE_{ON,OFF} wasn't widely used. Maybe I misunderstood
> what was intended?

The current solution of SYSLOG_ACTION_CONSOLE_{ON,OFF} is fine. I
still hope that it is not used much.

My concern is with SYSLOG_ACTION_CONSOLE_LEVEL. It seems to be used
by rsyslogd.

But wait! I see the warning only on SLE15-SP3 which I use for
testing. It is a pretty old system. I see that rsyslogd is not
longer used on never systems. I guess that it has been obsoleted
by systemd journal.

> Happy to revert to the previous approach with warn_on_local_loglevel(), just
> let me know :-)

No, I take it back ;-) Let's keep it simple as it is done in this patch [v6].
We could always add more conditions around the warning when people
complains.

Best Regards,
Petr


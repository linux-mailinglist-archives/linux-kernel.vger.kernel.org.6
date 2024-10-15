Return-Path: <linux-kernel+bounces-365964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D6099EEAA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9CAB1F250F1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2257B1B21A3;
	Tue, 15 Oct 2024 14:04:56 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1B31FC7C2;
	Tue, 15 Oct 2024 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001095; cv=none; b=ApVqxfp/nOc7I7viOf1/PfCGTQ4DhqFez7dq/gn91ZlGdb40Mp5bEMmscuoGyJvvViF2MFQG+xOFiVpOvIgV9v7P1kc+jK9sWUWH3ipUPsE/GiSvjL1Z0WlWGjvomZJuTOHR7iiiFIWf6xPKkbCRWI6G8nFhsiJ64NUzHlAXmfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001095; c=relaxed/simple;
	bh=WvuxKAE+SlWRB5IfVx0UDTjPV9gmUsnR31vBYZGm6tg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ooeg7ANDwXz9nYOSulHmEnlOLfujVct23OSf4LNx8LJDr3hbQYR5A9PV63+kWzAYTVOtg3FE0XzPJSeezqncxzuRNk/VZ7MI5nP+tPv5cjxJFfy0rZneSIqslgvJZxyY3LFXqEIf0glOO4Ltam+ODbhh2fvUJ8FrAk4PNoD7sws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29ED1C4CEC6;
	Tue, 15 Oct 2024 14:04:54 +0000 (UTC)
Date: Tue, 15 Oct 2024 10:05:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot+list3bf21e6ac0139f8d008d@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mhiramat@kernel.org, syzkaller-bugs@googlegroups.com, Jens Axboe
 <axboe@kernel.dk>, linux-block@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [syzbot] Monthly trace report (Oct 2024)
Message-ID: <20241015100512.54e5e840@gandalf.local.home>
In-Reply-To: <CANp29Y4KERQxwOwMCW5a4+YahhA8gWyJ=btE=OxnNgrF6puFgw@mail.gmail.com>
References: <67094369.050a0220.4cbc0.000d.GAE@google.com>
	<20241011120028.1e4ed71c@gandalf.local.home>
	<CANp29Y4KERQxwOwMCW5a4+YahhA8gWyJ=btE=OxnNgrF6puFgw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 12:05:29 +0200
Aleksandr Nogikh <nogikh@google.com> wrote:

> > None of these look like they are tracing infrastructure related.  
> 
> Like get_maintainer.pl, syzbot relies on the MAINTAINERS file to
> attribute bugs to the individual kernel subsystems. If several ones
> are suitable, the bug is assigned several labels at once. It's now
> actually the case for all open "trace" findings:
> 
> https://syzkaller.appspot.com/upstream/s/trace
> 
> (FWIW it's also possible to manually overwrite these labels and remove
> specific bugs from the monthly reports).
> 
> I could make syzbot set "trace" only if there's no other good
> candidate, but I wonder if that could hide the findings in the trace
> infrastructure that manifested themselves in some specific traced
> subsystem.
> 

I don't mind being Cc'd to these bugs. What I do mind is that only the
tracing maintainers are Cc'd. I still care about these, because they do
depend on the tracing code, and it could be the tracing infrastructure's
fault. But if an error is in a file that is explicitly called out in the
maintainers file, such as, blktrace.c and bpf_trace.c, then PLEASE also Cc
the maintainers of those files!

I had to manually add those maintainers when I replied to the initial
email. That is something I shouldn't need to do.

-- Steve


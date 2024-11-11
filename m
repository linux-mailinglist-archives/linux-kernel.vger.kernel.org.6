Return-Path: <linux-kernel+bounces-404757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFEB9C47BE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D4228B88E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD8C1BC085;
	Mon, 11 Nov 2024 21:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="P42VEiY3"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A63C1BC07B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 21:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358910; cv=none; b=bw3bnGXVBlNTmAbPjRSyt7T/2KAvyXI/NtqOEngp0bHaLo4at/P7tTMLZJQmcHd+hD2ayFjfYzNd4Iimh81x+1du0Tb0Tjixx3fEUcSW/2WMlcITY6cNM5JVkr2to1eJMiZ5Mm6OqKPcoMJTWodF5j79CEk9oVch7qwbfyoRGWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358910; c=relaxed/simple;
	bh=NsMJ6sflvPpN5Om1zPyJEDYX3eOfkFpvEC4GUB5w07I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIVLM+MhQrT9TGDiEWhRpBPe5xMdEqBlPtHjvWGiddV5aHdR1hhlOXI7U9YbHePFKwZ24lu27c3/XbF6cEn7b86+i6iAPVhcxPZoKxazPDjcu0mDXrv1wLOJWmPeKMQURlu8R5wC8D1wTKLX+GQyNoNdMb4UuGPv3JjPm3P5k9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=P42VEiY3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cdda5cfb6so49408185ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 13:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1731358908; x=1731963708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NEoBXDwxEuaRMLtjNe/ebt/WXN49k6ZubP/KFubYcXs=;
        b=P42VEiY3r3lIwuuapuyGUmVZ/PDkG4JCXKFoifocfRADPWBSWUFl2N5Xvdo9jQCxU9
         G5Yhc8HUOaTALFtjzkvg0E6qNmQ2PUqmzamvF1f516jkCO++Hg7XB8IzVBVJAWQeCKKt
         gGFypMxJFI3pAdGqI0MEZm90k1gwuu8A+xTpnPPEfB9OPHcoGe4gW8Rm73L7FWkkEGuL
         jcT/iBgPKVxjzHxilRHlX3GRPCZnSLoqReegwJTKaB2w+09ZUE+PhF1kDG6Nt2IiYT8k
         ibmwi60q0rrVPo4pHRzXbCJhm5NDe7EhrEnQDUDrG/V1RmPrBV0sSY3yfXdDz5bVwEaR
         Q4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358908; x=1731963708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEoBXDwxEuaRMLtjNe/ebt/WXN49k6ZubP/KFubYcXs=;
        b=PPb1otCau79SynsnQ1/KMl3PTPT6xtrTWqmeqEH/1ntz/0jmkNcXTKr5Sj7bmssWZa
         Dnah4iWlV8zvy/wIt6KPMx5moz1BTNhySckQqtaTDk2elALQ1a94AdH+3+3CytAXFSBw
         SapcYF20+89x2vWzzfK4EdnDbQVHknnQ9l6/hrXrB5YzZ9nzrPgLLAKMH02SDL4X0yGT
         wSlVJyFel72nFieArLADF8pfek9wi9vx6mtZnVlynqy5/QGiF2kKt0FPqy+LFVvaXxrn
         rLcwfMCljlzmGWS97qD6hS54A8Ts63ZJsBslLD0HLzCA9djmXFkZGowOovJO3kNjO+XB
         a3qA==
X-Forwarded-Encrypted: i=1; AJvYcCWVlQAuK/0LRZz4K4Vz9cb/ojVct5G6N6hKhuwM+46qspcEYywRmF0Z3mTlIeXfrvE1oxJvfcsOudr3XUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzm/jINUvf06rF8FflgCtK7hWlIXdUOx/E41y/btKj1k6YHkc5
	kf1i+WJaKAczsT5AyIPsAvKiNGEgGJ9/9+sqL0E2OTE1cWW/arU7UlAYX8K9CyA=
X-Google-Smtp-Source: AGHT+IG7tW946w3/G7AlvtKGoG4TioAyKsozsSRMpMaW+9Ajdm0/jT0ud0ACSeGosTxtaiT1H0m07g==
X-Received: by 2002:a17:902:e747:b0:20c:5e86:9b53 with SMTP id d9443c01a7336-211834dff33mr198742645ad.3.1731358907875;
        Mon, 11 Nov 2024 13:01:47 -0800 (PST)
Received: from dread.disaster.area (pa49-186-86-168.pa.vic.optusnet.com.au. [49.186.86.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc9f23sm80547065ad.29.2024.11.11.13.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 13:01:47 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1tAbXc-00DLQI-27;
	Tue, 12 Nov 2024 08:01:44 +1100
Date: Tue, 12 Nov 2024 08:01:44 +1100
From: Dave Chinner <david@fromorbit.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	John Garry <john.g.garry@oracle.com>, tj@kernel.org,
	jiangshanlai@gmail.com, mingo@redhat.com, juri.lelli@redhat.com,
	jack@suse.cz, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: workqueue lockup debug
Message-ID: <ZzJwuCvLv5ZEIT0e@dread.disaster.area>
References: <70cb224f-a468-40a0-82c7-735c590bdb43@oracle.com>
 <4e58d34a-ce45-437a-95a2-3ba21f35bbb5@leemhuis.info>
 <Zy1F4n9KoNybBmoD@dread.disaster.area>
 <20241108085419.GA6497@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108085419.GA6497@noisy.programming.kicks-ass.net>

On Fri, Nov 08, 2024 at 09:54:19AM +0100, Peter Zijlstra wrote:
> On Fri, Nov 08, 2024 at 09:57:38AM +1100, Dave Chinner wrote:
> > On Thu, Nov 07, 2024 at 01:39:39PM +0100, Thorsten Leemhuis wrote:
> > > On 24.10.24 17:49, John Garry wrote:
> > > > Hi workqueue and scheduler maintainers,
> > > > 
> > > > As reported in https://lore.kernel.org/linux-fsdevel/df9db1ce-17d9-49f1-
> > > > ab6d-7ed9a4f1f9c0@oracle.com/T/
> > > > #m506b9edb1340cdddd87c6d14d20222ca8d7e8796, I am experiencing a
> > > > workqueue lockup for v6.12-rcX.
> > > 
> > > John, what this resolved in between? This and the other thread[1] look
> > > stalled, but I might be missing something. Asking, because I have this
> > > on my list of tracked regressions and wonder if this is something that
> > > better should be solved one way or another before 6.12.
> > > 
> > > [1]
> > > https://lore.kernel.org/lkml/63d6ceeb-a22f-4dee-bc9d-8687ce4c7355@oracle.com/
> > 
> > I'm still seeing the scheduler bug in -rc6.
> 
> But that WARN you reported earlier isn't there anymore. So what exactly
> are you seeing now?

I just went back and checked the logs. It does appear I was running
an -rc5 base kernel, but that just makes me really confused because
I was running mount path debug trace_printk patches at the time and
that kernel was clearly built on a 6.12-rc6 base.

Yet, apparently, despite getting the tracing output I expected to
see, the kernel still reported as 6.12.0-rc5-dgc+. I suspect some
kind of weird delta rebuild issue (possibly some of my machines have
dropped time sync), but that's my problem to sort out.

IOWs, ignore this, I'll do a full rebuild on -rc7 and test again.
If you don't hear from me again, I haven't hit new problems.

-Dave.
-- 
Dave Chinner
david@fromorbit.com


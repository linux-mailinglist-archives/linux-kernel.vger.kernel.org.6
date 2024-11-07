Return-Path: <linux-kernel+bounces-399895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C196F9C05F9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82083283A3A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E57720F5A1;
	Thu,  7 Nov 2024 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ZDKFiOIy"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493F11DB534
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730983191; cv=none; b=pTHGlGzpCYVZUJmXSpENLLZfAHmENqGvDW9ATtNGptlsyYVYTRJXuMaCGJCGT8redwC/4PRH1peyjwANHu3rSEXS1ko/TXdFDPW44UonGmsjezLnr8tsa+qDXHvyfq3JOVyP5zM7awtxchCFOnxbmVgkhW8ROk/qPChCkkoRXHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730983191; c=relaxed/simple;
	bh=l6ufvF85HwoJWUhmgZ2iuzTo2qL0SCVeIkLSb687duA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CxFB3hTsyVi6jiQIqhEVwaseawcRjVYk52ha2GlFU/3XBwsGpV2hFbQJ0zfR/fRAt7wgluBCX0zuvan8eqc21C+pwVw2jeL01oi5cwH9Gx96cy2avjfRLck/rQyljr3o0aBMwml+lEBIWi3A3LJfMQZKugSfiYZn2wXIvx+xUsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ZDKFiOIy; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=E+fHOiPBBxWdnVVpaSlXJefWhHOYuF9e5zPJ6Yd0KAs=; t=1730983189;
	x=1731415189; b=ZDKFiOIycKUwwCzz2mVC6lI42NW4cUDs0GtctCBlvKWp614sIxIhhhUr9hOUs
	kg/zrW9MJwwnuyvmKnNudoXVoqhIHr/nQGDnlvLB70R1VZ/hI7GrHw1w317CUEbp36gKrH1vt3dtH
	i4rOhBDoz0Mh70+lvpkf3M5hAru5vRWfusYT/354jg+7+kGXO+rNc83TToX7Kq/o+C3gmk5lyxqJJ
	QFFS/ZI+QGBGfXJW+fLRAOS+Q6LGKTf/lNHeaaBY5EAZHk917EbQO4aBNGfauRb47ThpX8VSWLlCk
	pjKV5E8AZlLEEZz+a9hZpAFgw0IV1vtKD/tOM3LY/WZhfy7i9A==;
Received: from [2a02:8108:8980:2478:87e9:6c79:5f84:367d]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1t91nY-00009W-BT; Thu, 07 Nov 2024 13:39:40 +0100
Message-ID: <4e58d34a-ce45-437a-95a2-3ba21f35bbb5@leemhuis.info>
Date: Thu, 7 Nov 2024 13:39:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: workqueue lockup debug
To: John Garry <john.g.garry@oracle.com>, tj@kernel.org,
 jiangshanlai@gmail.com, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com
Cc: jack@suse.cz, david@fromorbit.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <70cb224f-a468-40a0-82c7-735c590bdb43@oracle.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-MW
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <70cb224f-a468-40a0-82c7-735c590bdb43@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1730983189;3181119a;
X-HE-SMSGID: 1t91nY-00009W-BT

On 24.10.24 17:49, John Garry wrote:
> Hi workqueue and scheduler maintainers,
> 
> As reported in https://lore.kernel.org/linux-fsdevel/df9db1ce-17d9-49f1-
> ab6d-7ed9a4f1f9c0@oracle.com/T/
> #m506b9edb1340cdddd87c6d14d20222ca8d7e8796, I am experiencing a
> workqueue lockup for v6.12-rcX.

John, what this resolved in between? This and the other thread[1] look
stalled, but I might be missing something. Asking, because I have this
on my list of tracked regressions and wonder if this is something that
better should be solved one way or another before 6.12.

[1]
https://lore.kernel.org/lkml/63d6ceeb-a22f-4dee-bc9d-8687ce4c7355@oracle.com/

Ciao, Thorsten

> At the point it occurs, the system becomes unresponsive and I cannot
> bring it back to life.
> 
> Enabling /proc/sys/kernel/softlockup_all_cpu_backtrace does not give
> anything extra in the way of debug. All I get is something like this:
> 
> Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221
> at Oct 24 15:34:02 ...
>  kernel:watchdog: BUG: soft lockup - CPU#29 stuck for 22s! [mysqld:14352]
> 
> Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221
> at Oct 24 15:34:02 ...
>  kernel:BUG: workqueue lockup - pool cpus=4 node=0 flags=0x0 nice=0
> stuck for 30s!
> 
> Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221
> at Oct 24 15:34:02 ...
>  kernel:BUG: workqueue lockup - pool cpus=31 node=0 flags=0x0 nice=0
> stuck for 49s!
> ^C
> 
> Can you advise on a robust method to get some debug from this system?
> 
> Maybe this is a scheduler issue, as Dave mentioned in that same thread.
> 
> Thanks,
> John
> 

#regzbot poke


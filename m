Return-Path: <linux-kernel+bounces-400863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA469C1361
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7413D1F235FF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79893B672;
	Fri,  8 Nov 2024 00:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="shyvSabv"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8502D8F54
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 00:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731027580; cv=none; b=IvEhg6IrwrEobnaPItbHZDHM1eXd8UNwy+Ou+iFkNT4v5MbgPqSYf7fjyIo458rEtdvhiX23TYBV5eNsI+HTyg8RsNYPRCgbshtQyN5c564LXhJei5k3hyzb1zHKx08Jwuz1d4PpxGjahFH2XpnBUg+CYgNTJV8Jqruo4+hBnus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731027580; c=relaxed/simple;
	bh=2Z3wd+ZMCDhE1fNOKNlz1k68JKwoJd0TG12r6GQ5CMw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mnOtr03ESD9LQI7Rq1SVoK8salBmDImciD/4ZXsT/VY4cInr7uAyX49xZF6jGG/AbLLJpnctcYbSWUsX4WKodGl60PiDR8LjgdjzCXYCgFbiKosafThXxpzCOAadXr12FzH3oZ7JksSrjYP/I0N0gJbvGLMtkqoroASd+yYU/88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=shyvSabv; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731027545; x=1731632345; i=efault@gmx.de;
	bh=59sI9IkggmHHN5RmxLtDn719RMyw9UmIvqwVtChNITc=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=shyvSabvnXUtTJ9L9s0qtFngaUBPoGkxIp014ezt+c9Zt5vGt7oFxnJVmJGy0RIU
	 eN5rJ0D6Lv5qKrxOMQKhlO0/JnvHxC2VzB7z/pkHDAIPyYDsWbg3WpgnFJ6ovmKC2
	 gk9mIMLLZMo1DRRkAqEJJw8rZHrmT7ff2llOaLZj/TLcOuj/XUNnMpbHtwLV9P/v/
	 eGofssyoZM9DwRv+JkStTJ0/PaSIW9KkpYphCSkw2ABOxN64k0lkARzkolmwh08Gh
	 VMjni5pgh8G8J1XNAWvvVKZ4wZwqryCuZOm3m4RpHpn0D0Oh+IXrs0u+DsjqDxM+I
	 ky2ys8qbXSKFbGs6xA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.195]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhlKs-1tmy092EtM-00ccPo; Fri, 08
 Nov 2024 01:59:05 +0100
Message-ID: <d9eb12bf0c7423368db2ac03ee3171925de15bfc.camel@gmx.de>
Subject: Re: [PATCH 0/5] sched: Lazy preemption muck
From: Mike Galbraith <efault@gmx.de>
To: Thomas Meyer <thomas@m3y3r.de>
Cc: peterz@infradead.org, bigeasy@linutronix.de, tglx@linutronix.de, 
 mingo@kernel.org, linux-kernel@vger.kernel.org, juri.lelli@redhat.com, 
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 ankur.a.arora@oracle.com
Date: Fri, 08 Nov 2024 01:59:03 +0100
In-Reply-To: <87v7wzklib.fsf@DESKTOP-DQBDJ0U.localdomain>
References: <87v7wzklib.fsf@DESKTOP-DQBDJ0U.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4i83uMEKb8IApSKe/7UEBXiWMJ3zggWUPwQEgdBtEBnwA4r5Dfu
 cB9L6cmQxIJDAyaWG59EGgahp8hxenjzvmIPyPMqAll0r2fyr5cnr55USaiO3sOV3ZGj9tb
 PyAhtp1TFwO0kzm+uvLjxe0rHN6mhg2K6TNerrHjhwjKqaFFYjcNVQOjY5IJmRI98/UYE2r
 0VkauNHG0dcUj/CN2MZjA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2qT3LAKmAc0=;0tiGVB/ouUDfWX+cyj8KZ1n51N3
 jblbKWky/yWjjhm9ewvcOqNzghyFA9lMlWBH6GnsZ7Vu+6J5o4IKi35L5tYs4kCUSxhzpfL6o
 m+v02CEDmxyYY9DboVIUlUCUk3EjDZCjepHmGsAryX65MO5dQNDovnPoq89VpFkY0eZuvQJdW
 7+zW3l63HtbmzQQ3qIlX6L3kd7vFtBPmnSnaPV9yNH9ea3mTv/VAJbBrI3opw9QgQn/It971m
 I3ai7zGtIj5Xta6IJYfzERe3KSIqfLF0960kbCKmKKEBpjWZlWPegTJwNby7zVjZuwGfez0Rl
 hjrS8yqtagJ01kUMs3Ql6hEqZbDf+kWxoSBCWqpEb2vt1BeEqFzF54llYP7a/+rb0IHHUirIs
 bbOPiZY3ke3vct+oqbaFl6bSGslpC9r0QbJJfHDqELDh+90YfEC0NE2+/nKD57RB6ToGanToQ
 na5c7TBETMcf/ivluBOnJ51bbcDGv8Jy3/rxAqEwrGnOtnyPTe65TDIQSlroJhrBGVVmgmqj/
 u38aBbXS8/8PkY/9c697XPQyuuBecCbDzdvEPp5Oj+XbEyR7lWIvW015Rv4G8oPBBRzjTAoHp
 lqjV/Ue70Zhwt1hfwG6xJqEA551WeY42lcE7NWVf7PIKPWNY0fbJYLNuKncxaeGQDGIbakCXv
 JShEJGjJKo6RseQbdDtwtHm9zNutcan0ytKSN23zVU3XxQFhWVgX1QZvvTOBkaXoxdw5dLjcD
 V5tFi6zotc4CrUk7zOWfEv+VrlCyZH8ABD3YVWP4V0WXNDDyJeMAgEieCs8KhMUvcpp2wfOf3
 +3UZOWptHT3QH0+vo5+oWHAA==

On Thu, 2024-11-07 at 18:21 +0100, Thomas Meyer wrote:
>
> Mike Galbraith <efault@gmx.de> writes:
> > Full per run summaries attached, high speed scroll version below.
> >
> > desktop util 18.1% static voluntary - virgin source
> > desktop util 18.3% static voluntary - +lazy patches
> > desktop util 17.5% lazy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 - ditto...
> > desktop util 17.0% lazy
> > desktop util 16.8% lazy
> > desktop util 17.8% full
> > desktop util 17.8% full
> > desktop util 17.8% full
>
> Can you please elaborate a bit more were those values, e.g. 18,1%, come =
from?
> How to get those? I couldn't find a connection to your raw data.

I use a slightly twiddled perf to profile, ala perf sched record
<whatever load>, perf sched lat to emit the profile, then do the total
runtime accumulation vs competitor runtime arithmetic. Both competitor
and desktop load are selected for maximal hands off consistency, poke
start, watch yet another 5 minutes of BigBuckBunny to make sure the
internet doesn't hiccup during recording.. and done.

> Sorry for asking this probably stupid question,

Nah, the only silly question is one not pondered first.

	-Mike


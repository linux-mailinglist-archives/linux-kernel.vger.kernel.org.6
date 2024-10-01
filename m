Return-Path: <linux-kernel+bounces-346358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E0D98C3A1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270481C2321F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947871CB526;
	Tue,  1 Oct 2024 16:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="IVYmLfKK"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE5B1CB50B
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727800911; cv=none; b=OEJZhKkHmC4+1BdYtbrVoL4sqvfrM+WupDeCGttllvmfpaX+PAWAOWEgPpi0QxMXu26tjEN9TAWrlRlDZ4tYLyl1kB/dyggBRz0V8L3xD3VjYniANqiMLsc72ulOTSToGdoZD2726gDjwto2JXtJRkzxVVrLi+V4+CkIUAkvp4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727800911; c=relaxed/simple;
	bh=eqIdfM/5GzZZ8dG9Rh6LyOe3nn6hj/9ZozG3ehitKwc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nOLCUt0M0LTFjdQ4sZU2jgjiTiFyPtX3Ua0+HpYQZkicBEz6aviqwKZJhIogN98UrfYtPHC7+UJkSkxqEUSOtc4bQ2q17TwxmXPeLfTbf5513Gh/xpzzpXoGzRnHxkE5N11V3A+lmnNIUjp1yPnoT0ztkwvnQik71067NnfO2Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=IVYmLfKK; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727800887; x=1728405687; i=efault@gmx.de;
	bh=PQB0y9pDvzFa1uwk3tQ17n5aIWodUcrXfv4huXSatMg=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IVYmLfKK5dj5lmCySQjq7CFwJsDUZOk6i7G/zwz27UFeTBdnhzdWThA7XyrFe6se
	 iZIGVqCm3JDVPrzj7XsyHwICXU/uVNVrMZ7csB483ztGdH8++tcKLVEbug5j39zId
	 rjg0SzojR0rBXqH/52COhYPX7T0/24WXcEWAJQnQneOEBI9xHNTqC8p12hV0M8Z1n
	 DewwrKvqUUEl1DO7usp+LCjCN9QmkRGBj6y05HNuG0y5JiIOhkkSQhtaykkprLao3
	 hbQrP/6M9VT7DJ6KzF6j1wHtAG6nas7DqFmfjRvnQXMremJpcFOJP+42OUPVbJYWY
	 Y4VyA21u3YyfRiDk0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.56]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLR1f-1seyAO1Bjv-00MEss; Tue, 01
 Oct 2024 18:41:27 +0200
Message-ID: <09e16088690e6577b60de489e6e52a3e5769f96f.camel@gmx.de>
Subject: Re: sched/fair: Kernel panics in pick_next_entity
From: Mike Galbraith <efault@gmx.de>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
 Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, Dietmar
 Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,  Valentin
 Schneider <vschneid@redhat.com>, luis.machado@arm.com
Date: Tue, 01 Oct 2024 18:41:25 +0200
In-Reply-To: <ZvwCaKkgb2F6pzLP@linux.ibm.com>
References: <ZvVWq3WM6zVza_mD@linux.ibm.com>
	 <20240930144157.GH5594@noisy.programming.kicks-ass.net>
	 <Zvr2bLBEYyu1gtNz@linux.ibm.com> <Zvr4wJ9YJRzWrbEF@linux.ibm.com>
	 <55a2acefffb8c99e4234bd18656a75625447c2d0.camel@gmx.de>
	 <ZvwCaKkgb2F6pzLP@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tl1THx8lYapu0ztgCnzSb7J2K+gIP7xe4Loy7LPzo9U5Euc89lM
 Bdt4HNnB+8nN0at5j20M1C4UVMSw+ZzlWDFKuql60sjhuAAHh8kuggGb3zQEh4HhONNQTTc
 9cjqwchc7DWqwqOb3xAON9La2mUeGny2ZZRGccmD1AxcfQcmm6X02AmXPLhV5iK0R+1HIup
 yXyhQlw6UkES0Q8gM43cA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:x7RwGw3kRko=;xd8K+mFFZLB4QImdYa9pbY9mHaX
 3V28mumL3/edI+Ld0oRPmk7UYDvxipzcJhR8YLKn6PAuRElO4yk3+cqG3WmP9Hli5ygrvvfvQ
 vjxqYPSMaViEtuxp56WxqwtEUg1CTqRpZ8GwePD//XyY3byjrWlo9ZIv49m5l5rvyFunj1dwi
 eefTKW8HpVfxypQqQ7u4TS5TOtjfnCqj9ARtgk0jk0YtaUMDfd3gWe1GJnoEdYWGilvNFIZ91
 UKPSWDiJys5mdKyZM2PLZbUiX2mjMt9RnGAo4els2D+cawvmb6Fg51f/NtDx5JlDLsas4X3Fu
 ns9FGB1M5mqP6M38fM+GZAAe/OKwpsM6llPEaLSPjlpeKFtXWnjz9fwlaIdasco8Gn0QIughf
 9D7MV2VRHtFg4qG6jJ2CugzrwOcYSxpMHOksCN6fdBKCVSG5rXXbfVV9fW+SBz1GIf6Vxq1Z5
 911mC88/zXY3am5cgpeobc7Mznms7k1pYijbeaB8E0K8PFCTjSW8Gyqq6Ga3XaHuCkzuI2Vg+
 ueQWQ3+q9oRQSr3UPEw154giVEvfwMDQy9hE3mkES9dQPcH4aVH/2enh6A0Va1UGmOkYk7CHh
 pEj5YXGkTS1Ti46teKiZGUrIYMFa0lcc11A/kWRgNqfQd4ROl63R9pBIi2GC8K/bKPfXki+12
 rkAhttfZZg6xuPT4FMM1PCwFZrwmHN9JjKDt+na+VPKn/IpDPHJoSpjPKmtdcfD1SqiU+m7Lx
 T1plWLklIOM8+JBjnNimUWZrY3nM2qCtqPI00tS5jNjooOdDC+32p58RrxLluTeq97S1DI9yh
 Z3bWNdzqQp06DRbZ57OYrHyw==

On Tue, 2024-10-01 at 19:38 +0530, Vishal Chourasia wrote:
>
> With the below changes, I don't see any warnings been printed on the
> console, along with it, there were no kernel panics

Darn.  I was hoping to quash the easily reproducible noisy avalanche of
doom to let elusive $subject through, that being way more interesting.

When I hit $subject, LTPs cfs_bandwidth01 was running, but there was no
warning prelude, box went straight to panic.  Trying to reproduce using
that testcase plus hackbench as efficacy booster produced lots of dying
box noise, but zero sneaky $subject instances before or after quash.

	-Mike


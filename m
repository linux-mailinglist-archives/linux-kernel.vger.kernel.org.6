Return-Path: <linux-kernel+bounces-397540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B38E99BDD26
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625BA1F2212C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573D118A93C;
	Wed,  6 Nov 2024 02:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="JnJ9ZdLz"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7415A47
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 02:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730861157; cv=none; b=mOGe8jjn9pfSiXfMAz8qXUIlED3KoJcphUKZwoFy0ptjLEpC8o8CB+KNifa7zxj0qAz2CzyF0KTSKxbXdshrnow3Ko7tbyAKhWMVDKIZpxjL9e7BxtNrNFV1TG+jF32aDKBAksXsFClw6hyPliuRgZ9P1edGmPEoyEJZJ4Jecx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730861157; c=relaxed/simple;
	bh=6AGxicPP3wzLa2foKik/ekq5nAhbb0E6/mJq5JcdFuo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pStAOG+AuZdGKjexoI+NZNOLfMILufsuIF/gW4SV612tiIBGLOrMP2geTY5cKo6eA1sDcvR8/l9smX2zV/igc8yY5M4cd4ef9gvS4mdrIZMtRl2okz6o0WKomF3VyPaEFUsu4DRMRow6s5DKHwv4pxNuBYPE9nO6rS/51lC5t6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=JnJ9ZdLz; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730861124; x=1731465924; i=efault@gmx.de;
	bh=nbyUCoKRyaPtnsnxqy8W8hwonOZ2n1FhF1yiVSJj7ok=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JnJ9ZdLzNBOTy0FzKOclwni9kkfEQGV/pV7/g3dURwnvherJMjN7eNB8Fz0tc6W0
	 5PhNzkbLZAZUA6o8H3ZZv4SlyvP1bcCjIqhhgo3GSoOd8kxcMyBkmDzLi1ZYO4UGy
	 U1i84nSMfGPnpYWuSTUsBfjgxKIhO1fQvvDOdva+yLcFCmpCm0kyVnaQr9B2ScMfZ
	 dZyCfKVLKTRiLD8hQwTNJe4BDZUM8MZmy4MzVvpg6I5S+OGEcYdjrRUK3ZfkAeLjX
	 s1GePPi5svbM+PS2gZwjujGszGIdbSxyCYr2n7zUtGheo+jtvYZf1NpVC5yMIhKIG
	 XOERefh43IVCvnbXfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.144]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mof9F-1tbGIs3BZh-00gVOS; Wed, 06
 Nov 2024 03:45:23 +0100
Message-ID: <3c25eda1d0d38fc956bf9f0ba73e6191dcad36dd.camel@gmx.de>
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
From: Mike Galbraith <efault@gmx.de>
To: Phil Auld <pauld@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,  rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com,  linux-kernel@vger.kernel.org,
 kprateek.nayak@amd.com, wuyun.abel@bytedance.com, 
 youssefesmat@chromium.org, tglx@linutronix.de
Date: Wed, 06 Nov 2024 03:45:19 +0100
In-Reply-To: <20241105190534.GC33795@pauld.westford.csb>
References: <20241101125659.GY14555@noisy.programming.kicks-ass.net>
	 <20241101133822.GC689589@pauld.westford.csb>
	 <20241101142649.GX9767@noisy.programming.kicks-ass.net>
	 <20241101144225.GD689589@pauld.westford.csb>
	 <a59a1a99b7807d9937e424881c262ba7476d8b6b.camel@gmx.de>
	 <20241101200704.GE689589@pauld.westford.csb>
	 <59355fae66255a92f2cbc4d7ed38368ff3565140.camel@gmx.de>
	 <20241104130515.GB749675@pauld.westford.csb>
	 <1bffa5f2ca0fec8a00f84ffab86dc6e8408af31c.camel@gmx.de>
	 <20241105152010.GA33795@pauld.westford.csb>
	 <20241105190534.GC33795@pauld.westford.csb>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LE0JMBLaxokoP5cVycXgG9DqQZEroBB3Aqw2zXqVFuc1ZnTpY5h
 9Qmj6gZzg1wlsF98R4UY3L66SIEjqUNEXJa4AQ6zB5E1OyQ6QIaiblzozXZCyVIGf3Rocot
 glk4FU4GlN68UdlxkZAVE5Mpt3tNq443G6ktqxCkWteFePMXqx87QoR3SUSsXZl0iGrqzgB
 8tsuVSVBFAV4zrBYQlNIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S9G1ukGqb4k=;JvNZbc/cg/jJD9PYQij79dDrH+i
 D8+O/JLflbjpK5ctxOvmSMvVcHAb/uNugEWElcW9NvTI9y+nt4Sm6sf6dzRG5hU0J2Oz0CeOo
 8yk6jjAb6zthi7BJbHmp0geOKIhveMtu9xWh/VOr2ZRzXg4YmGjlUo3UiEkQZ4crt3XZ3+IBb
 YKCffLoSRmhnYx8K26rhYVzTIJ6rZVuyT5FP2ziu1DeuoFlz7Z+zcUUg480Lt4Cyd9x0i6M9N
 XJiVcRefKwIwhbZn/n546+9rjnRwMuBEE1bZMQJA8XJ0wIyGAbnHy71W5TKvYkany/lnSDfI/
 r56+DOKZU5qEYu8axafsEgGJpKbYkPOOeRRfTfDEJrDMkv5E6ihQw8N/mZP+h59J/ih0aFy43
 jdEJiTOpLQAMTL2JuSEgqw4Ay0TikTjPdh9vl6syXMXsrKFr9AJCg9bZpx7vB9YwRo+1eJSxK
 7pY9R+1Mt60EyC21Nv2fIxMBbc7RInTXIzKs7E7BVKCbX1ghvHBx3MLY8g1e70BLNF0VkM2hy
 fxD9qxuFRWghDsSIiUakqxefqVNmfAWdEyABY9VtX4m70jq1ZTqnJUHLC1vaJAgbVlki8Bbyy
 rAIr4ATvWL0kJ+Ho0JrZelW8jCoqXlmr4cCPCUmHU1xJMoZxxY2pg5ybVh063+rrzCDutvtFM
 cW8RPQhXsUzxgafnu8gJbUTC11yemzqEeReFEi22IYEmJo4a0pQv27aWxOPGrOkAU6+vqWiMb
 ANTucUm8tFjl129TsKNk+h6G2AuEMdPpZB4MvmVkpJ6PT3GUzZ0PfxDP7z4hUP3VfQmz4d5b2
 doRncGBJAT15foLsAgPm68qA==

On Tue, 2024-11-05 at 14:05 -0500, Phil Auld wrote:
>
> Well that worked pretty well. It actually makes DELAY_DEQUEUE a litte be=
tter
> than NO_DELAY_DEQUEUE
>
> DELAY_DEQUEUE=C2=A0=C2=A0=C2=A0=C2=A0 ~595MB/s
> NO_DELAY_DEQUEUE=C2=A0 ~581MB/s

Hrmph, not the expected result, but sharp stick's mission was to
confirm/deny that delta's relevance, so job well done.. kindling.

	-Mike





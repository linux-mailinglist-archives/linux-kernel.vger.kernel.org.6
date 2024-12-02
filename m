Return-Path: <linux-kernel+bounces-428182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EA19E0B1E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B675C1644E7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C061DDC39;
	Mon,  2 Dec 2024 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="kWF95OT6"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781862E3EE
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 18:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733164513; cv=none; b=FtZ6/DJjTJoy/V7Mm348AH40zJxSM/KG3yr/QY/OAFnp3dc6U2x096xkYuNum/zE67QNzslBhPK30eJdGR7jvXamVnHyOkbmcBTjBTh52oJCq3OuyEnopg4OksT29fT8oux/Tvyd+xNG6bPePL5Yk9+dze1kvE8fBxgIVdiXcYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733164513; c=relaxed/simple;
	bh=d4hDGzmFGatNBWraJ/U0QmM8vdW/sZK362Mqm1iAioA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c4SLO/QJmDg+f3UpsSYOuEBRkFSi3+g9XVnhRZlhADCzfPW9IwUyR9Iwbgvm65lNRiwlq+ELybZ36mex4bXxJgohG8vvc47cnvEuzySqQ8koJLjMlw2arwPzAVCIVTcgJ2LGlrQe7n3nvAA0HC516RQ7Ma5tpyQAzZbzc7e2C3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=kWF95OT6; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733164493; x=1733769293; i=efault@gmx.de;
	bh=WQi65IK2mkZk7w3jmwVOV5eRAcg5a5EmOprRCA3q+Dk=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kWF95OT6gleWaAP00XrR48tf1gc6yrdfn4cnVriADpbJRDmWNBDdILNwy2RjalYS
	 IiXt6+0Pf2eylH8ZlnqywF0wjZmbkKKgBTUXzPZ8220b1zFg6Q+PFNivqimgodHvA
	 nj33pGQF4tBsiUKJMXEbpjS94gNIFifVuefs42w35vQEdMX0DweFquZ6fIP+f447j
	 40ZjtU7cXiVWQR5zDHysJJfpNW66PkwEQrHjcjWscXEvd1948OFEW4fp11h1Pswf2
	 p0+N5/PX4ctGuUsaOSWOPaJxtXIfhwSNDeJ3C0PVLXh5afrV64a+iioO3UV/uWt5R
	 gj0nycWld/MCCfWflg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.84]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M72oB-1tJWhn38nv-007Bko; Mon, 02
 Dec 2024 19:34:52 +0100
Message-ID: <e824a692ab22423a07ca2ab91713c8340d949c99.camel@gmx.de>
Subject: Re: [PATCH 0/10 v2] sched/fair: Fix statistics with delayed dequeue
From: Mike Galbraith <efault@gmx.de>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de,  vschneid@redhat.com, linux-kernel@vger.kernel.org,
 kprateek.nayak@amd.com,  pauld@redhat.com, luis.machado@arm.com
Date: Mon, 02 Dec 2024 19:34:51 +0100
In-Reply-To: <CAKfTPtDwS4+t0Fnacre6dtxKdxtrgua_2v=s7pZHqDsYoMMxFA@mail.gmail.com>
References: <20241129161756.3081386-1-vincent.guittot@linaro.org>
	 <227863d758551e75cd0807a5f1f31916d695205b.camel@gmx.de>
	 <CAKfTPtDwS4+t0Fnacre6dtxKdxtrgua_2v=s7pZHqDsYoMMxFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zuTnBchwSEfKkCXayxttZLer4pWxcsqvyCEC1Pfsd0nEoiUzNYE
 Wsayz4AtLQlUXU4u9EjPRwgFMBMiTj6hOod7NtMnAoFRzm1DgsddgX5YUzqsqrkKvgJKCTX
 asGsqtzAy6wBD1SV//FD7CMfPW65SYq0Yj9kuB4Tpt518OgQm+Ez01eCaGcyax9mWVor1pu
 /XusE9k0ziumCwhayC/sA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0sdlT/CidCk=;eriYKFHh5E8i3ejL+lyzPqnKF7E
 oQl4m2s6WGhkHrzMm6PRRiAWDSDL6OwVFH72DVD/p5K+inNwJb5X4PQh+YNLivQa+kKrikjk6
 KtnfyZBGYC/TWAlSCdz5qMNSM5Chdgg/M/XWPVMZBhEWd15YzmLkG44nEUMpAW/YaR6nXJM2L
 HyxfK/rPVyMivsYa1/K3n+mt3DheRHjIlYx8d6C8SmV8y0dT79XYJeAs8uTkpXKFxrK6WpRzP
 Jyo9is7Naf8GwgsRlXn24MQvaZv2I3IuwgJkqw/AHCVboHvks+eqoo0+qm+ZyMF0wbtasooO1
 Vxo4Bdqgy+i7Im9DBwxATUG+oawpedZPLscMjNDuY6CS2/ymaAdeff51S4oGFR8x8/mPtwSod
 GYI+PQinv5R8mlkKQmfB7c6c3QywKdlJD/9i1r/IbE1TSLG0YIF8iis93tE6E2MwrwHicPW3o
 RX81JU5WgrsB9YxmkG/krc7U91aYhkcN6YFbZYNllH6an8sD1OOmKadYbZu+cRyQdVZQkPaDy
 ZtZ1hUPSTHS4xul6Ilo3Q0GOR5AUWD7FZdhakoSeI497CsztaQZ9xLAs4/B1eeh0b5rOS/bh5
 AaxCiF/yojD7w6BKL4Fz9b8Zj5MAzVYszFS+/5/E9Ppl3HJtIa8PYJwSX7MDGXSXGbSmDrfng
 UZsGF0YrSkLZqXxacKVpd22iiU99WcSU5fRKZWq0VJT2AHFPP6otEPNTqQZ7B7dF0rsdCMiXQ
 +8Z2jkztcAIFrWr3ZNbFg6gvggqtBFjQSz9m6hwxGdp4mSGUJU1a0lnK4nj11Tm/P+pYoy/pp
 sKvQdWGM+0nE3Yz/CxDU9tZqFTmiViB9PuhgUync7VCvhUqnO3T9WN/FxmL9anzcLKgcfn0YA
 JoPOJWpztJOZ7REJhUfTOgesq5E9fzT6a1xyaWCHoSZU0b4HZBbCYhiW6EG0D/vh9TUjomgpV
 KcdHyMGQgPyxIej0PdktyuaWAC4WhWJm70d/1K2+FeTBq9ioFIbQkn1RdlUo54lKukMu8kNC/
 TcH+q8fCfO1kCb9bBIdt9d8xmt2dxpxifURA3ZkUjVl/7YTjcu6czMfGlDskxusyKNIgPMCgm
 hKyGEi+Wc=

On Mon, 2024-12-02 at 10:17 +0100, Vincent Guittot wrote:
> On Sun, 1 Dec 2024 at 14:30, Mike Galbraith <efault@gmx.de> wrote:
> >
> > I took the series for a spin in tip v6.12-10334-gb1b238fba309, but
> > runnable seems to have an off-by-one issue, causing it to wander ever
> > further south.
> >
> > patches 1-3 applied.
> > =C2=A0 .h_nr_runnable=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : -3046
> > =C2=A0 .runnable_avg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : 450189777126
>
> Yeah, I messed up something around finish_delayed_dequeue_entity().
> I'm' going to prepare a v3

v3 is all better with my light config.  I'll plug it into an rt tree
with an enterprise config and give it some exercise.

	-Mike


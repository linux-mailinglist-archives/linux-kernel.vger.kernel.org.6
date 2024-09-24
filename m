Return-Path: <linux-kernel+bounces-337457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC2F984A55
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C351F24A19
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB951AC43B;
	Tue, 24 Sep 2024 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="rgtdQ6J6"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938CF1DFFB
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727199399; cv=none; b=Qczgv1rhR3UAX6dd85IxedwdWCsYDROFoEmDaNb1H4ab7EDzqJnna2zGJzPo9XFIiS0M0SUICTpnzK/btBOXs2yB75nTk3JKeUOvZgv2O4JhrhEfTqd9iQZPl4yFbAqpfEXcGY5xEF+d7AMuLNc/PusKi2eRbxo0+DDYxh7DAw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727199399; c=relaxed/simple;
	bh=f5i/5LPhY1TGOvPasOjWAd/nrD2FDeXXkFx/xwrjRUI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DeCOKwcncHuNoRgev0SLP/IUaf1bZ/ubXuxCq0Hbdvb00LuURDZbGGIjsgG7s/7SoR9biYE0PTuilPiy3V6o8YU2GM8pepvk4tTCLKGvs7i5SJ4wh4R43BbtiKahY6YbDBQ82nSTe/nXG2VsQZ2B4dbHRjHmBcAaUKgTSDCTfYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=rgtdQ6J6; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727199341; x=1727804141; i=efault@gmx.de;
	bh=pyDMN/J35PwbscbwQM/l7EpelwJxja8WdpGY5rbj3OI=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rgtdQ6J6izY/zgEsqK8ysl91yDj2TwqbVF/UM8IcfoHrRIuhusxJgQ2sav9JrNZF
	 g//E7J1zaXdbto0PVTJWmo52KxID86ENKdXf+fSbxjbt2malN3XFt7HJg+P9rt4Vc
	 juv5DiH+w1hcnBUAl5Al9wD2+Su+b6u04pMkMrprbM0OevPKrwNCP5KyhuKxl9Xgn
	 ti7ESPX7gJVDxJkaArkrVk6rIEq+uBTxUGX1DiznxSff4jYyv8j3jj8kg/B0nBkCA
	 heO9Q1vCoGPPLWQkWDEvSvO5DT/utQB8yb/MCleS6QeneYMU5pMUOxIqo4zUr+C8R
	 U4Q70/1nCOOh8kxf9A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.98]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOzOm-1saMVt30MW-00Lzl1; Tue, 24
 Sep 2024 19:35:41 +0200
Message-ID: <cd0002841126d8a42db94c3624ccf2ce8dc1ad10.camel@gmx.de>
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
From: Mike Galbraith <efault@gmx.de>
To: Luis Machado <luis.machado@arm.com>, Peter Zijlstra
 <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Hongyan Xia <hongyan.xia2@arm.com>, 
 mingo@redhat.com, juri.lelli@redhat.com, rostedt@goodmis.org,
 bsegall@google.com,  mgorman@suse.de, vschneid@redhat.com,
 linux-kernel@vger.kernel.org,  kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, youssefesmat@chromium.org,  tglx@linutronix.de
Date: Tue, 24 Sep 2024 19:35:39 +0200
In-Reply-To: <c001e3ec-bbc7-4de3-a9bc-cc324d366fbe@arm.com>
References: <c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com>
	 <CAKfTPtCNUvWE_GX5LyvTF-WdxUT=ZgvZZv-4t=eWntg5uOFqiQ@mail.gmail.com>
	 <a9a45193-d0c6-4ba2-a822-464ad30b550e@arm.com>
	 <20240905145354.GP4723@noisy.programming.kicks-ass.net>
	 <20240906104525.GG4928@noisy.programming.kicks-ass.net>
	 <8d0d01b9-a430-49cc-93a5-67b4d68aa35c@arm.com>
	 <20240910140524.GH4723@noisy.programming.kicks-ass.net>
	 <52ca4cea-8f65-434e-af17-e4bf664d9488@arm.com>
	 <20240911084528.GJ4723@noisy.programming.kicks-ass.net>
	 <4fde8f26a9aeaeafda15b81bbb17b0ffc96941f0.camel@gmx.de>
	 <20240911091328.GM4723@noisy.programming.kicks-ass.net>
	 <2030b198180259eede6384cc6a6bc9bc9f64f874.camel@gmx.de>
	 <a96858374fb06ba38dd5eea5561cc7542220416e.camel@gmx.de>
	 <627e37090198cee91bf79c41b1cd8c20c2e2d71f.camel@gmx.de>
	 <1e89e5bcbd43934c65f8da23e7fbd59da950a0a3.camel@gmx.de>
	 <c001e3ec-bbc7-4de3-a9bc-cc324d366fbe@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eGefuFChs6vbk8IWHcJPcFvSY9cOUqmJsAOnfur6MnDnvUhn5o0
 uK389kZ7aAnMa1gC2/oU2gdGbMmjSDfTfWpNYM1v48poox79XoGPrjuP3SCZayqbtHAkdJN
 8bIt4roQd93TTq4H0q9xsXsIseM/eTXmkDREOX8I+AjOG3t9x2vPhxOde/iUmhNBJoaNVUn
 OC+mvrKmtDtmKQ1PVHaVg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E8T3M8AJvMY=;fz1cZxbI9VfX9la1knerCRWe5F1
 ONxiVkbQrQSoIpcigYgUDKXx+8PiueG+PoInGy9AnyM0duG2eH/bfeMPYOVPoP33+7UlqasT0
 QYlnpIc9Jkg//g/2KkDd3W+y7akbP2OyOpXQHeSfDzo5D1MuWLirIvyNcm6hoX7ONBO67x+Ht
 YR6yi7B8n6rfvIyTCWO0XIWX1aDiNMTN+jlKaUbPmWV/7gXHFhSC/z3y6uwRwV0cONqoWSHeD
 KelMJ7qTf0xuFPURyPhLJcld069PlLEEiJdCuTqDCPUadeJvnR6+VD0YNtBX2dZSEhZqhVhDe
 aEIkpwz6OZRn/helFVeT4iAd5bg+FCzFOXXk3Ko4eLaWf4UbGlaZfjEaH4HiY7MpL4tb03LOR
 IuOGAiCR3U+uULAL6+4Ye1n9DRHTuk/M5P86eLd7BXIee8PVy/+VW9OcS3IooaCDYBwNe4a4K
 tCMe+jk3uD4JPS9hDlv+ehG2/HEsS5imvYGtclGxzElKyov5l+kUKnd6Ewzkid6itETRNRkTy
 j8AUxo6EDyAhd5RcP0uO/GV5ZsUnOS2E3VwYANTPP298SRJ50cCwmr3d4sM0DnyCTjbylrMSj
 olWPKn96qerFetphCJ0Ahza7cNlvwIENRYL6vqqj3/Z0v3uDbijIO7ou928gXPvvJMrGSPMF5
 bAE4VqknbFxzzXyURE4B5dDMieyuu3bawpl3x9T1rUOfx2BEU13YtnuA4DCM07Oilj4p9mHcZ
 W/XBpAroPGTNzgvcps275yvkH3MZ8duR608cL5RnI3bm2ZnlFwbdHzZ7yDN4SgUBI7OtCDjmO
 aGSqIJ1MvBT/Z7dPjnZCXUBQ==

On Tue, 2024-09-24 at 16:16 +0100, Luis Machado wrote:
> On 9/14/24 04:40, Mike Galbraith wrote:
> > On Fri, 2024-09-13 at 18:39 +0200, Mike Galbraith wrote:
> > > tip 4c293d0fa315 (sans sched/eevdf: More PELT vs DELAYED_DEQUEUE)
> > > seems
> > > to be stable.
> >
> > Belay that, it went boom immediately this morning while trying to
> > trigger a warning I met elsewhere.
> >
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-Mike
>
> Are you still hitting this one?
>
> I was trying to reproduce this one on the Pixel 6 (manifests as
> a boot crash) but couldn't so far. Something might've changed a bit.

I'm also having no luck triggering it.

	-Mike


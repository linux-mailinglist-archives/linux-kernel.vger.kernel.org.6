Return-Path: <linux-kernel+bounces-444593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D159F092D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5A4169910
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253EB1B5823;
	Fri, 13 Dec 2024 10:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="cCAbUfgt"
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2681ADFFB
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734084672; cv=none; b=XicxI6WkSaOe285s0xv2RwD7AoPxItGyuFNGNSN81dmu+x0NJBjcdH+DgdeDEBO0WbcN0J+9TTygib1OJQ1tA2Fbw73iP+DwzEMwVGvg040DMsO1T+eNsY4tvl+CZYYJQ3j9VuXqC/l3rbRtWd+yq7juKE75FTL8dJYXr94I6dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734084672; c=relaxed/simple;
	bh=5vAjebdKfPKDzau8DjWaBsRSe4Z06BY5VOge9AXnoYE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rM4e3TAcFY223qoie4sB7f7CM35Ue/GZ0fS4p/JCf2Xnkg16+U6IX6ABfKPyi6s69GtgnNYRAhMHYLsc3dCrHLLKLxWkCaPSp7sSbIg9ZWMsYY+xl6GTuPM4xH7Ne+r8Lij2lHXt45DwaRezH+lTjqJhe+UwFzsQgg4fTihKmN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=cCAbUfgt; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PvqpUAaupnmebyBNzhqsCtweLUc8x/sRWyRUs0q+QN8=; b=cCAbUfgtLASgYIR/Dl90L2R3Ye
	sm4kKq+7A2bTpo94PtjYe/qKVddF44q/djLZUWa+bgkZycpIHFDEFwaEDAXW4tZQFFoXJPJn7t7Bs
	yPGH03cV5C9MR7hgd8QwQX64cblG9Zrqpx03/pzkFstpQDu3n+q8VPx0u/7hgzXcNmUUqjfBRcJWA
	Wi9Z2PI8wlx867oMLTBhOmrRmlOYgZM5ppd42pZdoOKip8iZOgHD0yqC1Jba2q8/39Lt7j1uwKBpK
	+wgSGFn3nvzYsRqwje1BHAyhLhntIpWmYh1bQymt3zDoauj80pT0X5jG6vIWVcOIm2kHdwn436SgL
	4ln3H2og==;
Received: from [167.98.27.226] (helo=[10.17.3.146])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1tM2dK-00329Y-42; Fri, 13 Dec 2024 10:10:54 +0000
Message-ID: <41be49a210d5ef1c48cd0cbfe23a52368cb049b9.camel@codethink.co.uk>
Subject: Re: [PATCH 2/2] sched/dlserver: fix dlserver time accounting
From: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>, Peter Zijlstra
	 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>,  Joel Fernandes <joel@joelfernandes.org>,
 shraash@google.com, i.maximets@ovn.org, LKML <linux-kernel@vger.kernel.org>
Date: Fri, 13 Dec 2024 11:10:52 +0100
In-Reply-To: <20241213032244.877029-2-vineeth@bitbyteword.org>
References: <20241213032244.877029-1-vineeth@bitbyteword.org>
	 <20241213032244.877029-2-vineeth@bitbyteword.org>
Organization: Codethink
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: marcel.ziswiler@codethink.co.uk

Thank you very much, Vineeth

On Thu, 2024-12-12 at 22:22 -0500, Vineeth Pillai (Google) wrote:
> dlserver time is accounted when:
> - dlserver is active and the dlserver proxies the cfs task.
> - dlserver is active but deferred and cfs task runs after being picked
> =C2=A0 through the normal fair class pick.
>=20
> dl_server_update is called in two places to make sure that both the
> above times are accounted for. But it doesn't check if dlserver is
> active or not. Now that we have this dl_server_active flag, we can
> consolidate dl_server_update into one place and all we need to check is
> whether dlserver is active or not. When dlserver is active there is only
> two possible conditions:
> - dlserver is deferred.
> - cfs task is running on behalf of dlserver.
>=20
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>

Tested-by: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk> # ROCK 5B

> ---
> =C2=A0kernel/sched/fair.c | 15 +++++++++------
> =C2=A01 file changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2d80aaac4413..f5329672815b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1159,8 +1159,6 @@ static inline void update_curr_task(struct task_str=
uct *p, s64 delta_exec)
> =C2=A0	trace_sched_stat_runtime(p, delta_exec);
> =C2=A0	account_group_exec_runtime(p, delta_exec);
> =C2=A0	cgroup_account_cputime(p, delta_exec);
> -	if (p->dl_server)
> -		dl_server_update(p->dl_server, delta_exec);
> =C2=A0}
> =C2=A0
> =C2=A0static inline bool did_preempt_short(struct cfs_rq *cfs_rq, struct =
sched_entity *curr)
> @@ -1237,11 +1235,16 @@ static void update_curr(struct cfs_rq *cfs_rq)
> =C2=A0		update_curr_task(p, delta_exec);
> =C2=A0
> =C2=A0		/*
> -		 * Any fair task that runs outside of fair_server should
> -		 * account against fair_server such that it can account for
> -		 * this time and possibly avoid running this period.
> +		 * If the fair_server is active, we need to account for the
> +		 * fair_server time whether or not the task is running on
> +		 * behalf of fair_server or not:
> +		 *=C2=A0 - If the task is running on behalf of fair_server, we need
> +		 *=C2=A0=C2=A0=C2=A0 to limit its time based on the assigned runtime.
> +		 *=C2=A0 - Fair task that runs outside of fair_server should account
> +		 *=C2=A0=C2=A0=C2=A0 against fair_server such that it can account for =
this time
> +		 *=C2=A0=C2=A0=C2=A0 and possibly avoid running this period.
> =C2=A0		 */
> -		if (p->dl_server !=3D &rq->fair_server)
> +		if (dl_server_active(&rq->fair_server))
> =C2=A0			dl_server_update(&rq->fair_server, delta_exec);
> =C2=A0	}

Cheers

Marcel


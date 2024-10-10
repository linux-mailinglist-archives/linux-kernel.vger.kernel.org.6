Return-Path: <linux-kernel+bounces-359725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CE4998F90
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F201F21E63
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5D819CCFC;
	Thu, 10 Oct 2024 18:15:23 +0000 (UTC)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8CC19AA75
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584123; cv=none; b=HM11QybpvmoyhPq386tGvGaIzNLBIEIEg2V91Ke1wUG+BG3C5NRfcBHj6d3GPQMhS4+P3mwJTFQpZwkllxIoNIY+NBYp+3JlRO7V0jKAoSU3lVyhe4FEeZTu18czaAXdFiYoGuyYLnyYe4h6A4+xdPtERjocVadNjqMJgTwXaPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584123; c=relaxed/simple;
	bh=9YXtJpCzg7TYAqmRxaWm3Xw2EuZaVbDK4L2lI5hflEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaLYMPVA6CEWb/AqKl02h+7w5IHLC0Aq5NhHPvf8ay2oMXkuAJPDqO2EvpCbs3dGkRGqsx4KBpWCrurWfe+/FyN+4kob0wo687yw2qwuwr/Zgs4OvLIIGDoAvK3uPGboMChvvH2PlAk9UldXJ+gscUM1wvO8MTLU4ptfPAvguos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e28fe07e97dso1262345276.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584120; x=1729188920;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwrn2Xy/aMgvLrxIFg3g/ca8md4MEfLanoKvVzTiBKk=;
        b=Vqm9LmUxXaQyR5tac8GBytROyMp/uNqaR4AdJo0cDZCQcJoQAGYUKiXSK9NXvSSBHn
         Sz3UtCtkGWdScjqa27XwyzX1ZAnySe5a7+fl0lPmyMveeVoy1kAg6I7HGLSfZgwirsAF
         5nHRgL5ltC6a2X9Zvj5gJ/cq+uwW1TQn1INcZdP9lxAHWEUror/jarkRfsJhKlkpK8tT
         naHkoVJR8sbewEp00EwO5S7JN+y1aE+F5d4DBmm4z3Hap1yjdD000JRoXdM0LdusDVtV
         ec4l3lpmy5vWwAPenNCRFdSFQLZRbNdeqWBrfKXXVREPu2dIfC4qp8EZRmpvXtqxJakD
         ZiCw==
X-Forwarded-Encrypted: i=1; AJvYcCU3FKss/5+SVTTzVvvScT70NczoZdFtDDUf6ngWFC44P1ljTFxHmkDmgvDfCYsOt7nmNX6JseHrD0C/XfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNtQMdIIPrP/nPVIgJnoBkq1pDLLKo1APID0msRQeJQxHZklJB
	30JpVkorUGhpIGVkoWC+da/oUj5sryueHxkkOZlPXGQwsrMvZFjn
X-Google-Smtp-Source: AGHT+IHMFzyiQKZfd6SfVyA36Z2swrAYkkMV6LkY+UaLlgCB3U3n5CFt7Sp4pJV9C8ICmMjdV45oQw==
X-Received: by 2002:a05:6902:707:b0:e26:7e1:5c09 with SMTP id 3f1490d57ef6-e28fe45342emr6497083276.27.1728584120206;
        Thu, 10 Oct 2024 11:15:20 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e290edf217csm399392276.6.2024.10.10.11.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 11:15:19 -0700 (PDT)
Date: Thu, 10 Oct 2024 13:15:17 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org, sched-ext@meta.com
Subject: Re: [PATCH 4/6] sched_ext: bypass mode shouldn't depend on
 ops.select_cpu()
Message-ID: <20241010181517.GC28209@maniforge>
References: <20241009214411.681233-1-tj@kernel.org>
 <20241009214411.681233-5-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BQwlaxrXEd1HS7zv"
Content-Disposition: inline
In-Reply-To: <20241009214411.681233-5-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--BQwlaxrXEd1HS7zv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 11:41:00AM -1000, Tejun Heo wrote:

Hi Tejun,

> Bypass mode was depending on ops.select_cpu() which can't be trusted as w=
ith
> the rest of the BPF scheduler. Always enable and use scx_select_cpu_dfl()=
 in
> bypass mode.

Could you please clarify why we can't trust ops.select_cpu()? Even if it
returns a bogus, offline, etc, CPU, shouldn't core.c take care of
finding a valid CPU for us in select_fallback_rq()?

Assuming we really do require a valid CPU here in bypass mode, do we
need to reset the state of the idle masks for the case of
!scx_builtin_idle_enabled? The masks won't necessarily reflect the set
of online CPUs if we haven't been updating it, right?

Thanks,
David

>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>=20
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 1cae18000de1..c5cda7368de5 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3126,7 +3126,7 @@ static int select_task_rq_scx(struct task_struct *p=
, int prev_cpu, int wake_flag
>  	if (unlikely(wake_flags & WF_EXEC))
>  		return prev_cpu;
> =20
> -	if (SCX_HAS_OP(select_cpu)) {
> +	if (SCX_HAS_OP(select_cpu) && !scx_rq_bypassing(task_rq(p))) {
>  		s32 cpu;
>  		struct task_struct **ddsp_taskp;
> =20
> @@ -3191,7 +3191,7 @@ void __scx_update_idle(struct rq *rq, bool idle)
>  {
>  	int cpu =3D cpu_of(rq);
> =20
> -	if (SCX_HAS_OP(update_idle)) {
> +	if (SCX_HAS_OP(update_idle) && !scx_rq_bypassing(rq)) {
>  		SCX_CALL_OP(SCX_KF_REST, update_idle, cpu_of(rq), idle);
>  		if (!static_branch_unlikely(&scx_builtin_idle_enabled))
>  			return;
> @@ -4254,21 +4254,23 @@ bool task_should_scx(struct task_struct *p)
>   * the DISABLING state and then cycling the queued tasks through dequeue=
/enqueue
>   * to force global FIFO scheduling.
>   *
> - * a. ops.enqueue() is ignored and tasks are queued in simple global FIF=
O order.
> - *    %SCX_OPS_ENQ_LAST is also ignored.
> + * - ops.select_cpu() is ignored and the default select_cpu() is used.
>   *
> - * b. ops.dispatch() is ignored.
> + * - ops.enqueue() is ignored and tasks are queued in simple global FIFO=
 order.
> + *   %SCX_OPS_ENQ_LAST is also ignored.
>   *
> - * c. balance_scx() does not set %SCX_RQ_BAL_KEEP on non-zero slice as s=
lice
> - *    can't be trusted. Whenever a tick triggers, the running task is ro=
tated to
> - *    the tail of the queue with core_sched_at touched.
> + * - ops.dispatch() is ignored.
>   *
> - * d. pick_next_task() suppresses zero slice warning.
> + * - balance_scx() does not set %SCX_RQ_BAL_KEEP on non-zero slice as sl=
ice
> + *   can't be trusted. Whenever a tick triggers, the running task is rot=
ated to
> + *   the tail of the queue with core_sched_at touched.
>   *
> - * e. scx_bpf_kick_cpu() is disabled to avoid irq_work malfunction durin=
g PM
> - *    operations.
> + * - pick_next_task() suppresses zero slice warning.
>   *
> - * f. scx_prio_less() reverts to the default core_sched_at order.
> + * - scx_bpf_kick_cpu() is disabled to avoid irq_work malfunction during=
 PM
> + *   operations.
> + *
> + * - scx_prio_less() reverts to the default core_sched_at order.
>   */
>  static void scx_ops_bypass(bool bypass)
>  {
> @@ -4338,7 +4340,7 @@ static void scx_ops_bypass(bool bypass)
> =20
>  		rq_unlock_irqrestore(rq, &rf);
> =20
> -		/* kick to restore ticks */
> +		/* resched to restore ticks and idle state */
>  		resched_cpu(cpu);
>  	}
>  }
> --=20
> 2.46.2
>=20

--BQwlaxrXEd1HS7zv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZwgZtQAKCRBZ5LhpZcTz
ZBGFAPwJbzrGDeHE8JzNrhtv4lQHB3JskJazMmVzaF+gFWtPLQD9EhoeJ5MZCsHi
GecKch+BmExSPQfbubu/BcZhqmo0Cw8=
=qcL6
-----END PGP SIGNATURE-----

--BQwlaxrXEd1HS7zv--


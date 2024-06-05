Return-Path: <linux-kernel+bounces-201658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 687E98FC170
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 03:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A9B1F23024
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C38455774;
	Wed,  5 Jun 2024 01:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MYapstne"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F54D41E22
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 01:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717552323; cv=none; b=RGZC+/H6P2O1rfQbsG46hV/QgHK2Ej+gxy41/QPP5zwefdPH+ztSVIpLrQX9P6nJhf8IB4F0HREmtueTCbxjdPzt6YidzYJDwZA+wmUY0mGLbl8cxYE2I9d4W2QaQLf7jE3irtei+dUigchogdl9yPmnX0g0C0hCeLOm73Z2VI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717552323; c=relaxed/simple;
	bh=tFstuWoiDFg9p/08Ftae3BF6Esh20l7dkxXpMlH7aeM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=IXZCtx7l66lMMmdWgMYuged7Yn9JNaU0Pgh451pufA2DhjhnbSjCEkDl0rnfrOgdj94RJSGGmojKlrmU1g5km/FwXCyxAtBc1RR+WqWRTNArBj6F/1iuj2MYo7Yii26Q1lNgYmMqr1kERBuZWtM4puBGOlBUcsGo5O5Rh7/Pw+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MYapstne; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: rostedt@goodmis.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717552317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUqGdjChfFePBEmzTvxgo/M+GEGY1EGXeb0w/Z5L5Bk=;
	b=MYapstneE6ipTNaTPdXA9F4FZHznwa/90mAqWVYKiuRXYiAPAdZN48zop/l2gdXKRROMwd
	lQVYqsVWjczNeft6tUPlGj6zTzC8QK+/UBwZ/lD9G26tNLmD9SB5zpKrTg2dhZMVHQkUZL
	qTfXn8zQo8qNcWoe6VIfBxjIpHCXAig=
X-Envelope-To: mingo@redhat.com
X-Envelope-To: peterz@infradead.org
X-Envelope-To: juri.lelli@redhat.com
X-Envelope-To: vincent.guittot@linaro.org
X-Envelope-To: dietmar.eggemann@arm.com
X-Envelope-To: bsegall@google.com
X-Envelope-To: mgorman@suse.de
X-Envelope-To: bristot@redhat.com
X-Envelope-To: vschneid@redhat.com
X-Envelope-To: linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 05 Jun 2024 01:51:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <e72e7b6cca0ee56b39e9f28fc66441f3366ba7a1@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 1/2] sched/rt: Use 'back' only if CONFIG_RT_GROUP_SCHED
 is enabled
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240604092203.7c31b7b5@gandalf.local.home>
References: <20240603125002.3086-1-yajun.deng@linux.dev>
 <20240603125002.3086-2-yajun.deng@linux.dev>
 <20240604092203.7c31b7b5@gandalf.local.home>
X-Migadu-Flow: FLOW_OUT

June 4, 2024 at 9:22 PM, "Steven Rostedt" <rostedt@goodmis.org> wrote:



>=20
>=20On Mon, 3 Jun 2024 20:50:01 +0800
>=20
>=20Yajun Deng <yajun.deng@linux.dev> wrote:
>=20
>=20>=20
>=20> The 'back' member in struct sched_rt_entity only related to
> >=20
>=20>  CONFIG_RT_GROUP_SCHED, so there is no need to init it in dequeue_r=
t_stack.
> >=20
>=20>=20=20
>=20>=20
>=20>  Init the 'back' member in init_tg_rt_entry and use it only if
> >=20
>=20>  CONFIG_RT_GROUP_SCHED is enabled.
> >=20
>=20>=20=20
>=20>=20
>=20>  Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> >=20
>=20>  ---
> >=20
>=20>  kernel/sched/rt.c | 15 ++++++++++-----
> >=20
>=20>  1 file changed, 10 insertions(+), 5 deletions(-)
> >=20
>=20>=20=20
>=20>=20
>=20>  diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> >=20
>=20>  index 63e49c8ffc4d..44bb9087cfe5 100644
> >=20
>=20>  --- a/kernel/sched/rt.c
> >=20
>=20>  +++ b/kernel/sched/rt.c
> >=20
>=20>  @@ -232,8 +232,10 @@ void init_tg_rt_entry(struct task_group *tg, =
struct rt_rq *rt_rq,
> >=20
>=20>=20=20
>=20>=20
>=20>  if (!parent)
> >=20
>=20>  rt_se->rt_rq =3D &rq->rt;
> >=20
>=20>  - else
> >=20
>=20>  + else {
> >=20
>=20>  rt_se->rt_rq =3D parent->my_q;
> >=20
>=20>  + parent->back =3D rt_se;
> >=20
>=20>  + }
> >=20
>=20
> If one block of an if/else requires brackets, then both do.
>=20

Got=20it.
> >=20
>=20> rt_se->my_q =3D rt_rq;
> >=20
>=20>  rt_se->parent =3D parent;
> >=20
>=20>  @@ -1428,16 +1430,19 @@ static void dequeue_rt_stack(struct sched_=
rt_entity *rt_se, unsigned int flags)
> >=20
>=20>  struct sched_rt_entity *back =3D NULL;
> >=20
>=20>  unsigned int rt_nr_running;
> >=20
>=20>=20=20
>=20>=20
>=20>  - for_each_sched_rt_entity(rt_se) {
> >=20
>=20>  - rt_se->back =3D back;
> >=20
>=20>  + for_each_sched_rt_entity(rt_se)
> >=20
>=20>  back =3D rt_se;
> >=20
>=20>  - }
> >=20
>=20>=20=20
>=20>=20
>=20>  rt_nr_running =3D rt_rq_of_se(back)->rt_nr_running;
> >=20
>=20>=20=20
>=20>=20
>=20>  - for (rt_se =3D back; rt_se; rt_se =3D rt_se->back) {
> >=20
>=20>  + for (rt_se =3D back; rt_se; ) {
> >=20
>=20>  if (on_rt_rq(rt_se))
> >=20
>=20>  __dequeue_rt_entity(rt_se, flags);
> >=20
>=20>  +#ifdef CONFIG_RT_GROUP_SCHED
> >=20
>=20>  + rt_se =3D rt_se->back;
> >=20
>=20>  +#else
> >=20
>=20>  + rt_se =3D NULL;
> >=20
>=20>  +#endif
> >=20
>=20
> Perhaps make a helper function to get rid of the #ifdef in the code her=
e.
>=20
>=20 for (rt_se =3D back, rt_se; rt_se =3D rt_se_back(rt_se)) {
>=20
>=20Where rt_se_back() above can be defined in the #ifdef blocks for
>=20
>=20CONFIG_RT_GROUP_SCHED as either:
>=20
>=20static struct sched_rt_entity *rt_se_back(struct sched_rt_entity *se)
>=20
>=20{
>=20
>=20 return se->back;
>=20
>=20}
>=20
>=20Or
>=20
>=20static inline struct sched_rt_entity *rt_se_back(struct sched_rt_enti=
ty *se)
>=20
>=20{
>=20
>=20 return NULL;
>=20
>=20}
>=20

Okay,=20thanks.

> -- Steve
>=20
>=20>=20
>=20> }
> >=20
>=20>=20=20
>=20>=20
>=20>  dequeue_top_rt_rq(rt_rq_of_se(back), rt_nr_running);
> >
>


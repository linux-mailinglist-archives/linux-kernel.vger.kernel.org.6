Return-Path: <linux-kernel+bounces-336123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D4597EF77
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2ACE280E42
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDC119F111;
	Mon, 23 Sep 2024 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Em40Ubmk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316DF19DFAC
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727109935; cv=none; b=ZCfK71VODUR09JwtGpdTRQaIJhvfDq6jTFK0Y0E4aVJs2OKANra1WN/ctWVUKptDlaRoolzpN0kLMZ2Nl3KaPm+TPZOMx0xjckcrMbaTXLdC7d+E/gS+eWp66PPn+lqfLnqbojTo2qcAiij1vFgXRrfKQpuv/3RK9lnOq9gmszA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727109935; c=relaxed/simple;
	bh=6GrFAUHlhUrOwzWudLfrmiqRAsjUtub+5CEd/7C9VB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=qwdl7Klgkb4zMvvoRp9Sa8BAbyEG2o4NG0tE1R3e+TWyU7uD7NaWe/OCEvqfhVB8ACVQDnwKcZk/TNoyEvQy7zC4x7jocyx45yVnSByVu7sT8VtsG7QbikqJU8KDDyJnIz/YKAVP+CW1BOGQvSQnAAjCaBNFyc08jW+Hm4aOvfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Em40Ubmk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727109931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O76AhB30S4wPpdyvW6fZEhabdML/sWlePUECjHRI6PU=;
	b=Em40UbmkBHVyrA4VDW3IwMcav7C7cHQptJm/kz67WJjXmRhqPdc45CC1NxdoUQUhxhD506
	/6ssVL2/pgC0I1FrguUB1k11kr502wGoJ/xfs1JyoYh7hTjf/Vn59zLBRtkxBHDxphNgJH
	yqEiIwZzTUxVa+ZxYaodZavckkYIBnU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-Uu9Pc5kRPfWQuqIkuVyB0A-1; Mon, 23 Sep 2024 12:45:29 -0400
X-MC-Unique: Uu9Pc5kRPfWQuqIkuVyB0A-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f75ec1ddb3so32444281fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727109926; x=1727714726;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O76AhB30S4wPpdyvW6fZEhabdML/sWlePUECjHRI6PU=;
        b=u644/fPniU/Lrhwt9H1zpkNS7YpoU3/1/RHtz91XAIMrz5ZoVagnZTb2WPg99B6LAJ
         9Ouj6Iq1DNTdseAsC0gvWfS74EbPuK7DbZO5NwL07YdEtfzMgiA7Y970gUyszHst2OYg
         8yrCbZZZZxsq6wgQ9xVaI4YoT8+SBGuLZ3j3vX+B/ObdaGA+4npPSAl8OqviFhScQOWy
         iU0ukxzRiIyN1EYrPMTs5XbUF4bQqk/vIZup8h1yszLPub+zVhQjFKdvyZBP43Qa7bN4
         DKwrpLudpkepV29mn2B5+nA1MM47jnSeGUbcONZesgeGU+VO1pxtQZPiNME12pfPYIYT
         CnZg==
X-Forwarded-Encrypted: i=1; AJvYcCWlNv4ud7WU2EwLITrxnk3wB4u9Z3oVUfYg4eUhOjFeasU530F7+M/pM6iII7UK9wh9L/Ou0/jQ35Vr+Us=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3o5pjOx7HNGXI2ToLXdTbP972FKixiOxZUn5tMGcjkM1bOJX+
	48xdlq07Tfe0eDWzp5wEzkK4L69AQIjN0hdm5QHeHccgLY7MKb/SiI6CaJafpXHl4MjzBNQE8MT
	jrqNhMh+jhQDdAI8o/ZjQ7irUgSWYN+8PGWnF+GUWKyWvE/kdK3iWay7JOAbBAuKxzI+bP36qYS
	K6lZnujq7KlDiFzJwEQPmV/03ZLktqk2naXRRD
X-Received: by 2002:a2e:9e04:0:b0:2f6:6198:1cf9 with SMTP id 38308e7fff4ca-2f7cb358243mr61552971fa.31.1727109926419;
        Mon, 23 Sep 2024 09:45:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiyA1N6elR3hp72waVhYhvpSMPm2k5BGY+OSAIwggAccFlio4y3w50YN4nXxpaBwct0dZ0io1mGt8UBCZjIxs=
X-Received: by 2002:a2e:9e04:0:b0:2f6:6198:1cf9 with SMTP id
 38308e7fff4ca-2f7cb358243mr61552621fa.31.1727109925493; Mon, 23 Sep 2024
 09:45:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724142253.27145-1-wander@redhat.com>
In-Reply-To: <20240724142253.27145-1-wander@redhat.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Mon, 23 Sep 2024 13:45:13 -0300
Message-ID: <CAAq0SU=MufS+j+T_AN01Pvy4WctmB5wEG66F4VfN3_ZoqDYm9Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] sched/deadline: fixes and improvements
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 11:23=E2=80=AFAM Wander Lairson Costa <wander@redha=
t.com> wrote:
>
> Hello,
>
> This patch series addresses specific issues and improvements within
> the scheduler's deadline (DL) class. The patches aim to fix warnings,
> remove redundant checks, and consolidate timer cancellation logic for
> better consistency and code quality.
>
> Patch 1: Fix warning in migrate_enable for boosted tasks
>
> Fix a warning caused by unnecessary calls to setup_new_dl_entity for
> boosted tasks during CPU migate_enable calls.
>
> Patch 2: sched/deadline: Consolidate Timer Cancellation
>
> Consolidate timer cancellation logic into dedicated functions,
> ensuring consistent behavior and reducing code duplication.
>
> Changelog
> ---------
>
> v2:
> * Drop patch to remove the redundant WARN_ON call.
> * Change the "Fixes" tag in the patch 1.
> * Change function names in the patch 2.
>
> Wander Lairson Costa (2):
>   sched/deadline: Fix warning in migrate_enable for boosted tasks
>   sched/deadline: Consolidate Timer Cancellation
>
>  kernel/sched/deadline.c | 45 ++++++++++++++++++++++++++---------------
>  1 file changed, 29 insertions(+), 16 deletions(-)
>
> --
> 2.45.2
>

Notice there was a PR from sched a few days ago, but this patchset was
not part of it. Do you know if this will be added later in this
window?



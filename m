Return-Path: <linux-kernel+bounces-356591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471AC9963E3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06DD22881CE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A6B17E019;
	Wed,  9 Oct 2024 08:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0lbCzn4i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/6HCSPr+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80883152196
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463825; cv=none; b=RGO1plPmJj7hSEUIiNWw961bI6mcRQ21BwF9WsO8pLYasQtZlG5nx3ywd3CXVXv31xPHV05EstwnURAaHRzK+13xlcqBEJdgKdM3CZrHkkLppfXgmu005tvKaoVv2VqW7Pze87nC1bJDNJj62k79ygHKH8eteaIQmD1lGEGDv3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463825; c=relaxed/simple;
	bh=Gj8T7GAviqnd9TLTsnW46gb58EIl1ZqSSJUWSQBE8Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiDrWx6hG5kxK/JL+5WWB8vcz//tBNZ2UJ3QXEeVvb0TLiCdb/W0XDmpe2QxDbS4Ivxi57v/HwitvLG7PDAgqbbHSROJ/Y/SVtcLy+4Vqf15ZnlA08Dl8ZxLNAXwnYtGqw9YrAUo242MflUW/OkOuXsVtO9s9+tpC18p8E1amwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0lbCzn4i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/6HCSPr+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 9 Oct 2024 10:50:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728463822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BF3j4zKCuUyfQKPQeIihF2R7tVndLQx9MfNFtEf2i1s=;
	b=0lbCzn4iwrEyidgiQ4o5HBZbxt+LNSBvnCdhOTG9pvkukbvrGB3VovfEuAkkKxDNovZOLu
	tKddSNhi6uyYjY1JR6loLmoh3FlNPvQZHRdYSkethuWe+Owxu01/5nW+hgJgPxYmkoNHtH
	O8bNV1V1eBq7OeBeR+YzDsXSsf/wNu7uWTC6fNKGzXDRkhPxMVcV4Z++5S9oCaHFk3UMsg
	AKKKIEBKZYdEvWJh0pUsJ9eBT7fAQfWtkqMlUwa7WPAtDVTKcgIcfKQuwKpkStZTKAkfgF
	aXjqUMJaGgUqwI4xK7XDTCv0EvClyG1wUb1O6UkgtEtdnUr4iCMUEj32WXXW+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728463822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BF3j4zKCuUyfQKPQeIihF2R7tVndLQx9MfNFtEf2i1s=;
	b=/6HCSPr+/f3Dv1XzrfpKQcP5BbBbFyRG4AAgd1zhg9buwQ8IX43rEM+yaGqmBC/vOrZo58
	V7og2KTRrIBP8jBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, ankur.a.arora@oracle.com,
	efault@gmx.de
Subject: Re: [PATCH 2/5] sched: Add Lazy preemption model
Message-ID: <20241009085021.cw9147B8@linutronix.de>
References: <20241007074609.447006177@infradead.org>
 <20241007075055.331243614@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241007075055.331243614@infradead.org>

On 2024-10-07 09:46:11 [+0200], Peter Zijlstra wrote:
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1103,6 +1106,32 @@ void resched_curr(struct rq *rq)
=E2=80=A6
> +static __always_inline int tif_need_resched_lazy(void)

The naming is a bit confusing here because tif_need_resched() checks if
the TIF_NEED_RESCHED is set while this returns the proper TIF bit
instead.

> +{
> +	if (dynamic_preempt_lazy())
> +		return TIF_NEED_RESCHED_LAZY;
> +
> +	return TIF_NEED_RESCHED;
> +}

Sebastian


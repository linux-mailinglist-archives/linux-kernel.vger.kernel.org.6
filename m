Return-Path: <linux-kernel+bounces-263566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C0B93D7C4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112921F2402D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910F417D34A;
	Fri, 26 Jul 2024 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GDN9EBUD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GEKhJMRA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904791B970;
	Fri, 26 Jul 2024 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722015784; cv=none; b=tOQT4VeV4QWU4I3LJCXtP/h6xu0DXcrOn8hk3mQUNTQRati88eyiR2VxwC4KWodXQzBVwhUxRZnLq/irBFZZjTfoknEB+UReNHHmul0uDW388LUT3e6Fgo0p3gUqNCzX9zgU2ZkdbOxQ8OoUdsk3M18avctJlMqUBjcF6PUWXkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722015784; c=relaxed/simple;
	bh=B2DD5q9DFmBoMoGKYCemOK64ZHvWE6L/7I+u6wFqKT8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S/2HRCVXIGgtsfyVUTmuueQp0EK0Gzjh9q3MLlEBKmoI2GheZsTm65vHfPbId7jH4nYr/PF5Nc9SQsM8yJ+OOvsTjKl36qtsXIvkocPMlvxYY9MuelFq55JYvHvDcQFedAWezy3qAIGE4US3jDFS+AANcI2Anfk3yTgvm/PYLTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GDN9EBUD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GEKhJMRA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722015782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B2DD5q9DFmBoMoGKYCemOK64ZHvWE6L/7I+u6wFqKT8=;
	b=GDN9EBUDhJkHhETXngFu+pjPabMOPQ65mEFmz83+bC0OSHHwy68cZIy7xMWjWZmF9Tedsy
	MGSn2vBXuLUjFoEJdUvn7wHNAa6WfCjBVmeBhTYKXudJx/HgBRYaR7oOXcdDP6tc1TxIMA
	nPVX5Xz7fewy5+5t42wliSWIv6aazfy1HR4o27srt/kjXJovbSwOYfl7/3vcNVtFk4rS4O
	XkwGIiSG8DBytVkEBMubP8oYElwx19Otgm6OgWZHn/9AQ5sJZCmp5YPsfUlmvjBGygLmag
	CdsRO9Fx2kN4rYWKZq2UanOCy+imcUY2Ve6b3sb0+NvchK94u+SSTcyEFbTlFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722015782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B2DD5q9DFmBoMoGKYCemOK64ZHvWE6L/7I+u6wFqKT8=;
	b=GEKhJMRA4W6FK7x5XhtMWMfjl5OMvjSNH8//TIaAtoCd4IBIirlMJvzSkv3Mjt1OM/SdT9
	YwZYCco32o/jTbDA==
To: Valentin Schneider <vschneid@redhat.com>, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Neeraj
 Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v3 02/25] context_tracking, rcu: Rename RCU_DYNTICKS_IDX
 into CT_RCU_WATCHING
In-Reply-To: <20240724144325.3307148-3-vschneid@redhat.com>
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240724144325.3307148-3-vschneid@redhat.com>
Date: Fri, 26 Jul 2024 19:43:01 +0200
Message-ID: <87bk2kuk0q.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 24 2024 at 16:43, Valentin Schneider wrote:
> The symbols relating to the CT_STATE part of context_tracking.state are now
> all prefixed with CT_STATE.
>
> The RCU dynticks counter part of that atomic variable still involves
> symbols with different prefixes, align them all to be prefixed with
> CT_RCU_WATCHING.
>
> Suggested-by: "Paul E. McKenney" <paulmck@kernel.org>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Acked-by: Thomas Gleixner <tglx@linutronix.de>


Return-Path: <linux-kernel+bounces-430439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 503FA9E30DF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E30B1B27420
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8359D2629D;
	Wed,  4 Dec 2024 01:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="A48Dgzqd"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C5F17C60
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733276551; cv=none; b=JblcCJGp4b7EmaeUTxAQBl7xtgJacnpbEZU+tvnmtEcUaDlcYesQdtk2ef7bPbdBuKfmuVxlTeKO8wiFLszLPIlktlcDfxAZPSSOpDndenYLvpi6b/c0aEtTU7rYQ5XnyPonAxhnHLGgFl4p9Q4NkObUc5fIthYSvcE1DXCCZ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733276551; c=relaxed/simple;
	bh=pg0T1H8ztOUB2019Y9lY7gBh9ApUHJWcAF6hK7zNC4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mxq6s7OorN87VtCZu1fRdsobw+Ri9WHgxKmuI+n/6dYsKgGNLw39wSTC6TWa/E72W2wb+KBtVNF2OSCRrcHMpbuI1oRINmJ2GjGoeBlxQ953Tljh2sM9oQ4G/zm3c02a+KFrbBfXW1GLTiadsZALTlJdTRHGH2+KtqwNBsiI7ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=A48Dgzqd; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GsUTXgPa24hrvw610ndLUilvD4R3wh9tUrRY9MzxmMs=; b=A48DgzqdAu4C7eUUccFyjhgTCJ
	MOtM/qS6aGBX7iNCZc5hN56/V3NgNv2sY32gHNm1qaQDmIUMhfv0QZGWWeoS5NUKBLGV+DH9Vd6yw
	/2zOfZo+w9P/fUtW9Jb7b5nBXo/aeOPfeWTx2ZQAa35/B1kzZVzIxfp5lHSLJtbg3i7AUg/Lowex/
	vXBvyuJwUzHJa5xwXMGRj6TB10o7bJsJKwPE1xdqACPKnNNdolIemMEcQ9C6YYr38CennDOgswP1o
	uHAkqfDjrTxaZPVtBZv1vmhFYKNIJ/cajqM3XkRdt2O4ykOgppLOP/hYLdNEaNR8VPDvs6p7uKOYA
	KtTbBfyw==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tIePD-00GI1E-E5; Wed, 04 Dec 2024 02:42:19 +0100
Message-ID: <ea78741a-09d6-42b6-b106-9fa5a54ed0fa@igalia.com>
Date: Wed, 4 Dec 2024 10:42:13 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] sched_ext: Manage the validity of scx_rq_clock
To: Tejun Heo <tj@kernel.org>, Changwoo Min <multics69@gmail.com>
Cc: void@manifault.com, mingo@redhat.com, peterz@infradead.org,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org
References: <20241203142802.36305-1-changwoo@igalia.com>
 <20241203142802.36305-3-changwoo@igalia.com>
 <Z0-TiGC5eUg4ZMWT@slm.duckdns.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <Z0-TiGC5eUg4ZMWT@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 24. 12. 4. 08:26, Tejun Heo wrote:
> Hello,
> 
> On Tue, Dec 03, 2024 at 11:27:59PM +0900, Changwoo Min wrote:
>> An rq clock becomes valid when it is updated using update_rq_clock()
>> and invalidated when the rq is unlocked using rq_unpin_lock(). Also,
>> after long-running operations -- ops.running() and ops.update_idle() --
>> in a BPF scheduler, the sched_ext core invalidates the rq clock.
> 
> Hmm... why are ops.running() or ops.update_idle() special? ie. How does
> sched_ext core determine what are long-running and what are not.

I investigated all sched_ext_ops. Besides these two ops, all the
rest are control operations, of which BPF operation should be
relatively simple. On the other hand, ops.running() and
ops.update_idle() are different from the others since a CPU
executes a task or becomes idle, which could be arbitrarily long.
So I think refreshing the clock in those cases would be nice.
Does it make sense to you?

Regards,
Changwoo Min


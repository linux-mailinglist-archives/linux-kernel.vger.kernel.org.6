Return-Path: <linux-kernel+bounces-448100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C49D9F3B14
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4415B18879FE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C961D54F2;
	Mon, 16 Dec 2024 20:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TbOM0Wao";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OlYOeBqe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E94D1D47C3
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 20:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381707; cv=none; b=cbUm/FkQUzF4kTUbZ0SPsBbZBdDY8Ytqh+me0ctcH76tU1MGipPS7BfzwvdBe1LPB84X0qvY4/NJ+Htsl67qnUV7QsvIoP04U/hGxWnDi1x9tpzlr4Ww6RZf20yFnVLy0jlZypW9K5KzOfhhlG2g2VQrJDL4u+7qjUVtOmG66eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381707; c=relaxed/simple;
	bh=2Ha288fDiGfbslAuZxDG5H7b6xzxlTEwi3JM5W7nbJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZMajYdpyT54pafZN8v5cW/BRcCsTMaShID0oZK2gKc1G2Hn6pZMgqh/QQ+2XrY+M7sqksBg7OL6Ci9hoHgCGOA07j5Jx/PxAWw1L2sqfUWJrfTKfoKNDurEtwSGqjly/Wmm0qJvYpPjyKzpT8rzbYjrwbIumEPdzu/+t3voriSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TbOM0Wao; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OlYOeBqe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734381703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xpHqeRSEScLoZvrRCvKzeXjOH12h5YIBSFQ3WbtPRMk=;
	b=TbOM0WaoHcOCyil33Uodv/hrQLdnFsaGlO/brYDIz0tbIyVU1RcY4NOk2aizvM0QAZj5ZL
	JoC92tKOfD51+EKO3+9NPOZ3eTnaA6LKsIEgofSo0N6VObulrOz3IIU6z+iHxB73TFq///
	I+WFiV2sklUNO3oz0kk8D++33xPvk0fNySgU/ZCG7EykF9DAbCWl/tqCLzEd+9SvDmZag8
	ze3FtOL23A5Sis8MD/MGd7L3Hp9knGoG6TAFvjCXdcsyI0O7QUJlQ4DRY1jFMSRNKNkJKI
	yI08h/CYypTCKlGS2j/K+xiJ0hD649OniDLKfBdMW/BCw2Q8DL6HhTO91IA+uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734381703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xpHqeRSEScLoZvrRCvKzeXjOH12h5YIBSFQ3WbtPRMk=;
	b=OlYOeBqe/AF4ABePZwAWKrkcGt8h0MnzZP2I8vpriPr97JsHog1+I0CJQw24GVdfs7ePKB
	4IEBL/gdGDqqK3AA==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Valentin Schneider <vschneid@redhat.com>, Waiman
 Long <longman@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH v5 07/14] futex: Move the retry_private label.
In-Reply-To: <20241215230642.104118-8-bigeasy@linutronix.de>
References: <20241215230642.104118-1-bigeasy@linutronix.de>
 <20241215230642.104118-8-bigeasy@linutronix.de>
Date: Mon, 16 Dec 2024 21:41:42 +0100
Message-ID: <87ttb3743d.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Dec 16 2024 at 00:00, Sebastian Andrzej Siewior wrote:
> The label futex_requeue in futex_requeue() and futex_wake_op() is jumped
> after the lock is dropped in a retry operation.

The label is jumped? 

> This assumes that the hb does not need to be hashed again. If hb is
> resized then the hb can change if the reference is dropped.

Again 'hb' and the confusion of hash bucket (hb) resize.

> Move the retry_private label before the hashing operation.

The overall explanation is not really comprehensible.

    futex: Re-evaluate the hash bucket after dropping the lock

     Sebastian Andrzej Siewior wrote:

     In futex_requeue() and futex_wake_op() the hash bucket lock is
     dropped in the failure paths for handling page faults and other
     error scenarios. After that the code jumps back to retry_private
     which relocks the hash bucket[s] under the assumption that the hash
     bucket pointer which was retrieved via futex_hash() is still valid.
     
     With resizable private hash buckets, that assumption is not longer
     true as the waiters can be moved to a larger hash in the meantime.

     Move the retry_private label above the hashing function to handle
     this correctly.

Or so.

Thanks,

        tglx


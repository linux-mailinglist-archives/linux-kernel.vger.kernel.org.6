Return-Path: <linux-kernel+bounces-262358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D75893C521
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47E491F24BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643B919D892;
	Thu, 25 Jul 2024 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUr0/ST1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3585A19D09A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918850; cv=none; b=RaEDRZsRsxHLHN/MA/Qo8cxm7x44rsdrpleCP4PX46N8h+DnVvWzA/+ul75xoLgf3nB6zDGlQo8LZuEHdqsuexn768DE3jySY3UAWl01zTkhVVsijA9HszD3jaKD3lQimt1mECS4D3j2eR/ryvqJxS15aGGWinBcAa9k6oQQIqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918850; c=relaxed/simple;
	bh=QnER8odTLOmeL5f+urUHq6SnfROq/GUN1kFA+FI+lYs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=euSJT3IvzBD62wMDXp/ucYIZFoDpoETYQrH8BIjYgm43eKOclpHbkBdxhJbJTVY8oW8OyZq/h/w8IcQLLkL93GlgMUuC3MbRiH35E3z19IXoK2L6j7ofW8No97n07Ht/grhGsZjzrxJeNNLvX9PQ0gx4fqrlrPNyPPxlEe3zF8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CUr0/ST1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721918848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXyZO9/KMzTlbY41LF3SQxG+wYDU6IMhQ0gKwsrX1JA=;
	b=CUr0/ST1itUL5gx9SBaDnZ5vEHa3yQYNxzfUfDIbtZV3A/FiPLhO6ex5gbSffR3dUYaMpk
	iWtISmIStJ3tuipsbZJvojkYZKkx8XuwZoEToS0zIenhDQcNy5gEf60UAYQOLGnRb8rxWh
	RxbkODEqafvtaOHdZae+qZy/VrHcbD4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-coOGwMKzMfW4NM3Zd0qbLQ-1; Thu, 25 Jul 2024 10:47:26 -0400
X-MC-Unique: coOGwMKzMfW4NM3Zd0qbLQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-368442fef36so734106f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721918845; x=1722523645;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXyZO9/KMzTlbY41LF3SQxG+wYDU6IMhQ0gKwsrX1JA=;
        b=NkImCp7zQx3DIfJL+tdrDrRvFRkh5qUAmw4vOsQ5jIvlT/RJiFuvWGRZcrAnOUq4U5
         o0aKTb8EFSyV3/S+2UlG2jblA6W5382JAU4DhuDOw7WoYFHFR+CQUiE2e3V2qhunqxRy
         CpVI+yFWs4pWXH0UepsnCes9nAAsgJGhQXUx+oHalrQn/nD1xvXl0axPOvpbI7vATgL/
         ITWj9iz9ILJVeAXobDxaY8s2XlGwL7UmmVUhfWOw0BQJsqCKY1zdB2hsiI60UTrIm+lY
         RPtjpyWpToNGkS3O7pnu0wSg8tB/vJtCEHaut+X1f03wK3HU6jCh4HjSWcGrUwmAmA+r
         bAaw==
X-Forwarded-Encrypted: i=1; AJvYcCUD1qRDWVyu03/lTd435fSm+59tO9YKD8e1jlj562TctZPHPo3X/WKwu8NeN3RgDTzw2aIE4m5EY98ytZoHe2+rArVT6szgSdCPwxHH
X-Gm-Message-State: AOJu0Yztl9xHsYHoXPKzs2k68ZvARQFJB96X9f7VdXxgpKeQapun7UL/
	FtyU+hs7zL1gA8bKDF9RROlRJZDyiXUmv1vX0elM1kvlkhAQDF3aczUXRxsRjRpLdHJYqc26fwh
	jZtZoYMrFGTUHQpKl98isB0seBbfercnuxlYyqSLxoaRjhOOtHKyyx6PCAB7ALg==
X-Received: by 2002:adf:fec6:0:b0:367:9114:4693 with SMTP id ffacd0b85a97d-36b363d6995mr2433663f8f.31.1721918845616;
        Thu, 25 Jul 2024 07:47:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY7SCU7fqeXp6yE3DeJg2PdjZIcxm6VAqEtOFCslLYwHBG2stEnSHtd13fnU4rlruOM/8JBQ==
X-Received: by 2002:adf:fec6:0:b0:367:9114:4693 with SMTP id ffacd0b85a97d-36b363d6995mr2433651f8f.31.1721918845322;
        Thu, 25 Jul 2024 07:47:25 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367fc7c3sm2427349f8f.49.2024.07.25.07.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 07:47:24 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, "Paul E. McKenney"
 <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Neeraj
 Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v3 25/25] context_tracking, rcu: Rename rcu_dyntick
 trace event into rcu_watching
In-Reply-To: <ZqJHeTE52cn1-4p4@localhost.localdomain>
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240724144325.3307148-26-vschneid@redhat.com>
 <ZqJHeTE52cn1-4p4@localhost.localdomain>
Date: Thu, 25 Jul 2024 16:47:24 +0200
Message-ID: <xhsmha5i5zfyb.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25/07/24 14:39, Frederic Weisbecker wrote:
> Le Wed, Jul 24, 2024 at 04:43:25PM +0200, Valentin Schneider a =C3=A9crit=
 :
>> The "rcu_dyntick" naming convention has been turned into "rcu_watching" =
for
>> all helpers now, align the trace event to that.
>>
>> To add to the confusion, the strings passed to the trace event are now
>> reversed: when RCU "starts" the dyntick / EQS state, it "stops" watching.
>>
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>>  include/trace/events/rcu.h | 16 ++++++++--------
>>  kernel/context_tracking.c  | 10 +++++-----
>>  2 files changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
>> index 4066b6d51e46a..e51ef658437f0 100644
>> --- a/include/trace/events/rcu.h
>> +++ b/include/trace/events/rcu.h
>> @@ -466,40 +466,40 @@ TRACE_EVENT(rcu_stall_warning,
>>  /*
>>   * Tracepoint for dyntick-idle entry/exit events.  These take 2 strings
>>   * as argument:
>> - * polarity: "Start", "End", "StillNonIdle" for entering, exiting or st=
ill not
>> + * polarity: "Start", "End", "StillWatching" for entering, exiting or s=
till not
>>   *            being in dyntick-idle mode.
>>   * context: "USER" or "IDLE" or "IRQ".
>
> So that should be:
>
>  * polarity: "Start", "End", "StillWatching" for exiting, entering or sti=
ll not
>              being in EQS mode.
>
> Right?
>

Yep that's better, thanks!

> Other than that:
>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>



Return-Path: <linux-kernel+bounces-356523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 369F0996295
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4EAC1F2338B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5D338DD3;
	Wed,  9 Oct 2024 08:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R23PKmqX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84F117C21C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462549; cv=none; b=elQulaU16L6SP453uulLA5ZGSp1qKwdSLmxDZFIh9IIQaoJuK38ZK/d7/Gvj+oU4iIOIehF1gh4ir3szlPCBloPr8MvDw+Okb7fNnYyLA7eb0jtOQ5VirHqURLOPvE8/KHpGteS3OTN98AjE7zp6oyu3Ws+jhctxjvZLVFNjatI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462549; c=relaxed/simple;
	bh=6Z9HdBLhA6aRVoIzSoRahQ1izErTexQJRM+13vRShlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ud6HrnW0MXfp/m4kfgMqxa/q/HyFtxoqdkY9SNT5Od3IVjMjeVeWk+KjQwVmBiUmVSi57yvCHvsjvmngx3akS3MH5pQCzVwtFhrtEQdsU27q+3e+UwTVAG7b0JLanjquNKAKm0KB56sn+Z9MzUdxOK+BQzYtmh/nYD9jWC5gOVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R23PKmqX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728462546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oI11tob+UZ2c2xTTRPXBNrTjqLa58MTZYOQ634//e9o=;
	b=R23PKmqXzLozwP9Oy+QAVFG+TbTOeE1GlVavmxdWs2hMGP+NdEOPIQZ3lLPjO4BV8xk3g/
	86z7FE6NENO5kbmyw1UdXaWfBG/4Yvh7KXzOty18byOnTAUyqw8RBEM7a1asLqTQC709Il
	NMhRAnZazjNQN/mF33/d7UCp4YkCSZw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-LcXcleyMPfWq5BUXCJDdzA-1; Wed, 09 Oct 2024 04:29:05 -0400
X-MC-Unique: LcXcleyMPfWq5BUXCJDdzA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6cbc8060744so14878536d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 01:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728462544; x=1729067344;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oI11tob+UZ2c2xTTRPXBNrTjqLa58MTZYOQ634//e9o=;
        b=rL+I6pOmWP6QBPYUVxf178LZMGMNRLiKpnqGohDBlhNoFAD0CRcwlz0ZEdopcX7dY0
         dLRLiwS61sTa9Ays2AhTw31GhXVQeHvNseQwQJIWVpbHykF4iAFj8E0Oq0sIZPlv4sWC
         uP7cmbV2Z2grssEeONgjTzA6HnPiT3xKqHCrJLFYK7Qxqb4/F+37cCCytKV1YxtzMhj6
         UIbQ3IGv55WeH8qb80CNeZ0XCwXEUzKzmvfVxRs/lspnrDYRPTFAU9MfDDGyjuAbw5SQ
         eMAwzPalS8T660rfZGkhmnzyERndMoFmc3Pt0gn+xjzXyrHdpgKAP77dKFE42Ew8Uc/P
         Zfew==
X-Forwarded-Encrypted: i=1; AJvYcCXJ3Lhw2U4khGn2NVvzgByhXcGDN6nN300zrv636cXPk2N+rNB++QC4XUdHZLJY02tGUJ12uUZf4N66WTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9mc+nrl/ZZpU/NY5OqA5n6+RvMv3iwl72D3f083JDY8hvT7aa
	TM++aPGwezdFg5RK07ZkJpqRCeQyfBiRDwYILSVdysZkAlmctmun4h98FH1wwyHynOGx5O8T95f
	dH0g2okaAgjICVK4uJSbeSlHMI9W4UI3T81m6aGUQNi/9wel2v2/RbewTLGrt5g==
X-Received: by 2002:a05:6214:4287:b0:6cb:bfb5:6fc with SMTP id 6a1803df08f44-6cbc9329f35mr27806156d6.25.1728462544181;
        Wed, 09 Oct 2024 01:29:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy/d5kOlbTbSnAt+rUIOozCwkfUFVh0rGvwRdShbsXP/G+rUWWR+snVmksK2/SiBifoqrkpQ==
X-Received: by 2002:a05:6214:4287:b0:6cb:bfb5:6fc with SMTP id 6a1803df08f44-6cbc9329f35mr27805956d6.25.1728462543875;
        Wed, 09 Oct 2024 01:29:03 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-206.as13285.net. [80.47.4.206])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba47513e8sm43835386d6.75.2024.10.09.01.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 01:29:03 -0700 (PDT)
Date: Wed, 9 Oct 2024 09:28:59 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Futex hash_bucket lock can break isolation and cause priority
 inversion on RT
Message-ID: <ZwY-y4h7LruimB0O@jlelli-thinkpadt14gen4.remote.csb>
References: <ZwVOMgBMxrw7BU9A@jlelli-thinkpadt14gen4.remote.csb>
 <b77b8a52-7b53-46c5-bece-621345fdd4ba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b77b8a52-7b53-46c5-bece-621345fdd4ba@redhat.com>

Hi Waiman,

On 08/10/24 14:30, Waiman Long wrote:
> On 10/8/24 11:22 AM, Juri Lelli wrote:

...

> > Now, of course by making the latency sensitive application tasks use a
> > higher priority than anything on housekeeping CPUs we could avoid the
> > issue, but the fact that an implicit in-kernel link between otherwise
> > unrelated tasks might cause priority inversion is probably not ideal?
> > Thus this email.
> > 
> > Does this report make any sense? If it does, has this issue ever been
> > reported and possibly discussed? I guess it’s kind of a corner case, but
> > I wonder if anybody has suggestions already on how to possibly try to
> > tackle it from a kernel perspective.
> 
> Just a question. Is the low latency application using PI futex or the normal
> wait-wake futex? We could use separate set of hash buckets for these
> distinct futex types.

AFAIK it uses normal futexes (or a mix at best). Also I believe it
relies on libraries, so somewhat difficult to tell for certain.

Thanks,
Juri



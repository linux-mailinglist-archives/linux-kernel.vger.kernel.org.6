Return-Path: <linux-kernel+bounces-265289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E7893EF13
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70CA7284175
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA8C12C559;
	Mon, 29 Jul 2024 07:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekO+rTCG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA2084A2F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239609; cv=none; b=SrZ/gY1+E60mZBJuol0VJT9aJOpl9Jd7SZPWilnsfFaTyvHVy5ctEfQqzGB+ukceIPB0VzOU6JzSHazlIY/vTJyif6uae10wDwrj1uL0vhZjNWiO4QjzYTnbzW09gTPc88nXtE3aFKgOKOWl/tJpD6bTulWL/FLCOW0Z1fEDiis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239609; c=relaxed/simple;
	bh=djJ8bv6B3o2BWURSSbOIYbI176vAVEVIraj+m0nNCdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntzUoGrZtjle3T8fIQ/w1k2vL6Nwgp6Hh17TkZ223ebKbrlO97Bo612RuqePhAKpDRf2as6PDn8Q8MsTr3oR38iWrtx2GbGz75kTD9gU+70UA9hYHc9mIZBMohRm6o637jOr1JDXjABMeKMLaN33eeRPuOizDgWzWEe0alv5JDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ekO+rTCG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722239606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=miXFg3fSSeF9GpHYpHbEquk4tJbMcuQvMoXeh3BnNK8=;
	b=ekO+rTCGa55OjPvuSm61Qo/LObqSIakAXXgRpSwF84vMu81fq808tjFI2VCDA+MC5QMCDS
	kw5SU2hbnt2yzwgG9Y41H9o96F9uHiYX5n/IOqS5o/2W5UjydQzYZECGKl+UDPbUEDMbHg
	vD4gFrGrEgpSqd/g8QRK6obziD85ld8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-w-Z1958ZMkaXE43pHRzmWQ-1; Mon, 29 Jul 2024 03:53:23 -0400
X-MC-Unique: w-Z1958ZMkaXE43pHRzmWQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ef2b0417cdso31146491fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 00:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722239602; x=1722844402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miXFg3fSSeF9GpHYpHbEquk4tJbMcuQvMoXeh3BnNK8=;
        b=QtNC/6OdNZEB/gt/XASqYrj6AGpjHuLyaZPsLjjgBToIedh4ypZDdCG9GqENr033UO
         X/4Bh8oRPksBfFBocKVLGVCgCOcOZxTV9ETqO6hzdID1W/Ten0S9diULCNRfvDqgBdie
         2YrCmwvbJeALTkJSEnSfiNaIXyU/ftH9YgHEj1jsSNNj6OOKBoz1agon//Nyyh5zeJy3
         O+0ccWwskXiGmr7n4wzUdtd/EcaJLII5H7K504AHlYspceyyCHa83fHOq56xK4IU8RKr
         U/p9oBm8wYLxLWmOAxRNINXmXrU3H2rNNnuMRJVuHjScmcF0iCoOg5R3eTWjsPUQZylC
         i/aw==
X-Forwarded-Encrypted: i=1; AJvYcCX+s/JFFbWBOLCMkp7DLNQw7AF1Jamn9KaQNEfwZDfM7wmRAp1hIbCMcgJfXfeykRNGeOHE/vsVfiiNuU9xiSDPpHUw5FR49sOclv/B
X-Gm-Message-State: AOJu0YxWrSvomGTZGSL5bXG6cPK77Z7ZZUyvQk7/U8RU7FIKckYSN+/t
	/EWUBAZJa85c3eDM+pzMDbsoOHf5CgfqVvJc0vTAybbfDh0/NgPRdUWH4r0gCWm6o4cViUCUKos
	KPIRSJu+MXSK9JmVE3NDf6ceLPNHbwvY1ZgjPUOQEYjdxIJvxEbtHz5DYYLLMLw==
X-Received: by 2002:a2e:6a02:0:b0:2ef:243b:6dca with SMTP id 38308e7fff4ca-2f12ebc97f6mr43256251fa.10.1722239601991;
        Mon, 29 Jul 2024 00:53:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb8wjQPEpjzMTvLEdSQRcfJjCAZWXeac8pgHmwVQktE2FDMCVGIrNpuIDCbph1DU+lIHxR/Q==
X-Received: by 2002:a2e:6a02:0:b0:2ef:243b:6dca with SMTP id 38308e7fff4ca-2f12ebc97f6mr43256091fa.10.1722239601580;
        Mon, 29 Jul 2024 00:53:21 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.19.246.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f937348bsm209518435e9.18.2024.07.29.00.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 00:53:21 -0700 (PDT)
Date: Mon, 29 Jul 2024 09:53:17 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [RFC PATCH 24/24] sched/time: Introduce CLOCK_THREAD_DVFS_ID
Message-ID: <ZqdKbcu-iyzmr85r@jlelli-thinkpadt14gen4.remote.csb>
References: <20240727102732.960974693@infradead.org>
 <20240727105031.053611186@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240727105031.053611186@infradead.org>

Hi Peter,

On 27/07/24 12:27, Peter Zijlstra wrote:
> In order to measure thread time in a DVFS world, introduce
> CLOCK_THREAD_DVFS_ID -- a copy of CLOCK_THREAD_CPUTIME_ID that slows
> down with both DVFS scaling and CPU capacity.
> 
> The clock does *NOT* support setting timers.
> 
> Useful for both SCHED_DEADLINE and the newly introduced
> sched_attr::sched_runtime usage for SCHED_NORMAL.

Just so I'm sure I understand, this would be useful for estimating the
runtime needs of a (also DEADLINE) task when DVFS is enabled, right?

Thanks,
Juri



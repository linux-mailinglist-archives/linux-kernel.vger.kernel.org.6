Return-Path: <linux-kernel+bounces-277599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F14F94A386
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52CD8B23F9C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D961C9EC6;
	Wed,  7 Aug 2024 09:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ar6bqeTK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB37198E7E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723021238; cv=none; b=onMOyOgvm5uRAN27c6d9rA1EuxW5QCkMLRIV4AsVIgPxAUjLXlePI2u/IjJqRIjGNN5q/ug4Iy/SKFuAR6u9RLzP+yZfN6beczcpJxXawgNf5xZ8TBeIxpvKrX7tpWo/SQXGZJIB5XU+pV6TLLoAh9m187pi5MO+9a/L+douoo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723021238; c=relaxed/simple;
	bh=RL1np96hA9bgA6SursxGme1l83B1rvSb6HtO+BeRiqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKmu0oGpdSTs1N6IpKxAg2BAUwcSpPqgNQWzmhRTAMyF94l9Mjv93uD2hOMG2sBvow2VdZcC4uaNd1SGux2bCIPRmot6nHSRPj88LkCcFCKFHwrX8yzr2LwSphc4j1ypiw8CeZa+RmTPx+217+4t4OrM5w00HEiAh4AqHknof0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ar6bqeTK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723021235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+7TSMM7RSCrnhwAsQiYVaNQicw+vwD/1jbD15fLbhD4=;
	b=ar6bqeTKnZZLGpekyhr9op94mIjE4bwqEXOC1k7t9ujdS+m8eeW8s4Dp2NJ7LR2Mb+XPMz
	X3za7wnmQSRfGXYEpbu72mKbxrZT5GjILKSAu/yPUNhJZkXegTY8U/c0SBKbMfHPmzKBGf
	KabOfxjcdQxXqlnv7eZ7RdQeSi92Nn4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-1UUrIJFxM6OcypHu7Ljt-w-1; Wed, 07 Aug 2024 05:00:34 -0400
X-MC-Unique: 1UUrIJFxM6OcypHu7Ljt-w-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-368448dfe12so310865f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 02:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723021233; x=1723626033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7TSMM7RSCrnhwAsQiYVaNQicw+vwD/1jbD15fLbhD4=;
        b=dmMjZXopv61EIyId7OjStwTrzHfqGWnjXzPhOgpEjnu53C2QG/2p1mRGYohU4B5KwQ
         3NeI98Roae2mraqo6V50+bQbHR8xzY3dU78SYCS/RWhhpV9/vg+wIgigUjP1ltqc5+7J
         N/MgIDDKrRmVK6HsIHADoo0Z8YwZR0OjhnTzWdCxYBZ3V1KawqkAVKbH1V58+z31GgfN
         9t7JDCWLMUOBMD96WwGfjmgWA440SGHr1sf5vWYyAdDw9geYCpaUhyj4RLkqW/wwdR8e
         izSl3Knd/CYwaLQemLY7JbihHiFIKRjVlAc//x5oRdLiz+SyGrI4hR+bji3KlV6gTuhS
         NFkA==
X-Forwarded-Encrypted: i=1; AJvYcCUu1JFaVFirGc6xONddoAOlLrXZnHw3SRvNsQmsXu8rPFE3JeHw++KuRG2k2LeGA47oytvjh6Gh3RsFTgczVmSOSI9zjMl35SoYGOob
X-Gm-Message-State: AOJu0YwvjKPmWShRRdGhOfz/4WAtskenqupyz1sqESV1dWoGCBewDdnW
	0oMd9Qd0WxUShHJK/PWx0N/b+JamUerPvbsCqyUsVBxa14YtSMsmReTkxhtczbq8vlyJuTLfJy/
	DFQhw+tZv7QBjFHegH+mGO1wez4WHSKzV4YRXFvmGnB1E71HLR/fnmXJ13Vi+Pg==
X-Received: by 2002:a5d:4901:0:b0:367:40eb:a3c3 with SMTP id ffacd0b85a97d-36bf0f2839cmr992545f8f.34.1723021232746;
        Wed, 07 Aug 2024 02:00:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFumAGM1L8vsLyWPahc2Nfwp4saRP75eIk629srCxv0SK9yvA1TPKV0WWsa9jZn8PVVTGoH+g==
X-Received: by 2002:a5d:4901:0:b0:367:40eb:a3c3 with SMTP id ffacd0b85a97d-36bf0f2839cmr992507f8f.34.1723021232237;
        Wed, 07 Aug 2024 02:00:32 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.159.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf0dd9esm15209985f8f.21.2024.08.07.02.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 02:00:31 -0700 (PDT)
Date: Wed, 7 Aug 2024 11:00:29 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Zhang Qiao <zhangqiao22@huawei.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, Wander Costa <wcosta@redhat.com>
Subject: Re: [PATCH] sched/deadline: Fix imbalanced task reference
Message-ID: <ZrM3rZFGg_nPEjjV@jlelli-thinkpadt14gen4.remote.csb>
References: <20240807083015.1385303-1-zhangqiao22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807083015.1385303-1-zhangqiao22@huawei.com>

Hi,

On 07/08/24 16:30, Zhang Qiao wrote:
> When starting a deadline inactive_timer, the task_struct refs will
> be incremented only if dl_server is not set. But when canceling the
> inactive_timer, the task refs will be decremented whether dl_server is
> set or not, leading to a task reference imbalance issue.
> 
> This patch fixes the imbalanced reference by adding a '!dl_server()'
> checker before calling put_task_struct().
> 
> Fixes: 63ba8422f876 ("sched/deadline: Introduce deadline servers")
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>

Isn't this equivalent to Wander's patch below?

https://lore.kernel.org/lkml/20240724142253.27145-3-wander@redhat.com/

Thanks,
Juri



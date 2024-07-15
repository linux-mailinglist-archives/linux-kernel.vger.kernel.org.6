Return-Path: <linux-kernel+bounces-252918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B869319E2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34FEE1F2212E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82ADB56440;
	Mon, 15 Jul 2024 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aA6Bv/RM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B24E4D8AE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 17:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721066237; cv=none; b=SK/HUpSF50Ze1SUlR9Fk6LLRzuJEE1HkohSXl5Q7IZ87fgw0i8HqijJYnyD9XjskPZ+qIxkXy6WiP29xPNxVuV74BUHZWtEzolyOQ+ZQatU1vQMprLgO9a8m9Plv++NROilPe8TctE98NGNtbsjdEsHAz21SJk52MsWj2X8QKHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721066237; c=relaxed/simple;
	bh=ryADqVEKJ5LrZggMqQrQAklaSbHdf0etkTj2L7lfQtI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WigHD2P3/3UDrWXILby1EU9IItFdFLTGSmgI7UgsVGGmkxeVaSO81knNqlZDetbXLx4/t0p2V8JS5NHWAURIujbshRsxNK8Z9caNWzCEPCaBR/n1/NsVx6XCRgg2Yl2NKkT2nOHf97OL2GzZSMtULBg1088FqF939icVk2x5R3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aA6Bv/RM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721066235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fi//A5tT5b/KGkVcXcH6Q4HMgHLicOcp8QtJZcCZxww=;
	b=aA6Bv/RM6r8YPqMJEc0ESS1RQaU4zqeootQHAdJLFuCAsfa/M3ikrDOrQYMDR6ln9DoOE8
	y7Xi/pavOBkwJrfnoeXguz5TVOaXtzfAqqxP3cCSlzvYsyqkoRLoU8suUICwM9iuEpIF5P
	hbLYTstF8XWJrs3mXiJgBU0/1AAsTj4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-CCI7In15M_OG_i9FM4zfqw-1; Mon, 15 Jul 2024 13:57:13 -0400
X-MC-Unique: CCI7In15M_OG_i9FM4zfqw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-447dbe5672cso87919731cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721066233; x=1721671033;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fi//A5tT5b/KGkVcXcH6Q4HMgHLicOcp8QtJZcCZxww=;
        b=llF3fxmJ9Gn0T6fv9VsNUTLhzmVl1A3zLuPkOuZiJMHoticGiYq11S6E0yY/OOFPwN
         o+Kt8Ny9x7Cti4aFZClSbzrG/wGVjimX5omKdXEQ073RsmL7hGNevrKfOLw4pQ31DCYe
         /h13+BS7R+bd1bvJsYGjpG4acI6B33G56HMLyG5imo+bBclJHqLDZ+/cM/OuvwuFWyzm
         4ygVKhjasG3a/D/vgCmLEp/+3Ye0ntQlIMUKLKpo/kGvMZ1IQ5QY8Bv1IriLjnDMJ9bz
         ectnPxM/G8qdz5x+sfnj79MXDZ+UtnIaOWuZD1p1WlavlsXoWsbV1N0V8i4ZkYL+ewXv
         o45A==
X-Gm-Message-State: AOJu0YyDRp1yi9gVKb0Rfq/D9DAKfU0lYxEVgSkqh8C2B6UxzOzqMr7k
	Jy8mzxvyiivJevP00VRlYuKBgmAV4sxjnB1lprGAxwYe51MgY162oAEmWs6EuWK87347TL/q9ex
	i+SqBdZi7mwe6ke7p2AkJqVww8oi40XsMpphq0qprCotuKmUjvnK689klh5dBBw==
X-Received: by 2002:ac8:5783:0:b0:447:dd66:8004 with SMTP id d75a77b69052e-44f78baa465mr7495531cf.27.1721066233190;
        Mon, 15 Jul 2024 10:57:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCOt8I0Cmlmhi/T8HwXWf9ta6rZvJj0E1YC1lGNYwYFllGk62SlYpkHNxQVya2Z0VyX86MIw==
X-Received: by 2002:ac8:5783:0:b0:447:dd66:8004 with SMTP id d75a77b69052e-44f78baa465mr7495171cf.27.1721066232823;
        Mon, 15 Jul 2024 10:57:12 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b7f8f02sm26970871cf.52.2024.07.15.10.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 10:57:10 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Ingo Molnar
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Phil Auld <pauld@redhat.com>, Clark Williams
 <williams@redhat.com>, Tomas Glozar <tglozar@redhat.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>, Arnd
 Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, Palmer Dabbelt
 <palmer@rivosinc.com>, Andrew Morton <akpm@linux-foundation.org>, Oleg
 Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC PATCH v3 01/10] rcuwait: Split type definition to its own
 header
In-Reply-To: <20240712151547.GP27299@noisy.programming.kicks-ass.net>
References: <20240711130004.2157737-1-vschneid@redhat.com>
 <20240711130004.2157737-2-vschneid@redhat.com>
 <20240712151547.GP27299@noisy.programming.kicks-ass.net>
Date: Mon, 15 Jul 2024 19:57:04 +0200
Message-ID: <xhsmhmsmi1qtr.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 12/07/24 17:15, Peter Zijlstra wrote:
> On Thu, Jul 11, 2024 at 02:59:55PM +0200, Valentin Schneider wrote:
>> diff --git a/include/linux/rcuwait_types.h b/include/linux/rcuwait_types.h
>> new file mode 100644
>> index 0000000000000..60a4385a2c368
>> --- /dev/null
>> +++ b/include/linux/rcuwait_types.h
>> @@ -0,0 +1,16 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_RCUWAIT_TYPES_H_
>> +#define _LINUX_RCUWAIT_TYPES_H_
>> +
>> +#include <linux/sched.h>
>> +
>> +/*
>> + * The only time @task is non-nil is when a user is blocked (or
>> + * checking if it needs to) on a condition, and reset as soon as we
>> + * know that the condition has succeeded and are awoken.
>> + */
>> +struct rcuwait {
>> +	struct task_struct __rcu *task;
>> +};
>> +
>> +#endif
>
> Can't we simplu stick this in include/linux/types.h ?

Huh, we can indeed. Silly me didn't realize that since all that struct
contains is a pointer, we don't need the embedded type definition for it to
be a complete type.



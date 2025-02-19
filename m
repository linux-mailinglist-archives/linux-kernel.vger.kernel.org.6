Return-Path: <linux-kernel+bounces-520821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B2CA3AFA7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 03:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625F6188C4F6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A045E19149F;
	Wed, 19 Feb 2025 02:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="e2HbqkuL"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D63F189F3B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 02:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739932514; cv=none; b=ReqzJGaMwXPgEv4zHmlciCoMuBOYpf16Ur6mVimttEYA+KkkdwhAJs0veDa9NipBYCbzJmCYGGZIndw8admuNqchMMaWwpLHOAiNfn+kWoEaL60dUmOWZOQwaM9DGICPOP8G3XQuQ3lWFTjykURv0ibFL3pQ452NdJM9T2J5dP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739932514; c=relaxed/simple;
	bh=xMj+a3horZECbsUTp70ryecXzS79kAANH3UKAZQH/Xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=afI5c6B+RuzVtzBjZeiiN1aO65rpo/1uCCeyJAG2pNuR4zOhOC3Ls8xihtNMJ8JBEgT/EmN5GyklKsmJPLLc2xTzZY1LrwxMZ+bS9SrRap2KPk4guSVcOAZGiaGQpREXhIw0rrk+R+ZTx7ED1656zTBYFleuzIqol0h7Wha14VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=e2HbqkuL; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f2f5e91393so1385432a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739932511; x=1740537311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=09crVdPJ6DNP+ajj0y1kahMC/P/o19M63rERtGCBZHg=;
        b=e2HbqkuLFJ/mt4R0UWp4sT+2Bqcn4b/CYi4Dane/K5t80w/lQDB6cSm4no++NHXil3
         uNWH8p3Oxw2Yj8h4NhKxHsoKuNIYo7oVvAnIOs4kGEurVKF5c/+TErGu0TLOfmffY1Qm
         /wpHZ33A709N195F+NcORyUkaHDK1TJPYh2c+7csaVKsCo611RIo2tCsSKvnEKOvw7Yv
         4w6xK1K8fBGaKSCBhXg9UMMQuT9YQ/o1GymYUM0fix9VLcv66XJrSvW8SU3O+Z5701HU
         XQBWG9t0H8DAWolRAk54BUaLdHnmezTs09su9KhWVbRs4q4kbUT530vi79X2YyNnwouD
         ygFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739932511; x=1740537311;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=09crVdPJ6DNP+ajj0y1kahMC/P/o19M63rERtGCBZHg=;
        b=FHU+X0Xm+BRPDVJoOcXFVVybcIs3VdZ/NjWBuAk8H7Ajw6k1rBjdJc1YWjXFeMsarg
         G6/Mw2JRezQ4BSj4A0cJuIWSpebfIWxl1thbGCQNlvU1BxRObPZHQ7e25RMgDX/zJvSV
         ZH+9O33XBWJraTCRQGNafhv7Jh4ikeX8rS6LRXEfQWyBOqffWmD6+WL1XdnlcvhQDEPO
         suFGcm7bUzUNjeAaptYwqasF2oSyUSr/1sVVde0CdnNRPvF19VEWGD+rW3p9/bvdfq2Y
         PnuX3wQteGrS/oIwvWnp0ycHP7Gl5DFUL+d7at5CPvDHBacS57Ff6JbRKw4fkPZ1VRIg
         A5Og==
X-Forwarded-Encrypted: i=1; AJvYcCXO8w3vNMuBIIzuy2T/IEG575de7zBZ17dFZwqJ4qR/WqdH7mK+V7ZJbGj3+iV7v/0GpD5YCZhgYnJmGys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjVa90qMeT/E/HULISeoJbrw7m1E3NGDa5SzXp9/qCkybd06UC
	jiIxoox7O+Pnz4yF8Wck1kplKSk5hVSNNpRihTijgnzl3zgenKIA50mLzGYpr/8=
X-Gm-Gg: ASbGnctY3ji/URinQ6EyZZ5Q5hTKkaj/nSMrKzYYuVEOJQJ4qKu4ma8RoFa9pdUHPdu
	rlDxVvey5IEvaIaj1oiYkaDiC3zoGa8uomKRX1ABjgY0gR9Q+CuM3tJneBfMRD/ivXL7zUGb7xl
	EFF8u0dsboDvzvshjS6dk+a/1p4fDTeVj+txUc+C+MOH8LuLlS48059jaUcqxuj81PQ6eQ6yvO+
	jyaSV236kt2pSs3XdXYa5f5DgmshYgJfZLnpRkcXQgOK0Kiq0GcP+5qGEkQUfepWb+Rzd0+UCD9
	Z9sLtr7uZcJID9fZLC3D9yV2vxoQxKXTP8pq+w==
X-Google-Smtp-Source: AGHT+IFm/ezzRUBSTF5ubokeL2y3X3qw2EPgW1gleUK8zJWAXhnpg5Xa99tIuiNpk1+QV7gj49PhRw==
X-Received: by 2002:a05:6a00:1256:b0:730:8526:5db2 with SMTP id d2e1a72fcca58-73261914657mr8861999b3a.5.1739932511607;
        Tue, 18 Feb 2025 18:35:11 -0800 (PST)
Received: from [10.4.186.143] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-add5a4cb306sm7248480a12.3.2025.02.18.18.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 18:35:11 -0800 (PST)
Message-ID: <cc25136d-ca21-492c-9708-cd72d7d7f2bf@bytedance.com>
Date: Wed, 19 Feb 2025 10:34:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Fix and cleanup and extend cpu.stat
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Yury Norov
 <yury.norov@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Bitao Hu <yaoma@linux.alibaba.com>, Chen Ridong <chenridong@huawei.com>
Cc: "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250125052521.19487-1-wuyun.abel@bytedance.com>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20250125052521.19487-1-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Gentle ping :)

The latest series:
https://lore.kernel.org/lkml/20250209061322.15260-1-wuyun.abel@bytedance.com/

On 1/25/25 1:25 PM, Abel Wu Wrote:
> Patch 1: fixes an issue that forceidle time can be inconsistant with
> other cputimes.
> 
> Patch 2: cleans up the #ifdef mess in cpu.stat.
> 
> Patch 3: extend run_delay accounting to cgroup to show how severely
> a cgroup is stalled.
> 
> v2:
>   - Fix internal function naming. (Michal Koutny)
> 
> Abel Wu (3):
>    cgroup/rstat: Fix forceidle time in cpu.stat
>    cgroup/rstat: Cleanup cpu.stat once for all
>    cgroup/rstat: Add run_delay accounting for cgroups
> 
>   Documentation/admin-guide/cgroup-v2.rst |  1 +
>   include/linux/cgroup-defs.h             |  3 +
>   include/linux/kernel_stat.h             | 14 +++++
>   kernel/cgroup/rstat.c                   | 75 ++++++++++++++++---------
>   kernel/sched/cputime.c                  | 12 ++++
>   kernel/sched/stats.h                    |  2 +
>   6 files changed, 79 insertions(+), 28 deletions(-)
> 



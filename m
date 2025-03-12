Return-Path: <linux-kernel+bounces-557806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B02A5DE10
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D723B6E2B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980D124DFF0;
	Wed, 12 Mar 2025 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zbtk0rXC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D381243376
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786360; cv=none; b=ViKi+Pz7o548OZ8ix87rBr5Y4MEpS//cxKwVmle41SKozT7GW7H98bUB3EWzGdq1/fC7+Q+3Ck3EhNvNsWmuPgBKyjdBRPw+a2HNfb7sfBX0VMu2PcYftAWng81KfQSCZaq+20OY/0UbeZ3HWpknWwmBlK/3J+XJAK8c0Im7bgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786360; c=relaxed/simple;
	bh=pMBnQB/WptlgARfKUKxfFhODgPcRfYP9RORJ9mLu3/4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fz9oUQQ9p95KxoOn6oOHTjt34EtIKeoDMQ2BR9Mg58pq1i7PclTzAb2rjkq2MH10EjmsEmem85QkIMye6JKi0mQalf5FzYH0Y9wEhIOOJYqWYfPNIvZWUbwFDTOenMxVT0aMGQOXfL6NMm4AM4d6zVraH66dpEdEnOqEEiY6uZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zbtk0rXC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741786357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pMBnQB/WptlgARfKUKxfFhODgPcRfYP9RORJ9mLu3/4=;
	b=Zbtk0rXCzpV8x/qYbWABLLFBt245/3R6z7m19gqRqdQKuzhD6qMMXtv8cZIH0LuInehcYS
	U6iK+qLmhXlNzfbfroX50wk+WROAMYE9/1LfuKkRNf/p+XenP4vOa/3gYpt+nAsDzBno3o
	YoyptgNTp1tZnghA3ndoxiay2YEHyqM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-O12KFQoMO36PTfoZNcYZZg-1; Wed, 12 Mar 2025 09:32:34 -0400
X-MC-Unique: O12KFQoMO36PTfoZNcYZZg-1
X-Mimecast-MFC-AGG-ID: O12KFQoMO36PTfoZNcYZZg_1741786354
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d007b2c79so20505255e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741786353; x=1742391153;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pMBnQB/WptlgARfKUKxfFhODgPcRfYP9RORJ9mLu3/4=;
        b=ahuOMdxvDGYleCkRHKC6wmBO2tffZMO3e8dvNXxx5lek72slWS9Xf290UAhy37hKm7
         gi8PG4+8wEC7Vgnuh7GheG4j6YQd+dNnZgDvAo6k6EhPUjTXRt4agZkuddFKYpNq/Ncc
         gloSZDWTWLiRSTg1dbBjq+FVuQI5+jM27ZB4Yi+yVv9j5W0/h1ovJKbdPAEeD4Cb8mfU
         qOveC2pOdO8Y+evvAvx5nQ7ghP5S+vBwAyfau0wCMEjaoOZxMultUsBTvTwIdpnUCQ23
         c1ocwhauZ6SalkTGDdKrTFed5DNGgjTYwRdCUzPJ/Vvz1ZwImC9NDrJk98uAkUi/W+wp
         RBKw==
X-Forwarded-Encrypted: i=1; AJvYcCVRE4kI/JLf0CghGT/3rZahUbGmBNEssQEbx91c+HorRxYEliWhPsmqgHW8JexIv9EHYVR4EcQLFUYO4X8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA8TuNRDwk4HR8PoI7vYL0lSwOe231RFXu/nR9fMO5Qj61mXSN
	6HkKPag4frN0C9GD39mlV9ZeHKRP9gr/SetUSSgqNvpjGS3tblWSrSMuNJnQOdsyjpybqrmW1P8
	TdaMKreIP9GqR7i5dZEMn51O/92RFBeTlnxOrfQtoePvpvtAChw+PLfvnhJYuPw==
X-Gm-Gg: ASbGncsWIZocYUgrgCOPQKVFNUTCd6BsKAtn2wRcJbOpLY1yBMqdNW6jm7d507XMAij
	4OnLZ3HFCrGfMqLxQP23gwmN4JLF4wkE5T1MzbPU8V/HpU9LzfoT1V3G9C/g4PFfN1wrqdYD3Qx
	umWTmcsttObNKT672hvJuyHVw0qzCTT7PnLuI1BbbpSR7pgiv4ip7Tw//gt7rARxGGbADNKDo3O
	bHyX6TZ0Z43qsZhNgRisKleJkx4i+bk2tERqyKDk/nEB4Q23w+O5Ve8KrF3WY6C25F+YFXFPiu+
	oqBZMankMJKlzCH1fS/NeyH+w1Ia59w6YAFkDQpGDvKZNt9UoVH+ZeLUDsrXYP86pDb6OgYtP7I
	D
X-Received: by 2002:a05:600c:4f14:b0:43d:7a:471f with SMTP id 5b1f17b1804b1-43d01be7e4bmr85573985e9.18.1741786353621;
        Wed, 12 Mar 2025 06:32:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3ABjY0Wbyoz7mffI/6sHIGOzIiGV3f5HP6r39Oz4vaIdVFyhl7aarVfkrAHGsAg9ShJgZSQ==
X-Received: by 2002:a05:600c:4f14:b0:43d:7a:471f with SMTP id 5b1f17b1804b1-43d01be7e4bmr85573675e9.18.1741786353291;
        Wed, 12 Mar 2025 06:32:33 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a78d245sm21220905e9.28.2025.03.12.06.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:32:32 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Waiman Long
 <longman@redhat.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
 Qais Yousef
 <qyousef@layalina.io>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>, Shrikanth Hegde
 <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it, Jon Hunter
 <jonathanh@nvidia.com>
Subject: Re: [PATCH v3 6/8] cgroup/cpuset: Remove
 partition_and_rebuild_sched_domains
In-Reply-To: <Z86zO_uCamVRRUqe@jlelli-thinkpadt14gen4.remote.csb>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
 <Z86zO_uCamVRRUqe@jlelli-thinkpadt14gen4.remote.csb>
Date: Wed, 12 Mar 2025 14:32:31 +0100
Message-ID: <xhsmhldtape6o.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 10/03/25 10:39, Juri Lelli wrote:
> partition_and_rebuild_sched_domains() and partition_sched_domains() are
> now equivalent.
>
> Remove the former as a nice clean up.
>
> Suggested-by: Waiman Long <llong@redhat.com>
> Reviewed-by: Waiman Long <llong@redhat.com>
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Tested-by: Waiman Long <longman@redhat.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>



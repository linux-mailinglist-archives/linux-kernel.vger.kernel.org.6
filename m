Return-Path: <linux-kernel+bounces-549378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A79E1A551CF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078811886B03
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E9B2561AA;
	Thu,  6 Mar 2025 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emUcydoP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EE813635B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279737; cv=none; b=aTR+WADXUJBP0jmLtDg2au1TrtvvRs0E6v9nrFz/ARnTfW5tM/e0gMs0EOuD1gGsgwyxSi1RF2TPC66PG0t4KlDleY3DpOQDWoMX3olimJcVHAgWLzL6IeJ8KajcXMuZ3W5ZONljnx7bnjoAcoI4ANHy4Bg6pYg8cZytqHLEHCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279737; c=relaxed/simple;
	bh=Y++u8rWHcpmVczkgOVDovidF76ottDHpCHaf9LbRsj8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tP+tImq6N55rjM5zqgvtiIzHm4UMkegqbCZb33n2mQ1btNbde1Vnvebkel3d1MAHXIYC63G/ucGWPwOkHmwEGFK4evMMtJp2AaYMSyCxh44IUIx7B0Aj67FjfcgfFKC69x3IQV2I0FmsmCpVzbhIOHKa260llaigmYlsOtVjPF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=emUcydoP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741279734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DnZMB0kgHOAUXEFLOXzghVoRuV4+jMQKukckas1LShg=;
	b=emUcydoPMfcC4BGw+QSWlvw+lZ4A1p7KUH7YFlZwBvUysT0w6/0Rb+SYiv+bxCpNgjPEU6
	XtzD24MlipiaLgpt6qnLDiQb9azwapMfVseWxbP5B7BEBkRycBrMEhNWuMMC6SUKcoAcEL
	kC2FGb1tfL7Ue+htGOekqW7H+ikIBR4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-q_p3c_k0MtaKu4q2CD4olQ-1; Thu, 06 Mar 2025 11:48:42 -0500
X-MC-Unique: q_p3c_k0MtaKu4q2CD4olQ-1
X-Mimecast-MFC-AGG-ID: q_p3c_k0MtaKu4q2CD4olQ_1741279721
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-390ee05e2ceso613060f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 08:48:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741279721; x=1741884521;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DnZMB0kgHOAUXEFLOXzghVoRuV4+jMQKukckas1LShg=;
        b=hWxAoTz8vKcDYv67i+Fpy21QPTqElHPjMHry9zIgj9hmvDM+8GbnrI4Bwa5fRoDXWA
         Tg3ple0VyLWc8oo+1rrU0Ldgq2fFLeRPgGPLgC5DXV1gOWnabV5Ml6ucAkug5XKKfZ6i
         hzdTKPxQmXrfX3V3ejm0NFRs+oJ5QDxwSH1Ddi//QmFrUEy5q9YqHrj0LHD0zxujy1IV
         9QxRpo7zwSJISr7Ctz//+B8wur0JIPC4XPpIXM166mSWW8Ohss2Qp/CbgYXKnmGD22WZ
         R0pZb9LGTK5rYErZqq8IyFtzmE4evggZ2VwtiV8xbage4b4czylgC7xW2BuW+Vbx9YMz
         BkaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkRocMONAHKtb4R7JAfM8VA6/ho59NOrZbFypWLRw2D8PxAy/OG9XdG2j75i3DMMvBPKuLSGigue9nOa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGyPqOEKjO6nxnXEOAmAyKF6lAJ1mahNf6ZhLKwim5zNmfWTST
	r5Gw0mVt06fm9rLHGjsUBX8cMVEf3GIasm8vRirjlGrEFZj5sYe954DR2OdwvNesG2xca4VgTaa
	OO4SIzzGcR9LHKStHnxkEQ9lq0Bq4V8p1jLP++Lef09Qj/VbxT2N+yvF9rL/rgg==
X-Gm-Gg: ASbGncuMFNXLzMr2WdxLtfQbmdeOPzirriITa4RKEwYLwZrrPmgPz62ZFW+U2PPIS36
	p62tr9jmYa6bEqJzicef/YV/+1ob1hkEdY7WBR2QAAEFLLG355WAulvjNlZ7ll/UuYD5wBT0zts
	sGygaUg48qw7wKV3ZW56d9dlI6iB7rcteDt0RlddmJ40IPxytqAqkSZM96JyXdfX9Of4xs4YI70
	wn2mC7HIwToTvmHhcvqi3fdKhvOzNd412Xeg1pbZrXE0YvrVdnp4kyBNqZWdzG+hpbRSh6XJW4h
	VUbxHNJtkV/dJkLyISGKhOr5fm8KSNN2dYj+btK6bz4OieiW834v6DvXzjXEoCxerc2ylQ+GmW9
	j
X-Received: by 2002:a5d:6d04:0:b0:391:2e31:c7e1 with SMTP id ffacd0b85a97d-3912e31cbdamr1733789f8f.4.1741279721435;
        Thu, 06 Mar 2025 08:48:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOpgKBtQoNqG0A8vm9wg1dVElBwbL0nvoKqU52pzsHajpANvmpL/kEWNNxDa1hdG90eyLpOA==
X-Received: by 2002:a5d:6d04:0:b0:391:2e31:c7e1 with SMTP id ffacd0b85a97d-3912e31cbdamr1733766f8f.4.1741279721060;
        Thu, 06 Mar 2025 08:48:41 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e4065sm2611195f8f.62.2025.03.06.08.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:48:40 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Naman Jain <namjain@linux.microsoft.com>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org, Steve Wahl
 <steve.wahl@hpe.com>, Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
 srivatsa@csail.mit.edu, K Prateek Nayak <kprateek.nayak@amd.com>, Michael
 Kelley <mhklinux@outlook.com>, Naman Jain <namjain@linux.microsoft.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [PATCH v4] sched/topology: Enable topology_span_sane check only
 for debug builds
In-Reply-To: <20250306055354.52915-1-namjain@linux.microsoft.com>
References: <20250306055354.52915-1-namjain@linux.microsoft.com>
Date: Thu, 06 Mar 2025 17:48:39 +0100
Message-ID: <xhsmhwmd2ds0o.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 06/03/25 11:23, Naman Jain wrote:
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index c49aea8c1025..666f0a18cc6c 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2359,6 +2359,13 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
>  {
>       int i = cpu + 1;
>
> +	/* Skip the topology sanity check for non-debug, as it is a time-consuming operation */
> +	if (!sched_debug()) {
> +		pr_info_once("%s: Skipping topology span sanity check. Use `sched_verbose` boot parameter to enable it.\n",
> +			     __func__);

FWIW I'm not against this change, however if you want to add messaging
about sched_verbose I'd put that in e.g. sched_domain_debug() (as a print
once like you've done here) with something along the lines of:

  "Scheduler topology debugging disabled, add 'sched_verbose' to the cmdline to enable it"

> +		return true;
> +	}
> +
>       /* NUMA levels are allowed to overlap */
>       if (tl->flags & SDTL_OVERLAP)
>               return true;
> --
> 2.34.1



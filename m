Return-Path: <linux-kernel+bounces-427800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48DC9E06EB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DCBD172A70
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36B420969F;
	Mon,  2 Dec 2024 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzuhHVLr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7451120897E
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151377; cv=none; b=F7qwoGs5KJyQO5Dy+qV3aMAg47ErS3wfYB06COhAXgMpah8gxUvttcu8EKO/Z3ceBtrErjqgCU/2Y0tBxRc0Yeae9fg//z/o1/dIp2f2T+JoUiu+hA/txPMRhaXwCdF8cdfdj/x1ZJWuv+IlQG6WHyn6fwaeBDdQ9oD9uT9Yq10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151377; c=relaxed/simple;
	bh=EC9E0hucXqDeFyn5BpO7Ofdsa5Yur7No7rg1GgbSVN4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JBr4oYc+I7RVF4WkyPZs2OXf8OUsMETrKtzHO7tCQYfmVlbftEAw705Z6uo5xBBKOBR55xRmp7J4amxzwk0c24hlBcEZvX3UIJUkl6VmnSxhJwaFxIaRhqicIswrrO+7DGueGVK0fmgZqmV1qwQBu7c1sUYDkOZ2L3AclQB3TZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MzuhHVLr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733151374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EC9E0hucXqDeFyn5BpO7Ofdsa5Yur7No7rg1GgbSVN4=;
	b=MzuhHVLrkC6udHcaF8aUsxW+LwFTnzAeTAwiplE7NotVnD5JlAL7Gn9dAMmqU85HnzaTOI
	k2nSOYyvAWa3WUoFtCOjSRcSwLXtZmnlQMwUqK/EAKtABV/t2GnmgnN1hPfBRAPEu5nRhz
	zmF9h8Iqlt0LYPWhnu9/vPB0sC8vwRc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-ZjfcfushOkGLR3RqI5_w4g-1; Mon, 02 Dec 2024 09:56:11 -0500
X-MC-Unique: ZjfcfushOkGLR3RqI5_w4g-1
X-Mimecast-MFC-AGG-ID: ZjfcfushOkGLR3RqI5_w4g
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385e3cbf308so757313f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:56:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733151370; x=1733756170;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EC9E0hucXqDeFyn5BpO7Ofdsa5Yur7No7rg1GgbSVN4=;
        b=hNwsC/iZG60+1Zq3PLsh6f4QZpkkQKsktdefY5eEpJOlGgMlmI65wc9JpKIWSlTRub
         P4gpIPWMv8rnuRKyN2rUjm2vaF9+9dqOTxnNlCdPWpkR8WdJntWb8yCgXFiopoBmvZ6e
         DMFJndRWFOio6ab6km/jnvBPDtAFNYiSnhFs6Zv+Emi4LHsW+dcfLr/piK0tEM+ibqoI
         2cCEKqbFSkStHCMTAzIsy3+HtHkMEmt9W/iUJQxuntpra7MLd2RboAY+RUILNEqFKxDf
         VTCg+U7NlOnAfF7W2tZ/KrSo080+Jh20n06rwetkgTmgeym3TpBB7atUXam1t/IaZDhX
         RwXg==
X-Forwarded-Encrypted: i=1; AJvYcCXNq2c3tIC1+I1oh7Y/Vn0Yj6RH0YvTqNgkx4ME+On6Nliv4sgIUWaNIjX40rXeRhXb/ZSIpgMmN1XvsTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9xheAIHP/Tm/sqRB+7E655E8O+Xucx9FTPaINAj8kYT741myc
	O+GT0EmKeMKBfAk5IXJa6YhhTEgQEL8RjfimqN3BUYDdTUVTbDTGnTDr5a8DMgzhViYK1LCtk15
	1QiAISaV7OPJobFXhZzptrGDbvSjPCZpPefd8Y2qdS4eOm8Hc7LejsAWCfznwvA==
X-Gm-Gg: ASbGnctp4JawjifD8SELnxciWNPhUm70Pi9G310t83LM93DT50ySdDYN4keA20DGpBb
	ScCxaDHuWJy81nm5vj49uo5+d3a4sfFyAkR5FuK3St1RnC+YQAfpf+jShtYrEZqMET42ho74Nbx
	H/ioGiHXq0MTjisQi2N9nqqBOS3kGCtqVsPDA8/mP50K7Eji84uZKJNN91Pl0n8d1ZpwHTTbFdA
	a2WbBEoVwHJ+6q1XNSURzsZ9qR2i90rQAQZqWapeaMjai4iKXbyed/jjBl9Y/WHjPlffTmAhSLw
X-Received: by 2002:a5d:6d8d:0:b0:385:fa3d:19c6 with SMTP id ffacd0b85a97d-385fa3d251emr704877f8f.38.1733151370101;
        Mon, 02 Dec 2024 06:56:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4l2XzqaYesgO1NND1lzztg36U2ZwkoTvJXF1I8fX5jH8ArXuN8EINJo3EoG8nWvxIoMzq/A==
X-Received: by 2002:a5d:6d8d:0:b0:385:fa3d:19c6 with SMTP id ffacd0b85a97d-385fa3d251emr704857f8f.38.1733151369779;
        Mon, 02 Dec 2024 06:56:09 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e30c54bfsm7614208f8f.110.2024.12.02.06.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:56:09 -0800 (PST)
Message-ID: <6b7b30528893b091b21a06ead610709219cd9ba0.camel@redhat.com>
Subject: Re: [PATCH 1/2] sched: Optimise task_mm_cid_work duration
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar	
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli	
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,  Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
Date: Mon, 02 Dec 2024 15:56:07 +0100
In-Reply-To: <c9a39d2e-6829-4bc5-b560-347ee79ff2e8@efficios.com>
References: <20241202140735.56368-1-gmonaco@redhat.com>
	 <20241202140735.56368-2-gmonaco@redhat.com>
	 <c9a39d2e-6829-4bc5-b560-347ee79ff2e8@efficios.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Mathieu,

thanks for the quick reply.

> Thanks for looking into this. I understand that you are after
> minimizing the
> latency introduced by task_mm_cid_work on isolated cores. I think
> we'll need
> to think a bit harder, because the proposed solution does not work:
>=20
> =C2=A0 * for_each_cpu_from - iterate over CPUs present in @mask, from @cp=
u
> to the end of @mask.
>=20
> cpu is uninitialized. So this is completely broken.=C2=A0

My bad, wrong macro.. Should be for_each_cpu

> Was this tested
> against a workload that actually uses concurrency IDs to ensure it
> does
> not break the whole thing ? Did you run the rseq selftests ?
>=20

I did run the stress-ng --rseq command for a while and didn't see any
error reported, but it's probably not bulletproof. I'll use the
selftests for the next iterations.

> Also, the mm_cidmask is a mask of concurrency IDs, not a mask of
> CPUs. So
> using it to iterate on CPUs is wrong.
>=20

Mmh I get it, during my tests I was definitely getting better results
than using the mm_cpus_allowed mask, but I guess that was a broken test
so it just doesn't count..
Do you think using mm_cpus_allowed would make more sense, with the
/risk/ of being a bit over-cautious?


Gabriele



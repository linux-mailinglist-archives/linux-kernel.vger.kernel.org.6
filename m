Return-Path: <linux-kernel+bounces-554464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9DDA5980A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44C987A22EC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E4F22CBD0;
	Mon, 10 Mar 2025 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="etB0YbRV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC0521E0BC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617999; cv=none; b=gdlhR3Wo3D3UXXXDpVtiFGLkRvdmLaE7vhi1pxxLguiIAOg340+Wj8pKjwg6PnmznEmL7KUh8ytAKys2Q9/dUGJeZBk3qdFldh9SVvSwlCpeSsqnFaDGn63zNXcrm80p5PE47gfrIjEQzihKaDWQW3dhBwOhUpsWG9j/3PBRMK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617999; c=relaxed/simple;
	bh=7NBn6thYETvxD4JzG7wm+CZqqHUZNZ9s0pu5TPouYvM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SRx/bQdZwKwVuWaQvspMtMcMh3cCYJ8CWin1qnSFaS7JbA73q5XRuUDx4KUETvyrhud2H4rXkRTha9LfMES8NrWuCcjsIebuOXr2i9dbdJmfX3gKkTDkzLMcUy/nBtssPyfnrtdfc6WrGkA6JewkOgzPfjFJCO/+kzlMwp+jSVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=etB0YbRV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741617996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7NBn6thYETvxD4JzG7wm+CZqqHUZNZ9s0pu5TPouYvM=;
	b=etB0YbRVMQ4XYi2GZdTtgmkA+bJMKpFctgRroPQGCE/E/xseK6wsouRTE7Uwd3Y2P68Gxx
	DoC17qCnUQ/GdVTEbpCmRH1/v06tZSfksdTTKj4N3HAIVlG/2jxOqZ5SyiNHIACAIwSGnP
	TNIArnU1L6I84wpQA3W+yXZUTLgvoFY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-ZcF6vw5uOlCdbGGuomuDJQ-1; Mon, 10 Mar 2025 10:46:34 -0400
X-MC-Unique: ZcF6vw5uOlCdbGGuomuDJQ-1
X-Mimecast-MFC-AGG-ID: ZcF6vw5uOlCdbGGuomuDJQ_1741617993
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf1af74f7so6559375e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 07:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741617993; x=1742222793;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7NBn6thYETvxD4JzG7wm+CZqqHUZNZ9s0pu5TPouYvM=;
        b=hqMC3b3FtbaRpyurEx8RqwZzjd8dJeeziSYWUG7kfQfCUrWMvcw+sSf4wcmwC/1E4N
         AmnVmCJonwol7XZWGfWX/0+YctRoSOaGbuWZTrjrGnk07X0/aPguzsQ1aCv5OEzJ8RqU
         9pEcEzxtWIWxoViEz2LBAO3ErjB9ueLj91VhH+GUpOKVpOjCfbF4WFvQWGPC4TLCNSFQ
         MpkeQRTi/G1xnSRoZvtZyZQIYmRwjqIsfPGUr0LyE2sYjxxo2fRrJX9P33MFqDYfl9Cu
         ylilEBw2oRT2g+dAMc7J/rwcv6iSJGLT527O9ofd7Kq+vZJ/vvnyTpx45AnCeDOX4aqs
         j3MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzn/Le6wKCQ+bLJhyNCpExiErEPK3XOSqD7UWa+WGfXOxo/BKjX3+3UyT0bZKTyBu9vsk8PN1j+Pw/hdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbNxH9M8V3Sdq8l4z/9t1+EK95xcOFsxZeKvtyOUYJqpcbWna3
	hj/oPHqxTsdwwixEJ0hu3CwbNciajFJLbxDtZBbWNDhEAhz1ct3n6ShZhpM14aAlXWl2Rupk58a
	fDyoGEZHqDpP+5YReF3MeApbNkfSb97MFmlqlERvD0QqDcLHmeLTtpXh4ukE1j/hAhNrDkHPn
X-Gm-Gg: ASbGncs/MSU4eAZse1pQ0KNxn56wDDWZ1sjDJhgGVQsBg4LQXK1LxVN8J75midjP31f
	r4SA1TH8WXFMds+zEjZujT4WPWY/NjuoNkNfRQ1nIzA+qyRT4ip7p2MdFB0nFaASZkDtNp9JveA
	IwNWnMe+oTe225l1tz9U+xpKDygPEZQmfGkOXotVCsBnBxc2yAc7pqrSYjFPe5cWHyhI+rJl+ni
	QCxINJSw7Jfeklcx54hqRnZy3UPtX0ub7LDcpXaABD7Q13SNYG/X/VJffPlek450P+uKMXHvk2q
	+Ym+omG0Dym/NuFFjrggGK0YQWHrUDknT/ibH/Oocw==
X-Received: by 2002:a05:600c:3512:b0:43d:ed:acd5 with SMTP id 5b1f17b1804b1-43d00edb082mr7759635e9.10.1741617993314;
        Mon, 10 Mar 2025 07:46:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGANFZABLGGy46eqy2gRJs9BwAJSC3qvlHZaJ0LiP+U9nBEsSDR/rVW+yl7lBsadPvWtmflfA==
X-Received: by 2002:a05:600c:3512:b0:43d:ed:acd5 with SMTP id 5b1f17b1804b1-43d00edb082mr7759095e9.10.1741617992856;
        Mon, 10 Mar 2025 07:46:32 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ceba8d727sm77640315e9.25.2025.03.10.07.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:46:32 -0700 (PDT)
Message-ID: <1c161066bcbc916ae9d97e7d1753ee12511da085.camel@redhat.com>
Subject: Re: [PATCH v11 2/3] sched: Move task_mm_cid_work to mm work_struct
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@redhat.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney"	 <paulmck@kernel.org>, linux-mm@kvack.org
Date: Mon, 10 Mar 2025 15:46:30 +0100
In-Reply-To: <20250227153329.672079-3-gmonaco@redhat.com>
References: <20250227153329.672079-1-gmonaco@redhat.com>
		 <20250227153329.672079-3-gmonaco@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-27 at 16:33 +0100, Gabriele Monaco wrote:
> Currently, the task_mm_cid_work function is called in a task work
> triggered by a scheduler tick to frequently compact the mm_cids of
> each
> process. This can delay the execution of the corresponding thread for
> the entire duration of the function, negatively affecting the
> response
> in case of real time tasks. In practice, we observe task_mm_cid_work
> increasing the latency of 30-35us on a 128 cores system, this order
> of
> magnitude is meaningful under PREEMPT_RT.
>=20
> Run the task_mm_cid_work in a new work_struct connected to the
> mm_struct rather than in the task context before returning to
> userspace.
>=20
> This work_struct is initialised with the mm and disabled before
> freeing
> it. The queuing of the work happens while returning to userspace in
> __rseq_handle_notify_resume, maintaining the checks to avoid running
> more frequently than MM_CID_SCAN_DELAY.
> To make sure this happens predictably also on long running tasks, we
> trigger a call to __rseq_handle_notify_resume also from the scheduler
> tick if the runtime exceeded a 100ms threshold.
> [...]
>=20
> Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by
> mm_cid")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Is this patch missing anything?

I refactored a bit to have it build in configurations without RSEQ
and/or MM_CID (which was failing v10)

Thanks,
Gabriele



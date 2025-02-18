Return-Path: <linux-kernel+bounces-519550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFCBA39DFF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A453C3AB86A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D647E269897;
	Tue, 18 Feb 2025 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXJCbQKi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6383E22B8B9
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739886580; cv=none; b=dqBTdv3CkOCJM8LmAD5Usq77wA2fPkGc15m6niZC63/55kBsQVNyF13wuhVzjQBEYQMcSAZfWFvYnp3FMb04peswOZfk5P3zI1la5NLvfi8SeM1ltNSl184L8j72BLDIoNryLmgpbepFlvWCokfgvgTqfjHLaxVbviZKDsnSgAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739886580; c=relaxed/simple;
	bh=YbtsSYh/zjlj40vi9mvsj1cNjf+xfEc6mak2FCLWzYw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FYRpdv0dx92LVd41DUYZZ1DsP/DnQC9z/XGlzbFnc8yO1uyqe9bL0qDUmW3wiStnr0U2XD1TPtjZ1BiZNi+lrVJrzxaD+zfOa26cONcZ+0Kr79zN/1qZk2nXSnQ21ZAcMR2oEGJZscyI1WEce9rmKZ2x022MT+B+v1HFdScjurg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OXJCbQKi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739886577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YbtsSYh/zjlj40vi9mvsj1cNjf+xfEc6mak2FCLWzYw=;
	b=OXJCbQKiwUYB/gm/qQScCU3CMOri5nDseN2qJ5BMwjuc57DNnXJp7NTP3+V7yYe18e9btv
	Jr+046G249LLU0qKXq38EH+z5OJ4lbc1WSBmUmqc4iNfLxsMJ2LMX34d3Ok2lShmPKB4Kn
	0/X1Ri6Y/+7RUKa8KrfeyrLZR1buZjc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-NN3Wf9DoPZuW5MSgFlFKWQ-1; Tue, 18 Feb 2025 08:49:36 -0500
X-MC-Unique: NN3Wf9DoPZuW5MSgFlFKWQ-1
X-Mimecast-MFC-AGG-ID: NN3Wf9DoPZuW5MSgFlFKWQ_1739886575
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so32781135e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 05:49:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739886575; x=1740491375;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YbtsSYh/zjlj40vi9mvsj1cNjf+xfEc6mak2FCLWzYw=;
        b=L1e0xYDX8o/Y4xOWDPV2ZSlweYGjLoC8jvlXMxve+nkH6psQ3Y59V70UY8EnqErKlh
         ATbcMt0tGGY1UTl+Mtg7Z7iWFX1tPhZPrp5yKwvzQf4N2rNr2fSSsmVUVBNj4t9Ue9ad
         5GgABBPRQASc0cK5r/T9JqHXkTrT1k4OKle93q5PGLq4OP/a4zCRMVjr1ynUkebwkKrG
         fIylwwP+wL4V8Zw3ohql0HDh5rz+HW7ZRKqpqjRvejx1G5qzklPehdk/uhQevHP2Kf8Y
         tEioc1xiLG+sjNFsWoJJvU81ClDUho1rYC3/U+OMbOuXSucHgg5DKCy81EAowfOj/0OM
         Wuwg==
X-Forwarded-Encrypted: i=1; AJvYcCVswSh3FXYLsLG20oBVRzdhrrSKHJTLd1WFBTS1RmVSLkDhkICM1sKpokw0XRYJHq42ZjfagikzfROwLp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwezXJDXKUD1Vz2QYdTpTfjgRDGgBU38Mt5azBYVBtYgXDfkwrF
	VYFtAxU5xfl5znldn6qELJex/U417MbKAkJ6kocxnU7T+VBPBnCTae3aouUkN0M0708LRWhriBC
	DsmRsjvLq+boOzlfBke1q08dJgoSSuwDxx30X+F5dKabihhb4zdcelnAmFMmUvC7599ntpxNh
X-Gm-Gg: ASbGncvmK9t3SMpi/o/azmIM04IDf6psa1TuqMWILWnndI+1y/4iAQ4RqquKxLcx71n
	6Ohw11RPXnhBuRzqaot5YUyVqN9SG2cbkXN5i4xN36xEyy/6IdjqFIjWLaj8nN2V/DhYxkjDrXa
	tDxpvamAJXwj28bRMTA0SzAHdVMjHQs1ywSao/7KSaPoAnyUsM1PZ2ytJAA3uYZ6qevQy8cVH7u
	eJkpWvtRzUAlqKfgh8hT5M8WXmFzlNOjI+JOxTlgnFbVmcMjW+7Lc2gVlQd/UlmDaxWvk8OThVm
	aBI9jdUIHR3T/7Q5KgMRTN8GniOT+kI=
X-Received: by 2002:a05:600c:5253:b0:439:9274:81d0 with SMTP id 5b1f17b1804b1-439927483edmr22745365e9.1.1739886574931;
        Tue, 18 Feb 2025 05:49:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEbIbgUGTdKs4RbLRMUHgyS3KswQNUpYKHj2Muk5ABoJ1TDHXwhjXdXpH6iqPKRDpy3fOCyQ==
X-Received: by 2002:a05:600c:5253:b0:439:9274:81d0 with SMTP id 5b1f17b1804b1-439927483edmr22745175e9.1.1739886574551;
        Tue, 18 Feb 2025 05:49:34 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439880fbd6fsm49857355e9.18.2025.02.18.05.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 05:49:34 -0800 (PST)
Message-ID: <8c5cdd12a0ec80d43fe737f5d2c4600d5933ba87.camel@redhat.com>
Subject: Re: [PATCH 2/2] rseq/selftests: Add test for mm_cid compaction
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 "Paul E. McKenney"
	 <paulmck@kernel.org>
Date: Tue, 18 Feb 2025 14:49:32 +0100
In-Reply-To: <e9ef4c7b2b979aec73f948cab33b5b4c0af4a804.camel@redhat.com>
References: <20250217112317.258716-1-gmonaco@redhat.com>
		 <20250217112317.258716-3-gmonaco@redhat.com>
		 <822a9d2b-a9f3-45b4-8cad-077489015301@efficios.com>
	 <e9ef4c7b2b979aec73f948cab33b5b4c0af4a804.camel@redhat.com>
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



On Tue, 2025-02-18 at 09:13 +0100, Gabriele Monaco wrote:
>=20
> However, I'm still not particularly fond of running stuff there at
> all.
> If a periodic task needs to run now, it preempts everything else and
> should be on its way as soon as possible. A task work is always going
> to delay this, although by a tiny bit.
>=20
> Again, for now I cannot think of a better way without bringing
> workqueues into the picture, and in this specific case we have a
> valid
> workaround to reduce the latency.
>=20

Been thinking about this for a while, what about getting the best from
both worlds?
MMs already have a dependency on workqueues (async_put_work) they
simply don't wildly schedule them like I was doing, essentially, the
whole periodic delayed_work thing was the issue.
Substituting what is currently a task_work with a plain work_struct (on
the mm) doesn't look too bad to me.

We still keep the mechanism to trigger and regulate its frequency and,
instead of doing it from a tick, we do it from
__rseq_handle_notify_resume.
This way we won't have it scheduled for sleeping, never running or
whatever exotic threads (which was a potential issue with the
delayed_work) but we also keep it in a preemptible context with
frequency comparable to the task_work.

Running it in a work_struct would probably make the batch scan
superfluous, since we are talking about some 30us which can run
perfectly fine in a kworker.

What do you think?

Thanks,
Gabriele



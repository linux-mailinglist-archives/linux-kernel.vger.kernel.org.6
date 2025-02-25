Return-Path: <linux-kernel+bounces-530628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E71A435EA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABA6F7A8C42
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44DE257450;
	Tue, 25 Feb 2025 07:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1QmRmjt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DCF255E4E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740467122; cv=none; b=ObrJAL8jFtqKnPDe5UnziNtZQIePTAKbTKMs8tYl9i4/Y7nHiSEbr+Ml6t67EDvsrO/XaYhAZX02a122eXbwA+XHo3o9hzyKZaOB2/oQVNvbZxePHGEWrd7f0WG1FmJz10zNNUFYgivv74pk+qP5LkwLsyog2w5VuSU7MoNNKx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740467122; c=relaxed/simple;
	bh=R1KNPUbY8j4Sq6oeIttoOmOjA31pS82T/7gfy/E4qVM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OFfnw1tDbru4FPC+hVLzT8THCRuZPXn6E2/5Gu49F4B7T6yL/UsHJYgTlEEIwa4DWFkFBwf7WW/NmaJGSY+7l+jy634JM3LDP2N6pRmuTnsvvTF4+J+2c/Vx4VetLRm/6XF7R9Ymwgrfj5Bz29xSW/ypJPSfKuUcDZCM8+NaMj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A1QmRmjt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740467119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RqAd8VzJLJdLi2vhE9uzobVZxQDnUMPSVtoywsbMNzM=;
	b=A1QmRmjtUsVafLN/MgdxDJAGwxsACZ+xnO3HO8l5XcXFHfJY955ADZUUqhwwUxltYcyYcF
	qLuDiE+s2wqK+7SdX1MhXMJFbSkKwvIbCjNDe6jbIosIYa8EwEpb2HKbqRGQoUn+QfhfdQ
	wxmfKZE9h2EZTteUPFmNgd45u2+MjGk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-N8k3xWW8MUS-DM906JmchQ-1; Tue, 25 Feb 2025 02:05:14 -0500
X-MC-Unique: N8k3xWW8MUS-DM906JmchQ-1
X-Mimecast-MFC-AGG-ID: N8k3xWW8MUS-DM906JmchQ_1740467113
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f27acb979so4938843f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 23:05:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740467113; x=1741071913;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RqAd8VzJLJdLi2vhE9uzobVZxQDnUMPSVtoywsbMNzM=;
        b=p3+lCBgbKn1A6m+Y6mIQctr2ZMUULIeZ+ru5/8464N4ghfQxA7/IZkycesXIwu+xxL
         u1ZIUFLQ6DsyG9sHxh5PF5ZvnOoBu0xBvxrlB3+py8EfnyhdohmkSn3giOTHN2w/lP6r
         k2rVrD3s+A/TcJ4MAMC7kGGVkrNT9DnRmQJPmZda6SedgJPpC+v9VLqmFkVBa0nrkqxx
         69pKg9YrAibpX8hbjBluK1z82+MLa7X5PXtX/fhOlPfSfEZtz6zFytgSmJOxtt6TLdCs
         ePMuguARaZ+E4ioPVzgoO1SILqmMC0jFkvddzayvub8MkAG8OHvtrBpEBW7V6/Px8kMS
         UsMA==
X-Forwarded-Encrypted: i=1; AJvYcCUYzW0G6yKxAu4oNxOmDFIm/YwedVpgJHqWuemgAqC9tu6Dogn58jPWuHnGL9x3S6P/zkIKPUDxNvlyvTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtxZJPRKw5EcjAnpj2maQJw+EK8LSBEvsBRHDgm76H+OP18gAk
	356JNcuiTlL1owKotXOoB1rMZGAED534F0nhpG7tnzdqghmQ94JtAtKStFunonY3Gc/zB1Bblno
	ei21mD5bnxkSf5bEZq8YPeHL9d7feRFlKRrqivHoOwYOzB8zpfzfTQojoz4/QQg==
X-Gm-Gg: ASbGncv1NM67pztf0ZsPDq7pMUDi62IdZ3IQp8bROfNXuNSpwpP8BvSYtut+79gCo8G
	ip8t5Cm9IvvtatEQoQ6Wm34g5rgAnKzytlq2zpCwUXSfnNFWzLZV3mcnWPVTIdsr1tn7jSjlyQm
	h8X1gNJSKjnApieJ93Xp0GdHoi+ZGR/wJ5DOavhvX2Ojmzd9ZAiRjRWTbH1qDUdUEGno9aCKK0x
	6yTonK8+xHTex6sJ64RnfhRFGqRxmi/4ZjqzxyMsbPcaHPHAEjtmKiYdgmFEOCyOMg+BmYQYvFe
	SAxZIgM1eg2WmUN+k7V1Cml4EfMCE6a6VinvP7Ln6A==
X-Received: by 2002:a05:6000:4021:b0:38d:d0ca:fbad with SMTP id ffacd0b85a97d-38f70799a67mr15083107f8f.14.1740467112860;
        Mon, 24 Feb 2025 23:05:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9YMw5XzZ0+135wSW3pKEkRcXfBgZYV9S0B/g6AXHwM8JHp+AH7f6Vd9OX/q/N2jg1cQ9U3w==
X-Received: by 2002:a05:6000:4021:b0:38d:d0ca:fbad with SMTP id ffacd0b85a97d-38f70799a67mr15083077f8f.14.1740467112522;
        Mon, 24 Feb 2025 23:05:12 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02d5700sm131895635e9.9.2025.02.24.23.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 23:05:12 -0800 (PST)
Message-ID: <b8508fe41425dd7cd568ade401f2d2622aa343d5.camel@redhat.com>
Subject: Re: [PATCH v9 2/3] sched: Move task_mm_cid_work to mm work_struct
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@redhat.org>, Shuah Khan <shuah@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-mm@kvack.org
Date: Tue, 25 Feb 2025 08:05:08 +0100
In-Reply-To: <2bc76f69-901c-4d2c-bd75-64e757ec2230@efficios.com>
References: <20250224132836.383041-1-gmonaco@redhat.com>
	 <20250224132836.383041-3-gmonaco@redhat.com>
	 <2bc76f69-901c-4d2c-bd75-64e757ec2230@efficios.com>
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

On Mon, 2025-02-24 at 15:50 -0500, Mathieu Desnoyers wrote:
> On 2025-02-24 08:28, Gabriele Monaco wrote:
> [...]
> > diff --git a/kernel/rseq.c b/kernel/rseq.c
> > index 2cb16091ec0ae..936863fe7eb37 100644
> > --- a/kernel/rseq.c
> > +++ b/kernel/rseq.c
> > @@ -419,6 +419,7 @@ void __rseq_handle_notify_resume(struct ksignal
> > *ksig, struct pt_regs *regs)
> > =C2=A0=C2=A0	}
> > =C2=A0=C2=A0	if (unlikely(rseq_update_cpu_node_id(t)))
> > =C2=A0=C2=A0		goto error;
> > +	task_queue_mm_cid(t);
>=20
> Given that task_queue_mm_cid() will be called quite frequently from
> __rseq_handle_notify_resume, perhaps it would be best to move at
> least
> the portion responsible for checks (including the time_before()) to
> include/linux/sched.h to eliminate a function call from the fast
> path.
>=20
>=20

Right, good idea. Thinking about that, task_queue_mm_cid checks a bit
more than the __rseq_handle_notify_resume.
As far as I understand, as long as we only call task_queue_mm_cid from
__rseq_handle_notify_resume, it won't ever be called from a kthread (I
assume the t->rseq implies t->mm and not PF_KTHREAD but also by
construction since it's called in return to user).

In short, considering we already check for PF_EXITING, the following is
just superfluous:

  if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)))
  	return;

and we could just keep the time_before check in
__rseq_handle_notify_resume, perhaps adding a t->mm check just to avoid
a perceived NULL pointer dereference, which seems not possible anyway.

Am I missing any corner case?

Thanks,
Gabriele



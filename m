Return-Path: <linux-kernel+bounces-554614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AA1A59A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED213A6DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CF622F3B0;
	Mon, 10 Mar 2025 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGH6bg2C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490A222D4F4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622232; cv=none; b=ghpIj85x/1e13C65aJUBBHzWsFukuXCMiQtAHgWBT/US3Iv+MZc+Lm7PBfCoy68RRQO67aAX8we8nVmwgSmsm969hKrfV5uldOKqxOtqjXh5uXqCsI9QZveZljs5T8BxZVsaHnnQN2CwbXXoud9rleERCJHY80m0o21GN6K14HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622232; c=relaxed/simple;
	bh=YIEFTn4o/Wiywn2P5BXfgmgT1qd2QuZ4tLJW8Pp9+uk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kgHSHFD20tKGD4pXtgniiabQ0hlynNpaYxlthKrnt4SAKzCMJnVrhDKIZVbPfp09fooIqYCb4eQSAqQwwVw0P8dSwLO0Nb8dJa0fGBINq+potLF1dIXvX/7VxF+L6EHsfTrWd2bciDHm5To2zu/1/Yc5tb9i7hBvXFkmEx80bs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EGH6bg2C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741622229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YIEFTn4o/Wiywn2P5BXfgmgT1qd2QuZ4tLJW8Pp9+uk=;
	b=EGH6bg2C3IQoPFJM1z6fuxn1+AoXH30SN3SnalGFIBKF6pm0BGMclqn+1nBWmORPM9SMyB
	YnkYU6BcxKV06t8TZiz7bKdBnTpaZnKnevRrm3YBIfAiFDHPwJau2u2+C5QhA/DMD3UFSa
	Q6Un/01bJvdzrAoWi54Vs3IjygzUJOk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-Zyr31zlsP5e_C3YdMnWD0Q-1; Mon, 10 Mar 2025 11:57:07 -0400
X-MC-Unique: Zyr31zlsP5e_C3YdMnWD0Q-1
X-Mimecast-MFC-AGG-ID: Zyr31zlsP5e_C3YdMnWD0Q_1741622227
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43ce8f82e66so9123665e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741622226; x=1742227026;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YIEFTn4o/Wiywn2P5BXfgmgT1qd2QuZ4tLJW8Pp9+uk=;
        b=w1Yz1naFPXuGQXty5IwiqqZUAzhWaVsP2gBYtm2PhLfuTkjzYtskL0YssHdgDJNwur
         zOEN7uyID5LpfSgWLlq0PL8ObPOZj71GnMiAJ2B9PzPHL+h2rgCCSuqS7g7C3mICkv3D
         Z+xB85Jmfldi3W6OHppRsTGnLc2PyfTpR9qLX2BOG0ATk3X4F7f8IfeB0kcKdsdQ7tMT
         RjRN7yKtq0safVnSZ6DtPsA59suQhhkT/eE8ri9EjI2IDrddLChqPc3nQfLRAlq/F9VJ
         SfzDulMDJGRVY4aMP+pmPv30zTtUtddFdnh7K9nXD43L273PgK3ukqDxSQzYvquw9yY0
         0Usw==
X-Forwarded-Encrypted: i=1; AJvYcCWXgn1NLgCthas9s5gr8yIRX9uXqpE5kCzbUWl+JbYFph3Q7IVDfN2hEmtKTJ1IiDDZa/Phei3auDwtbxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJig6go9BzHbMXQtcf/sdnLV31TNfey1Jzd/RJwQ6mJ7oUreue
	Kme/nwJSf8oQhgfopjU5Gr4YwtRZO47TcLrOm1zWwTWXdahJIi4xCM0bFY4moR5i3fj4iMQcY/f
	2fvs6bAs3VqTRHHoCc0TBa6l1VyDhzBX3F78XpeyrBG03NA8Gs76DGk8VvB4hYA==
X-Gm-Gg: ASbGncttHsF0GOWH15wpNT+2/CQSI4+PIa8BPCKczAMMYXL9uiQxS9KnveQ7GJHRxQj
	6EirHg54raI/hosXIdTl/zg+lCsqKfr7xfUGJLyv4NahireRtZMMdnzYDUO0e2vP68MOvpoplgc
	tsoe4J5wd+Yx8tThFD+HW2fDQWS6bxOHk5Xk416G/Z6c+CKc8BxNs5HhjWIEsngcR4Cip421H0v
	XzzE7okUO4oUal1vgOvin45iH4l6dQsqfl7nHv8D8XcqJtr3jtTB+R6zzV1SJTGaLqlBcb8ox4k
	4POn6lRL9K2l4ycCzzHrUaAEcpOyI9329pAi/yDG6A==
X-Received: by 2002:a05:600c:1c9d:b0:439:86fb:7340 with SMTP id 5b1f17b1804b1-43c601d19cbmr100841315e9.30.1741622226502;
        Mon, 10 Mar 2025 08:57:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7Wx729XLbdYNhh5Uh5+ULsnmrD5hmJxoj3oRgjANDXFizew90DDJwcouqQiqEKExMdX97wg==
X-Received: by 2002:a05:600c:1c9d:b0:439:86fb:7340 with SMTP id 5b1f17b1804b1-43c601d19cbmr100840845e9.30.1741622226066;
        Mon, 10 Mar 2025 08:57:06 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cf8a840e1sm37754895e9.8.2025.03.10.08.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:57:05 -0700 (PDT)
Message-ID: <c97730cdf59fa4b32ee46bd22f3cc514deb0f51e.camel@redhat.com>
Subject: Re: [PATCH v11 2/3] sched: Move task_mm_cid_work to mm work_struct
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@redhat.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney"	 <paulmck@kernel.org>, linux-mm@kvack.org
Date: Mon, 10 Mar 2025 16:57:02 +0100
In-Reply-To: <31fa089d-1f55-4bc7-9323-389fda4cadfa@efficios.com>
References: <20250227153329.672079-1-gmonaco@redhat.com>
	 <20250227153329.672079-3-gmonaco@redhat.com>
	 <1c161066bcbc916ae9d97e7d1753ee12511da085.camel@redhat.com>
	 <31fa089d-1f55-4bc7-9323-389fda4cadfa@efficios.com>
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



On Mon, 2025-03-10 at 11:50 -0400, Mathieu Desnoyers wrote:
> On 2025-03-10 10:46, Gabriele Monaco wrote:
> > On Thu, 2025-02-27 at 16:33 +0100, Gabriele Monaco wrote:
> > > Currently, the task_mm_cid_work function is called in a task work
> > > triggered by a scheduler tick to frequently compact the mm_cids
> > > of
> > > each
> > > process. This can delay the execution of the corresponding thread
> > > for
> > > the entire duration of the function, negatively affecting the
> > > response
> > > in case of real time tasks. In practice, we observe
> > > task_mm_cid_work
> > > increasing the latency of 30-35us on a 128 cores system, this
> > > order
> > > of
> > > magnitude is meaningful under PREEMPT_RT.
> > >=20
> > > Run the task_mm_cid_work in a new work_struct connected to the
> > > mm_struct rather than in the task context before returning to
> > > userspace.
> > >=20
> > > This work_struct is initialised with the mm and disabled before
> > > freeing
> > > it. The queuing of the work happens while returning to userspace
> > > in
> > > __rseq_handle_notify_resume, maintaining the checks to avoid
> > > running
> > > more frequently than MM_CID_SCAN_DELAY.
> > > To make sure this happens predictably also on long running tasks,
> > > we
> > > trigger a call to __rseq_handle_notify_resume also from the
> > > scheduler
> > > tick if the runtime exceeded a 100ms threshold.
> > > [...]
> > >=20
> > > Fixes: 223baf9d17f2 ("sched: Fix performance regression
> > > introduced by
> > > mm_cid")
> > > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> >=20
> > Is this patch missing anything?
> >=20
> > I refactored a bit to have it build in configurations without RSEQ
> > and/or MM_CID (which was failing v10)
>=20
> Found a small nit. Please fix and resend with my reviewed-by, and
> that version will be ready for inclusion.

Perfect, thank you!
I'm changing that jiffies thing, testing a bit and sending it.

Gabriele



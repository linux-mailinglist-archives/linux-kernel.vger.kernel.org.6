Return-Path: <linux-kernel+bounces-445062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EEF9F10A1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A41B1882601
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82C01DF98D;
	Fri, 13 Dec 2024 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8z7kvt8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B1A1E231F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102915; cv=none; b=uEA3clFB9RBrL6jhxr2EhOaF0M0OlWleixsl9eOXRqQ+gM168Jy5+giwy9j6/qYi1d6uHE07AeLdj1iFmwHsfXSxXVPY9xn4ISBJMZxy21HjpqbX1MNskF1l+U/j3LCEfWl3TDRZ3GP4/Wa+7Cxh72E/BM3UttuYJwPIV3tFU5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102915; c=relaxed/simple;
	bh=+bc0VEUVGJvQF/ApL/kzgdgidEHyZEFRuTt1fwptRzI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qY+FpQyr0Xx0jnxzQInUILZmkfPDKrret0hxuMc8MuDjGL7NrM4w8JhranBE769lAhHhkKevLpzy12PIn4MiNNAxO5QdZNcfceFCDlx2B7+NZxGqufEkiUDbCEXHCpw5fJCU5U8Sc/xn1FDtQnIlU0pPE58oUpLFRhCk03b5qh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L8z7kvt8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734102912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+bc0VEUVGJvQF/ApL/kzgdgidEHyZEFRuTt1fwptRzI=;
	b=L8z7kvt83ZHGjahd/KrNRKUbl3wwWNOLr6BVx6YLyUqZ7C9E2/YcK0NvOujiJp98SqtuU7
	YHKtM3agD0Juu//FqODPwu8vwAKgXzSfJZqgZ+lGi7DnHAwVV6ygVvmtOmQ4q8n8eKYwp3
	E/Bsafl8W3b7ejw0EnGe5OYuIkY6KGg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-cwmKgGSXNRePfFm5z7i8kg-1; Fri, 13 Dec 2024 10:15:11 -0500
X-MC-Unique: cwmKgGSXNRePfFm5z7i8kg-1
X-Mimecast-MFC-AGG-ID: cwmKgGSXNRePfFm5z7i8kg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43624b081f3so16589535e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 07:15:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734102910; x=1734707710;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+bc0VEUVGJvQF/ApL/kzgdgidEHyZEFRuTt1fwptRzI=;
        b=C082ntVJLg1B/+393rCfm0jrqj318XxOFJGENp6GWVCmeB7BHl2CehI3fZxwmglsrC
         qPcgvR8PO0rrpbPgtWFoIfkXcJfNRZ8WIKR20BP0Uieq33mRk52/f60fxmonnGt6brDS
         dHg6GJwJFwAp6lFpZyBitFUScvpoEZzsEZGx1NzaY+r6atuflvYdUKV7c4odMTemv31k
         ZMyXI5NbhUXnZkbNlAA43zXabFbNbOBHGwbQJz8ulrfTFkTAOctXVQ2b2vInEt/bxgHj
         GEWa2ncA+dNwWEJd265D0ZNswrf8B1cLYLXR0/mS3P3LdtJ771pxaeatn2dvUu8noUSW
         q14g==
X-Forwarded-Encrypted: i=1; AJvYcCVcCXf8UgWzftGc30K3HRAp6xYYdg/pQkukMxOUGLgp7fFdIm3PWELSFfic1gSRincH52IBLUQMvYcp9VE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwerwbBtxO0arxMk2RwKAA6jAehB+G5TmFYeyuyHXp+A0U2aak+
	r1eR6FsAMnAT0MQomqLs5lh2JjCv4xafHwNA6i0Pq52b5pNOJ6744K3JvntOlx+W8TSruilDKjY
	vDI6G47XWEaKJDx2sH95vEmF76wbAsBL1T8/30WU2rH4bFrGdsUK3e/v79AbB9Q==
X-Gm-Gg: ASbGncsmXdO1oDdkHYdbXE1FweuLC7E4QwK2sBQzLjY5siMqL5hrLfjiN7FRy+drQt/
	wvY26Zrf5WgNL8LcrQPChzT31/dYZTl8AuUgU2Grux7u2mH9cJdoJZf2mQkrI5FhhFs8p9M/mP0
	xxchK418h/eyb3GFxgr1LJm7wZEAjTPlYNVDfMDu068lR4DuUUMa6ocBhfrfZA0blH8lGcJ2eqo
	8Ln8XXtGuREdr2iTG22cKU889vw7aIqQi/8fYIOifF3YEitcDBkmAT+1tyoagUI5VxodlA8tYZb
	+MJFjh0=
X-Received: by 2002:a05:6000:4026:b0:385:f07b:93da with SMTP id ffacd0b85a97d-3888e0ac2f9mr2575179f8f.47.1734102909847;
        Fri, 13 Dec 2024 07:15:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYWIrgfbDW5IkfdnLaPWCCW62trF4hAEdP0hve6M/+WtZExSw9QG/CI8XTusgIUMybdrIfrw==
X-Received: by 2002:a05:6000:4026:b0:385:f07b:93da with SMTP id ffacd0b85a97d-3888e0ac2f9mr2575156f8f.47.1734102909483;
        Fri, 13 Dec 2024 07:15:09 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559ea75sm52049805e9.19.2024.12.13.07.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:15:09 -0800 (PST)
Message-ID: <f1286fbe772f331da885e77b80793c9cd12c0893.camel@redhat.com>
Subject: Re: [PATCH v2 1/4] sched: Move task_mm_cid_work to mm delayed work
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	 <vincent.guittot@linaro.org>, Mel Gorman <mgorman@suse.de>, Shuah Khan
	 <shuah@kernel.org>, linux-kselftest@vger.kernel.org, Ingo Molnar
	 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton
	 <akpm@linux-foundation.org>
Date: Fri, 13 Dec 2024 16:15:06 +0100
In-Reply-To: <5fe473bd-600e-447a-a321-cae3d838268f@efficios.com>
References: <20241213095407.271357-1-gmonaco@redhat.com>
	 <20241213095407.271357-2-gmonaco@redhat.com>
	 <5fe473bd-600e-447a-a321-cae3d838268f@efficios.com>
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


On Fri, 2024-12-13 at 09:14 -0500, Mathieu Desnoyers wrote:
> On 2024-12-13 04:54, Gabriele Monaco wrote:
> > Currently, the task_mm_cid_work function is called in a task work
> > triggered by a scheduler tick. This can delay the execution of the
> > task
> > for the entire duration of the function, negatively affecting the
> > response of real time tasks.
> >=20
> > This patch runs the task_mm_cid_work in a new delayed work
> > connected to
> > the mm_struct rather than in the task context before returning to
> > userspace.
> >=20
> > This delayed work is initialised while allocating the mm and
> > disabled
> > before freeing it, its execution is no longer triggered by
> > scheduler
> > ticks but run periodically based on the defined MM_CID_SCAN_DELAY.
> >=20
> > The main advantage of this change is that the function can be
> > offloaded
> > to a different CPU and even preempted by RT tasks.
> >=20
> > Moreover, this new behaviour could be more predictable in some
> > situations since the delayed work is always scheduled with the same
> > periodicity for each mm.
>=20
> This last paragraph could be clarified. AFAIR, the problem with
> the preexisting approach based on the scheduler tick is with a mm
> consisting of a set of periodic threads, where none happen to run
> while the scheduler tick is running.
>=20
> This would skip mm_cid compaction. So it's not a bug per se, because
> the mm_cid allocation will just be slightly less compact than it
> should
> be in that case.
>=20
> The underlying question here is whether eventual convergence of
> mm_cid
> towards 0 when the number of threads or the allowed CPU mask are
> reduced
> in a mm should be guaranteed or only best effort.
>=20
> If best effort, then this corner-case is not worthy of a "Fix" tag.
> Otherwise, we should identify which commit it fixes and introduce a
> "Fix" tag.
>=20

I will definitely make it clearer, but I'm also not sure if the patch
is actually a fix for that.
I wanted to mention it rather as a nice consequence of the change. The
main purpose for us is that it solves latency issues in isolated
environments.

From that point of view, it's still /fixing/ the latency spikes
introduced by that commit, so perhaps it deserves the Fix tag anyway.

Let me know what you think about that.

I'm going to merge this patch with 2/4 and pull yours first in V3.

Thanks for the review
Gabriele



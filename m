Return-Path: <linux-kernel+bounces-430741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1749E34E4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C149161DEE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F9718C034;
	Wed,  4 Dec 2024 08:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAueKe+K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5146C17E017
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299307; cv=none; b=QYBeH6KszrnefCfLLVL6YvuRyaaFjN49N0+dB/pKTwSu8pqjEb0okMRjc39+eFodoakwI1JcQyRAgXExX1+fCOUrRMFRz4v++Y/Kt8TZThGfAE90zDONZ2kjbbqty7AJcQuZ4Hnn7ZiCbgBt7aNne4RoGhSQ6dsbBn+ByaGkl8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299307; c=relaxed/simple;
	bh=waJ5W/yBO4GBh8KGfnv89gd1Yly76ZZNZhG+kal27XI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AhUPEtAXcSXMeUAZ2Rk2Hlkf3kbLXA5HY1QfZAY0Abcv7LRhlapoejauikpd8KSsPKBfiJspSVBX7JqKtSmQrqL5ajl9wKAlgPN/og2D8zi/Dk1J+IVghTLqiY3sUqOOi/evABH7zCFvxAGX+BtoIIGT4ypVnD2u85Z18KhSpBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dAueKe+K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733299305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=waJ5W/yBO4GBh8KGfnv89gd1Yly76ZZNZhG+kal27XI=;
	b=dAueKe+KmLUud1eWZe2LbRvJsB3FmHIATtryu60pw57ttwMjzSRa8bMRomlAO7erOo7/vP
	930o3mb/KYnJPjdBEGyPUHKWz1LDa0P3QauRj51QMioHN/LNq5qqLoYbLKrbDLWI0sUNHB
	juDj+qMJ1DqInmwCcePfQ/yim3vjIgs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-n-B6n2zEPnSNtfOGu5CvRA-1; Wed, 04 Dec 2024 03:01:44 -0500
X-MC-Unique: n-B6n2zEPnSNtfOGu5CvRA-1
X-Mimecast-MFC-AGG-ID: n-B6n2zEPnSNtfOGu5CvRA
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d884999693so73266696d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 00:01:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733299303; x=1733904103;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=waJ5W/yBO4GBh8KGfnv89gd1Yly76ZZNZhG+kal27XI=;
        b=juHYxM0keCdOwZtFWIGvgdLseMTZ9EpqvNAeah8z5hGSgwoPN2ntc3fCItBUIC0ZTd
         pLg6qjSJMCIzzH8GrLXcc+ejeicNmn2YjgFzuM/RYmKymsaxTXfFkT5WyBRvgf3BH7qj
         lS6VJeIOYS3QTiWovu7mb5yGudU8oP8wIaD9fMofQqvRaQPrFebIRhsy0mxjxdG+7AML
         RAcAiCteEGa2MHPLB3SkItaIzAGYDWMLbKrBEE1p7cIDhcj/hLUjkVzgkWo2kPS3+f/t
         aOV2RCT+4+Rc0yF0xk2SwGKGmvcZSUDMxY8LMoiAvJ6PXovbV0Y+IyPNlFYslagigPgH
         putw==
X-Forwarded-Encrypted: i=1; AJvYcCVgbe7NZh7QfdqMNlBrGWroJ40PmQUIpGTGsrWNnHcV02EGgS57rMJFhsvcW+drv4cxGfFaLVaPl/dNzQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaT44rkfYYzhoBCVKP6tkoEt/5yC/n76VL20D0Qg4WLuHFptot
	/4YvviYego3EdEsU7NQwEMJ4T6l7ZaNo5g4Icvi29XnbNnCZbLuGg7wod/VcmHDs4BRg4FnI74a
	tvYsZ1XhOXkH5iU7lPp0lazS+/scro134lyKcNy74JT0gVs3fLm5VxtYQr0HCwA==
X-Gm-Gg: ASbGncvZlt8RRWJHZ5PbKqsono7t2PV05zqgctJQuq8Uz5FmG+tpRO5I8UVllJfsHiJ
	7poD4Js+rC/yEn73cGQSU1oVfIzG9m3/hRst6UIV0qZcxbAL/DjYmfQEfF/CVCnho090K7qnBr6
	PfKYrAej4l/oD1EcPBpwAPCtGlCy9VROkc5M1h1IX+hpfqMlKLIBWJi95dPUyOtoql3nY8+ROLH
	Kqa8a+hUBH0/LZXQqTLGniygk7pUTAd0cuwdW0LYN5rryEFDrzDU2wpd4zvj/z9FvWX9CdxVm6J
X-Received: by 2002:a05:6214:2aad:b0:6d8:8fdd:9791 with SMTP id 6a1803df08f44-6d8b73b65eemr99368376d6.25.1733299303588;
        Wed, 04 Dec 2024 00:01:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhiXpMva47idGqFj5GtbBNZmdu1R1vo3wasWbHy6+dTkb4iz+yeUGZIRXwuzqkuGPteOIYbg==
X-Received: by 2002:a05:6214:2aad:b0:6d8:8fdd:9791 with SMTP id 6a1803df08f44-6d8b73b65eemr99367886d6.25.1733299303243;
        Wed, 04 Dec 2024 00:01:43 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8afe44481sm25181916d6.72.2024.12.04.00.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 00:01:42 -0800 (PST)
Message-ID: <81cc8be1b5fe76a3323c2990994442f7e7959629.camel@redhat.com>
Subject: Re: [PATCH 2/2] sched: Move task_mm_cid_work to RCU callback
From: Gabriele Monaco <gmonaco@redhat.com>
To: Joel Fernandes <joel@joelfernandes.org>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann	 <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall	 <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider	 <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, paulmck <paulmck@kernel.org>,  Frederic
 Weisbecker	 <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Uladzislau Rezki	 <urezki@gmail.com>, Lai
 Jiangshan <jiangshanlai@gmail.com>, Zqiang	 <qiang.zhang1211@gmail.com>,
 "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Date: Wed, 04 Dec 2024 09:01:36 +0100
In-Reply-To: <CAEXW_YT1NLU2xsBHwDjbBPg_rZWc4hNGNgmkdxF8C_0Dw60N1w@mail.gmail.com>
References: <20241202140735.56368-1-gmonaco@redhat.com>
	 <20241202140735.56368-3-gmonaco@redhat.com>
	 <c16481a7-20f1-44b8-981c-fd31cb331cbf@efficios.com>
	 <CAEXW_YT1NLU2xsBHwDjbBPg_rZWc4hNGNgmkdxF8C_0Dw60N1w@mail.gmail.com>
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


On Tue, 2024-12-03 at 10:00 -0500, Joel Fernandes wrote:
>=20
> Also there is no guarantee that RCU callback will run within a thread
> context (example, some configurations run it in softirq). Further,
> call_rcu() usage as shown in this patch can also delay callback runs
> by seconds (with RCU_LAZY enabled).
>=20
> See also #5 in checklist: https://docs.kernel.org/RCU/checklist.html
>=20

Thanks for the tips, I get the RCU callbacks are clearly not the right
place where to put this function.
I'm working on a V2 where the same tick is scheduling a new work_struct
in the mm_struct instead, let's see where that brings.

Thanks all for the constructive comments.
Gabriele



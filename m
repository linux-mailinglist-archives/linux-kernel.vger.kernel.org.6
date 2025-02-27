Return-Path: <linux-kernel+bounces-535679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97A6A475E4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA043AF727
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4EF21A44B;
	Thu, 27 Feb 2025 06:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WnoaE9Jo"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491E61E1E1A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 06:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740637250; cv=none; b=DMhkCEIK7lPo3dB1gNCMQBWg6KqzOuSU4DCbvGfRYzK3A2I05CDfXgkhXL2rseWuYkFnjStIifUXt+d1dLP/2M/1E4ApOtrrAt9NpTq1a5fyeIw9BKxpY9bXRgmDS0tXgZbB+DoYLzOm/VJqh8fxwSoxEirGd4t7Jd/ZpBchlwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740637250; c=relaxed/simple;
	bh=WLrZ6UcPbJVjrWmzvaD3wu5SEFqavsc6nlPmJlG4PWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLzAlsQOysnUuP6gBMCoWf4plSryBnASrZC1Zx5JMIXXsSadY6NxRR+0rZwuJB9xIeE7AH61ilDIz/iFWSDuWfOIPWDasFwfwNOrGrPFof+f7kTz30A9CworERxrZK1FBi5ODMzLeGvJHXHIwwgk6azxJqs3oHs9RN1WIFXtLFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WnoaE9Jo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-221ac1f849fso73295ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 22:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740637248; x=1741242048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLrZ6UcPbJVjrWmzvaD3wu5SEFqavsc6nlPmJlG4PWY=;
        b=WnoaE9JonqpZmprFGoujrikSa2DoLDVe0VD2n89QEcJxtYE+9qQnK4FAaqzT/v0Dgw
         tHHtC0zd/8w0jAFArd7CdRuWq64myvI5jDm0iTkXtDUYOzYrQT4yVkAWo99+ZOAs+aaD
         1U8pjyKlR7xlJdvebzHHfl0iKAQv28NWdEFfoPtzNlLCwtZLPg2aHIu9nnq/2nX5mc+Q
         lzEE2l9rs7Y/Tbgxz/DpZGsdRtyk+30LFr2YASS6Bc7Khp08sr/4sysF8eMorJXOd1p1
         w0rPIZ0RtfoS/xsSC+VjGTmc0HTn17rZp7msimn1G6aXK7oD9poV3S1pRJkqQhZ5rkYd
         Vp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740637248; x=1741242048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLrZ6UcPbJVjrWmzvaD3wu5SEFqavsc6nlPmJlG4PWY=;
        b=gtObSFiqgAS+57uO71gXL4gnY/QBCCpAE89IWgqPM/AOzRH8yBEW+JaMOjO8vvqLUI
         plb0rSAB8XxcScBxfz71GRVECe4aN0NWQ3Iojv8eDp+j4MB5NYEtkYL+kbE3XP75QNeY
         KBdBdRUFYroGr0kvdJ0RpNUtqeOiqFQiWincSBCLWZYTNjySyEXVcnT7F2jou1MCANqW
         gaMUqrsEmFtYKE5wotVt7RP8svj95CI6cYoqeBqgpffb66oeroGJwwyuJ3os4m9WUKa0
         TYbS3UjWkauQZSKNgXp3yntFTTWo3rG3/+9AfMMGgESKV3GSjGkgT3df1KVuMPzCqXS1
         Gs0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8TfWwqJ9/oN10NXtnlGltvTy/vwht6Bik5i7cHrIz116Kv8abxEyuUBoqrE1c84PLD4H/5hHvZELiQjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGY6UE8qvvHjbMjsHzi+dGCSlKv5Hnz9eLUz3c01gts9L1dvTZ
	7BJtYCP/QdupoIDbcgBYC56ud5V7ZoYgEQ56T0VpjMrJS6FQPveNgU9mPiu2+3ivzYTYSSEIR2e
	vLpKnn/3H4GpZm0bYNuMozZBS4R6a3ZE77mFn
X-Gm-Gg: ASbGncvDTXzKr9JtDMbP/My5eY4GLuhhkLeqHKysX3MaY4n10zU99ZD99xkowTRk0in
	mVX7YGM7GcLlsBwIslZPr8JbRDtgjAoH3elEMnyX0YTmcuWs/1s2p9pLtCIBx9tVjjLQEfAJDPy
	Bscfv6cRMU
X-Google-Smtp-Source: AGHT+IGWdTsjnNh0jvb72T9x8Sr7SE8t6FOt9DonXZW94PRF9kuZCf+jYLdiAC+H6QpW0xl74NslSGi1AKxbAeAHFY8=
X-Received: by 2002:a17:902:ce8b:b0:216:21cb:2e06 with SMTP id
 d9443c01a7336-22351753476mr1195355ad.19.1740637247911; Wed, 26 Feb 2025
 22:20:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227053738.788153-1-ctshao@google.com> <Z8AAcZXtuD7O3TAV@tassilo>
In-Reply-To: <Z8AAcZXtuD7O3TAV@tassilo>
From: Ian Rogers <irogers@google.com>
Date: Wed, 26 Feb 2025 22:20:36 -0800
X-Gm-Features: AQ5f1Jpr4a2BZhNUtWT9jhoDoUHEh7E9i7XEn4hL2DIo6HcdtdZc_Tj2IMANX7E
Message-ID: <CAP-5=fU4rVkTS07Uq8g9roO4kXq_z2R0CgMX55YFXFWMHzWTGw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf record: Add 8-byte aligned event type PERF_RECORD_COMPRESSED2
To: Andi Kleen <ak@linux.intel.com>
Cc: Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, terrelln@fb.com, leo.yan@arm.com, 
	dvyukov@google.com, james.clark@linaro.org, christophe.leroy@csgroup.eu, 
	ben.gainey@arm.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 10:04=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wr=
ote:
>
> On Wed, Feb 26, 2025 at 09:34:06PM -0800, Chun-Tse Shao wrote:
> > The original PERF_RECORD_COMPRESS is not 8-byte aligned, which can caus=
e
> > asan runtime error:
>
> It seems pointless. Most architectures have cheap unaligned accesses
> these days.
>
> Just disable that error?

The perf_event_header in perf_event.h is:
```
struct perf_event_header {
__u32 type;
__u16 misc;
__u16 size;
};
```
so it is assuming at least 4-byte alignment. 8-byte alignment is
assumed in many places in tools/lib/perf/include/perf/event.h. We pad
events to ensure the alignment in about 30 places already:
```
$ grep -r PERF_ALIGN tools/perf|grep u64|wc -l
32
```
Having sanitizers I think is a must, if we allow unaligned events we'd
need to introduce helper functions or memcpys to workaround the
unaligned undefined behavior. I think the padding is a less worse
alternative and one that was already picked.

Thanks,
Ian


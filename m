Return-Path: <linux-kernel+bounces-522708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118ABA3CDAC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFFD73B905D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88B225E45E;
	Wed, 19 Feb 2025 23:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OQqBPZyE"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21701C5F35
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007947; cv=none; b=pWBSJCJkQxPAFhax+nF8+z2Dq+V4OWBb23TxgNpSlKnpBS21NFnLuLRFQ31o5x5ORVeeQnwsi0f4ydmtVi15eOZb+xd39WKsxyq5GiBbGCs4HldUogPG/rSpjJqQ0Opr12rkjbWb0IyoOlNjcVX0ujwil0NoIELn5gmg5n0cBek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007947; c=relaxed/simple;
	bh=JsuY5aEnKTjWIegGtTXkzfenE0PnT/5RTkOFNi2Wbr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c89gkx8MBTUzvG13E3VEh15vxKGSyqPPnD+Ax5DIpZwH2VDPnwthdGvD16zc8TdcW5AX8qkxzrhn0Mr42wlyuaoWUGZri5eh515nc5yXVGqdYCG074tmM1ZhjbS9nt9lgD2iZjoeOwvRaP9X64tvSqXXJJrs/FZxe8a7+jMvNF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OQqBPZyE; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d1925db9e7so51475ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740007945; x=1740612745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RxA4eu4dfq7Zk/1pUhMY39No8gQgsfAHQ8YKi/sOm0=;
        b=OQqBPZyEs799NwJYwyZS8KVUW0aepoDMJaLS4iRzOLOrtV5u7PmYbhMQlj57qBaIk6
         g5VFj/9CjKXVfDaYxza9SCdkTWNB9x80YbXn+BPUN0AlTIEnc1Bx00YcmeE8/pgoQOCz
         RUxrhmiKDzSnPCDNk8cWQlh4q/opjGZTY3h2PURzwyufXKcCHRw3IrPesBnVO0Jgn3mT
         c+BgkVxIECrCakBq/RvHJx0ZjYwKEtJkMy2WdDAssP0pHC4B0r5++RyYDevvXb5BMlKT
         meCZSieSWJ9+jAJp4dGiO1h47sE+BTNqxbtUu95ArrTSGBAAcYIY6Ky3YwjwZVrRN8M0
         4U4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740007945; x=1740612745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RxA4eu4dfq7Zk/1pUhMY39No8gQgsfAHQ8YKi/sOm0=;
        b=OFL2ejGPOdpuVWvpkI8VJ3HLJreVVuYTSQdNSliqwsYK7DY9qnNTNNeWlna1mhvffM
         HqlTXNZdc1BnerM1bCj4yLxPkAbSGJWakUy7otCIpXaxfvd6EbHrVYGhoF9ba73OHXH2
         8UPvsaDD2+dsdKfYjqivzbsebODx9KgKy/Xj8naeQ2Lpv5UT7FL8X6XWhp+Sq0RG1jSw
         0Fn3qYKeakQ9t+kau+t2gf6nSgHEtMIf0zEEvHBqEbYkFtR/0XDSyNY2MuE+tq9KC9WV
         lTfLff0nsqxlGfE0LpHTkNnNF909PSN74ExaKjR2dXj/Uk1FcSpJY/sP82pRb9Fs5lPK
         FBlA==
X-Forwarded-Encrypted: i=1; AJvYcCXO/LjoRv4z+FnrmPA71OZfk4sRCVluU0vJiA+97DgkBIPOZjZ1Elz17kF88p+Kp/ApzMTH2beGeRgkCTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqk6OtdVSvlvNyqMwsfXGlp0U76b81of06QQ8PYpusylMZldEp
	5wL0FRz2/nPDguUgSVM2u6tjzoL1tF5jdNx5TswT5scbdTfDcmWmc5DDFX6GBsjhTUC/0CsUqqb
	A3s/gOKU2lsDd9E98fQUrcSufMtn8Q5Lxx6Qc
X-Gm-Gg: ASbGnct3kFl+S00cxM/ZvufsEV3VIpykMvo3fCEWldjar2W3cr+VQM4p3vSfFPhEGOf
	K8fRP7YO1HSf7oWFddqioKDcocuE9V421jqWs/8IW0s0uusVJIfULRpmJIRstUTUcR2arCelPvA
	Lbd6P2esKVWLXZStoH0hCvwImshQ==
X-Google-Smtp-Source: AGHT+IEYCkfJ1ZVGVS5yNULY/6v2ccbPdb6GmoCQPY2XQXgN3GgKXem7vryx+NCZihS3hzRZVe+ZGvhMO1UuJUsNbI0=
X-Received: by 2002:a05:6e02:2193:b0:3a7:c9eb:accc with SMTP id
 e9e14a558f8ab-3d2c0af361dmr1166825ab.14.1740007944860; Wed, 19 Feb 2025
 15:32:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z51RxQslsfSrW2ub@google.com> <CAP-5=fWzzWqNAgmrDHav63Z+HMnSP0RZJ3Q7PQpuzP7Tf_HP7g@mail.gmail.com>
 <Z6FcHJFYGc7HzSna@google.com> <CAP-5=fW9f2mxuTV2FGCdhKm7M9g8v6VsLJJXTPTLRr5tUv9rOA@mail.gmail.com>
 <Z6LFp5jiED7_-weN@google.com> <CAP-5=fU6WSOK_N0NoLcMSSdaWAkdC2DUBwLqsLn_KA7m6dJyeQ@mail.gmail.com>
 <Z6RD7NuT9IPhOkIV@google.com> <CAP-5=fV8rRMQyMDuy1vcxyEX9Gf8x0QJdVEP-K5krBec_A7mpA@mail.gmail.com>
 <Z6WPmYCJcc6pPKDA@google.com> <CAP-5=fU0263rZx+i_dpeBWVUiKHuNNp4ER7WhDe2zHPUsq=wmw@mail.gmail.com>
 <Z7Znm47DJcpAsvGI@google.com>
In-Reply-To: <Z7Znm47DJcpAsvGI@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Feb 2025 15:32:12 -0800
X-Gm-Features: AWEUYZkz89bL95SHTcyTv0XZuZJQ49X-HSItX_LXicReGoMS2frdXtXZWQMqHd8
Message-ID: <CAP-5=fXCzwWOJMTfxDToSxsr9Ox9KjXtNXkpLhdS5CpSzG4RUw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] perf parse-events: Reapply "Prefer sysfs/JSON
 hardware events over legacy"
To: Namhyung Kim <namhyung@kernel.org>
Cc: Atish Kumar Patra <atishp@rivosinc.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, Leo Yan <leo.yan@arm.com>, 
	Beeman Strong <beeman@rivosinc.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 3:22=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
> I'm ok with preferring JSON over sysfs.  In general I think they don't
> have the same event names unless you want to override one.

Thanks Namhyung. I'm not clear, what's the plan for this patch series?
I know the clean up parts of it were applied. Are there any actions on
me? Are there people to solicit feedback from?

Thanks,
Ian


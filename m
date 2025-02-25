Return-Path: <linux-kernel+bounces-530357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30467A43272
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF4D189A1C7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F4D1CD2C;
	Tue, 25 Feb 2025 01:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JU0PPyRl"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823A53209
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740446771; cv=none; b=Z07c4DKMtlZcrBDlFfR7p5Kjty33/9F3GvVv+NIWx2jyo2qtBajrk6etoOXiCpE44rwfgV2tvRWq6yTNbinbajZAmNHVQDe6bPv8aTpgcAcrbGHcsLwaYjklvxRmKQHF8OfFT/gWUZ5hc30RM1dzqNmTotIcLYf3/DVqXShkDNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740446771; c=relaxed/simple;
	bh=hfq5eDNioKtLkWHINnwuIrPBC9aQyX4oQ59oQWB1fDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rmHGfQiFKvN09MnNv0VSb9Ag14WYPfxg5THz14TJ+LfBrV9KEeefKDlenPIF87Ewzazrww4j9P+VJP5YeJ35Hd4Rkef/5kWMzg5Txpj92bV1F0v6UO1XjrpcApH4kJve89aqYMakvi6BHfwAMvqB/Jgylm7eF30tWLqwjebb6Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JU0PPyRl; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-221ac1f849fso41115ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740446769; x=1741051569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgxndzGjlSlaXDyh3XBK97TDI3RlMhgPpDRBr5d4hMQ=;
        b=JU0PPyRlYoMp5hQIKp+hvJkENpcAPpFSLvtwlaqnzMWnoLiezocMOQicVWGwokIMwv
         jfZv8T3ObrcrNfsRRkvdOvM+ZFBQmHUsrSO5qwX7GYPpH4iijF6N1oPKQvtiS4qNFY8C
         rODQwR76Y28NFD+wah2TZ2sDrLfLGmXlagShpZcU+YebllSiSL5s07Tv4uh+Y4kf23BE
         UEXHCp7m3Nis1rb5G8E/WMJLfiGU9dZDAHtWtJ3/a5QKW+6ZVJz70b+IRRPgHCtAn2qv
         i8+TLCrdw8BNvTvmf7Hrh9Jl9Z0i7DfpAUSfTVl8PHo6SrvZNqplijsT6TW+XvwGy/O5
         oZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740446769; x=1741051569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JgxndzGjlSlaXDyh3XBK97TDI3RlMhgPpDRBr5d4hMQ=;
        b=lyOtgk055BrcgWWy9TVoI6bLtjcq5j1vBtPb119AlFDAl40elcYtJMTa0JT2uP/ix5
         Kzd+avYBCFoxOuvR6TMcEsSMIRpOW2OeKhBuQ2v1otOWNlRE7nraSoEyYXqDzAzRqiWW
         Q78+PO5T5Kv3n6ALgIkFBSxVubbEH32jofZiIh4fdEPtf+W24CDEDtgqjv/xD8SugzA0
         7h0C2E8D7XuhO0MRWOAamCijVfcB7F5iNzX/Z/fmLVuqNOgssYJBkxOUhF4az0hxR0p/
         JbVSNw/uU5AgYFZ+UcWPuntZqCJ22Sx+ACVtgX2ddvtojM/hU/2nt0NGaizmVbJOEDV/
         MasA==
X-Forwarded-Encrypted: i=1; AJvYcCWt4d2oRDDTPp2UHg2Z+iWOtbpn5N4R0iaR2jgaMD9SRoe7Im0sYI8L2JPjobnqrbFxGeg6hqmIT/LCBhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx2hdPQ3gcr3U2atROwbLWa6E/+hxL0tTBYdjSfzpEtp4Ipsi5
	nxgUo6zpGi5tFco83Z24GGbzovKqyTI3UeS04QbQt1ADseFT202e9xZG/V2/Jj9zgO7JQN2ccKQ
	bgsyGvCAff/2vnXWOySCbNuETmX6LUTO1NFFx
X-Gm-Gg: ASbGncscZmE7MXfQcayuCbxmCLN3XRJNpkWZy4mnCv2Xukai6TXBKvwF8jr3UraSHu5
	6pwSgm02f9Kc3Op4OxcE4bz0Do5H6rLkih29NAEs3d3iYpbuX+QO+wSx5S7/2WczKMVxuFEhlao
	u3YY9o8uii
X-Google-Smtp-Source: AGHT+IEu/ac0Ot7cbDh2jJe/F41X9Vert1eIl6k/q+sXL9pVLRZb34FeW/KFffe09nTG6uJTb8mY28cNyXJPD6b/pU4=
X-Received: by 2002:a17:903:1d1:b0:21f:3c4a:136f with SMTP id
 d9443c01a7336-22307aab649mr1697915ad.28.1740446768416; Mon, 24 Feb 2025
 17:26:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222061015.303622-1-irogers@google.com> <Z70OqFzD2JcbhFtL@google.com>
 <Z70PHtvzjHDLx42A@google.com>
In-Reply-To: <Z70PHtvzjHDLx42A@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 24 Feb 2025 17:25:57 -0800
X-Gm-Features: AWEUYZlPfIbadQ9TYnETkNFQse6dMCgB4ETEKljJtCoXZLlUEI-WeE_kLBiuHmw
Message-ID: <CAP-5=fU68UPSQUDtT860myabmYu9i4Dt5gJhtLCq2XinDjEToQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Add io_dir to avoid memory overhead from opendir
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Sam James <sam@gentoo.org>, Jesper Juhl <jesperjuhl76@gmail.com>, 
	James Clark <james.clark@linaro.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Anne Macedo <retpolanne@posteo.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	=?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 4:30=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Feb 24, 2025 at 04:28:24PM -0800, Namhyung Kim wrote:
> > Hi Ian,
> >
> > On Fri, Feb 21, 2025 at 10:10:05PM -0800, Ian Rogers wrote:
> > > glibc's opendir allocates a minimum of 32kb, when called recursively
> > > for a directory tree the memory consumption can add up - nearly 300kb
> > > during perf start-up when processing modules. Add a stack allocated
> > > variant of readdir sized a little more than 1kb
> >
> > It's still small and hard to verify.  I've run the following command
> > before and after the change but didn't see a difference.
> >
> >   $ sudo time -f %Mk ./perf record -a true
> >   [ perf record: Woken up 1 times to write data ]
> >   [ perf record: Captured and wrote 1.757 MB perf.data (563 samples) ]
> >   74724k
> >
> > According to man time(1), %M is for max RSS.
>
> But anyway, it looks ok and build is fine now.

Thanks for the testing! So doing a regular build I could repeat what
you saw - basically the opendir isn't contributing to maxrss as the
BPF handling and so gets lost. Doing a minimal static build, that
loses BPF support, things were clearer but not as good as I'd
originally measured, 10880k reduced to 10696k - a 184k saving (raw
data below). Perhaps opendir got better or perhaps there are fewer
kernel modules. I tried heaptrack but unfortunately it wasn't able to
instrument the allocations in glibc's allocdir function (it reported
0). Originally heaptrack showing opendir allocations were significant
for `perf record` was what led me to this code. At the moment BPF
event synthesis and topdown event checking look particularly
expensive.

Thanks,
Ian

Before:
$ sudo /bin/time -f %Mk /tmp/perf/perf record -a true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.489 MB perf.data (107 samples) ]
10880k
$ sudo /bin/time -f %Mk /tmp/perf/perf record -a true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.489 MB perf.data (106 samples) ]
10880k
$ sudo /bin/time -f %Mk /tmp/perf/perf record -a true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.489 MB perf.data (109 samples) ]
10880k
$ sudo /bin/time -f %Mk /tmp/perf/perf record -a true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.489 MB perf.data (102 samples) ]
10880k
$ sudo /bin/time -f %Mk /tmp/perf/perf record -a true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.489 MB perf.data (106 samples) ]
11008k

After:
$ sudo /bin/time -f %Mk /tmp/perf/perf record -a true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.473 MB perf.data (106 samples) ]
10820k
$ sudo /bin/time -f %Mk /tmp/perf/perf record -a true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.473 MB perf.data (109 samples) ]
10696k
$ sudo /bin/time -f %Mk /tmp/perf/perf record -a true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.473 MB perf.data (98 samples) ]
10696k
$ sudo /bin/time -f %Mk /tmp/perf/perf record -a true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.489 MB perf.data (98 samples) ]
10696k
$ sudo /bin/time -f %Mk /tmp/perf/perf record -a true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.490 MB perf.data (110 samples) ]
10696k


Return-Path: <linux-kernel+bounces-402922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5309C2E78
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 17:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2DC42827A0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 16:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA15719D88F;
	Sat,  9 Nov 2024 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fBrBWMda"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74095185B62
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731169594; cv=none; b=egFgUeLRK+4gtPfOg1gg/i2a5qX7XOMj8Lz8a5jB5X63YfkB0YBLAWj6ncMUZrTmcY9M+Ze8qfYjl6o2nJtA55ZguPfMaOMaLXEVIbhUa3DfosOlUpGlwITNabSUht+5i0+G0Rnxgn3JKe5ikOa/nNxcpWDZP1Id6HwiM+2MrTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731169594; c=relaxed/simple;
	bh=X6DcOIRSVQ8Nro7YUsDb33yJfvUboXkH+318jBl2QHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhxRvbn1EAWM9Yp3qoB1i5bj0Ty0u0wJowmPFGbwHuVSId/rIPGpiQRLHlwDmV/zuG3wJvaJoq8d5DaKmQ8L4yAmkNNLGolm/wE5K4aUJZFeUlBS6FYNau4qiNODh+v364PkLjWYj8P2OucR+NzNcJqvLdrjalYSXg0Kq7ptHsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fBrBWMda; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a4e4776f79so118585ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 08:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731169591; x=1731774391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yfKzpu2F7oD0EL8nuutwuKfU/qe3AxHeqS/JVcWCfk=;
        b=fBrBWMdaX389DGv9yj9QDaCQ6BPSiwkxe7d2WGMLy9wd4S4I7z0+Oeph025jSoWSkA
         eN99eT1Cfn+du6pPZg1gxfF8eXUmQc6jOZ+jh/Rgk+2cU35a1d4RPZt1KsWr1/64GUQf
         LNy2qDqNnTxhetW5NKjEG4mbeE7iNkPr0+WMgCVs/cjuRA51YovLy7kS9IKn8IqtcnZr
         Anp9s9X9+amYJTFHDLrG0x8R4z4GtB/DXCRW7aBFSwkLld4JxugaftxNoSzvoHwqTcu4
         lQvwoJCCa4T5h5EFsvhLs9NQTO/AMzHyNNfvkfAfModOwk2ROVvHQswruxM3e+hzYGRj
         xgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731169591; x=1731774391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5yfKzpu2F7oD0EL8nuutwuKfU/qe3AxHeqS/JVcWCfk=;
        b=Ur3knzlcbsVOGwVvK/0Ccn3MCU3lWSG4b0Pzw9ZTDtPATw4Ti59Yt7WTihJ/Ehkpxr
         F4E9MHu68ZiZd7d7ZY9WeCn6V0JH6G7p56e2saaLXJzKciU3D4aH/UUZFMfA4XQgUIjN
         +/wLINjmwLN7bS4m/uw8ufQ4BUl/kuDcgt7voRCT/tlKdHN4eTDrEfvq6mpDm/VBrBe1
         MNnRMLELPJS0bvQrdbRPKr6hkgrU7tHwjUPD0frFRf3ft1bCexAyTVamPh3Ruopm22iZ
         lqy8mArSZJaQhiElfGmiOACD1OVt5pD7mupwC3OIKlO6BmRuNLsW8qY1+08GoAuGmybG
         FsHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQI9Fd4PLpbiqlvSlrOfGji8D4+iqEGVs1Z0BLUBr44dXmo4DexMHUeBsCvNVSOkPDUgyZx6vIV7g8VcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFE+lOBd6Nm3lUR8sZMRI5d1VK9RsfkKIxuxcTC/Iq4UcxhuIv
	Jf04M6xWYoDv7BIUsTG8rqQAZuj37sgK2TOKIR2v2q9d+dEuP9oY+Ugbm6B2r+ljOn44mjL+Ehk
	JS4/uEStfxMYVVxBtFYvOVGitc0TTHS0Rb+zC
X-Gm-Gg: ASbGnctmnDg6rFOIOpRuPnZHEMCUdoIJLNoZhCijQ2+u92m53VtoONmNbAD5pw6j/RL
	/1ODZ17f6hdIVTcQI0B6iEU07t2scAoz4
X-Google-Smtp-Source: AGHT+IFTLfjgOtMiA8ZjbeqDMMeptCT3ndxFl5gYXqrDkdB0BfmvURY07A0sWUPoOKT+AVpjCd5kag/dL8yZs4+4+mE=
X-Received: by 2002:a05:6e02:1b03:b0:3a0:9f85:d74a with SMTP id
 e9e14a558f8ab-3a6f8a225d9mr2275915ab.14.1731169591393; Sat, 09 Nov 2024
 08:26:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108184751.359237-1-irogers@google.com> <Zy8FIt2OMa5-GymZ@google.com>
In-Reply-To: <Zy8FIt2OMa5-GymZ@google.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 9 Nov 2024 08:26:20 -0800
Message-ID: <CAP-5=fXmxhaLk+qvH9nGAV-ByyhyHx=WPhXCFbBaZ3nSySSsMA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Avoid parsing tracepoint format just for id
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, James Clark <james.clark@linaro.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Yang Jihong <yangjihong@bytedance.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Ben Gainey <ben.gainey@arm.com>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Zixian Cai <fzczx123@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Paran Lee <p4ranlee@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 10:45=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
> On Fri, Nov 08, 2024 at 10:47:45AM -0800, Ian Rogers wrote:
> > Ian Rogers (6):
> >   tool api fs: Correctly encode errno for read/write open failures
> >   perf trace-event: Constify print arguments
> >   perf trace-event: Always build trace-event-info.c
> >   perf evsel: Add/use accessor for tp_format
> >   perf evsel: Allow evsel__newtp without libtraceevent
> >   perf tests: Enable tests disabled due to tracepoint parsing
>
> After applying this series, I'm seeing some test failures.  But I don't
> understand why it affects non-tracepoint events though.
>
>   $ sudo ./perf test -v pipe
>   --- start ---
>   test child forked, pid 3036123
>    1bde35-1bdecc l noploop
>   perf does have symbol 'noploop'
>
>   Record+report pipe test
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.210 MB - ]
>   [ perf record: Woken up 2 times to write data ]
>   [ perf record: Captured and wrote 0.517 MB - ]
>   [ perf record: Woken up 2 times to write data ]
>   [ perf record: Captured and wrote 0.516 MB - ]
>   Record+report pipe test [Success]
>
>   Inject -B build-ids test
>   0xa5c [0x17a4]: failed to process type: 80
>   Error:
>   failed to process sample
>   Inject build-ids test [Failed - cannot find noploop function in pipe #1=
]
>
>   Inject -b build-ids test
>   0xa5c [0x17a4]: failed to process type: 80
>   Error:
>   failed to process sample
>   Inject build-ids test [Failed - cannot find noploop function in pipe #1=
]
>
>   Inject --buildid-all build-ids test
>   0xa5c [0x17a4]: failed to process type: 80
>   Error:
>   failed to process sample
>   Inject build-ids test [Failed - cannot find noploop function in pipe #1=
]
>
>   Inject --mmap2-buildid-all build-ids test
>   0xa5c [0x17a4]: failed to process type: 80
>   Error:
>   failed to process sample
>   Inject build-ids test [Failed - cannot find noploop function in pipe #1=
]
>   ---- end(-1) ----
>    84: perf pipe recording and injection test                          : =
FAILED!
>
>   $ sudo ./perf test -v Zstd
>   --- start ---
>   test child forked, pid 3036097
>   Collecting compressed record file:
>   500+0 records in
>   500+0 records out
>   256000 bytes (256 kB, 250 KiB) copied, 0.00169127 s, 151 MB/s
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.032 MB /tmp/perf.data.KBo, compress=
ed (original 0.004 MB, ratio is 3.324) ]
>   Checking compressed events stats:
>   Couldn't decompress data
>   0x7ca8 [0x4f2]: failed to process type: 81 [Operation not permitted]
>   Error:
>   failed to process sample
>   ---- end(-1) ----
>    86: Zstd perf.data compression/decompression                        : =
FAILED!
>
> Thanks,
> Namhyung

I'm not able to reproduce:
```
$ git log --oneline |head
a59bca6eb0a6 perf test: Add a runs-per-test flag
0d0c002eb45c perf tests: Enable tests disabled due to tracepoint parsing
4b8f5c9dfbda perf evsel: Allow evsel__newtp without libtraceevent
7f57057c7884 perf evsel: Add/use accessor for tp_format
c27d357d2d4c perf trace-event: Always build trace-event-info.c
20bf7a2cd68a perf trace-event: Constify print arguments
f18b07ee2af1 tool api fs: Correctly encode errno for read/write open failur=
es
...
$ sudo /tmp/perf/perf test -r 10 Zstd pipe -v
84: perf pipe recording and injection test                          : Ok
84: perf pipe recording and injection test                          : Ok
84: perf pipe recording and injection test                          : Ok
84: perf pipe recording and injection test                          : Ok
84: perf pipe recording and injection test                          : Ok
84: perf pipe recording and injection test                          : Ok
84: perf pipe recording and injection test                          : Ok
84: perf pipe recording and injection test                          : Ok
84: perf pipe recording and injection test                          : Ok
84: perf pipe recording and injection test                          : Ok
86: Zstd perf.data compression/decompression                        : Ok
86: Zstd perf.data compression/decompression                        : Ok
86: Zstd perf.data compression/decompression                        : Ok
86: Zstd perf.data compression/decompression                        : Ok
86: Zstd perf.data compression/decompression                        : Ok
86: Zstd perf.data compression/decompression                        : Ok
86: Zstd perf.data compression/decompression                        : Ok
86: Zstd perf.data compression/decompression                        : Ok
86: Zstd perf.data compression/decompression                        : Ok
86: Zstd perf.data compression/decompression                        : Ok
```
Similarly not as root or if runs-per-test is 100.

Agreed that the changes are for tracepoints and these tests aren't for
tracepoints, so an interaction wouldn't be expected. If you have a
reliable reproduction perhaps you can bisect it.

Thanks,
Ian


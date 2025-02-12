Return-Path: <linux-kernel+bounces-512045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0703A3333D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 971967A349A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EDA2080F6;
	Wed, 12 Feb 2025 23:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1PL/nP2"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85E41FFC56
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 23:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739402269; cv=none; b=ejhElKJ7uyq4m8luJBNfEAN3aW5Ib827lDXUTFRhfIgNVKbCN3MAArwcx2chTYlC5bjLbPbz6a5PGnDD91reWaRhtE6DwlI8yLA52bWh3/TD8oddlV0L41qiwcA8XppeFV/8dJMWxhnnuVjSfoXH3MYNxLwtSgH6fVhpIGP/tek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739402269; c=relaxed/simple;
	bh=+M3XJuQqtMGrs52cCvPz7cXxeIy/dG6rgUA7paMBl+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gdjn9dOvxf9SZNWAa0VN3cQ8G4A5lDQr/3U05+HLKxoQHR8I8eH0ZPOI/BByHWLL9VSgETO1hk65gofhbqPZoFjL4xWkX8q43iY311RfU/sQLdKG+nlltHu53BBWBmYvk5+HNbzTg99t82+VUp7kY0G8COuNNpIQTxfkXao8uf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S1PL/nP2; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d147331fb5so13615ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739402267; x=1740007067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXhRThPyBlH83zC80+OUW/T8daW7B4fQzENl9JBxcN4=;
        b=S1PL/nP2Yxxg6m89iJWJunxy3pXGOC4PQ8RXpDr0zuJjseyFXXURKloBPQk9dQ2vaQ
         u65lBm9FU98v0R70gSt106yI2yDTI/YQOvdBiyUfyeFE1SwLrphyHbjKrKMkvA59oljU
         F5QnH+Mhfe55J1tq18E6bCYl4/DrWzHYEkkpc43nPkG6pJFaCjbFUGSulGMa8SATZGHu
         BcsNneLsdFQ3/GhlWHDZaWY/XK0n69AxzemvXO16zmZodc8XmBZzGsFIl7vSdHCgtxOl
         fs2YZvP03j1GU10E6o2gRq1mfSFlYAHgYBaTFvo+PRTG8tH60BFa516+G9kq2zU0Qnf9
         Iv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739402267; x=1740007067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXhRThPyBlH83zC80+OUW/T8daW7B4fQzENl9JBxcN4=;
        b=wCMk3mC5Lr4UnY8wehdheACS1byBdwzmSlUytXgM/C/xbFlt8CChyiG6PvgaXbESp+
         wMKjDqPakFIC2V8SVM9FmEC8plbU2J9bZX38Ui9cvp+enFocNRz6tD3Ts1TZjvsXZmT6
         8ZFrupV+bbpNkHrICcrghH0yzMWcmly9j/VLfmnX6fTbVf0Yla1yI0UiTWvChtjPleK1
         555iUTSTm3GTrBTbjeFxMkV8sPWeZiw+XRuuTjhNhXnn/vPU9kquzpgdTdxQLngcV06Q
         hl9nrtiZnvSw0ISI1mK1tXN+XgiQOtIiliF0ZK54Wr4z+8JSybv8FpRJje5dpKo4rMnU
         xbkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVix0p0xbyiEsw5NWlKvln32FLilovTbmo6+YaOO6wJTg4eg2f9R0H94CyBZ1nVqqOXa+uu/9iDVkThauM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6koOwOaGxeQ7NroMy/V0ygsKw0C9cs7pKK1XvFNNDspfSo9ae
	+LV2VONb/+CfCocJu6GrD1Rjn47XtvJjl4J49Znahu7D9WWvDb4vqExRUeTh61PbxEUy42cYt9r
	HuS8O/z0tVOLtpLmge4Rz2m00KhIJc0jR2Fkt
X-Gm-Gg: ASbGnct4J44nHbqpEJkQprt/a7ZMoTXq64/3x+S+OoBnvOf+4WPg81pvrbakU+Xz8Ew
	JfXLMHaLDUVs16368SCcmPKOjtjHGwGToolWIcVC/rnaT8z3hShFccJXR6Mws9SI0W6vV0jO8a5
	xje+TC7FmukffFJkLjJjJSBl0K
X-Google-Smtp-Source: AGHT+IGa5o2Db/WpcCG+cx37k/bVU+qQ7/uhqeEi5HoyudJYf3KOTaARVlxtW+XSi/gVyRONPb7Cy/M8hW3T/a0tV2w=
X-Received: by 2002:a92:c247:0:b0:3cf:fdcd:8a4d with SMTP id
 e9e14a558f8ab-3d18e1e1c22mr431465ab.3.1739402266577; Wed, 12 Feb 2025
 15:17:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z6panMzNSm1op8Di@google.com> <CAP-5=fUY83gifsMZA0Q45kiQQbAKp2uJxkuwrwGtHK2hiUFRDA@mail.gmail.com>
 <Z6rAHhAIdlkAryGJ@google.com> <CAP-5=fXjmJ+Rr7ejL6fCMeu6PZSit7n84hQkjh=0jQhkr1on3Q@mail.gmail.com>
 <Z6uOGNO6p7i9Fese@google.com> <CAP-5=fVxFe4nMS_dHmO=6-ddA40XbVdvouPLuOxj5cenjUr8ng@mail.gmail.com>
 <Z6v-mPJq6m61pFA4@google.com> <CAP-5=fU+-4igQomO4Q41=7xo6YWyDdVqJdZd34dcMUS-Ua=N1Q@mail.gmail.com>
 <Z6zslLa8XM1ubwXj@google.com> <CAP-5=fUrzPvV3sD1_wMzQ7dF8xk3hL9_nkdS6toFjt7L+SRsgg@mail.gmail.com>
 <Z60nBQCetMzhRg5b@google.com>
In-Reply-To: <Z60nBQCetMzhRg5b@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Feb 2025 15:17:35 -0800
X-Gm-Features: AWEUYZlLhZpXZob15i0VsJvQPHlVsStR_iCElZoEkkmPvw4jC9V410Zxy63C5Bc
Message-ID: <CAP-5=fWG7JOmQhTa+OccOxSLhik6Du-qy9d90q-zhDTu0P=q3A@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] Move uid filtering to BPF filters
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Hao Ge <gehao@kylinos.cn>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Levi Yun <yeoreum.yun@arm.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 2:56=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Feb 12, 2025 at 12:00:42PM -0800, Ian Rogers wrote:
> > On Wed, Feb 12, 2025 at 10:46=E2=80=AFAM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > > It's not completely broken and works sometimes.
> >
> > No this is the definition of completely broken. If it only works
> > sometimes then you can't use it, we can't put a test on it, there is
> > no point in it. Even when it doesn't fail on perf_event_open, does it
> > work for processes that start after /proc is scanned? No, it is
> > completely broken.
>
> Ok, we have a different definition for it.  Let's ignore the imaginary
> users of the broken features.  Have you added a test for this change?
>
> Anyway I've tested your change and found some issues:
>
> 1. It silently exited when BPF-skel is not built.  Better to put some
>    messages at least.
>
>   $ sudo ./perf record -u $(id -u) -- sleep 1
>
> 2. Even with BPF-skel, perf record doesn't work well.  It did something
>    but failed to get sample data for some reason.
>
>   $ sudo ./perf record -u $(id -u) -- sleep 1
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.045 MB perf.data ]
>
>    Oh, I think you now need to pass -a because it now works in
>    system-wide mode and drops samples for other users.

This is a pre-existing problem, no?

Thanks,
Ian

> 3. With BPF-skel, non-root users will see this.
>
>   $ ./perf record -u $(id -u) -- sleep 1
>   cannot get fd for 'filters' map
>   failed to set filter "BPF" on event cycles:P with 13 (Permission denied=
)
>
>    I think it's confusing and better to tell user that you need to run
>    'perf record --setup-filter pin' as root first.  But maybe due to the
>    issue #2, you still need to run it as root.
>
> Thanks,
> Namhyung
>


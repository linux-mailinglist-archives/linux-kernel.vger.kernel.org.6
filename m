Return-Path: <linux-kernel+bounces-409791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D4C9C91A9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2881F21170
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D5818132A;
	Thu, 14 Nov 2024 18:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D/abG7aR"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6887013A265
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731609077; cv=none; b=QeBQGXuEzG5a2r6JtBJxyNaWelcDkIYGTUpN2/DR1W1MA7KIx8l2fg7Z+aZO/7haiT6I0HnKm1ZoSvbIIbuTbXoexq/6REUw79L9CgZlR5H9hhlPbYukyeJoF6DC33hyPfeF/jNJcZv3uMIrlBQefwInMIoGFAm7afL18d4ry/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731609077; c=relaxed/simple;
	bh=qPgttRKqIwbel5Escl1oq0suAUqJ6hGmn2l42WFD7Wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DT3zEhCrHyBH4plFUg5/RSsiXwgOokr+/1dwbJRSszz0vUyEhXmoFVf8P3CUFVZC1Rvish9lQ2S8YiL4hXXOJxg1w1nwTsce4WDvM7WbhAPjE7Fu9jI82cASUMps72c8f5T/pNH9KPH7hy4mB/Rh5vKfE4iVNJpUh46ZgQ+CtRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D/abG7aR; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a745f61654so10825ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 10:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731609075; x=1732213875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPgttRKqIwbel5Escl1oq0suAUqJ6hGmn2l42WFD7Wk=;
        b=D/abG7aRzBAxHMtc6QhJ2JbWytpASw9PO/iS+5NxVsBvcWRce8xndB5GgGDsd26L90
         jht5feyGXxbsq9NNeVFusDyIA3viWyT0oNPK1JOtFPG5P2x98N5IrWihzseEyOXO+WT3
         ZtrGeBjG4Rfc24u1xofXl/GpcUMghRHZkdKbT/J0B2xzc90tnZrDkh2VdKdXnAqHf+id
         ORTFQgAUJZA4Mu3OqeDEOm5EfJdEN2Ed+qvzyPooylGXqZWrNx8jIV5CqjdoCSHdv7aB
         ruZCvbkTHCCGIMOTABjZnGsb6bmZSlXESc+I1fIUMRlZmIZzDxSY+zvfK1mCzAVmb1Ty
         414A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731609075; x=1732213875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPgttRKqIwbel5Escl1oq0suAUqJ6hGmn2l42WFD7Wk=;
        b=eBB1XkM6zBUPYoiZAUpDntly2sN1CqSzGtAJAfNxZM2yx2RGYPmd5R6JBoztu+cHz9
         YneGpPJlZX5TUNSyEzTdokOXpRmpXIYpLTXCA7nedrv1eAmGYyY52o/RRyj8SoiXrwEa
         0swxfK27PWTEBu780MSGcQJDyPVD6zEBhJ7AAQWP5t9pGj/WeVuhOCsmYa87Ikhm+V3Z
         tDRFQVblkNSc3Ww5khUVy8bbKy4tIasw0mCnKol/BHWUPOmYPxMBd7/CsHpShoYNyM1r
         Fjd//5IoCgzGY9auXVNyc1QcT1jfJE+kIdQujUDVZ+wti+ln/pH9vgAPh03nBxcOSupY
         EnUw==
X-Forwarded-Encrypted: i=1; AJvYcCXdzFUqbxr4yWnAooY64TQrk9nAJy+s3Yh5/u0tSY1+JMB51lHogdMYCtL30gG4GKMdIijg6yht20ZJc7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiWb/WfAj55WUeChQoiwQr/d1YIutFHZ/1jZ5MntnSHnKzG+mS
	Fd6wMKCAdC2+UNy8Haxf+b4YYuTRB1+j1xurZg3ELYgkhKcYEak8PrjVCUO3x2yKnNmxwu/iL8S
	FJgcwu6eFoVtqc8tfmYkAwIos5nu5yULfhCkG
X-Gm-Gg: ASbGncus8SA5yNOjw15hQuejeD6YtHdgzcjc+EltrA8ALNHnzGv0ZKJ2xSYLZPmtCkM
	u8JAyw1P0NHqOUaQvt6762OJwqveDNTP89U8w+YfEPN3tbXhOM9SqsV+3+Z5YO94=
X-Google-Smtp-Source: AGHT+IHbt2clAsvEm2GCWE3HZL8c9XYanWoYZmP6qTNs/eamsLOQaZgatLIMPvRuQ3+hmYVnmRaUTEoaA8PTfGw6NT4=
X-Received: by 2002:a05:6e02:1a4e:b0:3a6:af68:668a with SMTP id
 e9e14a558f8ab-3a71e7a2d67mr5483705ab.18.1731609075190; Thu, 14 Nov 2024
 10:31:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107162035.52206-1-irogers@google.com> <20241108025535.wfhke3btch5af4fu@hippo>
In-Reply-To: <20241108025535.wfhke3btch5af4fu@hippo>
From: Ian Rogers <irogers@google.com>
Date: Thu, 14 Nov 2024 10:31:04 -0800
Message-ID: <CAP-5=fW=RXz-A=xndhs8wkXaKCz-qXB=PemAMvbZpUagvObUoA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Refactor cpuid and metric table lookup code
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Huacai Chen <chenhuacai@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Ben Zong-You Xie <ben717@andestech.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Sandipan Das <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Dima Kogan <dima@secretsauce.net>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 6:57=E2=80=AFPM Xu Yang <xu.yang_2@nxp.com> wrote:
>
> On Thu, Nov 07, 2024 at 08:20:27AM -0800, Ian Rogers wrote:
> > Xu Yang <xu.yang_2@nxp.com> reported issues with the system metric
> > lookup:
> > https://lore.kernel.org/linux-perf-users/20241106085441.3945502-1-xu.ya=
ng_2@nxp.com/
> > These patches remove a lot of the logic relating CPUIDs to PMUs so
> > that the PMU isn't part of the question when finding a metric table.
> > For time reasons, it doesn't go as far as allowing system metrics
> > without a metric table as a metric table is needed for metrics to
> > refer to other metrics, and the refactoring of that resolution is a
> > hassle.
>
> For this patchset:
> Tested-by: Xu Yang <xu.yang_2@nxp.com>

Ping. Would be nice for this to land given the ARM fix and general cleanup.

Thanks,
Ian


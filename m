Return-Path: <linux-kernel+bounces-276517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D169494D7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300161C22CBA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832993C466;
	Tue,  6 Aug 2024 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AphVWnIG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F7939855
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959418; cv=none; b=EGWEJi2K8xOV+/ng97VPanIp9bkldg+0EYPQP1X84+R17LINwvrG2MkBzBKXXQML5I1eppr+Buumw0/mVwkQxFClu+0mzuj5nhzK0xIO9/0VaIYeHxgTEkDvB2tFXfqKH3i+VL8SNyb2Kej10AwpIQONgqnnRl4J5xnbElp6I6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959418; c=relaxed/simple;
	bh=MNX0AX4yItYjv9aP4unerrqiXI17MhLCA3jpCkKbas8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UaGTeln+/oB+RfphxbFGeKKyY/UO8et5g6nKv8t4aWY/my8YoerOPQwFgwnXKOCx5b3KGjB9vh6wzMdSSO6oIPo3zCRJPeCllr2e4ml2SPJJeKXvW1MBUr+pVoiWfaRn4vcKlEwrNC9HpV/YyU/SLEY6lHwyP8YqfYS7nOsiUIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AphVWnIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57747C4AF11
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 15:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722959418;
	bh=MNX0AX4yItYjv9aP4unerrqiXI17MhLCA3jpCkKbas8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AphVWnIGKGptjmxqyUHrhGEUDs/u9YYgR4FD+ytyEW7uzufIGmNYKH+VtSYtzq8oI
	 lVwY4jYRJBxY9OXhu2lkkbStqA6r8slMG06oMSuu3EoMvJDQrSzSOSxQuUEWD8IRuR
	 s9ObHQqzk/i6LDWHQVUV/1uZMS29rJ246rPaUN4np3ZcARc8x1EWLVWwUQI4TNAyIS
	 mT5GoMlP/wVjF3ASBuAILVXOI/HkVxy7DvefelEyPIe+6FHrCA4pDV+qoOCcYau4+6
	 BCKavWs6GwdOTVeK130r/nRQY3y/pMfdVFrYw/1Y7c4hmCYOpxy98tzKmLcDHv+sp7
	 cUyKh7Q9VQqWA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52efd08e6d9so1412614e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 08:50:18 -0700 (PDT)
X-Gm-Message-State: AOJu0YzLr4eP6FwA2ooukw1wgwG1NmXkc4be946CJnNymmYbQE5SlKAZ
	jeE/UtkiKE9SEtBMpe1O4trvDm/awzj1e2L0zigccNANKVBoh5vbzXpFTa1yJhadYYJdRvO6bqW
	x0N+XUTUvCJFEm1Roc8zPLU02IfY=
X-Google-Smtp-Source: AGHT+IGUYVUVcQ5kUVi2D8JkvZfb0KuRiJ8RGbi2blIBJOzX2qfiqBupMJYICOdo522BgU1J3op0Q5MlTunQ4u2ZzyA=
X-Received: by 2002:ac2:5f47:0:b0:530:daee:cfb0 with SMTP id
 2adb3069b0e04-530daeed2a8mr227964e87.52.1722959416743; Tue, 06 Aug 2024
 08:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805231031.1760371-1-song@kernel.org> <CAL_Jsq+dxQxNV-Bm3q5vzCyfWEzO2Qv-jq29eGVaP-sC-jVyww@mail.gmail.com>
In-Reply-To: <CAL_Jsq+dxQxNV-Bm3q5vzCyfWEzO2Qv-jq29eGVaP-sC-jVyww@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 6 Aug 2024 08:50:03 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5NjtFzYi=zRBO7SwFvgRvJi1MEhgU9F5P99nTugEJwkg@mail.gmail.com>
Message-ID: <CAPhsuW5NjtFzYi=zRBO7SwFvgRvJi1MEhgU9F5P99nTugEJwkg@mail.gmail.com>
Subject: Re: [PATCH] Revert "perf: Add a counter for number of user access
 events in context"
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Tue, Aug 6, 2024 at 6:37=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Aug 5, 2024 at 5:10=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > This reverts commit 82ff0c022d19c2ad69a472692bb7ee01ac07a40b.
> >
> > perf_event->nr_user is not used any more. Remove it.
>
> What are you talking about? It is used whenever
> PERF_EVENT_FLAG_USER_READ_CNT is set on an event:
>
> arch/x86/events/core.c:         event->hw.flags |=3D
> PERF_EVENT_FLAG_USER_READ_CNT;
> arch/x86/events/core.c: if (!(event->hw.flags & PERF_EVENT_FLAG_USER_READ=
_CNT))
> arch/x86/events/core.c: if (!(event->hw.flags & PERF_EVENT_FLAG_USER_READ=
_CNT))
> arch/x86/events/core.c: if (!(hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT)=
)
> arch/x86/events/core.c:         !!(event->hw.flags &
> PERF_EVENT_FLAG_USER_READ_CNT);
> drivers/perf/arm_pmuv3.c:       return event->hw.flags &

My fault. I didn't realize the code had been moved to drivers/perf/.

Please ignore this. Sorry for the noise.

Song


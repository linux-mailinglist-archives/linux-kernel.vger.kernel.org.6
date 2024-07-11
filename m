Return-Path: <linux-kernel+bounces-249908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3A992F16D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DAFF1F25658
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FD51A00EC;
	Thu, 11 Jul 2024 21:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cAjmkSfu"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6EB38F83
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 21:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735131; cv=none; b=gmLYCfLvmk1O9u6m2oLRmJYNW7gwyspSKNMBglAUcSMDeIA2G8T94D6U/f1Gu4kHh7ucJp4xmhkBIH6EgdLBI2CXznXy18dsQcK3UCxlvIzMGlK6sBEX7kCVl9Y4D60wbyHN07SSgvDNBfxLU2ywyyyVyQ2Fmv4/8r6KgqzbhtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735131; c=relaxed/simple;
	bh=FA8rurZAujgc19PD/q0qvrBhAi2huUDq19HfgpAZxRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5N6KnQXbBBSl+ZbK9xbDcEwJC9Prce1jRuQtN/BQ4XYRsCGdrjZkda4dWnJlkvIZxYJzPoBPEps+Y4haKsmX/dxkefIm4KBXFsNQrv6yWkuOd0bO5HdblntXSd/g7Y3o/aKAg1HXMyRhLnogl025bVnqsszVB4BEzZ1of+awv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cAjmkSfu; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-447df43324fso39161cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720735129; x=1721339929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnYOe1dJG5+d+L3aqlBxYsGPG+LDmnP2wQAV+RTmgZI=;
        b=cAjmkSfua2dfCU+sYh2XS15j1Hl4zIcTULvAjVLPF8VvxEACnVZ1cFrY6thrAQQTdy
         lQtewdjHNtkVtieTQZ/+Px6XOFCPm3zCvIlEBlacoL9rijsmkXAJZMvWm3FVrvYmVfps
         3wfe0E+OzbBt7KLLScWS6J+6+L/LFHbYwOVZnKkvWqA/g1nYRfJTUtS5EIXcCGzuZSF+
         BgQZMncF4I0xaU6fDvZW052MudMwU24qgzxBETakPnMbL7GMbrFXQ9dsMBEyVc8a9KwO
         3p2z6PKYJK/TEbpKaeI8cBBScV7t3dl4nyWfY37bViiImelQhXvQm6lfzg+aTxh65h4q
         ohRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720735129; x=1721339929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnYOe1dJG5+d+L3aqlBxYsGPG+LDmnP2wQAV+RTmgZI=;
        b=PogMZrTkREXAq54YLTnFg83KvgC6G2AKp4SxuU9lz2SxG0QUrk3dMgK361oilPGp5Z
         fCFhX+jB38jcUywyUhbNpDAGEfrdng3W4ofKEZAVc5gW6ACrXrT++JylUNi0QK7LOqe7
         TvNCA28Yjp8VO5IJT/XPymb+sUS0QhIQcFds7NPZFFiWErqM39CAPMpNWpt+YYIbdor0
         p3346aF9TDgNaVFBdp+t8s/EFAO9p/JI/d7Kp2TxJWCtzW7Dm1xyhcBp/Sw8pIuovs8u
         PDBcF4BBBPmIlvBNkVkLqoMulKbFYi+L95cvB8CgUNoEKNHIMzzQbfGZmPq10iVEiGfo
         m0sA==
X-Forwarded-Encrypted: i=1; AJvYcCWvm4XpzUm4ABQEYE0lcOBDjNKxkelKFwy/L9daDn2X1sZLXo9bg4VdcV5FfnET4tUhcs+a2sZ0gknUcz/XDE2X7PYZV5dL6O0vvl7x
X-Gm-Message-State: AOJu0Yz8WruX4jw1Sr1El62K0trAZYvqynePRLXYzZKM+/psMr90FTEh
	ObI+q45Lxf1u0m9yCivXPhRkyltQ+ugV9roidtv6aSscB+Fx5ggTTI7I+3TpeiLyYGTC46R0CMY
	B1bSHseBL9ir2jEZdK8EEwY7w2MzPBWM7zTEu
X-Google-Smtp-Source: AGHT+IELqWv5DEQWx38sI2VPsWnfcnaJgBIGYKNZMWEGKlbGp4EDsVqCEuin4magvXGBDti3fGOMeO+hfnwUiVNYQ7A=
X-Received: by 2002:ac8:60d0:0:b0:447:e5df:e1be with SMTP id
 d75a77b69052e-44e7350fe53mr1078961cf.8.1720735128225; Thu, 11 Jul 2024
 14:58:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1720700179-22839-1-git-send-email-ajay.kaher@broadcom.com>
In-Reply-To: <1720700179-22839-1-git-send-email-ajay.kaher@broadcom.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 11 Jul 2024 14:58:36 -0700
Message-ID: <CAP-5=fVwZfV+gNWcmEtRnkOtrvozMdXPVrZ37COHkf4BX1VPgw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] perf: add logic to collect off-cpu samples
To: Ajay Kaher <ajay.kaher@broadcom.com>, chu howard <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, rostedt@goodmis.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, yangjihong1@huawei.com, zegao2021@gmail.com, 
	leo.yan@linux.dev, asmadeus@codewreck.org, siyanteng@loongson.cn, 
	sunhaiyong@loongson.cn, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alexey.makhalov@broadcom.com, 
	vasavi.sirnapalli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 5:16=E2=80=AFAM Ajay Kaher <ajay.kaher@broadcom.com=
> wrote:
>
> Add --off-cpu-kernel option to capture off-cpu sample alongwith on-cpu
> samples.
>
> off-cpu samples represent time spent by task when it was on wait queue
> (schedule out to waiting for events, blocked on I/O, locks, timers,
> paging/swapping, etc)
>
> Refer following links for more details:
> https://lpc.events/event/17/contributions/1556/
> https://www.youtube.com/watch?v=3DsF2faKGRnjs

Hi Ajay,

I wonder if Howard's improvements (not landed) for `perf record
--off-cpu` would solve this problem for you?
https://lore.kernel.org/lkml/20240424024805.144759-1-howardchu95@gmail.com/
Or is that approach problematic due to the use of BPF?

Thanks,
Ian

> Ajay Kaher (3):
>   perf/core: add logic to collect off-cpu sample
>   perf/record: add options --off-cpu-kernel
>   perf/report: add off-cpu samples
>
>  include/linux/perf_event.h            | 16 ++++++++++++++
>  include/uapi/linux/perf_event.h       |  3 ++-
>  kernel/events/core.c                  | 27 ++++++++++++++++++-----
>  tools/include/uapi/linux/perf_event.h |  3 ++-
>  tools/perf/builtin-record.c           |  2 ++
>  tools/perf/util/events_stats.h        |  2 ++
>  tools/perf/util/evsel.c               |  4 ++++
>  tools/perf/util/hist.c                | 31 ++++++++++++++++++++++++---
>  tools/perf/util/hist.h                |  1 +
>  tools/perf/util/record.h              |  1 +
>  tools/perf/util/sample.h              |  1 +
>  11 files changed, 81 insertions(+), 10 deletions(-)
>
> --
> 2.39.0
>


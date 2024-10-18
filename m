Return-Path: <linux-kernel+bounces-371978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEB69A42E0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14061F22827
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9AF2022EC;
	Fri, 18 Oct 2024 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hLS2QvLf"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821B2168488
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729266549; cv=none; b=e9R/guT3syVQ6YRGy+7PUG8m+1QYjvjUrwhupeCVQqkGXh2b0wK4mIKwYGgPRqIpyTX30BGSn1Gjv5zGW7O9kw4uqBYcVGXjDKNvu5Nx4XRo4qscjWtDYg9ZTjTp7gSs7Oe/z9MuhyGdI3gXh5kzHPFFWxKpAvuXaoZrxz6iLYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729266549; c=relaxed/simple;
	bh=BgmzIY3kGULr1QWfbWRub0ZKXkdclNfLCw5wNfJJrYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzvgoDKRJopiRVmeqEvzpm92jAZjN5J61cTsQuywn906i4/CGZDdNXyI7nUIuBStQXCNFY0an+NCGPxI3jXESsxYwFKZRI1u3775/hl2Udl8AClKoatoym9qSLOd+WI8vrewpJxnXVd2EiG1Myk+5GH9QR2Dy0ofz1K/Tolw3QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hLS2QvLf; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a3b3f4b599so325965ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 08:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729266546; x=1729871346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyA65vYYqkGpQYYXil55YtRI18xwltFUUTkGJHKMDO4=;
        b=hLS2QvLfGxstbJOS2hzGn2p5RbutWYLPb9AUYLvL9lUrJBri0onuis4TP/fRNqMTWA
         8ZYoM+c7K9PjVJQs7WMXI2lyHS9v9lrdo0Ak5acF8ledxIVmv6ox7l89oYY/cFQPdTgz
         FsAhlmCfhSfVunPB6dh22ayvl16W5QSgTWrdgbSLrHaoZHCRveGQ9OfyEskz3GqpguHf
         jgPDxCZtiUQOgTVfFVSU/S9YXMkZkL39nTHkPYuUwfh1Z0wricMNicaj0/G85YKyDw6W
         6HlIivBkmHP0rjPQLyKgpqgIjSzOzB/lRRNn+f7QStSEvkzu95Avfm2UZeaIP34eoGts
         EGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729266546; x=1729871346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyA65vYYqkGpQYYXil55YtRI18xwltFUUTkGJHKMDO4=;
        b=F+I4+R+wl1OcAE8bfZLFZP+FaSSmyQl2PR28Odqd4NQx6Xu946JDDdWtGw0qOpegVp
         s3OmwIaoBvuE6JzhwNvJGDjLA/8g9s21HnoaGW2m6NpAytvUdaNsMoRTAenTgN0+5YDA
         00QQdbxKA+A25hOnFxttNUOLP2sbrxx7h3x0LQQv4RXCjqZgwyuPkyJDYJkTzaPx0SBi
         29KEOLqk9fazxi0DdTbNm2UGB00wqYGOaRSc/r3ERi4cch+SZU44OXTpXdxkG90j7+/Z
         Au5IKYcpNMh2Ryl5DZRxEUSkqE7dlwfscna+r9PAA95rsNmZkATKLVqu+1VSwhc+Vbxa
         RzdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZO0aQX1uUX3s7a9DluDTJB86kACPwF0//8/i6RJMl1c09lrlRs6Rd111jedCVA2pq6Dm6JRpeYM7/VK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz67Hj+AoDuk7TyLsVQBUE3OqPsxFjiLcU9oww8xTIgzkroU1dV
	uMGGbFV/FSjRsxYCCuykb4roRLviNQeznE/r+qT4sPlxZJ5dYT6ba1J6wlInx8S+BmxtH9/dRS5
	GGeI1aZ1ago4qSul9PLgHxRgN3C9xM8/eTjXW
X-Google-Smtp-Source: AGHT+IGBiBA5oyJymUOS/HHmvQLXekemn1RtscTcxGjaEY+msWJaXN/wIH4+jo9XYM9cQKuja4JWRp5lP2ysL4vbc3c=
X-Received: by 2002:a05:6e02:1fc3:b0:3a1:a90f:74c6 with SMTP id
 e9e14a558f8ab-3a3f41381c2mr3504525ab.21.1729266546405; Fri, 18 Oct 2024
 08:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729242778.git.sandipan.das@amd.com>
In-Reply-To: <cover.1729242778.git.sandipan.das@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 18 Oct 2024 08:48:54 -0700
Message-ID: <CAP-5=fXWPwvHcx38Cshha9xP50hKTTZFUxiH7+yG4u=z6sqvig@mail.gmail.com>
Subject: Re: [PATCH 0/3] perf vendor events amd: Add more Zen 5 events and metrics
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, eranian@google.com, ravi.bangoria@amd.com, 
	ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 2:31=E2=80=AFAM Sandipan Das <sandipan.das@amd.com>=
 wrote:
>
> Add data fabric events and metrics taken from the now released Processor
> Programming Reference (PPR) for AMD Family 1Ah Model 02h Revision C1
> Processors document available at the link below.
> https://bugzilla.kernel.org/attachment.cgi?id=3D307010
>
> While at it, also update some missing or redundant data cache metrics.

For the series:
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Sandipan Das (3):
>   perf vendor events amd: Add Zen 5 data fabric events
>   perf vendor events amd: Add Zen 5 data fabric metrics
>   perf vendor events amd: Update Zen 5 data cache fill events
>
>  .../arch/x86/amdzen5/data-fabric.json         | 1634 +++++++++++++++++
>  .../arch/x86/amdzen5/load-store.json          |   78 +-
>  .../arch/x86/amdzen5/recommended.json         |  112 ++
>  3 files changed, 1818 insertions(+), 6 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/data-fabric.js=
on
>
> --
> 2.43.0
>


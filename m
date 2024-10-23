Return-Path: <linux-kernel+bounces-377918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8DB9AC889
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9896F1F20F44
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA3E1AB513;
	Wed, 23 Oct 2024 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="BnsC4x/9"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDA71A727F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729681537; cv=none; b=XTWHICS4z1gDBFA3M+AFtaKm/iekFvmcURpUwBy6+GHmxsXX9jy8w7Op/8Dcs4PO5LZmeZHaj1cvi2HlnplJ3mxRW/4P34Uxo0inAQrVBiG0VgCGIHb0WMtlJpeLRRI313HcXgkoImADv2Y5nT8PlJfyct2+Jc/7p/HtOuyJquo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729681537; c=relaxed/simple;
	bh=sfDYrsc7jL8D8erZXRGgiet+3Cp94nf9m5xDJHz9CRk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Awz1sAs/CjEzm0fJROgAZIzuyMXm389EALxGtt9GjvydXqnSVMZmREzPyuzH+Bg0nymLfj0WR6y4yMX0BM+Ngj7VQCKI46x1ZpgIKzsOLOQLoZc3KNmlPnd4ynXUYXdlMKr0mKU9//ipOYga3u8qITpX/LBK31p7QpU6pxWNFnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=BnsC4x/9; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1729681532;
	bh=k1PQdwWV+FaoZceT3p/cXCl0FzqOvYe8Dz2UCeREsxI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BnsC4x/9hKn2WX8a/ynVLHtUy70nHjb2tMwMe/8nPz1URmvtwE8nyKrTjvUr9ERPG
	 pV8IePcBNuB+PadOvWlF5ji8IWw0tfRmzKY6M6wwZACJoBlRGbwKK66VR3VwislwrG
	 LUUBCSG1vxZcyq9f7i1NOn6NqYeEv1pLttGAkjrtzmDB4TGFo5wek2wO9L0nYDiwKF
	 0N4XhiTySswSmxQH6M6zu2M17295HO490mA2s2W2VXWBOlaclwhxqEFNjf2p5v1Rq3
	 iAFzRj/FmDFxAJUFpOO0uq65rUx4sVSORi67PWHi+2kzl43hBTSFYRHR7yW6MyFU53
	 qVX9ZYDOwJVcQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XYR6M2B5xz4wcs;
	Wed, 23 Oct 2024 22:05:31 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Stephane Eranian
 <eranian@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Sandipan Das
 <sandipan.das@amd.com>
Subject: Re: [PATCH v4 1/5] perf/core: Add PERF_FORMAT_DROPPED
In-Reply-To: <20241023000928.957077-2-namhyung@kernel.org>
References: <20241023000928.957077-1-namhyung@kernel.org>
 <20241023000928.957077-2-namhyung@kernel.org>
Date: Wed, 23 Oct 2024 22:05:32 +1100
Message-ID: <87ed472i6b.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Namhyung Kim <namhyung@kernel.org> writes:
> When a perf_event is dropped due to some kind of (SW-based) filter, it
> won't generate sample data.  For example, software events drops samples
> when it doesn't match to privilege from exclude_{user,kernel}.
>
> In order to account such dropped samples, add a new counter in the
> perf_event, and let users can read(2) the number with the new
> PERF_FORMAT_DROPPED like the lost sample count.

Are we sure there's no scenario where exposing the dropped event count
gives an unprivileged user a way to probe what's happening in the
kernel, which is supposed to be prevented by exclude_kernel?

Clearly it provides an attacker with some information, ie. the event
fired in the kernel and was dropped.

For most events that's not very interesting, but for some maybe it could
be a useful signal?

On the other hand most CPU PMUs implement filtering in hardware, which
this won't affect, so maybe I'm being too paranoid.

cheers


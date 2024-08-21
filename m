Return-Path: <linux-kernel+bounces-296075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0853095A540
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1411C217FE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 19:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1E216DEAB;
	Wed, 21 Aug 2024 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWB9+AB2"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2910616DC32
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724268266; cv=none; b=FsoB81+cDewkVkY4BGhCUnwJXJLF9zL5+8HFKjKzvFw6W+mv0wER7xynLwGI8CU97J02skMiu69tv0MFdlC+JgAjiSIybBh2eoTCPyHzlxaLez+Y3Fz6dlYggs7uFdUcC8ABNuANa7LJ7H0TOGB/wZeTPQtqiVBVslnaZm6Q/dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724268266; c=relaxed/simple;
	bh=0QLjBpEZjH3Bot7Qk6QEN7ATVN4BjF7u+ItSRzHBcHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nq6gpQ8bWAry1obmnkjOsFKzGpwHW/y5T1lgncTMw5IxMkEMUSr0t6vaADYWujBbGgztE9SVPPHottF1xGF7cBvaeRp9zpLPVQxK4RLiRDAvSvUSUTGfKuiU7Z/MeeJ2hPkzh6/f/C1GO+Vk94SM2kcKfxmmplBfursWANob30A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWB9+AB2; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44fe28eb1bfso644941cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 12:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724268264; x=1724873064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QLjBpEZjH3Bot7Qk6QEN7ATVN4BjF7u+ItSRzHBcHM=;
        b=WWB9+AB2S3Kd3rWOmZ3ETod2XTtHLTIl8KrnCdIkVuKQ0fiexv4tAmmr5N/SYVsaHs
         Kr+WkhV7WhGH904JzX6RQDdfTGDqsQJy8Vj44l91JjxN5KDtWNqvQAqxP6wS3m/jdTTU
         wp1MQOZ/U04e99SHrLfsEKB8LFlfwOIA4sDj1eEAYYMpvNYwMihmfyMjxV6yw72PigJ7
         YPY/M28YE5xVgod7CZFbURZluD+3/ivPj5x30o+Ug6xKGsOon3wojtP8ToygVXyf+q0M
         NGfmTdXKqHn7ojOPVASNdcNFMn15NKkdTtkNvGIHZ7THWoWyyFRw3Cio9l2hPe1qABDI
         NtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724268264; x=1724873064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QLjBpEZjH3Bot7Qk6QEN7ATVN4BjF7u+ItSRzHBcHM=;
        b=O8Hufb4SjWNbT0qqdhg846fgK79tyavitRg1S7fO7QFncv8qnRRunHG/tpaXBmKHU0
         Sjqxikk1EtKwoSzCTdkRukxpZsvRXc/vJhk/MP54EkOY/3xBuMst36omxNVsrhLLRayj
         yj1HjcBnoSR3b4Kv7rtD4HZ9Ygk7B0vNuVebdXJSBfIlBmTiLBRS+RzMJkAp+zYD6hpC
         R+JKjCcOKdqIIvUnEcPHOSxRaq8lmbj3bKx5YIRd//SEkVa6srZQIyHY1498GG267gmF
         9Ya/1621Tp0Ktw1NREFQylme81p2CdimCPrlVOEs06vXI6ZKnbkslW4D/bpIFZYdCXyG
         dLAw==
X-Gm-Message-State: AOJu0Yycd3gbDajk3ET3aF2Qwefx2aZUY3ceYFuDy2VIOe590vVx/JRJ
	BSPjGIIfou+ASSZgijQgWkmb6N8mDuMtH3x1Ylq+tnbA8NX4XWZ0UPeAmoE7z9oyh5OEssGg127
	GyfXWhH+J0Dy11a7cqr8Cs+rZbEM=
X-Google-Smtp-Source: AGHT+IHLx3rQ5gt0Sw70rHXqDyQ7cjxJkBKL/EtVZONi8HeZMTz8pD+yVQLt7wRMT+oajMo6dJMx49PejYNYTDt1MzA=
X-Received: by 2002:a05:6214:5b89:b0:6bf:5da4:96dc with SMTP id
 6a1803df08f44-6c155de6eeamr44114066d6.45.1724268263850; Wed, 21 Aug 2024
 12:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820195005.5941-1-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240820195005.5941-1-kanchana.p.sridhar@intel.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 21 Aug 2024 15:24:13 -0400
Message-ID: <CAKEwX=N-xuQume6C+xq0LfhVNOaK9rOiz_0c39GfoBB-4+6eng@mail.gmail.com>
Subject: Re: [PATCH v1] mm: Defines obj_cgroup_get() if CONFIG_MEMCG is not defined.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 3:50=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> This resolves an issue with obj_cgroup_get() not being defined
> if CONFIG_MEMCG is not defined. This causes build errors if
> obj_cgroup_get() is called from code that is agnostic of CONFIG_MEMCG.
>
> The patch resolves this.
>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---

This is only exposed because of your zswap mTHP patch series right?
Could you include this patch as part of that series (since we don't
need this without that patch series), or make it clear in the change
log?


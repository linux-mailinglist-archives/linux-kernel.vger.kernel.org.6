Return-Path: <linux-kernel+bounces-340939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3504987940
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 20:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AAFB2879E0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E94171E5F;
	Thu, 26 Sep 2024 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DIyS4wuc"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74728171088
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 18:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727376224; cv=none; b=uhf8Vbq6NY4Z5YhrGvBEHFmZoybnIuOwMFNjnXRXRLOB65SUWGmKII1jNkBAwLtNBm6DmOQzP+uKtBc9V1/RNaYQTpCRnyQvy6TmBGwGPZNdBi6eKDfZJO5gSw1imNCBqJ3PT4KZxFyfmwObaimamjcWRKF6LTBuIjaja6rfEnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727376224; c=relaxed/simple;
	bh=N47sLM2gPDK8H/UH6Urqt+sRxN8GMBO7RiuFRUvVp90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wlmh49/gQ97dL2pbbx6k6Q4++KcQnAdAw3iD/FdX5PZktkua9KaQ7n620ZpRSW21chUDBm34TzqSBJhf/No/uwlHM3KRyrOmpVLYikV1P1rdcZeUmpGC53VfSizip6lk6x9gPw/CnPHvG8fTCPUGdnwKmdKIFMEJGZSGYDO78W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DIyS4wuc; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f762de00fbso16634211fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 11:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727376220; x=1727981020; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t0PzEVEemf5GnI1QTvkx4SdyCDccmGN2z7Xse9jYZ3Y=;
        b=DIyS4wucKh54IrmmWviKGd6c8Bm9uUUceUYcvdQABiWAbaEyIEGOY9ukWLT+pqGThA
         P4ink5ZPFL9P8v/OSxL35x6ihV+/nzQ0BHdHWkYK5Aq15ll6wi6C7OrxaAh/D3e6JxPq
         aTN55nPpIEdixYSsI2RUvutK9frfVm/v050GA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727376220; x=1727981020;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0PzEVEemf5GnI1QTvkx4SdyCDccmGN2z7Xse9jYZ3Y=;
        b=DvPb2rM1p1V5ML2kfvkRfqGxZTh47EEnRNATa4u3CEV6YM/i4k6nij7MYilr82gHFJ
         Yg9KDtUZkyxaIaH6AZBMFItPOU6U4g3iJ6Khrt6Ac9i7vOxsy9wnIKgdtOzCdV/iIqs2
         Yv1Bck6OnYiw7zy8TsNCWKXA7hKJwERZAB57QI/Ts1OPftGNBVt+hKDUcPhTWErRi42E
         HWIeEckAYdOGVazBwA9AOVLZ6zew8gHnoA7Sx4SPWSvPlEynpTLOPPghHridTZbNGRrp
         qBhdT1Z8s+z68hcj8nBcgBjZPFtYoCHI2oupFX/anm74QiOlXZhbshYXaIkGx1/bD1lz
         vJpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU20vlqlN6ky0y0HXqDobSoD0S3XyTfqe7j+ax+ugcdqCeruX5b1XZn7rK8RNI1st7tnTyeTQWz6mWThtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdaJcvb7AvAJhN+M4QCdlJmNe1pHSHAn+02EZvWXxzLfEloXJf
	moDllBVHnKrwiUS1km0sTavwhNtug/BVsGgydhXZwNtoREbqs2aKcuS6hopJovJDorM7LqYTi8V
	wUonShA==
X-Google-Smtp-Source: AGHT+IHgDYi32Gfy2SIKUdmSiSyxyPkJDwcT7J1tNdHiWc49nvOEDma8DlGJgvNnv0IeO2dLt6GcBQ==
X-Received: by 2002:a2e:a541:0:b0:2f7:cba9:6098 with SMTP id 38308e7fff4ca-2f9d3e78d0bmr4862811fa.19.1727376220190;
        Thu, 26 Sep 2024 11:43:40 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88240b5bdsm223361a12.34.2024.09.26.11.43.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 11:43:39 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a86e9db75b9so206725966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 11:43:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX4yZ9xVSGakFOPL8/Oxxw31YDcpILQOtsZTnMYQ2dfxYhBn8/AMWgndaDpbLYt4YYNHOeevybnEdLoL9o=@vger.kernel.org
X-Received: by 2002:a17:907:e89:b0:a7a:a960:99ee with SMTP id
 a640c23a62f3a-a93c492a589mr41084466b.32.1727376218897; Thu, 26 Sep 2024
 11:43:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202409160138.7E27F1A55@keescook> <d122ece6-3606-49de-ae4d-8da88846bef2@oracle.com>
In-Reply-To: <d122ece6-3606-49de-ae4d-8da88846bef2@oracle.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 26 Sep 2024 11:43:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJiePHNw3Whxm9n==h3-JwXojefAN3OiDzT89BO3jDew@mail.gmail.com>
Message-ID: <CAHk-=wiJiePHNw3Whxm9n==h3-JwXojefAN3OiDzT89BO3jDew@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.12-rc1
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	Allen Pais <apais@linux.microsoft.com>, Brian Mak <makb@juniper.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Jeff Xu <jeffxu@chromium.org>, 
	Roman Kisel <romank@linux.microsoft.com>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Sept 2024 at 11:29, Vegard Nossum <vegard.nossum@oracle.com> wrote:
>
> # first bad commit: [fb97d2eb542faf19a8725afbd75cbc2518903210]
> binfmt_elf, coredump: Log the reason of the failed core dumps
>
> I have to admit I don't immediately see what's wrong with the patch.

That commit looks entirely broken.

I *suspect* that the problem is the crazy "get_task_comm()" in that
takes the task lock inside coredump_report_failure().

But honestly, I'm not going to bother even trying to debug this. The
whole notion was broken. People who have problems with truncated
core-files should be looking at their debuggers, not asking the kernel
for help.

               Linus


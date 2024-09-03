Return-Path: <linux-kernel+bounces-312899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C19E3969D64
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CDFE1F21D1B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A101C9851;
	Tue,  3 Sep 2024 12:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c3ZdmfnJ"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1371B12F0
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725366126; cv=none; b=GyMmtUqEiYnBFSzXZKGKCYeaz8YXd2PgL5QXzvrGwVKQ8uxNKgFprE3nhWUYNkMZxaUaUCRpY3xDN8QJIIGYJ4bOKhLhNqkYPATuwFydGPJte+YYQZNyz9FQrmZCOJAUcUn+618VLaSYGiCri+pZri6X861J5HQB15ItOvRNfVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725366126; c=relaxed/simple;
	bh=iVvw6Hvy8K6woZwjLvsf0Zf/r2JZ/Aun7jO2Q7vtrL4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZCIKQ6rUvk4xzgJkxxrfAVUNpMFaogjnuos0pYQv+nTYYhNlBRA0ZnGK7ekfbahW7M7E8QJPvv2xEmjHTmTIoTR1Mki3ieMFL/SE1Qy82M4WF2ts2oQ9UIYeN2oN8Xgt8hG5DYYyfE6+NU9ToLSUReOfzkLaX87l+KRuFlTgJSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c3ZdmfnJ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-45680350696so5067331cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 05:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725366124; x=1725970924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1iNKROeTecbC7NJJEQLnhWG64uAyJxfHsOWVXv+2sIQ=;
        b=c3ZdmfnJ2cQe6uh/OQUVKSMyAQYw/qORrrueT8hlxNUbASMilHPxer+gA6NNpXxccx
         kedSr651+aJ/yUAObuh1yZWznd6WFffTPpN6SBA13AGnjdKZA8g5rMHGzYjDrYbsCWt1
         lwmsHV+P+3u6xJRgLBcvpedSi5V/qwws9sg6KQAhmqVcpLOp3Sc60yYb/eNFekY5cIaH
         6hMJ2xWcRDx3i30Omq31afcA5alLkIJ9hnUpVJ9/WDNk+j4wltlb2smaLOeZLM+O4Qht
         ivENUxOPIxoHPEcDwlR7lkDa2cr+7IDni/8/uH2PByUfeP00ktVPuNDqoTjWZmypA7/x
         omYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725366124; x=1725970924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1iNKROeTecbC7NJJEQLnhWG64uAyJxfHsOWVXv+2sIQ=;
        b=BewktXHKVbIwY1H4iPeZyDcDqLbJqaJytexXmBAKUuX45BceUjFTC8tKB4TRVIZNpm
         6t7g9neG4ew79/uBvLj5u4TVpKcRgdEt4mMldjwNrjC21WN8VCdC8q64dhB5vRDRkH7A
         LXa1on8CxGNfZcsFJoZif0H6s1GQVjT9suFXVlO44F4GPEttEOhqZagPQ6ht9QVj3t5k
         roxJhwFTsVOonxsRog4E7tB+4b5+tCnZcc0I5elafsZ658il/xVQ9D/ukzsSmN8jVR3E
         8BqWXD2seP0ryjGlHca+7DCNNvJD4qwsvkQXtIh4PiqIZwr7poI3xxYrl2MubvRkY76A
         7tWw==
X-Forwarded-Encrypted: i=1; AJvYcCW7I/LsV71dUCpZ+jnbB/cGaaMP7mz04brE9tV4iL7NQKFKA+VyXtsl4kgYCjCB+KRpBcLvELors4PImY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3yrP3FMGSu9a8VU2sWVCovVAoU1NYbI1erJLCyWdW/vWvAZYG
	1brjFMR3xbitUf88s7OghyJHf4lf+75tX9KhhJbHDX/DQUN/nc627eQZXiR8gaNgXl5ofutnuom
	ihuND+QD+9/jOVqnXHH0bjt81csdYnrNfiHb9iA==
X-Google-Smtp-Source: AGHT+IEdISPnvRdSEUjr50GKb9NjFs+AWGhLcxRrWqnXIzc2xeEAJX9J31hXyh5Q095NVa2zLCFGLhEPYKSvu7vnZ0Q=
X-Received: by 2002:a05:6214:230d:b0:6c3:6da8:8cb1 with SMTP id
 6a1803df08f44-6c36da88ef1mr25683596d6.5.1725366123844; Tue, 03 Sep 2024
 05:22:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anders Roxell <anders.roxell@linaro.org>
Date: Tue, 3 Sep 2024 14:21:52 +0200
Message-ID: <CADYN=9JBw6kq4E9aA=Pr1rFy-6tY-j-XOthQVYVw6ptmj11=HA@mail.gmail.com>
Subject: Potential Regression in futex Performance from v6.9 to v6.10-rc1 and v6.11-rc4
To: David Hildenbrand <david@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, dvhart@infradead.org, dave@stgolabs.net, 
	andrealmeid@igalia.com, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I've noticed that the futex01-thread-* tests in will-it-scale-sys-threads
are running about 2% slower on v6.10-rc1 compared to v6.9, and this
slowdown continues with v6.11-rc4. I am focused on identifying any
performance regressions greater than 2% that occur in automated
testing on arm64 HW.

Using git bisect, I traced the issue to commit
f002882ca369 ("mm: merge folio_is_secretmem() and
folio_fast_pin_allowed() into gup_fast_folio_allowed()").

My tests were performed on m7g.large and m7g.metal instances:

* The slowdown is consistent regardless of the number of threads;
   futex1-threads-128 performs similarly to futex1-threads-2, indicating
   there is no scalability issue, just a minor performance overhead.
* The test doesn=E2=80=99t involve actual futex operations, just dummy wake=
/wait
   on a variable that isn=E2=80=99t accessed by other threads, so the resul=
ts might
   not be very significant.

Given that this seems to be a minor increase in code path length rather
than a scalability issue, would this be considered a genuine regression?


Cheers,
Anders


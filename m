Return-Path: <linux-kernel+bounces-510157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D8BA318F6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8F53A2621
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FB9272907;
	Tue, 11 Feb 2025 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bRiQypg3"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E252B272900
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739313800; cv=none; b=IwOsFFThv37KqOG6NM6s8oETVmRM/SWexOtqlOA7W1chYciIJodPe1pmWJasD5vR/yU29Avh8CuvDDSMPeiTi9CEFI1e8M9hjmdIukEpgl0MWj8y35lGBEI/49zgwSj1ZnJG6hhMEU5Ps23GT6ZL+uWgOknaxMV9lgFI3jxxXL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739313800; c=relaxed/simple;
	bh=f9KY+6eNEKUf11+++hxSSdeAgCYvmlb6iCdNJHIeWzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JF6otuRPBdZp5JsHBR+FAXNFvXawCQ0Z7E7AiogRi/uBEoU2QPyPdPFiHU0X/EkqQW7JRPdZURq5T0FyJ6H5iv6pmmxe4277XPLvLNFA24GkblD9QCv8qpkFYa93bAqpX2OAxtskJ67gKwoptZ01SvltNxrw19dWNpQIKId4U5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bRiQypg3; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d147331fb5so48405ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 14:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739313798; x=1739918598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QB+Kz99xiql9mHJ4ulDoF28EHq/GR2RedSyzITbYkFc=;
        b=bRiQypg3AU6ZI+W27dgsgAeIRjICjIhWl0wtHVUzrya7DTM0dgbfZqCzqGkqt69PM8
         AcdMArKLgJZbgHWB+X4s+NWmFYSR4nS/oHT74/U0pa61yzexaUFJI+4/A46xQo3Lb/zD
         tOTMzfIyrxrXeNufwpU3b3I64InWjzY/WhgmwdsJKT+fyl27rLDgqM+NYauAIW1Fx0qr
         d0IHAvfQDiArNslg2vQTNNYdqp1utIWB6VAhYHd/PukVqtdyWJ1PhRoOv7/umUiO79mx
         Vl5V4Glpe+tP2kB2KStIteEw41L9PlLe8w2cpRJGKx99lKJngP5gxkfROEw8bPI7zxpT
         u/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739313798; x=1739918598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QB+Kz99xiql9mHJ4ulDoF28EHq/GR2RedSyzITbYkFc=;
        b=IGRumqa9zZrFKRlJE3y+oEB22aV5DH19JqEaDq9FrINCk7faWMJQ7wrfJYPHag9eae
         xhVfYstNrCW7rLlmrEVFrMZytYlimo6j/FLVLlukbbG9J523dOLA/Ol0kRTe3KfGNKCj
         B1ZYg/sL6ZP/boiNtL0W7N6cUzGIXv9OKP+LKFR1xmS24cRodE2K+X9LbTQAVSXRE8ZT
         +nV1GknvwYLtmgzBLA3IWl48YKSASn6rTrrGa2Yis2GHiQeqJc8KL7s5nFJWE3Xw18P9
         5llnItlTeSqzl2CJFuC+B+CAnYpp9iXmnLC+Yd5lhGga5iXtBF1EHDb4zbgYmT0Qb2Lp
         JJDw==
X-Forwarded-Encrypted: i=1; AJvYcCXCebRsppb4VawM7Ur9vzH23MGnpWwbMD3Gx6sDpUqzm0+uwxzhDaftK/3jpZewZWA95pPRKUmDzCiYHfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAjHjSEm2iaapL985QbxDA9eGP5uNJexmq0Mgm7pjE+ltjwQQL
	l6ffOPzhYaAtPY3GWlad8A9a7jpMDQ/96QQfsxsW/QjohUIqimJSBXM4rR+G0qH9WBOTaCoepdu
	azMzwp/VT7TpJ5Bl4lIzPCzVq94VJWrLBGWq8DOFndE9rsfBXsZSM
X-Gm-Gg: ASbGncsQaVcdGE6KOXqnZ8oUunCHdDSEGLK3seFBLNUGOlvYPZcOx3s2ds4VELq1Azw
	S30wHeGb/Y0FOiXw+vRx/l3DcswCiNzWcKWP/Dz+oAM45O6Y1JQLAuD5VOhtwWMYNGPAvqPD7RP
	vuEIUrzJqLjlZwf+pJgVYx6qxN
X-Google-Smtp-Source: AGHT+IF+cb7GE8XgaPk0n38/Yi4kaWPSQbEoAefJVRYnQU6O9euNmFzz+KH9Emoxt8mZXUIIIsvpA+wdR0FLZmlK18o=
X-Received: by 2002:a05:6e02:1c03:b0:3cf:a4e4:8f89 with SMTP id
 e9e14a558f8ab-3d17cd5f2a3mr1080045ab.4.1739313797883; Tue, 11 Feb 2025
 14:43:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206000137.2026034-1-namhyung@kernel.org>
In-Reply-To: <20250206000137.2026034-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 11 Feb 2025 14:43:05 -0800
X-Gm-Features: AWEUYZm25vHIgauOaEXBMf2v_MqwEaiH1o1lrNB8Jgsn7jomjRRVF7NAhAargog
Message-ID: <CAP-5=fUcjEONLZ5uTHMDep3xF2b7ZB7Krd1dEViUSYfuWT-G0w@mail.gmail.com>
Subject: Re: [PATCH] perf report: Add 'tgid' sort key
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 4:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Sometimes we need to analyze the data in process level but current sort
> keys only work on thread level.  Let's add 'tgid' sort key for that as
> 'pid' is already taken for thread.
>
> This will look mostly the same, but it only uses tgid instead of tid.
> Here's an example of a process with two threads (thloop).
>
>   $ perf record -- perf test -w thloop
>
>   $ perf report --stdio -s tgid,pid -H
>   ...
>   #
>   #    Overhead  Tgid:Command / Pid:Command
>   # ...........  ..........................
>   #
>      100.00%     2018407:perf
>          50.34%     2018407:perf
>          49.66%     2018409:perf
>
> Suggested-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian


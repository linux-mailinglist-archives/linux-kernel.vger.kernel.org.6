Return-Path: <linux-kernel+bounces-239960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F95D926744
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05022832B3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A361850BF;
	Wed,  3 Jul 2024 17:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="Ew771wkM"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ACD184136
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720028133; cv=none; b=iKqFFY9OI9ixpL8bm5aQhyMbFVncEeSI3PnsgDv0bA2adCVl6GhGUKDPG7TX/dAxKKDuGgShlgwg+RxnpX/SxbE52IMpzosiNY2d80O5CGq2SI5RO9eGg5lT595+q4EKOLcCX1AppfUf84V+xyDnyZf+mgzwPLld4RaqqkkL9QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720028133; c=relaxed/simple;
	bh=wJqbm0cbDl3OnGsiCx+j3UvhXYjJ+xSxrF8iQeOZADw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgizOZi5zTAnTHOSPHOJENDEhcw88QBcGMXmpwai/GmrgqxvT5ggVhc5PO/2V2G62yNrkh/DG76at3wCqoep0PhbSTtZLt6/0iDHntmM5EiSiDwRabAxuMrQAqdCFYhUH1hu9FT6XIPKIvziHVwsYVhzPOOTbUcg0+bneYHCkAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=Ew771wkM; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58b966b4166so2848172a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 10:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1720028129; x=1720632929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=La/5eaYjg7H10Or0G7dRQblWRQsDom6PBTc29FvwiUA=;
        b=Ew771wkMq+bZe9z1mdKOOaCBmlghWM4YQ1pE7iwmJv6xNqWZA//bGGIsqKVXtqHijg
         A8KEDQrzybsV0tScp0gjMsEOuAhsn5da8O4YVxqMTh5odB1BV8Nh0eoa+2nPiBvYaew2
         AnxAL9um6v/FsGNM0QmEe5lN1eeZtLtQTTs6z0b+SNubM+CibLB4xgKEoPYWGNdlfx7v
         8o+X8rZqVYXTpw2wRTwBX1ei7mCrGMVcFwxLWPW8/PSqfz1osR2Vklgg4PKMUvP1MuXR
         u9p1EECek7zDD8GzEM8TqRz16NOhDY2BecPbKa26K31emH+4R4KjDn/PZeFEhFL9Ihts
         PKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720028129; x=1720632929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=La/5eaYjg7H10Or0G7dRQblWRQsDom6PBTc29FvwiUA=;
        b=K848z43LC9h45v8FN4HDVSATxGYeiEHR99F9EZq7ibL6P2ZL8x9YrfhIJMUNqcZB2+
         1E2LS81SyvqCiqEoho0wrqLTUzVOk+x/6am4s1E+Doeipy/9qeHygVtN59VGb4IXq5YF
         HQWmCMmFS6pL5P8VGRErzQVtj1+zno7T+LWKB/IytWqP0rCZsb0solD9pHRb1ZRGtOSn
         6FeKA56bSQlzrHr4U+PAtoMDZxpbxMKTYoWlVAWppAgOBxE9oTcBIA+Mwqi5kqbALgSU
         m6+YVBf9Vq7WuAhTCQtigoHzarr6pB9cIEIeTDta9uJnRz1QnE6xMnqo4vTGSlBHnlIX
         IXhg==
X-Forwarded-Encrypted: i=1; AJvYcCWbQJ+QQ4f5DNqEGKYR6j6ed2cdWvPJ5RJ4UWtg8H4f7G9w/fXm88ZWYmujYvHHTCFGQQfL4oCNNMYtgCcDkLlvDgiAWUBbbzTZFEYO
X-Gm-Message-State: AOJu0YzvjSIo/y9N3t26Gm2c1WpzkB403tfT/TEtax6M1zWuyvQknqWT
	h1kb7Az8OOVjSsCUWtbgDuMiOb9ObSbOSsT90+wDi/ibyw/oRY/E+/eKSKyoGRpHZT5y5cbOWt4
	k/TIh7GsqHVGnpqJ66bvkJxXtll3fJGwwXX9xlA==
X-Google-Smtp-Source: AGHT+IFBjLDcJRjLamuVf5zi9ojzKBMa9/VQRJAc3OBE+azv+Z6WVHDWucZC0ZTibSml6j6VgCjcl6c8rGjZ4ILsUhM=
X-Received: by 2002:a05:6402:2345:b0:58d:10a0:36c0 with SMTP id
 4fb4d7f45d1cf-58d10a03b2cmr1425175a12.14.1720028129456; Wed, 03 Jul 2024
 10:35:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703172117.810918-1-irogers@google.com> <20240703172117.810918-2-irogers@google.com>
In-Reply-To: <20240703172117.810918-2-irogers@google.com>
From: Matt Fleming <matt@readmodwrite.com>
Date: Wed, 3 Jul 2024 18:35:18 +0100
Message-ID: <CAENh_SR=4axuur1=ibGnGre8vm7tHNeG0VT-f1UQS1mHCUb-Uw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf comm str: Avoid sort during insert
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Steinar Gunderson <sesse@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 6:21=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> The array is sorted, so just move the elements and insert in order.
>
> Reported-by: Matt Fleming <matt@readmodwrite.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/comm.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)

Thanks, this fixes the issue I had where perf-top would spend >40% of
its time sorting comm_strs.

Tested-by: Matt Fleming <matt@readmodwrite.com>


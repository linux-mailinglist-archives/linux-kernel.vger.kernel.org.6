Return-Path: <linux-kernel+bounces-247960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FB292D6A8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B014C1F289DA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EFB197556;
	Wed, 10 Jul 2024 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="TXq782N4"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AF3193476
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629368; cv=none; b=UxEUXof0dyQtdG2t+lmvktA81u1hLsdAgOqhzqbq3SqH94p+BgtlMQtje08CxgZZ3zeY/vLsloqyOXGt841MgeI6mbqDWVVcLFl+Qxv7tTY3tWp5PWrja5Qlq6MwRprXrvqmJDo/1lwaEbEIw20M0LXsnJ0W3PODYd5hJhN+s7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629368; c=relaxed/simple;
	bh=AmY7/0Kx5MgGmOlXPK9ZhPz0KG3pwbKkQWq8KfClfAo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M+JS1GyBlyn3lyOv0ATrWAJNqcZdG3w4Bymhv9K8CpRwm37pDmfnYqrz11mAEobQQC28+jCCJT/pqdQOQNjFVWL12id579k50dfjeOEMNBXBy9XwPmyQh7oRcTJAfex/ZfEJjtkhVu0CrqN3Kbqs3pnR2sJ30Xyu0rNLplZ68NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=TXq782N4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fb05b0be01so39673985ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1720629366; x=1721234166; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GAyPmOUdsLd03mlAddpRof18UDE0qDKzzkyVj4fd57k=;
        b=TXq782N4GvwyHd48ipHsDO3etE2d20/+V5M6qIka7kkntUCKxBAxsK+tdiolSMOVgA
         glcFBqoe4UXxI1AFXNUK4fG5HSp4ggXEplqxx4qGbl8TUIbeXns67Y2JGInI1hKDh3Ul
         Lqjf87pK4l4lP5/T3Zg6573aA5cqoydHj8GkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720629366; x=1721234166;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GAyPmOUdsLd03mlAddpRof18UDE0qDKzzkyVj4fd57k=;
        b=cFoSW3Xdmi23sz+wNOqeUxaPADl51NW6N6c50IfVEr7byLG3XeWJE4Kwja1xYff5vR
         88rF8ALcZoJwxE9wIL/tMJjUZcHIeAO2g5P45rAIlI9dMKbDzgJP+4GsxtUsp0HkmSSQ
         zyW6IQX4r/sh9ddfugScKUtY3fjENrc8qvCh1oW+VJjtKuXVdlvQP2OPd4iR+M4PKZu1
         otjupuevdsb2eWzwHSwpLym41jt0HWAXiwBnzF2BBRH7DNhdTBipQ4J5psWmvegAcdBz
         QsOIA8VfyWbYFjUf9ZtEktIanv1IHoITkwnX4BpHnCSRts94qjhvzbUjmx8gwlv1M1T1
         ftJA==
X-Forwarded-Encrypted: i=1; AJvYcCV0L4OV+oTfn2NqNRyZ+LGo4zkvCEcXhiyi4MMIAWzRSnVw+VgkbHAx0y7C12XqofmmJTzXozOlMbgN0PisMSWN4XtOgsvqqNc8Kqxt
X-Gm-Message-State: AOJu0YwhXzaHRELjE/oNg6Tfkjyoda9Eqs8AkKsZgu+N7LTT3Ai6HNyZ
	EaAqTbuDLn2OHFwC+TS5C9Gw8NfLyq+05HGVaLreZz/PABn4c6iIcciqD1ghyRo=
X-Google-Smtp-Source: AGHT+IFSu03Qqw8EY48ag2gKY7v/+/XrSg8iNnofNUiIjWSb3EZMr23XoXHhqrVrkqdA19mx9qnCjQ==
X-Received: by 2002:a17:903:2344:b0:1fb:9b91:d7c9 with SMTP id d9443c01a7336-1fbb6d34b18mr54539825ad.4.1720629366052;
        Wed, 10 Jul 2024 09:36:06 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ac3111sm35614245ad.212.2024.07.10.09.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 09:36:05 -0700 (PDT)
Date: Wed, 10 Jul 2024 09:36:02 -0700
From: Joe Damato <jdamato@fastly.com>
To: me@kylehuey.com
Cc: acme@kernel.org, andrii.nakryiko@gmail.com, bpf@vger.kernel.org,
	elver@google.com, jolsa@kernel.org, khuey@kylehuey.com,
	linux-kernel@vger.kernel.org, mingo@kernel.org, namhyung@kernel.org,
	peterz@infradead.org, robert@ocallahan.org, yonghong.song@linux.dev,
	mkarsten@uwaterloo.ca
Subject: possible bpf overflow/output bug introduced in 6.10?
Message-ID: <Zo64cpho2cFQiOeE@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings:

While testing some unrelated networking code with Martin Karsten (cc'd on
this email) we discovered what appears to be some sort of overflow bug in
bpf.

git bisect suggests that commit f11f10bfa1ca ("perf/bpf: Call BPF handler
directly, not through overflow machinery") is the first commit where the
(I assume) buggy behavior appears.

Running the following on my machine as of the commit mentioned above:

  bpftrace -e 'tracepoint:napi:napi_poll { @[args->work] = count(); }'

while simultaneously transferring data to the target machine (in my case, I
scp'd a 100MiB file of zeros in a loop) results in very strange output
(snipped):

  @[11]: 5
  @[18]: 5
  @[-30590]: 6
  @[10]: 7
  @[14]: 9

It does not seem that the driver I am using on my test system (mlx5) would
ever return a negative value from its napi poll function and likewise for
the driver Martin is using (mlx4).

As such, I don't think it is possible for args->work to ever be a large
negative number, but perhaps I am misunderstanding something?

I would like to note that commit 14e40a9578b7 ("perf/bpf: Remove #ifdef
CONFIG_BPF_SYSCALL from struct perf_event members") does not exhibit this
behavior and the output seems reasonable on my test system. Martin confirms
the same for both commits on his test system, which uses different hardware
than mine.

Is this an expected side effect of this change? I would expect it is not
and that the output is a bug of some sort. My apologies in that I am not
particularly familiar with the bpf code and cannot suggest what the root
cause might be.

If it is not a bug, can anyone suggest what this output might mean or
how the script run above should be modified?

Thanks,
Joe


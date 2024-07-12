Return-Path: <linux-kernel+bounces-250944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C912392FED5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05F4C1C220F9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDD8176ABE;
	Fri, 12 Jul 2024 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="KxkSJuP7"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F7C14EC5E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720803239; cv=none; b=AXytzmDEOhXp7dnpLpflJk+mhvrV1DN9VnrE8AYh4P7aHwS6FM8OGNS0jW0aStUrhISoXsSeBxR8y99EdTesgwabfkbyuBLfljSRF1GH19/OOAW72rQoWmTvvh7nag4S6Sis5vN2NzRtcIfUFsVV/xoCglmoObJma7HRHLgEvP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720803239; c=relaxed/simple;
	bh=+m6V8fSxun2RfdrTEuNTJneNdueyObfWncInfZ5P5zU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jFFTSuzWg1MrV6u4Q14CCWg7VGiXCr7SzRtzjv+z5PKSKKDM8PnSZ8I0K1x44HYx/ulK8hAnAzESh99exk4ixxC7VdKGO56jWYPLLmsepkUVYmp9NW9GtfRBQX6Usb6dUPMIOlrIIsZMUKkK+yENJCCgeS3RO3yc4tqqsR6xTMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=KxkSJuP7; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c97ff39453so1675314a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1720803237; x=1721408037; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UXQxB5o+ewpSR2K84YTK03ebRY2kbZzy5KfilJMYIlI=;
        b=KxkSJuP7mIU02IAF8z00KKW55tUuttBLuLk/OXRY7ra1FmxfT7On5X3j/pcaZctMlI
         tfumXDs6aVz1aC6ruKEJNl9G0bgJqTFGYSRpIFDtt5GRrq9CHE8gfGlK+PdboRi893zA
         XijwOM7dqMZj222uAY/t+oO/rxm+nppcnzNe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720803237; x=1721408037;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UXQxB5o+ewpSR2K84YTK03ebRY2kbZzy5KfilJMYIlI=;
        b=p5jHZcCKCamYuYurmlVDPktiLqzGh1m6QUzXS9SgisHWVE3COt1u5AJ4+CW7h8ZsDI
         if0YSl3a/PWjmtTLbOePujlugTqQs25Zp+b7CbkaKPvW8Otm1F7WjkZCdbjy2QNVRNek
         aTO6xPS2vnfHVcOwLMh7SZeN84d00Gn9TC2hFXrA7sN6xficeEK34NAZWTzfEbHVOXhw
         ZK/IXypBVAlLJeto96YMBYqAwcdoICRTiMQbOyKKJcqVdSSHO8cS1MyHo4CV7efg6DB+
         6sz5GwYxcchRlMSVQCrC7htkxVTl5+o92VFi6o7W+jINKvW2DM7pB5FI6iMJSyIMOH3B
         x+AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSidxw2Pp+lGOgAbDZ5uhJYN9LgTfGsrfUdw+x4pQzajAp7wSCJbfOeaABE+PQqkM3TGKvoHc2wuQhGfyzRWZywcJM0BVPk77j7lIg
X-Gm-Message-State: AOJu0YxjWFkTbYso/LmqSd/8H9CeY84o+IG1fi6HS5X0XHyFw3/ZlM6k
	Aeu9BR0QKCkvaLkg8JL5wflMJrphTwZMFHYF3Ev8uE6KcJrWO377Jev25uJROnM=
X-Google-Smtp-Source: AGHT+IH5eQziWM3wzjpiIMOQHrPmtuMvPrC5qly54jAATa+tRsZKRP+UOMGEX2sutbwA+WRdzcprjg==
X-Received: by 2002:a17:90b:4ece:b0:2bf:9566:7c58 with SMTP id 98e67ed59e1d1-2ca35d6e171mr10132068a91.41.1720803236972;
        Fri, 12 Jul 2024 09:53:56 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd429eeasm1790270a91.27.2024.07.12.09.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 09:53:56 -0700 (PDT)
Date: Fri, 12 Jul 2024 09:53:53 -0700
From: Joe Damato <jdamato@fastly.com>
To: me@kylehuey.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: acme@kernel.org, andrii.nakryiko@gmail.com, elver@google.com,
	jolsa@kernel.org, khuey@kylehuey.com, mingo@kernel.org,
	namhyung@kernel.org, peterz@infradead.org, robert@ocallahan.org,
	yonghong.song@linux.dev, mkarsten@uwaterloo.ca, kuba@kernel.org
Subject: [bpf?] [net-next ?] [RESEND] possible bpf overflow/output bug
 introduced in 6.10rc1 ?
Message-ID: <ZpFfocvyF3KHaSzF@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings:

(I am reposting this question after 2 days and to a wider audience
as I didn't hear back [1]; my apologies it just seemed like a
possible bug slipped into 6.10-rc1 and I wanted to bring attention
to it before 6.10 is released.)

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

If it is not a bug:
  1. Sorry for the noise :(
  2. Can anyone suggest what this output might mean or how the
     script run above should be modified? AFAIK this is a fairly
     common bpftrace that many folks run for profiling/debugging
     purposes.

Thanks,
Joe

[1]: https://lore.kernel.org/bpf/Zo64cpho2cFQiOeE@LQ3V64L9R2/T/#u


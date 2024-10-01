Return-Path: <linux-kernel+bounces-345621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6DC98B83F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB341F22931
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE60E19C565;
	Tue,  1 Oct 2024 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qcqR9cmn"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC7C19ADBB
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 09:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727774749; cv=none; b=MyavHzlAqKPU3R5Zz51VqCBJAd02P6sCb6uqS3+6aWtax5lnqCMa5v9i+FET9UzlO8XLoIUgHfZnn6F2ifBY0NvWjWW0y+UPPZCo3KUSKfeFBx/iZZZhBjK5vxfmdasM2ZoaYF8rAalt25sa0lAMzeQiEc2i3Glmnd1XzsaKxl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727774749; c=relaxed/simple;
	bh=33vAjiY6Ij4WAhVHDofjMMnekVrRa95a2OTOry8233Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWIoBXphWIkcnG5R7NmKXh2fmtO+o+TYEaPR9UFKUJayB4zgDZDOFxjVavNMpAwudJS5GegW04lnxe3WI7FNIgQao9RtRl0gpQu2d6GM8pW4M2eiqI5IAclxWSXvQF6JWtpzmXtIap5+E616xGNCMlnOTHbX6vl2f7nmzypsQLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qcqR9cmn; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7db299608e7so3373028a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 02:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727774747; x=1728379547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D0cADSnJG4lkQXNDqjVKN/74kET4uX1nRsTWBId7zDc=;
        b=qcqR9cmnfpMgcICrkudm3qX5HkiFYvs8LW20NUQD2K30lgPZ4OLudili6DTfi+Tk0u
         G2LkMHBiUAp7bko4juuis/IrLz8frbY7yBr4rW++2GLJVRO97amZuvj+lvWNuq6KLuTh
         2zW+kHgUQXT+0yMWOcn+XAZzQBLyLzfnIgpn/d4m+87lf420A0/wcTG0fqESC9v8kavg
         s7XBsxt04OFCOh/9utVdts+UljLl+EBStpNVtyudnASA9b7TOP2lRPzh9/zEWPump15W
         3idQm3OrgI3Tf1AEmvA+N5gY91Ofp1jNZD467SbPgrIiSNmi6qBNTEBXcp/0kgOrfxGl
         HqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727774747; x=1728379547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0cADSnJG4lkQXNDqjVKN/74kET4uX1nRsTWBId7zDc=;
        b=uzCM+TZRY18GPIkTHk5/dPGHJ8I8BqBjxh8C3HrtpvXb2cpuwzcPbtfPpAIz4FV03N
         c7TnAndQc46FHxtMis8zs8/sf0DTdv9FLEAQ5gFs0qB2YTKxR5YYpBvzNZvztK34gYAd
         tW3UuNHH3hk74EFdpmWs7J6wIIQwEX2zP58Q2zcj3cBsyzzUJFWYTw3fDG4C/ljdHdZa
         XaTTM72SVIgmTR1bgIo7oW/CWBCGgZpf24MeAsFq+Lq9V8M+4FIioHry0jtuS3XZR4Zf
         lTXnV+mgYlR8hJT4v5GtRLoQP6Wz+BxDoVjpJvvBi6w1bMsHEBy5E6RQrqEsdYvD6S7P
         U7XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQOgB/3PeeIU8we9Gjz/f3kHmhVnJjJHps1reC3w8vEQfAJCKBTWdmdcYX1t/kzCWqwRJxckHfvHog1q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQddWTneo5N91/rQIBHCXXiIGVLeivY306pjzTon7/HE3WaMr/
	zjymXxezw0EhRNY11YkAoLWwYeVxWyw334hzX07ACdBLqm+7oWCHKRncL4B4GuGKXBdaE4sqfhx
	/
X-Google-Smtp-Source: AGHT+IHBj/NFMuB7yZu1UW1X8KeXWG/L4jewlDVgMri4tSan25yMSX6UKBvwgkjf4uX2tojkqnf3sQ==
X-Received: by 2002:a05:6a21:398f:b0:1d2:f124:a1cb with SMTP id adf61e73a8af0-1d4fa639a08mr19899055637.9.1727774747163;
        Tue, 01 Oct 2024 02:25:47 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2bc53esm7980961a12.36.2024.10.01.02.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 02:25:46 -0700 (PDT)
Date: Tue, 1 Oct 2024 14:55:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: David Dai <davidai@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Saravana Kannan <saravanak@google.com>,
	Quentin Perret <qperret@google.com>,
	Masami Hiramatsu <mhiramat@google.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Pavan Kondeti <quic_pkondeti@quicinc.com>,
	Gupta Pankaj <pankaj.gupta@amd.com>, Mel Gorman <mgorman@suse.de>,
	kernel-team@android.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/2] Improve VM CPUfreq and task placement behavior
Message-ID: <20241001092544.2tlydouyyc7jwuja@vireshk-i7>
References: <20240919000837.1004642-1-davidai@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919000837.1004642-1-davidai@google.com>

On 18-09-24, 17:08, David Dai wrote:
> Hi,
> 
> This patch series is a continuation of the talk Saravana gave at LPC 2022
> titled "CPUfreq/sched and VM guest workload problems" [1][2][3]. The gist
> of the talk is that workloads running in a guest VM get terrible task
> placement and CPUfreq behavior when compared to running the same workload
> in the host. Effectively, no EAS(Energy Aware Scheduling) for threads
> inside VMs. This would make power and performance terrible just by running
> the workload in a VM even if we assume there is zero virtualization
> overhead.

> David Dai (2):
>   dt-bindings: cpufreq: add virtual cpufreq device
>   cpufreq: add virtual-cpufreq driver
> 
>  .../cpufreq/qemu,virtual-cpufreq.yaml         |  48 +++
>  drivers/cpufreq/Kconfig                       |  14 +
>  drivers/cpufreq/Makefile                      |   1 +
>  drivers/cpufreq/virtual-cpufreq.c             | 333 ++++++++++++++++++
>  include/linux/arch_topology.h                 |   1 +
>  5 files changed, 397 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/qemu,virtual-cpufreq.yaml
>  create mode 100644 drivers/cpufreq/virtual-cpufreq.c

LGTM.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh


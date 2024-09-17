Return-Path: <linux-kernel+bounces-331608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D829197AEE3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2D6DB2970F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464E7166F17;
	Tue, 17 Sep 2024 10:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ILOnHvid"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15AF61FCE
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 10:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726569292; cv=none; b=MTZ6+6cbyZx9mbxdB+/Jjhj8YNmOzMNjIRp9QEOvxCAa8KrUpKG8890hhS6EZA9WJt2RFTSOpfr9ooKQizMp4FJ0Gavmtsk24ptqbrT2ppZ7JlplT6V8xgWQK/EGtYrTRLFAJjlFsshgu8hQmaJLbmv0oGF9/rIcdzo2SRnGDuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726569292; c=relaxed/simple;
	bh=7/3vPXDrQWMhs9icxfIhVsMHblmE8JCuuUC6wc2CeiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3lQVjcOz4lvEQwBsJbdc6oQJ7geRsTLMJ5OhInq7G8i8hFn0VtxlEV508zXjyH3uO9/otkJDKM2AX0h1agv4y9invE8GpUjmJx5SF1awjo/sM6Jv2x+t8LVHZ+5FvNRpV5bzi63XWBam7b23CIghnuh7cGhhJInTkoz3knivxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ILOnHvid; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb5b3c57eso54006755e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 03:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726569289; x=1727174089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3lajiHp8pF3piHvYLQb6FYA0YAlImwOIzK66rOuQWis=;
        b=ILOnHvidhGH18+EDdsZLFVm9cHFxr29LqgOUwdaAHDEESf49nh8ZB8kSSNI6vSMSXZ
         80yqpR9J0Foz+3OU5RTYv/0BUkJgAbwr8YST4s9M7CCdFavRf4VtwSNLiS3l2t6mHtKZ
         yY3i/LvXQ2ZXpHozVoZWNa+P76L8oQKmwIS3eI9rNqz5urpnq3paYRoXss6ZtuyX4for
         uKUWdmF7F0Jg8YLzQUpHlNtDdhNGtto+yI7IKtUqCAJ7seJ5GkRsrcfBR/1ynOZbJi+j
         I2WU3CCRXekZygBghS+RJlPIQAgOOXoLcWdCyvXAnaVO6PaQwz6G1Pavy3zNurJaxF7V
         s4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726569289; x=1727174089;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3lajiHp8pF3piHvYLQb6FYA0YAlImwOIzK66rOuQWis=;
        b=s64RCLCQi16FXUfu05yyekHh791V89KQ12F2NGcBGcBAqEEo+f6lXx/BiGlAWPVz8g
         Hvr6Y4B73+odc03Y+A3G5SCSN2uZ8g3lASYvk8GN7TPXlKvoHFbDM40iNOskaa3A1i+e
         s5nXHfyrWQxU6k3ozsCl73Mmq1Y0R4VvYOpPyKJPCwQED8WXf++RhjfKFxILmvjfD337
         2DQD639IIX3n9IGrc+8pS8J7fXIki5piVAJa2vulkLMV+9p4gHMul7Uh6ji1GbLd37/T
         HUCGvzjQ4b73/woUT1xNGSgF0trVuuoJYevjpUEWceI3Om2gOJ352/YJGfUFGQTq2WIv
         mUXA==
X-Forwarded-Encrypted: i=1; AJvYcCX6s74XNMOtpbt0HPJVAooUhwqwr8Z7eW4rKV9AYUL6s+cGMlvRzUvt026ZT1yeNFRBh3jh2H41fS3eXKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8qXkMOGj406fM0DjCCCbMGWtFQi/pZLY1ghOiPUkmbg5CMMfg
	E3gWBg7V6YXA7ZpWvwqp5gusS9EQBxpG4H3E7GwH5kagSS4PgtMDs3jEOT/UKzI=
X-Google-Smtp-Source: AGHT+IGTY3U2D3ATkqAlxhwKnfD0PwMT+SbB1VPzu7nsazWDiqfRvg8PRPw4ZwRCHyCLO4+1Gti3kg==
X-Received: by 2002:a05:600c:314e:b0:42c:bf94:f9ad with SMTP id 5b1f17b1804b1-42cdb5919fbmr131246545e9.34.1726569288794;
        Tue, 17 Sep 2024 03:34:48 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f99a4sm9100986f8f.57.2024.09.17.03.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 03:34:48 -0700 (PDT)
Message-ID: <95e39d9c-7f0e-447b-9b2d-aab5d36b933a@linaro.org>
Date: Tue, 17 Sep 2024 11:35:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] perf sched stats: Add record and rawdump support
To: Ravi Bangoria <ravi.bangoria@amd.com>, swapnil.sapkal@amd.com
Cc: yu.c.chen@intel.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, rostedt@goodmis.org,
 vincent.guittot@linaro.org, bristot@redhat.com, adrian.hunter@intel.com,
 james.clark@arm.com, kan.liang@linux.intel.com, gautham.shenoy@amd.com,
 kprateek.nayak@amd.com, juri.lelli@redhat.com, yangjihong@bytedance.com,
 void@manifault.com, tj@kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, santosh.shukla@amd.com,
 ananth.narayan@amd.com, sandipan.das@amd.com, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, irogers@google.com
References: <20240916164722.1838-1-ravi.bangoria@amd.com>
 <20240916164722.1838-3-ravi.bangoria@amd.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240916164722.1838-3-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/09/2024 17:47, Ravi Bangoria wrote:
> From: Swapnil Sapkal <swapnil.sapkal@amd.com>
> 
> Define new, perf tool only, sample types and their layouts. Add logic
> to parse /proc/schedstat, convert it to perf sample format and save
> samples to perf.data file with `perf sched stats record` command. Also
> add logic to read perf.data file, interpret schedstat samples and
> print rawdump of samples with `perf script -D`.
> 
> Note that, /proc/schedstat file output is standardized with version
> number. The patch supports v15 but older or newer version can be added
> easily.
> 
> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---

[...]

> +int perf_event__synthesize_schedstat(const struct perf_tool *tool,
> +				     perf_event__handler_t process,
> +				     struct perf_cpu_map *user_requested_cpus)
> +{
> +	union perf_event *event = NULL;
> +	size_t line_len = 0;
> +	char *line = NULL;
> +	char bf[BUFSIZ];
> +	__u64 timestamp;
> +	__u16 version;
> +	struct io io;
> +	int ret = -1;
> +	int cpu = -1;
> +	char ch;
> +
> +	io.fd = open("/proc/schedstat", O_RDONLY, 0);

Other parts of the tool use procfs__mountpoint() for /proc. Although it 
can only be in one place so it doesn't actually make a difference for 
this one. Probably worth it for consistency though.

> +	if (io.fd < 0) {
> +		pr_err("Failed to open /proc/schedstat\n");

A hint about CONFIG_SCHEDSTAT would be useful here.


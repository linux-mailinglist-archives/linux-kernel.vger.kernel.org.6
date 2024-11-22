Return-Path: <linux-kernel+bounces-417923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EAC9D5ACC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592CF1F22DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52C318A6D9;
	Fri, 22 Nov 2024 08:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dHz9BAUu"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D2C172777
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732263190; cv=none; b=FiEgXsxSjAXiv1EFpjfXIb+YhYInb7M/6m8kAlUNdt8GcnU1P+2Ndp/5hK9STqw8eVfu62Bg8khpLTnmkRLSXnL6z/F+3Hzr/IdpNpl+tzNHbQUu09ZEfMjgTdULK6Ixe0fE/l59/iPbkdHIg88SENdqp2TC9nr+aVKBiaG7DVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732263190; c=relaxed/simple;
	bh=2cC5+ylqaAyXDN4/QbFBkSVRcxQfIpjqqG260ixa/b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjLmpN1zIqzbJ2bxFYVTCP6c4wBijat3xH1Cy/U9BcWqDnfttlY6Eq6nwxRhc0kJM6nZD9qY4q/NPnRclP3rZyz77uAoit9KYm22lQOU1hSLnGiLwVgDZ3s1MZ4HnBYbJsnL/n/DLVVAvbk4FVs657ieYBa6luWDwjAgpR5oT7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dHz9BAUu; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea8de14848so1595764a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 00:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732263188; x=1732867988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qtiM7FGfMA/9Bsc4nOUQdU11ZmJTmqiA1GxS7HwsgKQ=;
        b=dHz9BAUu7Y1/Z9lGnVDXwT5kPGIgQN9zzr0YX0ulX23DdNsDgflpvYzURB5zkwbUL9
         77ebqswHThX2nFRVc8bq8lUtAHMuME18CqIb7W/eA9J+Sp6Yx3rLp0tjiUmiMv/bJsCP
         P4LtGPuR7PgF9BufivCB3tGDYa7GY/vrkdLW1LA6YTPLe4lMvduezQQskMXTAg1Z6uFw
         cnPGwUOnttYFxE+ULLbAoBs3jmL2s5ooJgKcwnrBC5cCiLS9ykJzgA98D7rLXfuDXtZS
         wzpfXvHzlEsiSjpdItsNJ71xwcx9MPN6lK79zIGR36KInb4fJfkl+w+ik3eq3kLhcaLG
         5TmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732263188; x=1732867988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtiM7FGfMA/9Bsc4nOUQdU11ZmJTmqiA1GxS7HwsgKQ=;
        b=b+zogCuZ/Kfk0PV2+F2ZL2Gobkgdgt5767JfWSIMgMG/zP8r5Wwge/yFd7OY+1k3Qm
         UAaKtJgEfP2RMAu+Sftv5UACPa48/wI8YaNpPJFG9KuxYPbBh1bRQICjIDe06mz8osDh
         OkJFkmVHWZtVDgOwCRs043lvoG0yhG+oNoTirx8A6Nr17Db9NleiqsZBsE2qEImIoqAO
         z7g4CFbOEIr3PSyHeZVYciq9sw9I9O8k/Tk3s4eOlKEYT+Mz5nmOS7nH8w84cEfSLHow
         VB6uDKMhzwgxIlhHId+ZXrQWjZRYckH+599oHvrVP4ePK05AObq7gS+LSgjk+wiegKFy
         tLzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOCicrpT18Er1rEmBne4RgHJtnpu7ZbmzDVITU8yJaf0/9DAot8+RqTbh6tFfpGLdVm8spKglDMP5iTu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyakS91I2JX3CUAJMG1c7NlS1RaCXrk/uxJGaqFjctKnC4Nc46W
	pU9gv7L45oVFZXwN9dlGsSCtvcpurYG/ncmRNVlJ/7eFcImT0LBpTrkYrRe12I0=
X-Gm-Gg: ASbGncuf9g2vjv2z318FlotSpfHhZSylchKc8c8VDCnNgy6abG1QMeJO7KZbUZX9SQL
	Es3ZfkxPMNg4F+2I7f0iKo3M0R6XuU/eH/Q0J5PRanQQFefCBrUAZI7kwyatKgH9YopheTJggn5
	iXssjFxZ1ZWgFlt8MYT+YtPdIA83PPD61gT7aNje6I7sQDGLzbbUAKIztmi7mDStsORcwY3s/BI
	0u9BgKDkW3L1yECoYzZo5c+ZuLLMwEeM5TURxl5xlz5NGBE44bN
X-Google-Smtp-Source: AGHT+IHev06k9pGAl1nqt+OQo9UbIc+5qm1amkYSvGMCzvONl7a9WGyQtu/RSPc8s9vIp3SP7KWhDQ==
X-Received: by 2002:a05:6a21:6d88:b0:1dc:3023:bd97 with SMTP id adf61e73a8af0-1e09e5da6ffmr2314612637.41.1732263186820;
        Fri, 22 Nov 2024 00:13:06 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc1e2490sm1064181a12.31.2024.11.22.00.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 00:13:06 -0800 (PST)
Date: Fri, 22 Nov 2024 13:43:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH for-next v3] selftests/cpufreq: gitignore output files
 and clean them in make clean
Message-ID: <20241122081304.j2zbjvmgd2nnfca3@vireshk-i7>
References: <20241122074757.1583002-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122074757.1583002-1-lizhijian@fujitsu.com>

On 22-11-24, 15:47, Li Zhijian wrote:
> After `make run_tests`, the git status complains:
> Untracked files:
>     (use "git add <file>..." to include in what will be committed)
>         cpufreq/cpufreq_selftest.dmesg_cpufreq.txt
>         cpufreq/cpufreq_selftest.dmesg_full.txt
>         cpufreq/cpufreq_selftest.txt
> 
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh


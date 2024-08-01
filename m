Return-Path: <linux-kernel+bounces-270559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2188994416D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAFE11F222F9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F092313BC2F;
	Thu,  1 Aug 2024 02:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ch6x012e"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E8E647
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 02:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722480658; cv=none; b=TOVvtpRyGrqz3Obe0oNYa2lhXAYzpb1ffwtN+IS9qnB+p3TjWt6ADoivwTQOU+qK+tKX9vVAaKI/yku++3HgWjMYOsr9UdZcd4yvyfc2E24qIre9L0O7PYirwM/SvUaoj52ix7ajFAXn5syQ3DQzT4joSEl3oy2UwNpTHNhhuuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722480658; c=relaxed/simple;
	bh=thhJIa1tvJ+ZAMG3SnWlSBYJdLugX8gLdZhTtvroAV0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Yz0FTV+yuifz3E6g1uTa7HXfwRV+PR6xMIDNXpSkwlWstttdAkmMmrn1Yz390q90wlTRMplWhfSTsCdovJ3w5SucCWphBApVj1a4JPVYPKPhV7JGK2UVx8rTG5Nd4keVVv0/yyahXuuid1CmkxRVkIqre3PaKIRJ+Zdq7pXY4TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ch6x012e; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-66c7aeac627so53890407b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 19:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722480656; x=1723085456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thhJIa1tvJ+ZAMG3SnWlSBYJdLugX8gLdZhTtvroAV0=;
        b=Ch6x012e8G/OURSM4qtQxo4/D7ApwqR8fGlSDyssrlbUkzUwI2idpVhQipduRvCCS0
         J2KyKecTK4Aw6kSf0bY82MYWxWrI4rzhDtX9AuwTnCQS5ihWaXwwH+OtbX7lQzBFFAS2
         FDT+wWaxXBA/KE0TYSC/USmLxq+VCS29NDvhDysZRqay6kPmqh5sDcWAa9Dx+yARtstS
         JT9TTBzaVjD36jMLRiQGl3zQzK3MD+aeNwp0sAW3PbIJfr5xrK6TvOnhyBo2iFNaDJV4
         RHwV7Fv3pI1mdOPTmjrjsoy/bjscNK2V8fG8IaSjBS+crA94OWIob0E0V0SfFaYgGbVz
         qk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722480656; x=1723085456;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thhJIa1tvJ+ZAMG3SnWlSBYJdLugX8gLdZhTtvroAV0=;
        b=hpsI5MisSJcqiAhzkbKPNzOJcRelIq7BkiYb5gBHd4lSFljLwVUsfpLyUPIiX2HqTL
         nucG8sJIQosWrF7mtCdfsT1aWkKX0szdylvFHUhIH/3an0YoBZz7WqqE+Y1m2C13TMyC
         qmKSnjgiO5SPwj4fY2ca3nrM1jQ5YUUFaREqZINUF6rvVy6Yz22Fnu+piM6GNTirgISH
         3lsyVftV8Ykqz7UVl/xF+vaQO8jJV7N/mxq124yrxlr2WvBzZhSlZ+VjgFbo9qIyECn0
         4puqynC2W0U3Lj0Y66dlm2kjwD20nsMC6jTH4hQ3NCPMebOxMiF+lNfcU7K6fcjy99Kd
         0M3g==
X-Forwarded-Encrypted: i=1; AJvYcCXlWgNEkdioXecSrcL64xC2nfNcendPI+Ap2UVeU+Jgr1/2gaRroLHasJXyFoEU+n1lIpyWwTMAuNVCzKp+O8ynTjP4JCfUVLSMO8YL
X-Gm-Message-State: AOJu0Yw+LIhPXgQijouYZHzAY28oj1w7y/DoYorcdW6UiqUyT/vYVTMR
	3tjdTaECoSi2zd/ztkpsJqnfcECKUWMaVtDpnHXhiCcXl7jYv4guoCqoqL/x
X-Google-Smtp-Source: AGHT+IGKfDRo6TT6kt2wYj/clUBXE38hQkXb47g0Ao3eezvW4tpUjhpDjsequShxyhD1CYHp8Zjw5A==
X-Received: by 2002:a0d:f4c3:0:b0:618:2381:2404 with SMTP id 00721157ae682-6875047a2camr4195967b3.44.1722480655683;
        Wed, 31 Jul 2024 19:50:55 -0700 (PDT)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-44fe8126979sm63935711cf.7.2024.07.31.19.50.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 19:50:55 -0700 (PDT)
Message-ID: <97e39177-f9f3-4fb4-b598-ba10fc6a8125@gmail.com>
Date: Wed, 31 Jul 2024 21:50:54 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: qyousef@layalina.io
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
 peterz@infradead.org, tj@kernel.org, torvalds@linux-foundation.org,
 vincent.guittot@linaro.org, void@manifault.com
References: <20240725011907.3f5ropfai3xoy3l3@airbuntu>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Content-Language: en-US
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <20240725011907.3f5ropfai3xoy3l3@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> We really shouldn't change how schedutil works. The governor is supposed to
> behave in a certain way, and we need to ensure consistency. I think you should
> look on how you make your scheduler compatible with it. Adding hooks to say
> apply this perf value that I want is a recipe for randomness.

If schedutil's behavior is perfect as-is, then why does cpu.uclamp.max
not work with values between 81-100%, which is the part of the CPU
frequency range where one pays the least in performance per Joule saved?
Why does cpu.uclamp.min have to be set all the way up and down the
cgroup hierarchy, from root to leaf, to actually affect frequency
selection? Why is sugov notorious for harming video encoding
performance[1], which is a CPU-saturating workload? Why do intel_pstate
and amd-pstate both bypass it on modern hardware?

It appears that without Android's very deeply integrated userspace
uclamp controls telling sugov what to do, it's native behavior is less
than awe-inspring. Futhermore, uclamp doesn't work especially well on
systems that violate the big.LITTLE assumption that only clamping << max
saves meaningful energy[2]. Non-Android users widely scorn sugov when
they become aware of it. Web forums are full of suggestions to switch to
perfgov, or to switch to "conservative" or disable turbo for those who
want efficiency.

That said, given how long the the PELT time constant is, a bpf scheduler
that wanted to override sugov could probably cooperate with a userspace
daemon to set min and max uclamps to the same value to control frequency
selection without too much overhead, as long as it doesn't mind the
81-100% hole.

[1] https://www.phoronix.com/review/schedutil-quirky-2023

[2] Does that still hold on high-end Android devices with one or two
hot-rodded prime cores?

Thanks,

--
Russell Haley


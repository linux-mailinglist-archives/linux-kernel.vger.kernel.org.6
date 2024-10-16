Return-Path: <linux-kernel+bounces-368840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4439A1589
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A0BAB221A5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770F11917C4;
	Wed, 16 Oct 2024 22:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="Qka3ZapU"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346971D3584
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 22:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729116240; cv=none; b=a3YI9AxbUyaj5mxlBN3aDk65zZwgRTSA8wGl14EzGTTJr+9/IqIDfj21EoK4a8hYEo0GevKqVn0rQx+XwcsRuPLZO0YCCYqBFBgkNrTJtIYGrneu4Ba3HJg2QH4Gk0MSN+U5/9eC6slpwbbOV7L9AKRdoXQkx59a+1XJpFFZsIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729116240; c=relaxed/simple;
	bh=pKk/6zrwsgyQPs6L8uSnW+XK2yvBcVM4b1sd3gOK/+Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=C/D3r8KXX6LOSu0XiH4ka+WcXYP+KgPRjurAPU4KajH2aPFdmTcg733eYz8CNdZGAssFG0smus+nIw/WpMeUQzO1gLAyUSSCgL5LmJ4Egrurr2Z9cLId9RjlC5SBai0svBVUhflXoPoToskUEZn1yQA0ksNY/2QWZ0mXDkCTP9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=Qka3ZapU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-430576ff251so2921575e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1729116237; x=1729721037; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zAy+YI8aJBgzKDlu+bhq0/HfkrFTLmcq01oXRQXTyec=;
        b=Qka3ZapUP6QP4k6h3rcegoIrOL/bawoS9j35GuDFtdQ7QCXFQr45/17yBxz3xnAoYu
         mkkFtPBjZUsMgyozF2gPiP1YRH2cIgh1bhonRujGYpAaQZNDp+mLgfFiPZrPWd56T2EP
         EnGYWL8CcUlqf8+SZsairTJCjE5phaFXMQDwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729116237; x=1729721037;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zAy+YI8aJBgzKDlu+bhq0/HfkrFTLmcq01oXRQXTyec=;
        b=LLCOVji9e+/4qIOiYmkoFLsqSANwisC498Dy8X8Egal2kr3BNn53iKa7Nl9xCmdCEL
         vN9DrUyms2Qgl9XoKpD/SJ+PaYfkDv0LdD6MglZyAC2u48Tg7kBscUmyCb750h2euXhg
         2NuznrURZnTHbyH1bO7iNWJb7Mr+wMmzi2aAN9KnkE9BlAjG9BPbDJmxrsrhlyQNbn9V
         OVKaQsfXWdUS9fEi1G0VPqpH0sUPP7wL6qwQWpqAeI/pWHBp15VWQacrg3DzyWsaqulV
         cR/usXNIMH+0dSCpPtpsBfum/JggGcc1ZFXfefPFh6vsadZgHPGccvNs9oeHTsO6xnUm
         1w/A==
X-Forwarded-Encrypted: i=1; AJvYcCWIY8h7kWWgr8Y6gQCE+VkdP5V3uEyQY0GMhoDnDvFAlcBlYnKgekhfeFXIqDRzCKjIHdNDi8hor0BIh6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdIxLDjusnEm9EPp77OYZnLuGI3uhZFY8Nx7YjIpeZDY7RJqN1
	MY9BmWVBBgjkEYwLPThbIAhr9CRpIH608xvqyEF1qlLLa2QwClnA+5uCMAyFcnI=
X-Google-Smtp-Source: AGHT+IGFt/uf+S0HV+Ry8LS1AtX6ZH7OZiyFlbevTM8J88NluXe8RmwYFQhQPmKCyxw6eLPaERmVsQ==
X-Received: by 2002:a05:600c:1f12:b0:431:5871:6c5d with SMTP id 5b1f17b1804b1-43158716f6bmr7664875e9.3.1729116237192;
        Wed, 16 Oct 2024 15:03:57 -0700 (PDT)
Received: from [172.20.10.2] ([91.151.136.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa7a13bsm5370910f8f.13.2024.10.16.15.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 15:03:56 -0700 (PDT)
Message-ID: <3b2195074d7c8fa20f93f1dc6fc25afe5dbb2909.camel@intelfx.name>
Subject: Re: [PATCH v3 00/11] Adjustments for preferred core detection
From: Ivan Shapovalov <intelfx@intelfx.name>
To: Mario Limonciello <superm1@kernel.org>
Cc: bp@alien8.de, gautham.shenoy@amd.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	mario.limonciello@amd.com, perry.yuan@amd.com, rafael@kernel.org,
 x86@kernel.org
Date: Thu, 17 Oct 2024 02:03:52 +0400
In-Reply-To: <20240905163007.1350840-1-superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On my desktop Zen 3 (Vermeer) system applying this series yields a new
warning message on each boot:

> Oct 16 06:20:41 kernel: Could not retrieve highest performance (-19)

As I see it, this is one of the pr_debug()s newly promoted to warnings.
Is there anything I can provide to help fix this?

Just for completeness:

```
$ cat-files /sys/devices/system/cpu/cpufreq/policy0/*
/sys/devices/system/cpu/cpufreq/policy0/affected_cpus                      =
       0
/sys/devices/system/cpu/cpufreq/policy0/amd_pstate_highest_perf            =
       231
/sys/devices/system/cpu/cpufreq/policy0/amd_pstate_hw_prefcore             =
       enabled
/sys/devices/system/cpu/cpufreq/policy0/amd_pstate_lowest_nonlinear_freq   =
       1746000
/sys/devices/system/cpu/cpufreq/policy0/amd_pstate_max_freq                =
       5274000
/sys/devices/system/cpu/cpufreq/policy0/amd_pstate_prefcore_ranking        =
       231
/sys/devices/system/cpu/cpufreq/policy0/boost                              =
       1
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq                   =
       5274000
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq                   =
       550000
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency         =
       0
/sys/devices/system/cpu/cpufreq/policy0/energy_performance_available_prefer=
ences  default performance balance_performance balance_power power
/sys/devices/system/cpu/cpufreq/policy0/energy_performance_preference      =
       balance_performance
/sys/devices/system/cpu/cpufreq/policy0/related_cpus                       =
       0
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors        =
       performance powersave
/sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq                   =
       1746000
/sys/devices/system/cpu/cpufreq/policy0/scaling_driver                     =
       amd-pstate-epp
/sys/devices/system/cpu/cpufreq/policy0/scaling_governor                   =
       powersave
/sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq                   =
       5274000
/sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq                   =
       1746000
/sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed                   =
       <unsupported>

$ grep -w cppc /proc/cpuinfo
<empty>
```

Thanks,
--=20
Ivan Shapovalov / intelfx /


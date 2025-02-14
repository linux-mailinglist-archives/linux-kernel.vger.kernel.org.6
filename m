Return-Path: <linux-kernel+bounces-514334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD5EA355B4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3420B16B374
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1151519AD;
	Fri, 14 Feb 2025 04:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="Q0W4gR67"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F412F1519AB
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739507000; cv=none; b=P/haSD+ekcCtuMfTvea6+2oOS8/Js1E6ysDv9tIIcL0qwMxDmOSv33sZFBz+7xwjC+ps+jA6TFaivwFsdGIEvw+k2RvGnSo1TOoJpdXcaUmlcjo/2SbCRWFJqikgO0XlvJx8XHDFIQsaieM9slwuxiVLP3j7dpGCDjEb5pPjbFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739507000; c=relaxed/simple;
	bh=jb+PMT2oTp9UYqeR8yZM4e7/uMXYINckOiviDOlRz1A=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=f+6pF2mFkP8uCBGTcRPSnx3qbC2aev5hbFirIvvBwHpzkPfl0x36Ca+dC8Vlm2Wg9qfLGFhfdl8SQAVT9jKARZggEeJG6+/JP5voFFggFYTWnvnQzt+pB2zALsEqQf91++pwNrS5lRcIQSYwnlGScLH19f7mPNeq3QrWmxEoauk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=Q0W4gR67; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fc1843495eso1836079a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1739506998; x=1740111798; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jb+PMT2oTp9UYqeR8yZM4e7/uMXYINckOiviDOlRz1A=;
        b=Q0W4gR67nKf2wm+qCAFdDLMagxcsDczoysbane4oE7c05iHoVNluFRlmZLQX4YfQPM
         CjtsL2MN6Xm7FVGuaIYx4Lj9y/YnZHQ/1oJaEuBOb96r3rXMOnoQ8wKn1KCRCou7EQdS
         82pOU3znK7YQmR0yEvvLr3aSBdn+P5ITxqi7YyWHfkQ6ykqDHbuINWN4ZkuLR8sMdsCn
         uZvz5xYk2bcwddzeWQnVo1k8bYozyRXIdN4SQ9OxdH3CPvZgyjum24YWh4yVIcLe400Q
         UWJAuGS2UkT1JRT9o4Saa3xFXjAvqSJtRcTzjH1xUi/+mGd7R7BCg0Mwn7g7DHy783Hg
         Emfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739506998; x=1740111798;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jb+PMT2oTp9UYqeR8yZM4e7/uMXYINckOiviDOlRz1A=;
        b=WqgOkNYz4RyFuIqzByEzgMGLAI4GK1Eg3lrDAvI/LOhTLvrPmdUmcrlh+K4m9sPrLS
         Q1HhZuLeV5SO0oadVdQmIIfuLa3oOb5sFDM0D8VWqsTTUD4nQKhjezp3InAK57XeK21l
         GzcFeHuDfjBkQQunC37qFpXcLHMHPhWzEwNBDVjNsfZ008x5G+vWoQlulBrEMBCCNDzO
         XO9mcoRDuTpJtIzw1sC75tr9/V62dIMbNxz+jYzQDoci1g5skihgZq9vQ0O+UfrDqgjC
         Vym+IeMl36oyIGnbUsk7CwS7POGyjnLQ5qrcrRuf2qjF77oiTg6QqvmCBa+oCmiJVuW2
         WZqw==
X-Gm-Message-State: AOJu0YyBcO06JuaYoNbLEm6OdfIcuUqmSSjCU1Dcf/LtMriUZ7n6hHR3
	w7aOPC+NI4vbN+UaOvFrdiv60/Vxr2jO9n+ap1D1xhTn0S9EgvYoiQNOYQhgKSs=
X-Gm-Gg: ASbGncv5QI3n55buuunXUme3dGfOfveGmZiWZq7W1GlQ8AoWeEhJ4Qctp/Lklo6+m/G
	oc2WEGWXx4VoOHK8kz81chaaN5JkBeS2ZdIGXKMcWguZKv+NmV3RP/i8u50qBeQjsQuwa7zXAt5
	JqzabjKmG+YSOxnfXJYI3RuQJyVXWIeCxS6CTBW0FDzqf1IZYwGchviH86zbSrfaqKwbOhslF9x
	fQzyUbSFX+Kcfblc80ByUcIltrq6tui3tNPYAg//2DT4qwq0o6VimPyLKqd/P5ia8sVmu99UmRl
	hy/321p8WToQ+qUkfhdkAq1+Ain3to8vZchkGrcT3P1NKDsrlsmwGNCz
X-Google-Smtp-Source: AGHT+IG2QHeQBkVHQWJbFh0rqoGoY4A0Mor/nCLFolUetRVisiO4xlKLSp/ye3TEAmwb/DY4PnwUWA==
X-Received: by 2002:a05:6a00:3d41:b0:730:949d:2d32 with SMTP id d2e1a72fcca58-7322c591b1dmr15819016b3a.6.1739506998246;
        Thu, 13 Feb 2025 20:23:18 -0800 (PST)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732547af8acsm241142b3a.71.2025.02.13.20.23.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2025 20:23:17 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Christian Loehle'" <christian.loehle@arm.com>,
	"'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
	"'Linux PM'" <linux-pm@vger.kernel.org>
Cc: "'LKML'" <linux-kernel@vger.kernel.org>,
	"'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
	"'Artem Bityutskiy'" <artem.bityutskiy@linux.intel.com>,
	"'Aboorva Devarajan'" <aboorvad@linux.ibm.com>,
	"Doug Smythies" <dsmythies@telus.net>
References: <12630185.O9o76ZdvQC@rjwysocki.net> <8d147f4f-f511-4f44-b18e-2011b0fab17c@arm.com>
In-Reply-To: <8d147f4f-f511-4f44-b18e-2011b0fab17c@arm.com>
Subject: RE: [RFT][PATCH v1] cpuidle: teo: Avoid selecting deepest idle state over-eagerly
Date: Thu, 13 Feb 2025 20:23:21 -0800
Message-ID: <003a01db7e98$2e9ad770$8bd08650$@telus.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQLC2T+pvcOY0U2G0e8FLXneTSytVAHTSa8dsWjejUA=

Hi Christian,

Thank you for trying to repeat my idle test results.

On 2025.02.13 06:07 Christian Loehle wrote:

> I'm curious, are Doug's numbers reproducible?
> Or could you share the idle state usage numbers? Is that explainable?
> Seems like a lot and it does worry me that I can't reproduce anything
> as drastic.

While I am having some severe repeatability issues with my testing,
not for this test.

Please recall my test conditions because the CPU frequency
scaling governor does matter. I was using "performance".
The power comes from the high amount of time in idle state 1.
I verified the idle state 1 power use by disabling all other idle states.
I also have HWP disabled, but do not know if it matters.
If I use the "powersave" governor (driver is intel_pstate, not
intel_cpufreq) then idle power is < 2 watts.

Anyway, my data:

http://smythies.com/~doug/linux/idle/teo-6.14/idle/perf/

> (Idle numbers aren't really reflective in energy used -> dominated by
> active power.)

Well, it depends on idle time verses active time on the computer.
I also measured the difference in the mains power at 20%, from
43.2 watts to 51.4 watts.

I am about to send a long email with all of my test results.
Since I can not seem to function without making graphs,
it has a lot of links to graphs.




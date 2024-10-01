Return-Path: <linux-kernel+bounces-345657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F3E98B8D6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85C5F1C22140
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D6E15099B;
	Tue,  1 Oct 2024 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OQrDBYHL"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03BF18732E
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727776915; cv=none; b=NTypTzH4EAFf6w2I2hsaRCscZQTaYyksgMq76pMAW0KjakyPkVq9QecLeTP/VndbM7d4TwFmUnPkEUDFjbezKyYbn1gntwXhJ1MT637EiowX0NvpGI62AocvmnhbYvnNkTSk1tuJBVaQh7ws78I94+I+hHz4WouCKK4AuOJ5oAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727776915; c=relaxed/simple;
	bh=dQ9x3bpYvDTlxkqy3NuCtqL8cqKpgb6HH5ZIev7hneA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmINB+8DG+xdDEll4pzX0ado8IJxdjUmT9dDX5AeugcG/SdyHj+D9aoJhQD0aCWtxnV0kaPZJ49+SEtYBltJxZrXPTLVS6jOsWJz/rwB5AmOAyW2COMN7V35yezgM0A0CsKEBOc2stbCZzHekjHT4Yyb57M259Tb4ECG73pRERA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OQrDBYHL; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so4403460b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 03:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727776913; x=1728381713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xrfBPoEp5KRET0h/E9YhE6pXHI5MQvZRYmIPkbAD0Gg=;
        b=OQrDBYHL6pPl0K2IVOfSB8neojntgf2ycsI9XSBKuKFdkgF+cTfh+xnEA1Eoyj3GCQ
         pT94J02r6Bppvv2PwU1wtvmR/V+Fj2TMikWDTTeFKbLzWDovV4utc15N64JzUSgqFbZm
         nyZhqXg+25ARu5KXvH8ATG+noIJIi4qKj1Tbbo8V1ahgDzwb3vyRDLsLCL0tjx3VxT/o
         9b3UDG8xb9jtczvGfYK7FAQQKCYJ+TgJhh/JKIqgXXcjgGoa+c4y14ttTxq7QJ4pY2jT
         0Iv6axViwT1DRt8ItqZ2nf3HRd3yAxaqD87TtwzCwv7CPiuOL2X1PGC47BMv4NKsJfHR
         ZGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727776913; x=1728381713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrfBPoEp5KRET0h/E9YhE6pXHI5MQvZRYmIPkbAD0Gg=;
        b=aKujIuqS7h9xQDoZJ221Ex9m7jJxhFnUDe+KO2yYOK6x97PpwnB3Mv8Zi1+U6AyMsy
         VLWOf7quh91s3Ipwpzq/gpeK3WJj8GnwbLKDM97Ql0/Ogmbg0lAyY8sFnUwHNOHykOuE
         70tdSdKmJou6VXCpzmHJzoua5UE8cxrAXBFYSPNW6DHSk1fRr403Amvtf5xca2lRctbH
         qd4Ty3x2yAExXijIBn43EUavRNsqI0jH506nSL/Grq2579M4AKW/6olBfSoKbHn6ySh3
         weh9PmPdQa79JCVZTpflL6h2wHdD698vVC/4b5FYVrjme6qKTzYelgoI8n6dfERASYoc
         XEyA==
X-Forwarded-Encrypted: i=1; AJvYcCVlhICXUECFOEt7QOABs4a/7njHcBVTha8ogjJRpHg1QJFDM4RCVAa9ZhfqH2aKhd6KeAtHiosBNP0ad40=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIMzzLsZ11QMfp4kdMT8FL0TH56utlzU6Of7BIlQ4fOJaH7TQx
	EXb1Qys3iKJgny+ds9IuqyEj8CGp+Z+sBKLFbZEYZSoUcA31nSNfV+/zwvDCzz4=
X-Google-Smtp-Source: AGHT+IFqJrqFAO+NgwKIzqUCeIODMavetPY09oVS1K2zaWF26Kv4W75g3uOXLFdaPekmgJCFR5la+Q==
X-Received: by 2002:a05:6a20:9189:b0:1cf:2a19:b1b with SMTP id adf61e73a8af0-1d52d0e8014mr3598687637.7.1727776912960;
        Tue, 01 Oct 2024 03:01:52 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2bce30sm6919791a12.38.2024.10.01.03.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 03:01:52 -0700 (PDT)
Date: Tue, 1 Oct 2024 15:31:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Qais Yousef <qyousef@layalina.io>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-pm <linux-pm@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCHv2] cpufreq/schedutil: Only bind threads if needed
Message-ID: <20241001100150.ecefg4spoo2snv66@vireshk-i7>
References: <a4a70646-98a4-4b85-955e-62d66ba68927@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4a70646-98a4-4b85-955e-62d66ba68927@arm.com>

On 27-09-24, 09:59, Christian Loehle wrote:
> Remove the unconditional binding of sugov kthreads to the affected CPUs
> if the cpufreq driver indicates that updates can happen from any CPU.
> This allows userspace to set affinities to either save power (waking up
> bigger CPUs on HMP can be expensive) or increasing performance (by
> letting the utilized CPUs run without preemption of the sugov kthread).
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
> - v2: Add comment for the dl_task_check_affinity return (Juri)
> v1: https://lore.kernel.org/lkml/480f2140-ea59-4e1d-a68d-18cbcec10941@arm.com/
> 
>  kernel/sched/cpufreq_schedutil.c | 6 +++++-
>  kernel/sched/syscalls.c          | 7 +++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh


Return-Path: <linux-kernel+bounces-255363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65305933FB5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9DB6B24495
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E446181B86;
	Wed, 17 Jul 2024 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="Rsn5FNbl"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A631E51E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721230281; cv=none; b=QAshtt/p4h/GbpHEVkcXCaX5NSyILyutTl6dE2chQ2olpMWy985BGlu8kLcOR3INr7UCq6q4lcQWcTG8g8e3usiRPOivdKONLbpKOYiWsjTgdr+Ym706Zo1P64cYyhxExXLHkasWZy4jJfz42MsCA3j9UamKxmKV1y5FhTCUiHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721230281; c=relaxed/simple;
	bh=K9d9gf+BWps+rreBtXWNmb4WQJY52bLiPpJQ1dqh/1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrAmv8uPkEW48boU05SDZfffMLF7NZQuYaHhovtlEui1RevSP0qUNaCExymouZxM0XoKVpw1RI84zCy0MrMtfMmagUUt87OWTf52Bsu4a9we0wkFqFc/g3Gy6kutVj7CDRo9nznJ7NSWMuxDjulXth2leH0df9xxa5HAlp1bi4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=Rsn5FNbl; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52e98087e32so8396101e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1721230278; x=1721835078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9d9gf+BWps+rreBtXWNmb4WQJY52bLiPpJQ1dqh/1A=;
        b=Rsn5FNbl8jkAwyK1P4moQTfyGK3wSh5hUhmMgLDKF6AY/bRAhrIzg/iUminG+vZnNY
         gYOJrztRssxvODWZQ1qF5XTf3+qZxtNxtpEfy0DTi9UcXhN66GBhhlrQi3qaNwpvBdjs
         u1iy1usKo23PcVyp5oKOGQLY70BaeFW9y4kWkR+4oqSA1Iq7WB6boAAlBq6M2cWso5Vc
         tfD+2xKDXwAlb89OW+xx5rxKcotWu3QJXPMIJHQPo4kVFJ3eVTl3EqBnUVJSW06+zFaS
         I59u8PzvuJOAbnQseRMdUgR1yPuNEa5HGor6jLTdT7r4G2O/XrGyiGxQQiOzXjhXCBD4
         1gQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721230278; x=1721835078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9d9gf+BWps+rreBtXWNmb4WQJY52bLiPpJQ1dqh/1A=;
        b=bX6ndk/oKbKHl80DKilEt5lauH7dtsndDRBMQIxf2MYSE7TOJu9Yr0dVuJZ0vmr5JT
         TkQ/dySk8XZ3zXBFo5r43UFM40ri0UfSWKc8lDm8JvamkVB/gSV9H2OVcSJ9l65MqP2C
         BZar1NvY0/3N80DurB4C0oXVZImrVGtYMW7DksFvLPNj6p3jwvXwhO/PzM7ClBM2cefp
         CudVftBnbypvlsn9exGH6G2rrZUM59Ybpsr9LNJ3NthGHsWhyVw/5/8iGHxw/EZxcRnU
         TfF+uP1x9lGK1KpGpG9yXCH0+HRLr7NpYbvWaLPT84pznaeiWBuV/qPcSwN19m/Bvpvl
         hGfg==
X-Forwarded-Encrypted: i=1; AJvYcCXwQkSo5yq8dmsuvMPO3NlUEwFeLN02tBRC29VQjGnmC1px2bqHkvfBDkvfm0as4CRaXXBqIQJBDYvu/JZg6uuHrC+s97SAPXbiBip6
X-Gm-Message-State: AOJu0Yx7iUcunXfHxMoweWl977gXCPoMYrZwVOw/Bww9RyfgzBA48vlS
	qL+4Hg2YdGy2PwacAnrbDCPxcmWxl6h7lM1hKKCKWPXIvYEaOneFaRXjHSAy3Ug+v0Vr94Cg21I
	ykBmCXG5E9BqYfmTlS7s6gia2L1/5Q/fhCMlNsQ==
X-Google-Smtp-Source: AGHT+IEtqRNWkpvaN0ZZj3IcHDCv/Wl5vLCgOqJyPMVkPLXlgeNoMP8YVguflrPN74CnwYiXEwru161+fYmKLiOF9w4=
X-Received: by 2002:a05:6512:e93:b0:52c:dea8:7ca0 with SMTP id
 2adb3069b0e04-52ee543f3f9mr1689796e87.55.1721230277516; Wed, 17 Jul 2024
 08:31:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1690273854.git.yu.c.chen@intel.com> <20240716141645.637620-1-mfleming@cloudflare.com>
 <ZpdAEYN1vwlnIGiS@chenyu5-mobl2>
In-Reply-To: <ZpdAEYN1vwlnIGiS@chenyu5-mobl2>
From: Matt Fleming <matt@readmodwrite.com>
Date: Wed, 17 Jul 2024 16:31:06 +0100
Message-ID: <CAENh_SQzWeViGDGsqZFZYaNooB3NBKQR7XOkYB26SGEq1cZ5FA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Optimization to reduce the cost of newidle balance
To: Chen Yu <yu.c.chen@intel.com>
Cc: aaron.lu@intel.com, dietmar.eggemann@arm.com, gautham.shenoy@amd.com, 
	juri.lelli@redhat.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	mgorman@techsingularity.net, mingo@redhat.com, peterz@infradead.org, 
	tim.c.chen@intel.com, vincent.guittot@linaro.org, yu.chen.surf@gmail.com, 
	yujie.liu@intel.com, kernel-team@cloudflare.com, yunzhao@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 4:53=E2=80=AFAM Chen Yu <yu.c.chen@intel.com> wrote=
:
>
> Thanks for your interest in this patch series. The RFC patch series was s=
ent
> out to seek for directions and to see if this issue is worthy to fix. Sin=
ce
> you have encountered this issue as well and it seems to be generic issue,
> I'll rebase thie patch series and retest it on top of latest kernel and t=
hen
> send out a new version.

Great, thanks!

> > I'm seeing this same symptom of burning cycles in update_sd_lb_stats() =
on an
> > AMD EPYC 7713 machine (128 CPUs, 8 NUMA nodes). The machine is about 50=
% idle
> > and upadte_sd_lb_stats() sits as the first entry in perf top with about=
 3.62%
> > of CPU cycles.
>
> May I know what benchmark(test scenario) you are testing? I'd like to rep=
licate
> this test on my machine as well.

Actually this isn't a benchmark -- this was observed on Cloudflare's
production machines. I'm happy to try out your series and report back.

Thanks,
Matt


Return-Path: <linux-kernel+bounces-341473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED8D9880A7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9561F2258B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3E0189F39;
	Fri, 27 Sep 2024 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeNJE4at"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E16165EF1
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426842; cv=none; b=ENdMXGjQO1zdoca1NHIXTAgfm9yeTy7fVy57Gy1E0p81Kb6koGsx+yh9rRdf/tBhFYXfMgfi9DfhWTRXWBoJtNuNfzzRBJKLyXTD3j0TWfxl6EVsRg1Iiktun3h8OKSBofKsLgOA3B80zmso/tkAqatugUzGhKrLGnCzj26mUqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426842; c=relaxed/simple;
	bh=e9UCiXM+mzDpcuo9tldMzc6UvOdXhJq/MA+nkkOH5lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a7GPU1UDpqGNM2jPVViKnU2ClMoE/usNpyog7I2ENovb4ZC15wu+M3b8/+JaZSDPxIk+khu4uSOw9FRSMSxy4V3/7n6lJKTxGNh/gopQ4Hk9eS3uieUWDRzSfKkbl3ktW1VeGKiV75IjQQDlrjkQBFj9pUUADqqeh7fFpK3LK3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeNJE4at; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cb2f272f8bso14799676d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 01:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727426840; x=1728031640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4D9ePqtkdnv0YKqqTp5G+TqxP1szwFKD9xiEvZ3Jnw=;
        b=ZeNJE4at8IcU37TjLorE37ks+tbwpI2Qm+acuzUeVgnVvnzHCtbADkrMSHVC4qW+yU
         Q29HjvRhB9KokZhys/AfTyzNYZiCrABniLaUrxcARajFLtNDuG9CjatTQYNoQXIHxZjc
         dvyxmcxsAKB8j7ApJMWsWNqeqLbDRgSC0tCEqg7nA5l5zAzEe8XM6unmRK8fi1hcbDYG
         fPXCKwzKk+kHAhKUU0dhVg7tjgc64nGzD8Gbbel+mGKOwFlBSIbFIo3gN8vVwZMQP3rg
         WguDF17dZmm2Urp3zIILb4tHysC8M5yHoWoC95/vaPaCK03gdiEEpZfaVWQtWBQ70DcN
         5RBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727426840; x=1728031640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4D9ePqtkdnv0YKqqTp5G+TqxP1szwFKD9xiEvZ3Jnw=;
        b=GbTKRG5yB0qFaawYZ0c0R7qCHQxTxOcqhiI1aoJoGvW6cld43Vo+W2UDSVqQADPMac
         afxp4d3/QXlXCRPxAhmxrvMhgZx33Iqx3jxNhMNLARh7L3WkATkwLZc4WWbtSj/bL2Iw
         qISfaNdgmFd/Bd0oEy4WD1NxhQWtoi1s8jgSFjWtnLbF+fonWGmH4Z7sltbSCsoiEW1V
         100Z0mDPUdbTf5rCF4oQ9cddx75NmM++6KvaJuDuMVTzhTcYxgM9OhPw8wXCSFyESRVQ
         99EVJLa6Tj8+kirhLf4HgtGk5+kR4B4ZrVfH+ZQqlo1GHWLk4ZIjwpj7X6pTl8fQHBDj
         vgdg==
X-Forwarded-Encrypted: i=1; AJvYcCUaURrmYsu/0yt3ZNBCb3Sf4ddPOQstZUudwUEd7ktx+VQn3/ArUw1ykg3NV+kEKXQtzIzVROiHk/cOooI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6aUePKbL5Z4nXO+LoyWgIretRA2YiJjTrUAtPs1K01PxsOv8d
	iy09j0oVBM6X1pHt0AIfYGBDzJnE/u8xWSkESocFlTLlSvd/wVXh/rlj2SWZZrF3LfKHYU75/qu
	m5eeolFTRO9OyRkOyRwrd8ggydrg=
X-Google-Smtp-Source: AGHT+IEDhzDvStqBzCh9UD4kHE5QtQr2IKhYirEM9k8FeVztqKEDVNTmVu+atHXWvFhfEuTC13zwyQTw+bcIXeRfe/4=
X-Received: by 2002:a05:6214:570c:b0:6c7:c650:969b with SMTP id
 6a1803df08f44-6cb3b63daecmr38217606d6.27.1727426839558; Fri, 27 Sep 2024
 01:47:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923090028.16368-2-laoar.shao@gmail.com> <202409261230.c7f0e4eb-lkp@intel.com>
In-Reply-To: <202409261230.c7f0e4eb-lkp@intel.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 27 Sep 2024 16:46:43 +0800
Message-ID: <CALOAHbCcMxzMUNaPuoDkErcke6YuuxyhN-JpYQjKK1566aNMcg@mail.gmail.com>
Subject: Re: [PATCH 1/3] sched: Fix cgroup irq accounting for CONFIG_IRQ_TIME_ACCOUNTING
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	aubrey.li@linux.intel.com, yu.c.chen@intel.com, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 2:14=E2=80=AFPM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "WARNING:at_kernel/sched/sched.h:#cpuacct_charg=
e" on:
>
> commit: e5633f7cf7d093cf5bb191663054441fbc745a5a ("[PATCH 1/3] sched: Fix=
 cgroup irq accounting for CONFIG_IRQ_TIME_ACCOUNTING")
> url: https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/sched-Fix=
-cgroup-irq-accounting-for-CONFIG_IRQ_TIME_ACCOUNTING/20240923-170321
> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git bc9057da1a=
220ff2cb6c8885fd5352558aceba2c
> patch link: https://lore.kernel.org/all/20240923090028.16368-2-laoar.shao=
@gmail.com/
> patch subject: [PATCH 1/3] sched: Fix cgroup irq accounting for CONFIG_IR=
Q_TIME_ACCOUNTING
>
> in testcase: boot
>
> compiler: clang-18
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 1=
6G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> +-------------------------------------------------+------------+---------=
---+
> |                                                 | bc9057da1a | e5633f7c=
f7 |
> +-------------------------------------------------+------------+---------=
---+
> | boot_successes                                  | 12         | 0       =
   |
> | boot_failures                                   | 0          | 12      =
   |
> | RIP:cpuacct_charge                              | 0          | 12      =
   |
> | WARNING:at_kernel/sched/sched.h:#cpuacct_charge | 0          | 12      =
   |
> | RIP:console_flush_all                           | 0          | 12      =
   |
> | RIP:ftrace_likely_update                        | 0          | 12      =
   |
> | RIP:desc_read                                   | 0          | 12      =
   |
> | RIP:handle_softirqs                             | 0          | 12      =
   |
> | RIP:kasan_check_range                           | 0          | 12      =
   |
> | RIP:_prb_read_valid                             | 0          | 12      =
   |
> +-------------------------------------------------+------------+---------=
---+
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202409261230.c7f0e4eb-lkp@intel.=
com

Thanks for the report.
The rq_lock should be held. I missed it.

--=20
Regards
Yafang


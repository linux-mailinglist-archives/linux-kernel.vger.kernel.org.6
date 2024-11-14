Return-Path: <linux-kernel+bounces-409202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0209C88B6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE799282393
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073311F8EF8;
	Thu, 14 Nov 2024 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSAzZFSy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6407F18BBBD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731583178; cv=none; b=KC/3PdsCjBpk9r614JtUFJAcd6Hx7jME8cId9ogYR+/wt4E8kvwdnHm4YRTsHtB6kmbEP9hEsaMk+OmQhQbSwiibkftNG+M6X9NaDj8kEHvwI4maTOyKoLkx2XuONpcN6vJpAQH8K4HRxAEoTK+c4NKNn+XSeptnBlLcoFNNkbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731583178; c=relaxed/simple;
	bh=5LXLqdSsXTfm0lyWapZQvhYmEzIbgszuUVAiWJ1EX0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O71UhQgU56ONYWM3DqyHXdKfTBErmF0dr8hdlHJJbWhHsomy0f10nu7CK2WWkZPRUcRIkqXyVX3zfEgO3i4pQG3lRIRhWuiZ3K9DgXmg5Z02G1kdsb/Wk5Fr/gQ2GNl0iazbc3B7edCGXQNkx0KwuVvf3aCqdtfMcr2XAE8VC64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSAzZFSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04297C4CED6
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731583178;
	bh=5LXLqdSsXTfm0lyWapZQvhYmEzIbgszuUVAiWJ1EX0c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bSAzZFSy8SLGBTGsvA5nPbA35l0AEE0i826hwPw51a4tMDmWGU8zs6M5QZ+OuZc6d
	 H895jnylDkPeJiMMyESAgB0MpGysauYqQcc3BGcoS7HrWtVfvoT5zX0R7Ocjmbigm3
	 IDXohjN267YCx+NTqiIcJPzDE0J3/zIavMQOlMZHC/kZbIgIQGanzULlBqLg1uoQdj
	 1WcKPee6+05YxHdd5qjKCfrafG1EislSoMV03H8mRGBSZtS3+sfwsUpCK4s3WRQPb/
	 YhFpdHPRX162/RHBAnSHllMtXCFTo607mkSj8JzzVozdxlXMfp/lK2BqCagS50BNK/
	 9JxLOy2PSWz9w==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cb6ca2a776so817483a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 03:19:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWRvC46yfpjNHTzd0Pg1YiHmtylEhBQSus+TBbfvEkPP3XJjHIbxlZq8i8ZYX9Z4FiQugqkuah2oNgLuTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2b6JbSKcuPnrxIekM+Ss6kmP0xlzbbTo9Ae1TO8r85DssBETA
	d9n/vy5P39Y3qG00chbqiBUvil9rKGpClH13WIV/bfitjNotJj8btWlLjTcMN5z/9AH5Fol67Ry
	y2eiqyG3oRxSNfvQMFTtUy3/CKFg=
X-Google-Smtp-Source: AGHT+IEzbaxCl9yHaUy9e06m8amyonezn0fW6mbWCgCe35uRNmhkAtlT2MkM7mrhM4TmRqFOCAy8N23HKIDEJHmCVsg=
X-Received: by 2002:a17:907:60d4:b0:a9a:1b32:5aa8 with SMTP id
 a640c23a62f3a-aa1b1024db6mr1068064666b.4.1731583176590; Thu, 14 Nov 2024
 03:19:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108091545.4182229-1-chenhuacai@loongson.cn>
 <20241108091545.4182229-4-chenhuacai@loongson.cn> <20241114103111.5W5ZY0D4@linutronix.de>
 <CAAhV-H72YSNBGutYPOVi=S7nwLb6YOiQOFqnimAp=9D0wAJc3g@mail.gmail.com> <20241114111409.LWKp5YEg@linutronix.de>
In-Reply-To: <20241114111409.LWKp5YEg@linutronix.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 14 Nov 2024 19:19:26 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4ecBZsV+9SxLZ-JFiUK=b3tMqkLZe0djac0_390==MMw@mail.gmail.com>
Message-ID: <CAAhV-H4ecBZsV+9SxLZ-JFiUK=b3tMqkLZe0djac0_390==MMw@mail.gmail.com>
Subject: Re: [PATCH 3/3] LoongArch: Allow to enable PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-rt-devel@lists.linux.dev, Guo Ren <guoren@kernel.org>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 7:14=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-11-14 19:07:37 [+0800], Huacai Chen wrote:
> > Hi, Sebastian,
> Hi,
>
> > > Why is ntpd/chronyd service affecting this? Is it running at prio 99?
> > > Otherwise it should not be noticed.
> > No, ntpd/chronyd doesn't affect latency. But they may trigger RTC
> > synchronization every 11 minutes, and RTC synchronization affects
> > latency. We can keep ntpd/chronyd running but disable RTC
> > synchronization by configuration, this is the least aggressive method.
>
> What is "RTC synchronization" in this context?
Means the sync_hw_clock() function in kernel/time/ntp.c, it can be
enabled/disabled by chronyd configuration:

/etc/chrony.conf
# Enable kernel synchronization of the real-time clock (RTC).
# rtcsync

Huacai

>
> > > Is lockdep complaining in any workloads?
> > > Is CONFIG_DEBUG_ATOMIC_SLEEP leading to any complains?
> > This needs more tests because I haven't enabled them.
>
> That would be good. It would show if there is anything that has not yet
> been noticed.
>
> > Huacai
>
> Sebastian


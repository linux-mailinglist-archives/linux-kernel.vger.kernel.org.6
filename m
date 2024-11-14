Return-Path: <linux-kernel+bounces-409219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 074EA9C8916
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7D52839C3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ED41F940A;
	Thu, 14 Nov 2024 11:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F72f1g0A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E400F1F8F02
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731584211; cv=none; b=f8Rs1SHzZjIlgpeSU2UorvdVJWgKWwF55ATvxZUwAGZXE+ryg3VgJ64BUj2F1ujW812s+OyadAm3D0r6la409M0pRkQjsvO8RpEAay+6SHdSJOL/j/5WSKm+R5JONzF0kWmpQtwkkpGvhN8eDH8vYglH5d6aJhMQEau0Lqf21UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731584211; c=relaxed/simple;
	bh=2XLV7xqIZ+/aSQ7I3R7xYx69y86EEpnqqBcMYOUPhrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PW9DPJS46ecip0tZP7cJEDMroBYdwRlsnrTmI6NfGDjCCI/C7rVFNvjtmTQvm1CN9ccLHotP+kmD9pQr+5c2lRWPJQZ1ifhUeaU34UVbZufmDSJMZwZZKu8S6/7cuN7GxMfOrNW5TMTIhYK1NK5Sef6UV/fdQzqt2noUYPP7/UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F72f1g0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA22C4CED4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731584210;
	bh=2XLV7xqIZ+/aSQ7I3R7xYx69y86EEpnqqBcMYOUPhrI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F72f1g0A9KjZwriQXlG4GnG8rPKlRS/cSVHyOpooOSaXTevPxyElJWBJXrcnyOGum
	 cwvykHsvtMGlPJ7gZd8PJbyGiyw7n98em9wW0JCwPHBlBw0SLkBafZ/HBB8zZh6F1c
	 tWEu2NfzpVS9sZgKSg0bGZIvV4fN6Q9pfcBmBwRcDb37sqwdpflR1JC68WvmyIWTfT
	 8XqAL6eh1Rc3fe5q9PXGP6SEctDF5wphQajiW9uOwN2hpL0nBZy2G37OTv/lVaeqoh
	 aAwxRmVnnK5579G6fwvNAUYUVAC8zstRGdV6qUwHpGrMIuAj4dzYPOalYY2jfXasXZ
	 ZQ1C5A6LKYrYA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9e44654ae3so74047966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 03:36:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWVSi8N7ibpH6vyUJHevBXPJKxmActxZIq+/6DReKxqy6NsqnM4mDmue+a69yijql0r7OtcHY5QM50MvVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpkkPDxBQpgWLK9Axt5er8Hmc0atg/VDg8Ae3ls15fUGqeckpP
	C9u3EaNDNYLTvLPXeC17e6Iuh39BsUE3lcz3Zs8D+NWClLg0crvB4eecuYUCRnhD5910ZxQT0CP
	diKNf+7jLWV0INPdKRuHzPDu0oYI=
X-Google-Smtp-Source: AGHT+IEVjBJAdOEkjL8C0OM7eIPERUREE6SUOwX6AI7Zmg05mjU9nqzY30S3fyHXOIMX5OD6A9wIXSiaqR7EOrCjpNE=
X-Received: by 2002:a17:907:1c0f:b0:a9e:51b6:2bab with SMTP id
 a640c23a62f3a-aa1f7e26851mr540468266b.0.1731584208975; Thu, 14 Nov 2024
 03:36:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108091545.4182229-1-chenhuacai@loongson.cn>
 <20241108091545.4182229-4-chenhuacai@loongson.cn> <20241114103111.5W5ZY0D4@linutronix.de>
 <CAAhV-H72YSNBGutYPOVi=S7nwLb6YOiQOFqnimAp=9D0wAJc3g@mail.gmail.com>
 <20241114111409.LWKp5YEg@linutronix.de> <CAAhV-H4ecBZsV+9SxLZ-JFiUK=b3tMqkLZe0djac0_390==MMw@mail.gmail.com>
 <20241114113018.Ilo9ZsQo@linutronix.de>
In-Reply-To: <20241114113018.Ilo9ZsQo@linutronix.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 14 Nov 2024 19:36:38 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4jDNG8nsW30U9zE1-c6dHwy2fSjy5hkZhpWWu3=og64A@mail.gmail.com>
Message-ID: <CAAhV-H4jDNG8nsW30U9zE1-c6dHwy2fSjy5hkZhpWWu3=og64A@mail.gmail.com>
Subject: Re: [PATCH 3/3] LoongArch: Allow to enable PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-rt-devel@lists.linux.dev, Guo Ren <guoren@kernel.org>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 7:30=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-11-14 19:19:26 [+0800], Huacai Chen wrote:
> > > > > Why is ntpd/chronyd service affecting this? Is it running at prio=
 99?
> > > > > Otherwise it should not be noticed.
> > > > No, ntpd/chronyd doesn't affect latency. But they may trigger RTC
> > > > synchronization every 11 minutes, and RTC synchronization affects
> > > > latency. We can keep ntpd/chronyd running but disable RTC
> > > > synchronization by configuration, this is the least aggressive meth=
od.
> > >
> > > What is "RTC synchronization" in this context?
> > Means the sync_hw_clock() function in kernel/time/ntp.c, it can be
> > enabled/disabled by chronyd configuration:
>
> But what exactly is sync_hw_clock() doing that is causing a problem
> here? The clock on HW is updated. The access to the RTC clock is
> preemptible.
This is a platform-specific problem, our RTC driver is
drivers/rtc/rtc-loongson.c, the write operation to RTC register is
slow.

Huacai

>
> > Huacai
>
> Sebastian
>


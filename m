Return-Path: <linux-kernel+bounces-247756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9A392D424
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA45928301A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A97A193464;
	Wed, 10 Jul 2024 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Pln59aDH"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3331919046A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720621345; cv=none; b=V54N+39wKSQY26GwrBEkzf0mWa2zXjYkpIyngJZycvRZCh2NDioNNAB31QGzKzyq8rHiTWnu69hDPqSkBHN6Ok1mzUrNzp7rISlnFI89UBMCu1suAkxVTp43lqFoYStuNMaslo7e4M++HSshE3drrVSQwv5cwVI05ROmVDLsUug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720621345; c=relaxed/simple;
	bh=JlC2OsADKBjuywOaQC1MwM+rsBTtM5dBOj5lQRE3ssc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=NGav47+8An/RY+mDoJ8Xl4fDZg/d7rPJQrKhXBa8fWIukDRMar5lmUsXvD8EdEAbKkZNhv/Ascsvca7lDtZ/9YNMGtpb+c9uDU8/4Qow6uRDeKFJrACDIbLHVF9/rwQ5nCefZ1jasLTG3rQjVXbkYI8wJ4qLODNjsWunpNMOrD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Pln59aDH; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1720621333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=27V6jUOaNytzMrX8tcswA+zOR0z0lNMkdk4MlU12XKo=;
	b=Pln59aDHanugpPxhabXhnNgy/f3kk/SoEB6XuIRPRD+u2Iny9Y+3kxYXie6bSsQPbxTVqO
	+SUmN1TgAXAeZ+/jGDSwVcz0nyOzPCDx/CRAbvVY0A1QzLt97MSvw+PBcCPRbHJkAxKER7
	Z1RwnzuVc2SOKxAXTx4PblsbUH++I437k3+bJjw3Q/dlni6TTEzGjGczn62KlDDaZyXkSf
	LSYX0rLM6RHO4fgdUzoHQx0mlhHqpmqZ5v5mE76pxgUneoMxYPiW2l6aSsbTR1w3TnaOVW
	7C0pkf5V2/c+FaHTgiOTo/BOp2DZYdd3cl98sLZJ8+r/WPbQBkCAAmuI0QjyIw==
Date: Wed, 10 Jul 2024 16:22:12 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andy Yan <andyshrk@163.com>, linux-rockchip@lists.infradead.org,
 dri-devel@lists.freedesktop.org, heiko@sntech.de, hjc@rock-chips.com,
 andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 javierm@redhat.com
Subject: Re: [PATCH] drm/rockchip: cdn-dp: Remove redundant workarounds for
 firmware loading
In-Reply-To: <20240710-smooth-hypnotic-raccoon-b91fba@houat>
References: <9b7a9e9b88ad8c7489ee1b4c70b8751eeb5cf6f9.1720049413.git.dsimic@manjaro.org>
 <109c6f19.2559.1907b817a99.Coremail.andyshrk@163.com>
 <0bf4701d98833609b917983718c610aa@manjaro.org>
 <2fd3aabd.785b.190914ec1a6.Coremail.andyshrk@163.com>
 <f0fb9feed2d9262bb4d7c8ade836af62@manjaro.org>
 <909d072.9028.19096c2429a.Coremail.andyshrk@163.com>
 <31062b80d3f9e11c339c400a70464f43@manjaro.org>
 <20240709-exuberant-tentacled-oxpecker-bd1ea0@houat>
 <b6d630447e6c69e913b76650d910f895@manjaro.org>
 <20240710-smooth-hypnotic-raccoon-b91fba@houat>
Message-ID: <a30067db11e586d8eb2c124abe32052a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Maxime,

On 2024-07-10 09:13, Maxime Ripard wrote:
> On Tue, Jul 09, 2024 at 06:36:08PM GMT, Dragan Simic wrote:
>> > > > > As I already wrote earlier, and as the above-linked discussions
>> > > > > conclude, solving these issues doesn't belong to any specific driver.
>> > > > > It should be resolved within the kernel's firmware loading mechanism
>> > > > > instead, and no driver should be specific in that regard.
>> > > >
>> > > > IT would be good if it can be resolved within the kernel's  firmware
>> > > > loading mechanism.
>> > >
>> > > ... we'll need this as a systemic solution.
>> >
>> > The general policy has been to put drivers that need a firmware as a
>> > module, and just never build them statically.
>> 
>> I totally agree, but if Buildroot builds them statically and provides
>> no initial ramdisk, we need a better solution than having various 
>> drivers
>> attempt to implement their own workarounds.
> 
> Buildroot typically allows custom kernel configurations, so it's not
> really "enforcing" anything like another distro does.
> 
> It is definitely targetted towards very stripped down systems, so I
> guess building the drivers statically is a natural choice, but it works
> fine with modules too.

It all leads to a conclusion that we need better in-kernel support
for delayed firmware loading, instead of drivers implementing various
workarounds, for the layouts in which drivers are built statically
into the kernel image, but the required firmware blobs reside on the
root filesystem.

I'll start working on it, hopefully today. :)


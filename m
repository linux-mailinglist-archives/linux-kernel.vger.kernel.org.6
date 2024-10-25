Return-Path: <linux-kernel+bounces-381952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDF79B069A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7D71F23137
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FB8185939;
	Fri, 25 Oct 2024 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lsT0ohrO"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F250F14F135
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868292; cv=none; b=gGx78t+bopDWvLsX7aNlLnhqcf2p6IA58J7ZMsQ5hRZsSuWr38qpUE2/ARwso/lgL5BCwO2XjSmh+JbuH4jdWWORPoAm5vxVxSiCWJ93qllPvFhNATFmUMGtzPrOHJPr7hE0/dqI04Vw8HgPFSdNU1A4ekpvaUNmQ7Qye0n6Nug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868292; c=relaxed/simple;
	bh=g3MfoZxhecfi4HZ5CyZhoCkqBJe/YJdi/vBp0g2shGI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=J7UttEMz4hLdqiXmtrOpGEi+76VoHayaK2re/86rWofT0BGZrQUk2vS/7vukDhkl02Md6yaY73mnm8y7qPnpqtqQ1ZNhBUzF7xDyjWbVNgirxSqDGbqkoVeTS+hSD2uO80GL8CGd1/TCSmYwJtScK8NtVnPYceG+wkhx7Pe+zPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lsT0ohrO; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <07766e5e-6009-4b8e-8a50-30ba0fe763f5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729868285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a8cGWjeBVtubT1nOUtGsNOA8VZMw6hKLHJizMjgK7rM=;
	b=lsT0ohrOh5E5xFM4/dj8E2d6LS9jzHhErfRZvWVngnIdLZIK7DuzuMzxTL+5FIV4LeCWN+
	U/20Ma87/13Nzno2oI+HQ5PtOK5L7+Jks9xkOZWaXhupqk0lEsFH/AtfUIT+Sa7/dD0CJJ
	yt+rOq5RPn/O0mA6h1enlPz24Aq4YXI=
Date: Fri, 25 Oct 2024 10:58:00 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 0/8] drm: zynqmp_dp: IRQ cleanups and debugfs support
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 David Airlie <airlied@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, "Sagar, Vishal" <vishal.sagar@amd.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 dri-devel@lists.freedesktop.org
References: <20240809193600.3360015-1-sean.anderson@linux.dev>
 <5e9769dd-459a-4ff3-aebb-bb7057192733@linux.dev>
 <a023bd66-8f42-4f27-9aa2-5097b2574562@ideasonboard.com>
 <e959a01f-b466-4076-8219-a6c83a7194c0@linux.dev>
Content-Language: en-US
In-Reply-To: <e959a01f-b466-4076-8219-a6c83a7194c0@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Tomi,

On 10/3/24 10:53, Sean Anderson wrote:
> On 10/2/24 10:50, Tomi Valkeinen wrote:
>> Hi,
>> 
>> On 01/10/2024 21:31, Sean Anderson wrote:
>>> On 8/9/24 15:35, Sean Anderson wrote:
>>>> This series cleans up the zyqnmp_dp IRQ and locking situation. Once
>>>> that's done, it adds debugfs support. The intent is to enable compliance
>>>> testing or to help debug signal-integrity issues.
>> 
>> I think the patches 1-7 look fine, and I think I can pick those already to drm-misc if you're ok with that.
>> 
>> I'm a bit unsure about patch 8, probably mainly because I don't have experience with the compliance testing.
>> 
>> How have you tested this? With some DP analyzer/tester, I presume?
> 
> For my test setup I used an oscilloscope hooked up to the displayport
> output using a fixture that broke the signals out to SMA. Since the
> oscilloscope cannot emulate a sink, I first had the output connected to
> a monitor. Then I disabled HPD and reconnected the output to my fixture.
> This process is described in more detail in the documentation.
> 
>> I think none of this (patch 8) is needed by almost anybody.
> 
> Well, I found it very useful for debugging a signal integrity issue I
> was having. Once I could have a look at the signals it was very clear
> what the problem was.
> 
>> Even among zynqmp_dp developers I assume it's very rare to have the
>> hardware for this. I wonder if it would make sense to have the debugfs
>> and related code behind a compile option (which would be nice as the
>> code wouldn't even compiled in), or maybe a module parameter (which
>> would be nice as then "anyone" can easily enable it for compliance
>> testing). What do you think?
> 
> Other drivers with these features just enabled it unconditionally, so I
> didn't bother with any special config.
> 
>> I also somehow recall that there was some discussion earlier about
>> how/if other drivers support compliance testing. But I can't find the
>> discussion. Do you remember if there was such discussion, and what was
>> the conclusion? With a quick look, everything in the debugfs looks
>> generic, not xilinx specific.
> 
> The last it got discussed was back in [1], but I never got any further
> response. I agree that some of this is generic, and could probably be
> reworked into some internal helpers. But I don't have the bandwidth at
> the moment to do that work.
> 
> --Sean
> 
> [1] http://lore.kernel.org/dri-devel/cda22b0c-8d7c-4ce2-9a7c-3b5ab540fa1f@linux.dev

Does this all make sense to you? At the moment I don't believe I have any
changes I need to resend for (although this series is archived in patchwork [1]
for some reason).

--Sean

[1] https://patchwork.kernel.org/project/dri-devel/list/?series=878338&archive=both


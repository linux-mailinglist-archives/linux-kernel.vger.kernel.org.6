Return-Path: <linux-kernel+bounces-293267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA925957CBD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 07:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45CC8B21B5B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 05:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE72131BAF;
	Tue, 20 Aug 2024 05:31:40 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F03D1862
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 05:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724131900; cv=none; b=E7SYx92K9AG0mXr1UgJxdOrX4kPEBkTH81PSVXk4vgJpMcPirPpSFgzcRCfG2d/zlsXK2SqehQNR3NVQtZTCt3RIt2RofW0hhwlUXN1nm3BeExSyDtYLHC5dtWkMbaCimLS+Fftd5+XzcMEqrGNIGIM3IcblodvT2OHAkwnJPHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724131900; c=relaxed/simple;
	bh=lnn1cMwZ5xGuxZXmYgF8Mux94AyucGFh2qMYd0RHS4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6GsAbhn4tv2njk6xz/BHIZIQp1skWr+OVtSAKQkSuRKSMpACYdF4zhtf4C8lmyUislDYf3L0G76nxfd5Dgs4Qsqe4GNuzdxARhLQo5Lb7ikWGTuGLK0Vg2twfsJyr5FIcXAcCKTZMYXhaYgZs2gsx+F2Wn00GSxbcwrdqn8nN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af271.dynamic.kabel-deutschland.de [95.90.242.113])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5486861E5FE07;
	Tue, 20 Aug 2024 07:31:12 +0200 (CEST)
Message-ID: <17001e93-7baf-428b-b979-e6fb8330cb84@molgen.mpg.de>
Date: Tue, 20 Aug 2024 07:31:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Commit *pidfd: prevent creation of pidfds for kthreads* causes
 `Failed to remount '/' read-only: Device or resource busy`
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
References: <3a1c9e27-6dcb-4eec-85cb-c03271c61a37@molgen.mpg.de>
 <b21aa149-fd70-4aa0-9b25-886c81ebfae2@leemhuis.info>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <b21aa149-fd70-4aa0-9b25-886c81ebfae2@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Thorsten,


Am 20.08.24 um 07:03 schrieb Thorsten Leemhuis:
> On 19.08.24 23:02, Paul Menzel wrote:
>> #regzbot introduced: 3b5bbe798b24
>>
>> Commit 3b5bbe798b24 (pidfd: prevent creation of pidfds for kthreads)
>> causes a regression. On the Dell XPS 13 9360 with Debian sid/unstable
>> and *systemd* 256.5-1, systemd is not able to unmount the root partition
>> (LUKS encrypted) anymore.
> 
> Hi Paul! Thx for the report. FWIW, a revert to fix this is already
> queued as 780d60bac21ebe ("Revert "pidfd: prevent creation of pidfds for
> kthreads"") [next-20240820 (pending-fixes)] after Eric reported similar
> problems recently:
> 
> https://lore.kernel.org/all/20240819-staudamm-rederei-cb7092f54e76@brauner/

Thank you for digging this up. I thought I search for the commit hash in 
lore.kernel.org, but maybe I hit the wrong button *locate inbox*.

Anyway, reverting the patch on top of master also fixes the issue for 
me. Maybe Linus can take it directly, as more people are going to run 
into this.


Kind regards,

Paul


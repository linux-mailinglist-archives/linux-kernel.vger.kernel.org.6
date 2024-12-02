Return-Path: <linux-kernel+bounces-426764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D67A9DF787
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 01:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5DF4B211B2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 00:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FCD79EA;
	Mon,  2 Dec 2024 00:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=matoro.tk header.i=@matoro.tk header.b="pHA+hciu"
Received: from matoro.tk (matoro.tk [104.188.251.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B8120E3;
	Mon,  2 Dec 2024 00:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.188.251.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733100193; cv=none; b=oid5rLMKG5lhAoQa6jfydw6qKCM7m6aP3XwL9adq/v7302azMchkCkPFaCX/Cyn+0PuuDyGsQyN3H9anDhC/ktKw04wUJxQC/9dtNIaodrtGVJ9TeVp+JIFUqC8dcz78e2OuwaBQJld3Md1b5/a0D1/bsuK/jCPjjx91z8YovUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733100193; c=relaxed/simple;
	bh=qa2qM3/pr0kGdqxBQXftZwsZwmiIu5a1oqL5E7xMYjw=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=isQVhWSu3moyIXGsnOQY34FrnnIXyLtsk+NrMm1tM6HZujz077izzcYZTQc4N3ggPPJYqbvNp9vYSD2nJ6QErttTN5XYsJg1Tc9JerfSTUUoKhorcyHbpYcDBsy4SACxdu1uoV2Qxnd6xfmicOxPCvcW8tgSDSW/byqeFJedcVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=matoro.tk; spf=pass smtp.mailfrom=matoro.tk; dkim=pass (4096-bit key) header.d=matoro.tk header.i=@matoro.tk header.b=pHA+hciu; arc=none smtp.client-ip=104.188.251.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=matoro.tk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matoro.tk
DKIM-Signature: a=rsa-sha256; bh=wPZJZ7zNgiasBzmRMvgKOmrp84OE3S31jgc4LVeCnoE=;
 c=relaxed/relaxed; d=matoro.tk;
 h=Subject:Subject:Sender:To:To:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@matoro.tk; s=20241120; t=1733099212; v=1; x=1733531212;
 b=pHA+hciuyeJ0GwzoHahR+KTjkC6iRoM7tG9D+5iCA/GESsNFHEDbtsQ2/5xYiDUO2/7Jzn3F
 ZQgF3WJNTXlgUSXuPicQgWzJLlXL9RNDhHButlwrt34vVJqCf+FeunuuM6GecCispOohyb7gnob
 NHJZemGmsyNrN/CYOiwAz01JgYYqLvft40kBGdVpVylEh9WF0zHxfUbX1J1s58JHbzUaO2GAE3b
 qgJMvy/mWvKMTL9KpFDPcpWtR3p8Ny5H960yHOykwUAswenpKieo96rEztuCnVJzwwq8MjfwNSr
 4kzxfsKwl9SiBJOHBpnHQ9M8bQjfF5Pd/kDQsvVoigHEtxfWwmz4g3f5v00k/QAMKHRA3hkerIh
 xCDtVzABM58cqXvhAzfiTAzDjV2r+WrrGOWeZO9QXmcbYUBzmYjGgIijpBq46twcLySn6Y9IF9Q
 ukzgQQp98kp9DRXqVMCpw0d/New6q+Rfgz7/fXcLUfk5yIQuk8xhfyCpqGh99ZS7uA7PReKd5jw
 HQinjVBkg7vARGVxLBgzJDevi1xaoZrvmxNcvo/IAuu3LFDM0I1ITZZhuvudoMY/IvvUL8Jq3B5
 Xh7E9JJTA+hwC5QjAtEY1sqv4vsuxtr4VLcVDfHoleZw5xUVgbkFbWRLTQXdEfzbrQLULc4IFWs
 xvCpTYEKYTo=
Received: by matoro.tk (envelope-sender
 <matoro_mailinglist_kernel@matoro.tk>) with ESMTPS id af952462; Sun, 01 Dec
 2024 19:26:52 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 01 Dec 2024 19:26:52 -0500
From: matoro <matoro_mailinglist_kernel@matoro.tk>
To: Linux Parisc <linux-parisc@vger.kernel.org>, John David Anglin
 <dave@parisc-linux.org>, John David Anglin <dave.anglin@bell.net>,
 deller@kernel.org, Deller <deller@gmx.de>, linmag7@gmail.com, Sam James
 <sam@gentoo.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [bisected] ext4 corruption on parisc since 6.12
Message-ID: <84d7b3e1053b2a8397bcc7fc8eee8106@matoro.tk>
X-Sender: matoro_mailinglist_kernel@matoro.tk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi Helge, when booting 6.12 here myself and another user (CC'd) both observed 
our ext4 filesystems to be immediately corrupted in the same manner.

Every file that is read or written will have its access/modify times set to 
2446-05-10 18:38:55.0000, which is the maximum ext4 timestamp.  The 32-bit 
userspace doesn't seem to be able to handle this at all, as every further 
stat() call will error with "Value too large for defined data type".  
Unfortunately, simply rolling back to kernel 6.11 is insufficient to recover, 
as the filesystem corruption is persistent, and the errors come from 
userspace attempting to read the modified files.  I was able to recover with 
a command like:  find / -newermt 2446-01-01 -o -newerct 2446-01-01 -o 
-newerat 2446-01-01 | xargs touch -h

Luckily, lindholm was able to bisect and identified as the culprit commit:  
b5ff52be891347f8847872c49d7a5c2fa29400a7 ("parisc: Convert to generic 
clockevents").  Some other comments from the discussion:

17:20:37 <awilfox> would be curious if keeping that patch + CONFIG_SMP=n 
fixes it
17:20:44 <awilfox> this doesn't look necessarily correct on MP machines
17:23:56 <awilfox> time_keeper_id is now unused; the old code specifically 
marked the clocksource as unstable on MP machines despite having per_cpu 
before
17:24:11 <awilfox> and now it seems to imply CLOCK_EVT_FEAT_PERCPU is enough 
to work around it
17:24:13 <awilfox> maybe it isn't

Thanks!


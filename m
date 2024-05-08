Return-Path: <linux-kernel+bounces-173227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 963EA8BFD4B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F1A1C21E9B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31644642D;
	Wed,  8 May 2024 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="zVPGKyKf"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED4D42055
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715171925; cv=none; b=CS8twUdBH/2UACKKHJOFLxFLF2hv2vvv/elbS7rvvUUp17WnCDNqEEue238FaD1mZnDJEPzpPUUgZccdWxDAb3x8qUay+DG57Lnn+A+atFNlaokOyvd+LnZ2OZcjCyoBwU7eHEolHRTkz39+jsdBBwwuNXE67W6KDRF0+2TtkTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715171925; c=relaxed/simple;
	bh=0U23O4IifsWoKyzKHhaaAo1uk/eFcgF3SudtcJ9vppw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rBWi1xPST5GRVNzlFyeFiFqT5DGkQTJ39fnIyHiLGf7hdS+GOK2yZjB8y9QhgGt9LX8vSm86r066olU1ADx3RBCCezmRb5Dmi+o/+z1rzAaJEfb6xl4jzwTY4w37czQ2pfYYSlsncf0KCZbC4kulZoOd+P2wO4TLYA6J5NnbcxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=zVPGKyKf; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715171922;
	bh=0U23O4IifsWoKyzKHhaaAo1uk/eFcgF3SudtcJ9vppw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zVPGKyKfbF3n5CnjFI147MV+4XzTAeuTZjHxXRPNjNWTJE2dKJIasxSpUmEEwbv2/
	 XIyGy9yI6gLpQykNgrcde8wfFtlNl28BY+f5uem5zyZDiDbTgUM6FdDSjLgk2bIf2o
	 nHAGmN6VkolhyfulWT/FGL8oanXwqqGl65Bu2/RWQKN++ZDFoPb2dCgziwccvh/3x/
	 whP4KRZOwslJvTCoqkuEhLzRLNh0CcAzpqwKtS9WAAJS3pBrEWJ2Y1dCHJYcrvshgE
	 zInEtTBq3pMAUGg+qn4LemLHVemv9mfDB4f8sd9Hl91QHxTm/kpghD/AQeRdz2e6O1
	 Ou63r3AsyqQgQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A31F73782112;
	Wed,  8 May 2024 12:38:41 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: regressions@leemhuis.info
Cc: kernel@collabora.com,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: [REGRESSION] next boot regression caused by RIP:0010:acpi_find_gpio+0x4b/0x103 kernel panic
Date: Wed,  8 May 2024 14:39:15 +0200
Message-Id: <20240508123915.534166-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <252f883a-6bf1-4ef7-a5f9-d261a6cf725e@leemhuis.info>
References: <252f883a-6bf1-4ef7-a5f9-d261a6cf725e@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Thorsten,

On 5/8/24 13:36, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 26.04.24 17:42, Laura Nao wrote:
>> Hello,
>>
>> KernelCI has identified a next boot regression on the following
>> Chromebooks, between next-20240416 and next-20240418:
>> - Lenovo ThinkPad C13 Yoga Chromebook (codename morphius) - kernel
>>    configuration used [1]
>> - ASUS Chromebook Flip C436FA (codename helios) - kernel configuration
>>    used [2]
>>
>> [...]
>>
>> The issue is still present on next-20240426.
>>> #regzbot introduced: next-20240416..next-20240418
> 
> Hmmm, I noticed nothing has happened here.
> 
> Is this issue still happening? With a link to the particular test in the
> CI I might have been able to answer that myself. ;)
> 
> If it's still broken I assume we need a bisection.
> 

The issue was detected by the new KernelCI system - there's no web 
dashboard for it yet, which is why I did not provide a link earlier.

I verified this is still happening on next-20240508 and I already 
started a bisection, I'll report back when I get the results.

Thanks,

Laura

> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> #regzbot poke
> 
> _______________________________________________
> Kernel mailing list -- kernel@mailman.collabora.com
> To unsubscribe send an email to kernel-leave@mailman.collabora.com
> This list is managed by https://mailman.collabora.com



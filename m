Return-Path: <linux-kernel+bounces-285411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA613950D16
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37924B25D74
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703F11A4F11;
	Tue, 13 Aug 2024 19:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=bob.beckett@collabora.com header.b="f6rwTdig"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FADF1A3BD3
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723577004; cv=pass; b=PGwUplA8Q/2i9APZWRdUnUNF7X8JaE+eA7uKG0wV+Pl2AnSV93NmDlEcg1vE0vNnvhRlYkQBIRMriS7gsnn5C9NMd11VC8MfyApDUPv+7a7/JR5HXYmQYklfLniro1ft9hg/AzhjmmKJufka0Xt/BhmTx5tK8K+v463y6wQj69o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723577004; c=relaxed/simple;
	bh=jS3I1UzIJ44oquZnHYmJGFTN9KgQd26gGC230wQZ4ic=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=SgaAjPCjT8zcqpBeE4i5PKdJ2ILUp1KNB/HaKshkEBsMjra+VPu0ZBbtsICT0NMDsyAqXxJMPgkILKbPyFRqosu6TuEtLq0XUP+7UtOR1hM/+5imfL9AKnV+nRgONxu+eJUqHzHg5lGn9lnq8XxjmLdENQT1uuqPjv2YW3rwxPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=bob.beckett@collabora.com header.b=f6rwTdig; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723576978; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=K96ngpZg7BwHSiatLdwuHB/e8EavEKBETgVRe5eWXEVHdiux4xLaegXuyTOL26fxtuKwfmYQ5RUcp4sxbB8HElPyKuzz1gdyQZyAtBZBlD09XqZFKKcajeMHSL+pYuy0OybebDlz9jgLoYXZNyq34c26/ASCOBM8xMkxdbf8INk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723576978; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xStHEN3DFYF+rBHqF+MX09tbCCUNzakqxHaQgIl1Nfc=; 
	b=LkZJDr6RqokLiba1s2JqOVU9DmgyCKGUtB8bcTN+p/3PTnUSJGpJRjnZYmNgAW+uacRCZy1AsE+i52UaooreR0oyTmqbLacwK08oSAhL27cDEr1aQIngpROIhtgYeGmc3YBfxHpjdN/PZJPa44QL4hezyU722JMpvwpVyXBDYak=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
	dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723576978;
	s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=xStHEN3DFYF+rBHqF+MX09tbCCUNzakqxHaQgIl1Nfc=;
	b=f6rwTdigptOcUpmKz+ZGW5cwxkb/G66HFBIJL8o2W9lH6MYuWUH51mpLAbyrSj8M
	AAZwV9XCWElGWnRwEqVldb76fbyTEz+T+jD0RuBIvXA408JEd0nUcJtkPwd1otmNYHq
	zL01CBotus/uZmMFRhlQdbj2hWQUlVxcrWVZajdU=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1723576946556359.0535966500198; Tue, 13 Aug 2024 12:22:26 -0700 (PDT)
Date: Tue, 13 Aug 2024 20:22:26 +0100
From: Robert Beckett <bob.beckett@collabora.com>
To: "Thomas Gleixner" <tglx@linutronix.de>,
	"Peter Zijlstra" <peterz@infradead.org>
Cc: "x86" <x86@kernel.org>, "linux-kernel" <linux-kernel@vger.kernel.org>,
	"Engineering - Kernel" <kernel@collabora.com>
Message-ID: <1914d310f3d.12a7d406f898033.7903291218646592039@collabora.com>
In-Reply-To: 
Subject: CONFIG_MITIGATION_CALL_DEPTH_TRACKING
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi,

After upgrading from 6.1 to 6.5 based kernel we noticed a regression in boot times
on AMD Zen 2 based device.

After some debug, we figured out that CONFIG_MITIGATION_CALL_DEPTH_TRACKING
(or CONFIG_CALL_DEPTH_TRACKING as it was then) seemed to cause the slow down.

Having two 6.5 kernels, one with it enabled and one without, with no other differences
we performed 101 reboots with each version.

It showed a median boot to graphical.target of 8.537s with it enabled and 5.938s with it
disabled as measured via systemd-analyze. This difference (within noise) matches the
regressing in boot times observed after the kernel upgrade.

Post boot runtime comparisons show as [1] that there is nothing between them.

I'd appreciate any advice you can give, especially around these questions:

- The original patch series [1] mentioned runtime performance testing. Does anyone
know of any boot time testing write-ups that may have occurred at the time?

- The help for the config mentions a 5% text size overhead. While I could (perhaps
naively) expect up to 5% more page cache misses etc during boot up, is a ~30% slow
down explainable via this config? (no kernel boot params are specified for mitigations
so all defaults apply)

- I am tempted to conclude that if we want to mitigate retbleed in a consistent way
that we should just disable this option and rely on CONFIG_CPU_IBRS_ENTRY. Is 
there any other option to support accelerated Intel mitigation without penalising 
AMD boot up times due to the overhead?


any thoughts would be greatly appreciated.

Bob


[1] https://lore.kernel.org/all/20220915111039.092790446@infradead.org/


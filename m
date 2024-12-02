Return-Path: <linux-kernel+bounces-427485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7EA9E0266
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39E3DB38C2D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED3B1FECA8;
	Mon,  2 Dec 2024 12:11:21 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CC41FF610;
	Mon,  2 Dec 2024 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141480; cv=none; b=MUz9lN1LH8VDxYQfDbNUb8YxHbuen5UaT7Ht4l2cpqsH2XhvF5GfUEbLkh8664oKu5tJIyBLIAHyYlLplHJw4QQdfB332GefgGZRdTMJalcb44QgWIbEwASPlF1dpOUbNwYijkwFNIHDfwz3u+OgHHAKjfWB38SuhVjTuNgZnpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141480; c=relaxed/simple;
	bh=7LU/ty4SAMGoEAFLEev6kRTVxLE6RRuqBohJQALDcqE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VVcWkT4VkdkJYkljdqEVbSmslciV9x0wmG4m2oYrPRQYabEKuIKIgeUqsBpfzpyNQWIcj+OXWAyxsbxzbnq6TIeJ32m6Jb5UcNnyFF7BE/8ZEDYJjOQp35DoaLSYWDR4nYk4QLrWLhNCIrz7FIUAdxWddJkSiFr+C5j1j9oCplk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 2 Dec
 2024 15:11:07 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 2 Dec 2024
 15:11:07 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<sashal@kernel.org>, <stable@vger.kernel.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, "Rafael J. Wysocki"
	<rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 5.10.y 0/1] Backport fix for CVE-2024-49935
Date: Mon, 2 Dec 2024 04:11:03 -0800
Message-ID: <20241202121104.35898-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

This patch addresses CVE-2024-49935 [1], a vulnerability in ACPI
subsystem caused by calling cpumask_clear_cpu() with bit to
clear set to 0xffffffff, thus leading to erroneous memory
access. The issue is still present in 5.10.y kernel.

The original commit [2] has been backported to several stable
branches (5.15.y and fresher) and now has been cherry-picked for
5.10.y.

[1] https://nvd.nist.gov/vuln/detail/CVE-2024-49935
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=0a2ed70a549e61c5181bad5db418d223b68ae932

Seiji Nishikawa (1):
  ACPI: PAD: fix crash in exit_round_robin()

 drivers/acpi/acpi_pad.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.25.1



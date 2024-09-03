Return-Path: <linux-kernel+bounces-312736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF53C969A81
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25A3D1C21106
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AE91B982F;
	Tue,  3 Sep 2024 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metrotek.ru header.i=@metrotek.ru header.b="RXCxfsvB"
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
	(using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900EB1AB6E7;
	Tue,  3 Sep 2024 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.18.215.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360389; cv=none; b=DqAI33OnPKR9v6nTjXfZz1xn/i+r/Zsu5lB9oDbXhX4mxIehFoxIVoyw872kdkl6zL4qXUDXIxC83oDF/lidDFGhZSHhJeQ1TdI4otqOmxi89F7eqMuO1o2+J2+is5QbQKELxQRzKzKo0PyVzeC+mcqSZ6C0w9kVo4f+GQ+jlK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360389; c=relaxed/simple;
	bh=7wyzaZUZ5APSgDe+WjKcf97u96IonNrHPHUv0em4dKA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CR1bN7qN4j/qL1zrMZIaUpADnR804ACHkA7E9Xhhic8P7meHAhhmw8jukz8Mg7h789fc8meLH9h7pozJlVEaSztMTF/d9+Zzc3CSC6t35pVCXNU2qBD1bf62CdBT4aii7+kou5jud2lTzjd5V8UoiLFX9SD0OnQ8XyOcIM2HZ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metrotek.ru; spf=pass smtp.mailfrom=metrotek.ru; dkim=pass (2048-bit key) header.d=metrotek.ru header.i=@metrotek.ru header.b=RXCxfsvB; arc=none smtp.client-ip=178.18.215.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metrotek.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metrotek.ru
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=metrotek.ru; s=mail;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
	bh=7wyzaZUZ5APSgDe+WjKcf97u96IonNrHPHUv0em4dKA=;
	b=RXCxfsvBj/YwBY1XwiFEvG+Z87+Y+CjTYPITsAUK6m5nZ5NLQbpgRCM9ysKB0pan3qjb9YcmDZntm
	 YaXX7K9ZRTm7RpJ+WbDl4l4Y3bIu8czVdFWiJqjU/TPM3nqnD+BZLNnxWzGQNSNf9kZ3iG6AowPZlY
	 4/hDWMGq3pZaDruC0BXSIhFHVMddhxSxnknfqf+fmqJHlzq1/jAnIlLfgoViHwildpbhm96Us/YaRa
	 cyQK6AvyGEHpoFi9AM+dkZZY+JH1wG1uzvxcFvjcaT4Q2A37O4XYZJkGsdkIPwrBI1M0mHJtFxBxCI
	 ZRTnNpEiWSRM15TwtnqAThacBgKpN2g==
X-Kerio-Anti-Spam:  Build: [Engines: 2.18.2.1544, Stamp: 3], Multi: [Enabled, t: (0.000009,0.004679)], BW: [Enabled, t: (0.000016,0.000001)], RTDA: [Enabled, t: (0.094081), Hit: No, Details: v2.79.0; Id: 15.qp9sj.1i6rnrulo.7qi3], total: 0(700)
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from fort.ddg ([85.143.252.66])
	(authenticated user d.dolenko@metrotek.ru)
	by mail.pr-group.ru with ESMTPSA
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
	Tue, 3 Sep 2024 13:46:10 +0300
From: Dmitry Dolenko <d.dolenko@metrotek.ru>
To: pantelis.antoniou@gmail.com
Cc: geert+renesas@glider.be,
	nava.manne@xilinx.com,
	radhey.shyam.pandey@xilinx.com,
	austin.zhang@intel.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	system@metrotek.ru
Subject: of: Status of DT-Overlay configfs patch
Date: Tue,  3 Sep 2024 13:46:08 +0300
Message-Id: <20240903104608.184988-1-d.dolenko@metrotek.ru>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Is there any place where the status of patch "OF: DT-Overlay configfs
interface" could be found?

As I can see, such a question has been raised in [1], but remained
unanswered.

I assume it is maintained separately in vendor trees starting from some
version of the patch. Is it so?

There are several versions of dt-overlay configfs that I have found in the
trees of different vendors:

   - Renesas: [2]
   - Xilinx: [3]
   - Altera: [4]

Link: https://lore.kernel.org/all/CAAMH-ysawX29vKsqkjjNG=YNTuxjZoAeax2RCycWq_Me7Gz2Jg@mail.gmail.com/ [1]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/commit/?h=topic/renesas-overlays-v6.11-rc1&id=7c8efb1ea31bc7a06ed20d7bb0e76bcd6db722f8 [2]
Link: https://github.com/Xilinx/linux-xlnx/commit/7e42c87c489b702795794e480fb5483897ff9e91 [3]
Link: https://github.com/altera-opensource/linux-socfpga/commits/socfpga-6.6.22-lts/drivers/of/configfs.c [4]



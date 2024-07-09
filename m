Return-Path: <linux-kernel+bounces-245533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D3192B404
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FECA1F22B02
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1498155389;
	Tue,  9 Jul 2024 09:38:31 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971A3136657;
	Tue,  9 Jul 2024 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720517911; cv=none; b=Mu6+yhQbpaf4oFRRVvOIVmj7K8qeKfOsWigea1rb5zaex1j/iBTNEO164BLhr9mNS6Hu6jN6TyF2ddqzTM2pwRycdjZYRjIMJsfqfoqLJOEEYIywot290dL8AgwcOj31vu1g3pgQ4/mMbfLkylq2J1+bHvVTV33mDKGao4BGV4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720517911; c=relaxed/simple;
	bh=exor/0LgprF/HFpm8SM8Q3DobD+hK94JEtk1/Zyltio=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version:Content-Type; b=CEX6vxGyo94gJRCYMpUwov+nnM6xbYOIMn5rkzhpJA5760QPGH9Q9C9+6qNEJuLq6zjb+r+D2D84CHDjlZYkE2Tc0+EqxHNfXNp2hp2UX1g5Eq+bnjerYuckU4X+X1/WXTO3hbrE8tnFxDItxkTZ61TVd0hoEoyplWKg3JrNUVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b693a1.dsl.pool.telekom.hu [::ffff:81.182.147.161])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000713A4.00000000668D03DF.0016EC72; Tue, 09 Jul 2024 11:33:18 +0200
From: Gergo Koteles <soyer@irl.hu>
To: Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Ike Panhc <ike.pan@canonical.com>
Cc: platform-driver-x86@vger.kernel.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 0/4] platform/x86: ideapad-laptop: synchronize VPC commands
Date: Tue,  9 Jul 2024 11:33:04 +0200
Message-ID: <cover.1720515666.git.soyer@irl.hu>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Hi,

Sometimes the Yoga mode control switch did not work properly on my 
laptop, and sometimes even caused a platform profile switch. It turned 
out that it was caused by a race situation, the lenovo-ymc wmi notify 
handler was running at the same time as the ideapad-laptop acpi notify 
handler, and the partial results of the VPC calls in the two were mixed 
up.

This series introduces a mutex and reorganizes the code a bit to 
eliminate this.

Best regards,
Gergo Koteles

Gergo Koteles (4):
  platform/x86: ideapad-laptop: use cleanup.h
  platform/x86: ideapad-laptop: add a mutex to synchronize VPC commands
  platform/x86: ideapad-laptop: move ymc_trigger_ec from lenovo-ymc
  platform/x86: ideapad-laptop: move ACPI helpers from header to source
    file

 drivers/platform/x86/Kconfig          |   1 +
 drivers/platform/x86/ideapad-laptop.c | 284 +++++++++++++++++++++-----
 drivers/platform/x86/ideapad-laptop.h | 140 +------------
 drivers/platform/x86/lenovo-ymc.c     |  34 +--
 4 files changed, 235 insertions(+), 224 deletions(-)

-- 
2.45.2



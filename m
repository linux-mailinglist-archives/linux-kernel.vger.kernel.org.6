Return-Path: <linux-kernel+bounces-410161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCC49CD565
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 03:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5229281BBE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 02:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D700314A4FF;
	Fri, 15 Nov 2024 02:33:00 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 8D69057333;
	Fri, 15 Nov 2024 02:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731637980; cv=none; b=aKSvRH+Q0ycrnzv8S6gP0WfKtOdC7tMiT+174gZo3WE1EeU7LapK6SLA17EDmiwwMnjBsL3NYE8wtsoM2KHxZiS/1zY+uakzx0wZYDg+IDC3ENq5OguBJN7iPsZseCe5v6RmfWiq6/2EqEFsRzs5wv1+ChvR5HrIBwXs7N1DxyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731637980; c=relaxed/simple;
	bh=OX1t5DPbooVFsbdG4KwG5aXVwsLvCwuExJhDiWSi97M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=r9GbpJpkvYKiEuQzY9uVhMx18wOmya9AKir4APsnE92hg/I+Ha6MLfhxUvWHzUvHwH4HTvaNW98ieeoifTHPhFzJUb1fCJ15cjgYXPMJOphKaW7A2Y2TWZIi4rVhmMa0aoC0gvLiiPmFh0gyjh9P7LeLw0rBVsboouHNgDfy/ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id D73CE619C974D;
	Fri, 15 Nov 2024 10:32:48 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: stuyoder@gmail.com,
	laurentiu.tudor@nxp.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	dan.carpenter@linaro.org
Cc: Su Hui <suhui@nfschina.com>,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2 0/2]  bus: fsl-mc: Fix two double free problems in fsl_mc_device_add()
Date: Fri, 15 Nov 2024 10:32:05 +0800
Message-Id: <20241115023206.3722933-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset fixes two double free problems in fsl_mc_device_add().
One is reported by clang static checker, another is reported by Dan when
reviewing the code.

ps: There is only patch 1 in v1 patch, patch 2 has no v1 version.

v1: https://lore.kernel.org/all/20241114082751.3475110-1-suhui@nfschina.com/

Su Hui (2):
  bus: fsl-mc:  Fix the double free in fsl_mc_device_add()
  bus: fsl-mc: using put_device() when add_device() failed in
    fsl_mc_device_add()

 drivers/bus/fsl-mc/fsl-mc-bus.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.30.2



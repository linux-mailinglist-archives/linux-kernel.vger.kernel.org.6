Return-Path: <linux-kernel+bounces-447080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8649F2D11
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28D1164C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F94202C26;
	Mon, 16 Dec 2024 09:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbeP15Yi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700462AF03;
	Mon, 16 Dec 2024 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734341662; cv=none; b=SWIEAHVq16O7GVKo9SyI2VGYRwvnIXAhgI2+B5UorJ7vXfMjsZcytrGDhNjkuX0gtjljLyjQT8NVB9jVexUaLyg2jWslbC4eaoU9micIKzfr+Sekml4B/To+VF+izsuWQ/UdcC/bO2D9imjdf5abd/y2FtKxoY562CMD3SEohxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734341662; c=relaxed/simple;
	bh=xWqkQMOo1r4aFmTSakPdz2zoa8VdVFbmcoxWJbGbCB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g6avmnRdwrEza3xjZI58leGqPPdJkLJyS10tBJj9oRjKKbsQOYUDSJtZGLmdpecTBDrRpoJZOL9C4O5JbsohTEOOeyjWyl7F5ovcs0zC5iX29G8o7nQL08xXHcYzNRhEzyjNvkuZuy3JFVkXvkguSRTQK+IToKGj2dwmL8Ur6ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbeP15Yi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A0BC4CEDD;
	Mon, 16 Dec 2024 09:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734341662;
	bh=xWqkQMOo1r4aFmTSakPdz2zoa8VdVFbmcoxWJbGbCB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XbeP15Yi2d2NQRjgsRe6Ny1Fnb8SZAJ1FGS/LpT47CUuAle1IjYn+SqNBwaqdb4Xc
	 UPwatUJNSsE0ohwt2mn/tA0hiZaVYAP5a+QUHqUUnbvXO15fzlhV8S35YthxkeEdfQ
	 mOUVwaG2z/Bh/BY4DzU3ESagisSIaGQqi9uY/GwlXd4+DvMDCIiLhF/vzqtn+bcIH9
	 XDrtnEuh1IOjJSOIhW1JxutmXzmnRphGVzMbt1uDYwRd8jp+uYjj/hKo/5o2KAHtYz
	 Ej64i5gyAM5j7F/6h5GOVBst7ULHSn6R+1K1kTCpy96g+5DGhtBKXGM1QHO7LEm0yF
	 lJUWff0E2VofQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Yu Jiaoliang <yujiaoliang@vivo.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ALSA: compress_offload: avoid 64-bit get_user()
Date: Mon, 16 Dec 2024 10:33:41 +0100
Message-Id: <20241216093410.377112-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216093410.377112-1-arnd@kernel.org>
References: <20241216093410.377112-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

On some architectures, get_user() cannot read a 64-bit user variable:

arm-linux-gnueabi-ld: sound/core/compress_offload.o: in function `snd_compr_ioctl':
compress_offload.c:(.text.snd_compr_ioctl+0x538): undefined reference to `__get_user_bad'

Use an equivalent copy_from_user() instead.

Fixes: 04177158cf98 ("ALSA: compress_offload: introduce accel operation mode")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/core/compress_offload.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index ec2485c00e49..1d6769a66810 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -1180,9 +1180,9 @@ static int snd_compr_task_seq(struct snd_compr_stream *stream, unsigned long arg
 
 	if (stream->runtime->state != SNDRV_PCM_STATE_SETUP)
 		return -EPERM;
-	retval = get_user(seqno, (__u64 __user *)arg);
-	if (retval < 0)
-		return retval;
+	retval = copy_from_user(&seqno, (__u64 __user *)arg, sizeof(seqno));
+	if (retval)
+		return -EFAULT;
 	retval = 0;
 	if (seqno == 0) {
 		list_for_each_entry_reverse(task, &stream->runtime->tasks, list)
-- 
2.39.5



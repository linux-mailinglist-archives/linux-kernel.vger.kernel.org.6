Return-Path: <linux-kernel+bounces-198028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7C98D7298
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 00:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF90281F00
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 22:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2B13716D;
	Sat,  1 Jun 2024 22:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Ef6ValLR"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FF3B657;
	Sat,  1 Jun 2024 22:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717282504; cv=none; b=tBy2O08St9C+oBQuaFK1IvuGz/lFDeSTlv/rXzi9mWjTO7dWKe3UGn4xZHoFqnDya0T4w786ZwRFtIsjLWr8623/JIZYaNCInTHpyFWDcXZNKG+KJ2F0FDOdpkeFg9BovVtMPML9yLFMREPcrIFwE2xA8KOcOV6iidOXTJ129Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717282504; c=relaxed/simple;
	bh=Bz4DX+gNxH9XlW8R/tgQrIV6zNdeI1eX040W7bTSUjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iPGt8e0xkiQYKlDRhYCD/R7MjA3jticMdrxgBmjLbgsyrBoo36Yh82WyyZk4uBRMD0dcV+vyZFwwk/Wt5t3JWge50nHVpb0vS0g/cjc+mXcHfVh7OfueYsgj+5RqCaiu1Myq+pryjRizod1wEjdFkM7qtQw6SUwMYzPhskDmzKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Ef6ValLR; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=PzOOP33dT+Tz2TGiINq9Jf04QvLUVzbMQN3na04iTuQ=; b=Ef6ValLRSROMFZsr
	aVRVRN4gECdP8JLY+tAO14n0P7xtbzcD5Fx2fcERpw+qYD9gXxXn2w/+VWE9Glj3Ijl+oNI4qT6+T
	MIXBHnpesU98tBe0AqgtX1AOA9snvGW5PA9I/1GEoiuDnzWlu+sgucIfLxmgMspXjAwUJXyexBifW
	VjPAwpWwyO/adNVfLoxujLXMhMt+lW1svR91Id/LKgW3YCxrdVggTv6uVLonYtMxPBYAPHFsPCtBH
	zyXrgAxxaLeLsJKNY4f1VkEMzTRkmpOErR/INzVGOIz/t7XQmOaz/DL0T7jUhQGbEAJT72OXhlsxI
	oCs2xHD5BlERZn29nA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sDXce-003lZO-2p;
	Sat, 01 Jun 2024 22:54:49 +0000
From: linux@treblig.org
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	srinivas.kandagatla@linaro.org
Cc: alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/3] Dead structs in sound/soc/codecs
Date: Sat,  1 Jun 2024 23:54:43 +0100
Message-ID: <20240601225446.183505-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Clean out a bunch of old structs in sound/soc/codecs.
Build tested only.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>


Dr. David Alan Gilbert (3):
  ASoC: codecs: lpass-rx-macro: remove unused struct
    'rx_macro_reg_mask_val'
  ASoC: codecs: wm0010: remove unused struct 'wm0010_spi_msg'
  ASoC: codecs: cx2072x: remove unused struct 'cx2072x_eq_ctrl'

 sound/soc/codecs/cx2072x.c        | 5 -----
 sound/soc/codecs/lpass-rx-macro.c | 6 ------
 sound/soc/codecs/wm0010.c         | 8 --------
 3 files changed, 19 deletions(-)

-- 
2.45.1



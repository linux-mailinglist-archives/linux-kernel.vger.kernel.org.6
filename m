Return-Path: <linux-kernel+bounces-514804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDD8A35BDA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03700189015D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F5D261372;
	Fri, 14 Feb 2025 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I/EAPNtQ"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3844522F388
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 10:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739530266; cv=none; b=Zf1dua/S9Ktr/weE9+hSORRQvgqve/OMTOyNE2e3cJpPEx2fXpceMS/seXIfKHB3NOjFH68WuehFAxc0ArDJQPpSNRubLn5b+rVV+l8uIut3e/MOhKrTxVRKQ/ky76P+XXilPsmYF1VrxJNm4LQ3+ot96lmQklJh9x7wRlM0xOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739530266; c=relaxed/simple;
	bh=uOmdwsErYI2TXvFPdID0TlewhOZbmAK4WYQksi9Me8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oa4IoaWlzy3IwY84t4eEyypYSQmnxFDcvn0Kb4i3F89y1br0Gr7+ANZKsKlgXrlEYpNAm1Hg0j4zQt43JW5m9Y/thNjlqMxBIqVMcQJHrOIN6RGdp+eaXgifkGUZ2DWhjuJtvO67F3Yg8twffS5tbUOXDfFVciBTHns+Rlaqm/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I/EAPNtQ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab7ca64da5dso361304366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 02:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739530260; x=1740135060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iKrRYi2DcewiQ8UFnMsHdUIKuoHMXLq1gLMqIZNXnR4=;
        b=I/EAPNtQ3ZQuUbk3GSDv55zl+qgRzROIp+GBol8h9qQQvCKpL9aUdFAMiUgS4G2VpT
         LSkT9aFZG/k6qod1d85Z/rDLXU0l1m4lKgURKkMqgCQAko7/EoOA58VDB0hGS6I6iHga
         5s+AN9AWuiATV3IIzFKSrXiyIUxFv1AmKtGrVcMBWBJaeX08EwkIimetVm2g6+IBF+46
         FkxqZr0mL1wbRKmklUm5Csl0s1g88KBji8palCc1fj4Taxop8Ld9hoTbamDidpssmNoz
         pv5E002bXO8tV+jOYKg5hqnBURcfhoEn2FfPTFKu6qxr6zmIuCyvTVM3LYn5JU24wvbj
         HLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739530260; x=1740135060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iKrRYi2DcewiQ8UFnMsHdUIKuoHMXLq1gLMqIZNXnR4=;
        b=an4MapOY/pCEoGnEv3idRTtH7/XHhjL1OJmE5HwDXZBkWZgAoYn7B9b3wR8eEcloME
         5ymlXsQo/MWYWYqs6xeReQazU5J+yp/QTvIKP7Sg3hsJ7tI4rl233C3msLJR+PJH1BtV
         N+8NbVN3nQkmhKL6CVBroe0XEutja7ZibCgyqMpGAC7RfbmCxN2prpSuf5NBLsycOIbG
         EVR0T2tF3Tb3cO+F8IMPkeeTuh+pRrHlX00XuN9gpGhljwyDxq1lMIkABJiLgbZqBqKT
         2rL4eZ2TeAvQGP6Sg1R52jTpQ29SM5V+UD5YFlCSO3E+fV7TTep+S2C0C2OXXRIR7aUU
         uvzA==
X-Forwarded-Encrypted: i=1; AJvYcCV/d79zU8IDPrvO3aIF3hwbBQKt4eRBlXr9Ee6hsA1s9u6jYtgzyv6ZWDwtK6eOQXCX4jYYlIUsQAakBW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0sx6rUXJLpVwpW0TD/fYYan+uH1xnBYe8+Ra8fYJvDP7tBRV/
	pxqgXvCMThD2Kk39ejTV9dtVyAHCOPfp76pSygroqfBPM7J0kIOq41ILR0CYyneVfWm1CKpg+Rc
	Q
X-Gm-Gg: ASbGncv5OszSjStgbcQyD4A7R23CydOCXsl3dwXKXRqBhMqtUbloe+vBa3qoVUuTcJZ
	HbpqOfuYE3LbUHaZmC8vfns4zm86XpBHJev11mitQvjOgYZoqBDAZWHavMX5+hTltbOgZefPK70
	h9EP+Ggn7vl8ko/T20Z33VzXX3nMywfSXM59qLn4YylkZ9V2tADPH2jIzk6lzfJhp5GMudt6SHL
	TF0QM00jGcvFhbrm87rR7KDcC2+DU5fgwbBZo4CsFxF3u0nftqUxOcPPloxALv6KrhQkhyhCV8P
	wJm9UV+usWJgRVW5z5zj0iZMAzT3IbJegnw1ipw=
X-Google-Smtp-Source: AGHT+IF+nI8uaFR5F3xBn/U31UKTP0rILJYX53CQrzbkQArWkDkAxcpVmIkFW+KNudbG4M+h4swvsA==
X-Received: by 2002:a17:907:2d88:b0:ab7:b896:b80c with SMTP id a640c23a62f3a-aba50fa0b94mr511634166b.9.1739530260452;
        Fri, 14 Feb 2025 02:51:00 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532575b8sm314551266b.44.2025.02.14.02.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 02:51:00 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 0/1] MIPS: Fix idle VS timer enqueue
Date: Fri, 14 Feb 2025 11:50:46 +0100
Message-ID: <20250214105047.150835-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch aims to fix idle routine while the CPU receive an interrupt,
because __r4k_wait() only checks if TIF_NEED_RESCHED is set before 
going to sleep.
The same behavior has been changed in LoongArch [1].

Code (cross) compiled successfully and I manage to test it on a VM
emulating a malta board. I ran QEMU with:

qemu-system-mips64el -M malta -m 2G -kernel vmlinux -serial stdio -drive \
file=rootfs.ext2,format=raw -append "rootwait root=/dev/sda" -cpu 5Kc

rootfs generated using buildroot (malta default configuration).

- [1] https://github.com/chenhuacai/linux/commit/a8aa673ea46c03b3f62992ffa4ffe810ac84f6e3

Marco Crivellari (1):
  MIPS: Fix idle VS timer enqueue

 arch/mips/kernel/genex.S | 36 ++++++++++++++++++++----------------
 arch/mips/kernel/idle.c  |  1 -
 2 files changed, 20 insertions(+), 17 deletions(-)

-- 
2.48.1



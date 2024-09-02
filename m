Return-Path: <linux-kernel+bounces-310594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C9D967ECF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED0A1F21C30
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 05:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA47154433;
	Mon,  2 Sep 2024 05:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="yI2jV3VA"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63236195
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 05:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725255110; cv=none; b=Stti5G7nDsu+I6uivLnKza6Y+Jk67c4MdHofLtsDe8HcE2jlhKzaNfnxUB329Jvbbi78sVQI5nAPBqsxUwPf9OWq85xFPkODSK6jjgSi2YrrtER5q+1TluFOxGk4wqDb7BJq/o22jS+g0kl1gqQxqRhgVuEu/vDtqAMEPXQI/EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725255110; c=relaxed/simple;
	bh=p7pV+OekQRanLYGDkHAzPVIoQUeenJaMBzGXbvR4lNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BNQGIM2UfQO7JrnSueS6G9vnghQ3UXeWJkuGPw5tCcvMIxiAvYMakIe1GFxEu+R+p19BfyN3TuOGBdyxRA+8sJditNu+ACR0Z7HehB4uPBLCkuCLm0wFxsVO0ZlXzHGTUf6MzCpZ5RJWIWPDwaYpPmw3tuwJYOHQcbmMx3qOmZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=yI2jV3VA; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-70f6bb5630dso131067a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 22:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1725255107; x=1725859907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dcARxruAP0vzhVrIv4mZE+MUS7Q/ymIzQKM3BTvM2Fg=;
        b=yI2jV3VASmzs8rFu0R7i7/aVcG13SLaVSBX4ouMg0JZcVxlniLgP2QI20NdomGgINx
         yhNrERDM238EorFwfOhrojkbftDYOFHo9alsjzzYh1ddFzgqiztsyAcb9+xn4qMBmVCX
         dRYdpFvxsSrfmHaQ6hQxeGYw1CxmVX8Did31ejFfoi720lu6UFxuWcr7vlp5teGL/4UR
         QqjMz/0XrF/m93pdOv4J8UtHyiz7y9vycaCX/HnjS/j/u29XP8MB18oU7Rv6hMMjnrKE
         94jb2MzbTF7AkHrGPQQkH+admxyQZdij8kJJ46mMh62aQtXulTcXrDYSUQDAQO0rUs4y
         o8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725255107; x=1725859907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcARxruAP0vzhVrIv4mZE+MUS7Q/ymIzQKM3BTvM2Fg=;
        b=rexA2WC3FaxUyexLbZqhTvPern+1aAnl0iWRm7Ttx7lNCLitoxc+l6hpsISUzRwxFv
         Nu3kj2r8wyTxQakEjAOKtlCxCZIPFDRBP2/xePeT52O9/PWtdBBySoqQme48qCjaNNlp
         vRv5bYbG6I691o0Y6lKbxFNCVm9d1up/gFHq+8BQvFxmENt6WZ8rqCz8f2VPObqU1M9m
         UW0qWQcdAtI0i3pDXtacEBYyhm6TuZTjZJdvpKs5s/HSPTr1otw4WqmHjikiS8j1vSd4
         v5M3y6Ldt5MPvVafJUoVloAbnHmekgS2iEJgzJYuMUuk6MMGFHrhNvEMua9MQ9ya73r+
         kvoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1VHsOl1m5+xlNdN2Tpm8ozrCHvbYL96BPTiC2ndWQPTi3smk9bVSbWWfTbclyr38OzP0CmTFrHz8oc1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1rxK8Efb3keJJgV6mlqSXRG8qGf95gOT38O9VXOK0J2HWSzSW
	zwTTwPgdUBPizG8TQ4e/UWgf1mgmFH+cG70siLN1C5H2yauvdlla6d2acnBZZ+0=
X-Google-Smtp-Source: AGHT+IG4O9VSEnbCHyMlef62PC66eJmk+Wcfg7k+VoUwjggysZcp2Zp81AWYRWJzYn+qz65dfh/WPA==
X-Received: by 2002:a05:6871:b09:b0:26c:78ce:b0cc with SMTP id 586e51a60fabf-277b0dd215bmr5158894fac.8.1725255107434;
        Sun, 01 Sep 2024 22:31:47 -0700 (PDT)
Received: from telecaster.hsd1.wa.comcast.net ([2601:602:8980:9170::901f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a692fsm6076279b3a.60.2024.09.01.22.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 22:31:46 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-um@lists.infradead.org,
	kernel-team@fb.com
Subject: [PATCH 0/2] mm: make copy_to_kernel_nofault() not fault on user addresses
Date: Sun,  1 Sep 2024 22:31:27 -0700
Message-ID: <cover.1725223574.git.osandov@fb.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

Hi,

I hit a case where copy_to_kernel_nofault() will fault (lol): if the
destination address is in userspace and x86 Supervisor Mode Access
Prevention is enabled. Patch 2 has the details and the fix. Patch 1
renames a helper function so that its use in patch 2 makes more sense.
If the rename is too intrusive, I can drop it.

Thanks,
Omar

Omar Sandoval (2):
  mm: rename copy_from_kernel_nofault_allowed() to
    copy_kernel_nofault_allowed()
  mm: make copy_to_kernel_nofault() not fault on user addresses

 arch/arm/mm/fault.c         |  2 +-
 arch/loongarch/mm/maccess.c |  2 +-
 arch/mips/mm/maccess.c      |  2 +-
 arch/parisc/lib/memcpy.c    |  2 +-
 arch/powerpc/mm/maccess.c   |  2 +-
 arch/um/kernel/maccess.c    |  2 +-
 arch/x86/mm/maccess.c       |  4 ++--
 include/linux/uaccess.h     |  2 +-
 mm/maccess.c                | 10 ++++++----
 9 files changed, 15 insertions(+), 13 deletions(-)

-- 
2.46.0



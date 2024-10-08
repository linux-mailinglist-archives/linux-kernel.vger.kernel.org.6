Return-Path: <linux-kernel+bounces-355454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13517995271
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443CC1C25828
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC5A1E0488;
	Tue,  8 Oct 2024 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MigGLMnW"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A0C1DFD1
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399136; cv=none; b=g0YXVi0ktnJ9uQyDAPiQgin5ZooPizaFTahcBHNSetLblsQqMnW7wxgb6Htr2WbXEEAPJD3FxsbVcLiFXprTFRHwj93VGy8Gleo8+ptZTlruw1ee497WtrsyQIPpkJ2KtNj9gQCQ0pz/tbJSqeMpwSeIDHUqu3TDb/E72n32DN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399136; c=relaxed/simple;
	bh=Zn5Lg4NhSvGrhq3IQewNEP54T8jNklAcWLlaRE/1F9A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MPVo7ezpAfUqDQln9hEGGZwJU0j1AV1ZjQQ6v19odwW3RRqQ7WRFCK9tzI+Wgl2MLk8cjT0kyW1htHEsFDwdrF/RyrvwumIS/i/KjBalFPHbSFUJGlWauFpaB77i62TQeFe9TDRz+TivVjvbeTXnCzK0vATTOSs66668V/0S46A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MigGLMnW; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-710da8668b3so2356255a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 07:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728399134; x=1729003934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xUyhXq0XNpQ1vRtn0GLY0jKRlrx865fpEqPXy7ajtC4=;
        b=MigGLMnWCc/8+YabSFhuYBgEwD14/UQVNvTTS9/KilzyKClGKIpPMPDVhb1wGAiLUe
         eTAM7RkXKVGGg0N7K/EOuSZ/l/2tkZyAqpuxpEfE+4qh6dM6PkXyJCn5Jyuxm/ZtL+DV
         bsBiv0oNx+t+ZnC0QE5noe8xhrLnyNvsbRvb5lNfe8l3Xp8Qd1wesjKJXw+4EUr9/Pll
         zBRA8kte0SZ+cr+MsHS1SpeOEVvhTEYW3vDdqDOUjjAF9TufW/yX2vfIxk1uSfhNBlc7
         KQ23Ymn+eeAK/+emBseWb0AuJq2tDOp8xpX6vdvzkc9D0i0uLi9JNkD6dOX+dCqEAQJb
         nxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728399134; x=1729003934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xUyhXq0XNpQ1vRtn0GLY0jKRlrx865fpEqPXy7ajtC4=;
        b=Be799V47XKhYcEbXG9V0CaU9PmdlU6fmDIY28taDRQqXS01mWTs0SDGW76WP4SerIz
         p01oRQxuPBi639bxYazUZbdJLAX+6DZ3hh7UjfN1Pe44eVNduq2VidrvqtQkGG1kkTgu
         s8FgJkJ6rlGQl9T/QJg6FapThcCOwCRu75iUD4u4xxVHooUh3MUIYfbxOgHCaEvSBc1X
         WSY8lI1WbOFBkmTVQR8T3UPPMZFPwl1V64kViRGeQ/ykE2EGQV8EMUhyCrhUJjIhLJ5+
         Mh8AVbGd+sJWSJKJj1lR/82NNnrZUFv/VyIpiW1FiDXl5GSdnVXn/zkyRWJi2K9sev9V
         ok5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9LRMGfGPIa6iWtdn/4LRYqwRCRQuiTmMnAIjQNM3NPr2ALc+WFcTnFm9UCP+sw3+0bXHe0iV3FttZhNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRjcn06cuK2wbf7BgwuhAKC0UXCEz0XRvIucnQdcKo2pXJPegJ
	g1DgNbaEFwgpuL11UgCcZ2K2TC9qmDJv1ocd+Xdgyoe7CXk7wPVL
X-Google-Smtp-Source: AGHT+IEkXbnGd0K9vpnQ3q25JVRnOSg43qf6tJeJGStyswbMqU+pptDh76yBoZwTlOKjBsOHGzfg7w==
X-Received: by 2002:a05:6830:926:b0:710:f300:9fad with SMTP id 46e09a7af769-7154e97cb9fmr11998102a34.30.1728399134027;
        Tue, 08 Oct 2024 07:52:14 -0700 (PDT)
Received: from Kuchus.. ([115.96.37.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c4cdfdsm6870944a12.87.2024.10.08.07.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:52:13 -0700 (PDT)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	perezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH] Fix typo in vringh_test.c
Date: Tue,  8 Oct 2024 20:22:04 +0530
Message-Id: <20241008145204.478749-1-cvam0000@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Corrected minor typo in tools/virtio/vringh_test.c:
- Fixed "retreives" to "retrieves"

Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
---
 tools/virtio/vringh_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index 43d3a6aa1dcf..b9591223437a 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -519,7 +519,7 @@ int main(int argc, char *argv[])
 		errx(1, "virtqueue_add_sgs: %i", err);
 	__kmalloc_fake = NULL;
 
-	/* Host retreives it. */
+	/* Host retrieves it. */
 	vringh_iov_init(&riov, host_riov, ARRAY_SIZE(host_riov));
 	vringh_iov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
 
-- 
2.34.1



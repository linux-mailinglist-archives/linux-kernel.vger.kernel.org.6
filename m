Return-Path: <linux-kernel+bounces-521664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DC1A3C07E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8328A18913B0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D010D1EB197;
	Wed, 19 Feb 2025 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZY6tDS7x"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2ED199E80
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972987; cv=none; b=ALTOXbUpM9qPmzNK5e6Cf0x7Sr9rzjFw6kp5SpHQBjy+g70Jy9yoYU0IOPX3iqqedvxqKReJdNY0D6h20lyqOdncPBALRWH9IAzv1tZKP7/abz9Qql+A3KUfdtXXOtueWvUTBcnG4iP4fsolvZU+AEudUk57AeBuj07g5SRkJAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972987; c=relaxed/simple;
	bh=ozAI7jPkN+E+ln8TQn9XKg6f9kSqAye64Nz9Y0rCWKI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tl6Siig1yba4XMrYqzupLVyL4uCxjhlXETlwHAltHDo5iX55y0XCEQ87ThFAGXjkO9f21YZ1rGt5dUjD8sJZz7e3IAQDxjip3InathFAQWlSqNF3FNDLbBN8DqwRvzo18vf3DtFuUzWOFDBxl6koF9y4E8VrDEDDMezpbUDgp44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZY6tDS7x; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abb7520028bso559516866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 05:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739972983; x=1740577783; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kH0pAU2X6UA0aC7rynWRidtqvLm/P00AqNLgxfvX0o8=;
        b=ZY6tDS7xi0FEYdG86plch0lnsA4kaPxA1ei+LFFXqVJSYhA7iYK8iftEy+jvPEroD+
         T8FI54dHGxr6BIS00f8DUS/RcAFnLlwGWS93Y8aq0DHT1uFzt1Ivm78gSWrg23gJ9NGs
         lWBYTvetmdZN3b1h+t2y2bu5ul5RPXumb5Twg3A0qh4LLvFCuo3PLgbEzc9em8YgOeQ+
         DgZ0lhAAypYCUYjXx++yIqP0r9hKcKorXol+kCrMcTmptFCgAW1O5JXK9jkOjYASgb1k
         Z5WxN4j1IcZQN17kudb/d8lzd01PL3HGyMK6lfsH4wZsEHoZJMLMMeWYujG9v6mk0fzp
         ei4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739972983; x=1740577783;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kH0pAU2X6UA0aC7rynWRidtqvLm/P00AqNLgxfvX0o8=;
        b=oBz+bGxbmn2IplXiO6d3TZI0MB5cnNiclVYX8JuZARkWyndYyKNYrDlLR1/y+Qxe7D
         qFf2mTEy1+4m/eGr77+9/Heo3GMMPSrF84jx/m/iiYHoa8xdPkdiOULFwJ5OinuDfLb+
         zzDMADLVIFpzEuyetSgyO8dTPYzyWLf52irATalGuAgqaQEqTCwTtoLpcp8rylbvC9pr
         doAvERTuZooZyi3Y6fMGQ3+oK6hL8qobmv9JtFfcsRlgrKQWjJiPObFM5cRHXGXGIGbX
         m9Om+xce0mMgPQlHn9yi6AUtSpaDb15KqMmQ6sYrWJl7zpCC7x4Xij7UJY3xiMcBbjg0
         Ii3A==
X-Forwarded-Encrypted: i=1; AJvYcCW+G8V5pefqc0FgYCadSwMUUjp2lH941WTL4lno4JB6idXePM334Nkpmkxhm0EeGEOyWYR5jegGPiZuDag=@vger.kernel.org
X-Gm-Message-State: AOJu0YznvlLtoxiND1jVptf4y7XR0m52wBG/inFaAG/o6VkKiGff9ZHN
	7zHlJrsoNGU2CHqgrnqDWdpT0PSKmg8C5MrBfa1D6Jra9HErxGRrAjbk6DVgWfI=
X-Gm-Gg: ASbGncs53WlLKLqA7nRsghzZyQEE3sevSy8Yk6mEkz2J0HFAjd8Nr0LGcWkyEcgcNsk
	tvrm69M1A4DLYJpwTbd3zrDZZKMA/Gv7CR36Xx1X3Q0EspR8dwK/yM0dqfg+QYRGEn4N7BLI4oI
	elOuNPMsdExYC8Huk3RSpHRrEglrL7D0l4y2Kj/QD3rMnEgmXWoDUDnzVlGQsmZYwdV50z2yUb7
	p8J4wSaZ5i+bDE7MEXAhTArr84WuPGw4s5KNCTqZW0yMWLlj84tNY4BQ4+0JIR0Pj6/T/ZBm+tn
	0Ua4LoSKav5YbbwUc8Xu
X-Google-Smtp-Source: AGHT+IEh++Dcbz3VxYv3Ivg8FCqcPYBovAh++mRW2ZFn7DD63wkwuldCqvj/jtkuwogNSm04zdgAcQ==
X-Received: by 2002:a17:907:2d93:b0:abb:b36e:5350 with SMTP id a640c23a62f3a-abbcd059da6mr292239766b.44.1739972983435;
        Wed, 19 Feb 2025 05:49:43 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abbdac1015dsm117494966b.127.2025.02.19.05.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 05:49:43 -0800 (PST)
Date: Wed, 19 Feb 2025 16:49:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jim Qu <Jim.Qu@amd.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Takashi Iwai <tiwai@suse.de>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Su Hui <suhui@nfschina.com>
Subject: [PATCH] vgaswitcheroo: Fix error checking in
 vga_switcheroo_register_audio_client()
Message-ID: <ae24cd32-1e78-4656-b983-051ed22d86b9@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "id" variable is an enum and in this context it's treated as an
unsigned int so the error handling can never trigger.  The
->get_client_id() functions do not currently return any errors but
I imagine that if they did, then the intention was to return
VGA_SWITCHEROO_UNKNOWN_ID on error.  Let's check for both negatives
and UNKNOWN_ID so we'll catch it either way.

Reported-by: Su Hui <suhui@nfschina.com>
Closes: https://lore.kernel.org/all/20231026021056.850680-1-suhui@nfschina.com/
Fixes: 4aaf448fa975 ("vga_switcheroo: set audio client id according to bound GPU id")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/vga/vga_switcheroo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
index 18f2c92beff8..216fb208eb31 100644
--- a/drivers/gpu/vga/vga_switcheroo.c
+++ b/drivers/gpu/vga/vga_switcheroo.c
@@ -375,7 +375,7 @@ int vga_switcheroo_register_audio_client(struct pci_dev *pdev,
 	mutex_lock(&vgasr_mutex);
 	if (vgasr_priv.active) {
 		id = vgasr_priv.handler->get_client_id(vga_dev);
-		if (id < 0) {
+		if ((int)id < 0 || id == VGA_SWITCHEROO_UNKNOWN_ID) {
 			mutex_unlock(&vgasr_mutex);
 			return -EINVAL;
 		}
-- 
2.47.2



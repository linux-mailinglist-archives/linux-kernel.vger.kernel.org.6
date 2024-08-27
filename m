Return-Path: <linux-kernel+bounces-303421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED92A960BE1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C64C1C231D9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F961C6896;
	Tue, 27 Aug 2024 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwcVInE/"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632E11C4EC4;
	Tue, 27 Aug 2024 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764947; cv=none; b=aOS/pUpoZvL+weYstCY9dcUtVXo6HsPFDJIulqVcd8Sle8cYKOWzB9k8EpN4fdooRYOUPD+Q7rsCaO8CYh7sDrVll9dPnxpn+6/Yk9CsyEZ2e4wyiw+Mit5sdyr2si2HQf2h5zqmBOxYjVoZMVUqocNRqvz0nNjPovo01Bl8hPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764947; c=relaxed/simple;
	bh=jevClh7SX6c+0UntZFDuVWLR45LYjLq01uWzGw1xEjY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KqH1EVs8BVGYYN2x/kwKYMrGigVCOp70W2UUSCfSJOx2ouhTYh/0giKrkZEC+OUvfPrmCISNOxBXqXCv4dSk9/po64EKD+sDX65/j8bBb5cFDrpfmJ/gI9iypa2pE3LGNXZlFv/dIkZGatUnn8H3jNdbvTXUE1UZao8QRWZmEEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwcVInE/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-202089e57d8so34889785ad.0;
        Tue, 27 Aug 2024 06:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724764944; x=1725369744; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JJL+N2eLmHLpakG2qqkvm53peIMy90DFUbIm7rn1WZo=;
        b=DwcVInE/B1z/6Kzxp3XnsxyyyHKByyM29D5xcelGKgXHED8enkg+X9kPvmWjzoCNsJ
         7o1XMDj9dTUG1ywHGgYK6TLNpB83BWA+RB1aoj9G9co+yERV6GSvULvamnyncFHNESz4
         pc3X6zEB46iVhP6Wv1Oq9Ul08Gprd1fpsn4VK14ul4LD2USb6Ar9oHfc0hz4CSxrq8ix
         DGNsmURPX6iaTXNVd7yVFaLOXbhz5xZVPrELzNw0paZIEjlpLJDUdr/WXC7KiFDSNp8k
         SWsAbURXOKkTWHGRA4qIcSFJl40BKdxQvDkSvv5qxumRIYxdL9aHmxxESLuZdgSs3jSZ
         ksiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724764944; x=1725369744;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJL+N2eLmHLpakG2qqkvm53peIMy90DFUbIm7rn1WZo=;
        b=vTwi3SDKtOAGgoup1PTcttuP6G09TKIi4j6RakK04lkHgwy/+NPe18IK+OfAUkEfX/
         vLk2FZvuOwWTZnWceRFkhcuf/EF9q/b+dcT5jTW8x8FPPYqSmGNDJpaFSKVqZN2TeGik
         7ewNjVasKCcmB5WhOexchwDyags+mlzd1IGxvXnkravhvQC7WZj3FwcGgrjhexgaNYE/
         MHk1XQPlYQXQeBFxo2C8GXFjH9I0CDbPhgDeWSCWy3xJu7pkXWS8FjZKwgmlipgxmabA
         6DL/7ihREdUHMBCQKq7PLoFgTUAXmWmMcaqdRJcJ/4ONqCo2/yLp4IIhRuy0E2dxhyWE
         yqkA==
X-Forwarded-Encrypted: i=1; AJvYcCU52OIbiFpQZkn77m296i9w53avZ09VRza+euoIQFZdGzFPpXyO+002wxO19IIKUvbWEB+Pj7pyHWY=@vger.kernel.org, AJvYcCVkOPgVqDUr2e2RrkdNVj6W5404m3oJdhLldGLOGSClSW+yK4WGunYbTBI/PyB4iZeKsfWZt+UlKNL+F0U0@vger.kernel.org
X-Gm-Message-State: AOJu0YxGO25tzrMV4nCAyrhbRd0AkIlyiq5vMdBUSFq+hpHJwrs8qje2
	v6mNVtnEXImq33P8VFvm/25lCn27Xf/2PTWo4P3NMpmg4TaVrZz1XH216syT
X-Google-Smtp-Source: AGHT+IH+gjePti/vhbU2OR07ibez0x8aiGAtC2+64qUjwk4+KfdD0ZNR/xV8p1UvVbBfp3B9hJPAuw==
X-Received: by 2002:a17:902:ce8e:b0:202:4363:b5a9 with SMTP id d9443c01a7336-204dddc4697mr47329445ad.21.1724764944480;
        Tue, 27 Aug 2024 06:22:24 -0700 (PDT)
Received: from localhost ([115.96.151.110])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9acdb54asm9320063a12.42.2024.08.27.06.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 06:22:24 -0700 (PDT)
Date: Tue, 27 Aug 2024 18:48:52 +0530
From: Aryabhatta Dey <aryabhattadey35@gmail.com>
To: liviu.dudau@arm.com, airlied@gmail.com, daniel@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, corbet@lwn.net, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/gpu: Fix typo in
 Documentation/gpu/komeda-kms.rst
Message-ID: <l5wzytcamcc43eadaquqbrfqilq6ajfnnseh37c77eceamtw35@hhtdipi4h22c>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Change 'indenpendently' to 'independently'.

Signed-off-by: Aryabhatta Dey <aryabhattadey35@gmail.com>
---
 Documentation/gpu/komeda-kms.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/komeda-kms.rst b/Documentation/gpu/komeda-kms.rst
index 633a016563ae..eaea40eb725b 100644
--- a/Documentation/gpu/komeda-kms.rst
+++ b/Documentation/gpu/komeda-kms.rst
@@ -86,7 +86,7 @@ types of working mode:
 -   Single display mode
     Two pipelines work together to drive only one display output.
 
-    On this mode, pipeline_B doesn't work indenpendently, but outputs its
+    On this mode, pipeline_B doesn't work independently, but outputs its
     composition result into pipeline_A, and its pixel timing also derived from
     pipeline_A.timing_ctrlr. The pipeline_B works just like a "slave" of
     pipeline_A(master)
-- 
2.46.0



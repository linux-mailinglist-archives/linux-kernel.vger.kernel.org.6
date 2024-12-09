Return-Path: <linux-kernel+bounces-437102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DEB9E8F2E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E451885F3C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A3C216E1A;
	Mon,  9 Dec 2024 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TKugvTDf"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAAD21660E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737777; cv=none; b=V0NnNOwRXMp08OmkmlPYiBdS9cs/8fXptQCU+unPZObYDpxQH2G+j6Piq2XAvhpkEbF9gUsfMjU5vFYqmYqt9j70MHD6iAt7XDtDrfrFFXKxz+iWtihoCGpxIrFhk7KPLTI3AJXd+30eSjUlDJ7c+Dm5IvcJkfX5iDhA2bSvTnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737777; c=relaxed/simple;
	bh=gvzytYw4sbSQU/ATlBNgaGw+c3UqmAd600g9QF+80xI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtAiRpevVR7x7SpSV4wmaskHaAnvW4q+/yFgzKN61Fsr3y3BDrOFhX817rzzQAinSxvxREVakQraqq10jdHIvsxXiYdCgvv88zIHBLMugpZ6WVRfmTVv2MzFzoq+yKvv3q6Ki4gc967idG0bEbxGQS3kdlcHX3Gm2nxJZGR33FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TKugvTDf; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4667931f14bso68191731cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 01:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733737774; x=1734342574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3Tsa9g564W559Vpb/AnoUfrIQ3XajXQIt2s3wRsgwk=;
        b=TKugvTDfoBjOS6n5X6dlr8+LRrTGoK+Bdp0iBq1DSpt/J9guRKpqF+/duZEsnGtn7S
         46zDbcnV4SGVVXJqbNgkpj/lIEKZFS8lujrYx3TLBr3+BVcx7GA1Mx3dvN1gInwBl13Y
         YRRzQmjmRArCK33HI5ijbNz5UX9mEXAqohZH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733737774; x=1734342574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3Tsa9g564W559Vpb/AnoUfrIQ3XajXQIt2s3wRsgwk=;
        b=ap0T1UHjydr9UGiRFjlQ4SOtLiYDBruO3JTkW8FrA2lIGFaVSwL16kd3Yfutw4upDX
         ads4r+BXdlpSwcPgMVKkO8+TF30WQyN/pj2VPhHwpBYb3ZWumTkjYhRDeDpmR7OaGnra
         wGKP48vN2e4oaTEwg5zi2yl7kdBo77ghjNUSbNy6J4YRVwl6mC8eDFMmnyMyV5AS94Qh
         tzp56FvNVpPXOYG71kVBLilf9d5aZJhQahy74huraZWgzrWL6olSEdcK/C7UJ3Nycdob
         YbsQ2/dPxkXPEv5R8EnQ0ig0mZZD4dv3X3RhPdUwBSJ22JaQTKFqrKIRR/7KnfRcECPl
         iw9w==
X-Forwarded-Encrypted: i=1; AJvYcCUB2oeYXDLtRYTx1dJqGY3aXAlxTAf4K+VV1zXImRxKlH0YTVGPgj7VDWHlKiybEZP4tMiRrzoPQBS+i4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKHAsLLHdWBnvy7GDaiXWABvdpvaOFqe+4i0dZYCZSWcbGXjX/
	W7CV8io53xhwT8nQrrptDeNXHPiPueG0BMEP91uSXDDOGem6TO7otinl2v+hzg==
X-Gm-Gg: ASbGncv5g2y8bvCDKitks68UpAJIK7phskNO2khmmdYHVgd0gXblsZbanYSqjrrF7xK
	PnQLeJhwuLmH+e2ubT8beFnu6AELkwFhCTwmKliIF6IX28foklfYoFaH6LA+e1eKmkrMIPFwsiR
	Gg1YT0NUQexX1TRRgggXZj9s/Vxowm4xxuWNki1GTjan95r7I/FGvZyjGXyuiYXKoHMsgjON1GR
	FGWD3H8bWfYArugHXCXTBYh7jfct9NrKIAz3wVxb4u+kQQ7Cyi9TESZSnlArN5jebboW21Qnnqq
	Nfw=
X-Google-Smtp-Source: AGHT+IGmY9glarrXNarZaAo9mWvdbYU7LPRt4v3eMj8NpeG7c1QvpqnB5GcbMm9FjHW0BzZ2wvAZkA==
X-Received: by 2002:a05:622a:15c9:b0:466:9938:91f3 with SMTP id d75a77b69052e-46734ee9e07mr201445901cf.49.1733737774204;
        Mon, 09 Dec 2024 01:49:34 -0800 (PST)
Received: from photon-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6d2147ff2sm128409085a.70.2024.12.09.01.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 01:49:33 -0800 (PST)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: zack.rusin@broadcom.com,
	thomas.hellstrom@linux.intel.com,
	christian.koenig@amd.com,
	ray.huang@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Ye Li <ye.li@broadcom.com>
Subject: [PATCH v6.1.y 2/2] drm/ttm: Print the memory decryption status just once
Date: Mon,  9 Dec 2024 09:49:04 +0000
Message-Id: <20241209094904.2547579-3-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.39.4
In-Reply-To: <20241209094904.2547579-1-ajay.kaher@broadcom.com>
References: <20241209094904.2547579-1-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Zack Rusin <zack.rusin@broadcom.com>

commit 27906e5d78248b19bcdfdae72049338c828897bb upstream.

Stop printing the TT memory decryption status info each time tt is created
and instead print it just once.

Reduces the spam in the system logs when running guests with SEV enabled.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Fixes: 71ce046327cf ("drm/ttm: Make sure the mapped tt pages are decrypted when needed")
Reviewed-by: Christian König <christian.koenig@amd.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: <stable@vger.kernel.org> # v5.14+
Link: https://patchwork.freedesktop.org/patch/msgid/20240408155605.1398631-1-zack.rusin@broadcom.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ye Li <ye.li@broadcom.com>
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 drivers/gpu/drm/ttm/ttm_tt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index 91e1797..d3190aa 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -90,7 +90,7 @@ int ttm_tt_create(struct ttm_buffer_object *bo, bool zero_alloc)
 	 */
 	if (bdev->pool.use_dma_alloc && cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
 		page_flags |= TTM_TT_FLAG_DECRYPTED;
-		drm_info(ddev, "TT memory decryption enabled.");
+		drm_info_once(ddev, "TT memory decryption enabled.");
 	}
 
 	bo->ttm = bdev->funcs->ttm_tt_create(bo, page_flags);
-- 
2.39.4



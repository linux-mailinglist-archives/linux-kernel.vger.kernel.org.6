Return-Path: <linux-kernel+bounces-269681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEF29435BA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57780285441
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1FD4879B;
	Wed, 31 Jul 2024 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lr7PoKy5"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4881EB3E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722451270; cv=none; b=F5tObiLR9VIpLSb2tV/9vPNpiiONUU6QAQ86IaJ6elrJHqmm98ZDwynr9/8MY+KliBdD6YibRwzjn+hfJKL0VsyXd7aIQrAV0+tasuw+7/5wswNfsIPaQatbGgiQ46XaEKfDfjHofcuI9t3ZUGi1HGJ748Iu423r9jtPElC5Lko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722451270; c=relaxed/simple;
	bh=ejlOJPrp2crlSFtJEskJcC0aiB/3FVJNEbuBxhvYngU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o5sKPrB3AlFgD0kpKjgxXUYIl8wUrMq2RwN8UPu80nuIbpyvYd9/yBUOtNNx8ZAcTa51knWjbD425ICyOpaZ4sv1J2xnUaYMUo2Vb0d3zjva3G2DoXZc+C3RtlgcOx+TCRlo5qrTizehp5b2xTzDVlnNU49nOMnNZp1FR02QeNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lr7PoKy5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc6a017abdso39564805ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 11:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722451268; x=1723056068; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mpmYPpOfmOLGgfXJ6vIlx4qsCIVjVavSG32HJaBlDTM=;
        b=lr7PoKy5jVMPvcYXDuIdwKEgJ83XixmAv30pXYqAl63+Xv21dz5EEVv6sOcytTrmat
         qk4FDxq8zfLqcyw578PcQqcheNyRNdG1oy4g5PcrfVaCS95P94yKsn6t7VO/SP8BH2Hj
         MuG6VlM7hLw7145Sa3LBidENLd1ZeQ51Pg2IRDVP+tBxloQVXdsMDKpBphthjPPEQQvj
         K03+4NoNsdqrRAH3gfLUdwh1+AclFpkQz0h9IBCAzUv6e4lTG2UbU2jpEmaL5Hq4PjJt
         cFpNBu7jS3hG4mocgpQ5k6lr8UCnp05ldPuJTl37Chv7Vo2YuWKpTH368Gc6QFx47DRy
         JTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722451268; x=1723056068;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mpmYPpOfmOLGgfXJ6vIlx4qsCIVjVavSG32HJaBlDTM=;
        b=wC8FaDrlC0MktHYziBDMC6+wqKa2etjKF6LtdytRCiGdzs3ZKfpGNMurT3YHNDlMUx
         T+IBggr+OsfZ4fFJsB40oqW7VXWimkZ60aMDHA0nG20Q2AhP4M4WxvjdEDxYV0pWMYya
         5D7Xjoelfxz11dB2qDYsNNe3+1HUqVu5+27/Y4qQI4g272h0jAUvBu9F+C6fAt9/Vj/+
         2zHdIQgPteBbX1UZ4OenKAynNoNyVDvq6SUwEtUJSXSrbfb3sFVIiN6AUHv44viA/tBY
         UIvbE41Wfh7zDtN5AHLLrKry/22ojBzr+GD45tI8nEgNoMnh3ZqL827HI6fDqJrf4OGn
         jI+g==
X-Gm-Message-State: AOJu0Yw4FmCubGgHOccJwmhmTC0KNR73wvd34xB6AYW94zXejgx+fzf8
	xBwOW2ZovVmZaFCYC2u3ONgGEo9OCn7hlS8c/hp13b1xRXOhU2okOs4y3PpB
X-Google-Smtp-Source: AGHT+IHmk1Y/30Hc0fWJpjuWTr5hCl0kXHsmHZtHdMEQxsBiik4OXWHD3ns0MzPqBtwKqTWcI0IIIQ==
X-Received: by 2002:a17:903:22d1:b0:1fb:68a2:a948 with SMTP id d9443c01a7336-1ff4ce8a9famr3038605ad.15.1722451267756;
        Wed, 31 Jul 2024 11:41:07 -0700 (PDT)
Received: from Emma ([2401:4900:1c21:dad1:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f9fb5dsm123888945ad.251.2024.07.31.11.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 11:41:07 -0700 (PDT)
Date: Wed, 31 Jul 2024 18:41:04 +0000
From: Karan Sanghavi <karansanghvi98@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Karan Sanghavi <karansanghvi98@gmail.com>
Subject: [PATCH]  Documentation: ABI: Fixed Typo error
Message-ID: <ZqqFQI95tBp-juK8@Emma>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Corrected the typographical of the word  "firmware"
in the below  mentioned sentence.

Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index fff2581b8..bbf6de5a4 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -224,7 +224,7 @@ Description:
 		decoding a Host Physical Address range. Note that this number
 		may be elevated without any regionX objects active or even
 		enumerated, as this may be due to decoders established by
-		platform firwmare or a previous kernel (kexec).
+		platform firmware or a previous kernel (kexec).
 
 
 What:		/sys/bus/cxl/devices/decoderX.Y
-- 
2.43.0



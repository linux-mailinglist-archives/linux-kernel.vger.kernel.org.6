Return-Path: <linux-kernel+bounces-547180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB31A503E2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F267A5669
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83264250BE7;
	Wed,  5 Mar 2025 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rFCUIxZj"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C5B2505C2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190014; cv=none; b=W9XqNpdSuix4VMDGwQbXvfoVf3OaeNCEG9qloN6BezFfer4iZuLSiUJ1fuvMMBQF4T3RroJkIjzvH7xRm6A2d+dURdPkYqb5jUJS2XuVUeS9CxFk39EwBSO1UVwvgB42Oecve5J0f8u8yay2HW4ScMj5B1WHfJXza66EtJ1ErqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190014; c=relaxed/simple;
	bh=7pugq9Q0HrD0WFy5Cy7xHVcUHRDsYuQl+Ilp5KZtAgE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NW4x6NXQtFW3NmomXKjIRXPAFYi2HApXXUdT2YBErmWX3YG2lhah0sDQX5AP1NS365k53OT0mKt730bBvo5Sa6XJFpKeN7+ioxzYaEISY4uS0a/xLHzerr5ZYBf88wtjPJte9g4BZ/wcwv6241wdhuXXF5mN7cpYssFx6rd2rDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rFCUIxZj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43bbc8b7c65so40344575e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 07:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741190009; x=1741794809; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=95chebkxx5uPpuk8Hf/uN1bb/WBC6Ds7j8DqJcXx7/c=;
        b=rFCUIxZjwzGncw+CJ8ac0yOnBxwosI+HlPG4hdlWTffVVOJ2Y9HKgp/qgGnFUDUwRE
         CB8w+WHFjdGDAJoXgep8bFA0Yw40X8jbbjQ0+SVzMn9MaQ8WVSwEW9CwUCTKvIgvFHsl
         7Wxc7WCH80enkOsVwm1RJ8Q8eL8OlvDMReiHYr14RfWCZb+IJGZbaHx7NMO5fC4LbnSk
         o2gLZrHAS00uk2UHuhlfhBazO4AjzZHswfxQW39OQhLhNScoVY3ruSNJ2byJGN/I4W95
         Pv4+KPOnBjRmw8cjxm5JWY+MaYe5RuBkXVHnpLJUJdphZqzG+e1tLK0PjY3ASL5h6oMO
         pbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741190009; x=1741794809;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95chebkxx5uPpuk8Hf/uN1bb/WBC6Ds7j8DqJcXx7/c=;
        b=JHpQAQWmyWFFPrsh/oq+L3cZJVCdfQxaOGSTKF3UjFjZX3tILztVeimILsbNoUniWo
         u9G/04lthi7oOMR8TiO8G4FjBvNIq0eVgseazKUMgZ8iRPrgPqL5JR8fVEvf83pysGMp
         yFAe99WVKbU6Fc6m+r/WkSe/q6t67bPVF0uYfuVrAEQ+CTB7Xl3If4HXCMstaSOLguGs
         7hf8Ny9TkF/RzqwJr5iDJPvpbgjz2cHnfsmEDFm/I3phhV6pbEa3STundmWLqg1/HjvC
         hFlTB0mvfjANiUmA4RZLEstcXa5Njz1HS2IghY2kq/oHJ+zzu/hqktNGLT3RDsmKPxY0
         UK4g==
X-Forwarded-Encrypted: i=1; AJvYcCVkzR76s9DHzuOMjW/jkUNKSdiQrKdY0bldm2e1mnc/URrIrGmsLkxu/3pHeI4R4P/2cdqJrD5LufzpOoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG06Pu+BnVoQxyHsBQQrlHjCYLi+N5w3HR5qtbJh4FeSaQYKy6
	GGD1/mY5FoIkfV15pNPVkBf6QGLDJQrQe2nJQBLmpmnGZ7gNpVhzUHz5zA0FuMA=
X-Gm-Gg: ASbGncvsqsNFRsetrSE922LDLgrMpEySsd4uCfKzcjUEO3vdRBUiplhCKIwX7VvBt0E
	cH0+0d4QHuYStz+mleh3/LPklxLMLaEZH4JjTZw9hh1ENnLDmS4Wew7Bu033fGVAEGMfLAG1iRs
	3JoPl2wgEtaPfy/Rd6loIsg1qzAyj7V96fBZE+WAiomHhPDeDnnS9NyLHxBgf0OkmKtoomue3Se
	BzTWy1SGoKsXHZTwtTqgQts7QcfrfJchnFu2BT8GrdDpNAa1xir9FFvmp6m3p2qoh8RYjY0yC35
	AkPswhbr65gLaInIjTexEsGUIIQkBzpFtjq4xRU0Te729HR9oQ==
X-Google-Smtp-Source: AGHT+IG46qG9NZg5asWLlzpx5UNbKVYGM9zYolGfR5W2sKaY9Lf5cmP+PeNKMAFOBaBivIz2363Meg==
X-Received: by 2002:a05:600c:198f:b0:439:9ee1:86bf with SMTP id 5b1f17b1804b1-43bd294309bmr36486625e9.7.1741190009583;
        Wed, 05 Mar 2025 07:53:29 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bd4291ffbsm21180345e9.15.2025.03.05.07.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:53:29 -0800 (PST)
Date: Wed, 5 Mar 2025 18:53:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Cc: Carl Vanderlip <quic_carlv@quicinc.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] accel/qaic: Fix integer overflow in qaic_validate_req()
Message-ID: <820aed99-4417-4e4b-bf80-fd23c7a09dbb@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

These are u64 variables that come from the user via
qaic_attach_slice_bo_ioctl().  Ensure that the math doesn't have an
integer wrapping bug.

Cc: stable@vger.kernel.org
Fixes: ff13be830333 ("accel/qaic: Add datapath")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/accel/qaic/qaic_data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
index c20eb63750f5..cd5a31edba66 100644
--- a/drivers/accel/qaic/qaic_data.c
+++ b/drivers/accel/qaic/qaic_data.c
@@ -563,7 +563,8 @@ static int qaic_validate_req(struct qaic_device *qdev, struct qaic_attach_slice_
 		      invalid_sem(&slice_ent[i].sem2) || invalid_sem(&slice_ent[i].sem3))
 			return -EINVAL;
 
-		if (slice_ent[i].offset + slice_ent[i].size > total_size)
+		if (slice_ent[i].offset > U64_MAX - slice_ent[i].size ||
+		    slice_ent[i].offset + slice_ent[i].size > total_size)
 			return -EINVAL;
 	}
 
-- 
2.47.2



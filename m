Return-Path: <linux-kernel+bounces-421018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 266979D8670
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B7F8B38FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF221A76B5;
	Mon, 25 Nov 2024 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EUG+O85Q"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B88B1A01C3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732539233; cv=none; b=p8dHc0Pcx2NzN61Rwv2jpelKIp/McUBmyBdO9v14byl2+bxgaPmBvs2dKdoqE03POCeWqddNugduIZq4lykafg9lOHqFXS7qRyIrln8sUf9LtZ+vTizC26Q5tJraLAOGSLrAuxGdr8XhBqKhgzaJpuQo5D20ekVqtiE+qGYq7S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732539233; c=relaxed/simple;
	bh=qpn3nL4ruTIH9jcXSn5EnaywmyoyKdo1VON2EkUGiV0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WcWE7WSIS0vOm3v9p3Oqokn2uteTCXVf5Rtuwwz47wq2dzEYkogpMiAH+VfDS43Pv3bh6YRhHiU3WhRfOz4tFChTYjVuvxPgkZ6U3ZUnPB7F35RkN0tPmASfwhWUT14QwHqSj3zUa7qxL1r5d6ZpMz5rodW+y114/QQfz65dzNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vamshigajjela.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EUG+O85Q; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vamshigajjela.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ee6e1f2d25so71370657b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 04:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732539231; x=1733144031; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kQ4bkEkWXI9460U69LX56jW+n+QgNq12f2hQHN4SQHQ=;
        b=EUG+O85QFtdwdD6iurL9QkH6pPPod3l62m7vNUX9J3FmJUZKaKGHjJWuAEvEP6IaiC
         243biEHaM+xutmCgPZKUi+md/TMW1YMwKMmi4c/utrXUMHf7bxsRN0jUS8XQPOqmMj7T
         7vX/EoGITzMMwlkEVDdqhhad+1hEdfy1OhA1109t38JlDjdMU8Ps3XPVNPRg0zsyPAfo
         9elHJzUlARNBBtMAitm9l4wmFKSPTuiW3kaG12RIcbv/OxawXWbJrCYZ0275oZ2zCkif
         iFbUoouo7sDug8gEDKWEO3bSNUZ/bP1eWPAkdHrJ2UjyrJjCxykodETqOrB+Pvxgvswf
         qYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732539231; x=1733144031;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kQ4bkEkWXI9460U69LX56jW+n+QgNq12f2hQHN4SQHQ=;
        b=SFxC+FADmi20eXkpAgHfZ6T5p+S9TJw34mV8N5Z9CIm0gA2pqxvilB2BoOU2GeAUfj
         B5Np2sJBv7vXbgb3zAWCGnxj/h0y1nDyGREH8ivfqMQvX8lMZW5xGrSXTHtVVFPHlKe7
         NVFnawPDm17W5Id5KlzWR5W9KZiNJYgtDicFokyuhVEs62EVbLBwerdtL6VTRMoLyFlm
         285s5+9ZJ/gWXl76W5wlH0IL6+YX754cCqAEh/7l9CBUp3eTO3JqyLD9tm8uJjLk6TAi
         kw2SDQYZMc4yjG4ORPKK4nfQfazFAq74WoyNUYzTyqG+101mqwi+gn6ev2dkhJoJ7hhr
         3gXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3Ae/vm0x7a9L5prJdNgI7HagRRs2DYc2bKgKXLsVgxkteHP2Qhq7PCywbs2lAwI7ZhsIog3wfeZMfeLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrUetNPrtm15o3taFyknTRhiezzpbHRO85c5xzO2jde33omDMx
	3vMoV1eSvIBlEXQs0MDcVajFygGXrOpd/zr3HKRJ0Yce9cvfH9D10p56LWZL3VZaO7iGBQVreTk
	0uu9d5EXmQPVMThKE3pazv4z9H535bw==
X-Google-Smtp-Source: AGHT+IE19EwzHoDlqo1+yfATE7tPwcQWjdN41993yStl979u2Ve1bKHZt1w5Eo8cthREpp6xIqRXTv4idhncz1Ja+bW0
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a05:690c:6709:b0:6e2:1713:bdb5 with
 SMTP id 00721157ae682-6eee0a39166mr522877b3.5.1732539230924; Mon, 25 Nov 2024
 04:53:50 -0800 (PST)
Date: Mon, 25 Nov 2024 18:23:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241125125338.905146-1-vamshigajjela@google.com>
Subject: [PATCH] scsi: ufs: core: Fix link_startup_again on success
From: Vamshi Gajjela <vamshigajjela@google.com>
To: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Vamshi Gajjela <vamshigajjela@google.com>
Content-Type: text/plain; charset="UTF-8"

Set link_startup_again to false after a successful
ufshcd_dme_link_startup operation and confirmation of device presence.
Prevents unnecessary link startup attempts when the previous operation
has succeeded.

Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
Fixes: 7caf489b99a4 ("scsi: ufs: issue link starup 2 times if device isn't active")
Cc: stable@vger.kernel.org
---
 drivers/ufs/core/ufshcd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index abbe7135a977..cc1d15002ab5 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4994,6 +4994,10 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
 			goto out;
 		}
 
+		/* link_startup success and device is present */
+		if (!ret && ufshcd_is_device_present(hba))
+			link_startup_again = false;
+
 		/*
 		 * DME link lost indication is only received when link is up,
 		 * but we can't be sure if the link is up until link startup
-- 
2.47.0.371.ga323438b13-goog



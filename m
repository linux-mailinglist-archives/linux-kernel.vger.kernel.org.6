Return-Path: <linux-kernel+bounces-435800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 932309E7CB5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 00:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FDA716C4AA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17100215046;
	Fri,  6 Dec 2024 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k5onkOd+"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55C221480E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 23:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733528330; cv=none; b=jZYGodVxkZsN4NctkHtaZdLgkXhhgKXEdAqtZYxAuBR7sUjypmDAVpxsDm5gg4TYU2WYYKhvj3SG6Nvpxps3tQggFvzeoV3kzDnzKLvQkHgd2B8T9AbjVzchZxnn3u0lUyNZJ0q2wtpuVdRchvn8PTu5Z5Qzjva8h0vQv/EsRR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733528330; c=relaxed/simple;
	bh=Jlz35Axmxas20UXZdMUAEnU/Zcdy+VnrtwvvujZhzjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dnxtx8bnxKD92V/aSyg88klRilv4zQlP0so9N4sYn0UDzFcO6wKavOy6KuH1FFdffvcGFy+HLzEBjV+SyoPX15lT0o+ujIEA5TsidadkyMkg7VuqH4PXsyipB/pKAwoSgI975w/IEo+sdnQcM1ygT4n3xPPiiw7VVvC5vw0AGsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k5onkOd+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-215b13e9ccbso25371045ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 15:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733528328; x=1734133128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEsFgZZBOjZItw/w6Re8IWK1gazviV9TFZpIsGLgdzk=;
        b=k5onkOd+HLH6NzluXQuidMKvZdOf6eBpLocBkdHjOKw2qGL2wsmupbrSb7oCPSnEE2
         yFFXcY72Me+Cwni12FjPmEQ6rHApRC6UefZJKhgiQZzBBhgxVLvden6s+Lx2Wkd7yT/o
         V6t48z2hXSi53XkWWj4xPBqtljEPekTnv2SAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733528328; x=1734133128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEsFgZZBOjZItw/w6Re8IWK1gazviV9TFZpIsGLgdzk=;
        b=EpZYGR8KW0BOXIAfKho4S5cK0Zz5AQPMJ35EtavU+/CuEf6vxt8ms/HqzjF1Sxoyxx
         mnRjZJ+6LTSGyjHjbREdLsagiKMBlfKQldI95LQM3dXuk6kTS3uPf8KrhJ+jbnB1oDiV
         i8LjCwyfcTG2/XThtjUVAa2aveWqPpHeAnbwZJ0XMfl0clnLXM0rqFv1Cwy3v1fOlRWb
         RS93vX38ATl4NA4b54c+bCcxtcytr+aPDCYU9RBVPqCePK6Pd4D14E14LeD1xjP+9YPF
         u7EQJGwEFdXHZ3RJuFef6iJyx2SdJFGqW3iNXa4BwV+WpWphqMMgNUN+sVkO3L9tsXaE
         2dpA==
X-Forwarded-Encrypted: i=1; AJvYcCUKn3ivJ5OpebuoGGaO5NKDxx3wc1tz4qRLhv8F/VQfKnkg8zRncK4IA8BHKh4MeGjURps5OlYzA1qXoDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRgA8RlHX+Y0582OFE1CWoCuZxC3NVdxSsjsbQDgpQtCwCrHjC
	X7DfcofCeFwOT/+kmggnX/PsUj6ty8yDxJB+ElIMEXhS862seS3CUo7f78uLeQ==
X-Gm-Gg: ASbGnctPTO0UvDbAgJPbRAkfyaWEvUNsbuzcZcNuvAtm9qWrngOybc+N2cAm/xK+99e
	6Y19uzsfoIS6y8t9IAJdWR42U2axvlCaW+TXaHerE2ZoSO0n0jX6MQVtQ+Le55Xb4nnDnwkqwaW
	e2qSKbPmxdFqO4y5SU0cLvYINVZGly/s3D8vIqr3LVUyd3dgBz3EPW3wJ91Sx/zgnpP8y3Z5HqG
	/YdsewN3HWXHY74czDWH0V+agiC0LVHKleoejO2fEoNHE9TSvfVC5VZLqBBSKT6EqREuZDcTpEf
	jARFV+PXGOKLxODkK7QnOsxL
X-Google-Smtp-Source: AGHT+IE2s40s6YYwYc1sTeIXRAHidUXahuDrUL8yJczv/cBkFhoKl7A5wKj7RNqs4UHrL++1LK1l/Q==
X-Received: by 2002:a17:902:e5cd:b0:215:9642:4d6d with SMTP id d9443c01a7336-21614d3ac8amr54953465ad.17.1733528328424;
        Fri, 06 Dec 2024 15:38:48 -0800 (PST)
Received: from localhost (227.180.227.35.bc.googleusercontent.com. [35.227.180.227])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-215f8efcc70sm33915095ad.167.2024.12.06.15.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 15:38:47 -0800 (PST)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: heikki.krogerus@linux.intel.com,
	tzungbi@kernel.org,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: akuchynski@google.com,
	pmalani@chromium.org,
	jthies@google.com,
	dmitry.baryshkov@linaro.org,
	badhri@google.com,
	rdbabiera@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/7] usb: typec: Print err when displayport fails to enter
Date: Fri,  6 Dec 2024 15:38:14 -0800
Message-ID: <20241206153813.v4.3.I6cff9d767b0f8ab6458d8940941e42c920902d49@changeid>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241206233830.2401638-1-abhishekpandit@chromium.org>
References: <20241206233830.2401638-1-abhishekpandit@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Print the error reason for typec_altmode_enter so users can understand
why displayport failed to enter.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

(no changes since v1)

 drivers/usb/typec/altmodes/displayport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 3245e03d59e6..e292780ec309 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -252,7 +252,8 @@ static void dp_altmode_work(struct work_struct *work)
 	case DP_STATE_ENTER:
 		ret = typec_altmode_enter(dp->alt, NULL);
 		if (ret && ret != -EBUSY)
-			dev_err(&dp->alt->dev, "failed to enter mode\n");
+			dev_err(&dp->alt->dev, "failed to enter mode: %d\n",
+				ret);
 		break;
 	case DP_STATE_ENTER_PRIME:
 		ret = typec_cable_altmode_enter(dp->alt, TYPEC_PLUG_SOP_P, NULL);
-- 
2.47.0.338.g60cca15819-goog



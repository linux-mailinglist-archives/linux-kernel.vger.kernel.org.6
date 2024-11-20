Return-Path: <linux-kernel+bounces-416027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFFF9D3FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ED59B3075A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF54143871;
	Wed, 20 Nov 2024 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqwB+GLn"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDDD85C5E;
	Wed, 20 Nov 2024 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732117572; cv=none; b=Jn3QT/QAC2wkdNVbL7T0mMbWs9dELTzEKlh56YNDCb7l/OZnKlUhk8bjlt6ODqlFIUUaryOiisXRsildyeJcL6zjLm88bwYOYiUBiQ1MzrnkjpbKaQpDnE8EXz4fjrU6V3ZxZyAPf17MFNkgT/OmU8GV66kcbY/tOB0vUrt+WLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732117572; c=relaxed/simple;
	bh=NoAx2DXVAyrCS/4irxTbhJAiFco/Aqrx4Ig8U69PSHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pj0dbjZcQXljdKuE0L+uCQJkJeMyb0DVANUe8qx0goli8LSiXKYev0B6gJkuQYEpU3VchHIBznO1LOfxnisSY7L27G/ZrAgdS83Wi4ySUxHM2Seop5Hr1r0Tqt7ycrxwKwPpTT5Z+sOEbnmTD4pFwavL0mFbllF5DMjmIsx4aDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqwB+GLn; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-72061bfec2dso3783261b3a.2;
        Wed, 20 Nov 2024 07:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732117570; x=1732722370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mlC1fiUhPeILfOtmUrQ/N6IVvKcd/i9shLrZYcMb/8g=;
        b=XqwB+GLn712YpETVHXn/KObtD9Dn2dBTNmd7uUGWHG9Mh+/A6D+mDNcgkd0vPiBfbS
         AzmVrgrt0pFCuvePw+dSbopuHEXnuJF2LI+rPYHnxi+W/iPqmYGo8wY8WDzyJ563UVdf
         kmFjo0zZcfTRWNMNZhPX65tiqTWZBXbPWeTvibfiP+ZOogLGY8fNBsUJ5VhmjWx4M7bJ
         Edq88Rhhp9BLk7289UTBAKlB0XxbYSlPG9dGPF5HuN32cr61IwncBGuFS+hq3Es/ki6Q
         N4Ln1A8H9Sv8yS8EJpD07W6c/J9B2D0CesSb48VZgk1I9fKGQ5XaroQiaaFz6dUBDxSo
         Eclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732117570; x=1732722370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mlC1fiUhPeILfOtmUrQ/N6IVvKcd/i9shLrZYcMb/8g=;
        b=hI+5gRt7sa3tZD3Qq1aiMCcbXjjAk+bmPv8PMjWZ084/uJWFI7jz6EWo+xt0+5ScZv
         uF9WByxxZV02fO4JpxHjliqVoA6HZIpROD97lnZTUM1vmxBvNi/a+ujttcvNlKzv/Tdr
         WK23hL/GuyPwYL28COIdm+MNjoYA0yknZiPnifca2zXQu0WyNm7E3Dwrfty/9RtVz+NR
         J9q1fzb5Tlg0uWe149JQJeu1oadNRQtP1DfWmY78E5SoafJaGlablBoK2NjtyCN2w0b/
         bk3eqoiBy6tsstd34kvnFoJRnRg6QCmiSp68qHZG8FIzqiPc2ZCx7JtzhGRd4VqnLIyi
         bO3g==
X-Forwarded-Encrypted: i=1; AJvYcCXm5+2nka8EASKYST43ueqiyt6aCbocKUZld0Tk0pCRPVllrwHXiOz0vrnU3r95qjmPJ/CQU1twOAYkg+M=@vger.kernel.org, AJvYcCXwrgCbjDwLjD7GpEBnB307TTLq0hKJwiCn22WNBx3StISkCdF5DAuvoi0tnKO4JiaX8nYxNxzF5xtO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9X6vCQVSiHMO0zKJqpAy0EFTVhMwXVEWOEIAz/R0QNoRIQw85
	DwmLuJoL9How+W0ElThrSqTJEGd7rQ/oead8RGJpcR7zsyTpL8e4gjbhAXYcDSs=
X-Google-Smtp-Source: AGHT+IFNRYwFJYtTRsYFIAe54Lh4omf9H/vO8B1hc+P4dH5FyrlHuZmBlJaXnBwLQ8pp45dbnF1nBQ==
X-Received: by 2002:a05:6a00:138b:b0:71e:695:41ee with SMTP id d2e1a72fcca58-724becd76f7mr4397056b3a.5.1732117570022;
        Wed, 20 Nov 2024 07:46:10 -0800 (PST)
Received: from x13.. ([149.40.62.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724bef8daa5sm1844109b3a.102.2024.11.20.07.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 07:46:09 -0800 (PST)
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: Thinh.Nguyen@synopsys.com,
	gregkh@linuxfoundation.org,
	rbm@suse.com
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	skhan@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v4] usb: dwc3: remove unused sg struct member
Date: Wed, 20 Nov 2024 10:46:03 -0500
Message-ID: <20241120154604.51815-1-luis.hernandez093@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sg (scatter-gather list pointer) member of the dwc3_request struct
is no longer used and should be removed. This patch eliminates the unused
member, cleaning up the struct.

This change improves code clarity and avoids maintaining unnecessary 
members in the structure.

Reviewed-by: Ricardo B. Marliere <rbm@suse.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20241118194006.77c7b126@canb.auug.org.au/
Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
---
v2: remove unused sg struct member as per review[1]
v3: 
  - Add reported-by tag as per review [2]
  - Carry over reviewed-by tag from v2 [3]
  - Update commit subject to reflect maintainers
  - Update commit message to reflect actual change gathered from 
    Thinh Nguyen's feedback

[1] https://lore.kernel.org/all/20241119020807.cn7ugxnhbkqwrr2b@synopsys.com/
[2] https://lore.kernel.org/all/2024111922-pantyhose-panorama-6f16@gregkh/
[3] https://lore.kernel.org/all/5l65sdskdzbehxamff5ax4ptiqhaxh7ewi4umtpp6ynen45nj6@nebuxjg4c4rx/
v4:
  - Remove out of context paragraph from commit message as per 
    Thinh Nguyen's[1]
  - Fix Reported-by, correctly attribute report to Stephen Rothwell

[1] https://lore.kernel.org/all/20241119221907.tyt4luboduaymukl@synopsys.com/
---
 drivers/usb/dwc3/core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index ee73789326bc..3be069c4520e 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -956,7 +956,6 @@ struct dwc3_request {
 	struct usb_request	request;
 	struct list_head	list;
 	struct dwc3_ep		*dep;
-	struct scatterlist	*sg;
 	struct scatterlist	*start_sg;
 
 	unsigned int		num_pending_sgs;
-- 
2.47.0



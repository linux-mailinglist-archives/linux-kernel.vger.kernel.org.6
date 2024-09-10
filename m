Return-Path: <linux-kernel+bounces-322549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D2E972AB0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4138286B96
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C5117D35C;
	Tue, 10 Sep 2024 07:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QVLO75QW"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5626717C232
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725953255; cv=none; b=GtFz8iuPWyocnuPXU/nCfaGtxrsFm3wo+3TL0ntxnRmwKOzleOmvjqkfXPIPrKwwjVoTyMEv8lffCIFJdwDzOKtpLm5WVOws9KysV/zk2QDatiQr7IaJpS2lKWwoqsX4wsqunEI4rMTolfFK0tXdNjhekQa+01s40dMsky+oqqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725953255; c=relaxed/simple;
	bh=xHp27Dl5rFoaVGhUHo6nRu+Kc8ifNyYXpBdJfUc/Yn0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Un/wj87UYhMeTBTLYRwebhN7oCFLhM8P/JpV2GQB9N4B2dc2xu+4leLh1yee94+35WQLxq+pELjdwHLm9JacvXIZT+fHv9s3MnAz17edpYyM9c+8K79fBD0vLa2EIwGkowlpMUXB2Ruqu5ilYW6myRkmDNfYA1aLX1wt/nXLBv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QVLO75QW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so11871745e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 00:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725953251; x=1726558051; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=imHMW4srmvxlkZw05ahiPZKsauky+pygFs/tY2Ct9A8=;
        b=QVLO75QWp8YlQT+WrG7A0qWJSXfQ2G+9QsE8CaKan3SHnLqnDwuryXiQQ4LXfevEPe
         yYCPKvUB1HD7ELWrmGWQR0hqabC71SsfwIHTmIHNJOxq0zyVpt/6c+0qZnC25Z14z9Nz
         +IVjVV4+5ZzylscAXX14QJqwIjz0NWbybzNRXqQRdVM3l50L64Dn4GED/50hVquJTrNt
         Vwc9x7mnod+52WreiVCzrmjazsZnuPHkPvJNvnsP6MIrLYpkh5n1bXwZpd8WsxXZMWdE
         KPYR3bpzLL/ljHnMMtEiR9DSxlZZk87I14mdF/p3fEyKhfYSwD90j32a0NCIf2wc82FF
         Xgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725953251; x=1726558051;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=imHMW4srmvxlkZw05ahiPZKsauky+pygFs/tY2Ct9A8=;
        b=n4xJmnWFjnBhAUO0AyxcJtm0cWEnK5qoUiX57l+sVKHFuN446mpW2ZFQrOW0KKMhz4
         r6npYNnIsQxKfe2c5zQNTEB9gnMSf9BnHJH8BGd2q/X+9hn1NtndU0uKjaeRtPL4sn3c
         Yi4EGQTg/ejskXcfZcv1A3E8btQpZwNhjdHbu4wsfqFYGg2/5kEn+wc0mveO747dlyP/
         +E+eOvJStxfY7HOMcTcGBl7Ugp9QCOtxHLCoLJASeP2/fJ+rqr/qMz1AJA3CQNo7BVJa
         rj7U+ZyUnQWooHJaUzk8yFSwNJGRmP0ZN42U8U5VLdi/IAmtAtkmTnbzK+W9AOXZUcYW
         zlxw==
X-Forwarded-Encrypted: i=1; AJvYcCV3eBXV97vZ+78I4F0jBGXo50diTiQmxwd1lDOD6EEJ+Gh5qvVVnVjR0BRs0GLqmCt8vGI6jl/Ny3OUv6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ9Ro9kOJKKrXgRZAn7hXD23MBSlMnV5kPFIxwV5gpClTgNexE
	jk4aGNjx+SolbM0Mzww4ul9OMW9iUXA2GfA+cpRCm3K1hljzxcZ40uRr7FWRZYw=
X-Google-Smtp-Source: AGHT+IGoJxhSFCZbyl7tqtAC8eWbUuCuNeiK6sk/bYCSGEBjaxZfva9+5Us1debP3cR6vVuVBeMXzw==
X-Received: by 2002:a05:600c:1f09:b0:42c:b8cc:205a with SMTP id 5b1f17b1804b1-42cb8cc232emr37553905e9.32.1725953251538;
        Tue, 10 Sep 2024 00:27:31 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb1cf939asm86495265e9.19.2024.09.10.00.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 00:27:30 -0700 (PDT)
Date: Tue, 10 Sep 2024 10:27:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	lei lu <llfamsec@gmail.com>
Cc: ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] fs/ntfs3: remove duplicate check on "asize"
Message-ID: <15fc9478-cf00-42b6-820a-87a2d62f2766@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Commit 556bdf27c2dd ("ntfs3: Add bounds checking to mi_enum_attr()")
added a new check directly after "asize" is assigned so this check
is duplicative.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/ntfs3/record.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 427c71be0f08..0f400366231d 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -268,10 +268,6 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 
 	/* Check size of attribute. */
 	if (!attr->non_res) {
-		/* Check resident fields. */
-		if (asize < SIZEOF_RESIDENT)
-			return NULL;
-
 		t16 = le16_to_cpu(attr->res.data_off);
 		if (t16 > asize)
 			return NULL;
-- 
2.45.2



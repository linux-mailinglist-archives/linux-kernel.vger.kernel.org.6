Return-Path: <linux-kernel+bounces-431149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8474D9E397F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6013E1693F4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801981B6CF6;
	Wed,  4 Dec 2024 12:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nl1jZlwf"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E4F1AB53A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 12:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733314044; cv=none; b=gjLOLaI7nlJS1vKDrBUkbTQc8W+OVqH4D//NYqhLoT1VgwS99XBXBrFdU6KNoaaQx3YFDy93zJ2NDMESdQTVLKnv5dw3aK/mUD4aOWVl/6UQYMqErJ/9jsrglDpJUgJ5NDuJhLJVu1q4cdsJLBECAp5kKeczTTlHUjPl4yW605Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733314044; c=relaxed/simple;
	bh=RvR3qOxj7F/0e9rnW7O2IklQmCFVE6f3EueDbZzyUHM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hPzPuwxz20g6BVtASeAI0cG4loikiBjF8//z8FRJMdcJaomvonCznnUZS1tP9Ike836FhCc4HMalxV/7ATfdxldQnjDDgYYPquKQB3NDbhrXHtUtGF1YTKp9buPKuaAVgqEShdIdJR1jKTzasTWAuSrgpozwFkt8L8Se8B21bxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nl1jZlwf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a766b475so61680615e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 04:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733314042; x=1733918842; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h210QoOSRhdPOVfbdTSglVOfvi7IBDHS6sm3Gy55HvY=;
        b=Nl1jZlwfY1Nt1c1j+pN2QmDPxKOcAoXDPFhQJ6G3+I6gBaFxQIGeYBgx1gvlZ72kLt
         nKmJIlDnRdgB98L8bUxncMzIPGn6DRE3riy5BY24IKbVU+KZx62iteuk1rYoxd9ShIBO
         t24mdAA3fen00onL9nIzDdP9qTeg8fN9KOeQT4L2DCHXmrTqwwfxUCceYZyBGcfuaRpX
         OgEXx6TBRJmwm+5DHqG3d3HDVpeC59f0nijF4Mu0uefZaYGL8oUydjlhRRGLrH8mDTXV
         bddrm2YZnXKPiqWXxPElf5GkEkEWmqg/uwh4ltPah5KhD0O0lS4Lq7n3SmOpPqSYkolw
         TbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733314042; x=1733918842;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h210QoOSRhdPOVfbdTSglVOfvi7IBDHS6sm3Gy55HvY=;
        b=UwcP9wq4T82MfY9kRu1/jXvHd5dJT06VYZJ8N0JTdeOQrNN4JzoJXaGVDCVOZh1Kyu
         Zi81xRZUsyRumHjNtiz9bNaytPz6hYWpL6F4gkJ7p89HfXh+ELkuBOE9avOlJ035s9gX
         +5ubjNEtcvEbsKJk7RHjH5VLNmhReti847lu7d7ojkA3jAW6gB6BFzJsiFVVoK0u2rln
         mRCeEPl9FCHrxuw0pBhBgQRTnajgslM6INYymF4YMDCyUu9OKqCD7n37cj8epzn2mM04
         bPzs2jHrtm9UpEZZUaKh8obvvFfUOCKA3qhpshELlHwtGrLUnuwKXASLx/57KD4grM5T
         JwzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLreWVfVT28O1+P3fLBlYESa8zOOQggdezJKy1UYTraGk4vp1F91PgxFPtvVW0W3Y3VornffXThIUY5Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCsAE89oqVK9WXYtIL+wVs7ZPP69622PdFHNpEeq6d1h5jFf+W
	hvqTvS4jy/2VQiPxqZGCBORDXlJELiKHFfIvLU2soVknzIH5sF9G/3sBjG/tIPg=
X-Gm-Gg: ASbGncsGp0iCr5PUTRaIMlNKiGBqINM/+AA7PZDlIZwN5OtJCl1s+7Abe7zCnVy0LeH
	hsoYtjDr76bEOvedZZf5skBgFwgpbf+yEdAliyu07EN8p/1oPKyDlpaovmVcYRQLkIfUBL3s648
	nX6s8H3ZwLFqJjwspkROgFyLKqc5JjgKkCbtLiimofofj5t7fs+LyfUyu/h9T6WfAEDN2D4mTUe
	GaOWge1r8+USehLr8Z3tQWXrv73ofQAg5xZ9mlCkbem+qSryjEHCcs=
X-Google-Smtp-Source: AGHT+IEMOOOmz0PjNc5gkcjsABrK46MDH+6JTcOtcJN37eRjlQ+sir8R5ollqwe8lrVAPHvlPmBp4g==
X-Received: by 2002:a05:600c:3b8c:b0:42c:b52b:4335 with SMTP id 5b1f17b1804b1-434d09c0b53mr62649135e9.10.1733314041606;
        Wed, 04 Dec 2024 04:07:21 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d526b14csm23020975e9.2.2024.12.04.04.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 04:07:19 -0800 (PST)
Date: Wed, 4 Dec 2024 15:07:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nicolas Pitre <npitre@baylibre.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] binfmt_flat: Fix integer overflow bug on 32 bit systems
Message-ID: <5be17f6c-5338-43be-91ef-650153b975cb@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Most of these sizes and counts are capped at 256MB so the math doesn't
result in an integer overflow.  The "relocs" count needs to be checked
as well.  Otherwise on 32bit systems the calculation of "full_data"
could be wrong.

	full_data = data_len + relocs * sizeof(unsigned long);

Fixes: c995ee28d29d ("binfmt_flat: prevent kernel dammage from corrupted executable headers")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/binfmt_flat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 390808ce935d..b5b5ca1a44f7 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -478,7 +478,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 	 * 28 bits (256 MB) is way more than reasonable in this case.
 	 * If some top bits are set we have probable binary corruption.
 	*/
-	if ((text_len | data_len | bss_len | stack_len | full_data) >> 28) {
+	if ((text_len | data_len | bss_len | stack_len | relocs | full_data) >> 28) {
 		pr_err("bad header\n");
 		ret = -ENOEXEC;
 		goto err;
-- 
2.45.2



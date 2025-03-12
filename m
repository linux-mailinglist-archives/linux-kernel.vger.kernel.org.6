Return-Path: <linux-kernel+bounces-557389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED69DA5D844
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CFE83B5B25
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389FE23535C;
	Wed, 12 Mar 2025 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a6k4ASzB"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0802722E402
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741768389; cv=none; b=EovpK8fyPXRU2M0cWgrIKw0MkJc0RRjYAbQIjxAT6z65YSjPmw2+10JC+XFx+Ey1qnJXbUK9ELOirIffppXW7tB5NUBs9Vatxev1hFWujpxjgvfnBBrWjtmgqRzDGCpDyb2nvEnLLRvF6phIHUmN39dqIRxgYSDS7RFs8u6xqrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741768389; c=relaxed/simple;
	bh=pSo5vTjN3OF9dYBlqCsRbrqAPdXDHi9h8WPbDq3JzfU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QkYNghBwzAmg/yD8aOigqfstpMx5aJZXoLxzU5vOiuuFV8xGTHwoYjEaWYIuDASufs0I6PiemfcNnJ0X4BhxPg88YbGxcfEAAUgJTgzhW7MwogQHwCRxKJ4xCSRqypMZVWO18BtbqLtccd+RTY2rNj6ROrgo/e09lvpmt6bnyLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a6k4ASzB; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-390e3b3d3f4so3145444f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 01:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741768386; x=1742373186; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hk846ocqbbU4c/o0fjWpAAvlpyCOyvBrM2NRYSxeofk=;
        b=a6k4ASzBb1G7kE6ckaJCr6lLoeoPiYyROxlGsOl8CUvqp7eHaZ45lmCLQf8shcPcTM
         i1Fi7jrMRmDN1ItAIrsCkfn+IyKXAkCZBPQOnzzOnwj7ClR1GRVWPFSbrBMu2uC1u0f0
         yrNCyTm4P1AcHub7B2IxzTHLs3cuU0FunUXxNWJmXGOWCbfx8J5ofVeDwzErwy4eGTCV
         TpRurDmSoUfqGyb1yPnsKyumk5Jq1KZ+EWJCufk4rQOCOkn9ziqFxfjJMY53t992box7
         ih/dHcm3hVA5eClo+5rL45piJkFZwvJy7aJyl+oqkE9pJ6fwAfGT/6hfahAXEhN9OH6b
         nu/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741768386; x=1742373186;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hk846ocqbbU4c/o0fjWpAAvlpyCOyvBrM2NRYSxeofk=;
        b=D6+zHpJN09vRxJoICF5vc0Fwt97wMATPxMDJhbCGGOvJn0UuaX9KCg+Ld27jZbOfP2
         fJYTqvV/HOHKcUNa9lBHHfIckNfr0zxQeekjUzZzPgVmCyaTN/7G3CtNgVeISmRD3dx3
         mh2k2yYXsJfTk/f/ggzdWboc/YIoRBx4STJ0cKQc79yhcwDKQfo+faYZ4LJIQdOQP5+Z
         vqy5jMGxDTJ/lBCw4FAvocCM/+LTMKLf48uF6higyFdLM9c1lvpDC2g4NwomqRTBiK4B
         lIXhvRKGoVgj7W18UOLPosLVmXcdpDE0eSXt5rp0fzJSNmuIQF0L+t1qSK0mxbahsIzC
         HmDA==
X-Forwarded-Encrypted: i=1; AJvYcCUwdi0qu9vKEWnd6Q3n62cee3CMZPaTL5xfbWdrHGClxjUQy1CC/6Nc12da72qhPjJfCpJ7vOWVs47NKNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuY7QybKG14ENeTi80fDqn145s4YF8N2/kKKqq1c71fDTlKGtj
	NwaW7sjlkV7JBJ0+6Ezwz7osMCc9lpuE9R/HF5UsimrLRcTpwytASGgpCtE5dDTan+vZYEMWaNe
	T
X-Gm-Gg: ASbGnctQ8ZEO1wvX5vXlmgA+2PvHCJoqCfXQ105EnaPyfuj48YLydTiJ0jD2fa3D+03
	B5eO623btHogGcKi//dXseMnjn8d1+tMhOPNH0GLQ8TkNv9AkXIomitEpz6vaHCHZCAtReqYlDq
	11emii4tKhB9+WGGNO/BxBHUJZzYyGHikV4xsO1Y5reYFAsKGysm8MhBjbbQc32dpEi1hiyWcEL
	Qfsb8lG4eHv2b4UnhxY8lZXI1Y9MGhsbKcW9dldoaC93k0B9T5ES4Kf97VItVaOnNkKUDvLRDHw
	T9UCpwjlQTCFQCwG60jYGhmBEk7O75/fWwv02X+hgkBG3srYZA==
X-Google-Smtp-Source: AGHT+IH+soUGCO6EN3L3810VPuOet5YZmw+fbN4JVDjX2iJDlZI1jlgA7rGnGm4yrtxgN9st0ie6UQ==
X-Received: by 2002:a05:6000:156e:b0:391:3d97:bd33 with SMTP id ffacd0b85a97d-3913d97be31mr13299968f8f.13.1741768386394;
        Wed, 12 Mar 2025 01:33:06 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912bfdfde7sm20820827f8f.32.2025.03.12.01.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 01:33:05 -0700 (PDT)
Date: Wed, 12 Mar 2025 11:33:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] gfs2: Fix a NULL vs IS_ERR() bug in gfs2_find_jhead()
Message-ID: <ed5089eb-fb83-4c69-9835-dd64735b8a73@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The filemap_grab_folio() function doesn't return NULL, it returns error
pointers.  Fix the check to match.

Fixes: 40829760096d ("gfs2: Convert gfs2_find_jhead() to use a folio")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/gfs2/lops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 3853c422040b..0fd3b5ec7d8c 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -530,8 +530,8 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head,
 			if (!folio) {
 				folio = filemap_grab_folio(mapping,
 						block >> shift);
-				if (!folio) {
-					ret = -ENOMEM;
+				if (IS_ERR(folio)) {
+					ret = PTR_ERR(folio);
 					done = true;
 					goto out;
 				}
-- 
2.47.2



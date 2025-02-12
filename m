Return-Path: <linux-kernel+bounces-511358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51676A329F0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301C7188D326
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C69211700;
	Wed, 12 Feb 2025 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TpMAppSM"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21232116FF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373951; cv=none; b=GgLD9/Kv8H5PNQcyxz4etmpdBmT3c8ZMVVRotQu2qNjN8dcBSDM8Bk2GlfuddK2eZHTwkoVhFVqPoandHHDQ+TOjLYQMl+17EYvdTbeRg5j7exgZrGSWn+enhp1SUh1FgzmlbMuRjtzTfqjsGbKzophMFQzJd9fKCrdqz8yctKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373951; c=relaxed/simple;
	bh=9Xev0WPL3aqSoOZ+iEdwAurHlCOlmppDeErE0Vxv/pY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m99vvnfOIFZmPK3dypuKYa5vgbEnrgb7Yvj+PO1HM6PD2eAYGGaGRckx5ryU+lCtPgH/2IzsQV9FqCxdxLtim+TLMwxxy0cRrPsqie+IZiRsYdL72UASOmyLTzGf6r1kb2wgwZn3NxP/5OIhZtFMB49LSQ6y6MOiubN9OPXNmSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TpMAppSM; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dea50ee572so2856614a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739373948; x=1739978748; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m7M5GwfQ+3LOfRzgrXxTqKn9y3djRSUzmsbdmGEOdrs=;
        b=TpMAppSMzGe7Qgv4SD2KCRxTXd7Cs/VAiAWIT/QKGvfTP+ILlGxHKXM4soOQca0ag8
         8GDz5fTZziGjiehapCvZXCW+BJbJclA1dYlLH3SJu359VtyhHMXVb0eICI2ME5DhLHGC
         +nZA9GeBm/Y47BBKn3Fc/Y4k2zMIBp2F/YobO3m+mA18daRp5pzAHM0sMUNQiSVRNIq1
         C6PEo5joERGid0roqAMquRmaXxMokaHzYJQDZIOxlQSYxFCK/pgRLk3SbdBLL1FcOIll
         YUllb/JwuL2OfRpxrDA1g6h4Xzo7dit65ZLhVDQkXsBWtmw7F6MLYxtGtTYyxVqNZLKa
         DmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739373948; x=1739978748;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m7M5GwfQ+3LOfRzgrXxTqKn9y3djRSUzmsbdmGEOdrs=;
        b=TyeBDHEvZyIWpDqPDMugtQFvcPp5qaaQspf4PquZHSez06zx9xgzlukUsmIwe8WcO6
         6m4MVzNY9IiPe3xeZ9V3NWTyjvFRZ5INISQQ3TVihxvGm1ql+qKLXvkebVPlkoJndN1H
         EH9apsTn239OOZ6Zr1Lt+Msv0sHA02viQiph/vgaZf9tDGwnhiNLzIjWp91jIPdqb6Xl
         DW3QWzzVW1pegFOCwraDCBEqYxzn2n+zn3QOLSQe8W7woquVq5vY4RMRXjXR1rg8Twzk
         DKrxvVjkbkZuslDOYafnRporlzhZcjelmu6AzYQ7Ctj8/qptQ5iRwUS2RmXkOc78lzq1
         Q/9A==
X-Forwarded-Encrypted: i=1; AJvYcCWKdSj69IBOm3O6AnFPxyC+NQk7i7nEvnqtNgIIKF+1+zJrE8BedaYPL2T5XhYYYcXLzIKJY9peveuNSMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnG8zs97hgMUa7OYhuZoQEcdsL0z2TNVVVhCcHA86ze/PBaQm6
	qQR5IPPI2r57YIyrzJHx8n3F2FMQwPUt1myG16GZiDQ+mD9DvH9Sbf/shtyrucs=
X-Gm-Gg: ASbGncvaPuKINFQI5wwY9dtYfoOoe8yyd8JVrdPSzTN76LAoMqFbrTJ4f+BzSHuM3vh
	kFjFOtSqvJCYXUJd2inxqVLq8W1w8k6CNy8wbkPFDyer2xiRaaB9UuhGRIQdFiz1eU+zZGdXHOO
	9QTD4AxMWw5rYNDMjTUYx4PjuQp0o1ryo3o0oeIuXRK0Fp7cNRamiBFixT7JRVo5GnpEnaP1zkC
	joGNV4VDZm03DwERQGGm7WrFKxd1hc63fCAJmI7ii8VznBhAHTadaTtXK0BkFopBt3+7rhKWmi4
	dCDlgdVh5wb68hg9OSWd
X-Google-Smtp-Source: AGHT+IGbFzs4+6mWsWpYBe7JoXi+IDrmdHZBXOXvhE9G4jtbV7nz5cMuSQAFACr2ooMFlOpmsOYjfg==
X-Received: by 2002:a05:6402:40c7:b0:5de:ab36:699c with SMTP id 4fb4d7f45d1cf-5deade00bc6mr3449416a12.30.1739373947907;
        Wed, 12 Feb 2025 07:25:47 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5de59f893ebsm9040916a12.45.2025.02.12.07.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 07:25:47 -0800 (PST)
Date: Wed, 12 Feb 2025 18:25:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] ice, irdma: fix an off by one in error handling code
Message-ID: <47e9c9a0-c943-440c-aea7-75ff189c5f97@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If we don't allocate the MIN number of IRQs then we need to free what
we have and return -ENOMEM.  The problem is this loop is off by one
so it frees an entry that wasn't allocated and it doesn't free the
first entry where i == 0.

Fixes: 3e0d3cb3fbe0 ("ice, irdma: move interrupts code to irdma")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/infiniband/hw/irdma/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
index 1ee8969595d3..5fc081ca8905 100644
--- a/drivers/infiniband/hw/irdma/main.c
+++ b/drivers/infiniband/hw/irdma/main.c
@@ -221,7 +221,7 @@ static int irdma_init_interrupts(struct irdma_pci_f *rf, struct ice_pf *pf)
 			break;
 
 	if (i < IRDMA_MIN_MSIX) {
-		for (; i > 0; i--)
+		while (--i >= 0)
 			ice_free_rdma_qvector(pf, &rf->msix_entries[i]);
 
 		kfree(rf->msix_entries);
-- 
2.47.2



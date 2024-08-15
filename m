Return-Path: <linux-kernel+bounces-287874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC4D952D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1444B2330D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826581714C2;
	Thu, 15 Aug 2024 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s1JqzpUG"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453457DA99
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723721352; cv=none; b=a2LU7DecwCammr6n6K8sFUXJx4P36rrno0VCgqYT3GXNZ3G5OSLQxC2g0WBCMPtUOsioM2vmldsV1xy8lj1Z7qUgtWmi61MaWKdoOvbM4NmLqOQu2e/0rAyRhmTiaAfkPh27Lt2fkDtijES8/V4ZlMnOItpLwAPrc+qd9SMFYkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723721352; c=relaxed/simple;
	bh=5yq7ytwNHn2qEvgK7GpGxCanu4fLp9NgxjldEljV6Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CVDq4NJwfhe55gN0tdjvBMmsyiQuc6cwVzRKCTrULgPgEOg8W+2uPZPA8JYhkSjXVmhZp4Fkrld96MwI3iNKx0Eg8ZWuc/0pqjyt0IPuK2XzmQdXja4dbPXwn0qaYhgvJwdRELlvA6I5xFv0BO1kTKXCC0KQ2ivuWiywJHNJ1+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s1JqzpUG; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso1271482a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 04:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723721350; x=1724326150; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=54Zuy7nrqOr7HzwudR7mUSOwh6Bt+KzFm1OF0/li1xk=;
        b=s1JqzpUGhteq3nJA6TbhRNhk945JVTr+EAbdJpJ9lSNj54j75VdexDFqAlu1cQ97I/
         d0usb0OOAjR0jJkeBlL00zTFyQ3rx5qb3KKCr1QGx0LzkUNbovs9sBd8+uP3on+zwWJa
         2tSLlG9hSVyeD2c2IvS5NDPsMGkdzjKNLMEbGQnUMaLYm93FVQS1iZNETVUXL0cAPqQq
         +l9c5kdJC6ahjxpmSprYeWyjF+PEEs+OM3kXab0HDiQOFgnveks6Q4j1PuENI92pIMFJ
         WuTolzzfTJyLN5y08TR0Hc2QFSY/GlfLNv1KwdZds9kTeEiuUyC4KvVkOZ//q4pF0Bwb
         A+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723721350; x=1724326150;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=54Zuy7nrqOr7HzwudR7mUSOwh6Bt+KzFm1OF0/li1xk=;
        b=clI7HWpTyuS7eaNi/1/m0VPMZEq7/aMGGnxv8m9mouoaH+l6qTz5R6VHYIo1cJFXmC
         74zwUnqdLZ/iJCWsrCgNJAHFUFPcf9+UWGlDiEF+R+oYQyq5QvEMprClx8g7MVYkBLbl
         oss6LS3eJPVAZAyTXEukLRiOW6QnBj2a6d4YRfh8ZMNikclXh3LkGij3KtT/+ZTVgbHG
         uqNmtIJ6xs4qTrfB9bBuNggD/4DvtSAYZkYELLEvZRx58hLzrMMt6ddJMQjy1vNNw98J
         3DaWyciLPTozOR4lmsoV0t69mVURUpGemfLnRGxnW1XynDaDH9HkmSQPlx+288SoJAgd
         pqRg==
X-Forwarded-Encrypted: i=1; AJvYcCVCys3xVUyQK3iaFvTsTei8OIRmQ0RqALGsMzCowu2Xf2q1ww5/DJjKXP5ryTkxnkOOiT1tp4IQQmBwzKG6rAbZty8YqrWCOvBI6VuA
X-Gm-Message-State: AOJu0Yxr8DCYTqTens4JEieCMixWLPSp9qj4kp65dHKQLWMGQJ8bj8pj
	gCJKP+qaEMhv1RewW4QvIhbfVVvOq0MqwfjGZxZlTfUoXPjOHlgUgjuTOSwqEOJSLwwyAUOXden
	A
X-Google-Smtp-Source: AGHT+IHodIlI/PTrXRzPvp5z7NIYGt15OMaZASUJrA7ZoG5lrLvhWQzVLdVc0XUqFxReFzqVCQiEnA==
X-Received: by 2002:a05:6402:e81:b0:5be:9d95:3910 with SMTP id 4fb4d7f45d1cf-5bea1c7b6efmr3910351a12.22.1723721349606;
        Thu, 15 Aug 2024 04:29:09 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbbe26f1sm802131a12.3.2024.08.15.04.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 04:29:09 -0700 (PDT)
Date: Thu, 15 Aug 2024 14:29:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: James Smart <jsmart2021@gmail.com>
Cc: James Smart <james.smart@broadcom.com>,
	Ram Vegesna <ram.vegesna@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Daniel Wagner <dwagner@suse.de>, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] scsi: elx: libefc: potential use after free in
 efc_nport_vport_del()
Message-ID: <b666ab26-6581-4213-9a3d-32a9147f0399@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The kref_put() function will call nport->release if the refcount drops
to zero.  The nport->release release function is _efc_nport_free() which
frees "nport".  But then we dereference "nport" on the next line which
is a use after free.  Re-order these lines to avoid the use after free.

Fixes: fcd427303eb9 ("scsi: elx: libefc: SLI and FC PORT state machine interfaces")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From static analysis.  Untested.  But it seems low risk.
---
 drivers/scsi/elx/libefc/efc_nport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/elx/libefc/efc_nport.c b/drivers/scsi/elx/libefc/efc_nport.c
index 2e83a667901f..1a7437f4328e 100644
--- a/drivers/scsi/elx/libefc/efc_nport.c
+++ b/drivers/scsi/elx/libefc/efc_nport.c
@@ -705,9 +705,9 @@ efc_nport_vport_del(struct efc *efc, struct efc_domain *domain,
 	spin_lock_irqsave(&efc->lock, flags);
 	list_for_each_entry(nport, &domain->nport_list, list_entry) {
 		if (nport->wwpn == wwpn && nport->wwnn == wwnn) {
-			kref_put(&nport->ref, nport->release);
 			/* Shutdown this NPORT */
 			efc_sm_post_event(&nport->sm, EFC_EVT_SHUTDOWN, NULL);
+			kref_put(&nport->ref, nport->release);
 			break;
 		}
 	}
-- 
2.43.0



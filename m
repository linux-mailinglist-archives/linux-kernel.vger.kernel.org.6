Return-Path: <linux-kernel+bounces-515154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2E1A360F3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BA867A4CF4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A7926658B;
	Fri, 14 Feb 2025 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W5Ltf2hO"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364991862A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739545365; cv=none; b=WTblAxMH8bJnoNLKr3Exr5MmhGLcLoc59BY+kBO/VUYfQslYMo8/rHBtnkCxA6o3p2+1V0cHP6KDHowLtsAFix9bQ3ZquvImXhtWcvGlcEtM2LJksqcUq9rfBTm9FAtiy+4rPCwERd9NvYi+JgCux3joQLwjC8NFLWmjLrMhrkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739545365; c=relaxed/simple;
	bh=M2AdWFZSowZKSxyzGjq/UoprlB43WGCl7x/qQuT+Z/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxEr2pTNtyNyKanpBOAK3CP3qwR92YBO40geK+nckbk+SVnCn4HZrEQ8mTFGX6JGojlBuLtwKeOhUi1tqqHaS4seTcvy/EcohfDBeDERUgAVSlwpBejhC7dwdW1ydQW9yTUReEK7me+w0Vi53ciEnfN0jLSKSoDTvboQdARw1M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W5Ltf2hO; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5de38c3d2acso3485536a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739545361; x=1740150161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rN1gBf/mWgaHncz25lS93Sf5l5HPFOQDfhm85WlICA4=;
        b=W5Ltf2hORFy30PTfRYM4t+LKkEOPCXYCok/MnbChGSn7hltN0VpoGpzZKLOyNt/BNG
         kcG107kbAscoV9bRsD+BvV6BEukZoZoTYpeRxAOHGHNvmBhCaXAN6mNC4waQ0NbD3PYT
         3y8SFQuvQVSxQzDTNJAe2oWhb3RbG58e6d/LMRdk6QZr90j53QEPVOxB9sM3LJx8PYgf
         p7xTJAe5fPLE2yZ5pUex09dV3tkGPlb1L6JNmKfSIJD7m/Zxy5O65NP5kLvuOnR9/4s0
         dsjZflq0/GkFu/YSXwZioAWnm7kICkiKYLs4LVfYPLvCC4C8HpziGyZXeTiovB2VgI6Y
         QXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739545361; x=1740150161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rN1gBf/mWgaHncz25lS93Sf5l5HPFOQDfhm85WlICA4=;
        b=TRRmRZ1C4mWe6644PeBN45RN9GdTtpVXNTOCUbMGlD2iirjGQDJt/bHSDTP39yHR6s
         T8hlQGLm0xm2m4dUhxoRTdPaA6FIVCnu6pcp6dmFqfeCr0pJJk+G6aEsdsr5yX37MlWx
         U509ln9veyqXS2ypgpjRvK1p0sFvJdb8daGW7WrTT13PCwY/yIDcqjMB4yeTIBBGoZdf
         y64Kffu11U7LhjD48hbFqSP3g8FtzHNYQcSzRG5/e+ONZGExerKNrvt1IvMgJKkVkgH5
         iroZi+98m9BkdCvbXA+NfiG1qKQVzYIfPAQMIry+U1kj3kRxWpAq8eGReJbMrXFbw2G8
         4iWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1pYskQFRwcN/k/fubo/lZfY4Pz7GwlJdlQnUKZA4A//snHIz8/PUdDjEWGMWMVublw3MvrFJNAk9hMuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvy/TZrj7Fj82CDht/BbaqEbHEY6pXoqSV3Z8ImyezPr7eb2Mm
	z7dzcRB+wvCaXnFuxBFJia1dIoMNYwrMsvlkQU88T3QHL6e4rLStcPxtQGaCoBw=
X-Gm-Gg: ASbGncv8OJVd2meEx7Out8Y8T69D5LcPwPeqc+zh13EC595iL15TkmYmPtIkVTTxYA9
	ZFu73NwXeQSj/wOYf30B0rCBnQviOUCY5X/Ty24JF2/9IwWLkOaROsol8SCHvQvh6e0Z7hVvmDh
	MUc4chpHDKT+ZKre/38/YT6j1Bw+mH0PuKQGeMbDT+9m7xf9KO1KhaTdXPxlff1mHYy36AX4Qga
	4L0GEZyUXqOQ81Omsq1L3UxIv6ugnNP1O0JhW5jLZ+EHLtNF8JqFGq34PwODMwcW8K/zCtsjTgZ
	z88HcBd0J/RQYasAh0zZ
X-Google-Smtp-Source: AGHT+IFTRPVJe8Uo/fbtBUM/QHP6adG+ehpZXzG1dBG0m3OYN+ePtIDh3yC1U9YhL4jzIL0DQt25Gw==
X-Received: by 2002:a17:907:940b:b0:ab6:5210:7c8b with SMTP id a640c23a62f3a-ab7f347c1c0mr1333438866b.37.1739545360497;
        Fri, 14 Feb 2025 07:02:40 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aba533bdd96sm352439666b.165.2025.02.14.07.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:02:40 -0800 (PST)
Date: Fri, 14 Feb 2025 18:02:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Karan Tilak Kumar <kartilak@cisco.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	Gian Carlo Boffa <gcboffa@cisco.com>,
	Arulprabhu Ponnusamy <arulponn@cisco.com>,
	Arun Easi <aeasi@cisco.com>
Subject: Re: drivers/scsi/fnic/fdls_disc.c:263
 fdls_schedule_oxid_free_retry_work() warn: inconsistent indenting
Message-ID: <fd4d8516-5eaa-43b0-9100-2984312930f8@stanley.mountain>
References: <f1c717cf-63eb-402a-82cc-91c445055b97@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1c717cf-63eb-402a-82cc-91c445055b97@stanley.mountain>

On Fri, Feb 14, 2025 at 05:42:25PM +0300, Dan Carpenter wrote:
> 
> I guess we can't call schedule_delayed_work() without holding the
> spin_lock?  It's a strange thing.

Actually, I see now that we're just dropping the lock to avoid a sleeping
in atomic warning with the GFP_ATOMIC allocation...  I bet you could make
the code under the lock much smaller.  Just the test_and_clear_bit() stuff
basically.

regards,
dan carpenter

diff --git a/drivers/scsi/fnic/fdls_disc.c b/drivers/scsi/fnic/fdls_disc.c
index 11211c469583..ed141236a4aa 100644
--- a/drivers/scsi/fnic/fdls_disc.c
+++ b/drivers/scsi/fnic/fdls_disc.c
@@ -308,31 +308,22 @@ void fdls_schedule_oxid_free_retry_work(struct work_struct *work)
 	struct fnic *fnic = iport->fnic;
 	struct reclaim_entry_s *reclaim_entry;
 	unsigned long delay_j = msecs_to_jiffies(OXID_RECLAIM_TOV(iport));
+	unsigned long flags;
 	int idx;
 
-	spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
-
 	for_each_set_bit(idx, oxid_pool->pending_schedule_free, FNIC_OXID_POOL_SZ) {
 
 		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"Schedule oxid free. oxid idx: %d\n", idx);
 
-		spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
-	reclaim_entry = (struct reclaim_entry_s *)
-	kzalloc(sizeof(struct reclaim_entry_s), GFP_KERNEL);
-		spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
-
+		reclaim_entry = kzalloc(sizeof(*reclaim_entry), GFP_KERNEL);
 		if (!reclaim_entry) {
-			FNIC_FCS_DBG(KERN_WARNING, fnic->host, fnic->fnic_num,
-				"Failed to allocate memory for reclaim struct for oxid idx: 0x%x\n",
-				idx);
-
 			schedule_delayed_work(&oxid_pool->schedule_oxid_free_retry,
 				msecs_to_jiffies(SCHEDULE_OXID_FREE_RETRY_TIME));
-			spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
 			return;
 		}
 
+		spin_lock_irqsave(&fnic->fnic_lock, flags);
 		if (test_and_clear_bit(idx, oxid_pool->pending_schedule_free)) {
 			reclaim_entry->oxid_idx = idx;
 			reclaim_entry->expires = round_jiffies(jiffies + delay_j);
@@ -342,9 +333,8 @@ void fdls_schedule_oxid_free_retry_work(struct work_struct *work)
 			/* unlikely scenario, free the allocated memory and continue */
 			kfree(reclaim_entry);
 		}
-}
-
-	spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+	}
 }
 
 static bool fdls_is_oxid_fabric_req(uint16_t oxid)



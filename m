Return-Path: <linux-kernel+bounces-538177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AC4A495AD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F5B161488
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA55B257AEC;
	Fri, 28 Feb 2025 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RShMBrKZ"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DC32566E4
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735456; cv=none; b=OUqlrZNTMNPYNec+efAft+ID25YVdSKhHCpNr4fZPk7EMjl+HQ6vrPx8RfyBHlLWnanb0GEMJBdoOH9nP526ZkmqvBzqWo/rbm7e4lgBTnQTDCF3vzx7u5T48Hzkl0W6fR0s1ZpiZL1r83Wntz0o/LuTmVZYo4iLjWPehCEw3Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735456; c=relaxed/simple;
	bh=mXhku7IHghHzgD5uOXEgBnRnYCvInJFCk9RjXNz+DvU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pei0LhaUNs4CtNjqh4HmHRlYXIzl6B3JAr+UQbIZ7TTJ5m43GOT0SAjUopmrsbebH6zpo4FEiLU/rcI6YLMFjcgjy/q0Hug+jy1jtjhgjWMxQB/LqVcRkI3m7AFWW/lnCOha5vU0ICakjQZCZG3afC28AzfuTTwa/UB4dYV+2jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RShMBrKZ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e0573a84fcso2708978a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 01:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740735453; x=1741340253; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AF5nsT/tqJ0sa2KfZr17M52RbC0HR9O1oH21NA6kGQc=;
        b=RShMBrKZa4frQH1WfVRbDnLv0oUQPpVhAi4h8RWZTs9uX2YvDH9G5WQeTpu4aMTAYF
         LO/H34ljYqumzEW39GOSL/mnyekQiCtaMgHPygeub9nbXEE44OHDu9eBqTG0KEmUSEVC
         huMMPzwhi/sbG6V1TxocxBfZuY1iFRVOFSthB4o0GKKWUAuXJq+h6CgJViLcxwsNOFJl
         JYnCuZYbJh0V6NIfQS+IjsOYRqC+4skk6h+fny+vaaGwtWX3D3sbKgfTyH2jVmuYZJHM
         JJBEWwvtYDDFShhwc1FTiB+rYl2Cou2aqkEn/MxWzC2athtDFbD9zDn80tdrKsiqANpJ
         c0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740735453; x=1741340253;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AF5nsT/tqJ0sa2KfZr17M52RbC0HR9O1oH21NA6kGQc=;
        b=iwlKqBCmj+Zthvgl8vN0bKbodxZ77JcVkMo4hp7tS11424Wb0mreBduNUT6a8OZ+Ib
         PEhDsCNM7KN6Jf/JtJ/5umsa2Slsmqsh6XrTB8uJhldDrnf2Q4btJ1dGm5gD+hr4t1Yy
         aRGO/iCzlR6G0QZUKKYjy0cOftOZ/Zln1S1i62glubNUwPVlyHTC2waz+tlcfzLKIto3
         xaPnyChOiU6MnAdhjR0o+8X5k5X9pfDgIDInxxChMDzxfvVySlZ+YnSNcAZ7UQCtwCrH
         iLlQ8f2/XaeHQ4Zq4mRdVIEo2XAEn+hTy7Mee5hltv0Vu/aRJwZWE1nDFTSveBIG0qp9
         6Vbg==
X-Forwarded-Encrypted: i=1; AJvYcCVRebbiIKpBjXoi2vci2ExD7BgtmEzWYls6X2yFldGyWa708ar9nrbckK3a+9pNrNco7a3cvDNkyP4+noQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzgMTn77Bypr7ZxJwn6aCIgVZtiiRUyXdqvk0yGmR/9o63hoWL
	i6HuX45bi/ln3Uq8yvDjwL7cwX43bb108A4QWRhK75WGLjR+ETx5uO9uhO9sNAE=
X-Gm-Gg: ASbGncvtJrzi4JVRi58HUCWE4tmMhM0piJkCPHEuVU2cfF9e1b3FMTs+gbFjg/sGInC
	cH1ZQNVH75mtaDvhxzojn4dZD52GvAfPzxYk7oJ4y3DRfm8VmRRXvcO4CA6yAZDaH+xJU3h5rpH
	71sKMyV0DC5poxF+bl6HwBRab8FdV1RK/tr2NqBa1dMES9YteAL8aBxc+jQZWewvhxeb7QO6MBP
	Pe/27S8OxWGUdvl8Tp47z9O1XGVC1d/g2iyuchClUGPnSBdXSRSoszzEWE5nUN7OIJCGeuGvYEP
	SJvCzwO9WFPOKjGlefznsnOBE2q50vM=
X-Google-Smtp-Source: AGHT+IH0rbUhLFGAEfY+tGINt28wIT6ZI81UIlrbwU1hKXYL7titFBMGZMuaFvwZupi/juouiULxXw==
X-Received: by 2002:a05:6402:2813:b0:5e4:9348:72c3 with SMTP id 4fb4d7f45d1cf-5e4d6af105cmr2172188a12.10.1740735452591;
        Fri, 28 Feb 2025 01:37:32 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5e4c43a4e26sm2229958a12.66.2025.02.28.01.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 01:37:31 -0800 (PST)
Date: Fri, 28 Feb 2025 12:37:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Cc: Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] scsi: mpt3sas: Fix buffer overflow in
 mpt3sas_send_mctp_passthru_req()
Message-ID: <02b0d4ff-961c-49ae-921a-5cc469edf93c@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "sz" argument in mpt3sas_check_cmd_timeout() is the number of u32,
not the number of bytes.  We dump that many u32 values to dmesg.  Passing
the number of bytes will lead to a read overflow.  Divide by 4 to get the
correct value.

Fixes: c72be4b5bb7c ("scsi: mpt3sas: Add support for MCTP Passthrough commands")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/scsi/mpt3sas/mpt3sas_ctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index ff8fedf5f20e..063b10dd8251 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -3017,7 +3017,7 @@ int mpt3sas_send_mctp_passthru_req(struct mpt3_passthru_command *command)
 	if (!(ioc->ctl_cmds.status & MPT3_CMD_COMPLETE)) {
 		mpt3sas_check_cmd_timeout(ioc,
 		    ioc->ctl_cmds.status, mpi_request,
-		    sizeof(Mpi26MctpPassthroughRequest_t), issue_reset);
+		    sizeof(Mpi26MctpPassthroughRequest_t) / 4, issue_reset);
 		goto issue_host_reset;
 	}
 
-- 
2.47.2



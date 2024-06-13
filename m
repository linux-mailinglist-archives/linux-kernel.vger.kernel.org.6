Return-Path: <linux-kernel+bounces-213931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F7E907CAF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D543E1C2231B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202B214D6EB;
	Thu, 13 Jun 2024 19:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5QAehiW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF691474A8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718307260; cv=none; b=s3sPCeEqcOpfEoNdUewsFR1BJgPZq059jpOkUaDVMKcBrcJT1oJFPbP7L8JETv7KsomFIpRFGITU9LfLmNoDhoGter9DqTCy+NxVZ/MF3TJQjADGNardEsC0udSVxhjaOnTNkyd9YIAqGakmPObZ/YfImg3+Gpq6ZAdm+1GJtws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718307260; c=relaxed/simple;
	bh=7aG7kDyVxZ+xKhQ+yxWUmVgAOGSJ6gommzR9sbbVuMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGSQ2iqgMDsTlZOce7asJoZQAX9n5L/3bzPmAa+HIVcimyTASka4lUK9a0OBMX+K8HvMBU3ygyXk4MHTdyr5brDbUyr2CYtQBQKwnZ9QIaD2NdUyzRZYPfwE0fwSDInr+TLhOCUqZJsX7jNr3CLzXkvX1/ECdBr3zjRfjNCzwM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i5QAehiW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718307257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/IsYvLqgq+E3FY1k2F2Fg9bKLYI4WtRPTLB94zlxiIg=;
	b=i5QAehiWG9IHpX9BaE6WNpALHW42Wwz/QrUC4TSsqK43fx6MviyVB7r/SsWVus5cXLYrpy
	6ZS/YMoKauj+hHGu4PFv+yi0HMxJ13zp9riAjBkD2e6m36a3TB+t1VqzdaoP9odCL0TASh
	xQBRKc47bGDYO4/n+xIz1wOBWR8VEdo=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-gIfM_Ai-N3qrrdUE-CjFCA-1; Thu, 13 Jun 2024 15:34:16 -0400
X-MC-Unique: gIfM_Ai-N3qrrdUE-CjFCA-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-62f4a731ad4so27420217b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718307255; x=1718912055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IsYvLqgq+E3FY1k2F2Fg9bKLYI4WtRPTLB94zlxiIg=;
        b=Z1V2+A/lSDwGnOgGI8xC6BYRMEjcm/HZptSQItx25fuppDFE1Rir5Ma2YScaGnakD0
         rYOO+w4zt5V4Px8rQzSNVO56taR/ehzWT9ZMZ63P+pmz5mliwUNtaOLWq1mPzDN+UcCX
         dAeOpQGAyUQCsXGi/+BSF+hivm6rrxv845yFt75O1+8WiijNISI0ruq9G5CpMsEKQAC4
         TlfiQc88C1V1LhHRmdCx5Hrwk6XdXEu8EKGbalxQvwVXmUfqorEJ1xE/pgdLOgSwaJ6B
         kGOz2stWagkmAtHcc0qL8JNV+mtQSsUzcedI/3JC/Ox65iA04/0yWMt+lgAh/4GFcc2x
         reCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWvaSSMUa5tVzslnRrqDt0PUBaDE4gbMBX0eCkBHLImmrT+xwF8cqrIQeNTSsccaxxNNhfC4VeYH1l4gYGEsXUH47xeuoIhE6Veuqo
X-Gm-Message-State: AOJu0YyE2V65QZjXf82PZQl4fMcCI7geYe8p+ZO/eYrYp5/yx1jJtVsp
	4LMzsQaH9XQbZNfSjS5XPtVXUE4UOYOVyQc1vx6Vw9p+99HqcWpvlOkZVUnOTz6padXU7g1Lh0V
	khd0EGp7WKomEwbrgH7WmmSFBngJIC2dgkFSqIItTAmeG18W+TdWX3DeACzJyqraAJiuuXA==
X-Received: by 2002:a25:d041:0:b0:dfb:96e:1f15 with SMTP id 3f1490d57ef6-dff1549168cmr469717276.42.1718307255322;
        Thu, 13 Jun 2024 12:34:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr91FD/R6YxAjrE+liHylnQVNjnoxStaUZFpGCZ5A09J3aRTJXCfWk80vcxy79HA4dylVI2Q==
X-Received: by 2002:a25:d041:0:b0:dfb:96e:1f15 with SMTP id 3f1490d57ef6-dff1549168cmr469682276.42.1718307254907;
        Thu, 13 Jun 2024 12:34:14 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c27786sm9995666d6.55.2024.06.13.12.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 12:34:14 -0700 (PDT)
Date: Thu, 13 Jun 2024 14:34:12 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Joel Slebodnick <jslebodn@redhat.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org, 
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com, peter.wang@mediatek.com, 
	manivannan.sadhasivam@linaro.org, beanhuo@micron.com
Subject: Re: [PATCH] scsi: ufs: core: Free memory allocated for model before
 reinit
Message-ID: <6krasewc6bps43ivmk6eez2v7clnpoxczpctnp7jhgthpjpaqz@hk2yip3wknsc>
References: <20240613182728.2521951-1-jslebodn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613182728.2521951-1-jslebodn@redhat.com>

On Thu, Jun 13, 2024 at 02:27:28PM GMT, Joel Slebodnick wrote:
> Under the conditions that a device is to be reinitialized within
> ufshcd_probe_hba, the device must first be fully reset.
> 
> Resetting the device should include freeing U8 model (member of
> dev_info)  but does not, and this causes a memory leak.
> ufs_put_device_desc is responsible for freeing model.
> 
> unreferenced object 0xffff3f63008bee60 (size 32):
>   comm "kworker/u33:1", pid 60, jiffies 4294892642
>   hex dump (first 32 bytes):
>     54 48 47 4a 46 47 54 30 54 32 35 42 41 5a 5a 41  THGJFGT0T25BAZZA
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc ed7ff1a9):
>     [<ffffb86705f1243c>] kmemleak_alloc+0x34/0x40
>     [<ffffb8670511cee4>] __kmalloc_noprof+0x1e4/0x2fc
>     [<ffffb86705c247fc>] ufshcd_read_string_desc+0x94/0x190
>     [<ffffb86705c26854>] ufshcd_device_init+0x480/0xdf8
>     [<ffffb86705c27b68>] ufshcd_probe_hba+0x3c/0x404
>     [<ffffb86705c29264>] ufshcd_async_scan+0x40/0x370
>     [<ffffb86704f43e9c>] async_run_entry_fn+0x34/0xe0
>     [<ffffb86704f34638>] process_one_work+0x154/0x298
>     [<ffffb86704f34a74>] worker_thread+0x2f8/0x408
>     [<ffffb86704f3cfa4>] kthread+0x114/0x118
>     [<ffffb86704e955a0>] ret_from_fork+0x10/0x20
> 

With the following in place:

    Fixes: 96a7141da332 ("scsi: ufs: core: Add support for reinitializing the UFS device")
    Cc: stable@vger.kernel.org

feel free to add:

    Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> Signed-off-by: Joel Slebodnick <jslebodn@redhat.com>
> ---
>  drivers/ufs/core/ufshcd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 0cf07194bbe8..a0407b9213ca 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -8787,6 +8787,7 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
>  	    (hba->quirks & UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH)) {
>  		/* Reset the device and controller before doing reinit */
>  		ufshcd_device_reset(hba);
> +		ufs_put_device_desc(hba);
>  		ufshcd_hba_stop(hba);
>  		ufshcd_vops_reinit_notify(hba);
>  		ret = ufshcd_hba_enable(hba);
> -- 
> 2.40.1
> 



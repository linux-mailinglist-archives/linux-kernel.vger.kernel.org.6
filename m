Return-Path: <linux-kernel+bounces-218510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E53190C121
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1841C21456
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA33DDA0;
	Tue, 18 Jun 2024 01:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JQTawzsd"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2081E4C6D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 01:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718673210; cv=none; b=EpvYu/pfr+HF5JDiq//ZdgEW581pRPxm9gTB1PyRkpJhXVZfHzZDKIUodORvfOXcFa8XKHa4cIjcN1hFEZ/9L8fxMvOm1+v7UJcw5v6h1Tjt2wUgQXsr8m6QgqmbMj78WQZznEowmO0pt0OrHkdRKyCfJRmPSD0q5izX7uT81K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718673210; c=relaxed/simple;
	bh=UgQKWMweYegWbphbeurOe+yKcM6omTSeSzhX7x5ur3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+sb1UyYWGPojbXRHTQhAHo2O9DXtynKYhaRYSoV8EiQZeHYfhkO+heTFZMhwpAb21VDrKWABpkTMayvhn6gszGW7a6qR0zM00DSFeWvnbMybyDHlBPJpj9/SnH166Ju2ywOWg92H5fFlmraNBbYaOExAz77WCHKmhon0j6BRo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JQTawzsd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f44b441b08so36458475ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718673208; x=1719278008; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XueetR4VJZ9UVBgD570LhnSEwoNPilSpxdPqN0y/iw0=;
        b=JQTawzsdU2QJA/m8FKIDOVJBuHZWknMrPg3pDTGzyW2dtGL7t1lkH+edBn79DQs68g
         hG3KbfjSxS3xyWdPRp9MIeYZ8U0ERTZU+IlHf818pWh9iIHBC6ug4R1K9qg34OCbdUr8
         QRCTuGav/dquSsrNypPCB3rVHKCz3UK79lqmq+ti5UdlDK4o+x7/Ie17KKJS82EVF5xr
         NkcHTfyvC4HgDiJ4UoftSCZ2wV/a12rjoa94W7N45S1DVYeZQEndie4y0Ws/f1bryYK4
         z8k6DrdHCNRlHT0BG6voiCNo7+MG1iAkBV12GLD48uuKgHHp52TamsjU0WgVhf5SnYaE
         y80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718673208; x=1719278008;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XueetR4VJZ9UVBgD570LhnSEwoNPilSpxdPqN0y/iw0=;
        b=BrV0kOJQrMwxCgGgg24gM6HfRaMU3YNQuixgxGgsryFtQY8Afq5XZB7GtlWPde115k
         2gAkKht3DgImGu6T8UjX0mIaRRfDjNU7w5z/ynckdzkUNDKsraJQdmbQ9EJKdoLQmjGd
         WAa5xauMasJIm0jSJStEMO0ee8BcrKFemWSYdgZ6IXZoxBPkB2NRk/31DOlqLasc8WfR
         t+NVX/OQy+8ROcO1oYaV2vYoQ5mc4OZVvjVLP2OZrzES5C4donQZtjZh4QDDWxhjFWn3
         fqxgFpCnTmLqMJvwsscRUq7gp4eltLP44XUo5ataavZ+YwIRjMYvoADjDt2o1h2qOn0k
         Yu/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWATNjQws+0X9G4f3WBk1RD8F4PqjBxKDuN3WxkRvgkFgyK70fYJ6AVOEhHnZ8ZBpImDPWVgI3kYnCITnvGR1nET59m/ZNLddVdUptJ
X-Gm-Message-State: AOJu0YyN3SjCsULe9dn5rBPXz7In7BxoQDae740UCB9uvS3krmaIoaGj
	464B2bYVoOylYp3ZVlx5evwiP3TEpjcAG9p0n7cq0mF7vtKyYVugLwnLIyeorg==
X-Google-Smtp-Source: AGHT+IHW19R9wHiTKWlkyt16Mn7WGJH/ANvsoWPbF6NAtcZYt/4DxpShctw1zwCMvdbHalomgntDlA==
X-Received: by 2002:a17:902:ce8c:b0:1f6:daa6:e774 with SMTP id d9443c01a7336-1f862a0605amr147739525ad.61.1718673207946;
        Mon, 17 Jun 2024 18:13:27 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f3d3a0sm85370545ad.271.2024.06.17.18.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 18:13:27 -0700 (PDT)
Date: Tue, 18 Jun 2024 01:13:24 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] ata: libata-scsi: Generate ATA PT sense data when
 ATA ERR/DF are set
Message-ID: <ZnDfNLBwsG6zFJ4-@google.com>
References: <20240614191835.3056153-1-ipylypiv@google.com>
 <20240614191835.3056153-3-ipylypiv@google.com>
 <b87d51d8-5a89-480e-b229-7750c241aa6f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b87d51d8-5a89-480e-b229-7750c241aa6f@kernel.org>

On Mon, Jun 17, 2024 at 08:22:07AM +0900, Damien Le Moal wrote:
> On 6/15/24 04:18, Igor Pylypiv wrote:
> > SCSI/ATA Translation-5 (SAT-5) Table 209 — "ATA command results"
> > specifies that SATL shall generate sense data for ATA PASS-THROUGH
> > commands when either CK_COND is set or when ATA_ERR or ATA_DF status
> > bits are set.
> > 
> > ata_eh_analyze_tf() sets AC_ERR_DEV bit in qc->err_mask when ATA_ERR
> > or ATA_DF bits are set. It looks like qc->err_mask can be used as
> > an error indicator but ata_eh_link_autopsy() clears AC_ERR_DEV bit
> > when ATA_QCFLAG_SENSE_VALID is set. This effectively clears the error
> > indication if no other bits were set in qc->err_mask.
> > 
> > ata_scsi_qc_complete() should not use qc->err_mask for ATA PASS-THROUGH
> > commands because qc->err_mask can be zero (i.e. "no error") even when
> > the corresponding command has failed with ATA_ERR/ATA_DF bits set.
> 
> If there was a failed command, qc->err_mask will be non-zero since the command
> completion will be signaled by an error interrupt. So I am confused here. Are
> you seeing this happening in practice ? If yes, doing what with which  adapter ?
>

Yes, this is happening in practice with the PM8006 adapter. ata_eh_analyze_tf()
sets AC_ERR_DEV and later ata_eh_link_autopsy() clears AC_ERR_DEV making
qc->err_mask == 0.

ata_eh_link_autopsy()
  \
   `ata_eh_analyze_tf()
            if (stat & (ATA_ERR | ATA_DF)) {                                        
                    qc->err_mask |= AC_ERR_DEV;     <<< set AC_ERR_DEV                                   
                    /*                                                              
                     * Sense data reporting does not work if the                    
                     * device fault bit is set.                                     
                     */                                                             
                     if (stat & ATA_DF)                                              
                         stat &= ~ATA_SENSE;                                     
    ...

<cont. ata_eh_link_autopsy()>
        /*                                                              
         * SENSE_VALID trumps dev/unknown error and revalidation. Upper 
         * layers will determine whether the command is worth retrying  
         * based on the sense data and device class/type. Otherwise,    
         * determine directly if the command is worth retrying using its
         * error mask and flags.                                        
         */                                                             
        if (qc->flags & ATA_QCFLAG_SENSE_VALID)                         
                qc->err_mask &= ~(AC_ERR_DEV | AC_ERR_OTHER); <<< clear AC_ERR_DEV



> > Additionally, the presence of valid sense data (ATA_QCFLAG_SENSE_VALID)
> > should not prevent SATL from generating sense data for ATA PASS-THROUGH.
> 
> Same here, this is strange: ATA_QCFLAG_SENSE_VALID indicates that we have sense
> data for the command, regardless if the command is passthrough or not. So if
> that flag is set, we should not overwrite the already valid sense data with
> sense data generated from the error and status bits.

Sorry about the confusion. I meant that the "ATA Status Return sense data
descriptor" is not getting populated when ATA_QCFLAG_SENSE_VALID is set
and CK_COND is 0.

What you described is true when CK_COND is 0, however, when CK_COND is 1,
existing code will call ata_gen_passthru_sense() without checking
the "need_sense" value. This will generate fake sk/asc/ascq regardless of
the ATA_QCFLAG_SENSE_VALID flag.

> Do you see an issue without this change ? If yes, what are the adapter and
> operations you are running ?
> 
Yes, we see the issue on PM8006 adapter.

Any failed ATA PASS-THROUGH command with CK_COND=1 has this issue. For example,
Sending READ SECTOR(S) EXT via ATA PASS-THROUGH with CK_COND=1 to an lba
that was previously corrupted by WRITE UNCORRECTABLE EXT is supposed to
return "READ ERROR - LBA MARKED BAD BY APPLICATION CLIENT" but instead it
returns generated "UNRECOVERED READ ERROR - AUTO REALLOCATE FAILED".

> > 
> > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > ---
> >  drivers/ata/libata-scsi.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index 032cf11d0bcc..79e8103ef3a9 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -1632,8 +1632,8 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
> >  		!(qc->flags & ATA_QCFLAG_SENSE_VALID);
> >  
> >  	/* For ATA pass thru (SAT) commands, generate a sense block if
> > -	 * user mandated it or if there's an error.  Note that if we
> > -	 * generate because the user forced us to [CK_COND =1], a check
> > +	 * user mandated it or if ATA_ERR or ATA_DF bits are set. Note that
> > +	 * if we generate because the user forced us to [CK_COND=1], a check
> >  	 * condition is generated and the ATA register values are returned
> >  	 * whether the command completed successfully or not. If there
> >  	 * was no error, we use the following sense data:
> > @@ -1641,7 +1641,7 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
> >  	 * asc,ascq = ATA PASS-THROUGH INFORMATION AVAILABLE
> >  	 */
> >  	if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
> > -	    ((cdb[2] & 0x20) || need_sense))
> > +	    ((cdb[2] & 0x20) || (qc->result_tf.status & (ATA_ERR | ATA_DF))))
> >  		ata_gen_passthru_sense(qc);
> >  	else if (need_sense)
> >  		ata_gen_ata_sense(qc);
> 
> -- 
> Damien Le Moal
> Western Digital Research
>

Thank you,
Igor 


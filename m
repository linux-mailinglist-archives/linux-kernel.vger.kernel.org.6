Return-Path: <linux-kernel+bounces-220269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B02490DEAF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3414CB219F9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B37178CEC;
	Tue, 18 Jun 2024 21:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XbsPJ0bZ"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1DD178393
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 21:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718747516; cv=none; b=ssiuCRnJ56+f1gI04mjR8DjO38haxyGVG5DPR7a80V4gYYlE/jtpU11kIVtmhgd85G3y62IvSfSnULEnVwRcFnWno+BEOMlxlAdVMIrwLB+K6xQJVes2q0ceKqUN87DcpUd1fD5SK4mpPYxl/8dEOMB3kLR0hJ9+gDNpwaxDzsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718747516; c=relaxed/simple;
	bh=CqEFvUi33IeiyrhXnQTeKtS4O31jbgZDt3BX58FEWeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5ZQCA4QbejPObztHUQb030MITcKZOwdkuvWukEnfbvRF4D/9rUMjxVlTixyKRf91MCSwhJd7Js4Ga8KgL9VYuRZqyNh7WVqmzLj/6S8sKG3ljICK/UPA1iGoMulB6Gx40yZpK7du4p8rczs8JKKqC2GsHHKIW5na9Ia+NNEXw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XbsPJ0bZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f4a5344ec7so1941535ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718747515; x=1719352315; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EddmKaQNzlzVYw97ZqD0XqGEPD+yJIIQwz4mjKY5K9o=;
        b=XbsPJ0bZlGkPabr3lwyeqA+kh04DcJNMpw+I66nzLnHrnMlvIZGQHPImcN5zy6Grkt
         yu/OINrQycKHs1slW/n1sLcyDT0G3yJ5krKOZWXQbuwOgYdIuFcrEnCtqlhd+C0ZiUc+
         XCAuIGnYr+WjTPYEkN/vT0XOV8J7OyYmKiM80X6rEYiofCvW0vW4b5pS8t8kNmOJH5eQ
         EUMbXwDGccIFU3tkQhEZ9Hmct7AiNJaUHaRyx4+UICDm+6aIVKernlz9aux0hkA+oCas
         wxsoS21+JcPo48XiPC8GblUw+dtQXBJC1lFh8EZO9zMl8tXBV4VeVjgZW5VtjqHCjROW
         fLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718747515; x=1719352315;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EddmKaQNzlzVYw97ZqD0XqGEPD+yJIIQwz4mjKY5K9o=;
        b=iQlOI6j+QZrVFoZ4ywTqtBt99MvSkv+xK7tdMXevfiONVWzcQGwgv/0vabC2riGJZP
         ytD/uW1rMeigWC9lJb5cK+7fS+g9TdIakqqyUPfZpVqqVlLWYqAAn1vY2fBSVLVCnAvt
         JIIZ+8DbOwCGF/hgFH5CVzxjHBtG9ivmRcKxX0s7L5zmNXqbp+KXfeFyAXX/GNkrPV7w
         Qle4YhQzaa9B10z3ZxschI25ZWjuAQbc5PxyeE1upvDZXgLk+9+X4+YK2E2MjiaNdxkg
         08ugDB8fErB8dqxycsfKK9/uek7iB2jMhGO1lLHDuTjUinEdTQbEQ1EbEJztNJy94I6y
         mgqg==
X-Forwarded-Encrypted: i=1; AJvYcCUDB+94UOIqBzG42h0nwP3Zr3c27JYIS+CuiWk59iPe+EiuxW7iVw3uOBpxDZsGVhu3Jl6aaAhFn2nOBBBB1NrC8ld+BPslVO1Qidey
X-Gm-Message-State: AOJu0Yx3ZD+mFF5ydqoHYp3TrvIv+p/V12xGiLm0wJ3jbNoHd2axbWSo
	6bt9XeSvJhB9sN7Afn7Hzq047e8wehpcUaU1QmO042pxNUzed/7C1u9ebuS6KQ==
X-Google-Smtp-Source: AGHT+IEahqloPwk/x+cxkcUdOMw9blmlZPj21bv+8g7c1W4xGTEgDa7RaRW5k+YLnvFsL/M6J5PKYg==
X-Received: by 2002:a17:902:ea12:b0:1f6:8c90:3521 with SMTP id d9443c01a7336-1f9a8d419a0mr13655185ad.8.1718747514093;
        Tue, 18 Jun 2024 14:51:54 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e704desm102517345ad.75.2024.06.18.14.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:51:53 -0700 (PDT)
Date: Tue, 18 Jun 2024 21:51:50 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] ata: libata-scsi: Generate ATA PT sense data when
 ATA ERR/DF are set
Message-ID: <ZnIBdj02yKFz4sK8@google.com>
References: <20240614191835.3056153-1-ipylypiv@google.com>
 <20240614191835.3056153-3-ipylypiv@google.com>
 <ZnAeFbdt02zge2my@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnAeFbdt02zge2my@ryzen.lan>

On Mon, Jun 17, 2024 at 01:29:25PM +0200, Niklas Cassel wrote:
> On Fri, Jun 14, 2024 at 07:18:33PM +0000, Igor Pylypiv wrote:
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
> 
> The reason why libata clears the err_mask when having sense data,
> is because the upper layer, i.e. SCSI, should determine what to do
> with the command, if there is sense data.
> 
> For a non-passthrough command, this will be done by
> scsi_io_completion_action():
> https://github.com/torvalds/linux/blob/v6.10-rc4/drivers/scsi/scsi_lib.c#L1084-L1087
> 
> 
> However, if there is any bits set in cmd->result,
> scsi_io_completion_nz_result() will be called:
> https://github.com/torvalds/linux/blob/v6.10-rc4/drivers/scsi/scsi_lib.c#L1052-L1053
> 
> which will do the following for a passthrough command:
> https://github.com/torvalds/linux/blob/v6.10-rc4/drivers/scsi/scsi_lib.c#L969-L978
> which will set blk_stat.
> 
> After that, scsi_io_completion() which check blk_stat and if it is a
> scsi_noretry_cmd():
> https://github.com/torvalds/linux/blob/v6.10-rc4/drivers/scsi/scsi_lib.c#L1073-L1078
> 
> A passthrough command will return true for scsi_noretry_cmd(), so
> scsi_io_completion_action() should NOT get called for a passthough command.
> 
> So IIUC, for a non-passthrough command, scsi_io_completion_action() will
> decide what to do depending on the sense data, but a passthrough command will
> get finished with the sense data, leaving the user to decide what to do.
>

Thank you for the detailed explanation, Niklas!
I was looking at a related logic in ata_eh_link_report():
https://github.com/torvalds/linux/blob/v6.10-rc4/drivers/ata/libata-eh.c#L2359-L2360
 
Is my understanding correct that if we have ATA_QCFLAG_SENSE_VALID set and 
qc->err_mask is zero then we don't want to report the error to user since
SCSI might decide that it is not an error based on the sense data?

> 
> > 
> > ata_scsi_qc_complete() should not use qc->err_mask for ATA PASS-THROUGH
> > commands because qc->err_mask can be zero (i.e. "no error") even when
> > the corresponding command has failed with ATA_ERR/ATA_DF bits set.
> > 
> > Additionally, the presence of valid sense data (ATA_QCFLAG_SENSE_VALID)
> > should not prevent SATL from generating sense data for ATA PASS-THROUGH.
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
> 
> qc->result_tf can only be used if qc->flags has ATA_QCFLAG_RESULT_TF set,
> otherwise it can contain bogus data.
> You don't seem to check if ATA_QCFLAG_RESULT_TF is set.
>
> ata_scsi_pass_thru() does set ATA_QCFLAG_RESULT_TF.
> 

Thanks for pointing this out! Looks like ATA PASS-TRHOUGH case is fine
since the flag is always set by ata_scsi_pass_thru() as you pointed out.
Do we still want to add the check even though we know that it is always
set by ata_scsi_pass_thru()?

If the answer is "yes", I wonder if we should use the ATA_QCFLAG_RTF_FILLED
flag instead? Currently it is used for ahci only but looks like it can be
expanded to other drivers. inic_qc_fill_rtf() will benefit from this change
because it is not always setting the status/error values:
https://github.com/torvalds/linux/blob/v6.10-rc4/drivers/ata/sata_inic162x.c#L583-L586

For the non passthough case qc->result_tf in ata_gen_ata_sense() is also valid
because fill_result_tf() is being called for failed commands regardless of
the ATA_QCFLAG_RESULT_TF flag:
https://github.com/torvalds/linux/blob/v6.10-rc4/drivers/ata/libata-core.c#L4856-L4873

In this case using ATA_QCFLAG_RTF_FILLED will be more accurate because
fill_result_tf() is being called even when ATA_QCFLAG_RESULT_TF is not set.

With that said I'm not sure if it makes sense to update all of the ATA
error handling to start checking for the ATA_QCFLAG_RTF_FILLED flag.

What are your thoughts on this?

> 
> >  		ata_gen_passthru_sense(qc);
> >  	else if (need_sense)
> >  		ata_gen_ata_sense(qc);
> > -- 
> > 2.45.2.627.g7a2c4fd464-goog
> > 

Thank you,
Igor


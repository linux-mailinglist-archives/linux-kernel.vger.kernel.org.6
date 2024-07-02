Return-Path: <linux-kernel+bounces-237182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BE391ED20
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 04:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70CFA1F21B0A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 02:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637021756A;
	Tue,  2 Jul 2024 02:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KEOQkZXb"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DC264D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 02:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719888662; cv=none; b=IwY0zuuZvyKVbgfpxmIPmuHIN69SdFSovGtA3n3rRwxXvTMfAtDjVRpt5ZR8Ghw4nh3A2CuM31JBda1a980X/iLtqT/NUR3NcNQ5znqK3InVkClxp2t0a22ksiGiVaX0DYIOVcOACW4ELIuDjNTVLnFbhF/kKP0LeRGupCI6PXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719888662; c=relaxed/simple;
	bh=dI4FUUfMjl69PrOL983cIvqHwtYC/LP2jgUv1UMPb4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buxF+qEdQKna+76j79sPkkULkrlaDzHdJtqNwOa7UMGJYfysQp5bw4CYeL6X15kuXP+YNihFSzDgJMZr+gkqofPaSMnxQUcYGDhBh2Bgq19biNHPASW5IIAOPPgnXjAnJm/9joa0V+N0ucarLExjA5uRwY/v2bCz9+FReF27okc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KEOQkZXb; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-707f9c3bd02so2414873b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 19:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719888659; x=1720493459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nBp88gZrUa2YS7lo6hEmRMUQenqjZqceKeedcGibfdc=;
        b=KEOQkZXbdHMQKAMmA8s+fZDUnapasIIQlXOqJRuy7fE2l4u/1FnOLd5oy/0splC6oV
         B1ScMcNB1auB2GuQWE148z6cXritZM3BxCsHuX0cOyDhN7lmW9jFwTI377Nc/g4QY+eU
         HOAEHM7Qj++eK++Gaxhz6B97ReKVU+GkghOtlnOTdEQs2de9EdV6K0uRWQ3JLmQsQEnT
         cpVm0eC+OviBuUVwaElc3CtdD7c5djEiJiKmS1NltdrQbPDKr558M0TBS8IcqnLUAxzN
         jhNLQsybPmAObbOchbpRS/XzOK7OojEHOqvosB23PwzBETnRLfKcrqgaJi9oCQ2rmYrg
         3/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719888659; x=1720493459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBp88gZrUa2YS7lo6hEmRMUQenqjZqceKeedcGibfdc=;
        b=F0T8axfaMrR9f6+5+E+1K5yzQGEjo3OdIT8S3SOAE2AmSYTVpiO8yttQvXq6c41A2Y
         y71LZU+/xvpGy+L91B6ssmAadYK9n0NrnjpAlIr8mN8oQX95PDMU21JrGIvedTTt1YdT
         fHv7CyDH/Wa1wEUrD3xItyq5gLRE9SUDQZnLEq+LN410KCym+pKuLa2NPpRQtANtjxBU
         nW2b7qMaOX4/z+QzYuLHV42cDL9IZiCJ0BR/2spEo7ga/jCq8DkRFEjck4ps0yoZmBMc
         lBWVeKGh8zY0EmxNGwaJKDtYxO86Uh/UX6UJH//jz6nfku+1dJ517pqLvgh9w3D8JOP5
         TgtA==
X-Forwarded-Encrypted: i=1; AJvYcCVtrNJvXbVC/pbnyCPZONhoLR6BvB1j6gTh6bd6Q6913WPIebPQNz+lJHlC818eWoy2uOTChbpvP1QWibBHBwsGc8OubBkKd1peYweP
X-Gm-Message-State: AOJu0YwH2pHcQZIXGKrQzDuiP+P/KVd8Q9B3FDoOmSjBPIKdcvqWmy5Z
	qHtyQOwypkooIKPfjUCUc3l1+tKkHXfm7Q1gs6Igp9RVm/hyPO741sGpVRDi6g==
X-Google-Smtp-Source: AGHT+IFf88EVVdjFfdu2f1Xd7SqqWlpsU+fSNzdJfNG3fiH6hUTe+nsB4Eh7rlvmYm98E6DkS52y3w==
X-Received: by 2002:a05:6a00:4b4c:b0:706:705f:313a with SMTP id d2e1a72fcca58-70aaad3add2mr5320365b3a.12.1719888658875;
        Mon, 01 Jul 2024 19:50:58 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70801e57aa0sm7300844b3a.28.2024.07.01.19.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 19:50:58 -0700 (PDT)
Date: Tue, 2 Jul 2024 02:50:54 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 8/8] ata: libata-scsi: Make ata_scsi_qc_complete()
 more readable
Message-ID: <ZoNrDo0HIISlBMdX@google.com>
References: <20240701195758.1045917-1-ipylypiv@google.com>
 <20240701195758.1045917-9-ipylypiv@google.com>
 <ZoMciql1lQcj5MbM@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoMciql1lQcj5MbM@ryzen.lan>

On Mon, Jul 01, 2024 at 11:15:54PM +0200, Niklas Cassel wrote:
> On Mon, Jul 01, 2024 at 07:57:58PM +0000, Igor Pylypiv wrote:
> > The ATA PASS-THROUGH handling logic in ata_scsi_qc_complete() is hard
> > to read/understand. Improve the readability of the code by moving checks
> > into self-explanatory boolean variables.
> > 
> > Additionally, always set SAM_STAT_CHECK_CONDITION when CK_COND=1 because
> > SAT specification mandates that SATL shall return CHECK CONDITION if
> > the CK_COND bit is set.
> > 
> > Co-developed-by: Niklas Cassel <cassel@kernel.org>
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > ---
> >  drivers/ata/libata-scsi.c | 21 +++++++++++----------
> >  1 file changed, 11 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index a66c177b6087..8f21b3b0bc75 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -1659,26 +1659,27 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
> >  {
> >  	struct scsi_cmnd *cmd = qc->scsicmd;
> >  	u8 *cdb = cmd->cmnd;
> > -	int need_sense = (qc->err_mask != 0) &&
> > -		!(qc->flags & ATA_QCFLAG_SENSE_VALID);
> > -	int need_passthru_sense = (qc->err_mask != 0) ||
> > -		(qc->flags & ATA_QCFLAG_SENSE_VALID);
> > +	bool have_sense = qc->flags & ATA_QCFLAG_SENSE_VALID;
> > +	bool is_ata_passthru = cdb[0] == ATA_16 || cdb[0] == ATA_12;
> > +	bool is_ck_cond_request = cdb[2] & 0x20;
> > +	bool is_error = qc->err_mask != 0;
> >  
> >  	/* For ATA pass thru (SAT) commands, generate a sense block if
> >  	 * user mandated it or if there's an error.  Note that if we
> > -	 * generate because the user forced us to [CK_COND =1], a check
> > +	 * generate because the user forced us to [CK_COND=1], a check
> >  	 * condition is generated and the ATA register values are returned
> >  	 * whether the command completed successfully or not. If there
> > -	 * was no error, we use the following sense data:
> > +	 * was no error, and CK_COND=1, we use the following sense data:
> >  	 * sk = RECOVERED ERROR
> >  	 * asc,ascq = ATA PASS-THROUGH INFORMATION AVAILABLE
> >  	 */
> > -	if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
> > -	    ((cdb[2] & 0x20) || need_passthru_sense)) {
> > -		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID))
> > +	if (is_ata_passthru && (is_ck_cond_request || is_error || have_sense)) {
> > +		if (!have_sense)
> >  			ata_gen_passthru_sense(qc);
> >  		ata_scsi_set_passthru_sense_fields(qc);
> > -	} else if (need_sense) {
> > +		if (is_ck_cond_request)
> > +			set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);
> > +	} else if (is_error && !have_sense) {
> >  		ata_gen_ata_sense(qc);
> >  	} else {
> >  		/* Keep the SCSI ML and status byte, clear host byte. */
> > -- 
> > 2.45.2.803.g4e1b14247a-goog
> > 
> 
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> 
> However: I really think that this patch should be squashed with patch 2/8.
> 
> Sure, the changes in this patch will make it harder to backport...
> but, even patch 2/8 will be a pain to backport...
> 
> And this patch will need to have CC: stable and be backported as well...
> (such that we always set CHECK_CONDITION when CK_COND=1), so I strongly
> suggest that we should squash these, since it will probably be way simpler
> to backport the patch that is "patch 2/8 squashed with this patch",
> compared to backporting patch 2/8, and then backporting this patch.
> (That would just give two patches that will need manual backport, rather
> than one patch that needs manual backport.)
> 
> Both of these are fixing incorrect sense data for ATA passthough commands
> anyway.

Agreed, it makes more sense to squash. Squashed the patches in v5.

I really appreciate your thorough reviews and feedback, Niklas! Thank you!

Best,
Igor
> 
> 
> Kind regards,
> Niklas


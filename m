Return-Path: <linux-kernel+bounces-236960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAC291E918
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 22:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C012820AC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503BE16FF45;
	Mon,  1 Jul 2024 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jyzQvx6g"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C30A16EC06
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 20:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719864066; cv=none; b=g9bD0uKfa+vTGSCPwoIRkdCSAPjMW2wwRVjMsYTljn9KVGelxOQhHMCjgInCXgkMMQf5jOHRRJosXuDb0XxLF2IdbAAUH8euwy69ApB8qIdrffB7ihtKuWwzDKUk5idCMetNnL5unjzS2wTipQHGobu811gj7knEDYmjitrYVvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719864066; c=relaxed/simple;
	bh=vxAFQz6LQvLRoQawIx6qi8XSz5qlU2LKh8KykaOnyXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXAAr00su1kyggKElK7yfs9Z94svBMLZ/V5PJunjGmqNpPyiwSPrg55w5bX/tu3GFYiLIra3bSOsNF0MywaRsOZVPPR5geSENQaA9S77vDlt4zCgfniCIaJJeZk+Y261Rsz9xAw+t5HmgRVLOslnIpISFfZo3sKqB59lsSP2Z+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jyzQvx6g; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fa78306796so19640795ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 13:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719864063; x=1720468863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OS4SdBNiA/DMxzk10gnrZNsn1Vj66CuQ4DdsvBAzo2c=;
        b=jyzQvx6gpm8u/PLndYBTtYwrPbBTJAVumDSaKm9U3lJ8uLjRrrLh2vG+InL6GEqQj5
         aYDx0NMwepWxYNjB3uGxXxSCmmUm5kUkA88z90kzR+fWdWJ12bgWqTtehn8DGfXc910u
         hHCLvt9EUmW/0daYPfiwU9Ecv/3vATUAJEEZy5T7Xq48du+DEqsQ0I/FDRYaZI6FynSG
         PNMpQfwIWd29/gNv/P0EgLuFLixi5RgdNJD1l+PVTpO041bNmddnzyjY2+t2wCJubZAy
         EYwTnPdBzfAMOmqiOKwglCZaHzzDE1Wz31gTJZChjOh3F1LNGbBn70xVeGGWExWy4evV
         lu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719864063; x=1720468863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OS4SdBNiA/DMxzk10gnrZNsn1Vj66CuQ4DdsvBAzo2c=;
        b=Uv/OiJpbEkcSitfT/lcZSgPrZK33thmfNNr3Y9vxVYSlrfeR/8eqfZWSEkZwcGQ/YP
         xOB9aOPm/oD6uZTIq0mM9PxgrER+6pJqjo3ExvjAp6dtuRW3ztU1Cj+lMOk55Lxi71FB
         wVOzOzdVvc9acUfkDPwv9jhbUAxY6fkOOSVBND5vR3lm3UtGokqcW470jbHV2wdiw85L
         NH52tumJRLCOJp+h0vlRhesGFX4MQRMy9KEHJAx+ALh3Y3bqN3Bb5/3lpweZjUzxeWDB
         jjmfUxrQfNQYtpdx+7D/UILaH9RXepILEoTLHRT8wYSIU/BbG26WcKCksZ6t8yc6e3fw
         QZNw==
X-Forwarded-Encrypted: i=1; AJvYcCWki98lNXak56wiFsXldHdb3x5BkoFGP52QFJ0CBVFvfbDDqZfcDEkFU7X6zKHmVt+HGaPG99HQI8cxxW68o0KbbJLOXz4iYOxWAhx0
X-Gm-Message-State: AOJu0Ywy+oLwGILDRl4XQDGtfEjnGnU7kn7SGeP3mrd6N0Zs23mt1NIo
	44jukYJHdcLxDQ00PsII5V99boJ3p/PxbMgZUqAajnkoX5FIUxyiIZdcqHmfCA==
X-Google-Smtp-Source: AGHT+IFNQxjeOvzf9RJAjTgY1Z08Z3SV34axcPKndyBuPp2L+maQdFQY0GN0r3Zl5EJkCzosXI0zQA==
X-Received: by 2002:a17:902:d4cd:b0:1f9:f1e1:da93 with SMTP id d9443c01a7336-1fadbc5b7e4mr42206405ad.4.1719864063012;
        Mon, 01 Jul 2024 13:01:03 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15992a0sm69140185ad.263.2024.07.01.13.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 13:01:02 -0700 (PDT)
Date: Mon, 1 Jul 2024 20:00:58 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/6] ata: libata-scsi: Do not overwrite valid sense
 data when CK_COND=1
Message-ID: <ZoMK-gpSbOWVFhf8@google.com>
References: <20240626230411.3471543-1-ipylypiv@google.com>
 <20240626230411.3471543-3-ipylypiv@google.com>
 <Zn1zsaTLE3hYbSsK@ryzen.lan>
 <Zn3ffnqsN4pVZA4m@google.com>
 <Zn8EmT1fefVzgy0F@ryzen.lan>
 <Zn9H17FoDDg9hpUr@google.com>
 <Zn97AtP4IC7T1NoO@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn97AtP4IC7T1NoO@ryzen.lan>

On Sat, Jun 29, 2024 at 05:09:54AM +0200, Niklas Cassel wrote:
> On Fri, Jun 28, 2024 at 11:31:35PM +0000, Igor Pylypiv wrote:
> > On Fri, Jun 28, 2024 at 08:44:41PM +0200, Niklas Cassel wrote:
> > > On Thu, Jun 27, 2024 at 09:54:06PM +0000, Igor Pylypiv wrote:
> > > > 
> > > > Thank you, Niklas! I agree that this code is too complicated and should be
> > > > simplified. I don't think we should change the code too much in this patch
> > > > since it is going to be backported to stable releases.
> > > > 
> > > > Would you mind sending a patch for the proposed simplifications following
> > > > this patch series?
> > > > 
> > > 
> > > I would prefer if we changed it as part of this commit to be honest.
> > > 
> > > 
> > > I also re-read the SAT spec, and found that it says that:
> > > """
> > > If the CK_COND bit is set to:
> > > a) one, then the SATL shall return a status of CHECK CONDITION upon ATA command completion,
> > > without interpreting the contents of the STATUS field and returning the ATA fields from the request
> > > completion in the sense data as specified in table 209; and
> > > b) zero, then the SATL shall terminate the command with CHECK CONDITION status only if an error
> > > occurs in processing the command. See clause 11 for a description of ATA error conditions.
> > > """
> > > 
> > > So it seems quite clear that if CK_COND == 1, we should set CHECK CONDITION,
> > > so that answers the question/uncertainty I asked/expressed in earlier emails.
> > > 
> > > 
> > > I think this patch (which should be applied on top of your v3 series),
> > > makes the code way easier to read/understand:
> > > 
> > 
> > Agree, having self-explanatory variable names makes the code much more
> > readable. I'll add the patch in v4.
> > 
> > Do you mind if I set you as the author of the patch with the corresponding
> > Signed-off-by tag?
> 
> I still think that you are the author.
> 
> But if you want, feel free to add me as: Co-developed-by
> (which would also require you to add my Signed-off-by), see:
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
> 
Sounds good! Added the Co-developed-by abd Signed-off-by tags in v4. Thanks!
> 
> > 
> > > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > > index d5874d4b9253..5b211551ac10 100644
> > > --- a/drivers/ata/libata-scsi.c
> > > +++ b/drivers/ata/libata-scsi.c
> > > @@ -1659,26 +1656,27 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
> > >  {
> > >         struct scsi_cmnd *cmd = qc->scsicmd;
> > >         u8 *cdb = cmd->cmnd;
> > > -       int need_sense = (qc->err_mask != 0) &&
> > > -               !(qc->flags & ATA_QCFLAG_SENSE_VALID);
> > > -       int need_passthru_sense = (qc->err_mask != 0) ||
> > > -               (qc->flags & ATA_QCFLAG_SENSE_VALID);
> > > +       bool have_sense = qc->flags & ATA_QCFLAG_SENSE_VALID;
> > > +       bool is_ata_passthru = cdb[0] == ATA_16 || cdb[0] == ATA_12;
> > > +       bool is_ck_cond_request = cdb[2] & 0x20;
> > > +       bool is_error = qc->err_mask != 0;
> > >  
> > >         /* For ATA pass thru (SAT) commands, generate a sense block if
> > >          * user mandated it or if there's an error.  Note that if we
> > > -        * generate because the user forced us to [CK_COND =1], a check
> > > +        * generate because the user forced us to [CK_COND=1], a check
> > >          * condition is generated and the ATA register values are returned
> > >          * whether the command completed successfully or not. If there
> > > -        * was no error, we use the following sense data:
> > > +        * was no error, and CK_COND=1, we use the following sense data:
> > >          * sk = RECOVERED ERROR
> > >          * asc,ascq = ATA PASS-THROUGH INFORMATION AVAILABLE
> > >          */
> > > -       if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
> > > -           ((cdb[2] & 0x20) || need_passthru_sense)) {
> > > -               if (!(qc->flags & ATA_QCFLAG_SENSE_VALID))
> > > +       if (is_ata_passthru && (is_ck_cond_request || is_error || have_sense)) {
> > > +               if (!have_sense)
> > >                         ata_gen_passthru_sense(qc);
> > >                 ata_scsi_set_passthru_sense_fields(qc);
> > > -       } else if (need_sense) {
> > > +               if (is_ck_cond_request)
> > > +                       set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);
> > 
> > SAM_STAT_CHECK_CONDITION will be set by ata_gen_passthru_sense(). Perhaps we
> > can move the SAM_STAT_CHECK_CONDITION setting into else if?
> 
> I think it is fine that:
> if (is_ck_cond_request)
> 	set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);
> 
> might set SAM_STAT_CHECK_CONDITION even if it is already set.
> 
> Personally, I think that my suggestion is slightly clearer when it comes
> to highlight the behavior of CK_COND. (CK_COND will set CHECK_CONDITION,
> regardless if successful command or error command, and regardless if
> we already had sense or not.)
> 
> And considering that we finally make this hard to read code slightly more
> readable than it was to start off with, I would prefer my alternative.
>
It makes senes. Added the patch in v4. Thank you!
> 
> Kind regards,
> Niklas


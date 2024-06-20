Return-Path: <linux-kernel+bounces-223681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4649C9116E2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 01:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85E71F228D1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2650149C65;
	Thu, 20 Jun 2024 23:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UW5s1Egy"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB2178C67
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 23:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718926458; cv=none; b=EBbT+qT1M7j7VXWWYDgnzuY17rdu3bgdJewcdwz04KTLhWjhl9hr6sQfiaIDPIDtTx1e3Hdau52SmemSr2tzVJnJmVLt6Tj5TdIrX3pYKwGmTGsuhom+Ob5hcvGVUU4U0L7HFPf0LAg5pfs5vyoZM1cmyv5QY2C55r9qQQgzoag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718926458; c=relaxed/simple;
	bh=YzCAiEQpfg/g/kJuQO+uwqiy6/kqbKxaI1i2Ujvp+5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9bTi+BbtsRNjCLRImMnsRbRDg4RVY9k/6Fyhmd4uNO+NlatlJD8K0zkO/NeU2LQJRGT0xdl2F10Ti4ZFiBkkGGamddyy2wLDgcgItHufrPUQ8kT/2k8ioXdEqxRRLCvgv9nkAeU5ffH0L2fmhmIVrMASr15y+fMkIc0kP8ps+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UW5s1Egy; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7061d37dc9bso1266179b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718926456; x=1719531256; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7XfksNSVifcZsxGv6eaETaFbtJmM8Uyclp22FAxA2lE=;
        b=UW5s1EgyWjUFxPhvDD/oxPOf3CaXhaJAew7OeBrGXL8OuSYOgQg8UhEo5OGFxn0558
         AFSN1PI18xurbHKMb4otFbjDglrr0OUhppLrXNwLw3oHGAl6CQT5yj8lur1TG7uRK5mc
         22zsZNJSlMt31MSYz9qrRTII4JLYW5Ewbcthbr9VelBd8oaUlEagz8Z4NFO4xHqBFbdC
         Uvs5DINlUG1Gno5AW+EMjNdcWlNlq0eQi2CArHvpTwLx2lUxYju3i1ofbLStgIc9SKVL
         IW/RKKJAhuR8hd53sqmS6vqTihOwqok/rRT6ezIi1WscOnX7nS174976iZknTEbOU4sO
         SbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718926456; x=1719531256;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7XfksNSVifcZsxGv6eaETaFbtJmM8Uyclp22FAxA2lE=;
        b=Vy1/ZF6IXdmeXulVCLXHWaXcAig3uL4MdjgHyR/YMujTjZR1kcrebO0r46IW1ZK+5i
         zhtVtpx5dShI3cksOun0bai+rmlU3xJiofe66L5o0leXAk559yv8+myNYjRvUB5YZRrJ
         fyaWSWyJPGjnlmAaZgFBdV+yJPqwJ2TVeRY7qED26UKEkzu5Sqg8CLeQVaDa52btwpgL
         VWptNOQ1Xui8t1Ytt2SiJLuTL5OnDbqiesSGtsFVwBgMwZGoTJQwvQ3Smjzk1F7SuZne
         H74NQUOd8oZ51TpI8mnxufq8iVOuqmfXT08RqYp82PfmMktlVu0bUH/PuZCsKheV8fcs
         vQ1g==
X-Forwarded-Encrypted: i=1; AJvYcCUNIJrDYgTT2mkreTU3CebyT/iC5b5/HxZQayf1dDTEptl5/YvqeBQdeOJyl3pwrhqoDatztzSfBrGL/pnlsvXeeFcXwq9s2ps+PMrZ
X-Gm-Message-State: AOJu0YyEtW/GkAyXPBP16NgdjfRsYq5HHDfxw/azLgzEY2Rz1Nv5/Ycd
	8DTK/GQ6Nx547ZOj8Z91myxnTs/V6JKUdnyp14+fNFvAbEy0C5mcJvtdslI4MoErCPLoFEonNog
	SsQ==
X-Google-Smtp-Source: AGHT+IE7kWnNs02QXbSIStlmhOJow1svDh0NpTLzx34/evD0hCRr64S7MEEV3tkbVh+cTtvFamswSw==
X-Received: by 2002:a05:6a20:3ba9:b0:1b2:be25:b5b0 with SMTP id adf61e73a8af0-1bcbb4190famr7404322637.20.1718926455516;
        Thu, 20 Jun 2024 16:34:15 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065126563esm191150b3a.101.2024.06.20.16.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 16:34:14 -0700 (PDT)
Date: Thu, 20 Jun 2024 23:34:11 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] ata: libata-scsi: Report valid sense data for ATA
 PT if present
Message-ID: <ZnS8c3qN21NAkrOy@google.com>
References: <20240614191835.3056153-1-ipylypiv@google.com>
 <20240614191835.3056153-4-ipylypiv@google.com>
 <ZnAUy5C-DXEuliSm@ryzen.lan>
 <ZnDHZWZQFtUmwtwE@google.com>
 <ZnQ7i0D4syhhI_hO@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnQ7i0D4syhhI_hO@ryzen.lan>

On Thu, Jun 20, 2024 at 04:24:11PM +0200, Niklas Cassel wrote:
> On Mon, Jun 17, 2024 at 11:31:49PM +0000, Igor Pylypiv wrote:
> > On Mon, Jun 17, 2024 at 12:49:47PM +0200, Niklas Cassel wrote:
> > > On Fri, Jun 14, 2024 at 07:18:34PM +0000, Igor Pylypiv wrote:
> > > > Do not generate sense data from ATA status/error registers
> > > > if valid sense data is already present.
> > > > 
> > > > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > > > ---
> > > >  drivers/ata/libata-scsi.c | 17 +++++++++++------
> > > >  1 file changed, 11 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > > > index 79e8103ef3a9..4bfe47e7d266 100644
> > > > --- a/drivers/ata/libata-scsi.c
> > > > +++ b/drivers/ata/libata-scsi.c
> > > > @@ -858,12 +858,17 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
> > > >  	unsigned char *desc = sb + 8;
> > > >  	u8 sense_key, asc, ascq;
> > > 
> > > Like I suggested in the earlier patch,
> > > 
> > > can't you do a:
> > > 
> > > if (qc->flags & ATA_QCFLAG_SENSE_VALID)
> > > 	return;
> > > 
> > > here instead?
> > > 
> > 
> > We need to populate the "ATA Status Return sense data descriptor" as per SAT-5
> > "Table 209 — ATA command results". By returning early we are skipping the code
> > that copies ATA output fields into descriptor/fixed sense data buffer.
> 
> We might get sense data from the drive.
> If we use REQUEST SENSE DATA EXT, we will get SK/ASC/ASCQ,
> we will then call scsi_build_sense_buffer() which will generate
> sense data in either the descriptor format or the fixed format,
> based on the D_SENSE bit, which is set in the control mode page.
> 
> The user can toggle this bit, see:
> https://github.com/torvalds/linux/blob/v6.10-rc4/drivers/ata/libata-scsi.c#L3691-L3694
> 
> But by default it is 0:
> https://github.com/torvalds/linux/blob/v6.10-rc4/drivers/ata/libata-scsi.c#L86
> which means fixed format.
> 
> This all seems to be in accordance with
> "Table 209 — Returned sense data with the CK_COND bit set to one"
> in sat6r1.
> 
> 
> 
> When calling scsi_build_sense_buffer(), we supply:
> scsi_build_sense_buffer(dev->flags & ATA_DFLAG_D_SENSE,
>                         cmd->sense_buffer, tf.lbah,
>                         tf.lbam, tf.lbal);
> 
> so we do not supply the STATUS and ERROR fields when building the sense data.
> 
> This seems fine, since SCSI has no knowledge of ATA status or ATA error.
> 
> 
> However, for ATA-passthrough commands, ATA status and ATA error fields
> are part of either the COMMAND-SPECIFIC information in the fixed format
> case, or part for the descriptor format, in case of the descriptor type
> being ATA Status Return sense data descriptor.
> 
> 
> So what I think we should do:
> 1) Keep the sense data if it exists, and fill in
>    the ATA status and ATA error at the correct offset (depending on if
>    the existing sense data is in fixed format or descriptor format).
> 2) If there doesn't exist any sense data, generate it, including the
>    ATA passthru command specific fields (ATA status and ATA error).
>    This is basically what ata_gen_passthru_sense() does today.
>

Yes! That's exactly what I was trying to do with the horrible empty if in
ata_gen_passthru_sense(). Factoring out ATA status and ATA error population
into a separate function makes the code more readable and less error-prone.

I'll make the change in v2.

Thank you!
Igor

> 
> So something like this:
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index bb4d30d377ae..a0687eb28ff7 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1645,9 +1645,17 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>          * asc,ascq = ATA PASS-THROUGH INFORMATION AVAILABLE
>          */
>         if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
> -           ((cdb[2] & 0x20) || need_sense))
> -               ata_gen_passthru_sense(qc);
> -       else if (need_sense)
> +           ((cdb[2] & 0x20) || need_sense)) {
> +               if ((qc->flags & ATA_QCFLAG_SENSE_VALID)) {
> +                       /*
> +                        * ATA PASS-THROUGH commands also need to fill in the
> +                        * command specific ATA status and ATA error fields.
> +                        */
> +                       ata_fill_passthru_specific_sense_fields(qc);
> +               } else {
> +                       ata_gen_passthru_sense(qc);
> +               }
> +       } else if (need_sense)
>                 ata_gen_ata_sense(qc);
>         else
>                 /* Keep the SCSI ML and status byte, clear host byte. */
> 
> 
> Kind regards,
> Niklas
> 
> 
> 
> 


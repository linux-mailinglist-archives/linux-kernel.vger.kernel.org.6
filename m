Return-Path: <linux-kernel+bounces-218450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A1690C001
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1A11F21904
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9B279C4;
	Tue, 18 Jun 2024 00:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HScf538v"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0149EA95B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718668933; cv=none; b=homjwsDgGJXbHFfdyDqbOj8YVlo8TMtTmzcYzYl3TIIShWCmS9dVRVs04+mqmjHZKEFNLBBum6ovKD/0FBQ4qmLIhdYVosPzapHHcbbgL/y3OdZpJMlHwxV4HNzZW5qNVT7tmTjOVNtjctROGL9NRg3TCB5delJeLOOw7scfASw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718668933; c=relaxed/simple;
	bh=MQ0UkyRa32S08P8X0GuZZXaCeFjdlR7ldXAmsqhG1NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5wOUEaZtwhSi4HKnJH05XZZojztiBigX/a/3HjiNYOkC09plPfnFbrpJWehqU369i72o44MwiBGzhbebp9pTd3rrzPm+n03wrKLEwv+iuENTrNDqNyObU9p46JDK+9CydaU95SxZiNs431hUMiTe2YBDDrLK0ikLX/dG9PV5K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HScf538v; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-70df2135439so310075a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718668931; x=1719273731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G5QggLKVvtXcjNE7wsmNHduvxN81Zmk7QTPLx0dgIXM=;
        b=HScf538vzQCcKU0yixyl+LPJGwWdaehNLeik+MHo54cGJA/Qz9fvjF6EVSpZmtqGb/
         88jOPit2rZCDLxuoTpPnKKsbRty9K0hpIX13er28hlwj/23ml7pdnqHupG36TaC6wJ1a
         U7njKogCe6jDbJTvIC6wjEsCPvUddQVE15sLhcBffUdDKN8xdVE6JOIPzATWJVyCBpVA
         iBn11QCnGoBrucYZAOjHn5qQeK/Z4cCtPcqkqoW4sVuMPm2T1L4GAxN9AuOsnyCa3VLm
         B7hIJyf0gaqztWz436GM9EAZKjiB1NY2AHl8q2A5NH+O9p6WXguvWzc64f9GN1TsUokq
         QEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718668931; x=1719273731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5QggLKVvtXcjNE7wsmNHduvxN81Zmk7QTPLx0dgIXM=;
        b=eDZglXwr0/dYW6Qv+mdFOnpsnM7NaC/3USnLjmd9FyeVAkCFnewiv2a8eJ8GN/wOvj
         o4lh5+b/ks/OSRaseqUB2bbD6h11eKxDL6eXR/orrC5KpOp3iX8VB+gL9sctDNzfYgjn
         Xjrk/Au76L5/+0b2vtlqZTYmgNc0kCE39mAG1L9C8FmyVUs/HV+/dQcaMvOrWNFpyejC
         NZPeNCzGTBfZeRh/Ghx7SzoFqTU6IMNJU4kX0dnpRKclf6jHZUQNtQeIJDkE1peG8UMs
         R13zM0vZ91+vrc5AcmE1ZNWWdfTRetcgg9oUr3o1ubFHBBiNQDuGcYUGwdTm7u5cncy0
         3mqA==
X-Forwarded-Encrypted: i=1; AJvYcCUxm8OIjxrohhnE06cpE8SgciVChh6rSudWX0paQFPJQrniHFlSxOK1xjT+nbIk2I3h02vxDWuFp7GbB9teR3BTlrLeMDB4h9C2jpaO
X-Gm-Message-State: AOJu0Yw0Ab10R+Se3ykQmDYqLo7G8VYhsFZNBAd5fhm4b9+be2+n3x+j
	SHOKgfzDPv9IARMy10JLz7WOXPoibUdlK35r/BpSsP/sJtyLEYcnue+FsLlFmw==
X-Google-Smtp-Source: AGHT+IEaL9SMJkuSl6W1G9gOHBSO4BNEF5ZdqBW01H+lkarcRA4jiV0wRtBSfOlpQ3DRHisvBSW3dw==
X-Received: by 2002:a17:90a:ae06:b0:2c2:f6a3:3043 with SMTP id 98e67ed59e1d1-2c4db133ea3mr10836842a91.9.1718668930970;
        Mon, 17 Jun 2024 17:02:10 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c466c3desm9488343a91.46.2024.06.17.17.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 17:02:10 -0700 (PDT)
Date: Tue, 18 Jun 2024 00:02:06 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] ata: libata-scsi: Report valid sense data for ATA
 PT if present
Message-ID: <ZnDOfqq9Jo-38LBl@google.com>
References: <20240614191835.3056153-1-ipylypiv@google.com>
 <20240614191835.3056153-4-ipylypiv@google.com>
 <dfb741e5-2fe6-4b36-b1ab-55c3c33032d0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfb741e5-2fe6-4b36-b1ab-55c3c33032d0@kernel.org>

On Mon, Jun 17, 2024 at 08:25:54AM +0900, Damien Le Moal wrote:
> On 6/15/24 04:18, Igor Pylypiv wrote:
> > Do not generate sense data from ATA status/error registers
> > if valid sense data is already present.
> 
> This kind of contradicts what you said in patch 2... So I am really confused now.

Sorry about the confustion. I think the problem is that I was using "sense data"
to describe two different things:
#1. SK/ASC/ASCQ
#2. ATA Status Return sense data descriptor

Both #1 and #2 need to be populated into sense buffer. The problem with
the current code is that we can only have either valid #1 or valid #2 but
not both at the same time.

> Though this patch actually looks good to me, modulo the comment below.
> But shouldn't this be squashed with patch 2 ?

Yes, that's a good point. Let me factor out the sense data descriptor
population code into a separate function and then squash this patch with
the patch 2.

>
> > 
> > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > ---
> >  drivers/ata/libata-scsi.c | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index 79e8103ef3a9..4bfe47e7d266 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -858,12 +858,17 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
> >  	unsigned char *desc = sb + 8;
> >  	u8 sense_key, asc, ascq;
> >  
> > -	/*
> > -	 * Use ata_to_sense_error() to map status register bits
> > -	 * onto sense key, asc & ascq.
> > -	 */
> > -	if (qc->err_mask ||
> > -	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
> > +	if (qc->flags & ATA_QCFLAG_SENSE_VALID) {
> > +		/*
> > +		 * Do not generate sense data from ATA status/error
> > +		 * registers if valid sense data is already present.
> > +		 */
> 
> The empty "if" here is really horrible. Please revert the condition and add it
> as a "&&" in the below if.
>
Adding the condition to the below if will change the code flow and we'll end
up executing scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D) when
ATA_QCFLAG_SENSE_VALID is set, which is not what we want.

I agree about horrible :)

Perhaps I should have factored out the descriptor population code into
a separate function to make the code correct and not so horrible. Let me
do that in v2.

> > +	} else if (qc->err_mask ||
> > +		   tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
> > +		/*
> > +		 * Use ata_to_sense_error() to map status register bits
> > +		 * onto sense key, asc & ascq.
> > +		 */
> >  		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
> >  				   &sense_key, &asc, &ascq);
> >  		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
> 
> -- 
> Damien Le Moal
> Western Digital Research
>
Thank you,
Igor 


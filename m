Return-Path: <linux-kernel+bounces-220126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A755C90DCEE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503ED285A85
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC41C16DC19;
	Tue, 18 Jun 2024 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2d37N+5e"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8690E15E5BB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740743; cv=none; b=jgOVbQZNPdDvuQuUQDgzwwIPpifkpumD+kjdV5p+1QG0VE7/XNLy7rPEyRbiyoDBaeQZ7vFfpqG51brDyG0pnGLgTdfLjga8SwYkZsV0ScS7agjVAwqPIO+pDTEwDTWTRtAprkF4sxRcVm1utpEUtDbvcqSTmMXecrYhL4cMmhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740743; c=relaxed/simple;
	bh=DzUvNMgjfp2wSkyzXhS9hHtcy9tOJqV336Yg0S2PK1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mf1+aV5tb00qyzp+HLR/qhUKyN1CZeq999poiwLXSI7xDzRMXaeTAt39sqPOH20fD+L1Cp56qmZeaAm+l04U0Bj35UwmKjwF4yNuIjbGpWTJgfwB8H/E4TihD4+xupnRn5+HpZ0JqN/4Cod3ZHH7B5onCwyaAv5jiCqoI6ONB/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2d37N+5e; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f70fdc9644so1545335ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 12:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718740741; x=1719345541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FFHOdkZMtbgVnUKrgsjlYBo8PKQHi5OtnFCvxiR7rC8=;
        b=2d37N+5eVY/Y0ZqgYh84LUoF8b+Q4i6zmFWs/3L94kI/kmA9u4z7FLP5Mui/MpZiaC
         QhmwvxL7fLNIQ/KjpwtiGStaSdHpUnnl50Jw8GIxYRg1taP4FB02Xr4j+nXM4oWB75Gu
         ZX5I/kKNgWvogfoGYTaOfAbinQcv0PtYhly+V/fAa4uMtDKcHNJZM957K4fLmrARE3ti
         xFJXMAepSDqg01lDAy4xR19ZUGzSVc16gC1IOZFLJwySLYyuj1hUt+IfQt0X8s4kwDEs
         WPniM39Aq5y90Z6gugId+CZsNcsLys1Jv4u3CS/WpvKXqMo3YDfIXbmHXvCKowqPMXKP
         pxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740741; x=1719345541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFHOdkZMtbgVnUKrgsjlYBo8PKQHi5OtnFCvxiR7rC8=;
        b=eXJMCfkVSkgzr3JaPkbDq04rtMwhbLRjFSKhi61PbZzFXNAhD/oH7/T8qweLebp8XO
         sGeQtSepyz6/4DM98WVfNwVrhv7MeomYBkAR0+HTK9e8vw//BPbRQdXUyrgnm74Pg3od
         5UWgVyRgFTG8lc488qkYc9xhujI/sHsDcM9QDY8aHLgcx+GRajaNDvNqBb33Rx1yUz4v
         +nzTgqESBo23R8ru9d63E0TjMjpIg3Znf+Uwuj+slTuKz5hIiLEHzyPP7rgHQPkk4SW7
         V+bjw2BDu++rQfqaNzsEA2XTJARI8sBxhvQTvv7EZCIEBuD4A/Mqqx8empkdNBATWG5/
         zZbg==
X-Forwarded-Encrypted: i=1; AJvYcCU8CQXpp+1+Zx/BVBWA1A0snAqV+0WvT2Aw5Py0dzuRyLz5uUDiYCVLRVttInTd6D/J9DbOgm8no4F3nUzA2/QJ4BHt54ZXbUWqs3EB
X-Gm-Message-State: AOJu0Yx4fPiXxb38wu0rLy6ki9nKh7wqxHN6qUwcNz30eu1vp2L6Gtmk
	/dFcqwe9/H8kPkZsbRpcxHaZVJ1oYtr5cqbqbmJ398LwEHZV9WXVfo3TLvIxGg==
X-Google-Smtp-Source: AGHT+IHos8Ko7w2LymzJi+scCR3rc7KvYmpUWTzsYJ5tsLPJalRVKanhrbNFJ9Z1kEE299imQvxT2A==
X-Received: by 2002:a17:902:f684:b0:1f6:a572:86ab with SMTP id d9443c01a7336-1f9a8d5de07mr11411455ad.15.1718740740445;
        Tue, 18 Jun 2024 12:59:00 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e6dfb7sm101248115ad.64.2024.06.18.12.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 12:58:59 -0700 (PDT)
Date: Tue, 18 Jun 2024 19:58:56 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] ata: libata: Remove redundant sense_buffer memsets
Message-ID: <ZnHnACszbExFJSuY@google.com>
References: <20240614191835.3056153-1-ipylypiv@google.com>
 <20240614191835.3056153-2-ipylypiv@google.com>
 <ZnAS1nux75l7QlqF@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnAS1nux75l7QlqF@ryzen.lan>

On Mon, Jun 17, 2024 at 12:41:26PM +0200, Niklas Cassel wrote:
> On Fri, Jun 14, 2024 at 07:18:32PM +0000, Igor Pylypiv wrote:
> > scsi_queue_rq() memsets sense_buffer before a command is dispatched.
> > 
> > Libata is not memsetting sense_buffer before setting sense data that
> > was obtained from a disk so there should be no reason to do a memset
> > for ATA PASS-THROUGH / ATAPI.
> > 
> > Memsetting the sense_buffer in ata_gen_passthru_sense() is erasing valid
> > sense data that was previously obtained from a disk. A follow-up patch
> > will modify ata_gen_passthru_sense() to stop generating sense data based
> > on ATA status register bits if a valid sense data is already present.
> > 
> > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > ---
> >  drivers/ata/libata-eh.c   | 2 --
> >  drivers/ata/libata-scsi.c | 4 ----
> >  2 files changed, 6 deletions(-)
> > 
> > diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> > index 214b935c2ced..b5e05efe73f6 100644
> > --- a/drivers/ata/libata-eh.c
> > +++ b/drivers/ata/libata-eh.c
> > @@ -1479,8 +1479,6 @@ unsigned int atapi_eh_request_sense(struct ata_device *dev,
> >  	struct ata_port *ap = dev->link->ap;
> >  	struct ata_taskfile tf;
> >  
> > -	memset(sense_buf, 0, SCSI_SENSE_BUFFERSIZE);
> > -
> 
> Are you sure that this is safe?
> 
> atapi_eh_request_sense() is called both by:
> ata_eh_analyze_tf():
> tmp = atapi_eh_request_sense(.., qc->scsicmd->sense_buffer, ..)
> 
> and by:
> atapi_eh_clear_ua():
> atapi_eh_request_sense(.., sense_buffer, ..);
> where sense_buffer is dev->link->ap->sector_buf.
> 

Thanks for pointing this out, Niklas!

ata_eh_analyze_tf() case is safe because qc->scsicmd->sense_buffer is cleared
by scsi_queue_rq().

atapi_eh_clear_ua() case is safe right now because the sense buffer contents
are not being used. However, someone might start using the sense data in
the future so it is not safe to leave it as-is.

There's one more place where this function is being called:

zpready():
atapi_eh_request_sense(..., sense_buf, ...);
where sense_buffer is dev->link->ap->sector_buf.

This one is actually using the obtained sense buffer so it would be
a nasty bug if we don't do a memset().

I think we should explicitly memset buffers before passing them to
atapi_eh_request_sense() in atapi_eh_clear_ua() and zpready() so that
atapi_eh_request_sense() can have the same behavior as ata_eh_request_sense()
with regards to sense buffer expectations i.e. both functions will expect
buffers that are already memeset to zero.

> 
> Wouldn't a better fix be for ata_gen_* functions to return early if
> ATA_QCFLAG_SENSE_VALID is set?
> 

It would be possible to return early if ATA_QCFLAG_SENSE_VALID is set once
we factor out "ATA Status Return sense data descriptor" population out of
ata_gen_passthru_sense() into a separate function. I'll factor out the
descriptor population code in v2.

I think that it is still benefitial to remove the redundant memset() from
the ata_eh_analyze_tf() -> atapi_eh_request_sense() path?

> 
> >  	/* initialize sense_buf with the error register,
> >  	 * for the case where they are -not- overwritten
> >  	 */
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index cdf29b178ddc..032cf11d0bcc 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -858,8 +858,6 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
> >  	unsigned char *desc = sb + 8;
> >  	u8 sense_key, asc, ascq;
> >  
> > -	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
> > -
> >  	/*
> >  	 * Use ata_to_sense_error() to map status register bits
> >  	 * onto sense key, asc & ascq.
> > @@ -953,8 +951,6 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
> >  	u64 block;
> >  	u8 sense_key, asc, ascq;
> >  
> > -	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
> > -
> >  	if (ata_dev_disabled(dev)) {
> >  		/* Device disabled after error recovery */
> >  		/* LOGICAL UNIT NOT READY, HARD RESET REQUIRED */
> > -- 
> > 2.45.2.627.g7a2c4fd464-goog
> >

Thank you,
Igor 


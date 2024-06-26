Return-Path: <linux-kernel+bounces-231635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D69C919B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 01:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5091B1C20283
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C671940B2;
	Wed, 26 Jun 2024 23:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kj7sU/ss"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE76417F500
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 23:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719443481; cv=none; b=mFPq2S1ZxE/FRQerDUdMdAAF98Aw21E6uPHOaONLJboun01ecbLAKFPksZ/A2HhzLcvxoFh271k33nou6Jw9JvJafwu0UBt/0dYrYOt8P2g+oobz9o5IV8NxZZ7wwTbLYiVezcQT6K2NvYVmARF24toKRqHyrisoq1VBKfISj2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719443481; c=relaxed/simple;
	bh=mUWhhLbgN6nl3yENs/GEivbhZRy0Wq9Dz0D1sL47sQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qe7CKgYyWsul8W1THZVr4GeZgZi17/GcHwGqyJGuSqHbW5w0p/dt/hHkFB9zcuRF0KAYwd5sL8YT+r3Zyfs3AznoGrjNiblEO8iWLxrwqZ+wiSpkOLvrGkUSiEg5Rw37xv0sVawsLDay9+AIBThj4snN5vYqZzqL4oQmMjZY3yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kj7sU/ss; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d55cfebcc5so1151239b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719443479; x=1720048279; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oF0gfjmlTTx6hmif/3dN/HOBOIoUolbTTwBRvXTw/ps=;
        b=kj7sU/ssauGG1oboQXjXy5zZzX6tfXzhcWr7xsJukiBgGwv0X6+hBDAqkvNdyAkUCK
         t859N0vqeXKBT7wERLJzGjCfIgoE8J7Qa8j7aM0LDPuqvNzRmV+b+Gx1tULoYXUGfhrv
         5kqZoi9I9bJVFQb9NZ8P9aQ5bxiSwMXg4BvAKITHIxUXyLEwvpr9jmu/7kEV8D9hHQI4
         Z7obuDk0wnR1TgElboCptkTDMyhBoSdKjBIEcIRghaE3pGj9zpBWNDpXVFtpuu6awToa
         M5OVF2BZrJ/IMN7caJAafVmOxJG1K5oPTOQpGLUN+ezG9UhzRVx7UPwDDmZdQkSw8n13
         6y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719443479; x=1720048279;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oF0gfjmlTTx6hmif/3dN/HOBOIoUolbTTwBRvXTw/ps=;
        b=NEIgxqVFkccHJhVWzX01tTA3zRZsv188vP8ES3ObJrvij84JKwWRb3fVfuIaYvJYkt
         nPWNdds7r7HGzOZfyYkc4Oaw9synjEIF8w/a9MQ7u9yJ1eMg6fCEuyyI4aKdjAMafdSA
         vziOADqQlcvG8X6TEUTylfK0b3M/jLGM8BlbpR9Hts9I8XVA4gH+UorOUtRiinLNOckh
         UzuxtHQ8zb+LVds9hyKrQ5oCCs60WZqFIQyiAI22PeaIuAI65ocoLEFhl7gR9/NY3iAS
         Cqi80FIMDWQtgt9YTRQF7sjMAnDRW2KTDbFVcK3wXW5ihdl4zLh//YdUy/ldTx3g1vze
         Bi4g==
X-Forwarded-Encrypted: i=1; AJvYcCWP+hp2hIzL298f0Yj/VJjeo2dr8l/mAT9tZbqgsQDJUJmuAXjtpEotgZhD57K9vCvzasCHGWgchBCjsNSnj+uIV55ZF6t3xQKjL89c
X-Gm-Message-State: AOJu0YzNIBouC+J1qdJtgU0lgupHFwq8LrPVlWHzwB6zzIGcV/nb/AW5
	H0wLSxHB+ibEomD4aMfpaglEj2SgHWFXFYgjMaE3Rjhpk55AQqaIfyUh95jTLg==
X-Google-Smtp-Source: AGHT+IFSwZ4HAACuGuWBOrFcp9DWdYoYoG41UP10z6VykeGjmV/v3EVoaHY/c1qzHRonS8zQvapVXA==
X-Received: by 2002:a05:6808:f05:b0:3d2:1eb6:4894 with SMTP id 5614622812f47-3d5459639fbmr13115485b6e.19.1719443478553;
        Wed, 26 Jun 2024 16:11:18 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b491026esm34000b3a.55.2024.06.26.16.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 16:11:17 -0700 (PDT)
Date: Wed, 26 Jun 2024 23:11:14 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Niklas Cassel <cassel@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jason Yan <yanaijie@huawei.com>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED
 before using result_tf
Message-ID: <ZnygEoFkgUlorAc9@google.com>
References: <20240624221211.2593736-1-ipylypiv@google.com>
 <20240624221211.2593736-7-ipylypiv@google.com>
 <7d085940-2ad1-4f44-83bb-33d852e80da0@suse.de>
 <ZnthK-NjkSgIiGiE@google.com>
 <ab9f6564-3df1-4061-93e7-32a59aacb205@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab9f6564-3df1-4061-93e7-32a59aacb205@kernel.org>

On Wed, Jun 26, 2024 at 03:21:58PM +0900, Damien Le Moal wrote:
> On 6/26/24 09:30, Igor Pylypiv wrote:
> > On Tue, Jun 25, 2024 at 08:26:59AM +0200, Hannes Reinecke wrote:
> >> On 6/25/24 00:12, Igor Pylypiv wrote:
> >>> qc->result_tf contents are only valid when the ATA_QCFLAG_RTF_FILLED flag
> >>> is set. The ATA_QCFLAG_RTF_FILLED flag should be always set for commands
> >>> that failed or for commands that have the ATA_QCFLAG_RESULT_TF flag set.
> >>>
> >>> For ATA errors and ATA PASS-THROUGH commands the ATA_QCFLAG_RTF_FILLED
> >>> flag should be always set. Added WARN_ON_ONCE() checks to generate
> >>> a warning when ATA_QCFLAG_RTF_FILLED is not set and libata needs to
> >>> generate sense data.
> >>>
> >>> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> >>> ---
> >>>   drivers/ata/libata-scsi.c | 10 ++++++++++
> >>>   1 file changed, 10 insertions(+)
> >>>
> >>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> >>> index e5669a296d81..7a8a08692ce9 100644
> >>> --- a/drivers/ata/libata-scsi.c
> >>> +++ b/drivers/ata/libata-scsi.c
> >>> @@ -246,6 +246,9 @@ static void ata_scsi_set_passthru_sense_fields(struct ata_queued_cmd *qc)
> >>>   	struct ata_taskfile *tf = &qc->result_tf;
> >>>   	unsigned char *sb = cmd->sense_buffer;
> >>>
> >>> +	if (WARN_ON_ONCE(!(qc->flags & ATA_QCFLAG_RTF_FILLED)))
> >>> +		return;
> >>> +
> >>>   	if ((sb[0] & 0x7f) >= 0x72) {
> >>>   		unsigned char *desc;
> >>>   		u8 len;
> >>> @@ -928,6 +931,9 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
> >>>   	unsigned char *sb = cmd->sense_buffer;
> >>>   	u8 sense_key, asc, ascq;
> >>> +	if (WARN_ON_ONCE(!(qc->flags & ATA_QCFLAG_RTF_FILLED)))
> >>> +		return;
> >>> +
> >>>   	/*
> >>>   	 * Use ata_to_sense_error() to map status register bits
> >>>   	 * onto sense key, asc & ascq.
> >>> @@ -971,6 +977,10 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
> >>>   		ata_scsi_set_sense(dev, cmd, NOT_READY, 0x04, 0x21);
> >>>   		return;
> >>>   	}
> >>> +
> >>> +	if (WARN_ON_ONCE(!(qc->flags & ATA_QCFLAG_RTF_FILLED)))
> >>> +		return;
> >>> +
> >>>   	/* Use ata_to_sense_error() to map status register bits
> >>>   	 * onto sense key, asc & ascq.
> >>>   	 */
> >>
> >> Hmm. Not sure if we really need the WARN_ON() here or whether a simple
> >> logging message wouldn't be sufficient; after all, we continue fine here.
> >>
> > 
> > My worry about adding a simple log statement is that it might cause a log
> > spam if things go wrong for some reason.
> > 
> > This code is more like a "this should never happen" comment and we always
> > expect ATA_QCFLAG_RTF_FILLED to be present when generating sense data
> > based on ATA registers.
> > 
> > If WARN_ON_ONCE() is too much for this case I guess we can just remove it
> > and silently return?
> 
> what about ata_dev_dbg() or ata_port_dbg() ?
> No message spamming by default and if problems are detected, they can be turned
> on to figure out what is going on.

ata_dev_dbg() should work. Updated the patch in v3.

Thank you!
Igor
> 
> > 
> > Damien, Niklas, what are your thoughts on this?
> > 
> > Thanks,
> > Igor
> > 
> >> Cheers,
> >>
> >> Hannes
> >> -- 
> >> Dr. Hannes Reinecke                  Kernel Storage Architect
> >> hare@suse.de                                +49 911 74053 688
> >> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> >> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
> >>
> 
> -- 
> Damien Le Moal
> Western Digital Research
> 


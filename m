Return-Path: <linux-kernel+bounces-234693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA4D91C985
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 01:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB612849A3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950978249B;
	Fri, 28 Jun 2024 23:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YCBVU8b3"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A10626CB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 23:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719616552; cv=none; b=NmKXbssVjpM02xB0NBZwyvYzi3jqDMnwYZUKmp13LJNMx9cfJNpzKzrJN59esP7WPlSl2Yo/xEDFNqcT/TQ6NdOpfcAP++mvPoezk8qtkV8zZ492EkmcWreZnT1s6jq1mATiFtGNrk8CkkSIUa1HyJdhIzJD3hDEdWEqXaAsuHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719616552; c=relaxed/simple;
	bh=GXCnN6Gc6mHQhyMlcVl4JuiW37l2AbPh/yqkCVqQk8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDx/TjiRv47vuhif9gmL+4NxHIRyXDyyMadyILHovA3O6B+7gwWU3wHe+RfMOjIqmL+v7cRTlM+NpkmiaF6i6QO0FN1hLH1yZTt2NG1n2NxhL1njcICBUdDby6rIvsj3LEguTVevxZe5KIMJtSaUnGsG+gz+GtLWc89MqjsivIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YCBVU8b3; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7226821ad86so816251a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 16:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719616551; x=1720221351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EbSDBkYJnCYPN13RI6gAGzcjnqgBMJXiLfp/idvdK+U=;
        b=YCBVU8b3GUlIMezK9RRl5Zq/kwsBO1KM4vhCf49tkfC04nn7OEzCspJiQ7/XYh8k26
         AxpVb+CLnyLve7HtbWsJOR3uahpsAHz8PvH7J8HpBBTTnqGrVpwHvn4AM0wTRYMAePh7
         sv84gdZ/liFe7PgA1NUCLDebFuMqCF5Z8ReAmCF9nkvoNZCYOqnb0GxczATuT7oNFL/N
         awFkSuwk1/zmbULvVvMLVNGNgD/zrW/qXX/I3jeF3tlJCsK0fJcgOpzbFnvukCz0nn7j
         z127GQkFYwUej53HikLAgQtD9pogIAi3sa7A0L2j9KGHq8uqBhsJTxzHF+7V8ozRjx3M
         6lAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719616551; x=1720221351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbSDBkYJnCYPN13RI6gAGzcjnqgBMJXiLfp/idvdK+U=;
        b=Xxbw6jKCOXaTdrVdq7joB8mQuhHihkW//juv3OYQ7i8TVpCnIdd3+z06SS7hN6FPwO
         lsyxeo9nWPLdIXNmN6UQGnzmfLvhhIOoLEnUSIUUMeNRg61Uyn3t9/rtecVE9jB2sJDh
         2lBZ/krzDrmjl5bXINOPOgpRPXBXJltONet5/pUUQhDdTZvRUe+i7xTjae3eWaJBpOuW
         vpxWjgcNc/6VbjrpXSrppq5HYZqylNvGD2zWxxeyT3n28H+BYfli/2cJfB/gXbThpJIP
         Vq9eVkfw0O/eJ/5nP7hGkA1FSbfjWQfPptr3G3T99RrJfFj61/aDG42ltwVHmzKH1uF+
         1lqg==
X-Forwarded-Encrypted: i=1; AJvYcCUJbQpDRkB25Bwd3vO3jq1ZZhxJ0cHKWtBQiZCYmgHv3kjpUfPrmwUW6aHSGp50VLeIJqEZblwGemq1aW/yf+d/YHpCNwJOPju5HSV/
X-Gm-Message-State: AOJu0Yxm9kQVO1vhfBl+k69C8aUK3t1COIcBGNCcot864vZM9xNhR2jV
	YYLA8rA0ND8WjRLEPTZbDUhCzYao6PM/gQ53ovAw0uQH7UUHvRgIBpergwPjMfxV1F5QdviSHdL
	HZw==
X-Google-Smtp-Source: AGHT+IFUomxsPWf+KjDHq84WqaX003xsKucWIPaupPEaqwSpB3gujhuAtSkVM24DWrgFburemNGz5A==
X-Received: by 2002:a05:6a20:b2a5:b0:1bd:2782:3cda with SMTP id adf61e73a8af0-1bd27823dd1mr10126427637.35.1719616550480;
        Fri, 28 Jun 2024 16:15:50 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e38a9sm21189685ad.76.2024.06.28.16.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 16:15:49 -0700 (PDT)
Date: Fri, 28 Jun 2024 23:15:46 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED
 before using result_tf
Message-ID: <Zn9EIs5BqeFTQD9z@google.com>
References: <20240626230411.3471543-1-ipylypiv@google.com>
 <20240626230411.3471543-7-ipylypiv@google.com>
 <Zn8SPZG4y4wvSH-g@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn8SPZG4y4wvSH-g@ryzen.lan>

On Fri, Jun 28, 2024 at 09:42:53PM +0200, Niklas Cassel wrote:
> On Wed, Jun 26, 2024 at 11:04:11PM +0000, Igor Pylypiv wrote:
> > qc->result_tf contents are only valid when the ATA_QCFLAG_RTF_FILLED flag
> > is set. The ATA_QCFLAG_RTF_FILLED flag should be always set for commands
> > that failed or for commands that have the ATA_QCFLAG_RESULT_TF flag set.
> > 
> > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > ---
> >  drivers/ata/libata-scsi.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index 02af4d5d5799..d5874d4b9253 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -242,10 +242,16 @@ void ata_scsi_set_sense_information(struct ata_device *dev,
> >   */
> >  static void ata_scsi_set_passthru_sense_fields(struct ata_queued_cmd *qc)
> >  {
> > +	struct ata_device *dev = qc->dev;
> >  	struct scsi_cmnd *cmd = qc->scsicmd;
> >  	struct ata_taskfile *tf = &qc->result_tf;
> >  	unsigned char *sb = cmd->sense_buffer;
> >  
> > +	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
> > +		ata_dev_dbg(dev, "Missing RTF: cannot set ATA PT sense fields.\n");
> > +		return;
> > +	}
> > +
> >  	if ((sb[0] & 0x7f) >= 0x72) {
> >  		unsigned char *desc;
> >  		u8 len;
> > @@ -923,10 +929,16 @@ static void ata_to_sense_error(u8 drv_stat, u8 drv_err, u8 *sk, u8 *asc,
> >   */
> >  static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
> >  {
> > +	struct ata_device *dev = qc->dev;
> >  	struct scsi_cmnd *cmd = qc->scsicmd;
> >  	struct ata_taskfile *tf = &qc->result_tf;
> >  	u8 sense_key, asc, ascq;
> >  
> > +	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
> > +		ata_dev_dbg(dev, "Missing RTF: cannot generate ATA PT sense data.\n");
> > +		return;
> > +	}
> > +
> >  	/*
> >  	 * Use ata_to_sense_error() to map status register bits
> >  	 * onto sense key, asc & ascq.
> > @@ -970,6 +982,12 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
> >  		ata_scsi_set_sense(dev, cmd, NOT_READY, 0x04, 0x21);
> >  		return;
> >  	}
> > +
> > +	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
> > +		ata_dev_dbg(dev, "Missing RTF: cannot generate sense data.\n");
> > +		return;
> > +	}
> > +
> >  	/* Use ata_to_sense_error() to map status register bits
> >  	 * onto sense key, asc & ascq.
> >  	 */
> > -- 
> > 2.45.2.803.g4e1b14247a-goog
> > 
> 
> In order to be more consistent with existing prints in this file,
> please do not capitalize the first letter, and remove the punctuation.

Thanks! I'll remove periods and will keep the colons.

> 
> 
> Kind regards,
> Niklas


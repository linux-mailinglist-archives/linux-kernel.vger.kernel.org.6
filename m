Return-Path: <linux-kernel+bounces-233074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656EA91B1EE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143D828495C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8069E1A08DA;
	Thu, 27 Jun 2024 22:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OrZgkI3V"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C95719EEA9
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 22:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719525812; cv=none; b=b9K++x47c0ggXIe2cyxkQJHgjXKAw5OD6C6IvXVdOrj2KUzajQrkbRVHL7cF1anDXSliRTOZoGhLj41JGT+48tdjYHoRQJPP2Py/gvteQDPLjcNNfGZGzs0xqJ6ypEQatbmlHIPVFFqC1vzPq2L4oouwG79LXih1mzExp/J2jWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719525812; c=relaxed/simple;
	bh=ruVGYcvYTiFY7ob3kFKyWPd5pTS6/tfHCvKSvwJN6o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8nWOP2m8vEtF+ktraMX/hyaqJhm7PNE82E99/WvTQWhdgdWqFZUMcdmU90Ash2lXZpnCGY7M7N2xtTxA1jwzuWh6MMV80QO9ORcQ9KEWErgpTWVWWOGLm+VoWI1tNg1FPj7xmjyfevZX/p0Frh5gAXCGVuv6fvji5if1xXermY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OrZgkI3V; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-72c03d2926eso361013a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 15:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719525811; x=1720130611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vhvq8eSOHACbnB6DnMnFlIUUAp+10Kb7/uut0w6GZhk=;
        b=OrZgkI3Vx8YLlcDRNAMszykWdqgrWRh8RM28KWsVhqTMKd6h7zhw9skRigNwmkEa6z
         wYSN/jbBuDlwJoekdF4ReMuYX5gj3G1SnsjWXASsat4j2602iMcW/gKdIfSmf5zCTXtL
         TCVP97cYRbjOFdGJuIAHtwbuxXSTOTkGTo26ytR/raeyBMtLJcN36yWGoXE9dZEnQ8bQ
         dBIKvxwQ/kKdTgxzfNcdKWxy6+3NCNkP25EVRixhgZ9mxNXbaeNCyADl5t1FLu40Ofwi
         gQODmt6II+QamVIK3HfrLlvEErkrEgbITS8ZzgJF878qRTA51I4aTxAtGKAEbqQ0iKAG
         GmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719525811; x=1720130611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhvq8eSOHACbnB6DnMnFlIUUAp+10Kb7/uut0w6GZhk=;
        b=UK9UlNlXqbO/lfF+eaSGw1xgPPhQXQlQlIaL+ihQScoyXOOdxywXG4qOpCJXD8AfZj
         +3UeZaogMq87NNdsRHarJR0G+GquC/O45+uNHprdJv4Awxti3OmA6MeEJ1rrhwqYuPo/
         nLFJ+qTaTZ+uRKad60A0jHDRQYW5pJxqR0Gz9Cyje95IrjRGljOn2pvdcLjC0qnalaMX
         ykv57Rl1SLNP6OzCiZxWhvrWeL365N/e79DpLoo4xXFMbGXi1RN7pukSplQnnV1dif6N
         KelMw2Xssw21VVRkdMfKApqaI1YTIXCSjDbSlWfelPyyJk9dZgVqWWKp/ytTM4TXGUI+
         9KBg==
X-Forwarded-Encrypted: i=1; AJvYcCUfY7Kz7KTeFQQa01x0CQe8RuVE4s8lQKnMNj1elDYr+JcU7phV28A5jcS6jld0NSBjKGPssPK0X/Hahu+92s4F0Pu69MKErvIZM79Q
X-Gm-Message-State: AOJu0Yx6uWQ5VikZ5DATEnuxhZbp1629pizSyAL80MDA0hcUVCmG5RLk
	4y3UPJynpMx15KyisV1sqBZa/KUOoKNEnvTbLdEBuBuKjJ6tN0eheFOMCzMWAA==
X-Google-Smtp-Source: AGHT+IHuylOPpfQrS8FFXZXu4vWvJgTlwjrp3ySkFGvDcPmmxbmb1NWqcNURsPWRzP4vQLioXX96aQ==
X-Received: by 2002:a05:6a20:bf08:b0:1bd:22fe:fca2 with SMTP id adf61e73a8af0-1bd22fefd92mr8274941637.18.1719525810345;
        Thu, 27 Jun 2024 15:03:30 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91c7df8b0sm308591a91.0.2024.06.27.15.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 15:03:29 -0700 (PDT)
Date: Thu, 27 Jun 2024 22:03:26 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED
 before using result_tf
Message-ID: <Zn3hrlF2VW3dWH1f@google.com>
References: <20240626230411.3471543-1-ipylypiv@google.com>
 <20240626230411.3471543-7-ipylypiv@google.com>
 <9c8d751c-8d38-40f4-a88d-cfc39c7b6967@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c8d751c-8d38-40f4-a88d-cfc39c7b6967@kernel.org>

On Thu, Jun 27, 2024 at 09:19:17AM +0900, Damien Le Moal wrote:
> On 6/27/24 08:04, Igor Pylypiv wrote:
> > qc->result_tf contents are only valid when the ATA_QCFLAG_RTF_FILLED flag
> > is set. The ATA_QCFLAG_RTF_FILLED flag should be always set for commands
> > that failed or for commands that have the ATA_QCFLAG_RESULT_TF flag set.
> > 
> > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> 
> Please change "RTF" to "result TF" in the messages below, to be clear (RTF is
> not). Feel free to split the ata_dev_dbg() lines after "dev," to avoid long lines.

Thanks Damien! I wrote "result taskfile" first, then changed it to "result TF",
and then to "RTF" to shorten the lines :)

I'll change it to "result TF" with the line split in v3.

> 
> With that:
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> 
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
> 
> -- 
> Damien Le Moal
> Western Digital Research
> 
Thanks,
Igor


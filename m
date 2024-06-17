Return-Path: <linux-kernel+bounces-218435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D9490BFCD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AC7AB2146E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3246C19A2AE;
	Mon, 17 Jun 2024 23:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pRd+vyGL"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B48D19A2AB
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718667115; cv=none; b=FZA8Jrg8WPnsQdwwVV1VDup3JuMf0WG2MZL/PE0qr4zQfynzKLp+CO7yB1wUydxfopw18rSXG4/PIsPJkGpa1YihnaPa9vz29FfJvvmdYFPXcbtUSsiiJ6mtGpQSoKHJAlPG/6odzz1GcT64eveaN7Wkyq7i6cvlmXiDBUggrFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718667115; c=relaxed/simple;
	bh=7qbkRush5jqH6C4U4mHQ4zNjckTMadOjSd/ADCJT8l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCHunX3VL9K2vrfNPl9LZs5IEZdCqJno4WlDx+mrd00biuIU8xPIT6eOsYrmgIr3E676HEi4b+i9hLYqcAWVaO+OBiXwKoxnRnXhG5GadMSNMqKiIsj0NvJfV3I8FcQ7LCrxGswuURblWYMzPdtlbV5ZnrxeqmX1AwBIpQ0l8wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pRd+vyGL; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-705ff14d159so1315014b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718667113; x=1719271913; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3FO5nJ1Vj3EUf1P5YQy09laiFztkoKBjLr7YQiDGnGU=;
        b=pRd+vyGL0Tpi3rgrgbnc0naeost6UuElt9l4ylPCTXYNiP1wun5XwhbQx8yXqDfvM0
         Zwwkf8fKztgneWljqtW+0mpEc08MaYnRp5tvG84xmAkYs1HSMe7lHqJzF/8kpDIg75WU
         ppCZX7Zsjcw3n3RXaeDLDleleroh50qnDz2W2CPjOGDougUT1Pp+sQjVlm5y4WsJKf8Z
         5PQ3GZNoBlkYvv09g8SpBTydNnjpsbconA9zrCME+K22/twjmX9fIkzCX7DtV5VjxIjX
         FxVnXPCBowGMeBIJHG/8KnIa8i8DS+7HNuNfTQQEp7P+DOgZ/GVrKORltXjs8ek/GmTc
         Wnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718667113; x=1719271913;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3FO5nJ1Vj3EUf1P5YQy09laiFztkoKBjLr7YQiDGnGU=;
        b=es+mnHXl+fj2gL5NuUFYout1KbThmE8nb+B+s3JXkt+N6xxjUiMXdIk+x1psRHchho
         b47KQ2FQIz8rIyk239++RVy4WHq/2w/1fzC8IBCp6eXo/y9n5NgelRcl3UaTCsWBiZhQ
         g2C+w0QxvfBDXWulw5+sF38REUX971kZhVI/o/T4QwF5U4ParhS6iK5rqjgQSK1tu177
         G3JhhVIGOXBMbNt5N9y0MeeLhMCT+D2Mv9lkwXq2AbB8wtBNTfHBx1OoNrYO77pLP6H+
         76dh2EzubrF1+OFJNnwYhWHuEhdUds0+cnzS8YMGmAYHi0961P+X89j2IQ0Eb91rRhss
         heKw==
X-Forwarded-Encrypted: i=1; AJvYcCWc07AXOT1evRt1bX7Ds1Rvk42dBlblP2hpd+MZSVSrsVOfurx6oK8nqObcq6Cr79BCTsl8pJCL4SPdV1u4S4Myzb9I9GCNZP5z6aAE
X-Gm-Message-State: AOJu0YxlnLf4kB0KQUqwGUMgBaN3gbiqqGKaYPcSp959Z6GWkgzQV+GV
	MdHk4Eun0nvOpmRaZu9vKSKBx/eccVxquiDaglHQVCGFPyuRnVsky+FZ5XbG8Q==
X-Google-Smtp-Source: AGHT+IFxIYRKh3R8VVqY3cVNqHd4fZRi5puptw2mVg4a461ZGXjuvBxhqJ4fvAcNUguJu+wrN+90pQ==
X-Received: by 2002:a05:6a20:a11d:b0:1b4:da55:e1ba with SMTP id adf61e73a8af0-1bae7f65a87mr11801799637.9.1718667113110;
        Mon, 17 Jun 2024 16:31:53 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb6b9c9sm7890966b3a.160.2024.06.17.16.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 16:31:52 -0700 (PDT)
Date: Mon, 17 Jun 2024 23:31:49 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] ata: libata-scsi: Report valid sense data for ATA
 PT if present
Message-ID: <ZnDHZWZQFtUmwtwE@google.com>
References: <20240614191835.3056153-1-ipylypiv@google.com>
 <20240614191835.3056153-4-ipylypiv@google.com>
 <ZnAUy5C-DXEuliSm@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnAUy5C-DXEuliSm@ryzen.lan>

On Mon, Jun 17, 2024 at 12:49:47PM +0200, Niklas Cassel wrote:
> On Fri, Jun 14, 2024 at 07:18:34PM +0000, Igor Pylypiv wrote:
> > Do not generate sense data from ATA status/error registers
> > if valid sense data is already present.
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
> 
> Like I suggested in the earlier patch,
> 
> can't you do a:
> 
> if (qc->flags & ATA_QCFLAG_SENSE_VALID)
> 	return;
> 
> here instead?
> 

We need to populate the "ATA Status Return sense data descriptor" as per SAT-5
"Table 209 — ATA command results". By returning early we are skipping the code
that copies ATA output fields into descriptor/fixed sense data buffer.

> 
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
> > +	} else if (qc->err_mask ||
> > +		   tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
> > +		/*
> > +		 * Use ata_to_sense_error() to map status register bits
> > +		 * onto sense key, asc & ascq.
> > +		 */
> >  		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
> >  				   &sense_key, &asc, &ascq);
> >  		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
> > -- 
> > 2.45.2.627.g7a2c4fd464-goog
> > 


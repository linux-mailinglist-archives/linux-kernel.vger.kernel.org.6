Return-Path: <linux-kernel+bounces-220079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 741E590DC75
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCD2F1F23108
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6724016CD17;
	Tue, 18 Jun 2024 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HUnMPAJZ"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3159E15250C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 19:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718739126; cv=none; b=dqt6uArQUQKFuUzvkFdReKSupeswr7EWfUeKIJzxFiQFKCyHURbOfGZ+/DaOYf7EeQcDoLj6nTqCBM+dCbFZzmvF3osePTRZPVGLcJJ0/iZBah+TpN19Qn9lxHy1Xr2rY9rxTFFSsQeImYf+e0e02sQJgvJR/RXQ/Tm2as1iaxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718739126; c=relaxed/simple;
	bh=gogAE9KL/40Q9fZel0OE+Lk6uZ5lpZ6A+QIGBdM7yW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0vZigVRL6UIUIr1SMUNIQDUP2K2k5DS8ESYAAyZ9mHekzGcjMQiI9dVIRm0xeb/zU4qMdiWoPXssUKsdVCfY14wMW8rCIUL+l+ROsPYMIikT2jdzB/lhw5t1nb0/XetUryfWsW/UfN0Fy3cOiu0NySAKE+i5XVhaa2/Vn9HpzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HUnMPAJZ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7061d37dc9bso1099035b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 12:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718739124; x=1719343924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gGVtqutyEHPxTVvQWKPkJaIyYXm2BJ3IBE4f5NPgAOo=;
        b=HUnMPAJZN/Pirw5/Dz6dolknmX08bk6vN0IiA28L7dZF8UvNdqi4CAAMLH06BjuZI+
         ee6SZhJBCrnsrjblRlK+scuPcMEIA4ipiDZoG/2TcjndnfWiKXEVSjyk9SI3Khg/jBdx
         TYW1YhMBkuMqCbRi+OBrMtRXxVzl0ogq/HzygyDeWkNMSsL2FIFSPVpbgJau6vXX2k6R
         iuVvvJsSV4bU7NcMYBZdWFXHvZJpLZOEbD64kzFC5O0+FZYKIsYtBPc5NDAx+pfuyxX/
         G8dZj3DxYosc+y0K4f2lN3VtqZQ+hFm8tCxIzW9xDtvl2+e2RkjsVm80CsdoDLLkHSyn
         5KQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718739124; x=1719343924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGVtqutyEHPxTVvQWKPkJaIyYXm2BJ3IBE4f5NPgAOo=;
        b=Nmw6aAaDrpfHyXvLyylTHmy3i+PDxxtveTd2yleEsrOBRcAEaEoa79ncu5We/od2cv
         xiWPxE9F7pxs7+hkUHoUDr6D6Ms5z8dF+aPaMP6lZ23jCPm0+XI3RRxJEQ6HNj2bGAxD
         tU2nw4n03XKS64o0i5PjxHg4/FbUx5pzV99h8/pKKSQz2zwj3578jnXqkseQmBHCPQkF
         d0c5GQ6AGYhVQIaq8x56DQqI4YPgxe3dyoKBzjxKkBaIyvgmBe/+1tsRXYa0d6j6xufD
         OXe8Hhnx9f8z+bPXlAP6HyfMVSToWehiijik1t8cJTK0t9N1E0yOE1Xc6yB+rb703SH9
         JVMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU83jpYlp0988mdju/rB4S+6TGG3V7cL1/u/CAws0k8KFPPnuCKx0IX6ycgRd1ppRAMdDVC6hI3eRwA9d1bRO+bTqm2T4adWfku8wL
X-Gm-Message-State: AOJu0Yw7bkYCFsbgYHrnCnZGK+15QxZQGecr19VTS+PhW3V7X2DBxnv3
	NTO3ADjrqACRnP9+wUFLMaljNrZ1UraZCK0S7qdhGByAD3T9ZAXHREKh0XWcug==
X-Google-Smtp-Source: AGHT+IENDsBfiSpWc+1r6tA+Id++wNzmNu/HUV4tZsCKQm3NJyyTO4F75xOW21ef3RqunlNuJsUJSQ==
X-Received: by 2002:a05:6a20:af89:b0:1b8:9f3a:c1c3 with SMTP id adf61e73a8af0-1bcbb617391mr510712637.43.1718739124222;
        Tue, 18 Jun 2024 12:32:04 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb92a4bsm9314910b3a.212.2024.06.18.12.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 12:32:03 -0700 (PDT)
Date: Tue, 18 Jun 2024 19:31:59 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, Hannes Reinecke <hare@suse.de>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v1 1/4] ata: libata: Remove redundant sense_buffer memsets
Message-ID: <ZnHgr2mgWGTDFXaT@google.com>
References: <20240614191835.3056153-1-ipylypiv@google.com>
 <20240614191835.3056153-2-ipylypiv@google.com>
 <2e89e829-9caa-470a-9ec8-5e8162fb5559@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e89e829-9caa-470a-9ec8-5e8162fb5559@kernel.org>

On Mon, Jun 17, 2024 at 08:13:51AM +0900, Damien Le Moal wrote:
> On 6/15/24 04:18, Igor Pylypiv wrote:
> > scsi_queue_rq() memsets sense_buffer before a command is dispatched.
> > 
> > Libata is not memsetting sense_buffer before setting sense data that
> > was obtained from a disk so there should be no reason to do a memset
> > for ATA PASS-THROUGH / ATAPI.
> 
> This sentence is not very clear at all... I assume that the first part of the
> sentence is for non passthrough commands. In this case, libata does not clear
> the sense buffer because the scsi layer did that already, in scsi_queue_rq() as
> noted above.
> 
> For passthrough commands, the same should be happening as well since passthrough
> commands are also executed through blk_execute_rq() -> scsi_queue_rq(). So I do
> not really understand (but I do agree that the memset() in libata seem useless).

Thanks! I'll update the commit message to make it more clear.

> 
> > Memsetting the sense_buffer in ata_gen_passthru_sense() is erasing valid
> > sense data that was previously obtained from a disk. A follow-up patch
> > will modify ata_gen_passthru_sense() to stop generating sense data based
> > on ATA status register bits if a valid sense data is already present.
> 
> This fix should come first in the series, since that commit will likely need to
> go into current rc and cc-stable. And that will simplify this patch as well.
>
Ack. I'll reorder the commits.

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
> 
> -- 
> Damien Le Moal
> Western Digital Research
> 

Thank you,
Igor


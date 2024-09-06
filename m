Return-Path: <linux-kernel+bounces-319329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE22196FB2D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75CCE28B47C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C811B85CE;
	Fri,  6 Sep 2024 18:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ed8BTvj/"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4381B85C6
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 18:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725646911; cv=none; b=rRPr7PiaZb34yUDgVXXVYbMg2Cctc91rVpSj8cLXpcd0XW7V6irqdA90ApNgo3sKEIQiMl79JZoz64IJnnbqshiRMPJuT49Dogd/HnPIr1HbxqDkyy7chTTAF1PwBqxz1LJjGwdxYNNmNrSe8uH7Hf+bTGr2E+efmjWrztL5BYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725646911; c=relaxed/simple;
	bh=1RcEtQxyXNVEHPH7M+N7u9SwlkljoJhEEidqIj6eUDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fB08GoKxArXkIPK4ksuMdlZQzWOxgxsjCC1t4WDBc9YSTyfWxQeOC2Ty3HeCb0OvmlR7+TMwFyOZOa7zrXEUDRyvzEKTCNALFxQQnkQ+GGoF7fVt0GfLlImaF2Lyrr8GhBRsa6ZjloeltHlgTbncsEEeaI9rj8o1PljO8t53jdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ed8BTvj/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-206fee0a3d7so24215ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 11:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725646909; x=1726251709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pwnPIEm0KPjGFsFfnsKbez6B1guLorw0OsRGnKG8tk8=;
        b=Ed8BTvj/GfZ7J1P2eaqE0U5iIJGv/W3DpurUoFAgodb+QIS5YLYfw7ip9y3aQtg7qz
         8masVBrivreSdE81WUpvjfF8b8A9ccGparPkOKAC1irxFuV/GQFWqWLn+Cb8eMetg8rq
         REKhRL2muKxxHSaLpm84XaqoBlG8/M2dGe8DvOqHpvzETPdysnvO7AWAUW3xHBHZf1vF
         DTgjly2einaF61KysNHFd5QGURM8z5aWqxRf1vD6zyelSLgHCVgWGJp7dpsNK0h/7b7g
         QlqGb8Ia/XwdDtdSeWbVUqrBOFrA6yJKHq4bqyy3RXhGH3zCfld0CqMf7yhSfJCm6QWI
         32rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725646909; x=1726251709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwnPIEm0KPjGFsFfnsKbez6B1guLorw0OsRGnKG8tk8=;
        b=Q+HweIPxzCGabLNhnTiRbGYUp3U777qL9lQlOoUkq5cWPgoBV2Qn2vmqAn1fURkoyq
         sqA3RTc3khe9hbq2qGioErOoyMvs78/Ykmh+B5LTLqbLZLsdUVIOKUMTURncx/k6tYrQ
         4pRKRgz0K3xfQxfZUQ6bHAKSQ7A0e9xcFu1x3cGpr8D84w/d9Z7g5F223xGKo1MFv4M7
         1cO1dd59NeOqoYG6WWMgm9O/+s+EoDul9ugGqKuF9sWZThe/wKNZr8XNz1qrHth0KrcG
         wRYh6MDwtRIin9bnG6DruUeyAzafUYcXAVn7jKXAHYHNpHesI6w0mCCkmVqToRo3ybGQ
         tgfA==
X-Forwarded-Encrypted: i=1; AJvYcCVmov1A6dwwmPuTYefjYiWUk5/tBaVrOwQuhs5AhFbc0vBaYKOzv8h5DWYHvUFWtlQq+18nZ4DZNGgaha8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQhgDIZF0Ot3z8B3UUEEBabi40Xuh46cmPu8HCB1NKJ+zG7mh0
	//05/SUhANU7zuRMXlVNQN7mJHX2Cj/U/jWTWnhuLABxByp5ypmx81EWVuVOUQ==
X-Google-Smtp-Source: AGHT+IH/9spz8okDWsysDTf0twuxS8zpWgXzuPiPzEugvmY5I1byDGpPFmsWX7QgKP/e7AsOKGRWDg==
X-Received: by 2002:a17:902:d48a:b0:1f7:34e4:ebc1 with SMTP id d9443c01a7336-2070b7b8aa3mr121975ad.5.1725646908383;
        Fri, 06 Sep 2024 11:21:48 -0700 (PDT)
Received: from google.com (35.72.105.34.bc.googleusercontent.com. [34.105.72.35])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8aab2sm5236848a12.20.2024.09.06.11.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 11:21:47 -0700 (PDT)
Date: Fri, 6 Sep 2024 18:21:43 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: libata-eh: Clear scsicmd->result when setting
 SAM_STAT_CHECK_CONDITION
Message-ID: <ZttIN8He8TOZ7Lct@google.com>
References: <20240904223727.1149294-1-ipylypiv@google.com>
 <Ztls4mim6Jky7E0S@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ztls4mim6Jky7E0S@ryzen.lan>

On Thu, Sep 05, 2024 at 10:33:38AM +0200, Niklas Cassel wrote:

Hi Niklas,

Thank you so much for a thorough review and coming up with a better patch!

> Hello Igor,
> 
> On Wed, Sep 04, 2024 at 10:37:27PM +0000, Igor Pylypiv wrote:
> > commit 24aeebbf8ea9 ("scsi: ata: libata: Change ata_eh_request_sense() to
> > not set CHECK_CONDITION") changed the way how SAM_STAT_CHECK_CONDITION is
> > set. Assignment "scmd->result = SAM_STAT_CHECK_CONDITION;" was replaced by
> > set_status_byte() which does not clear the scsicmd->result.
> 
> "which does not clear the scsicmd->result"
> 
> scsicmd->result is a combination of:
> -SCSI status byte
> -SCSI ML byte
> -host byte
> 
> Please be more specific of which byte(s) that you want to clear,
> both here and in other places in the commit message.
> 
> 
> > 
> > By not clearing the scsicmd->result we end up in a state where both
> > the DID_TIME_OUT host byte and the SAM_STAT_CHECK_CONDITION status
> > bytes are set.
> > 
> 
> 
> > The DID_TIME_OUT host byte is getting set a part of error handling:
> > 
> > ata_qc_complete()
> >     ata_qc_schedule_eh()
> >         blk_abort_request()
> >             WRITE_ONCE(req->deadline, jiffies);
> > 
> > blk_mq_timeout_work()
> >     blk_mq_check_expired()
> >         blk_mq_rq_timed_out()
> > 	    req->q->mq_ops->timeout() / scsi_timeout()
> >                 set_host_byte(scmd, DID_TIME_OUT);
> 
> I would have reorder your commit log and have this first in the commit log.
> 
> 
> > 
> > Having the host byte set to DID_TIME_OUT for a command that didn't timeout
> > is confusing. Let's bring the old behavior back by setting scmd->result to
> > SAM_STAT_CHECK_CONDITION.
> 
> I think you are missing something very important in the commit log here:
> What is the user visible change before and after your change?
>

For ATA PT commands the 'result' value is being returned to user space so
not clearing the DID_TIME_OUT is user visible.

> Is there a difference is the error message in dmesg? If not, that should
> be mentioned as well.
> 

I haven't seen any dmesg errors reported for ATA PT hence I don't think there
is any difference in dmesg.

> 
> > 
> > Fixes: 24aeebbf8ea9 ("scsi: ata: libata: Change ata_eh_request_sense() to not set CHECK_CONDITION")
> > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > ---
> >  drivers/ata/libata-eh.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> > index 214b935c2ced..4927b40e782f 100644
> > --- a/drivers/ata/libata-eh.c
> > +++ b/drivers/ata/libata-eh.c
> > @@ -1605,7 +1605,7 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc)
> >  		 */
> >  		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID) &&
> >  		    (stat & ATA_SENSE) && ata_eh_request_sense(qc))
> > -			set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);
> > +			qc->scsicmd->result = SAM_STAT_CHECK_CONDITION;
> 
> ata_eh_analyze_tf() will only be called on commands that are owned by EH
> (has ATA_QCFLAG_EH set).
> 
> Thus this command will end up in:
> ata_eh_finish() -> ata_eh_qc_complete() -> __ata_eh_qc_complete() ->
> -> __ata_qc_complete() -> qc->complete_fn().
> 
> complete_fn will be (except in special cases): ata_scsi_qc_complete()
> If you look at ata_scsi_qc_complete(), it already clears the host byte:
> https://github.com/torvalds/linux/blob/v6.11-rc6/drivers/ata/libata-scsi.c#L1695-L1696
>
> So could you please be more specific of what problem this change is fixing?
> Is it just that you think that it makes sense to clear the host byte earlier
> in the call chain?

I should have mentioned that the issue is specific to ATA PT commands.
The problem is that ata_scsi_qc_complete() is not clearing the host byte
for ATA PT commands causing the DID_TIME_OUT to be returned.

> 
> There are many different paths a QC can take via EH, e.g. policy 0xD NCQ
> commands will not fetch sense data via ata_eh_request_sense(), so clearing
> the host byte in ata_scsi_qc_complete() should be fine, otherwise we need
> to do a similar change to yours in all the different code paths that sets
> sense data ...which might actually be something that makes sense, but then
> I would expect a patch series that changes all the locations where we set
> sense data, not just in ata_eh_analyze_tf(), and then drops the clearing in
> ata_scsi_qc_complete() (which was introduced in commit 7574a8377c7a ("ata:
> libata-scsi: do not overwrite SCSI ML and status bytes")).
> 
> 
> See this patch to see all the places where we set sense data:
> https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/commit/?h=for-6.12&id=9526dec226f0779d72f798e7a18375bf8d414775
> 
> 
> 
> 
> Side note:
> You might also be interested to know that a command that was sent via EH will
> be finished using scsi_eh_finish_cmd() (called by __ata_eh_qc_complete()),
> and will thus end up in scsi_eh_flush_done_q(). A command that has sense data
> will have scmd->retries == scmd->allowed (set by ata_eh_qc_complete()), so you
> will end up in this code path:
> https://github.com/torvalds/linux/blob/v6.11-rc6/drivers/scsi/scsi_error.c#L2213-L2227
> 
> Which means that SCSI EH will set DID_TIME_OUT for any command that does
> not have (SCSI ML byte || SCSI status byte || host byte) set.
> 
> A command with sense data will have most often have CHECK_CONDITION set, but
> there is also CDL policy 0xD commands (which will have the SCSI ML byte set).
> So this special flag SCMD_FORCE_EH_SUCCESS is for commands that were completed
> successfully without any SK/ASC/ASCQ in the same interrupt as other policy 0xD
> commands which did have SK/ASC/ASCQ set.
> For details, see 3d848ca1ebc8 ("scsi: core: Allow libata to complete successful
> commands via EH").
> 
> 
> Kind regards,
> Niklas


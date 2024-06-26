Return-Path: <linux-kernel+bounces-229856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A83691753B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 02:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ACAD283D88
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 00:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A351B6FDC;
	Wed, 26 Jun 2024 00:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HVhVmB4n"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906A21847
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 00:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719361842; cv=none; b=rT24N+OQUuygBUsdwEN9h55iyWDLdiysWHd9paJwU1AF9bSpRd9ehuDJJxqz0HhWY/njeN4Nt5RQUhlUTtFmHTqvucDO6JVKAx3Ar2RrnVvAiBuJS0zQ0Vwedt38OV5z84Z4UDZ21+OASZwJqk0lces7MbM7z5wm5shpfxHCR2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719361842; c=relaxed/simple;
	bh=//lbaRqY5eoLuH4cVGLi2EsZ7aNqiiSDMS7zZVy2wIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QM9jltv2yTND5j+mPEGmiCre79llOQ7rwWeyXe0bZA7qJe5M+msNQLGR509x+Axs/V7myjheV88r65A0aUSh/6zNvdH/oD6luGmd82Dma4wQuVO/d1YNB2vBpbc7Mcu//DGCmvD9Y0O5Ah6xiVvmVIPokqn+yGqv8R5GZYGYEp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HVhVmB4n; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f480624d0dso52007215ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719361841; x=1719966641; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i23/JHna8Kw5DlU8qzmRWS+LzRQQ+oAyxg9Kg6RIE+I=;
        b=HVhVmB4nMUueVIppBPYhu3oj2poxdny/dxItr7vGadnFfT7Vs9vDkpXjfwf8L99qhT
         D4lo9VXkZ6z48bWMUI8BcWzGwaW+HN8seLhz0g68GFqK2jwRapmrrCXgpY/wa8hQpJ1P
         I4XwZxgVbxbZEnfk0Cy9S810GcEzOfSfvje6tddHHN9nZRiuCKAFrVkvh0Y/Rft1VPEN
         9h2JbJeTtO6qA/ZBW40qtk9acmL2gBuOpfQFpQblO3+RpZMdFvHBmiVvejHLZFj4Ekbu
         B5ZxOjnfH/IbwdCiUWAivZMyyNfGD7Cq/rDrbfsZXvka8FN4jxmy2Lzvw9Mm3Lc55ILs
         EckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719361841; x=1719966641;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i23/JHna8Kw5DlU8qzmRWS+LzRQQ+oAyxg9Kg6RIE+I=;
        b=F+0GKDtXUdrMXDB6ncvtKGfILwJs2h+YigtVzzDs3M1ZtazECyYGrcbw/g7Hg1WS78
         SOp8gaSVijWVsEfD6FdkODMN1B6Hm1UuzQvSzh/VdlFzVlI8bk9fsXuynd1waS3Fb1ue
         X90S6KkL6/oYUNv2BSIAHVitdz//IGBlMzfV7Vuzdre2Rg3g+DBfZZi+F1gS/ysBvowR
         IjZCjYD80K2WHrIU/lNNNr+cnjPurG4u3wSI9+iJ4b5DFxEFDAnSTEKfy8NhZdZghRCB
         v4iOiteYk929T0MtLMPYa9T/WYD5AxxdlVePx0RCzaPWXT4WTEfQtxmSLCwLoiFOpWga
         P7Ew==
X-Forwarded-Encrypted: i=1; AJvYcCXaJakhyMIvWAiEAdFUWg5qto8YIFYjn4GGSu59P15hUBZfjuGAK7O6Rm0YB4yHsyCbi9sfxHLr666Y9ZQYAifKEz1JLpLqQnnd7/CZ
X-Gm-Message-State: AOJu0YzIYDAbb/VRqrUlJdWj19vYT+6HBRjzRa8ZBQ1C1BJAbmBH7Cb9
	/pKBe9idLjesY8G6da7L1RwJjQONNIKt6ywKPM6PrbIPDp0IZwgHCwM9bMc0Cg==
X-Google-Smtp-Source: AGHT+IFx/AHTzD88KwcwaUMpPa/wWT49rpSS1KTboIK2UJ56CegkPm+jg5af9OdvUO9x64xl23dIbw==
X-Received: by 2002:a17:90b:4f8c:b0:2c7:aafb:8e3c with SMTP id 98e67ed59e1d1-2c861246c21mr8421073a91.18.1719361840450;
        Tue, 25 Jun 2024 17:30:40 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8d81d29desm234795a91.53.2024.06.25.17.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 17:30:39 -0700 (PDT)
Date: Wed, 26 Jun 2024 00:30:35 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jason Yan <yanaijie@huawei.com>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED
 before using result_tf
Message-ID: <ZnthK-NjkSgIiGiE@google.com>
References: <20240624221211.2593736-1-ipylypiv@google.com>
 <20240624221211.2593736-7-ipylypiv@google.com>
 <7d085940-2ad1-4f44-83bb-33d852e80da0@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d085940-2ad1-4f44-83bb-33d852e80da0@suse.de>

On Tue, Jun 25, 2024 at 08:26:59AM +0200, Hannes Reinecke wrote:
> On 6/25/24 00:12, Igor Pylypiv wrote:
> > qc->result_tf contents are only valid when the ATA_QCFLAG_RTF_FILLED flag
> > is set. The ATA_QCFLAG_RTF_FILLED flag should be always set for commands
> > that failed or for commands that have the ATA_QCFLAG_RESULT_TF flag set.
> > 
> > For ATA errors and ATA PASS-THROUGH commands the ATA_QCFLAG_RTF_FILLED
> > flag should be always set. Added WARN_ON_ONCE() checks to generate
> > a warning when ATA_QCFLAG_RTF_FILLED is not set and libata needs to
> > generate sense data.
> > 
> > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > ---
> >   drivers/ata/libata-scsi.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index e5669a296d81..7a8a08692ce9 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -246,6 +246,9 @@ static void ata_scsi_set_passthru_sense_fields(struct ata_queued_cmd *qc)
> >   	struct ata_taskfile *tf = &qc->result_tf;
> >   	unsigned char *sb = cmd->sense_buffer;
> >
> > +	if (WARN_ON_ONCE(!(qc->flags & ATA_QCFLAG_RTF_FILLED)))
> > +		return;
> > +
> >   	if ((sb[0] & 0x7f) >= 0x72) {
> >   		unsigned char *desc;
> >   		u8 len;
> > @@ -928,6 +931,9 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
> >   	unsigned char *sb = cmd->sense_buffer;
> >   	u8 sense_key, asc, ascq;
> > +	if (WARN_ON_ONCE(!(qc->flags & ATA_QCFLAG_RTF_FILLED)))
> > +		return;
> > +
> >   	/*
> >   	 * Use ata_to_sense_error() to map status register bits
> >   	 * onto sense key, asc & ascq.
> > @@ -971,6 +977,10 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
> >   		ata_scsi_set_sense(dev, cmd, NOT_READY, 0x04, 0x21);
> >   		return;
> >   	}
> > +
> > +	if (WARN_ON_ONCE(!(qc->flags & ATA_QCFLAG_RTF_FILLED)))
> > +		return;
> > +
> >   	/* Use ata_to_sense_error() to map status register bits
> >   	 * onto sense key, asc & ascq.
> >   	 */
> 
> Hmm. Not sure if we really need the WARN_ON() here or whether a simple
> logging message wouldn't be sufficient; after all, we continue fine here.
> 

My worry about adding a simple log statement is that it might cause a log
spam if things go wrong for some reason.

This code is more like a "this should never happen" comment and we always
expect ATA_QCFLAG_RTF_FILLED to be present when generating sense data
based on ATA registers.

If WARN_ON_ONCE() is too much for this case I guess we can just remove it
and silently return?

Damien, Niklas, what are your thoughts on this?

Thanks,
Igor

> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N�rnberg
> HRB 36809 (AG N�rnberg), GF: I. Totev, A. McDonald, W. Knoblich
> 


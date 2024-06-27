Return-Path: <linux-kernel+bounces-233046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C77D91B182
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4CD6B25CC6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79F31A08CF;
	Thu, 27 Jun 2024 21:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QGzIUFz+"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5491A0729
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719523342; cv=none; b=qplLEQf1/O04g7QdwjaiHq1nvrBbaS7P2HwXB5p5kxGwyJbhR4oMLlshF18SjydhXvRo1tk/fbVlNnZTKV+8V6BS5Kmguma3tusVE9e2Hoi/SenGb5E4qz3B7Is4NGXOAjCt8VNEZrHn9zTOdy4bdX68mykG+nsHqTpObdOt7cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719523342; c=relaxed/simple;
	bh=whfQVJTqJ7KJ0VxOyRfPiNhfqsaunBsnGeFsXvTkJBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgMvhmVqRuoKXLB/Wkfm1kgl/usxBVrASdgTVMupRE5ghbqG0XmqP4JvXS5JBAbGVmbTOYBvwBZJ4eVtmhnU0QhY9CH32SMVw1h4kRlpRdDNzKk683yvDDhq7AMY9MK305dlGzr9livD+KvNtZ9XUIlVvxI7xpSkYLkX3OzS8tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QGzIUFz+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f9e2affc8cso55545135ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 14:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719523338; x=1720128138; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5jKJZjz46n85iPjR+qb7a7teMFGLnU0s6sJD+tdHoMs=;
        b=QGzIUFz+r8AnxI0mihiLNaLu5gxeNPtN6rIR7imxH/JI7sbgRTiFNY0QZ3l2Zv3IbT
         pJcC5s5qFCyMaFWMXbCNfCPd9k+Lne905Xc9KUMHwPUZ/739JNAjuNHR8FrbewgOHKHZ
         HKGlF9b+4MTilInYAPx35/3aPXCcRcCoIGmNzarA6fNtunUOTvpOcNrkmX4WSAnoZaa5
         BaV7jInhKLOFzDfjLK9ONnbrsczuAV7JlPy4kcm7iuNOokqib+FmbIznxDEWqtjoz8fR
         DP2t6o6gzUSa5YMkx2WnlIHhj0FtXxUEYnPIpSflsCRZNjo5ZvU9TMNycnqxjCNXIjrp
         AkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719523338; x=1720128138;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jKJZjz46n85iPjR+qb7a7teMFGLnU0s6sJD+tdHoMs=;
        b=QGNrCgU3610fbgFDqHspo7gNFL+ETiq/8LUBeIonPOf8Z6nueIsnCx5z6Sxnp19KjA
         reeFHgDXlKbKKRqqIqok1XaPsWAThIOXfvpeWmfx8P6iI3xMgVReqkm0prAOYcocEP6H
         PEq75BYrzaLCoONAxJRpZiaww/jkWAAuQFOtpQ2KnbU0eJZZdgHQJeWZh9pB/5bRHw+f
         EwYfGSIjSDkaJ3I4RO850c+fqi25wL/1hEEpmQMXuNzDzTDzqNMl+vm4vyjJlsQu30CY
         iZ7Q4jZNtUvzlAZpGgefUqIyKP5rZyOB8nvbzlRpZB5KO5o8/TLhn6VJOaQ7oT1KYjxM
         NmLg==
X-Forwarded-Encrypted: i=1; AJvYcCVnE/z2QO5LoOrNx4VoKBmaXJ8Yn4BnBiPYaA7iPHM4G2l0XYNrTVZAaLOHOIuRNCtyEX7TLkIIA6V8IPjOIB9YVWsu8HlhZc2vKHoJ
X-Gm-Message-State: AOJu0Yzlj/xYJHgZalfCH7bq939sKwb/E4l9xJT+Ht2ekiT2D+CIn4FN
	bwX6Ri2ijuTCaXrwCuRWApUcH08SlCTp340VniNxopv2Lj6wZyWJLbkd4/mPOg==
X-Google-Smtp-Source: AGHT+IHdFTZQRvPcLE1anzbbYiFhhHX5sG6m2LXtCjq4LlIivm5yWh/1UvEWWWYm08Rds2iX75LE4w==
X-Received: by 2002:a17:902:d2c8:b0:1fa:428e:3179 with SMTP id d9443c01a7336-1fa428e332emr144335795ad.45.1719523338255;
        Thu, 27 Jun 2024 14:22:18 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac155c32esm2140625ad.185.2024.06.27.14.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 14:21:56 -0700 (PDT)
Date: Thu, 27 Jun 2024 21:21:11 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Akshat Jain <akshatzen@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/6] ata: libata-scsi: Fix offsets for the fixed
 format sense data
Message-ID: <Zn3Xx11UIbbJkbxq@google.com>
References: <20240626230411.3471543-1-ipylypiv@google.com>
 <20240626230411.3471543-2-ipylypiv@google.com>
 <Zn1WUhmLglM4iais@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zn1WUhmLglM4iais@ryzen.lan>

On Thu, Jun 27, 2024 at 02:08:50PM +0200, Niklas Cassel wrote:
> Hello Igor, Hannes,
> 
> The changes in this patch looks good, however, there is still one thing that
> bothers me:
> https://github.com/torvalds/linux/blob/v6.10-rc5/drivers/ata/libata-scsi.c#L873-L877
> 
> Specifically the code in the else statement below:
> 
> 	if (qc->err_mask ||
> 	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
> 		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
> 				   &sense_key, &asc, &ascq);
> 		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
> 	} else {
> 		/*
> 		 * ATA PASS-THROUGH INFORMATION AVAILABLE
> 		 * Always in descriptor format sense.
> 		 */
> 		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
> 	}
> 
> Looking at sat6r01, I see that this is table:
> Table 217 — ATA command results
> 
> And this text:
> No error, successful completion or command in progress. The SATL
> shall terminate the command with CHECK CONDITION status with
> the sense key set to RECOVERED ERROR with the additional
> sense code set to ATA PASS-THROUGH INFORMATION
> AVAILABLE (see SPC-5). Descriptor format sense data shall include
> the ATA Status Return sense data descriptor (see 12.2.2.7).
> 
> However, I don't see anything in this text that says that the
> sense key should always be in descriptor format sense.
> 
> In fact, what will happen if the user has not set the D_SENSE bit
> (libata will default not set it), is that:
> 
> The else statement above will be executed, filling in sense key in
> descriptor format, after this if/else, we will continue checking
> if the sense buffer is in descriptor format, or fixed format.
> 
> Since the scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
> is called with (..., 1, ..., ..., ...) it will always generate
> the sense data in descriptor format, regardless of
> dev->flags ATA_DFLAG_D_SENSE being set or not.
> 
> Should perhaps the code in the else statement be:
> 
> } else {
> 	ata_scsi_set_sense(qc->dev, cmd, RECOVERED_ERROR, 0, 0x1D);
> }
> 
> So that we actually respect the D_SENSE bit?
> 
> (We currently respect if when filling the sense data buffer with
> sense data from REQUEST SENSE EXT, so I'm not sure why we shouldn't
> respect it for successful ATA PASS-THROUGH commands.)
> 

Thanks for pointing this out, Niklas! I agree, it seems like there is no
reason to ignore the D_SENSE bit.

Interestingly, the code was using ata_scsi_set_sense() before.
Commit 11093cb1ef56 ("libata-scsi: generate correct ATA pass-through sense)"
changed it to always be in the descriptor format.

> 
> Kind regards,
> Niklas

Thanks,
Igor


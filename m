Return-Path: <linux-kernel+bounces-218533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF5190C1A2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25CFC1C21A15
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA9817C95;
	Tue, 18 Jun 2024 01:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I5D/UGzy"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF124C98
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 01:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718675500; cv=none; b=pQh81e1Q55LArIMct2UFjXTBgIo3o1GMQapfSg+8TueLOkcaRfxPmYwW/972kw15FxkAGtx5bwac3tv+/RsPbUj5OiXm/3jhVq2j+sp7IEhLg8ngRytVm/dHGKF+ocEvCt/UyC8Uu0xNlB3VtF0Fb+U75bIXRjCiihZFmuZQ2aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718675500; c=relaxed/simple;
	bh=hMkjKPv985IpdOvdWgFvnGBRvJIT75npFty3jGqy6DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqds3HLXwGG3dKLtTV20I7XYSQupZjyxBkDEWIyMCzGEIr98ZZnGbcBJjRjzo2UAPLu/YI1Ljd09dWCCADVC8RZFEWPNDsQ0nSQc+hX8a4FdsgcXtnKmQHa8vlsvEAinHmmxPd19xY4cWmEdUyEoT9QXZaV7mDrDdI/xSz0xWdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I5D/UGzy; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d21e00d9cfso2965407b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718675498; x=1719280298; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O8DT4vnSsckXWtxvc8ohh5KTY3XsHIoiRBbMkvSpH2o=;
        b=I5D/UGzy7NGynmlf5GbA7PDTcX7c0jJJ5R9hEWvOQmG47+XQqwk2mKrcvRLdK9j++8
         vLoT0oeWRElOWFbZDHAOTDC68oklN3HdH1J37g4Jv4cJpZN51/kHJH3RcZepbNXsk0H4
         +bm7C+q5rqsvDcUtVw+guMxGR7iJdI/mtDwjXGPZ842702pri/tgCvxRFYbjzXV1YU3A
         g2ZWS2atCo7neClXmvtjzM8XXu9SMjOAFmWjGu6wAYk3aOrXyXGod+9MEHjCxvaHcLlz
         ofH1flGw5vyxuo7JoOPgwfTT/W3BaAsEHtZNOuzrHk7Ak/L9O7xLAdWJZSTGuWHTUfea
         qemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718675498; x=1719280298;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O8DT4vnSsckXWtxvc8ohh5KTY3XsHIoiRBbMkvSpH2o=;
        b=dtTpqIbUuBFRkF2LC9zy7E+2/DcR38M1Vr6rtoqhC4F30tEhbwu62zoKKYyHGhj9gL
         1AlwB88UhUhXpt50X2+rNkfxDzhHEVWVinu9mlCXu5aqgsYQi47qSz5UVu+rHVapvIGG
         XCGNAKEjMZNxdIVbSl3Gh8ys2bIzbcUhI6YOi/D0xG2LSbb2kFOhiOkxRXSSBqh+Mow4
         /DB2t6SOR1Qz1d19B5xef7stINYo8/pq1qnbWDRC4b7jDVVtHAmW2bVE4YQa3RG5ohB7
         YnUctu4pwx/WxEt1Xf+NtZin0/pP6kHklhEg47X7FCjm+HqNooGd6Rz7x/ty88XdMPwZ
         h+2A==
X-Forwarded-Encrypted: i=1; AJvYcCUrZDad/1A0Mta8FLxTJFOf9sQDf2PCOPpcSmUwYjQu8yClK1it3K2waHngbRcMNThUEQw10MRRsXIOvGPLfUETe9he7FpUKQzInlUL
X-Gm-Message-State: AOJu0Yy9rRl1qJB7CHcaVt/8cgmfgs35WbMZd12aZhTN55oadcWs6DDx
	cWB8K5BdHnXnWTiGkUFkDpp7d/2tZNFZbQNgATcueC0jLVDvx/A4wI5t48V2VQ==
X-Google-Smtp-Source: AGHT+IGZCi13AF0IHa1IirbKk1+YU5KknFtaROCYslbDLM9YsqsmHASLonvhRrxLXgitbEBlXceAFA==
X-Received: by 2002:a9d:7449:0:b0:6f1:4414:14b4 with SMTP id 46e09a7af769-6fb93766bd5mr12343092a34.10.1718675497603;
        Mon, 17 Jun 2024 18:51:37 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedf49d7b1sm7240876a12.51.2024.06.17.18.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 18:51:36 -0700 (PDT)
Date: Tue, 18 Jun 2024 01:51:33 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Akshat Jain <akshatzen@google.com>
Subject: Re: [PATCH v1 4/4] ata: libata-scsi: Fix offsets for the fixed
 format sense data
Message-ID: <ZnDoJQUbFOvVHqqK@google.com>
References: <20240614191835.3056153-1-ipylypiv@google.com>
 <20240614191835.3056153-5-ipylypiv@google.com>
 <6ce12728-c9a4-4780-af55-69674e510c12@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ce12728-c9a4-4780-af55-69674e510c12@kernel.org>

On Mon, Jun 17, 2024 at 08:37:09AM +0900, Damien Le Moal wrote:
> On 6/15/24 04:18, Igor Pylypiv wrote:
> > Correct the ATA PASS-THROUGH fixed format sense data offsets to conform
> > to SPC-6 and SAT-5 specifications. Additionally, set the VALID bit to
> > indicate that the INFORMATION field contains valid information.
> > 
> > INFORMATION
> > ===========
> > 
> > SAT-5 Table 212 — "Fixed format sense data INFORMATION field for the ATA
> > PASS-THROUGH commands" defines the following format:
> > 
> > +------+------------+
> > | Byte |   Field    |
> > +------+------------+
> > |    0 | ERROR      |
> > |    1 | STATUS     |
> > |    2 | DEVICE     |
> > |    3 | COUNT(7:0) |
> > +------+------------+
> > 
> > SPC-6 Table 48 - "Fixed format sense data" specifies that the INFORMATION
> > field starts at byte 3 in sense buffer resulting in the following offsets
> > for the ATA PASS-THROUGH commands:
> > 
> > +------------+-------------------------+
> > |   Field    |  Offset in sense buffer |
> > +------------+-------------------------+
> > | ERROR      |  3                      |
> > | STATUS     |  4                      |
> > | DEVICE     |  5                      |
> > | COUNT(7:0) |  6                      |
> > +------------+-------------------------+
> > 
> > COMMAND-SPECIFIC INFORMATION
> > ============================
> > 
> > SAT-5 Table 213 - "Fixed format sense data COMMAND-SPECIFIC INFORMATION
> > field for ATA PASS-THROUGH" defines the following format:
> > 
> > +------+-------------------+
> > | Byte |        Field      |
> > +------+-------------------+
> > |    0 | FLAGS | LOG INDEX |
> > |    1 | LBA (7:0)         |
> > |    2 | LBA (15:8)        |
> > |    3 | LBA (23:16)       |
> > +------+-------------------+
> > 
> > SPC-6 Table 48 - "Fixed format sense data" specifies that
> > the COMMAND-SPECIFIC-INFORMATION field starts at byte 8
> > in sense buffer resulting in the following offsets for
> > the ATA PASS-THROUGH commands:
> > 
> > Offsets of these fields in the fixed sense format are as follows:
> > 
> > +-------------------+-------------------------+
> > |       Field       |  Offset in sense buffer |
> > +-------------------+-------------------------+
> > | FLAGS | LOG INDEX |  8                      |
> > | LBA (7:0)         |  9                      |
> > | LBA (15:8)        |  10                     |
> > | LBA (23:16)       |  11                     |
> > +-------------------+-------------------------+
> > 
> > Reported-by: Akshat Jain <akshatzen@google.com>
> > Fixes: 11093cb1ef56 ("libata-scsi: generate correct ATA pass-through sense")
> > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > ---
> >  drivers/ata/libata-scsi.c | 26 +++++++++++++-------------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index 4bfe47e7d266..8588512f5975 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -855,7 +855,6 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
> >  	struct scsi_cmnd *cmd = qc->scsicmd;
> >  	struct ata_taskfile *tf = &qc->result_tf;
> >  	unsigned char *sb = cmd->sense_buffer;
> > -	unsigned char *desc = sb + 8;
> >  	u8 sense_key, asc, ascq;
> >  
> >  	if (qc->flags & ATA_QCFLAG_SENSE_VALID) {
> > @@ -880,8 +879,9 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
> >  		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
> >  	}
> >  
> > -	if ((cmd->sense_buffer[0] & 0x7f) >= 0x72) {
> > +	if ((sb[0] & 0x7f) >= 0x72) {
> >  		u8 len;
> > +		unsigned char *desc;
> 
> Please move this declaration before the "u8 len" one.

Will do in v2. Could you please explain why this declaration order is preferred?

> Otherwise, this seems OK but needs a Cc: stable@vger.kernel.org tag added.

Ack, will add in v2.
> 
> >  
> >  		/* descriptor format */
> >  		len = sb[7];
> > @@ -919,21 +919,21 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
> >  		}
> >  	} else {
> >  		/* Fixed sense format */
> > -		desc[0] = tf->error;
> > -		desc[1] = tf->status;
> > -		desc[2] = tf->device;
> > -		desc[3] = tf->nsect;
> > -		desc[7] = 0;
> > +		sb[0] |= 0x80;
> > +		sb[3] = tf->error;
> > +		sb[4] = tf->status;
> > +		sb[5] = tf->device;
> > +		sb[6] = tf->nsect;
> >  		if (tf->flags & ATA_TFLAG_LBA48)  {
> > -			desc[8] |= 0x80;
> > +			sb[8] |= 0x80;
> >  			if (tf->hob_nsect)
> > -				desc[8] |= 0x40;
> > +				sb[8] |= 0x40;>  			if (tf->hob_lbal || tf->hob_lbam || tf->hob_lbah)
> > -				desc[8] |= 0x20;
> > +				sb[8] |= 0x20;
> >  		}
> > -		desc[9] = tf->lbal;
> > -		desc[10] = tf->lbam;
> > -		desc[11] = tf->lbah;
> > +		sb[9] = tf->lbal;
> > +		sb[10] = tf->lbam;
> > +		sb[11] = tf->lbah;
> >  	}
> >  }
> >  
> 
> -- 
> Damien Le Moal
> Western Digital Research
>

Thank you,
Igor 


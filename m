Return-Path: <linux-kernel+bounces-531717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D85A4440E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4B63AFE33
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ACF26B958;
	Tue, 25 Feb 2025 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="OdcqWojO"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE11268C48
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740496269; cv=none; b=NemNJ+kG2gHZWhAJTWUtWrLOyh/Xe5JII2RCefeIqwPbFiK2hEkwQ+btrhRAreA5AH8dyc/iYA186mfjFrqApht5mP2YVj4QtUtZv50nX6yDiRR6y+4Q47LQ9kxxnG3oVj/MIfqeI5b6dTBmsKj8t0YgsG3U1109iqhQGGlldpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740496269; c=relaxed/simple;
	bh=tkSmq7pnmmsOA5HbpEM7dnueRwC5y1v10Z0L0e+tnJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7EObpkZY1DbMIn7GIPzEeCsLd7EbDrIuAf99YUZRiY+ndfYtZC1MtObU+ef2v0ZwSQk9K+lr1zZYtMF2hjPbuOqaXBQ+9JBEjQHPfZQfULWQWc7tCGeQ7D8V52o2/web7P8pjSrQP6G4HrXxPiaDVi5DyRsiDn0ExvHqenrRV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=OdcqWojO; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6ddcff5a823so45789326d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1740496266; x=1741101066; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UuZd7P5DT0VbRPayAqAZRRBZvg2Yklr2Rd6Ruf/f2fY=;
        b=OdcqWojO+x/BoE8WpuLf8eMF5qLgHxwDg19zcAReilMWQ/5g5cEXsrseR66gABzkDX
         i2Mno5IiVE8Mb8xpIcS8vkp5Uaqc/Yh6a6gGsRZ9sZmtdWw0vQlAGTpUBDG5kcgFa57g
         CmK1H1EGB1K559gGCqBQIH+FsKPpU+0AMG+SgV1krjrVxxsGyFrMBgXYsxGrNWvD35QP
         xX/Nzef1P06NOoOuD4uxhdxOnrLKbsEQfRk1h+LF/Bhx/thQCcWuDAe5Zi9QhVHtV/pB
         bgSFx2M1pxpA6ZHGRJ3S9nOOWv1PJiftqF/WyQfUR8N+92DPV0UqTpY2tehkEftk+m+h
         bODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740496266; x=1741101066;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UuZd7P5DT0VbRPayAqAZRRBZvg2Yklr2Rd6Ruf/f2fY=;
        b=SJLe/t4Q7IrA934LM35bLGbfmMChJUsSyTEuZdABPubR1btu4RNaBs5NmotjFe/rXl
         t2fV8lBQJjlZzd2pFQU9iD4emmZmGv0VHo8hEgSmNA1H6SNzQswpQiPzkoPbgSoIFNWE
         hAYzSphOkO+R1qr0AZsaerULhVgyOAJ00Cza5sQlt3lHM8YTLwuwDR1XsxubT1V2cTFN
         ox8J420gqV/1qMikNOKSUfD8oh5jyUej6Yn1G+O142zPLKqIrx/w/ZVwbSrKfRjLE/W8
         EwP0sl4jolnB1BVJKaNMB9ECeIjNhQ0QnccDlZZGeabdbCnSbdPTZsg8TauVsBzdn61y
         QMUw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ9HOqxXSIloiW9EnvGPSGOkHSh3+ajEDQ4nzY/B+mQR3WPW5mteqEn09mPDRj0SdmmD8QEIFfN1GJE1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSeBgxhrcwV9K7jKV2oNHtbPi3/6klFhWFclllsqn44xGdjIp8
	AJinTpFOOkt0xLDMw0FDu/sx2b92xkF6nzpnPXOoUtAvB+QSs4WARDl/EiPBXA==
X-Gm-Gg: ASbGncs8wxOC17RYm6B320dhXkI2E9RaOoSu2kVnTS0qBsCLhpYhH5cBxlZ/2zND6P/
	jEOVPl5DStCvMKgwMrTVeelxLZf8d2/2S9LPV1DXFJlQbHr+MdZ2OjMuz2YPXOab6HMUGaE3OPr
	3lar4kAPODVrpCbcqcIhVg7w3oq56xOnpC0mKGN5vxqestFlF0UmPL+X4/HWU/XVtwHijXQiIHz
	T2HkgTNnIjw7wkjzswCmrprwdvnZ2VMZ9blYH89p4R/mcwt3MBaCXq9DuXxfbp6z8tiQ0voVDFf
	uowKS2EwG9VDNh8G7CC4ibiQSG8=
X-Google-Smtp-Source: AGHT+IG3zEgevegcgMopSAlehoPLE+jDUsXcWUX3ParBTGXTVTexOgk9CAmzQjvbJLn2aJ2pE8/Daw==
X-Received: by 2002:a05:6214:765:b0:6e6:683c:1e32 with SMTP id 6a1803df08f44-6e6ae7c9ee2mr254909256d6.8.1740496266092;
        Tue, 25 Feb 2025 07:11:06 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::2dc7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b0a04ccsm10187616d6.68.2025.02.25.07.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 07:11:05 -0800 (PST)
Date: Tue, 25 Feb 2025 10:11:02 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: j.ne@posteo.net
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH] usb: storage: jumpshot: Use const for constant arrays
Message-ID: <a4e81827-b506-491f-8087-204044705c42@rowland.harvard.edu>
References: <20250225-misc-const-v1-1-121ff3b86437@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250225-misc-const-v1-1-121ff3b86437@posteo.net>

On Tue, Feb 25, 2025 at 01:25:03PM +0100, J. Neuschäfer via B4 Relay wrote:
> From: "J. Neuschäfer" <j.ne@posteo.net>
> 
> These arrays are not modified. Make them const.

This does not explain _why_ you want to declare these arrays const.

> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

There should not be two Signed-off-by lines for the same person.  You 
should keep only the one with the email address you used for sending the 
patch.  And it should have your full name, just like signing a legal 
document.

> ---
> 
> This change was compile-tested with ARCH=powerpc
> ---
>  drivers/usb/storage/jumpshot.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/storage/jumpshot.c b/drivers/usb/storage/jumpshot.c
> index 39ca84d6859122903de4e64b13e697e8b7d4ab31..089c6f8ac85fbb683cca8b03a2ff06c0ca776167 100644
> --- a/drivers/usb/storage/jumpshot.c
> +++ b/drivers/usb/storage/jumpshot.c
> @@ -367,16 +367,16 @@ static int jumpshot_handle_mode_sense(struct us_data *us,
>  				      struct scsi_cmnd * srb, 
>  				      int sense_6)
>  {
> -	static unsigned char rw_err_page[12] = {
> +	static const unsigned char rw_err_page[12] = {
>  		0x1, 0xA, 0x21, 1, 0, 0, 0, 0, 1, 0, 0, 0
>  	};
> -	static unsigned char cache_page[12] = {
> +	static const unsigned char cache_page[12] = {
>  		0x8, 0xA, 0x1, 0, 0, 0, 0, 0, 0, 0, 0, 0
>  	};
> -	static unsigned char rbac_page[12] = {
> +	static const unsigned char rbac_page[12] = {
>  		0x1B, 0xA, 0, 0x81, 0, 0, 0, 0, 0, 0, 0, 0
>  	};
> -	static unsigned char timer_page[8] = {
> +	static const unsigned char timer_page[8] = {
>  		0x1C, 0x6, 0, 0, 0, 0
>  	};
>  	unsigned char pc, page_code;
> @@ -477,7 +477,7 @@ static int jumpshot_transport(struct scsi_cmnd *srb, struct us_data *us)
>  	int rc;
>  	unsigned long block, blocks;
>  	unsigned char *ptr = us->iobuf;
> -	static unsigned char inquiry_response[8] = {
> +	static const unsigned char inquiry_response[8] = {
>  		0x00, 0x80, 0x00, 0x01, 0x1F, 0x00, 0x00, 0x00
>  	};

There's nothing wrong with this.  However, several other source files in 
this directory also have static arrays that are never written to.  Why 
don't you change all of them?

If you do, it will be best to put the changes for each of the files in 
its own patch, and then submit them as a series of patches.

Alan Stern


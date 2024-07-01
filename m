Return-Path: <linux-kernel+bounces-236661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DC291E57F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9F02835E1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB0B16DC30;
	Mon,  1 Jul 2024 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y642MEww"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4341A16DC18
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719851929; cv=none; b=d91s3nPebDp7uvqOLR+xdzn7tLIsrj/ZCHgS5KN1Bod1n7gfX1/Jxg8L7q91BAMHkaEcKp39oPvocUvrvWXDgKijK5t3Sf4dLro+p+/9pMH5yoNJjD93ICcs2kBTyxPwTbNWieBelL+egj1GrBzof2gIFQ59ZItgocRdwBoBivE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719851929; c=relaxed/simple;
	bh=0b7GgSUI0eaO01MBB0nXBh/uhDFmkdDbzFFrkkaPLGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTXOaFto5Ru5DeFFksK/Jqysig6xPwUYSQE9jG0u3iwS3k3dcmRt7jVlRoNfnKUC6rFO3tqsRBFkPB2BefkUlkl0VL5anxfMozsjNbkNPEZ/7AlaMcw/igexDgezL5Gyza2clq0ZrT/HpRmksSpCmNmAGwEqAbDBXUP7idNHK/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y642MEww; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-707f9c3bd02so2006022b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 09:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719851926; x=1720456726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hNYjJKW2jt8iaEsXSmdf0KI6tUTkldXsy2itazLTZ+0=;
        b=y642MEww6iDrivxrs4wcxpJnjBHGw8CuSQqqOEzp7WhHLkzBJ6MRQH94x3FFOBZYO7
         /72FUlfsLCjk2ETrjytYwEDnbDTafgbl1zoIP4gDBFHH+v/aoiLuFCY8TbgaLy4NFJ+h
         emVPnhsBlKfI9V514uX0QvAuds2V0NXkJX/JhSE46cJGU2C/ZjSbVBhkMok3m/I2Ei6G
         zbaEI64POA2Rcd6WEJoM5/9Cc4nn2tdDpLKCVt6MxdxT6OhBR9Dji+iZqHpZ8iPuTZV4
         Bmgm+qw2eKESMPDADDmbZKi/xyUdYkkKZ+rZdDOFKrPKmsRRqDdStc0VdHccsdHUmx2m
         gjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719851926; x=1720456726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNYjJKW2jt8iaEsXSmdf0KI6tUTkldXsy2itazLTZ+0=;
        b=uYWhy8tgabLVly5L45qacdtjN+Sy6uqgRXGoDTMTagQcj/FFap6bhX8M5nTgo3v3ns
         2yrdubEBcj+iI8nBbhSGjYa2Va7yk7oemOPo71im4zuBDcQCcKGyBhkgZJWffYN52f32
         BPljjcKdWOI+V8hnvGovgsVRU8rH2yxhYMItMOV80zSxxipdvvPYE42w5UPr04l+y7EE
         vlVQXtZvLddVQtPVWkQH4iNtUuX6YEb8Nr7MFwypbErjVFumfJT8oDb1o69KfQhYpfQy
         qzUVKqqk6gEFvQ/5bmKfxaKjpEFADjMsUrrZ5UlD24tjT9OZ4dKQf/pizxFRzVpdmqw1
         GpXA==
X-Forwarded-Encrypted: i=1; AJvYcCXIuckHyPsLIw+CT/g17uWe3Vf1f+seVXVw+7wym/PaKh/GmirUjXBNk1/QXF5WxA4DTJVG+akIAfHyP3TdCAZHUstqzXNKoi2UIWf2
X-Gm-Message-State: AOJu0YyF0ULUK7+Yjiaye7oc3yhhR02EdoS+z/UfJPl/ck7aQxWODYQZ
	cArhk2ht6TiOYs1DE94jd67AtslmktRQ/fs/sqh+xdc15lD6+IW0UJYx004w2aM=
X-Google-Smtp-Source: AGHT+IGc+D4Kly/VppZGK/Z1ZC7dkWa/VVh5diZ2R4Kt/mwAbmpm/6oFFdZKNY8WdAVVVUZU4t+S3w==
X-Received: by 2002:a05:6a21:789f:b0:1be:c59a:8ed8 with SMTP id adf61e73a8af0-1bef60fa8a2mr5963059637.16.1719851926542;
        Mon, 01 Jul 2024 09:38:46 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:be24:7a34:86fc:1a51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70838a9a188sm6555725b3a.131.2024.07.01.09.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 09:38:46 -0700 (PDT)
Date: Mon, 1 Jul 2024 10:38:43 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Hari Nagalla <hnagalla@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	"Andrew F. Davis" <afd@ti.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Suman Anna <s-anna@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] remoteproc: k3-r5: Fix IPC-only mode detection
Message-ID: <ZoLbk3HjrPRfBNVg@p14s>
References: <20240621150058.319524-1-richard.genoud@bootlin.com>
 <20240621150058.319524-2-richard.genoud@bootlin.com>
 <Zn8UumUllbGS4/p9@p14s>
 <CANLsYkxFvci0o0ET4vOGTYp0P2xEdwU2q4V1SmNh=W83uj87rA@mail.gmail.com>
 <3064a3cb-9153-3bd1-4c55-79e8911f029f@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3064a3cb-9153-3bd1-4c55-79e8911f029f@ti.com>

On Mon, Jul 01, 2024 at 04:13:00AM -0500, Hari Nagalla wrote:
> On 6/28/24 14:58, Mathieu Poirier wrote:
> > > This could lead in an incorrect IPC-only mode detection if reset line is
> > > asserted (so reset_control_status() return > 0) and c_state != 0 and
> > > halted == 0.
> > > In this case, the old code would have detected an IPC-only mode instead
> > > of a mismatched mode.
> > > 
> > Your assessment seems to be correct.  That said I'd like to have an RB or a TB
> > from someone in the TI delegation - guys please have a look.
> Agree with Richard's assessment, and the proposed fix looks good.
> 
> Reviewed-by:
> Hari Nagalla <hnagalla@ti.com>

I have applied this patch, no need to send it again.

Thanks,
Mathieu


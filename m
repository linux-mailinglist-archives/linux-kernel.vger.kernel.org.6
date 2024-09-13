Return-Path: <linux-kernel+bounces-328210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E82CA97809E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E578B20D54
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4AB1DA61C;
	Fri, 13 Sep 2024 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="hUzXSX7r"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B32E1D58BC
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726232311; cv=none; b=ulzGJJpfXto9gFHLskfQrif+WKPKJMCCnnJWIZ7hnqKYl9UcH9ufdH2mK/7yVrlyPqiMJ8HMyZ/8uy0CBWOeUhhY1vQs7b5H43v+rmHDEGccTJ9iApVKVboiFXe+H5WuoLWGQGMbhT68g+7B6zi38+GtFKFeziBxFpp+Cidq+MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726232311; c=relaxed/simple;
	bh=nS7Duuf+HKwlIgucWCm3bY+03/DzdCTPPHs45h0jo4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zzh1dN18tLwDP9WOuIuHyIcR+pIyEe01ZIVIASdTAZ0A6tQQli8bdtEZavxVcPjFBuLTNsVcMfE/qPIufQp+NR1OSFD82SIX4hYTKZczoT8qM+5kb/228b210fbXr90QgyiUHxfLI8GzcCLCVkMDM5Yk/vblDfo8AGDEAt+9hqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=hUzXSX7r; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6c524b4f8b9so8123956d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 05:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1726232308; x=1726837108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h9HemonoSff4igOZu0xZNoZpNwJv/dD9FtFww6sphMc=;
        b=hUzXSX7rkp+Dx/VURG4loXUx56adYEYXTnLvYOK8PPU6FncrqI3Nk7LnDudIq4hSYX
         lpJ+7yqkFixOBuUrocYEbUhqVtN+ee8wWSUFoq9rGQxyVAAwn9JVlFDFiJGZY1VIhFd+
         hNSGX+80HZFWj0wXr4XD41/+66siP4yGCWGofsUzY+QDbhP1K9wNBFd3TTLVFQQcAtKo
         XgkgDSPQCkPA3+s2kdkv8/4YR17dgcCfyFO8xn8iL1v4/nggDxtw5MoS3U1x2JOK/QOt
         p+eoC1yP1d4kSragqIA/D0qssQEkENUsr0/kZ1pNVqJUihAfX2FRTDDXsRCtqo3LH4sg
         n7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726232308; x=1726837108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9HemonoSff4igOZu0xZNoZpNwJv/dD9FtFww6sphMc=;
        b=NFOvu+ZRRECl5ZIGBmTCZ/wGivwCBynceCYnttFwoaPWRZzWpRVEHQgCK3JItCXsAw
         NAboNW0+Z7GRkNaSHIPHH5cXgKzufJ51iZOCPBu28ix/m0lhaeukhefzv/7iS1lU7Y0o
         yfrqcBxDX1OTRqcFR/U1AFdrRON2hzpJTxmKhO/iSI3RsNX+lE3PCIAc1Ok/6nW7fSsS
         cqse3YnCWRbLL0WWEFk/rbA0fOGALMp6ozF0gNu+/+zRfvbmllB8YbasppdlBxPKZSPX
         5D60GEhDTDAb7/TlB+R4OsB9IiEYR92IpewUXjPCt+9giNJAjkGNyK8Na+DbDFryuT2x
         SxeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJTdeaD2zLh3ryEP4aEsLzZ0yFRwO7k8oNVkIs/ou0AEi3uSE9oObZYqDGZQU9yKeqthb58CBbHdduoFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvQhcNbay7w/86RskA+OT9fFjkI7aJVyqirtcxmH/tQZDKBH+L
	vnzsL0SbNUPDP7IOhUAC+Hv83r+aZRjro31w+bt06vnV9D5kt+/rPnwSUMqbmz0=
X-Google-Smtp-Source: AGHT+IGxnv1AR033O+1dC692fhlVGgQoY71B4fSyjToczXO7FownXlskiz61N3UHzua0YSRM9+CkCQ==
X-Received: by 2002:a05:6214:450b:b0:6c5:5a63:7ee5 with SMTP id 6a1803df08f44-6c57def3025mr47201026d6.9.1726232308381;
        Fri, 13 Sep 2024 05:58:28 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c534784f51sm66119896d6.133.2024.09.13.05.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 05:58:28 -0700 (PDT)
Date: Fri, 13 Sep 2024 08:57:42 -0400
From: Gregory Price <gourry@gourry.net>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	ardb@kernel.org, leitao@debian.org, usamaarif642@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH 3/6] libstub,tpm: provide indication of failure when
 getting event log
Message-ID: <ZuQ2xmXo0FPZpJa-@PC2K9PVX.TheFacebook.com>
References: <20240906202745.11159-1-gourry@gourry.net>
 <20240906202745.11159-4-gourry@gourry.net>
 <CAC_iWj+uieGoH1ouc6nwdZjirULgjYk+H6YFQQHSHcAySdaFog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWj+uieGoH1ouc6nwdZjirULgjYk+H6YFQQHSHcAySdaFog@mail.gmail.com>

On Fri, Sep 13, 2024 at 09:59:03AM +0300, Ilias Apalodimas wrote:
> Hi Gregory,
> 
> On Fri, 6 Sept 2024 at 23:28, Gregory Price <gourry@gourry.net> wrote:
> >
> > If get_event_log fails, at least provide an indicator of this failure
> > to assist debugging later failures that attempt to interact with it.
> >
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > ---
> >  drivers/firmware/efi/libstub/tpm.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
> > index df3182f2e63a..192914e04e0f 100644
> > --- a/drivers/firmware/efi/libstub/tpm.c
> > +++ b/drivers/firmware/efi/libstub/tpm.c
> > @@ -185,8 +185,10 @@ void efi_retrieve_eventlog(void)
> >                         get_efi_config_table(EFI_CC_FINAL_EVENTS_TABLE_GUID);
> >         }
> >
> > -       if (status != EFI_SUCCESS || !log_location)
> > +       if (status != EFI_SUCCESS || !log_location) {
> > +               efi_err("TPM unable to provide Event Log\n");
> 
> s/provide/retrieve/ and yes the print is going to be useful.  Do you
> know if the EventLog is mandatory. Reading at the spec GetEventlog
> only has 2 return values, which implies you can't return "Not
> supported", but it's not explicitly stated anywhere
> 

I believe it is mandatory from my reading of the spec - but the
"Final Event Log" was only added in 2.0.  We report an error when
2.0 is reported but the final event log is not supported, so i figure
we should probably report when the event log fails as well.

> Thanks
> /Ilias
> >                 return;
> > +       }
> >
> >         efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
> >                                    truncated, final_events_table);
> > --
> > 2.43.0
> >


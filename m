Return-Path: <linux-kernel+bounces-328212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D19CD9780A2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C9F2869E3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5E41DA62C;
	Fri, 13 Sep 2024 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="aMAIfCl6"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BE21DA624
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726232335; cv=none; b=CqkAhfF24fj5oVcAlfwLpiZjp9VDXOgJnKWvI31kp+ns3yOKwovLYAcdi7RUcvLMVPubAsirxVIcbH0L3TYvDJLwGRboffAyy8yW6hAVv5xfV4ccYco97cwLhzKihpo2WDbaIWBER846xmNDqgKFk/WWD6mDBqTubxDsrLb7k68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726232335; c=relaxed/simple;
	bh=N8j8O/+D2TBT3NwIq6SdjjxWvxg3xgC17emmyfAmgdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sytCp/e4eT+rOt2dNbnC9Y5bEJf/5ZwQGY+xi4Rtig/Ba5zAi2LButrTnP9xRHHDxX3yU2o+LXy/YDDukOZVypktQewnVd/ulzKKMo6Tk+2ix9MSgrGqhEeqrpS1Kn+4msQfQLALgQ3KTIfchL8oF1AAWKGBKmgXndksyLzsvd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=aMAIfCl6; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6c36ff6e981so15256806d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 05:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1726232333; x=1726837133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuuJoK+wzbggFN4GfM60Piaki2H1kRnBiRq5Uha2+h0=;
        b=aMAIfCl6x7xqpM70tYsPhpC/ZnLonlHaWGTywkX3AsYdhjuDz+q04VeLsN4wtxP51X
         F+M1VbSIPlZT7sHxQGk5oaTez1yKUW+bCaYeRd2D19pnoljF5Ga1v9R7tz3zxafcd7w7
         Upw335yvz8QagIhqcHcFYD7HQX2DvZt5QyteLwikDIlLgCyhQguRyM9zn6/+guRqhncP
         35KItDzOS8wkpW9cFjaQdj0pMbBdbwRtPgcGehd5byR016Ai8SiMc0eiPfGla+yaRIvl
         g2ccneluY96yzzrqsdhjhz6CKt5msuvkV6jTn9tLSES4rNfjQJpnDDu06yDhmkjyj0PX
         Eq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726232333; x=1726837133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuuJoK+wzbggFN4GfM60Piaki2H1kRnBiRq5Uha2+h0=;
        b=I67hAHsPj0Ocle4C5gzTTC6NcU26K5tOjk0ulyan5DazvyM9X9Xq/tC+whLf3I+D/L
         +6T0xGPYjd1ONmKRETRB89kXC4WRoysZoEdF34loFDFjj8uZUZUvYvA+qcf/Tqdu9SwN
         4yBTa20tos3DkiIM9Xb10ocQO87z3l7sSzCrE69tYXWbhbbqsshpmaBaKvf/H6G7WyYc
         hHzVPecLudksHnroMW1z0p71ZO8MnpOnfPyQMBLtrD1xowTdsXszqKDD14REPjUJ3L7P
         kU0d1GMFkdtmoa11xepSZzZZNxzqE5uFO0AOzOfUwB1rBFjV/21B5xRWcfJEtag4Crup
         PUnA==
X-Forwarded-Encrypted: i=1; AJvYcCVAUT5kWMwVZZYW0sRC0zFu4XFVIBcxpUbEoMiZ7wV6TXGBTk+/C10NMf3v6GxSzGz84aWKrugEywik68c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy794empj3rYkNNU+jrGzwzgk5p2YTEucqsbQrFQB4J35zZUbY6
	YRwKF+kBsyFaCJmtStxQCXnO98yi+4MhXh8YinSUREAfxGccnu7Oc5hXFgHpro7+NzpXGtzSja1
	v
X-Google-Smtp-Source: AGHT+IGtBK3Poe8ntK0MT1qzEFRZPAk+0jw48MAb2TIUhy3u3HSJSA+/gbLo8i2TijEYaCWQCpUlCQ==
X-Received: by 2002:a05:6214:3993:b0:6c3:6556:70a8 with SMTP id 6a1803df08f44-6c573555ffemr107759106d6.6.1726232332892;
        Fri, 13 Sep 2024 05:58:52 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53478611bsm66148926d6.137.2024.09.13.05.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 05:58:52 -0700 (PDT)
Date: Fri, 13 Sep 2024 08:58:07 -0400
From: Gregory Price <gourry@gourry.net>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	ardb@kernel.org, leitao@debian.org, usamaarif642@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH 2/6] tpm: do not ignore memblock_reserve return value
Message-ID: <ZuQ238sRbOYaEuvD@PC2K9PVX.TheFacebook.com>
References: <20240906202745.11159-1-gourry@gourry.net>
 <20240906202745.11159-3-gourry@gourry.net>
 <CAC_iWjK6EXf1g-CwBALTFmhhnRJaHcrdCS787aDDksdhSJxJTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWjK6EXf1g-CwBALTFmhhnRJaHcrdCS787aDDksdhSJxJTA@mail.gmail.com>

On Fri, Sep 13, 2024 at 10:02:32AM +0300, Ilias Apalodimas wrote:
> Hi Gregory,
> 
> On Fri, 6 Sept 2024 at 23:28, Gregory Price <gourry@gourry.net> wrote:
> >
> > tpm code currently ignores a relevant failure case silently.
> > Add an error to make this failure non-silent.
> >
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > ---
> >  drivers/firmware/efi/tpm.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> > index 9c3613e6af15..6e03eed0dc6f 100644
> > --- a/drivers/firmware/efi/tpm.c
> > +++ b/drivers/firmware/efi/tpm.c
> > @@ -61,7 +61,11 @@ int __init efi_tpm_eventlog_init(void)
> >         }
> >
> >         tbl_size = sizeof(*log_tbl) + log_tbl->size;
> > -       memblock_reserve(efi.tpm_log, tbl_size);
> > +       if (memblock_reserve(efi.tpm_log, tbl_size)) {
> > +               pr_err("TPM Event Log memblock reserve fails (0x%lx, 0x%x)\n",
> > +                      efi.tpm_log, tbl_size);
> > +               goto out;
> > +       }
> 
> ret is going to be 0 here. I haven't followed the rest of the code and
> where this function is used, but you probably need to return -ENOMEM
> 

good catch, will send v2

> Thanks
> /Ilias
> >
> >         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
> >                 pr_info("TPM Final Events table not present\n");
> > --
> > 2.43.0
> >


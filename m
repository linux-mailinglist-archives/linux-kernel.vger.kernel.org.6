Return-Path: <linux-kernel+bounces-328277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1342978159
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41A27B2357B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196C61DB534;
	Fri, 13 Sep 2024 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r38jofUn"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B76758AC4
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726234798; cv=none; b=loMm9Iy3xcK/5qr9XLuPk3wEjDLsfWZll9TLcFUwJFmZLRWW69BYDjofdxqkN8dUDt1THNkZHjWvpKrLw0PeI73w2uaagYdoWv62HjJDNEBSnqxPSQUt3Hv9i+YbqzR42lW28ulhwNH4tipYhQq8R1xLsxlYDyplVrXwNf9YiN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726234798; c=relaxed/simple;
	bh=Une7f2k/KmpgDey8zFYfeiGwdtTaCeYlY49pG0SshaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4whnenuO3rn5orYRlAU3v5an1/xJAnjCDfN6HMnmfgTepWW7JBoISeJlR22xdauW+z6W0cygnVhX54RLE1toUCVPr4LUSriENiaVH5AaD5c+x6NRA362/M/9srH1Hys3cOoE5HQMmSyf4lTQT2kl5aPJ33CTm+NQTdZab2ae3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r38jofUn; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so1412121a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 06:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726234796; x=1726839596; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=15unwVZm+OPwbYI5yFxIUYjpkqKaKnTXKaJUsxY7urY=;
        b=r38jofUnrThI6s7mtqUHcPcl+fsVc/2iJhwdKIVfTGX0LpRwnQaGjvBhxAiXjopxqU
         b7J+EpIacYXOdgN4yTbGkQrc2tirNE+Dd35sRXy9a0j4mlDyWlOHfaOctyDjffyTpJr/
         CE0Lwkx4j+SSmgko5eFdmDLmPNkBRexU12CPEcc6c80GtPHdnUP0vjfSlG8ME+LKgcKM
         qeu7Ztta3nNMYlg2BFgK+RuOdbiirUK8mnXYI70JYQ0g2xNlHwLiKO/nHkZzF5Vv3Iiq
         qm3pMIUdN6zbmPX8itjLrVcRW3bepyyHCIR+2nH/f7S4T1NbO7muLXS2OCntitiSy7bb
         MoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726234796; x=1726839596;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15unwVZm+OPwbYI5yFxIUYjpkqKaKnTXKaJUsxY7urY=;
        b=oOt1Gvqv+O4OGnJjae80ErK4kClJsjvT33dOm1G86bvQH9B8K4MXQD9H4mTK+v/51s
         KpF0VGjxz0NyT7xWZh3yvz67b6hPSCewZxTkLA9PV3pYpatHTyDCSRUYfdX7me00qhrG
         VsLTRE3cAyihJhFoEOVniP7iUEGVFHuHSPh9d5qGA854b0UshI4tE1cQQIZJ9z7z2HM/
         dCW3V1bkjMSmS3JaAK1zx5+66Ek8oZnzCqgk1wUcJMxelHqSfjlm6gJ+ee/PGw4rrxL4
         eMJXreuBoJaQojv4fuTPaYi5RpSnNbAms1j+brV/MBXLtMSaGrKXWz1nphbNq+aL22Sb
         dXkw==
X-Forwarded-Encrypted: i=1; AJvYcCWiBPTekrTs5QA6DglhPXepOKDU3SzrT9uq0yYl4WBmjX9AHei/uy4j2bnkFGEAXj/1ToeM9yPQazeqMwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj1MdIH5dX2FR389toZ00MOeRh/R7m6xxl+VDT8CPozY1qHsWj
	ODgTAvhT+Attv44bmqT2iUN9tsv52OvF7A4uMC+ClPAj8/dab/btrZnSOyh/cvu+4+c7+pTOPV2
	xRRuMBfd4aIdBUaIJVtBh8nf66ww0t2l+PYzxBw==
X-Google-Smtp-Source: AGHT+IF59t17Y/5ech59IOa2/IFQRJFPElHtqzuEuiaN7v3gSFbj/dR4AVugJXpvaSP7ix1aYeDgRQlJmu3t8gEO0M8=
X-Received: by 2002:a17:90a:6809:b0:2d3:d728:6ebb with SMTP id
 98e67ed59e1d1-2db9ffa74b6mr7489220a91.5.1726234796028; Fri, 13 Sep 2024
 06:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906202745.11159-1-gourry@gourry.net> <20240906202745.11159-5-gourry@gourry.net>
 <CAC_iWjJizjQWucDbrqKGdZTcj7FFxiPN97=p1zwfnPE=sAC6RQ@mail.gmail.com> <ZuQ2c7XOptYMJEtD@PC2K9PVX.TheFacebook.com>
In-Reply-To: <ZuQ2c7XOptYMJEtD@PC2K9PVX.TheFacebook.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Sep 2024 16:39:19 +0300
Message-ID: <CAC_iWjKoptBngCj-W6axZ9bmJmhT11JMctn1m4maVvO4mzcENg@mail.gmail.com>
Subject: Re: [PATCH 4/6] tpm: sanity check the log version before using it
To: Gregory Price <gourry@gourry.net>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, leitao@debian.org, 
	usamaarif642@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 15:57, Gregory Price <gourry@gourry.net> wrote:
>
> On Fri, Sep 13, 2024 at 09:40:30AM +0300, Ilias Apalodimas wrote:
> > Hi Gregory,
> >
> > On Fri, 6 Sept 2024 at 23:28, Gregory Price <gourry@gourry.net> wrote:
> > >
> > > If the log version is not sane (0 or >2), don't attempt to use
> > > the rest of the log values for anything to avoid potential corruption.
> > >
> > > Signed-off-by: Gregory Price <gourry@gourry.net>
> > > ---
> > >  drivers/firmware/efi/tpm.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> > > index 6e03eed0dc6f..9a080887a3e0 100644
> > > --- a/drivers/firmware/efi/tpm.c
> > > +++ b/drivers/firmware/efi/tpm.c
> > > @@ -60,6 +60,15 @@ int __init efi_tpm_eventlog_init(void)
> > >                 return -ENOMEM;
> > >         }
> > >
> > > +       if (!log_tbl->version ||
> > > +           log_tbl->version > EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
> > > +               pr_err(FW_BUG "TPM Events table version invalid (%x)\n",
> > > +                      log_tbl->version);
> > > +               early_memunmap(log_tbl, sizeof(*log_tbl));
> > > +               efi.tpm_log = EFI_INVALID_TABLE_ADDR;
> > > +               return -EINVAL;
> >
> > I don't think we need this check at all. Did you actually see this happening?
> > efi_retrieve_eventlog() that runs during the efistub tries to retrieve
> > the log and the EFI protocol itself explicitly says that the firmware
> > *must* return EFI_INVALID_PARAMETER if the event log is not in 1.2 or
> > 2.0 format. If the firmware does something wrong, we should report the
> > FW BUG in that function, instead of installing the config tables Linux
> > uses internally to handover the log and catching it late.
> >
> > Thanks
> > /Ilias
> >
>
> We saw this happen and discovered it was a disagreement between EFI/OS/kexec
> causing the table to be overwritten during kexec.  We've since found a fix for
> that.  So the result was that it appeared the firmware was doing something
> wrong. The sanity check at least allowed us to boot without immediately
> crashing - because the tables don't get reinstalled, they get re-used
> (at least that's by best understanding of the whole interaction).
>
> If the check seems superfluous, i can drop it.

Ok, that explains why it wasn't caught earlier at least. I would
prefer dropping it tbh, but I am going to defer to Ard for that.

If we agree that this needs to go in btw, I think you should refactor
it a bit. That function already defines an out: label, which unmaps
memory. So you can rewrite the above as

If(....) {
    ret = -EINVAL;
    efi.tpm_log = EFI_INVALID_TABLE_ADDR;
   goto out;
}

Cheers
/Ilias

>
> >
> >
> > > +       }
> > > +
> > >         tbl_size = sizeof(*log_tbl) + log_tbl->size;
> > >         if (memblock_reserve(efi.tpm_log, tbl_size)) {
> > >                 pr_err("TPM Event Log memblock reserve fails (0x%lx, 0x%x)\n",
> > > --
> > > 2.43.0
> > >


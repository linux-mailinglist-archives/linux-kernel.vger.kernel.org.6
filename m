Return-Path: <linux-kernel+bounces-280403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B767094CA0B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF221F25A6E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 06:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5D616C873;
	Fri,  9 Aug 2024 06:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mbqnojnv"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8236B184
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 06:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723183554; cv=none; b=gIJNyewuJf/H8pJbI16vwZKltkWkeJvIF2P8VhzBs6H95vke1ZO3H0HJGjK2AfZs7C07zfdX0eBYg1zbtmkgsK49qkoNu+cflU4GCUAbGhnJr3MdHN6sx503pSm8CqliCtIugnvj7HbSM1iYMp+61zTDMxcTjhmMRFyAjUMmsZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723183554; c=relaxed/simple;
	bh=jXayqboATD8u/COIAY3ZXKnv0y67nXF6jQI0JTNNsn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/h5BUi1vA8+l76ZAB6oYlFqNWeOt9PRL25foSMPoE1iWJuqDEtqi9S4lb0gK0F18WL8BcGAZ9ShXC1dhmy7cz/MNs89kNObJtv7Ol2dmdEpLL27wIbbEDNqhB5v/XzGT2q5PuA4ziCeqCHJFJp9n5INHcgbqLIGkLRZUtabZFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=mbqnojnv; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-25dfb580d1fso823135fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 23:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723183551; x=1723788351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fx3FfVfdiP9K1YQ4WlF6JZNFpHKhTks7LWEP0de0u1U=;
        b=mbqnojnvgoqpta9+rgAZ/DyJQE2SmXCD1RGrVaoZ1kQJqPIFKpLKiMTDKZfnUTAKNK
         5Tj8Ei45HWhH3hAkvo+xiUah2Qq4gD7WgeHXdyCfc4b2AuJm4FML9Y71r/uZn7Ug3L9/
         KVS7RJUxEEsGTRExgAYmTds8e5QgUevvavZMTd+TdQH2bDCvJjwi5soXXgOwi8PR5bNS
         c/gS5tLLnDda+TcLLNPpO8ZMcueE+9rcS1VfKEsOrA9ABB4LnEMUiruDoT7Wlvs9Jice
         sbP6moW5bSYmkfQLe91zLJfC9RKyDj321JToYdrf4kqKSCelxYnSJ2LeFyvnSDFk7O3B
         PDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723183551; x=1723788351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fx3FfVfdiP9K1YQ4WlF6JZNFpHKhTks7LWEP0de0u1U=;
        b=R0pbAKh2zBzBTocTTNH9Bd09IDP6wLAc0M17CiYS0hewQTxDNCr6NK8qswpXepxmjv
         JKvndueLA4wBPytNdhtuzNEsNy+Jzmfl0eszkstEqn0zPckDUJuVMc9cSzzCrnbERBew
         wNnwyhP0mLP//rC4QN9Qha9UnF6OysX5Y4I96UONev3nOmaaCZtKBhl6bZnKpywFITNO
         x9TTiEp727JPlaE1tz+EoxBhqIrZuqnS6YeDs3AQFqPwMLQ12EfSdU12L5X88UdeczwM
         b6UVFDv6ZoFDgGhC0a6DC1TX2dm7H0cogFMW0FEgAYy1pajJSTdhW7HOhAqMqM6KSaqs
         lCMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV68TVLnsumAhliTnNthyUNT7HI2fmIdPnzly26wlsGoChtSPeNOUJgYEQTweWXnqXKj0OmtjbR7UD+9wbaDAzIR3JiYdBHfukz92XG
X-Gm-Message-State: AOJu0Yw0K1fMnFqS6NdO6tMMtVheetWIK9rpE0d+GJhcuTFNhXB3thu6
	AbZ2QE0uhO0pUT1K7kC/Pet31zAJaALUGoyRzQor7WaQRqfq3+v4hCbEbFSODoUX97Og9udTzde
	9dQx2Tc24c8OmhABDtlL28kWX/DfB39q4CKdvQA==
X-Google-Smtp-Source: AGHT+IHaUR/BZOF1mE4d26qoLAX0jJ1FBSRJZVz2DTf4hfAj2tLEfjd+PkHRvYZNcY/6s0Eg4S0/m0G8spS1t23ZWKQ=
X-Received: by 2002:a05:6871:691:b0:261:1c5e:29d3 with SMTP id
 586e51a60fabf-26c62c5637emr647903fac.12.1723183551453; Thu, 08 Aug 2024
 23:05:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808081412.24553-1-yongxuan.wang@sifive.com>
 <CAAhSdy3VKMngwHxOg5+z6pK3QgZnLv=3+hpZBeUm87L_e62aUQ@mail.gmail.com> <87ikwbytfz.ffs@tglx>
In-Reply-To: <87ikwbytfz.ffs@tglx>
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Fri, 9 Aug 2024 14:05:39 +0800
Message-ID: <CAMWQL2h94Sk5N6BkTe0aNcPd7QR2Q2s3-632K5aRdCh5hPYSew@mail.gmail.com>
Subject: Re: [PATCH 1/1] riscv-aplic: manually set pending for the
 pre-existing interrupts
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, greentime.hu@sifive.com, 
	vincent.chen@sifive.com, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anup and Thomas,

On Thu, Aug 8, 2024 at 10:34=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Thu, Aug 08 2024 at 18:56, Anup Patel wrote:
> > More appropriate patch subject should be:
> >
> > irqchip: riscv-aplic: retrigger interrupt in MSI mode upon write to
> > sourcecfg register
>
> And the correct one would be:
>
>     irqchip/riscv-aplic: Retrigger MSI interrupt on source configuration
>
> 1) The prefix is correct
>
> 2) Sentence starts with a uppercase letter
>
> 3) It uses understandable words. sourcecfg is a implementation detail
>    which is irrelevant for the high level overview of a changelog
>    subject, which is visible in the short log.
>
> > On Thu, Aug 8, 2024 at 1:44=E2=80=AFPM Yong-Xuan Wang <yongxuan.wang@si=
five.com> wrote:
> >>
> >> The section 4.5.2 of the RISC-V AIA specification says that any write
> >> to a sourcecfg register of an APLIC might (or might not) cause the
> >> corresponding interrupt-pending bit to be set to one if the rectified
> >> input value is high (=3D 1) under the new source mode.
> >
> > Add quotes around the text from RISC-V AIA specification.
> >
> >>
> >> If an interrupt is asserted before the driver configs its interrupt
> >> type to APLIC, it's pending bit will not be set except a relevant
> >> write to a setip or setipnum register. When we write the interrupt
> >> type to sourcecfg register, if the APLIC device doesn't check and
> >> update the pending bit, the interrupt might never becomes pending.
> >
> > The second sentence above can be re-written as follows:
> >
> > When interrupt type is changed in sourcecfg register, the APLIC
>
> the interrupt type ... in the source....
>
> > device might not set the corresponding pending bit, the interrupt
>
> bit , so the ...
>
> > might never become pending.
>
> >
> > Define APLIC MSI mode specific irq_set_type() like below:
> >
> > int aplic_msi_irq_set_type(struct irq_data *d, unsigned int type)
>
> static :)
>
> > {
> >        int rc;
> >
> >        rc =3D aplic_irq_set_type(d, type);
>
>          int rc =3D aplic...
>
> >        if (rc)
> >               return rc;
> >
> >        /*
> >         * Updating sourcecfg register for level-triggered interrupts
> >         * requires interrupt retriggering when APLIC in MSI mode.
>
> APLIC is in ....
>
> >         */
> >        aplic_msi_irq_retrigger_level(d);
>
> Thanks,
>
>         tglx

Thanks a lot! I will fix them in the next version.

Regards,
Yong-Xuan


Return-Path: <linux-kernel+bounces-445387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DB59F155E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D237C1696E3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086D61E8835;
	Fri, 13 Dec 2024 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ksmk/S+C"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840CB1EB9F6
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 19:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734116431; cv=none; b=j3JLyWMz0/jfHX/0rXZBFnFVptGtPUfkQ5rJwfdO5aMg+eayqtEddfl7rx2OVxh4FGcszqhC2dEQjnuCRUkIxr0le5NzA4EXhwCUa05lfzNM4rqvKni9XyjCAU74kBUAvUW8WY0uUbYlBFrpj2mabn4SSC/qbhiL/9FGsKD7jSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734116431; c=relaxed/simple;
	bh=rEhuKTJFG7kaQcZsmnfySlNHTz78q/G4iPb6LTLb2Jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X8a8unXecczm5z3Bhca4VMG08nqEQUtezS1cXYBCL+5gLPmB381FLK6q/87kNcD8ufOtA2cW5QTTcCwfMytptoav0yDBy5RQ7HjkikGZmQ5hPDF8s1vwIBxOjSFJVRkzgLeBA8we4oKGlusAkoKz1iEmMQfEBHDRyHZDRO/pxxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ksmk/S+C; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4afe2f6cecdso1500626137.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734116424; x=1734721224; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2kiUVYADXZMs0PrxCadhmBZVpv0bclMEtNvJ3GEENZM=;
        b=Ksmk/S+CntmD7AcD8CEtsUUgdUun2uCdgdqxNaEUYlkL93motSddz1dP5+IOGkPnXe
         32ClDSsUdNFWxerSgke5yOTas3IjhP6sc4t8+wf/oSiQeUlqn02BWVRyCCECsC91fNw0
         75oXiN6EFEKc70QJ2WYyAq2jWxmjpIqJJzo5rhMrBnEe3Caf2B6tO+xCbvQLBwpEC5ti
         KMck4MAWA/KDstV9NumnFXbu/4UY4Q+RbXjjs2ZrdhpkxIqkGujy0jiiz3txrgrRdLYk
         +pMAQRMIsYmKjMvjaCjY2f98feOnGAJXOmVsFyXqus8NQyW9pdrBfzb6smuzG94s9jS6
         WybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734116424; x=1734721224;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2kiUVYADXZMs0PrxCadhmBZVpv0bclMEtNvJ3GEENZM=;
        b=trUa44F+GwpbEVaslxRu9xDgxIfeizD0/7gnsvnto96oKye8w5mkn8ubGR7p7ma3Tt
         i9oVenIWmtHVhFHfbwEcB7MzVbrWRHBNFlwXDLjjnMyFvloMMEJUCpBnWcc89oyBE/68
         vvnfYWaq39LFb5UGtFyYpTpepgh30sw9FCU8MFzyN5GLRcaZS6b+tqoFbIwNiJb+YBNn
         2He9PgTSATzLllTdA7KcAmg1we2iLZGLOJiGTWaDOM/ThO19jr2FThvNDuSokjkI6Gdj
         CtvnKW1/juDieOSxligA5gQyEZewGAcnJkuJn3oDqcw4KqfqA7V5k5Hze/13O1RyzvZ/
         YGkg==
X-Gm-Message-State: AOJu0YzISGZ32zMoAsk8pMQT+tgQ8PSjVCS8YaTDbIKYeaL1B3Gqz7bb
	KtttNyG1R+0TOPMi9nfQfiXr4c/FnGgcPNd7XqicSDss45CXA64WJksi9BCx/a/Pz4ich/+dGdo
	pahC+W4HQh/n3UIt7ttdwxYpEEuJuNtRwkWI2fjrI27RMsbUN
X-Gm-Gg: ASbGncvQBkMtICTum8FNvBK3Z006fgBZF/XJa0IqiMbX9Jweira7hodcXGYVEk2RgnS
	xd/lI87DSDstJedPbsXuLwqX7YfuQ96GSi4FExfETxci3AK+d80MhvevbLM/0GAe2GacQmQ==
X-Google-Smtp-Source: AGHT+IEjufRIjhWmlJKoN0rbl+lTaPFa6fQvlWeLn9wfErBSSg2fkq4XMzoP/XHT94xjChXMjOmIRyCkVv3rseZBIIM=
X-Received: by 2002:a17:90b:1810:b0:2ef:ad48:7175 with SMTP id
 98e67ed59e1d1-2f13ac98c80mr11963669a91.15.1734116034076; Fri, 13 Dec 2024
 10:53:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213144919.110642-1-mike.leach@linaro.org>
 <20241213144919.110642-2-mike.leach@linaro.org> <0c13fbf6-3023-4f9e-9571-a9e8ca6e3402@arm.com>
In-Reply-To: <0c13fbf6-3023-4f9e-9571-a9e8ca6e3402@arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Fri, 13 Dec 2024 18:53:42 +0000
Message-ID: <CAJ9a7VjC2AioY8S6qrgDkStn4pLnUm+2QUKTppYm1XXuOVRGbQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] coresight: Update timeout functions to allow
 return of test register value
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	coresight@lists.linaro.org, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Suzuki,

On Fri, 13 Dec 2024 at 16:38, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi Mike
>
> On 13/12/2024 14:49, Mike Leach wrote:
> > Current coresight_timeout function spins on a bit on a test register,
> > till bit value achieved or timeout hit.
> >
> > Add another function to return the full value of the register being
> > tested.
> >
>
> The patch looks good to me. However, this change doesn't bring much
> value, other than avoiding a read at the caller side. I guess it is
> simpler to leave things as is and let the caller read the register value
> while logging rather than providing another variant.
>

The reason for returning the register value is that you get the exact
read value used at the time of the test - not potentially a different
value read later.


> I am inclined to keep the interface simpler.
>
>
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > ---
> >   drivers/hwtracing/coresight/coresight-core.c | 50 +++++++++++++++-----
> >   include/linux/coresight.h                    |  2 +
> >   2 files changed, 41 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> > index ea38ecf26fcb..feb1a1db355f 100644
> > --- a/drivers/hwtracing/coresight/coresight-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-core.c
> > @@ -1017,32 +1017,37 @@ static void coresight_remove_conns(struct coresight_device *csdev)
> >   }
> >
> >   /**
> > - * coresight_timeout - loop until a bit has changed to a specific register
> > - *                   state.
> > + * coresight_timeout_retval - loop until a bit has changed to a specific register
> > + *                         state. Return final register value
> >    * @csa: coresight device access for the device
> >    * @offset: Offset of the register from the base of the device.
> >    * @position: the position of the bit of interest.
> >    * @value: the value the bit should have.
> > + * @rval:  the last read value of the register being tested.
> >    *
> >    * Return: 0 as soon as the bit has taken the desired state or -EAGAIN if
> >    * TIMEOUT_US has elapsed, which ever happens first.
> >    */
> > -int coresight_timeout(struct csdev_access *csa, u32 offset,
> > -                   int position, int value)
> > +int coresight_timeout_retval(struct csdev_access *csa, u32 offset,
> > +                          int position, int value, u32 *rval)
> >   {
> > -     int i;
> > -     u32 val;
> > +     int i, rc = -EAGAIN;
> > +     u32 val = 0;
> >
> >       for (i = TIMEOUT_US; i > 0; i--) {
> >               val = csdev_access_read32(csa, offset);
> >               /* waiting on the bit to go from 0 to 1 */
> >               if (value) {
> > -                     if (val & BIT(position))
> > -                             return 0;
> > +                     if (val & BIT(position)) {
> > +                             rc = 0;
> > +                             goto return_rval;
> > +                     }
> >               /* waiting on the bit to go from 1 to 0 */
> >               } else {
> > -                     if (!(val & BIT(position)))
> > -                             return 0;
> > +                     if (!(val & BIT(position))) {
> > +                             rc = 0;
> > +                             goto return_rval;
> > +                     }
> >               }
> >
> >               /*
> > @@ -1054,7 +1059,30 @@ int coresight_timeout(struct csdev_access *csa, u32 offset,
> >                       udelay(1);
> >       }
> >
> > -     return -EAGAIN;
> > +return_rval:
> > +     *rval = val;
>
> super minor nit: we could be flexible in accepting a "NULL" rval and
> thus keep the normal variants pass the NULL straight in. i.e,
>
>         if (rval)
>                 *rval = val;
>

Sure.

Mike
> > +
> > +     return rc;
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_timeout_retval);
> > +
> > +/**
> > + * coresight_timeout - loop until a bit has changed to a specific register
> > + *                  state
> > + * @csa: coresight device access for the device
> > + * @offset: Offset of the register from the base of the device.
> > + * @position: the position of the bit of interest.
> > + * @value: the value the bit should have.
> > + *
> > + * Return: 0 as soon as the bit has taken the desired state or -EAGAIN if
> > + * TIMEOUT_US has elapsed, which ever happens first.
> > + */
> > +int coresight_timeout(struct csdev_access *csa, u32 offset,
> > +                   int position, int value)
> > +{
> > +     u32 rval = 0;
> > +
> > +     return coresight_timeout_retval(csa, offset, position, value, &rval);
>
>         return core_timeout_retval(csa, offset, position, value, NULL);
>
> Suzuki
>
> >   }
> >   EXPORT_SYMBOL_GPL(coresight_timeout);
> >
> > diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> > index 055ce5cd5c44..29cb71e82b0b 100644
> > --- a/include/linux/coresight.h
> > +++ b/include/linux/coresight.h
> > @@ -639,6 +639,8 @@ extern int coresight_enable_sysfs(struct coresight_device *csdev);
> >   extern void coresight_disable_sysfs(struct coresight_device *csdev);
> >   extern int coresight_timeout(struct csdev_access *csa, u32 offset,
> >                            int position, int value);
> > +extern int coresight_timeout_retval(struct csdev_access *csa, u32 offset,
> > +                                 int position, int value, u32 *rval);
> >
> >   extern int coresight_claim_device(struct coresight_device *csdev);
> >   extern int coresight_claim_device_unlocked(struct coresight_device *csdev);
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK


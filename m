Return-Path: <linux-kernel+bounces-284651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576AF950390
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157572826BB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34241990A3;
	Tue, 13 Aug 2024 11:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q75QLfeg"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DE54C8C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 11:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723548392; cv=none; b=bD3pI0476l1ImQSV/gz6qUpPEonMHiVW3ooUOCEHC7UTmFHd1HK/PaXPS9NWKibmzNVmq8QbLmpJ/Oagwiwoh4vydvuxyKVYg/FO5ijXxfCC7S57pLIwg5vELadtWWm9cKNN9kyALx92H+pAglqss069pwRR3iOozgDPKxuUaaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723548392; c=relaxed/simple;
	bh=FwpQPZaZownGys16tIIRTbTH5Pl+L3AghxOMJwhap/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUJgECCJSD2Y0aENorjdH9/wgjD3tMF1WZ2U7FepehKtjL1vaqoz6fqAG4+fU7ggJk95CyGJm4YTKh6EQOwfyqtil1YKqQDY7SKjqvyOSvKxpvYaLnTHfhNJTBbjUUQJu2mH2X1ZtL+tN/90WveefKQFRNkIB9b+bTnGiKKz7gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q75QLfeg; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3db1270da60so4131126b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 04:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723548390; x=1724153190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZ42mAm0PGh+S/W22e7yYSDhvCDheJds0Y8DV5bgOPs=;
        b=Q75QLfegpDNfJsyNOWzdjpfcscVQ26Gq7NDttuBDkgCOB93ZFuMDQu1nM5F6MKVeb5
         p4NxmXjUs88r7jTdtPJGVslGe/vWdZrsnZ00Jh1hZscX2TStS0dCQJ6Cis5Twa2v4BX3
         ur/sCcW5HItptmitilPCiQ04A3dKazPXqxBtvzmlHunyVPfHPRVkB19gxC+YfRBfk9VH
         drz2HRIpOFDmMDCPH73Mc6+mPQ0dcGzRIAD4hnrzHw7RZy4SjyYtnOzV4GKYmJsFFIKk
         TKtyf2T6ZZHxP3quVBTFu1Q2aT7aQZ6hq/ul0CDELvLATtXsYeSU7H+9IyoqcjAmw9zP
         NpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723548390; x=1724153190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZ42mAm0PGh+S/W22e7yYSDhvCDheJds0Y8DV5bgOPs=;
        b=BV9zK/HnIcRc5WHEDxf+R4a6owfl9pYP2077UjD3LBBJ24uqEqZCrAmbuGIRDGmRIz
         5NkUNIEb+tTtD12P/cCXX3BqZ3GwEHusF9yPgODvK8dMpjuY0sX07wTuPB5Ip5Dh04x+
         XHtT1hew+7th4542lRHa9c7zrn/V/HrhciFEt8GfWU/mL462g7aPzRstCPjgVoV0+iq2
         3oN4Pv1DVHttkk2603WneIPBv4sPMkBVIPOH4JUcxhZjaXbKGdPUS3+djLKJ/7lv6Xb0
         NCS4zxw9lsxdpL2VgesF8AThsI22jaSralzpiSpcdLF+AvFS6QOm9f6U9FgVaZQsSkdF
         1CDg==
X-Gm-Message-State: AOJu0YwLbXvs0kdoXWOs98oyXwGE3bqexfSpGXdY56OCbLag9TkAs26o
	EnjuFjsrGPKc1J03kHgs110sTq0d7LYs0/kz9lGR9jccM18EZSUdffTAbLZWIclyXyew7Pq6USr
	xCzdNA/cxQDW4xNw1sWHWhULkGOOsNkk0MHh/cA==
X-Google-Smtp-Source: AGHT+IG8gqm83e9g/rJZ3FO2MQeP4LHgHhY5VJivHLmApt8VoHwKszZd7wDHqUFg9IwoiA+PDtzW6UWv56TdB0upWYk=
X-Received: by 2002:a05:6870:8a23:b0:25e:1edb:5bcf with SMTP id
 586e51a60fabf-26fcb641ef2mr3532611fac.6.1723548389774; Tue, 13 Aug 2024
 04:26:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812133127.865879-1-jens.wiklander@linaro.org>
 <20240812133127.865879-2-jens.wiklander@linaro.org> <2024081346-dutiful-stalemate-0e07@gregkh>
In-Reply-To: <2024081346-dutiful-stalemate-0e07@gregkh>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 13 Aug 2024 13:26:18 +0200
Message-ID: <CAHUa44HYQVhT0=E9py2JsO2X93wLhZ=YvH0fBqQpzFBujSGgtw@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, Ulf Hansson <ulf.hansson@linaro.org>, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Manuel Traut <manut@mecka.net>, Mikko Rapeli <mikko.rapeli@linaro.org>, 
	Tomas Winkler <tomas.winkler@intel.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 11:29=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Aug 12, 2024 at 03:31:24PM +0200, Jens Wiklander wrote:
> > --- /dev/null
> > +++ b/drivers/misc/rpmb-core.c
> > @@ -0,0 +1,233 @@
> > +// SPDX-License-Identifier: GPL-2.0
>
> Fine, but:
>
> > --- /dev/null
> > +++ b/include/linux/rpmb.h
> > @@ -0,0 +1,136 @@
> > +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
>
> Really?
>
> Why?  I need lots of documentation and a lawyer sign off for why this is
> a dual license for a file that is obviously only for internal Linux
> kernel stuff.

I'm sorry that was added via one of the patch sets before mine. I'll
revert to GPL-2.0 only.

Thanks,
Jens

>
> thanks,
>
> greg k-h


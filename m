Return-Path: <linux-kernel+bounces-330288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CF0979C18
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14BCC1F21320
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C726713AD3F;
	Mon, 16 Sep 2024 07:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="gblJNOmW"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0613C45979
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726472134; cv=none; b=pWjmNjSCBuEYXYRX3MyOL+auP/gxsFTRbxAIckLWfakfyluv1t+XCIPdSjtUscbAxTBnkKTkxveFcLv3siWMnszXcJP1E4c1Ud3TrFYrK86oPclLd0Wb0ENKmlx4OVQdqGgqlsW5efrY402m11bqQHJDvnwHHc1vLDFKwYSMG28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726472134; c=relaxed/simple;
	bh=cka3ptCLUIv9GLSUue/5iS1G5wubhTF/tarvR1cCWA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LaxB3qiBooJpnyeH4Bq0UFECDcjG8w4+UhLxBkJDbEzikCPdUmsga2LLaf9OltZGWbaEr4JDK2A3sqNC2mq8gCBElTNzzIfBVVVpF2bAJpEEyJ/bsZZqu4Ty30Htb/gtaBghRvKhNBFWYTGvC5bO749Kii79nk8/KSdwhOS3kG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everestkc.com.np; spf=none smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=gblJNOmW; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=everestkc.com.np
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c42bd0386cso2523870a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 00:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1726472130; x=1727076930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnWuM9HQ4mBlsv0BI+sstHU0s3mcNwmf+pJCtm/+BeI=;
        b=gblJNOmWSsB7Kf2/hwPqkft3n/+rkkv637+U78j5BFLugEeq7U0Ar6XOyGELjennK9
         bsPIHo4h2CaUjg7gl1nr0+rvRlugGMCW/2fXd/FPvt+MTyib+4guJ5Ju/agik5Gy1tot
         rZioHUiu1R2JJP5+YFnui3SQbcHD58cam1UG/HQ90ejeJYididlTJm0seAx4kVRrLSUg
         U9Ru6GTuUPR2nQuV4H2Jtc/EoQ3TNYbxqan8Ak6Iw89J3S+KOxWXuSBz7werVyNXy7L/
         zeD6/JOTsEtQLTt8tCrqpaapXQNuStN+KwkUE1MskqtRPQm4lcUDBBz/Xr1/gyHuYZAt
         +n+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726472130; x=1727076930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnWuM9HQ4mBlsv0BI+sstHU0s3mcNwmf+pJCtm/+BeI=;
        b=i4jO0f2RCzqYJX7gBZ4JbUMcQP3hNT2fHv2e9rl9pUJwOX3gukjR72uyHTx2JBzR8T
         wZlUH0rbK5Bd7r66RiW38veoPC7MAmcH+SWtbeSiMW9vJv2TPiCO/XfMztxdwvRH016b
         7XoEwFcnNEFA/JItnH95Gcf4RAfSlw5z0RdnBVWkOWeVZL/DZsTspRFd53WRs0anQ3+u
         QCwaf6I1asyrgTdZ6HInGSWPI67KVFCfNk+r+ZHruV49b5Zlfgdem+z2Ez+Bnt8i+eTZ
         46kcL+kdcm4FO7REFL71BC2KXlTnytemyenERmqthQ9KgdY43iIIZq83cOyFhhyfuyeO
         CRzQ==
X-Forwarded-Encrypted: i=1; AJvYcCULkp3v2Kx50faWbKrm4/aOOlcjCjzxuDrvKV2aLBb5wc0z0Z427uG8MGXSQ5lMONsAHZJDbYMhvBYbS+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7/3z4odh1XRSJ0/5faTY9pUGCuH/MRW1FcME35UygF5dYokhH
	nR5EE0KOf0ofBVcVYM9l7S9DTRuBxfhsX093uw6oTucIyYcQG/qAPw/n9zrZGTvU4/12+UX0TzF
	On0kFCE/lMUt5wFR75L1XBfGneHZgNqNbAJZ8AA==
X-Google-Smtp-Source: AGHT+IFGrSGT/zgOLSUtCTGTqE26K7WtLGRS4m5gJ/bQ4n6IzHmrNdIMZ/OqkSlNCYFD4MqYQWxDu0/7T/vHDZb8wZk=
X-Received: by 2002:a50:cbcd:0:b0:5bf:c8:78a with SMTP id 4fb4d7f45d1cf-5c413e1ec95mr10909057a12.17.1726472130018;
 Mon, 16 Sep 2024 00:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024091626-trailside-grandkid-5f86@gregkh> <20240916052357.6487-1-everestkc@everestkc.com.np>
 <2024091639-tasty-relay-5082@gregkh>
In-Reply-To: <2024091639-tasty-relay-5082@gregkh>
From: "Everest K.C." <everestkc@everestkc.com.np>
Date: Mon, 16 Sep 2024 01:35:19 -0600
Message-ID: <CAEO-vhEYdfJ=zLQPPWv7eD6K=G28b_cjog+qBn+QHuQ2dp0u7Q@mail.gmail.com>
Subject: Re: [PATCH v2] Fix spelling errors in file drivers/usb/gadget/udc/m66592-udc.c
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 12:52=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Sun, Sep 15, 2024 at 11:23:56PM -0600, Everest K.C. wrote:
> > Fixed spelling errors in error message and comments that
> > were reported by codespell as follows:
> >       unexpect  --> unexpected
> >       workaound --> workaround
> >
> > Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> > ---
> >  v1 --> v2: Removed the coding style fix. This patch now only
> >           fixes spelling errors. The coding style will be fixed
> >           in a separate patch.
> >
> >  drivers/usb/gadget/udc/m66592-udc.c | 18 +++++++++---------
>
> If you do:
>         git log --oneline drivers/usb/gadget/udc/m66592-udc.c
> you will see the format for how to properly write the Subject: line
> here.
>
> As this is your first kernel contributions, I recommend working in an
> area that is designed for new developers to help work through these
> types of issues, drivers/staging/  Get some experience there before
> moving out into other areas of the kernel.  Also note that many
> subsystems do not care about things like spelling fixes, so be careful.
>
> thanks,
>
> greg k-h

Hi Greg,
Thank you for pointing out my mistake with the subject line. I have noted
and will keep that in mind when I submit my next patch.
Also, do you mean the fixes like this need to be done in gregkh/staging.git
repo? Do you recommend that I resubmit this patch with corrections or
discard it ?

/ Everest K.C.


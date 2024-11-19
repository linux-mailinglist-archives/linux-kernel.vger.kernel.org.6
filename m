Return-Path: <linux-kernel+bounces-413712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFAA9D1D8E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520611F218B7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 01:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC59F7DA84;
	Tue, 19 Nov 2024 01:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYJsNUcv"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953EF1BC2A;
	Tue, 19 Nov 2024 01:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731980882; cv=none; b=PEztYIkDUoQpwd4r30WuxFZ6qTiA06XniwX1wG2VSHmkS5SEL6Jo7x/1iGIMQ6n0S1dPd/vXJq12cohsRGPmJX+/IoMP7bf7GdRylmpEYRAJZFxOXlZ4tIE8Ct1Hsj2iYSipFddzF9xJPaxJOJ5H1n/irvdOK/x/rCbCCrHhDrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731980882; c=relaxed/simple;
	bh=cOA9tbXSSzb/i4FerefFNqM5AIHpypMF5LH5jqpf4mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwNFq2wSTyXMVUW+hclikDKtfbmmubS4pKrVXTCwT+C3d7insmHBAXv0o7S+w60d+RrrfLf7/Fd4LjOvYn4iZxYW722CRTQcClUrCWHsH3qyDsleYfaNW4lAzN2lLY8KkwcKlXAaTehA4gjoV3gpCqvupvqQtV6lRyMb6Urkl8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYJsNUcv; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso664038266b.1;
        Mon, 18 Nov 2024 17:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731980879; x=1732585679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0Jo/KKBcPffbGmgIdsyD8pOkohSJSpZck1cIdtrRTs=;
        b=TYJsNUcvyKeIsNAVzOFzHZ2G5QVCDtW4OVwgLSDUPOHy0fjAf9R8KTBl3s1c6sLoV3
         iCEKkSby8drfbalsAJT+JOH/uauKODMbOpwVN/uvKeOmiLu0UeCV1m3UH1SgYAxFQWyn
         QDLNuw/k5yyEhQWwSfGAHNB1wTsxxh0iHFAWVdj076JyWhOMzZYsCR4o8F2sBVrrEaiQ
         rysT2bamqBJbWF+uFfbnIiiD3PDY74Evq9qBoXlJ9yJ7q6zr6TqOZehg9ah0UKwcEb1N
         XhmzZfL7IQAB5UQS8PZ3H3Dsv1yDqSE8HE1Fatj8vQFoHCS9IuA2BSHhROYDk1q+t44z
         dTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731980879; x=1732585679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0Jo/KKBcPffbGmgIdsyD8pOkohSJSpZck1cIdtrRTs=;
        b=WtY7K+2A5Q9uNdSF7NNcL6KEHqA9VoSeHetGi+kDKcv687wj7DtiplFzlkbgZ6QTxp
         wW7KlFrTGRu8jqG0t3d+Y6Iw6JGfQEKuExJlnrA+EWiX1jGGL4KcSp7Acq3zNgFdR0lp
         UAoSzEFR+GKCCPObuGLRflnLZoMIK0NvZvVmGIdDQngPEzBQKL77Tzl3+tr4PFZazoIW
         QvjP5GvMrw9yinlroc0Jdb/R411O5C9rotz+q+qELawcmlJ8b99FJMIvZdMeR373KCMM
         XPp0FF0b8s/9R9BwNJW0YDqRHxhOahfI7TL92m9fUnAFlT5ujAf3XriCZIJXRw2YzFND
         Y0hQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7Z92xOZLW4BnZfvmbE53DZDpOGR/VZiI+BHDwkZI45ih4fduWwRSHizlovHgijXxIJv8Voy3QFgXy1mP2@vger.kernel.org, AJvYcCWaiQIJsxMwBZfxMKYhnMZcYClZlNnrVdvU6u/C+RPM87gDq2ITY2DoywDkNTEUEB84aW4OZRyuqVvI@vger.kernel.org
X-Gm-Message-State: AOJu0YxpJXqgoA5bD5w4C3Go+U9b0G2yv5IozPqtnaNV1n7H5JyxbV8I
	D7pXzpTd+WOn8s0FpVn+4I+PwaXRk0LxE8By+c5RHunwSuBT5AGzPYyYC6q5N1W74LlAuUNM+aB
	zgGTeiZmgNFDFR8yzv+5SdQY3eb4=
X-Google-Smtp-Source: AGHT+IE8gBfJzkyFGKkxy2q1jEDdV9oHCgOI5STCd2ZM9i3LxvLIsbyX+gXcPK25+06SDNGcaNi725XTI8R8fxIJd28=
X-Received: by 2002:a17:906:daca:b0:a9e:c947:d5e5 with SMTP id
 a640c23a62f3a-aa48347618amr1308741266b.28.1731980878781; Mon, 18 Nov 2024
 17:47:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022-ssif-alert-gpios-v2-0-c7dd6dd17a7e@gmail.com>
 <20241022-ssif-alert-gpios-v2-2-c7dd6dd17a7e@gmail.com> <434333fb-5703-449e-83f2-46e85f34fd23@os.amperecomputing.com>
In-Reply-To: <434333fb-5703-449e-83f2-46e85f34fd23@os.amperecomputing.com>
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Tue, 19 Nov 2024 09:47:47 +0800
Message-ID: <CAGfYmwXotiDHCJJod0Q-SjC9GyuCFFhO+qj9SXCQFud5JgFHSA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ipmi: ssif_bmc: add GPIO-based alert mechanism
To: Quan Nguyen <quan@os.amperecomputing.com>
Cc: Corey Minyard <minyard@acm.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Patrick Williams <patrick@stwcx.xyz>, openipmi-developer@lists.sourceforge.net, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
	Cosmo Chou <chou.cosmo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 12:29=E2=80=AFPM Quan Nguyen
<quan@os.amperecomputing.com> wrote:
>
>
>
> On 22/10/2024 08:20, Potin Lai wrote:
> > From: Cosmo Chou <chou.cosmo@gmail.com>
> >
> > Implement GPIO-based alert mechanism in the SSIF BMC driver to notify
> > the host when a response is ready.
> >
> > This improves host-BMC communication efficiency by providing immediate
> > notification, potentially reducing host polling overhead.
> >
> > Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
> > ---
> >   drivers/char/ipmi/ssif_bmc.c | 15 +++++++++++++++
> >   1 file changed, 15 insertions(+)
> >
>
> Thanks for adding feature to this driver, the code looks good to me.
>
> Reviewed-by: Quan Nguyen <quan@os.amperecomputing.com>
>
> I'm just have a bit of curious on how the ipmi_ssif in host side to work
> with this mechanism? Will there be patches for ipmi_ssif to use this
> feature followed?
>
> Thanks and Best regards,
> - Quan

Hi Quan,

Sorry for the late reply.
This implementation is only tested with our BIOS team, and they are
not using linux driver for ssif feature.
At moment, we don't have plan to add changes in ipmi_ssif.

Thanks,
Potin


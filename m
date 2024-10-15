Return-Path: <linux-kernel+bounces-366904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D54699FC14
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ECFB1C248E7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F801D63F5;
	Tue, 15 Oct 2024 23:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="FYG+k10B"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECD21C75F9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729033636; cv=none; b=bVgcnypnFvGMXMiiVk11XAZysTS9eNB4b+w7onqipjb5F34lNp4zH5q/ioa2kstNwiNkVB4eTmDb4WJryr8xum7ESQfCpICayMnTSATQc+V9F6lQ6XxCOg/q4u/LDWg44d31x010KFNggbko13t40KYPciyiAC4ZuQt/jmngXIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729033636; c=relaxed/simple;
	bh=E7PBTrZAH3ZbKpRiXLjyMPUiIBR1IZxIbTUglZYSC9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ps2EpCp5Y3BVQFT+JpfNL0rYNIuwxnbTn8RPNOZugB37bPiP3WeBciyZrdIRl+KQHeBU8+ucfa5z/Rok4ZQoIAh2Wunm1ZmkTI3ZIes/76MeAG27OGO7zW2h+jwD8rzRkGHN7jUIeV4Jnjj+I9cp16Bq/143Xye14XHtroXjhac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=FYG+k10B; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c9362c26d8so559911a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729033633; x=1729638433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guqvnX2MDH3oX4FJs8ET2tIkQNvvg150UDLzRoMm4po=;
        b=FYG+k10B1ZgqXlFvGmHXjK0t88WDqp6JeeLsCJhGAZDS9mm3qxPg6XA9Wv2qfnd6q/
         D9C9Ha+WAz0XKNI2GX2QntAo2FQ0wOcMd2FWsrBpx++crju6t5f+fXxqblN6D8COxm8P
         Eq/qToKBjf/iRWWdv14dYv2Pp+/zMtDnUGNM66eIso8u0pjf0wQTrDPG5cDywyWjjzjE
         VJajhcm+bTZ53bFOkcKMPk/gkzHkMQMP3dTL/m/KDURPZGaby9VRzeytb8U0SQOJ5yc9
         ozDmHhVc/7PaXvJLkEr9qS+KQEjajseOHoqhImVW/VgC+JFdiENe+Eipt+M8/BjVfDdm
         ZmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729033633; x=1729638433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=guqvnX2MDH3oX4FJs8ET2tIkQNvvg150UDLzRoMm4po=;
        b=r+Km+8Z1BL+4v4hcZUWRMCxMHBPryDMVlfP4Yf14tiFltVl9QhqMK1XTf6f0A6uehQ
         FOG9Z/wgHrz14KJyYtHDHeZcLAB7u14a4aClq1brDvWv41zZGvrS5FNR4496onuJM+to
         veJTIrOARrhogj+xmbow112v1vQ3GiCsiiJ8oqGMBcFc4yOR3KjhIWbQTB36deVMiyb4
         fdv/LyXxTI42qI5z7B2ABd6l07lOLiusT62xOnm32rCCA0hmtGzMnbDdP4rSASDY/uma
         hYc0yarvD48v5H9WrRfmlnAbzZVPnNan6j3OQd4IG67k6hIgWXwpcAO+ai1rZTSB2glz
         oiSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb+L1wY30HGF8lFMMX/lFz4867LZ0bln7f8AIkJbUqjG3+uHt9cv262t5A7pkZeNQVlGJPXsb0gk1cY3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyya8UxgU/q7fSi0PI1NfR86Ji9lPpzPi/1a/J2PCsiEcGMBy4q
	Ii0LPfeFGhOUYJKxUCcHnGZlxM8lpLtlpkbiaQg5HD8nAca1L/K6GCDku2cirwTI8cmaJh8r42+
	nMT+8gnSJYHDX0YttZFP2D0RQoz2/T+ur0YCurlpOjOoz2WpF3fvm7DmGiAk=
X-Google-Smtp-Source: AGHT+IE4m6oEn9p0XHD7GyilqGR60jHljiPnpCXyjhWOO/7AzQTrqk2mNfequr5OyVlWNiBMSSjKd0ta2+tSJF+WD2s=
X-Received: by 2002:a05:6402:3907:b0:5c9:19ee:97f1 with SMTP id
 4fb4d7f45d1cf-5c947596650mr14995821a12.19.1729033632671; Tue, 15 Oct 2024
 16:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015193013.16790-1-everestkc@everestkc.com.np> <f7c92929-dcda-43f5-a163-9a167abf0de6@linuxfoundation.org>
In-Reply-To: <f7c92929-dcda-43f5-a163-9a167abf0de6@linuxfoundation.org>
From: "Everest K.C." <everestkc@everestkc.com.np>
Date: Tue, 15 Oct 2024 17:07:01 -0600
Message-ID: <CAEO-vhFOv_CWUF=E5CjFB-6HVTXe52UOHtPcwPj7a2tkjUXK8Q@mail.gmail.com>
Subject: Re: [PATCH V3][next] Bluetooth: btintel_pcie: Remove structually deadcode
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, 
	Dan Carpenter <dan.carpenter@linaro.org>, kernel-janitors@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 4:27=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 10/15/24 13:30, Everest K.C. wrote:
> > The switch case statement has a default branch. Thus, the return
> > statement at the end of the function can never be reached.
> > Fix it by removing the return statement at the end of the
> > function.
> >
> > This issue was reported by Coverity Scan.
>
> You forgot to fix the typo Dan pointed out in the short log.
> Don't forget to include reviewers when you send new version
> based on their comments.
I missed that feedback from Dan. Will include it in V4.
Also, will include Dan in V4.
> + Adding Dan
> >
> > Fixes: 5ea625845b0f ("Bluetooth: btintel_pcie: Add handshake between dr=
iver and firmware")
> > Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> > ---
> > V2 -> V3: - Removed that the change was successfully built
> >         - Removed the link to Coverity Scan report
> > V1 -> V2: - Changed "Fixing" to "Fix" in the changelog
> >            - Added that the change was successfully built
> >            - Added kernel-janitors mailing list to CC
> >
> >   drivers/bluetooth/btintel_pcie.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btint=
el_pcie.c
> > index e4ae8c898dfd..660496e55276 100644
> > --- a/drivers/bluetooth/btintel_pcie.c
> > +++ b/drivers/bluetooth/btintel_pcie.c
> > @@ -391,7 +391,6 @@ static inline char *btintel_pcie_alivectxt_state2st=
r(u32 alive_intr_ctxt)
> >       default:
> >               return "unknown";
> >       }
> > -     return "null";
> >   }
> >
> >   /* This function handles the MSI-X interrupt for gp0 cause (bit 0 in
>
> With the typo fixed:
>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>
> thanks,
> -- Shuah
Thanks,
Everest K.C.


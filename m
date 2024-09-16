Return-Path: <linux-kernel+bounces-330115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB739799E7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 04:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC125282A2D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 02:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AC48F70;
	Mon, 16 Sep 2024 02:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/5zcmfi"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A43C8E9;
	Mon, 16 Sep 2024 02:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726452276; cv=none; b=IQvOXMvdUgr5bZL42D+Xjf9j6Ea4+Bdyanc9hIMR/t7MdtnezYxxnQ1LwRgOBd2OPaWAON1U4MqzjAbzwvv4ZGR20ke4qZjzIM8FfEG7gbyfWnkd5M9yEt+qeptI+9THjgPsKi7JFwPMxN4IwCFvAD/dDhmRh6t7+C4L+27hcJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726452276; c=relaxed/simple;
	bh=WUYLE36L+WCT8uDtjp0Z6sx/J6FpuWUiwQ1JKa3K3do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDhXfhiu1fJTK4bx8q2T6o5MJMLyBG4SmL6niespsx88af/UXE8C5ZHQjapgkNeyoAzgwhQy655CZ8C09wYjfJpcVnM0om+MXIT5WU+1iK4jPPyqvUBH1kwpqZHK5jueR8hToar7ioSLn+n92okU/WdM0zflDAZLPpuk/6ZXj3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/5zcmfi; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7191df6b5f5so2739482b3a.0;
        Sun, 15 Sep 2024 19:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726452274; x=1727057074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUYLE36L+WCT8uDtjp0Z6sx/J6FpuWUiwQ1JKa3K3do=;
        b=a/5zcmfi5TuAiynNyHarFHO6UGsX0xl1ZtKJn+3T9wlZ10kwAWPYzeJNfvdWf5NZGS
         M0I9MHiwhgYr5sD/3ft57+5kKRD+HjySVJH/+NOkIQuKiric4q/QoAtZ3dqIG/+G+kSI
         sV4LWHtFntJPNnq8vhqFTpJpu3IIZ2S2aHQymhxqBgwG9GOLucGYmMp+b3AeY4NkYoha
         ZB2DmiSm0QKRbDFBkMsGNlDKZUT4ZoiheuozmnEFsxX8LfDLtB2mk46bwjGKPmJL1D+p
         O1AYAvx85Wxto95WlJ38ZYZxUtjHbfXDri9K4ylownFKAcVdgdsMUJ1c61U3GmVyvEUo
         RFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726452274; x=1727057074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUYLE36L+WCT8uDtjp0Z6sx/J6FpuWUiwQ1JKa3K3do=;
        b=Er+Hq1Fwx9TsUYGEUbgkrK/pZGVJrILl6rHd1gg3MiRHhnLviWb40X2HzX95+juy9d
         QE5NGTe4HO6vMaN8zmDs8CP/p4DhNNAoU1WGUANG6HQVCkrYOSTyUijaI0T5h9UIfRnQ
         vhPBS828dtP+/u4g2emq4DOMZq03hEbQyDErSo9d+xigHvyKMjALQtwaYO5XvT/3mkFZ
         +bEG4DTFqhE+7eoDzqE9cbyr2M6eFU6rjnbYeMcwkJxJqsPM9OA89TeRaClA61jrLWAv
         Yp+da1rG839AhxSW7q28XT0X0EaSK5DraZak0LeJNyq3aX7/fhNgClmkUKiHXjsYXb85
         Yu5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpsHBvNLgap1Pkwl1ZTF9UY/iXQCA9tYh2Cgpk93EKYSdQnoYwz4INDxZHPV9SKvrDaILrTLkxnvJx@vger.kernel.org, AJvYcCXN74112CUPOjg5IqqHbIQ1lUoXD/yaUi51xUg8k+KhuwCOtOhhWAEI9jAPBB9Gh+sDj3kuvJmYG+iwDyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGm+CPD6NgvsmeY+4UPWsCwHfLm+E6IpZC7RplZhzaINJfAvAm
	WRfeq0Irnx4TtrA78FO7wk6qeDZGGtOcvnB0IEzXfSmmNKWY7dBQ9rVx4xvu9wLGIfduBrQYS8D
	I7VAi7U+4Mm1i/bCKHgHUngWohE8K2K+L
X-Google-Smtp-Source: AGHT+IE1bMaUA+fWmy8vQqyozHauW12KHm7QnUONI2Y5N/KmorxOP48n87iqTLgiisx7W6UHIt+6q6B5v9YN4nWnOaY=
X-Received: by 2002:a05:6a00:2e94:b0:706:6962:4b65 with SMTP id
 d2e1a72fcca58-719260915c1mr20491032b3a.14.1726452274382; Sun, 15 Sep 2024
 19:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911051716.6572-4-ki.chiang65@gmail.com> <20240911093828.58129593@foxbook>
 <CAHN5xi235kgU8Xd0VYw6r5NeieCM8uqWjgPnLSP1haAFqgcFsw@mail.gmail.com> <20240912091203.3ac9b88a@foxbook>
In-Reply-To: <20240912091203.3ac9b88a@foxbook>
From: Kuangyi Chiang <ki.chiang65@gmail.com>
Date: Mon, 16 Sep 2024 10:04:30 +0800
Message-ID: <CAHN5xi1hwMi3v9j5OPJjWqtPwVHw_6AycyYeGBmApD+4RwtSZQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] xhci: Some improvement for Etron xHCI host
To: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, mathias.nyman@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for testing the patch.

Micha=C5=82 Pecio <michal.pecio@gmail.com> =E6=96=BC 2024=E5=B9=B49=E6=9C=
=8812=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=883:12=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi,
>
> > > I'm aware of one more bug which affects my Etron: if an error occurs
> > > on an isochronous TD, two events are generated: first the error,
> > > then "success", even if the error is on the final TRB (the common
> > > case). Then the "success" causes "TRB DMA not part of current TD"
> > > warning. I suspect that all Etron chips are the same. This should
> > > be easily reproducible by unpligging an audio/video device while
> > > streaming.
> >
> > Hmm, I don't encounter this problem.
>
> OK, I know what happened. This bug only affects SuperSpeed isochronous
> endpoints. If you don't have this kind of device, you will not see it.
> I checked that High-speed isochronous errors are reported correctly.
>
> My motivation to develop a workaround for this bug has just decreased
> another notch.
>
>
> On the other hand, I was unable to reproduce the control transfer bug.
> The exact chip I have is labeled "EtronTech EJ168A", for the record.
>
> You are right, not all transfers have the data stage and transactions
> get out of sync with segment boundaries. I modified the patch to only
> print a warning instead of queuing a No-Op and then did various things
> which use control transactions: setting baud rate on serial, changing
> the volume on audio, starting video recording on a webcam, running
> ethtool on a NIC.
>
> The warning was printed a few times, but nothing interesting happened.
> Dynamic debug was enabled on handle_tx_event() - no errors reported.
>
> Maybe a different silicon/firmware revision, or maybe it's another
> SuperSpeed-only bug, or other special conditions for it to happen?

Do you see any "Transfer error for slot..." error message?
What is the speed of your device? high speed?
I try to downgrade my ethernet adapter to high speed and do some tests,
no errors are reported in dmesg if dynamic debug is enabled.
I think it is a super speed issue, however, it doesn't happen on the high
speed device, I am not sure. So the patch will not check the speed of the
device.

>
> > Ok, I will use one quirk XHCI_ETRON_HOST for these workarounds in the
> > next patch revision.
> That was just a suggestion, you should ask Mathias Nyman, I suppose.

OK, thanks.

>
> But, again, my impression of this hardware is that it's pretty bad
> and full of bugs, and they are bizarre enough to likely be unique.
>
> Regards,
> Michal

Thanks,
Kuangyi Chiang


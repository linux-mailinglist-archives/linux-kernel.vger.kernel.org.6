Return-Path: <linux-kernel+bounces-368785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3221B9A14EB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC9F1F22779
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B821D2F4E;
	Wed, 16 Oct 2024 21:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="ysyGKW3J"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B971D2B03
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729114756; cv=none; b=Fd+wVgzo7Yd3hcd/267f2JI4i2AVDyUt7jH1f/9VGmOJ3okAuZfoz1XgR7OqpVq1rkT0OEBYkk7SPMaPAHIslkChKGuz1KqhWMRTSHyFboNGB3XQJjjm++ncdPph9nZj2deijRi8dF1nDR1hzymWmVivIzM35MUON/ikxsa+B0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729114756; c=relaxed/simple;
	bh=k7GxTv21vlnA+IKy5RrAYAcCA8X9XxHW0ySsY+Tvi3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WnLcQn83OmZfgHrrOJ02cb+cbvdyBRAq+D+NG+HIBBJZ3ZuQ5rJGgzpp5aYt/zsIyb0LKvUFH3wpAcwDKOU+N1IPMdYIhRHi6iMo8j5n0u5qlStpg8E5WYfFLGjbxLGdEnB2ntYUWP0Yvszlw3x3tSN5lwKXY+ev5H4Fjf0U5OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=ysyGKW3J; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c973697b52so400180a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729114752; x=1729719552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGbTpYZZEZP+mGuvzqT9GIg1Bljms7cSdFODzrCOUm4=;
        b=ysyGKW3JYSClX/KxZX/QZpz1IRfsZnUcsas9RzzdWZ6ZFg91cuyPMT5aofgZUDiiOu
         /+wXqwPFI86iSCNkxmdVpJe7f0Q41oSl6wK+UWHvsDAub4WWdZkh59G2GvC7WdBMTLan
         F3g/08Ly1V02LMhvGSlXnnq4OYnVAE29fL093cgB3D/yhRI4buWY2PvhSjid1n6RPyCm
         611Y/WcWOrhJVsguctvm2gA+QTDF6agjEzzRJ5dvhsMG3vj4BiKQ4PuxTJQzhLLagSgf
         bYEiG/ey4VyWTHOg+xgv2jFhCyxtjvqcqc8jDoJKSOoesdR6auhOgRWQeNUtWZn4FeKR
         tcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729114752; x=1729719552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGbTpYZZEZP+mGuvzqT9GIg1Bljms7cSdFODzrCOUm4=;
        b=Y+sLYjurz7fNwKwncrkR4R6MO9e7Wqr8KtJFU3SNDlLSs+HZfWOPsFYd7GLsi5oI7G
         aWy7/CeLRAhkL14BGv/epKBuzyi8SvKCAy+Kg739Aohj36E4Pitb05KX0g+5FwSWiryn
         wq12anWZXLV167W+AcCRWLSiJUvD5qRRnMH+DlmPRj7munj4QzQDfV4IMbAhCz5HDRui
         U6UOAZhMuqFiciqh8FTHJmtdMT/cBRdp4Aza3zaCIAjhadda43L8ZzpfNlLL5VESWQ92
         1wZljZn2bcieIrMa179gMHPGBiNpRz5ilSXNoD16FPpjHIq9fZ4MfW10DM/gdUlsb9/B
         zhxg==
X-Forwarded-Encrypted: i=1; AJvYcCUvNwMeyW8JvNDhb/uRaKEhtb9DUCjhf9zilBKIx1z9k+pp1Y9s1gQbjEO37gFa3BwPTW28Sn6uc2ovC/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPTZUUlTY9QmVJ4UFZPAr2+uCD0q7K6YV+Xz3DXxGOWH7IfkO2
	vFGaQ5/K7VXIwa6a64IUuntniu4ZoWwpHeKPMc9wbKrrPcbmrk5fIMMikXAjlVN652ZYN8deLEg
	0EIXYUw3RJtKTGM82E/zsGliHMfynvQzzWQY5Zw==
X-Google-Smtp-Source: AGHT+IGfXrUOPkq3mI2TubA4yiUF56RfE+/zlumUxASWgWuC+eB9Q8NPP8mccdlaABo7RMO5uJK/NoWjyHvR/RsH+kI=
X-Received: by 2002:a05:6402:5247:b0:5c9:6b39:d9e5 with SMTP id
 4fb4d7f45d1cf-5c96b39dad8mr13701812a12.20.1729114751823; Wed, 16 Oct 2024
 14:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015232212.19242-1-everestkc@everestkc.com.np> <e22aebb2-0961-459c-bc02-3165c364115b@stanley.mountain>
In-Reply-To: <e22aebb2-0961-459c-bc02-3165c364115b@stanley.mountain>
From: "Everest K.C." <everestkc@everestkc.com.np>
Date: Wed, 16 Oct 2024 15:39:00 -0600
Message-ID: <CAEO-vhGc9A5NfRDng1j43czdWo7=DO0wahC1Y5mQrF4w6kZRpg@mail.gmail.com>
Subject: Re: [PATCH V4][next] Bluetooth: btintel_pcie: Remove structrually deadcode
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, skhan@linuxfoundation.org, 
	kernel-janitors@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 8:42=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Tue, Oct 15, 2024 at 05:22:05PM -0600, Everest K.C. wrote:
> > The switch case statement has a default branch. Thus, the return
> > statement at the end of the function can never be reached.
> > Fix it by removing the return statement at the end of the
> > function.
> >
> > This issue was reported by Coverity Scan.
> >
> > Fixes: 5ea625845b0f ("Bluetooth: btintel_pcie: Add handshake between dr=
iver and firmware")
> > Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> > Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> > ---
> > V3 -> V4: - Fixed typo in the subject
>
> I don't like to be the typo police but, no, you didn't fix the typo.  :P
No, using the correct spelling helps in searching the patches in lore.
Thank you, will send a V5.
> regards,
> dan carpenter
>
Thanks,
Everest K.C.


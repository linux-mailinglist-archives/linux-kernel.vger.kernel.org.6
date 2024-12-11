Return-Path: <linux-kernel+bounces-441791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A05169ED41D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4399A280FDE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8531FF61A;
	Wed, 11 Dec 2024 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hs3m8neY"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7DE1FF1DF
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939652; cv=none; b=pgNPOM24D9grBxqrQ+RB73uPzYa8jwXw0LAdlYEkYvcdfYpF+BGTsc3iGibAFC1yCHS8BOJxzS4rsHuhhOaypZ8Jev4nyKSYVStiz7+hfXCYZlWLjCYhfUxVbh4TOjvso7xIcaiML5g9bBzfpZFif73PhiH/bDyfPnfk2RGaEyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939652; c=relaxed/simple;
	bh=SBAUUgHHCorAYYhe1b/RpcaSfhfVVFDNGT3lM1F0Fxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jnn0zLrKPCWPvfEtO81VFsrhn72AvQbQYNqe/F23UV0iTIjfN41e0YXz+u28y3wJPSHTFi+Ks6Jb65iYNAsciGoEN9uJ3e5Oek90B29krFq7BGjrCFGZbS36SXf5eG9pcMgKcF9G7fHc15ryw+9Vak8geQcGci/8eFCff4aZ9CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hs3m8neY; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3eb87127854so288307b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 09:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733939650; x=1734544450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBAUUgHHCorAYYhe1b/RpcaSfhfVVFDNGT3lM1F0Fxg=;
        b=Hs3m8neYcFQmat+Z0mFFTxjDikX4Mwuk94t3ojvAnoHxDlMkOyFWNObjPHOCG5MBa+
         ya+3ODDO+leNdv6Yo9xCwY8vFDcdBNPMFPtjkWX4VFh2SrDXk4sZDdF36QwkZ8vvXVLk
         my5MYV0ekQxnqq+Z+HHut8SjzCRyMSTGzota/MTmkbEEWI5AFsuhwNwhfxARLw2rfAUW
         9EZb7jd6ysQL1upHb/5Hqm7QpWJV5KFIitVk53kPXHAtl/dEf1XRSF1gJltGMH84Z6bS
         Bn6oOE9ZXzO5CvX+XLRRDpGrG5HjEhUhrkNHgRVUKkNBtTrAwirc+5EAPYHARiCw1UhX
         j4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733939650; x=1734544450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBAUUgHHCorAYYhe1b/RpcaSfhfVVFDNGT3lM1F0Fxg=;
        b=O305VtNfelPb1X1p+/Jm7UZxLklJB1YqOjgxmgazOzrN/iZBOBIbkkQDBVs2gJVutc
         GL7pPZR3MahcQrMwYZUJBbzjIK5wZuEcEL0Ayvll0jEeLiyMJrmvCepiYljmdd/E11Aa
         /cx8XoWCmdIoLagYQ24/awqUJb+65lTGwXg3kyf0KUuxYKhveT5xSurWweZV9BACUx24
         wXvBWP4tnixH1Na0klA5VyY3JrfG9oCRPudOxLGYGMY1uUDHrUXoh9Uh6cyNbS/ChfQ6
         HDyWnVXCUTZwWWE/JHeAD5ZYRk3lRN1gmwJkjCTql4xJtnkKETyXdDsEcbAZtFz/Ra8H
         uv+w==
X-Forwarded-Encrypted: i=1; AJvYcCV1xvt6BHtZ1MwErKk8/y38w4DfbrfcHp3O9YylV+cBBpMzKLCBWaKjxTMH/Ff1EC3KhrRpke3mkrihGjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YztmKlY98FM8thgRIeHquP7i5/Vs/fl0ps/dJ+z9Lso4ZV39bgg
	O90oYewEwGXcpeUK38ihYGEWbySJClztMhuS+EUPjgOBccJakLpC2+lytxdXkOnZR4ib4WDTuCo
	irt+f/z5ClMISrvlz2N0tUR83Ag7NLFHjdxRsXQ==
X-Gm-Gg: ASbGncv/+xjI9vweLsVD6235YiTO4rA1cwMs/nXVpHlN21WBk0SJGvzBk/Y6Rd5kCGB
	TY9aMiz08oHVjMtBsNFX6P8W3lmp7KBp1YC8=
X-Google-Smtp-Source: AGHT+IFfj39z5VsWFUtc547a2JiE2gqj7fMrc6Hgv7LJC75wfYKzbNhVcat1Y4z8nTrgUp65iUPhRZVJvBmlgSE3NeQ=
X-Received: by 2002:a05:6808:1304:b0:3eb:3cca:8829 with SMTP id
 5614622812f47-3eb85d14a42mr2424138b6e.34.1733939649689; Wed, 11 Dec 2024
 09:54:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206-gs101-phy-lanes-orientation-phy-v4-0-f5961268b149@linaro.org>
 <20241206-gs101-phy-lanes-orientation-phy-v4-7-f5961268b149@linaro.org> <CADrjBPrz1qUxbEVFR8OT785xLPwWmu3_ZThSne+EtpS8_NHEEg@mail.gmail.com>
In-Reply-To: <CADrjBPrz1qUxbEVFR8OT785xLPwWmu3_ZThSne+EtpS8_NHEEg@mail.gmail.com>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 11 Dec 2024 17:53:57 +0000
Message-ID: <CADrjBPqW81kaK=Wco7wMg50APTXGRwhnfFjbnogrSQ-T_mWnUQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] phy: exynos5-usbdrd: allow DWC3 runtime suspend
 with UDC bound (E850+)
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Sam Protsenko <semen.protsenko@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	Roy Luo <royluo@google.com>, kernel-team@android.com, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On Sat, 7 Dec 2024 at 22:03, Peter Griffin <peter.griffin@linaro.org> wrote=
:
>
> Hi Andr=C3=A9,
>
> On Fri, 6 Dec 2024 at 16:31, Andr=C3=A9 Draszik <andre.draszik@linaro.org=
> wrote:
> >
> > To make USB runtime suspend work when a UDC has been bound, the phy
> > needs to inform the USBDRD controller (DWC3) that Vbus and bvalid are
> > gone, so that it can in turn raise the respective gadget interrupt with
> > event =3D=3D DWC3_DEVICE_EVENT_DISCONNECT, which will cause the USB sta=
ck
> > to clean up, allowing DWC3 to enter runtime suspend.
> >
> > On e850 and gs101 this isn't working, as the respective signals are not
> > directly connected, and instead this driver uses override bits in the
> > PHY IP to set those signals. It currently forcefully sets them to 'on',
> > so the above mentioned interrupt will not be raised, preventing runtime
> > suspend.
> >
> > To detect that state, update this driver to act on the TCPC's
> > orientation signal - when orientation =3D=3D NONE, Vbus is gone and we =
can
> > clear the respective bits. Similarly, for other orientation values we
> > re-enable them.
> >
> > This makes runtime suspend work on platforms with a TCPC (like Pixel6),
> > while keeping compatibility with platforms without (e850-96).
> >
> > With runtime suspend working, USB-C cable orientation detection now
> > also fully works on such platforms, and the link comes up as Superspeed
> > as expected irrespective of the cable orientation and whether UDC /
> > gadget are configured and active.
> >
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>
> As mentioned on the last patch, in my testing cable orientation
> detection is working, but Pixel is detected as a superspeed device in
> one orientation, and high speed device in the other orientation. So
> you should either change the wording of the last paragraph in the
> commit message (assuming you get the same results as me) or make it
> detect as superspeed in both orientations.

You can disregard this point, I had a typo in my test setup :( I just
confirmed that it is detected as SuperSpeed in both orientations.

Thanks,

Peter


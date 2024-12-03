Return-Path: <linux-kernel+bounces-429855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C7C9E2BF1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C38AAB365BF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FD51F8AE6;
	Tue,  3 Dec 2024 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="O8rYk9EH"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE291F4707
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244013; cv=none; b=LCvfrg4BtW3EEi/HQ+BySfIo9E2l/sJUjHeNMoTQadLR2YzlyYIHtXp54aKl5EbNBEZJlcGXHti0+G/1GeNddwsFZOT3g8Fau33p+6Iz02zlwIZMTEuL0JRs3mN85CSnuGFvGoyVsxDSwYoBvo3POTMy8cYNu7xFEI30V03kjy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244013; c=relaxed/simple;
	bh=zhpXsUhWElyZTF7rStYo8xogRYQt2jIshLLPfv46x4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZ5HcjAy8650F4U1LohQ0PjWkha+mr0TT8+hScVjBM8V36P72sOjLFe5kyqMdRJwaMETNbG1JBzIu6rfeQB8tCUHqPTLeHHGs8AFY9FLkcSyLKvstKU2zt2VKJW/E0kH09maewPgT2+PJsAjQ/FqSARAkRjDpI6CpbXha/q0iRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=O8rYk9EH; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa53ebdf3caso321261066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 08:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1733244009; x=1733848809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NT40s9IhyBcB81OE2gH4u8uUiWRgntK1+AQA8Q6mydM=;
        b=O8rYk9EH/Uoxgdz+e2Px5znOiDnUMd4+Y51jCgsLUvJv6JN1E0D0myO6ig4fTNAnXh
         m9/4Xsn6q6thAE4n3TILLH0Kb7/AChxBXm+TzSzXJPQB0HgF7zTXd709JoKBS47luvhY
         EMaD6WfmRsSCVseuw0Eyp8FjE/gmEqlVoi+xGR0HZNWpFHdQ89CWJbhMag90S1rVui16
         H2eXr2HlzZQz86vA67hjYa01V0K/d9CrjlKw7k+KzFLAGiR7Cfz73Ulp2+2a+cvq8N6D
         yB2OZiwLfATNv3ULWYWiZdDkNzHsn1j21NCYpYKlOXyqQuxDEtYMT1cLBS2spA6/6XOT
         wejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733244009; x=1733848809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NT40s9IhyBcB81OE2gH4u8uUiWRgntK1+AQA8Q6mydM=;
        b=EK8fbiqdnLswYEfQYDYExUKzD1GtcCBmCXlzpSxI4DW0OQcg00kGHRMkeJqSrvBZZx
         Y+vDnOOkwqTwjlnNTqf+guJbDUB39i0NxC4nU0E+9v8tVMb13+zWlVLd31IJzjs2bepD
         gYXLySU76h0qfWgvxQ+veHxddtwY0lYrj6MWGN6r4if3TabIaCDr4x0hPuOoCGPhOIPN
         CPa18ed9Nf3+tUG1rHtZmN0zMkRiJP0N6OeFtW6OAgg2TXnftuVNNi16e1TH9CYSHabV
         vFmc9IbhJv/o8COGmdyXWTZh9Y/+gwPgDIGICuTARVGgct3nkwuy3ueI2wxhBWtEp6r3
         G57A==
X-Forwarded-Encrypted: i=1; AJvYcCVld8T/TTts7nTgm31NR5sV77kbLMrvx7iGvHGcIbMs4B9GbLbCGEpzSJ90D29bTX5ahKl6WGB+hgnLaxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbUMS+JmnKhpZOBhUs1K/zSIHfO4hUuA58oFn5KgudL2QFPJA/
	J2kWyAkoawwxzT7XkwSAb9DBgSQeg0aKz8sgVjOFYuU0n4dSwDFDN1drBJJ4WjxlI+qnxMy4p+2
	QmbI=
X-Gm-Gg: ASbGncsI9RSW02k8kE58avzYodqpeibPDX+rE+Gm8ylu4JsH4gZHjILbvGz2eQieDvq
	BFIQkEFgDV3FLDvHOlGWk8Lec6LYSYAMUMlhjI2l1WrVcS0cfeb0a1k405bmAAy/n3VM3F2XhdW
	qBGIWhGhaSsD3wT4EmlxCEmqKpOiXEfjDJ9a2nL6PzCQPArfL5Tsvlvfcqd7HXCBrB7FZdlASkT
	Uii24ihMWfg7dMSd7oB3syb2wQ0dVAJbUycMXIkKo1mZl1/2vrgfw0ucF4vHdd3x5HNoKO3/mBg
	u0Kj4FMXBHikjBjBK1bMmg==
X-Google-Smtp-Source: AGHT+IHtlYiKlmbmtddBIfD3mvOQXuVdKJkgV/ebJcDoDWG+o0kpShNERfrSJ/3NHy4jFEc2DIFrlA==
X-Received: by 2002:a17:906:2182:b0:aa2:c73:3720 with SMTP id a640c23a62f3a-aa601924620mr109708466b.58.1733244009543;
        Tue, 03 Dec 2024 08:40:09 -0800 (PST)
Received: from blindfold.localnet (ip-185-104-138-68.ptr.icomera.net. [185.104.138.68])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996c192fsm642636566b.27.2024.12.03.08.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 08:40:09 -0800 (PST)
From: Richard Weinberger <richard@sigma-star.at>
To: Mathieu Poirier <mathieu.poirier@linaro.org>, Andrew Davis <afd@ti.com>
Cc: Richard Weinberger <richard@nod.at>, upstream@sigma-star.at, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, andersson@kernel.org, upstream+rproc@sigma-star.at, ohad@wizery.com, s-anna@ti.com, t-kristo@ti.com
Subject: Re: [PATCH] rpmsg_ns: Work around TI non-standard message
Date: Tue, 03 Dec 2024 17:40:04 +0100
Message-ID: <8065064.qOBuL9xsDt@somecomputer>
In-Reply-To: <901d75f1-76ad-4c32-920b-1e9b10270236@ti.com>
References: <20241011123922.23135-1-richard@nod.at> <3518312.cLl3JjQhRp@somecomputer> <901d75f1-76ad-4c32-920b-1e9b10270236@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Andrew,

Am Dienstag, 3. Dezember 2024, 16:19:31 CET schrieb Andrew Davis:
> On 10/15/24 1:00 PM, Richard Weinberger wrote:
> > Am Dienstag, 15. Oktober 2024, 19:56:08 CEST schrieb Mathieu Poirier:
> >>>> In my opinion the real fix here is to get TI to use the standard mes=
sage
> >>>> announcement structure.  The ->desc field doesn't seem to be that us=
eful since
> >>>> it gets discarted.
> >>>
> >>> This is for the future, the goal of my patch is helping people to
> >>> get existing DSP programs work with mainline.
> >>> Not everyone can or want to rebuild theirs DSP programs when moving t=
o a mainline
> >>> kernel.
> >>
> >> That's an even better argument to adopt the standard structure as soon=
 as
> >> possible.  Modifying the mainline kernel to adapt to vendors' quirks d=
oesn't
> >> scale.
> >=20
> > Well, I can't speak for TI.
> > But I have little hope.
> >=20
>=20
> RPMSG_NS_2_0 is a compile time option, you can turn that off and rebuild
> the firmware to go back to the standard message structure. Our new firmwa=
re
> doesn't use that anyway (and it was only introduced to support some OpenMA
> firmware that had multiple channels. It was left on by default in some old
> firmware SDKs which is why NS_2.0 is in more firmware than it really need=
ed
> to have been). Is there some specific firmware you a working with that ca=
nnot
> be rebuilt?

Cool, that's valuable information!

In the meanwhile I got contact to the right people to be able to rebuild the
firmware. The overall software stack is complicated and I'm just the Linux =
guy...

So, with some luck, the DSP application can work on mainline with
almost no kernel patches. :-)

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y




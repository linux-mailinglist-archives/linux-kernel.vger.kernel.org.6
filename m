Return-Path: <linux-kernel+bounces-537367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F751A48AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF9D164198
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E44F271828;
	Thu, 27 Feb 2025 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWiG7gSf"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0552702D7;
	Thu, 27 Feb 2025 21:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693534; cv=none; b=DoV8myTjxsPuFGCuuZBhZJSZ9E/E7FGkiij+5KKEWTJUSATAsKClltCJWPupLp92q4rtNahDo84ExDkL/zTpoxSxmsvg7HC+YDN0qIwMEsldq8fzNlSv82RIqWN4bYOyoaCLyirZ+SqS3LStL2RlXRcdEMIy5gMCR3ezKRZjTuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693534; c=relaxed/simple;
	bh=Dm3RxaB0CXAQe1z7lgXkILph+xq5j+lovtkROFEkZdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHivdrWziKojtDiIPYEMmNlhpW1jMs6i1mBdMSv0+q89bzV7ewuoFcA5jCNL/yUGp5tX3gUaQbyxZ4KYX3dIEwuttDC9odt+z0toXTEJ96YOIO05Xjg6MnQjj5j//oEEc1BIUjvmj4mfAw5dJZGQpi3t5hltd92FjID6eunV3nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWiG7gSf; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-471f16f4b73so14224191cf.1;
        Thu, 27 Feb 2025 13:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740693532; x=1741298332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dm3RxaB0CXAQe1z7lgXkILph+xq5j+lovtkROFEkZdE=;
        b=KWiG7gSfBf4wGfKvY5ibhhZfYa7dtDt3IdGRtzsKbbabkgDcF24VShprByqUB0INNE
         9yGUD7hxW+iqEauU8O9CqmgJYib9MRFE0Yz537CEhnOqXNjMht9TZcY7MOfG26vjHjPH
         TmpdTiywRmthss4yewWtR4rV4Vsl09xPLm/tj19XxiUIGqtFkFmnjN+6LtD0tPENDtCa
         9RlKIcq6Pt+tBcKnN3CvY78Cn3tB4YnX8NEzmzbWGqh8yqU4YN1EtC65da++PP0ZBliL
         /9G0gFTIEq6BABkrGh9eT3otjYfhYawjvbx82u2fkLDNi23BZd8ZciMZ4NjiyG2TZvxf
         CmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740693532; x=1741298332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dm3RxaB0CXAQe1z7lgXkILph+xq5j+lovtkROFEkZdE=;
        b=SjqKsGs1F/iQrRrMUHwsRBWIV2g8VH/VZa8KCeFM+VjQuc/EPZ2uZLbxIAXVn2HQg5
         IJ45q49Cvqng6ovd5RYUCLG7ri2SrJXv1/Lr/mVNHcMVsMpZX9Gjz/p6WAO60CrNSAot
         tu+jjfR1/rYhPhu/RwuSlvc065dejl+tZ7xvG/qhZer7yMnNR6lY7Ds1tm7e0OEf7rXC
         lAYjwo8y4Jnw3qEY121XadkUPJ4QwjsOISDKGahW3noUq3VbFvO9l9LGzwgxkiGku5vC
         iQtUAd2ddTaf15UdZQ63retJUYd35tPtq/i2m59rLv0cV6i+M+7z52FaVu1Fak7t2fB0
         36fQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+L/VoFXPajW4+9SH1F6x86W+XJtPE9s3F4SrmFe3ODdkLXjiMOSzApo8h0jaESmrNWXZf2YtP3OQqLw/H@vger.kernel.org, AJvYcCUOug3lEs6QBvOjSEzsOVune/qwLFjhNRIxv3HmvdjJWonhpoDzFgd08CJbKzTcuObGAk1uMSPNBmJoUmY=@vger.kernel.org, AJvYcCV2MeQiaO8PEwHX3SHhfR2I4dqhVQNnqq5dfA5n8DHMSle/UUYACYqgpdePiqIK6YN3m7hU5ZCDI9hXSD0=@vger.kernel.org, AJvYcCXA6kxLdqyfoSmHBE7BHx2ALJqlxpM94+xl/lFZ0mcrI5MYY6Grx1YKt21cftdsJdeWAsdMqcONWs3V@vger.kernel.org
X-Gm-Message-State: AOJu0YzMvLeYNXbi226kkLOlzn+rhTNiPoQiyMCGINICFoMXIDXS8naZ
	EAQrWW6ypD2JMBax83Nui9llkeLdRL7sVwCg5cVr9B7W2kmH62YrkHU/0KOaF4/WAVeO5fA8/WM
	QKtq87cJv4MAI1vHR70ya1w472qaMFV49
X-Gm-Gg: ASbGnctGESNdbgWz/aK24Q4LUh0uT4ukOMG18993Qr58V596RuY4yD0mHg/xnRG4f7i
	hXXC9xHee2f/oPePEce+XmA9NPrzLfxo905zPguJAmHXJToiWYW0JI2WBSzRiso5woix/P5lSK5
	6dduwJ1A==
X-Google-Smtp-Source: AGHT+IGZycxF9mK2j7Xgw/jf4P4PzwJkPkA+YQ8gNsvWst/YlqRF9ahH2kcIfaFTwicW7dgH/uB2VhA7H7UVn8sEOSQ=
X-Received: by 2002:ac8:5ad0:0:b0:473:87fb:2ecf with SMTP id
 d75a77b69052e-474bc068615mr12002921cf.21.1740693531852; Thu, 27 Feb 2025
 13:58:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
 <20250227-apple-codec-changes-v3-15-cbb130030acf@gmail.com> <f3eecce4-51d1-4414-af85-680d51e588fa@sirena.org.uk>
In-Reply-To: <f3eecce4-51d1-4414-af85-680d51e588fa@sirena.org.uk>
From: James Calligeros <jcalligeros99@gmail.com>
Date: Fri, 28 Feb 2025 07:58:33 +1000
X-Gm-Features: AQ5f1JqhIE5frhKKp88Yce4HcYqH0rbyxjCTlt3Y9iZPbu-hf4o4-EBYqcvAUCc
Message-ID: <CAHgNfTx_kMj=rsd4nUCiX_PvgC4GX3DsPDwXHdEyEeLMbDFccw@mail.gmail.com>
Subject: Re: [PATCH v3 15/20] ASoC: tas2764: Enable main IRQs
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>, 
	Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shi Fu <shifu0704@thundersoft.com>, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	=?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
	Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	asahi@lists.linux.dev, linux-hwmon@vger.kernel.org, 
	Neal Gompa <neal@gompa.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 2:23=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Thu, Feb 27, 2025 at 10:07:42PM +1000, James Calligeros wrote:
> > From: Hector Martin <marcan@marcan.st>
> >
> > IRQ handling was added in commit dae191fb957f ("ASoC: tas2764: Add IRQ
> > handling") however that same commit masks all interrupts coming from
> > the chip. Unmask the "main" interrupts so that we can see and
> > deal with a number of errors including clock, voltage, and current.
>
> Shouldn't this also be a fix?

I don't think so. The referenced commit only says that it adds an IRQ handl=
er.
I don't think this commit is actually "fixing" anything - it's just
enabling previously
masked interrupts.

Happy to move things around if you disagree.

James


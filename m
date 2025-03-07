Return-Path: <linux-kernel+bounces-550520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E53FA560B0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E218176227
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC49719D082;
	Fri,  7 Mar 2025 06:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTLXAzr1"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9037DDAB;
	Fri,  7 Mar 2025 06:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741328325; cv=none; b=C80VBtvhhy2sS/9VMfRKmZ9PWL0SBMdWGBAHmCSRXcYJXoKj6XchKxu6amznKunBWPA7IxFiPsom7zUrWlbf0M+cM72QnkbwyJK2afSjZZxLAa9GVjEERFYT9BLcKYRiInXUE6uayb6S8ohxaieVrm7ZziYr7FyCsyEBdbsi8vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741328325; c=relaxed/simple;
	bh=1soUIkK5EKDYaH0c8vrvpJEpTwWQncZv9NclynqEpxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/1MgQ/h+eS+T2hhT48THA4INpwEoHDtUackheqVAFvsiwu65y5bFiDvfEVLMy7QOxFqItEnKkOOOp7x9Fv1tPo+Wew2q9gk5B38zrC4scOyjNJ2AL1VUbwVlHiEBs3JV2gh3zDcNA0GwPAI5xz3o6TDFnfqSeBJRW3ZKUoa6f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTLXAzr1; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4750c3b0097so13048881cf.0;
        Thu, 06 Mar 2025 22:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741328322; x=1741933122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F10fia5s8BJGMmpI4HkuMx1Ala8TT6PDF9W24WMGIHg=;
        b=DTLXAzr1METQGL1nVOzo0upACWY064ZI9wB9HCG5didw8yBtCBfykQc+DLedE31n+f
         w4IMOE495czsJlX0IddESs9sDGbQns9n5uR7r2wNMV8Kl5eNb3TSi9nwI2Ved06TuzJY
         i+ruvU8iGfi5nH/1LTAhjjQYCTVZ39n/F2GBqBZZaFST618gRdMFiUXEsykwiWR9ikXz
         F1lwHF36Tv2KwTdrOj1yn6bCUNhDLDnjCF+ydd4aZBZujKJJORZHVaDOFDywTWyNvw1b
         m8H/WiauP9bJ1CdYv5edL9m7DSxVYuKqHhoRdKRpmbHCxWOwyj9gKQFy5aLzcguY81Oz
         fXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741328322; x=1741933122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F10fia5s8BJGMmpI4HkuMx1Ala8TT6PDF9W24WMGIHg=;
        b=XhF1VP5OU+ulAisigFdv70C4rlBZhQkFOgF/OQelRePe08iIhmzvCpM4hQ9b6EH6FY
         ck8eKP42hTyrNSRLinlONqBagaPPYrMUSZn3E7+Dsdfxt4sK/T+OVyEHX61yPgGRiu/x
         e4tJrmZk/Cn75asWzISwcYry0noPuUEVzMvfJhsa+NP0lAivGyHirh7VoYMVvvVPcjZg
         JHmpAxTdOMX18qYgqN3Cz47u1GKf2R5D8nGXxqsvIiB7b8bQpnF5N9lpF2KZ5E0YKZQV
         VFtvIi61LMQExdQgUq7F2LN1ZT0kQ7+QQTo+JV1PXK7tChKMusL+yYyClJvcTAvIoCzr
         dK1w==
X-Forwarded-Encrypted: i=1; AJvYcCUEKE/H5R++2kpFrFB4UtGNN3O7zD6DNl1+dntV+ydFw7aCBGFTf1N3SS9c5RJXhRYg3raADrwquT9xo/fn@vger.kernel.org, AJvYcCURCQr3oSbQZALmvtbdQUInZlLhsfF5KqBpU0JoL8r9D4eR7nAL1xg93Lq6zm5Shu7h1cymdU9xbq4Q@vger.kernel.org, AJvYcCVGwXQ+KNgkt8uwsDsjkh2ns0LZ0vgNHzTl7gWMvEQKM9viq33oHusvTpqTGeW0pg5Pqpe0y/3vGznU7Bw=@vger.kernel.org, AJvYcCXIGwCEJ+sXhLtyWYGqYaTXUOcK8BfJQP2UN+L67wIZIIdzJlMEh3OnWkcCodcx9CaZomMemCT3qtxChFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmGaljcnPraTFQ8IOFrFsU5ubY50f1eGVs3hvBgW3wTry3iPhN
	b5YsCOhUKc7Sx3i6yXjeAklkAIXOWEAxEncqVAXbNtMeqLxYDUlthAWNQNIJFxX4i7AaW0LH4m9
	yqWSNLkWbpxnNRsSSWyqKatgBFL4=
X-Gm-Gg: ASbGncuoyiWi/MjzkVtPi/nKkwzo9cUFy18aiksRMqmSMhHcfpA70Gt6tDpgG1a+aQ8
	LWH8H6EJJ90iM3O/pga1SjvAi/kaO4JbG7UHG5gYTpbMEzCETzldfmjo/EcI1RwLNE2aoQL31qF
	zXCFlwlQlf/bm2mf7LgGtiyhcIsI1J/SdO0E3uXDk0SgFTXgEsHEfVMd+f
X-Google-Smtp-Source: AGHT+IHhETGPw/ZFKq+YENLV2u5EcdpAk3T+SS5XFSamMDKfcKgYmQS3Mbj3mWKDGRDz4TBEKSSztO8xYHOfJx/qczs=
X-Received: by 2002:ac8:5e4d:0:b0:474:f29d:2e96 with SMTP id
 d75a77b69052e-47610978d28mr30024911cf.21.1741328322528; Thu, 06 Mar 2025
 22:18:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
 <20250227-apple-codec-changes-v3-17-cbb130030acf@gmail.com>
 <20250304135050.GA2485358-robh@kernel.org> <CAHgNfTyVKFuT0fZ3Qj=MdcXs67KscwkSepAH95xkAAKWM1g8Xg@mail.gmail.com>
 <20250305132239.GA1415729-robh@kernel.org>
In-Reply-To: <20250305132239.GA1415729-robh@kernel.org>
From: James Calligeros <jcalligeros99@gmail.com>
Date: Fri, 7 Mar 2025 16:18:31 +1000
X-Gm-Features: AQ5f1JpO-lY2IBZyJ9phmkLFb8GGKVOf8HdEFFSJcTDAx0YxxJ5ZNijHlkAl-zg
Message-ID: <CAHgNfTxS1Q4PPsw520-J4Yn6xg+QZOYFkYhg5yv-uZFu5waN_g@mail.gmail.com>
Subject: Re: [PATCH v3 17/20] ASoC: dt-bindings: tas2770: add flags for SDOUT
 pulldown and zero-fill
To: Rob Herring <robh@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shenghao Ding <shenghao-ding@ti.com>, 
	Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shi Fu <shifu0704@thundersoft.com>, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	=?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
	Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	asahi@lists.linux.dev, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 11:22=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
> This just feels like something common because any TDM interface may need
> to control this. It's not really a property of the chip, but requirement
> of the TDM interface.

What I'm imagining then is something like:

dai-link@0 {
    cpu {
        sound-dai =3D <&some_cpu>;
    };
    codec {
        sound-dai =3D <&some_codec>;
        dai-tdm-tx-zerofill;
        dai-tdm-tx-pulldown; /* either or, having both makes no sense */
    };
};

Codec drivers would then provide a function to set TDM TX behaviour if they
support it, and export that as a dai op for use by machine drivers
when they parse
the dai link similar to dai-tdm-tx-slot and friends. Is that close to
what you have
in mind?

Regards,
James


Return-Path: <linux-kernel+bounces-553840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D14A58FAF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8785916BC96
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807072253E4;
	Mon, 10 Mar 2025 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOjRnGk4"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743881C5F22;
	Mon, 10 Mar 2025 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599018; cv=none; b=EgvMham+0JT3Qg8JzrqMZ6HM95jE5u1QhZbsiQT3w17ExmfJFm8bJwQbqqyYt8CHmaLhsd1H/p5yiNMOOOW8fvrlJ6XURlSIz1fNK1eS9Ft5EwMVBRtaLZ4eDgwnYGTnZunaNj7VCCFqGAzYB1VtBva78AcQhS28xvrvyxfuiz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599018; c=relaxed/simple;
	bh=jUtUQg74aR+QT1pHvyCm57vRLK9jOPZ0YAQlpRfOnKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJDVcc7JZKZYsjLeIu1tTiygOHDrfm7sUgQIsPJMMCCRUn6Kxy8EGX/a62gArbEQTAhGFbY5K/GLaQzmphq794FpxLLCmyhLQFgMTfbGYR9jtFEklYuDlUMnT5/dAASG4zeyGYUM989+X4YeuigARg+NbmbRoRe0wNNv2FrvirU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOjRnGk4; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff4a4f901fso5746013a91.2;
        Mon, 10 Mar 2025 02:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741599017; x=1742203817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5PO1nUn7Da+eSXJyU+EvbCSWkrbL0y5pIUDKxSEvMI=;
        b=LOjRnGk4jaYubYrtW7gBdeC2Ufx4Z9DSZFanBCnAUcjr3ytE+Nn+0kq++8zHxox077
         kJ/lFnxYer2pvzThQmuvV9vDVWA7+HH3INklQTpfl79gT+CYsV7TJZ1CPiPg8IID9Mzc
         dkN1/D4SLATXK3F4EyAILUAvkcxvBvB0KAfSt1QKWIfy5kCH2s9DEOge/Wg7NLT/hxzc
         asSD/pdtMzAry+l2DElajpyjS2IG8neKgSXy4HLQzuQAbvcMqiXxn5UMRlxuNPguyD2P
         Lp/Eq98dswlMm8A0tRFgmE5+xml2voL+/IQs/J5UZT4XK1NkviAUEwvIBqBchx5LkQS1
         +f2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741599017; x=1742203817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5PO1nUn7Da+eSXJyU+EvbCSWkrbL0y5pIUDKxSEvMI=;
        b=qiv9sjhRnG+PxS6CoKNpdPBCWokSKzxddoz8imv2V1pjH8syCYJO+DoJ7SDIxT8EET
         5zsFiV1EwdUHL7XpPPE3saVH+7ChlkEZms6V38m947fwP0gQjOhZyxXk2OMkWgIh0pE4
         WAKLC1wOZ6Xsc5BqudqPIZQZ06/pF6WNkJ89i+J2JlK2kAVnCP6vBuZ98DpO+VATJc02
         e1JBfztFUst6ZNu58FDrj4pFRQkcaT82HAp7CSvR8kugCNhoXjCtGsv9jqJV37zK2Hcu
         tT5nNrpb2Ip1g8Gq93yoEqiEhzstm5omgrBO25FR8YTwetCySQv7ShfwhtMJgFLBOsO8
         z8Nw==
X-Forwarded-Encrypted: i=1; AJvYcCU07jpTmsI8vnEMiZIMJsdLuFkYcTIwmiAmTLnNx2L+c93pnnpP9HEY+YaRKkoxYi64BerOpxUrvz6WQPo=@vger.kernel.org, AJvYcCV4+dlCEWUDElZKbFgJ0mhXfZCy/bpAOBPi8609t7xNf965Luw5KUjIxqLNFBwCDVToclSB70sygrHEQTU=@vger.kernel.org, AJvYcCWinNLGZD19sPkyVK86ASlHaYpEIlm8dAktw7qznXxJFizwxCd/bkSXXaAjZn0KzUg6JJOwLpXPF+MqF3m5@vger.kernel.org, AJvYcCXgijivGUCto6K97ub+Zu3n/1LMOHUlnC8SuiJDIPrbwLjywx9aJAOm6Al5G10qWdlLRrLoYebxN4/Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl+y6DQUMO16YrIFuoO0NG6RGKMNFFVt/qsbcOWEm9bguk98MI
	kNGZJOkNswwE/aH/aD7JCkp66DLORhTl6BuYZx6NWPWIJhM04Y9vFqmDOkyN
X-Gm-Gg: ASbGncsuWbX8zlAB1/2bPfKBEbU0C7WADuLFT6tAnTFkdV1kaxluNiiKlNtqVSrCz4+
	pk8HFSVugK7whweyTU/cHPGiLQWNjqtLQxKuSpvOmGDZKwQ7xlEuzcbWfbjC4mygwKE94V5Bdwk
	JNrM5iHLChvx6b+7Vzy5OW+JbKZ6E21aYlrNEgGWtCXXPNeo/bao/28x3xvZXzsThNu3rnWE9m7
	m8jeN3B7U/qpeWcFcKqszdc1E1Tw+aAkEQuRARjGT1EWxPHllRaiAzTfdu7DJGJ3Q0GrfrPaP+c
	ioTn3SqEtuqL5yGtz42n4gEUKRyMnfXu1FHuU0RsQDdsNPuITwfd8GRRsgBGLo8OiKjnhOXIxB+
	NxW57xaDUa0LSlN4ONcrR2UBR0GV2tiDhjHv+mLtdPIk=
X-Google-Smtp-Source: AGHT+IGUUow1W9RHWgrDcswCnQbDzoJQvZyLilCRmisCyeH8NamOu+V6JXATKLMsX5Bdy5T6O5mGzQ==
X-Received: by 2002:a17:90a:e7c2:b0:2ee:aed2:c15c with SMTP id 98e67ed59e1d1-2ff7cef5ce5mr19339490a91.28.1741599016487;
        Mon, 10 Mar 2025 02:30:16 -0700 (PDT)
Received: from setsuna.localnet (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f98esm72725035ad.155.2025.03.10.02.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 02:30:16 -0700 (PDT)
From: James Calligeros <jcalligeros99@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
 Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Shi Fu <shifu0704@thundersoft.com>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Martin =?UTF-8?B?UG92acWhZXI=?= <povik+lin@cutebit.org>,
 Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 asahi@lists.linux.dev, linux-hwmon@vger.kernel.org
Subject:
 Re: [PATCH v3 17/20] ASoC: dt-bindings: tas2770: add flags for SDOUT pulldown
 and zero-fill
Date: Mon, 10 Mar 2025 19:30:07 +1000
Message-ID: <5996925.DvuYhMxLoT@setsuna>
In-Reply-To: <20250307205156.GA583954-robh@kernel.org>
References:
 <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
 <CAHgNfTxS1Q4PPsw520-J4Yn6xg+QZOYFkYhg5yv-uZFu5waN_g@mail.gmail.com>
 <20250307205156.GA583954-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Sat, Mar 8, 2025 at 6:51=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
> How would it work when you need a mask? "dai-tdm-slot-tx-mask" is
> enough?

The existing TX/RX slot masks are used to control which slots the codec
is operating on, AIUI. I don't know if it makes sense to alter how codecs
deal with this. Could we combine the suggested dai-tdm-slot-tx-idle
with an optional dai-tdm-slot-tx-idle-mask property? From the machine
driver's perspective, the API would then be similar to the existing
set_tdm_slot ops. The current downstream macaudio machine driver builds
its links by allowing multiple codecs and CPUs to be linked to a DAI,
like so:

dai-link@0 {
	cpu {
		sound-dai =3D <&cpu0>, <&cpu1>;
	};
	codec {
		sound-dai =3D <&speaker0>,
			  ...,
			  <&speaker6>;
	};
};

In this case, the codec-specific mask property was added so that a mask
could be applied to a specific codec rather than the whole dai, however
from upstream drivers tt looks like the way this should be handled is to
have "dai-tdm-slot-tx-idle-mask-n" properties at the dai level, then have
the machine driver set the mask for the appropriate codec during setup. So
for macaudio, assuming speaker5 requires this zerofill mask, we would
have something like this:

dai-link@0 {
	cpu {
		sound-dai =3D <&cpu0>, <&cpu1>;
	};
	codec {
		sound-dai =3D <&speaker0>,
			  ...,
			  <&speaker6>;
	};
	/* equivalent to ti,sdout-force-zero-mask =3D <0xf0f0f0> */
	dai-tdm-slot-tx-idle-mode-5 =3D "zerofill";
	/* should this be an array like the slot masks? */
	dai-tdm-slot-tx-idle-mask-5 =3D <0xf0f0f0>;
};

The machine driver then calls something like
snd_soc_dai_set_tdm_idle(speaker5_dai, SND_SOC_TDM_IDLE_MODE_ZEROFILL,
		SND_SOC_TDM_IDLE_MODE_NONE, tx_idle_mask, 0);
and the codec driver deals with it however it needs to.

Regards,
James




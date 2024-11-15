Return-Path: <linux-kernel+bounces-410208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D229CD649
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 05:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6AF282A51
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 04:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB0D16F8F5;
	Fri, 15 Nov 2024 04:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDmF88xy"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214313BB22;
	Fri, 15 Nov 2024 04:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731645965; cv=none; b=o1aUo1r228aFpu0tIQx9IFn14dh6crrfh4DWJ+Ah/jcmdzXpm/ZgxgKLmXrjM3b5NO7D1PvjS+/xLtbXvGoDdTE9gzSWVeb2U7IrMugwqmSSMGofHywIRHe5J4kq5k70IpJjwmBKnQCXHGCO0C2CAgCOj9kiUb5rFHL2e5Hsrzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731645965; c=relaxed/simple;
	bh=b6cnIcR9AC6nzmjvRca5WRqdJjKrJ0vBDKQL0Z6aTxY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FDkhXLwnH8MJX7e4APQk23dZTQX2HeaalJTtn7ea3x4BdwffbF+7Ao9vaY2hKhBbSxXFgwABBrUjtg9+zFB2L7g8oVxHDkh6292Cg/6xcXInuFgZ1fLPj9XFQQWMeeLVo59KnSoEY6q+vuYqJFC2NabvZidOlA1ONAPJvk48PhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDmF88xy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43152b79d25so2455535e9.1;
        Thu, 14 Nov 2024 20:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731645962; x=1732250762; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6cnIcR9AC6nzmjvRca5WRqdJjKrJ0vBDKQL0Z6aTxY=;
        b=GDmF88xyF9EOP+jUqJZRaDxMUVL7QMrR66AX4+hkMYz/S52n5yKaVTom9JsWSos0dc
         0NG3GNlspORv9WTX6btt+m0Ny8Qvb9xWwsdySu2GXGjsK6CqWH2e2eGwtZOxg2NvDkA5
         +XOvz/b7jWVn+qbbkyDeSDctTZGf4db9otNInWTAgOyPEfoR0pYBOO4iNUFgortK026b
         s/f8yhuQeIqwuLdqrmN9jImK27Lk0OfPG0Vo4x1ho4xURlcNmMknSYXMaf8LN28BdfDk
         5/o/+vV71ObN1Y4OyyKqSSyXirxCHq9uPpWm80cSwZluX8cwGZ3bt5Al+/ig8f8LJ6ko
         ldIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731645962; x=1732250762;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6cnIcR9AC6nzmjvRca5WRqdJjKrJ0vBDKQL0Z6aTxY=;
        b=ufocwzm5PiosOjepW/kRMoNGZ3SwCCY1HV/m8GWaRNM4ViupLsrUu8ClLANp++Ft2g
         5wUbQHXcndL9JJkoCjllfWGeSAmjxdaWv6maA9Q7mwSkQHYt4h+DCpsF6gKfRha9ye2w
         ABaSte18JbfsD4kZvCnjif4GcFi+1QWaOleVGPR5w93d0b8D8wNjKa/ToDsgfcwMwAVG
         6X4v1rJH2SzOenXJKdOPA2NrWlBSiiZnP6TzgmtYXtWqtjOh5COwaMOl+xCL4coVL9jj
         ZuuoMTTgzR8od/seKq+Jv7j/9HDvywwEdQ2BgWM1kcyl7qzl8wYPy0A8mo4K3WhbqFdc
         KTNA==
X-Forwarded-Encrypted: i=1; AJvYcCUFb98pY0pH6JtuSLwZcFAC6JkK4RaQ2W36ZUyIqZoFOq1WlUcH13ANdmcht+V91RGEDc5r+4GHwX1/U+s=@vger.kernel.org, AJvYcCWuVfnWTJ2mvP1xk9YFcvKfilJ5p9B3Fgkaw8tuBnL/M+2aiii1UlkIsgFBY4b7xR0I85ZyNCRaEKFlXZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWPumaSyCDmv4JcaxV1MQHV/3mRYZjZZ4VV/AmczkaKOK/Xf02
	o9HyLmLywe6X+rHarOzGmyrBSG1N2QwnqfiSEgWUaTv6/UZ6MOuO
X-Google-Smtp-Source: AGHT+IFIkM3N7uR+57CBPb5QyrqE0zz7iKfeepuoTkyWlne4HGbZA/Xv0wuEiFveDKiT7rbnj39vaQ==
X-Received: by 2002:a05:600c:4eca:b0:42c:b037:5f9d with SMTP id 5b1f17b1804b1-432df71e782mr9727565e9.3.1731645962062;
        Thu, 14 Nov 2024 20:46:02 -0800 (PST)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab80ad9sm40454045e9.25.2024.11.14.20.45.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2024 20:46:01 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [RESEND v2] ASoC: hdmi-codec: reorder channel allocation list
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <ZzXiJIyf8Iyb7f50@finisterre.sirena.org.uk>
Date: Fri, 15 Nov 2024 08:45:48 +0400
Cc: Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Matthias Reichl <hias@horus.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Jani Nikula <jani.nikula@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A5A3A740-7FB3-42BC-A723-2648ECE959C6@gmail.com>
References: <7697010E-E0F2-419F-8378-FC3E491EE1E4@gmail.com>
 <ZzXiJIyf8Iyb7f50@finisterre.sirena.org.uk>
To: Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3826.200.121)

> On 14 Nov 2024, at 3:42=E2=80=AFpm, Mark Brown <broonie@kernel.org> =
wrote:
>=20
> On Tue, Nov 12, 2024 at 09:07:00AM +0400, Christian Hewitt wrote:
>> From: Jonas Karlman <jonas@kwiboo.se>
>>=20
>> The ordering in hdmi_codec_get_ch_alloc_table_idx() results in
>> wrong channel allocation for a number of cases, e.g. when ELD
>> reports FL|FR|LFE|FC|RL|RR or FL|FR|LFE|FC|RL|RR|RC|RLC|RRC:
>=20
> This doesn't apply against current code, please check and resend.
>=20
> Applying: ASoC: hdmi-codec: reorder channel allocation list
> error: corrupt patch at line 6
> error: could not build fake ancestor
> Patch failed at 0004 ASoC: hdmi-codec: reorder channel allocation list

Looks like mail client =E2=80=98resend=E2=80=99 broke the patch, =
apologies. I=E2=80=99ve sent
a v3 to the list to ensure it=E2=80=99s distinct and formatted =
correctly.

CH.=


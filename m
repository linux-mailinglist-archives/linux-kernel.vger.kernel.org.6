Return-Path: <linux-kernel+bounces-568913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6952A69C03
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B99118916AF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBF321C18D;
	Wed, 19 Mar 2025 22:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kGCfwt6G"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A8C207E02;
	Wed, 19 Mar 2025 22:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742423213; cv=none; b=rGufaM0KcDL6gLM9XAt37HbuVyCB6xXBK+pi5zekJvfV6wi3yqJxDG28ahmXZKuTrOiuDj7GnnClGgBY/pBpo/r2M3tgb6jxk2iDn1HUtfd2kAu5IY3RtrwY0WRJcEn2wz0kKoJ3KoKvQCCN2Svf4JcAXon07J4XDKkupNd+O/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742423213; c=relaxed/simple;
	bh=NNyfmeKR/anLn346wanRuU0a869h+kzpQmtcgRy8IFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tt0UPwQzewJflARxfJikOZOMt+NzcQMNbx4JDUFcINwk5lNJ75mj9Ntdh8kEoux8gL/EiAUU26R/LGg++CtEPgSDdGYwG2ga7ed1zTXXRnbWPGvlOBpkogDpqIq895VQk5TWJ/Qcf3IcK4hdNRkzAOz5D+4PFdKb+f2WwhePQh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=kGCfwt6G; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2260c91576aso936335ad.3;
        Wed, 19 Mar 2025 15:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1742423211; x=1743028011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hh0lbU+Oo2lQ3Bjxsb/KHgcQpBxKm0dV99RGXCT0+I0=;
        b=kGCfwt6GBj/Jbmw9t0Pao10xzFhA7wF/4LljuvrreiwcRkH/mtsWfzFBaSzBsCpSpc
         7cga3V7P0EM0KscvvKhP17svqOmZayaKmeomWtGWenb2J4IbIVhFJwcSMyjRr8WMG21G
         NR1+nf2eRxtn9vFWxYCTCXMHRitzwiN4I0HOos7nHkUHIPIlPty94V6LkHqK79TKdj3Y
         ivxsl6n79nXAei5+gz8vjG8dmDuZI5cuUn7pdrUNbEChFTmY3TFDd/SO+sQkZbv9GwWd
         gTqK8rRObPs33afOj/wNT9HsR2wvyxpCKVzyruuRZ4PwVgDB/AcKDIJ1Jo4IHxB/qa2z
         Qe/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742423211; x=1743028011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hh0lbU+Oo2lQ3Bjxsb/KHgcQpBxKm0dV99RGXCT0+I0=;
        b=d8xEwMtWlxUYBEWmhAcyfFB2LXJT9yw56G3jDi7/0fjo858oryQj1Axsv8eQFqjfkx
         UO0rb88xCsa+MobW2Jo1p9FX0Q2RjydQumXk2XRj5gLrq+1MZqv9pdUo0Jq78Mqk0+Lf
         dIChyFCXnUsNY+VL5nMFzNZLAYWkRPyfAtRY6mQD2NQD0jeMZJQjZVuCyQ3WMRSzYLUY
         g6kaGUACZHFnYiSB16kgHmuPFg80YxKhj4TNFqbmrVvFqO3VNcvDljwJGyzHcJOQvDaA
         GENhsXzXr8Z0m9jy94BbGnQJXhhuqu8c+VWCkBb5m73aQzlWznv9vXf2H8NLW6oB9SaT
         1Ykw==
X-Forwarded-Encrypted: i=1; AJvYcCWVI87OY+m0gCXIsrPBoaTLexgOgUSRVZ7pSArOhv7Hzhy0avi8mRRrtOZ0OwNxqDhVP03Ek2kV810h69y7@vger.kernel.org, AJvYcCXXWC0bASxMkSJMLsF75qoAWK/DqHkL3q4+t2jWPEf2ez2M3mkCUTUneCYYtpQSC61IzEv+glyqtZGz@vger.kernel.org
X-Gm-Message-State: AOJu0YzlwcLt9Osruc0h6j1POjSqdN5MVRuGKdHR2ypNL7PPeKnJ5/uk
	wTjS+kaQgAjH8ZFG1uMcYrrNBiZF6EhMdwYkJyhJ0Ef3tRaW6BkFRD1T5mRfdeR1Mv4oKB53pni
	IaTKzKvuArYypa98mkqep98/br6Q=
X-Gm-Gg: ASbGnctqe6T+4DE4o00Nu0rEUWY+EEfyQmmgBFYpCq1hlbqlyX26okrlk+zsmaOIN15
	FnhFHvev7AMiblGSCKEzYrJh1hWbQyNu25YPbjHKQ4bnCyk0XEbbpD0GGs0V5ftQjKtfG+xsztY
	pE62SBNLW/n4DyugZdPtyvGkrYSCl8oog4sMfHfwIoc7mDYeMv9n676mSE1aU=
X-Google-Smtp-Source: AGHT+IFcGyOMikyVY9qlKdXwGdd+iPF7PAzU5/0LwXwsIYEBQl9meRAr7922jpsZNYH0Rdr8c3tSS8XVX+XEZrjW3nY=
X-Received: by 2002:a17:902:d54a:b0:223:6657:5001 with SMTP id
 d9443c01a7336-22649c8fe35mr84587625ad.40.1742423211163; Wed, 19 Mar 2025
 15:26:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-ugoos-am3-v2-0-422104b0cec5@posteo.net> <20250314-ugoos-am3-v2-2-422104b0cec5@posteo.net>
In-Reply-To: <20250314-ugoos-am3-v2-2-422104b0cec5@posteo.net>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 19 Mar 2025 23:26:40 +0100
X-Gm-Features: AQ5f1JpGPU3zshV1sBp8v7DgL1EJjYt8fZcN-H0O1bb1f4rALS8YmKAYBWD29tg
Message-ID: <CAFBinCA1wa89vSo0TOs5yZWg_Fs8gt5vUerjhSNFAHMkANy6GQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: amlogic: Add Ugoos AM3
To: j.ne@posteo.net
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 12:11=E2=80=AFAM J. Neusch=C3=A4fer via B4 Relay
<devnull+j.ne.posteo.net@kernel.org> wrote:
>
> From: "J. Neusch=C3=A4fer" <j.ne@posteo.net>
>
> The Ugoos AM3 is a small set-top box based on the Amlogic S912 SoC,
> with a board design that is very close to the Q20x development boards.
> The MMC max-frequency properties are copied from the downstream device
> tree.
>
>   https://ugoos.com/ugoos-am3-16g
>
> The following functionality has been tested and is known to work:
>  - debug serial port
>  - "update" button inside the case
>  - USB host mode, on all three ports
>  - HDMI video/audio output
>  - eMMC, MicroSD, and SDIO WLAN
>  - S/PDIF audio output
>  - Ethernet
>  - Infrared remote control input
>
> The following functionality doesn't seem to work:
>  - USB role switching and device mode on the "OTG" port
>  - case LED
>
> Signed-off-by: J. Neusch=C3=A4fer <j.ne@posteo.net>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


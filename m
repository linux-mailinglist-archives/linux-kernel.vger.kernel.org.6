Return-Path: <linux-kernel+bounces-516334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59209A36FC2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 18:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C3C3B07EB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B7D1EDA16;
	Sat, 15 Feb 2025 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b="upQVhLhy"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FE71EDA19
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739640290; cv=none; b=PBfvEZ0xq88CIwCePngZKeF1HUaGf6HgKNEz6T8wmPywOJFU2R3GCSuhpOpP5g4nxq5WLNTGVoFGv+wnRy5z/BFW5nMXedAtupqlrReVgKVNfVeGugaIoUzBg8BakfIoTRrzm2DjcqCk8EswAbydN7F6b9BmmI3R2y+KsRGtNjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739640290; c=relaxed/simple;
	bh=teKQ4hdjN7BYX7EoxvrsCHltx1se2slKk6pRdKtxyvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IvIyOoBaj3pZbP6DyVjXFAfd4oqS8C8QhoTdmcLigL5gRuIcFARFlRLsZ8yNYb7GZpYtoSs4to8L4EAa7rUualHooeWxFlb5TWguaMWUMZUjifTAfhvBv9N2VJpev92uOcal3NmBJtGK4gPIFmYcJKUuZLmogQxY6Vh8H3Lq018=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b=upQVhLhy; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab7e3d0921bso550693466b.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 09:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=google; t=1739640287; x=1740245087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEbvPfbzlqpfyi/ZuM8Sn6es2AIq+nlH6qd/TbLpx0Q=;
        b=upQVhLhy5Bl/GTttGIKOuzvK/L/50AttRV7rT8SDHkSt96BZNuIsUheLsTm97SW2v/
         aQx+dB9P/OKJFLdzB42gwocfTjdQ+MjPjl00Wl4CRiScD3NvlFreYPKzpWyj4ViOgJU4
         d64yFC1RDVQ5Y2eZkksizIzGsXqUeDwTTZ0/VJ+ddQlagLZyBWL6A5YTwCLio03i18zm
         cpbzGQ0Z9/e3KyXhsTpRvaR7HXZU84Pikh2uWLPoArrrGVmhig2jeEcPO5ubwwMqELRf
         HNMmBxFStSsACgVRc2btnWqI11RdR6PTxgv3EWTw5jwKuFyfYZM/0ocl6q8VbNVNbEiA
         KO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739640287; x=1740245087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEbvPfbzlqpfyi/ZuM8Sn6es2AIq+nlH6qd/TbLpx0Q=;
        b=ZM5MY1zEl/lgJnzi+u7I5qJbrKidpc0mcGorz8jk+vosQgEy329qKt3/F+n6jCCnun
         RvVjIq0Rjk26FqPHa4gOSohFx386BJ01P19B4dAjBvfxPKsET7lznCYqq1bLmHftwA8+
         7ku6GhdMmpGDRrou2WTQIa6nrgn01PS/UxGuycjZ3fqu0j7P5A6RR29MWkKfUNR/ZHWe
         TqGPt0IIt5rqzG0OBwUHXui69XMzVyCf/+GqqrxlMGU2H3+6wBPG/vz0pwy3iVDasdjD
         weyrumOrWdZHACHGw5JB19598Wz+yqtRY8LFhUWM+bfOlpWVq/ke4n6v9ClPkn3y1Efv
         HdYg==
X-Forwarded-Encrypted: i=1; AJvYcCXoyVotpQIhWGXwnvmRaV+IuEzaEUUi7mS/BkuPdbba9Z7O/HgsLcQT3W0KOTchqQO6yA1ckB0ApPyPFrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz6w+Pfs9YS5kvP0oGmBmOCf/rm9Otsx6NWa29muwI4G/7iluq
	T84K39PoxotS3sA4ZprrVQ+VUZchxdtFd4h7KhvwJ5uyMDtiUlojpckXXvqBCbQvifKN3d26ve5
	6MPZojjuWVBDiYcGSb9JIdzBILjUGnNr+DkvnJA==
X-Gm-Gg: ASbGncuwDll8qRYkZSR1PLPifEI1p+3RhGSUn0+HSZiaRb8QkCBf5FmRlbV64DJcOsA
	jm2c/kj7zbdiCZ9dSjW+G4oCwCHJg2jNP+Fl6CQz8OSWS7vozsK/3LFFwoH4xWRg+a6+38KG8
X-Google-Smtp-Source: AGHT+IHpM1eqc8tlYMhaHVIvfcF2/sov/Rb7t32A/3fz4T8tN5Lqj5CbXTDRT00b6qYe7eMIRGaa1Dgm4UxTcOcxbsM=
X-Received: by 2002:a17:906:c153:b0:ab7:c3d4:2551 with SMTP id
 a640c23a62f3a-abb70dde461mr387599866b.33.1739640286846; Sat, 15 Feb 2025
 09:24:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250215075701.840225877@linuxfoundation.org>
In-Reply-To: <20250215075701.840225877@linuxfoundation.org>
From: Slade Watkins <srw@sladewatkins.net>
Date: Sat, 15 Feb 2025 12:24:35 -0500
X-Gm-Features: AWEUYZlLRXmnBt-692KO7vYcJFwLxQMOVLPLKrHkNbf4YYJGv_M_v-aJo302zFo
Message-ID: <CA+pv=HP-_uNh=Tdx4L30uN2TUO8K2pN2adYoXs_1HH=ScG0t2A@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/418] 6.12.14-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 2:59=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.14 release.
> There are 418 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 17 Feb 2025 07:52:41 +0000.
> Anything received after that time might be too late.

Hi Greg,
No regressions or any sort of issues to speak of. Builds fine on my
x86_64 test machine.

Tested-by: Slade Watkins <srw@sladewatkins.net>

All the best,
Slade


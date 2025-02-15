Return-Path: <linux-kernel+bounces-516335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EF7A36FC3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 18:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C7C16FA96
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D02C1EA7D4;
	Sat, 15 Feb 2025 17:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b="aBsnKVA9"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC9C1E5B94
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739640353; cv=none; b=p9gHjSPadH/+G3QyNNv6LikM6VPCkrgJk2FouCTN1eWgtCIEkmsNNtlREMuEvQBbXb97v3zyNwelZH6SaDkhIBqsMzQkUuB7Rbe/P57lKmmOuDJtJaWTzGZaw75LYesKhI06uDUQ/J/CUwwPmxQ6AoAWk9RRyVRLaDzcsf54Cno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739640353; c=relaxed/simple;
	bh=bWdwc4tU+jS/WtyYL5ZUs1E6ELOzM9Zd3g3hT2CGL20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMlhnTsIZGiTBuq/wuuaB7UTAKiHUqI3Ihhvg7UJ1tEZ14g3GF5AOU/qejMvAf5TwqXUD7DS2VZUJiMDz+Dv7rATCKZSGzNBmugSCC27BtCAm9lBrumdMIuN1hctrHKuQRfG0FE8ppe5JaztEuR3Mz/BvcE5MLLALTpkbRdQihk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b=aBsnKVA9; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5ded368fcd9so3643658a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 09:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=google; t=1739640350; x=1740245150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHP8LGPaE55AxKwpSHf5L42NI3V/KQU7zbKAocoI1Fw=;
        b=aBsnKVA9ag9LC6n5ANYZdb5zeLf2sQJlZ+LXg/4VdFDaiYs/T8fBRNEzptsFRJVE4T
         bGmMd88mjEIZTAJbYq+HxsAcVaFXLAFHmHnoSyRDRzuGg7omEvSqbDdCqGDB8WHXr6ot
         DiWS7YqXH60NCiEYU+EU3G/whlQtUlwskc1tigiVVQ5s927i2Wk+95DsHJJ7JLNdY/Kk
         4a3YZPlqFJ1t5+6MZTvabV/pDGzsK9HXKvEcrWl3AhyNNsUUZOzVnNau6Vfj/+LQT2pH
         R5OM/XSE9KwE7UbZE5CcYqh49lzIKuuuReZbW7u8az1A0Vv1wzFUnXuuzLaI55WB9B38
         Rs5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739640350; x=1740245150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHP8LGPaE55AxKwpSHf5L42NI3V/KQU7zbKAocoI1Fw=;
        b=Nuhl886OPSABj0VYTznNjjw2fWqk/MXKHghORmRq0ovau8Gi0BhmLj6G4Q2rzHbNe0
         V1aGAwzWn1gyFTru4scYA2IYmWCB78ocsYnVI6wNadT0ryvdArRI3pN8kUWdENV8USnI
         bIWs4ysyh9A++pk9UQskITeFHeFycrMb2AUdlzYeg24ozB351E20VhWmuwPEldW2kKWH
         ghe5tlowgabRae4JMQe3uEp4L03GfkhO65kAFoRTpnjKr60hTQwky9UMaIuE41CBXfxe
         nOxlcMtz9366U3O84N9agvj3KKAuXZ4JkgCKjdgFt+2NNRE276Qsxvl8sClm9TyJCr4g
         Y79w==
X-Forwarded-Encrypted: i=1; AJvYcCV+FpoEgtUWMAYkXiUDAOjsOVnY7TCfvkEABAl7horpOD6gz96+eYFAcIX97WqWp9RGv7sACeAlEzpCIFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLnQ+a8i0RRt+4lIYkhQzYIYg5MqL111oMea0iHnrVApmz/en0
	7Ps2xHbtjOZ8Xtyckbd3x3O/eaK8RaJjd6dlbe5dd+FOROgp1XCV6CEcghXjskdvr0RJa32p4Uk
	mkAtgt+HL2X7kf6rjFMfXC2c+xuDshT+88vchWw==
X-Gm-Gg: ASbGncuNeyIJ1jYHjq1je4Yr1fphDq/SXYG1fiDRtonE9YHzUagcfPxCWUYyZX1zq9x
	uCk2DCnW0sU+j3/ddcs9aoO3kwciGT5NT1MnuRYhnaDfzFq2l20QnTRbIyk77ZOPAoPGyTk3b
X-Google-Smtp-Source: AGHT+IHJzLjc0Mpd+v0lswpn7DhJ2tM9BZti1csqHDT4yfjUQZtHYKVsAb7uI+EuHhv1xXJViJSu9WBUuDD1SVw30Wc=
X-Received: by 2002:a17:907:1c21:b0:ab6:fd1d:ef6b with SMTP id
 a640c23a62f3a-abb70bad34amr363614966b.27.1739640349746; Sat, 15 Feb 2025
 09:25:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250215075925.888236411@linuxfoundation.org>
In-Reply-To: <20250215075925.888236411@linuxfoundation.org>
From: Slade Watkins <srw@sladewatkins.net>
Date: Sat, 15 Feb 2025 12:25:38 -0500
X-Gm-Features: AWEUYZkvqJ1y-XsnBU_Lwvy2M4G3bDMXGE9SW7Ow2NVPM6dh7UJTVqGNeXXm7gM
Message-ID: <CA+pv=HOEzqtotB8hp4ikj_q7NWFB334CgPUT5BwYi2Re877dpA@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/442] 6.13.3-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 3:00=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.3 release.
> There are 442 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 17 Feb 2025 07:57:54 +0000.
> Anything received after that time might be too late.

Hi Greg,
No regressions or any sort of issues to speak of. Builds fine on my
x86_64 test machine.

Tested-by: Slade Watkins <srw@sladewatkins.net>

All the best,
Slade


Return-Path: <linux-kernel+bounces-521689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E97A3C0EF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF5B172DFC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1F21F5616;
	Wed, 19 Feb 2025 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlzi1D6z"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2A61EFF87;
	Wed, 19 Feb 2025 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973238; cv=none; b=mvM8HXAQ9qAKobtOdN9cbEMUCgXwtx6Q5V/LyHN3vg3juaf9k5sR6azsv9q2ybPtbxYZjwVz57ejODJ4HW6NUoJTfMmLNQQtduvb1sd+lKpxhge0q0IIGj2LJt42Ct3TLr6nbOqaBolkTvPLxX9E5futZVl7Xn6AjvzOTuc3bxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973238; c=relaxed/simple;
	bh=EBGIkFOMA3Q9uBedxQ7Ytmbg+ijF5b4a8hOe1QEXg2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IRlNgDVd6PTLhpt7sfnd8RBrv8j6KfE0t4YzbEyMxy6VpNmPtStF6swzNFH9qngTZdPAVmHCbMA6b0WtjabxQ0CBMa2IpkibdDVnaGfr9zYfl89K+QCb9Tk7zcn7TycAq/mdMWroCmfas1OLKQUuSYXipoUj/0OSKdmXeG2KfoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlzi1D6z; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-543cc81ddebso7005377e87.1;
        Wed, 19 Feb 2025 05:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739973234; x=1740578034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6t37BQHYg5C29qODMPAidihVqNJ54EsapTzOiph9W0=;
        b=dlzi1D6zZUzgoeYTFEcMSeq8gt96XSkCTevnMk7z+T/2i8BJiFxYPIiie6jhFYv4TT
         ShuyGEhT4MsWQTXW3rOZh/x7T0B8zSFoRoS59/jh2GYdRa4FKaN3YCJKXYf5zg9jXgxA
         ks+q41vyUNor/IjwgbDiHjTEAhJjzFCXiYSyOsz/U/o7/qA/6+mYbRXFzMMiTBTrVC2q
         HvjiRnv4JEzg8DSvIb5E4mSxlUA/Plm4I6lsyT9Cj7QoOUTPm1niGSexnMvloonARwK/
         jVap6QKWWm1ZcnhUDJoeTn0EndNeEtv6Lkb5wG4/DPnGVywC0UzNRgimUW2lJ1JHP6xf
         thUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739973234; x=1740578034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6t37BQHYg5C29qODMPAidihVqNJ54EsapTzOiph9W0=;
        b=T/FIoZkHynHESNZL3VAmo6xOx9i6kYS7x/Y9PAGJKJCvTO7cJkZx25uwoEouA8+A/Y
         UZLUUJjWLPQ6PBEP6o8m9+J+fpyvdDCVMxSTQD+4bu1cZkGhVXATdbGDvQnHlMKp+FU4
         R/mAckEIlxtatsx6EJtujYFk0IjXZl8yXTz2NrpIzRTL2jT7tksUcScsohGW3TQ5EI2Y
         epiRFuANmT8nQ4N5gh4e3Dfu+lbxVl14W/OcNQ4lfumCDESjeNlmk+dm1kGbzQc0lTCA
         nmR0E7jp06cgZEuU6Crn01DSHDa0WGrht3OC+wTKUiMPwmMTPH/IQfa7fkmAAzKvcZ8F
         V/Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUX8StiitTbRqlmSI8WQz5eFzrO8YRkuceM76COvx9Q/ByrHrqn/Ml3AicVSbE6lWKV8vDedkvp34OY@vger.kernel.org, AJvYcCV7ECdha9iRFqp//jP+xw+MGAK5gsSQKpW9KFouE/bpuOJhAgWqafSiuQjqLVMD+W4gwNn4say04Ru3yWFi@vger.kernel.org, AJvYcCXLExsfHhXPv8uyMlm0IgvJYHF9jD6i+GM5MK8xJYFkglqSVfstDxp4LKdSr8dWZC+1y/8+OfqCNSc5Oj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7GttdBr0dmg4E7SuFeePv2CPAaSqmRDqAjh26XOfCivvDkHd+
	vAab81FQp6sbx/d0J9m4cZzs/vftNxNRPeSS7fbC18oNcaje8OahUUtPyVL5dZ409AsezeCToec
	evRYvyiDWkt1lEOJk/mZYBsH2WfI=
X-Gm-Gg: ASbGnctdhFLVWc37ZJJvxSPUi6GOKfG2K5HTeGq8BnxbPwrlu7Mn056v+4OaxQcohMj
	J6zzJVl5NR5TUXwnJSRa6ZmZN2t/V4ha75AVE3VLCU3+YLVd+6ObaLPvRLfBEToIGGHz7KIeRpj
	vMuLbmICo1wxo+oeeGDKEUmQPRTos=
X-Google-Smtp-Source: AGHT+IEfa6BU1Og4EYBhPdGzQ8AbNlSEs40TcyE4AyfYRci4Yh7JUHFGkcpocxJ2mslPN8Wgy1hRW5VA2U7L8Kutmic=
X-Received: by 2002:a05:6512:3b9e:b0:545:2f6e:32fa with SMTP id
 2adb3069b0e04-5452fe55430mr5275021e87.21.1739973234258; Wed, 19 Feb 2025
 05:53:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219133221.2641041-1-florin.leotescu@oss.nxp.com> <20250219133221.2641041-4-florin.leotescu@oss.nxp.com>
In-Reply-To: <20250219133221.2641041-4-florin.leotescu@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 19 Feb 2025 10:53:42 -0300
X-Gm-Features: AWEUYZkJFhBHdwEt5veSqP7xF0ysRoigYMPW5u1lRGmZYIM_SaXIS4HOYQ74S6A
Message-ID: <CAOMZO5AfsHqyo3a+hmfprOnNJEzMzC81GuzBxtrt_F9cHufAtg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: hwmon: emc2305: Add YAML binding
 documentation for emc2305 driver
To: florin.leotescu@oss.nxp.com
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Shych <michaelsh@nvidia.com>, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	viorel.suman@nxp.com, carlos.song@nxp.com, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	Florin Leotescu <florin.leotescu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 10:26=E2=80=AFAM <florin.leotescu@oss.nxp.com> wrot=
e:

> +description: |
> +  The driver implements support for Microchip EMC2301/2/3/5 PWM Fan Cont=
roller.
> +  The EMC2301 Fan Controller supports only one controlled PWM fan channe=
l.
> +  The EMC2305 Fan Controller supports up to 5 independently
> +  controlled PWM fan drives.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - hwmon,emc2301

As Microchip is the manufacturer, this should be: microchip,emc2301


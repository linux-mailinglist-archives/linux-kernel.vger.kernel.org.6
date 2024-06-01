Return-Path: <linux-kernel+bounces-197970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D767D8D715F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 19:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112851C20BAD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 17:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE7F154BFA;
	Sat,  1 Jun 2024 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDB6tsHt"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B733915219B;
	Sat,  1 Jun 2024 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717263717; cv=none; b=lWlCxYRKcB5m++B8ur+q90EhkEfY4owFfBXKj195KIQmuQkc5uQiK3kzzw/WCsEj9x3OjoFqBBONp+Wq2c69uID57dE8jGCerjZjR1GqEkZA48S8REyMS6xPxxWMfBNSOq/0V3lIxTBn0AZ/FMR33+q75WaS3C3f715E9w83m+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717263717; c=relaxed/simple;
	bh=bsEyydaAYT9XXqTl8bsO2MRBf0XUN2C/EVIikHgV+r0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVZnKvLZ1s35G80BSc4NgEJuiuFBL6/8xexFuCezAEeqXVFxGycHVx0fhEPu8mNko1zChmxIvp/rMVcOF69nF+A4N8GEp97kHqab3eFbT1WUMdl/gg42cZ9wOoeCWohNOHBY6SxqUkW3b4JBGR9I7IjQvicr9lfSetsaB43xhtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDB6tsHt; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6c53be088b1so214015a12.1;
        Sat, 01 Jun 2024 10:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717263716; x=1717868516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsEyydaAYT9XXqTl8bsO2MRBf0XUN2C/EVIikHgV+r0=;
        b=ZDB6tsHt7AIz4zxPE3ij4PT9eLVr0iGKE+xDIosb/+uUzUw3/BUavh27aWvGzDsv+5
         avRA8BSt6gMZQs8TrFqXftjoNJJGecITpnck7N32iahVagOivtoDSRZ6vWyiFmIbVsvG
         6zgQ9tR2LvYiRHD4q9J0nYIaIa9k81SQtD/21NU6c2n2Fa16WyBdqTD9UhU/gCbZdqW8
         M9UVWoOktHQRhQyU1XZtbqYF5GEfw4mJZQiufpPXgPc2+le+BL/Xg5WF9Q+m0NDjfNoi
         1RLJf5Nh1GZPUH+rrmuYYBdODoyi+ygxoqoUZAOgvzzVibdvlFrHHs6P5TJf53gyCh8m
         X91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717263716; x=1717868516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsEyydaAYT9XXqTl8bsO2MRBf0XUN2C/EVIikHgV+r0=;
        b=FA7dWcxmuWu1VDhtHm+rLtk/oLRymvvaBFuBWhxQta/QgzR6jN5Wxb260hES2AEOj1
         LfhvXlAb/PjvZbxpXIbon3GL19OKXgQAokNxILbvYH1KWuXrQwvW8Om9FGBEKQ7mVkU6
         39wQ3Es4EoAx8P1dxfPSpl7DmxUp2fvzBGh9qjGOnzDwG+LHa5Y3pymit6Z/WYMkJglT
         4crpn1nZFypdAE71P1bwWnT8KCIYzKtGW42Iy/2JCqr8krdwKBuJPWjcjRPIBINxS7em
         HEMu/e941Bypp0COzlFKMonoWYjUHQpKcfwoA7W+ZCTmiMJ1InRHOe8GFyZhypY8Wamb
         +vFA==
X-Forwarded-Encrypted: i=1; AJvYcCWrteFnd3xHr9abdhAjcPs3nbEul3zwOnEz+gVaLEBNKLM+5xnLpkebOzC5FFq0t4WP8cQ7p1kVA1Z54o6S0vRWyGBY+moyf6GSgrX2U04JS9ogdqmHArD2wfgp1jC7CGacrumay/4FAg==
X-Gm-Message-State: AOJu0Yw5aM7pzitNEPxjTqGt4bucQ6rF6JCB8ToiAoKS010aZ9Pfcw7D
	uAKVaAOj7ZfxQmKAEF8/Noo9PneAnV1PubrXTUX6Vj+u55aM5wv4AtfnkzsSAHx2fzXFWj3OR9e
	mODnCJ46Tpolh7fnGLZDFzPkCPBzl4wGO
X-Google-Smtp-Source: AGHT+IGHnvmpmNTTfNUy5D8KhM5Q3tt4LuFd3aHPkPUX8XCjz3oQInk0yPU6lIldWfbHyomiGJxpxAAi2Pe+xFyTbpY=
X-Received: by 2002:a17:90b:3013:b0:2bd:e950:dfa5 with SMTP id
 98e67ed59e1d1-2c1dc5caceemr4430512a91.2.1717263715898; Sat, 01 Jun 2024
 10:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601135230.89980-1-aford173@gmail.com>
In-Reply-To: <20240601135230.89980-1-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 1 Jun 2024 14:41:44 -0300
Message-ID: <CAOMZO5CyZsHEchFuguz2q4VZcO-3qgXT2w1O97WbZZpgFVaFMA@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] arm64: dts: imx8mp-beacon-kit: Enable ADV7535 Hot
 Plug Detect
To: Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adam,

On Sat, Jun 1, 2024 at 10:52=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
e:
>
> The DSI to HDMI bridge supports hot-plug-detect.The driver
> supports shared GPIO IRQ pins, so it's save to enable them
> which allows for hot-plug detect.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>


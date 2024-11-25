Return-Path: <linux-kernel+bounces-421050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340B29D861B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F4AC166A6B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1E218A6BA;
	Mon, 25 Nov 2024 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enbChpMq"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B034B18D625;
	Mon, 25 Nov 2024 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732540501; cv=none; b=daLmwsBNCLu46V08d3pzSVnBp2BgI4YjyulGk3fqJ/rMKMm3ErpahgEnYCpEYESkZxwGRG9MuP1s/oTPz169/d5QTjD1P2kGbFqDON/OHPtkbMI3Z78DZ0at+wCm3ZgpiUkFbiGQpqrPU1jdEye+iBexdG0qmcVcblbraCKf1PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732540501; c=relaxed/simple;
	bh=29eqaOcblHE7fnrH+/9B8++CMwboxE8T+PhkUkEFlJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhUK8lb4J1erN6qPTKHkYbgD8TkAQvvKBP6n62ZlghzZrk5nX97b8YwL88apjaBckTjCXZ7/4P+X3R4rtFfBf0gSNcgd92cKqVbmlzOkYRcgF0nbuJT8RMvQfMbl6bZuVxqOjasSsRVHL8B0pelNlSAWncI7K5v995MZM/OgL5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enbChpMq; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e382589e8fdso4350389276.0;
        Mon, 25 Nov 2024 05:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732540499; x=1733145299; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=29eqaOcblHE7fnrH+/9B8++CMwboxE8T+PhkUkEFlJM=;
        b=enbChpMqfJ4SFaqr754g6RGaK4HTbTAjlXzzOZv3pSZx2P4yNrgpADX3HWolHeqAfR
         NQyBv/xwd9cIgn61SGMC2qqrMvDBNBwiWFbwBBnt/szOR+PTQC+heAL3NbYszS8kDbAT
         4TXgwr56zN3zRSdXxcTLkhcUd9CBbHsHPtlylWgelw56ji2t2rf7nWX1DIfieiHjoqWh
         b6gNYcXzpT03U6u4r54coZFDldpW+R9o+97yWtBo5cXUUTIQEYGW9MhDciqTCqYxuKY3
         7g/duX4wjBE6KVMwpi4gxiABt1Du3devB27hcq7Q30aC+lB/JeUBA6pqRjjDcuKu+ceW
         mqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732540499; x=1733145299;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=29eqaOcblHE7fnrH+/9B8++CMwboxE8T+PhkUkEFlJM=;
        b=eRo8yD6H6zDgUVigZfOpzV7B5xq1AxIBlSV1WvyDRwax6Vdr9XzCWlbnyz/Z1PsT8l
         rylsQhr8dmuOm5BPLUBvSoxopksu0va0cE72QEuJnNkOa7lZ/iYnERko+ru0IwDfMXsZ
         5xAzRuURLUOjX39QvUBOch3ctScRx+lXhO7TKO3dYGNTIRFP1Yph8V5jU9amncVH+I9z
         OFzZCm+TUfbof5/xLZlmoy8UkcjVyIoyEwchTCozAP4nnyHzfI2BjP6NWXT7Dsmv8lxe
         1jEMCbY+eN5eSJcbviPelIG2Ou02VgA+4nioRNnWJKdpnUv9DQkInh4Ccqu2yiIrqI/h
         2W7A==
X-Forwarded-Encrypted: i=1; AJvYcCUeyAZhnTvk3MJaoGlyn4kv1FaNKCWDo3/4FHIxvsrdwTqkL4CIyEbPjdqBSjBKxA8t/mtIyXeqw40Jkhvl@vger.kernel.org, AJvYcCUsrzbFoUohz74zoYyQikNj6KHtu/mBSWdaKt1hAdduXQwJz50e4H8eeal0SIP4udt0t65kTSrJF4CL@vger.kernel.org
X-Gm-Message-State: AOJu0YykX3kwDjGEoDQjyk5QMW12yJLjvUv/fFgLKyyBBDErcthBVI5d
	UK1TQq+Qi4PJuRlsJsSdmXEoAuJrLdyLJVivD9JDZxriUzfXozHAFndfDN3JWO1GCTN4ktZQr1m
	5mq5s8pQdw2dtlZd2wcQP+S8b6JM=
X-Gm-Gg: ASbGncung/4C6JQ00tRMYkMnlKd4rUDK3t5GKEfSOp2OUEYVNLSOfeOGF99GkJDyIOq
	z0uP2ZhE5Jm9LP9szrD98YaWTjiCOoSi0
X-Google-Smtp-Source: AGHT+IGfaRNCO8ZfhjsTKNxOcvugz+C7g7ey2hBA5+ko6id9//Gtggy/7MbHGZufCHhEZf6fX8TjG/HrfvyCxyamoGU=
X-Received: by 2002:a05:6902:e0f:b0:e2b:d131:f293 with SMTP id
 3f1490d57ef6-e38f8c09892mr11476595276.51.1732540498735; Mon, 25 Nov 2024
 05:14:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241124-adpdrm-v1-0-3191d8e6e49a@gmail.com> <20241124-adpdrm-v1-2-3191d8e6e49a@gmail.com>
 <10d0aa88-de2e-4856-a137-301519e58b2d@linaro.org> <CAMT+MTRWZWj=3AP7wyooXr49-W4vcm0ZbAoqPyEuNkQBMOaJfw@mail.gmail.com>
 <c6b0273f-16f3-4469-a4b8-9564f7355400@linaro.org>
In-Reply-To: <c6b0273f-16f3-4469-a4b8-9564f7355400@linaro.org>
From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Date: Mon, 25 Nov 2024 14:14:47 +0100
Message-ID: <CAMT+MTS3Nmy=RzsE4wUf=jHBsu8ghyyqpXWPyB8qoR+W3EUscw@mail.gmail.com>
Subject: Re: [PATCH 2/5] gpu: drm: adp: Add Apple Display Pipe driver
To: neil.armstrong@linaro.org
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Janne Grunau <j@jannau.net>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 13:57, <neil.armstrong@linaro.org> wrote:
>
> On 25/11/2024 12:24, Sasha Finkelstein wrote:
> > On Mon, 25 Nov 2024 at 09:50, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> >>
> >> So this controller only supports a single mode ???????
> >>
> > Most likely. On all devices it is connected to a single built-in display.
> >
> > Ack on all other changes, will be fixed for v2.
>
> OK, so instead make the panel driver return this single mode
> and from the display driver just filter out anything that's
> not ADP_SCREEN_VSIZE & ADP_SCREEN_HSIZE.

Not sure i follow, you want the mode hardcoded in the panel driver
and the controller driver to fetch and return that?


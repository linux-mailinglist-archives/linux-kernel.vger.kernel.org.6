Return-Path: <linux-kernel+bounces-394810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F779BB43A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9757B1C21414
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9761B4F29;
	Mon,  4 Nov 2024 12:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Od22BDmv"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1BE7C0BE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 12:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722201; cv=none; b=fhUSqsi9yX5xX6z5c499yNXe0prMJOGIMwnrOENhGsCt3ICIQvoWrwlgv7qCTXHtVLOlhzPPeT68a3VyW7GsGa3ldRhPL1P+I3RhfPveZwWWnmjcatefLgV6u6wVASd8r/v/+bFkFf+ix6f6Lmb3PDfrDt6+1/igfSAuEdjXbIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722201; c=relaxed/simple;
	bh=7aEHlPRrC4NOUdPPFxjLWKRbXGK7QkMpo0vxXSBf3dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkMX/vzGqXWr7Lc312TuV6geqp5jmps00dbXapARgEFWXSxLSr8vNY6Zttc0nekG0gA5SFFafxvn1/6Fmm906nDn/q3APyHYy7PzSGcHWAks9zm03uL0h5Xv4MlIE2dd57/pzuVUqG/zTNO7jMjhi7JpPmfAX6PBeP8XDUNliKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Od22BDmv; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a2cdc6f0cso623633866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 04:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730722198; x=1731326998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aEHlPRrC4NOUdPPFxjLWKRbXGK7QkMpo0vxXSBf3dw=;
        b=Od22BDmvVaViPqUuBjJSuHEfnvUV+1/8bB93OCMvpOXikZGe2b6QYU7fhx9en/Hpax
         mMI+DR2k3qGLyE/z+jipplS3E7nYfA/omFeqhWDLGHET2nfGzVHl9Mq+z81Moi7XZYIQ
         u6Q3MGV0YBTr3K2QOw7uwiyTlUCZyoHgOjDHCLJY9sn7Y1Kc7qyE+Q4WkboN66bapg2E
         xprosRr5GLcOteBPZkSHYugPbgrEOhNXbSTUNLIfoyrtC9iSjTi71DpM7fug0Yy8TbdQ
         exNmrEXNE6J+YUYg3a1UAGqHbZuCbGZJPHSFK6+s2IflNbJ93QvfGqz9IjJ4WmWc/h8I
         lyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730722198; x=1731326998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7aEHlPRrC4NOUdPPFxjLWKRbXGK7QkMpo0vxXSBf3dw=;
        b=ihpmsJLji2WKGojrWizLj5M24KvwY5ZoqMXllpAWk+z1ayK6i78raEfT4b69rRleUq
         9cxXpyEgEP+zsxugj8RXC2vqSvs78dbk9hf+89vS1KlzFPcjNqvcznhA1Uahz2ZeHhz/
         mL5InFGzzost11MFIy6DVhn2XM3FhQtagPqW3yywcpLaC9t5DMOMIR3ze7oWuQQ6IGCk
         LOMKjeXyDGfrB7S6utdOD7NjUxxsgKiYw+3j+dMZGgSIOp2l/NDLPYPIfJTTs9CE3tQR
         EdopaXsKqYlrzatGGoO/hi4uoKPvC52oLGsr/KSU1YZ1dnOZ4OqodM9UUhB5I9w8XZ8r
         gMMw==
X-Forwarded-Encrypted: i=1; AJvYcCUcrGtDGTrUYrrJ01leSmVZzm/C7IXje0uf2efsJIKkLfMzN45XEflpS4NcTMFAoeM5DgMtrjLRIbAkTUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6NPkz+jeCYzOpXTn6M4Qy3vdBLpZVxWarpnys1vWywa/uLLPD
	uQ22SBBp8WhFvsm5HIL87Hse8qTspxnxOvb6/XFghLE882MLfYQG3/KGnmImNju7G4VdDRPn3GO
	Y1vrGZBlx/rouBg20Bo+pD0i5TPE=
X-Google-Smtp-Source: AGHT+IEGMIh4+c4YieOvHOR42Mov1UsihiQ3LsJ7TD25F5Pb01l8fHd5tbR8/l7Kzokrt89RSrjZfi57fW5XXOgI0Rs=
X-Received: by 2002:a17:907:724d:b0:a9a:bbcc:5092 with SMTP id
 a640c23a62f3a-a9e50978806mr951428566b.39.1730722197690; Mon, 04 Nov 2024
 04:09:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017075725.207384-1-giedriuswork@gmail.com>
In-Reply-To: <20241017075725.207384-1-giedriuswork@gmail.com>
From: =?UTF-8?Q?Giedrius_Statkevi=C4=8Dius?= <giedriuswork@gmail.com>
Date: Mon, 4 Nov 2024 14:09:46 +0200
Message-ID: <CALt+6nqxMZjuZuOKaj8Cx4dcNZx0n-0F9aa97d-vZoMWeN=bOw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/i915/lspcon: do not hardcode settle timeout
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Kind ping.


On Thu, 17 Oct 2024 at 10:57, Giedrius Statkevi=C4=8Dius
<giedriuswork@gmail.com> wrote:
>
> Avoid hardcoding the LSPCON settle timeout because it takes a longer
> time on certain chips made by certain vendors. Use the function that
> already exists to determine the timeout.
>
> Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> Signed-off-by: Giedrius Statkevi=C4=8Dius <giedriuswork@gmail.com>


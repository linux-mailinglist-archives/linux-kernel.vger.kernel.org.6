Return-Path: <linux-kernel+bounces-368011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B22D99A09C6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69DBC1F230A8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AE3208D92;
	Wed, 16 Oct 2024 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="M6UjNCSS"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04922208D7E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729081640; cv=none; b=ZsvzkEd0bwCUoHiDB+5w6NWnmy8Nc5USr1X1GLsumYfOSBhpdXd8FWWxSTWuR3Y64UygbMoA1+LMjvSGWfplov1gpYVLiREzuXULrvOcIqnaw8jQc8x2eW5xRRo9R8gttcPHx8mKzMHKGJFz9mbMY7L5HS6FcB8P/JmPRvKOwPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729081640; c=relaxed/simple;
	bh=V2XtVEB4RpgqB/HnGsWrsfsIch7eCUj9RPKyjZ95Xuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+IqQslb9SCimBaJFKHfVRJm0knjNNUIgZsQ7mNqYk5XxtNaDXkw/DzDz8/qsbkJop84GuSObOl2ezKegHcKXDKWwZ0MTURZuY/ZL3adjMaH2capvrLd9/Boha7+Mv5/ccseBwg4iCttHt9Zjqz58kI71jSlN+Givy3TBDbpOGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=M6UjNCSS; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b147a2ff04so38126285a.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 05:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1729081638; x=1729686438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNLjlnEnDyHjV3CBswVgJafVhgghTbfH6ZETGps1FrE=;
        b=M6UjNCSSdSiHqDn/3Akdv+gD908elugITsSeGwov7A+1RaVPg3PxrI53aq0uB9NiTD
         +C3PS1mbHiCOOX/BaSxjt+xYClQEVh4C7xo45VZybzWKE0tTTFs7UbxHcLzNQoCFhD4y
         NZmPU5s0D+hOwqh5Rx35d9FpdyGlDw+Gr/vPmLK5YlLRzJrcGKPezKY+lD1mmxXPAYS/
         Cen6W8GXgM4712g8fLzUSKmmqy5nN+8k1wiliEOQI2r+AE3783R7saaa9xv58rauLcNP
         M/G4QIbrK/4A1wHO9TAatIConD0gic0FgTEi3eUm0jGB0ohP2BYC6Agn4kuy6d3zW+zl
         tReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729081638; x=1729686438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNLjlnEnDyHjV3CBswVgJafVhgghTbfH6ZETGps1FrE=;
        b=N/Tq07fx3DABgck5blGCj2aoLwdwjDBkd+Tp6tOacW6ocBLuhpJHOcFL3E4pQUnjRV
         7fFJGQZYXroQ3exIHWfQqzF7LA0HDyg8Rs1qfhKeNMfEu4CXqW3TDs5Q3rhDBU2OpLfk
         AmPVWm8MC33jXcc6dmtMmqgu7Yxs0M/aiO5kwriAB7Eji5d0H4dtPNkGWqUp4cCqZCDG
         dw7Q8+ejIWCsYxQPopfBIp5wqNuAfZIJ6/U6VLRWH5o0w5F/REfHBl+04K+MPVVGQU0i
         x+hQb1qHOVZ1UD0K73a6G4Ps0DqPdTSNj0flFEt46gOSY1hYBdMTRXX3r5LiQYoKR+8t
         lfzw==
X-Forwarded-Encrypted: i=1; AJvYcCXWDixSltsrRwNslrMtnMF9Mq9x2367WOWkp/a7E0RFUAVFGL9r6NWgbN46kfPqPE4DI7/m8AdHC5WSmKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpcmXGNmY3duaRbnpJMOCcCqYbM65pLdSsPGkkkXHVtQx8HLVx
	dOmOqOlkdghTJfF2c/K2MGNWjwVhgaZWZenLIk5TS7dfNs3Dz/YgfieQWH3TURJOVB2rdEUpFh6
	zZlnmS7U9fB80XTISKFL+C3utCSGQRwPX/wcoDA==
X-Google-Smtp-Source: AGHT+IEr2RGRH7z7eOPt4+/WSGTQZH3Rri8cgQyjmurOqgpwt74+wkRyeSLE84F+GLTwunyO3mI8dvjKyhWbsrjeDMI=
X-Received: by 2002:a05:620a:2989:b0:7a9:ab72:7374 with SMTP id
 af79cd13be357-7b120fc4b5bmr2484755985a.35.1729081637696; Wed, 16 Oct 2024
 05:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014222022.571819-4-pZ010001011111@proton.me>
 <7b45f190.452f.1928e41b746.Coremail.andyshrk@163.com> <o_Cyz_ARcHj4zNlovv75MBwslIRhn3YWlscoNrlpLVobh7eWIMEQR5bNv0yhHx2KEx_gbYi_gH-8Y-CdvRZs9lZscz3-lhAbM50GXUdtSKY=@proton.me>
 <30940542.b36d.19290215124.Coremail.andyshrk@163.com> <1974DYrs9gLrQrZ5VwCglFgKDDK686iyqnS_g6uPB-s9wZ_4CqfZXPjmYWihLgrkRu7ptNjpkFeqB0uTt73RFId6cL8FowQ8LFltPmaKCoI=@proton.me>
 <1ae9f15d.e52.19292e05e73.Coremail.andyshrk@163.com>
In-Reply-To: <1ae9f15d.e52.19292e05e73.Coremail.andyshrk@163.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 16 Oct 2024 13:27:06 +0100
Message-ID: <CAPj87rOmPyat12S4WUixiUBAsuAEEbyNX5VY2JS+wn5a1jux0A@mail.gmail.com>
Subject: Re: Re:Re:[PATCH v5] rockchip/drm: vop2: add support for gamma LUT
To: Andy Yan <andyshrk@163.com>
Cc: Piotr Zalewski <pZ010001011111@proton.me>, hjc@rock-chips.com, heiko@sntech.de, 
	andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, Dragan Simic <dsimic@manjaro.org>, 
	Diederik de Haas <didi.debian@cknow.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 16 Oct 2024 at 02:11, Andy Yan <andyshrk@163.com> wrote:
> At 2024-10-16 04:13:40, "Piotr Zalewski" <pZ010001011111@proton.me> wrote=
:
> >Ok I get it now. Is such rework correct? - when gamma LUT for rk356x is
> >being set, instead of disabling the LUT before the gamma LUT write for t=
he
> >current CRTC's video port, active video port is selected. Selection is
> >based on if DSP LUT EN bit is set for particular video port. eg:
>
> If the userspace want to set gamma for CRTCx,  then that is indeed where =
they want to set the
> gamma on=E3=80=82The driver silently sets the gamma on another CRTC, whic=
h is not what the user wants.
>
> I think there are two options=EF=BC=9A
> =EF=BC=881=EF=BC=89return a error if gamma is enable on other CRTC=EF=BC=
=8C this is what we done in our BSP code[1]
>   (2)  disable the dsp_lut on privious CRTC, then switch to the current C=
RTC which userspace wants.

1 is the only solution that can work. Silently changing the colour
properties of a separate CRTC is not OK, since this can lead to
displaying incorrect content.

Cheers,
Daniel


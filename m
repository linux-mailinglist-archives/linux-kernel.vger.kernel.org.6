Return-Path: <linux-kernel+bounces-376729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 650099AB530
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0B81F24438
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41801BD00D;
	Tue, 22 Oct 2024 17:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIyjRPtv"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFDC1BBBC3;
	Tue, 22 Oct 2024 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618615; cv=none; b=E5sAwfbACX5wl2aWNdaRZNU+BkOCUg02EMQ5tfaXjXrD+XLvaKK4gcdnsg9GTWtbBYly/vC4wibXElPEqQiamcHNIS/L/p1SzAENZ/61wQSLGWk7l2I5Q6DNifTkN9nA5EMo4H7nf8YDRA3ap7Fbdyb9SBw41WvfJp2x8RJH8Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618615; c=relaxed/simple;
	bh=A0rRwiZmVRMudCLJX+9pCJK3ES+/ITJWDtgwWJHsQME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aUx5eG6vv/+2n4dgL2rO5quKbx2BQPgq5hF6zq3PFXhs3RnsV885lodwlAvEmzF6E6aNUGmXD4fUS3lG2dusuGbLY0ua4WROH3iVkVq2h0f9jNCSMFCW5WwCwQffKozKyp+68igmR8Ls/WPN8TkSnyNZRwZs5m1Il0/q7TFcKYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIyjRPtv; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so5321962e87.3;
        Tue, 22 Oct 2024 10:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729618612; x=1730223412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0rRwiZmVRMudCLJX+9pCJK3ES+/ITJWDtgwWJHsQME=;
        b=JIyjRPtv0CVd/zSKFc/hFWSP0kITD5TCQwavLOf75Yp9f/ia42B0E29V4lcM7E6MC5
         7MXHc8/NFpzi+ijGp7sVd2gLjhBDUgGF9O7JJLiII+CKBtv4tqgstu9Au0Auu2dYeJmM
         ZXGAtnZqRq5Q4PZNwCRmm/Z6eguMuQ5ak5DPnUpCS0cLh1haYY2sJPpL7blaPho1DY8i
         c0DqDO/RgBdyzZU64UyRP/OpPRrPKwHI/itI4ggC8wxtqaxEHs0/DKkAnd3A7Wc4g/wQ
         T28NfJs5O0GEb4GAzUk0QO6nEiXW+WiFGs1MBzJIDv8az7wo3PcHC5P7CUNGXvi3vl6C
         +H/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618612; x=1730223412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0rRwiZmVRMudCLJX+9pCJK3ES+/ITJWDtgwWJHsQME=;
        b=GlGd9Mf3GDx5DDIeA2QvOZ3bSmqOxQ6D/NWMjZgvMSeMo+QDDVs9L2VQpAxstWb2ei
         o0H6SLpBefvprapXnpDpYpK9DUWk1BtAmg902oWw6uZO2H155jCm3726DIi0HnE4ehWj
         A5k9ttDVxZPr+Ir98pkBPg1/kaFxr/OjfDtTN6asWbTrgjBJ/ycakIZcS+Yyqp9PLPlL
         erVsZJtNfpzaNOnPqlMhfiU/dA6w3VC8kcp6K67kOPxPdaE9pq3Sz+6Fv4Xa+GHZnDOo
         YnZ9PmfpTbVXZUjqTYW9d5KqZQSjzmyym9E7ZNsmMMBkueVOzfxY4U4TCRUmk0w5ldYW
         Bh4A==
X-Forwarded-Encrypted: i=1; AJvYcCUmHZ39gxiCnAbFBqx6kyqol78ruYP/8ulEQ02zAmZ86PdHmsLb6JwU2xVvS2ZCJ2i0a0Rp24NDkO6X@vger.kernel.org, AJvYcCVhXRBXfBicG6Yf1OP2fpAhYHVq+Txa46aGWwuN0BoChaEwwnzrYCPhr+e4bTz5aFGhpk72vugG/ENuXzz2@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa6lTikNgdUEimU0mHX1e0sDAMdiLReI6YY5mPtS1gvB8qORXj
	o4cIc05LIVl7ZmH4jd8z/tUDqlHo40e98MtFpkYxm6sM4z/HiVEeFBBg/06u5VHbndVhXcskCMG
	9xQ7UJNzAgR7LMsX2hIENVFUd5Cc=
X-Google-Smtp-Source: AGHT+IHESL1pgIga/1DcaFprc680IQPO/MbgmFx2MwT8kkePvAJwX89NW38rjSyD8aBcw7tZ2hZZ8Om6l64XvUJHk88=
X-Received: by 2002:a05:6512:1304:b0:539:fa43:fc36 with SMTP id
 2adb3069b0e04-53a1520b1d2mr8509712e87.12.1729618611710; Tue, 22 Oct 2024
 10:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021100224.116129-1-lukma@denx.de>
In-Reply-To: <20241021100224.116129-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 22 Oct 2024 14:36:40 -0300
Message-ID: <CAOMZO5DpJmWOExk4i6CWQ6XG_zyU=uz-ZCOBS1t9Xbk1YO2MVA@mail.gmail.com>
Subject: Re: [PATCH v9 1/4] dt-bindings: display: Add powertip,st7272 as DT
 Schema description
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Stefan Wahren <wahrenst@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Mon, Oct 21, 2024 at 7:02=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wro=
te:
>
> This patch provides the DT Schema description of powertip,st7272 320 x
> 240 LCD display.

Using "This patch" is not recommended per submitting-patches.rst:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/process/submitting-patches.rst?h=3Dv6.12-rc4#n94

"Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour."

The same applies to patch 2/4.


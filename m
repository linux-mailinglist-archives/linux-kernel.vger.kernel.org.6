Return-Path: <linux-kernel+bounces-282584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6010794E628
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14DDD1F2202F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 05:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E27514D2A4;
	Mon, 12 Aug 2024 05:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjrp4V3g"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637B643AA1
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 05:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723440566; cv=none; b=R0X7CVd36aaovNUJ+6XBRvjRDmkNCaRAeo6V0Amm+aol+qWO3LhJQl0vb5+nrIzgPqbeObMNsGqtv8yY8H3ov7TFMub1UlhZzAhjjR/IMUYdcUylTZRBubK5fqlWcrCqln0LTvX9i5+VmRWdBDLMOdMDisEmWFJtvQ12x6YfmiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723440566; c=relaxed/simple;
	bh=DZd5uNs6UOMTvmxGNDjkddt+74otlfFDKdBy1Jo1lns=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JTtdXPghk+s8I3neMRw5EADX3ktM4wbW4c8YGXrnnVj/MOFk7sgDM0V6TyCe2dfrt2lcUakwAu4ptNKgrYPZ0kw9YxkOsNlSnEUeFXH4dAHz/VrR1TGaRoIMmGBfg0Xs31aX4VDcVPDdbJORVpo4ewNLcO48zoWXkB0SyHFLD3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjrp4V3g; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso60819621fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 22:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723440562; x=1724045362; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DZd5uNs6UOMTvmxGNDjkddt+74otlfFDKdBy1Jo1lns=;
        b=gjrp4V3ghCmSheOKC7G9IqljJ7bl1wA0xqcZYUWbSCxrQw21GhQ9eYTRFG3uDtx1Cg
         7ziTvkvC3fbB8krLzgJE3ciQdAipfiWdgL6yLY/c6APWT8EPT4mHjp+jdh/1PUdVWlf9
         l1vPisTRqOUp2Bhqaa5NSdovLo6JtZOaoEa+zI8N3X85/xtLiH+BgCEv57yFya6ctpQm
         8Eqw0VGFQ7VzJh3Ih1MVM8Poo5lWN3NFb5Usu8hB1xjmDM6hRy7gu5+vIgKYpRVdzfIf
         y108lo+TWU9GRc54Qy8In+CBSMyahcTb40eHGmYyWkNzB6MJVHDyChqeuzQDlO+ZoELY
         WGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723440562; x=1724045362;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZd5uNs6UOMTvmxGNDjkddt+74otlfFDKdBy1Jo1lns=;
        b=twL4LwA2dmgIkAfq6wE08HnqDQe1fo+dRuKw1s6ErHH2BJ9V5j64IgvQYsdxvLXsK0
         2/HMD25YUUnj5upeKu/39k5BfFR5dF9ZNuJ78qKOaDXMzdPKWm5uVKWk3nz8Ui9VbmRe
         65Zp96S0EfraHWkcU//Ej7SwwVN+k8+qFVSFTlB7kgC9oPVsqA/UvEFg75lV9Ly3/Ha3
         bAuZFI++iDMOqCWlC9ABWzyiRroTVcTALMrY0pWvcF2HrdM5xct/FuGKeiO/sekOhy6t
         gGlhMW/RY+z8zk5WOSz9YOcW9cPtyZBgiaDNmm9AeydjFrx+2eNg4iseM0MsbFaWvfFI
         Ny/Q==
X-Gm-Message-State: AOJu0Ywt76haxeCPBZuMrxKU3+ZOHmNyJSVoYoUB7lf93rrwA6CF93nW
	3QRCtQMkpuSrehFaM8oFPx3+IzKgBTqFh9nblY7Yl7Xq7GnIsare/Un9Mm7MM9rZ7EqpPUFUdMM
	1oJLCF7sqJaIoVu/5/hM6ai+omMdMAcoI
X-Google-Smtp-Source: AGHT+IFXxNlsBa9tGDcVQLKJCeddTmbVCYqAYXmcLnB8Ym/lreZCiKWc6thH88fyl3TM6fmmJUQZs2Ay9gq0nUa3AAg=
X-Received: by 2002:a2e:b88a:0:b0:2ef:2c86:4d49 with SMTP id
 38308e7fff4ca-2f1a6c6cf9bmr72940691fa.22.1723440561599; Sun, 11 Aug 2024
 22:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Mon, 12 Aug 2024 13:29:09 +0800
Message-ID: <CADtkEecKdWc9t0reu5WCefTaFvW_cuNmZAxjDFL8btN6LmfnPg@mail.gmail.com>
Subject: Query about the maintence time of LTS
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Content-Type: text/plain; charset="UTF-8"

Hi :

We are now a little confused about the LTS maintenance time of the
LTS. Does the maintenance time of the new LTS is limited to 3 years or
2 years? will it have any chance to extend to 6 years as before?

Thanks


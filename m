Return-Path: <linux-kernel+bounces-200151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CAD8FABEB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4777D1F2195A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D8D140E2F;
	Tue,  4 Jun 2024 07:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHNIHKxQ"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09580142659
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 07:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717486084; cv=none; b=QDocLS9VMRshjyKJ81kfLPI3aZEy/mvzNhz0D3UHIPrP+RxrKyNpyyrUWE3qCynoHiI7jKgVAEekhuwVh6AV/Q0W8s3Re6FCRCISjM40BM2BnZM3Y9NnjAbDGUseKaAm056vNRB7/qxUcpJne6W4tGTardn/F3y3wQv3YI8XZ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717486084; c=relaxed/simple;
	bh=baRlgkeTgqJ6XQw99hZbHYZxMDAu/x1hcB/VGB/urmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VAp+Yb5kIKeqhBw2PUNYMsmH++6pa+oeltjYSenE4f72oyFSo6W9H8mPya8rXtCvne23uV3ZEFTl9vJExJjG+fZhuiWUMzchp7b8mF8Y3K/EymEgG3x9JXo0cDbovK0JtBeNugAoZkNxyxk1DqxRCY7TgqokZ9+rOKg6UwkLqpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHNIHKxQ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a68bf84d747so271688266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 00:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717486081; x=1718090881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baRlgkeTgqJ6XQw99hZbHYZxMDAu/x1hcB/VGB/urmQ=;
        b=MHNIHKxQ1omM43lpOW4/0oFo+6Ahv1ZPsAn2YOFj7MWo23w058pp2NQtB5fY2NLEVs
         r+NwnrZjC+nUpTsLlmjYg61FPz6SqO9lCy9nGldryJHoinJXjKZY90+vrJLhZzhA0cHB
         7/Sz1PFgip6Xd8NIUZuxBAYosz3hjiRu0VBNwagZChQyIVovWm28txYlqZ+f0Oed+AF/
         WUqmxpcN1eDPX1uf9tXl+qedYomP99goNVAFrZc1aKGnSPFv7wrhC8eS0GaGAfaSA/Im
         RDskimWMinrGKBwKAiv715+N1TvXN0DzLMrTQ6FvJgziQ3krpCFx7osgw8hly/sn700p
         6uJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717486081; x=1718090881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=baRlgkeTgqJ6XQw99hZbHYZxMDAu/x1hcB/VGB/urmQ=;
        b=JM2kWG7zwduDCEOIjlvK8acW8wK4Dlr4dQRfx+t5BX3qoswuqtfEUrMTeZnkH2Cty3
         w60+U2a4ATSTq3UPVD9eAE2Vrn33CLzBElrOecTmgs4uGTkZJdqFP6vtWPT5O/U6UVM8
         oLlWnNmcxqO69T+HbFmfAlG4nCHCf68Xn9Dg5qGyf8aSPUprD+Is4H1OlXLGvUZGRkl4
         GRFjm/WoYdRoSXFNpxdoArjYmoBt94fRl662wANlVt8NLfiQDSWn4vdQr2d4r4BN2SqS
         vUlHWBQR15tPfWGe1hER/h9p34b6wfEvFSRu5atyeiMh6kkhGgXLNOp1MO1Dd8QgU9c0
         AfTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQy7a9OGElRCcyprRdtnYI+yNBxXEv3KI+/tmE0AEkQbE18KVwpBrMNaroBJ/xnUc3Uf7dNGkDeop42R6cf8qrYZJiEnSvvKzgG8dS
X-Gm-Message-State: AOJu0Yw0dsOwVRn1v2zcGvzvMzMJSwOOPOOz/BuD+QT7Vfd/9fxH3+t+
	ULL8FbOxnYtGZsd+0b0tWwfSYwt52B79gkIY+r30JMmhuAYNtZ8OmO3wYntyTpsHwl3F2cBYt8N
	H7aZl4DMGi4fCKqFlsGV0+pL9oO0=
X-Google-Smtp-Source: AGHT+IHGQah/C0RXpKLehNCODMuC0u5PCuTvlvK4Kx7JQmwVXuuWItzNmLSEm8AezwHysYj9Hn4URKZuBKBWSTSDZjs=
X-Received: by 2002:a17:906:b044:b0:a63:cb4e:9a10 with SMTP id
 a640c23a62f3a-a6822049c19mr635331666b.77.1717486081256; Tue, 04 Jun 2024
 00:28:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530232054.3559043-1-chris.packham@alliedtelesis.co.nz>
 <ZlnuNx6gKJV6w9YS@smile.fi.intel.com> <87e2e4c2-ed9e-4ab4-8920-e7983c5a18ac@alliedtelesis.co.nz>
In-Reply-To: <87e2e4c2-ed9e-4ab4-8920-e7983c5a18ac@alliedtelesis.co.nz>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 4 Jun 2024 10:27:24 +0300
Message-ID: <CAHp75Ve5XCFYemAZHZM5ZTf0B2cHJrH5GdPCR+cLPE1aoMDs2Q@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: linedisp: Support configuring the boot message
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Andy Shevchenko <andy@kernel.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>, 
	"tzimmermann@suse.de" <tzimmermann@suse.de>, "ojeda@kernel.org" <ojeda@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 12:59=E2=80=AFAM Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:
>
>
> On 1/06/24 03:35, Andy Shevchenko wrote:
> > On Fri, May 31, 2024 at 11:20:54AM +1200, Chris Packham wrote:
> >> Like we do for charlcd, allow the configuration of the initial message
> >> on line-display devices.
> > Pushed to my review and testing queue, thanks!
> >
> > I tweaked the define to be LINEDISP as Geert suggested.
> >
> Actually did you? I just checked what's in
> andy/linux-auxdisplay/review-andy and it still uses LINE_DISP.

Oh, it seems I forgot to squash the change, thank you for the catch!


--=20
With Best Regards,
Andy Shevchenko


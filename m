Return-Path: <linux-kernel+bounces-222817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BA0910819
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CAE6282694
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CEF1AD9EE;
	Thu, 20 Jun 2024 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OL5Nao81"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C421AD9D3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893527; cv=none; b=EQlC3F1wSUQ9DcbrgY4pg7Au87RojNsiVA06iEzuBiiiCy3gfoZag3ZLOu81MxTrEUs9qqgglTt68/d6xUrc8268dmzORwjzyDx2FMmF5nmbCh7zOA/fsEeu8YisyU9ZjmvTFBarlAeygyV1dtN8nXqjIjAaZFXlPHMbkAfDXWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893527; c=relaxed/simple;
	bh=SQMNm/Wgloa85H/6Ml/z+UyGgCgN9Pm78Q6nwvCTYt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yu41Nl1za7yqbJZW55uNPjbaAHh4P4Vrmt8URgBo0Iv+pIa2M/aCuJ8CVDh8upjnbl1XecbSDufeaMxXYmMVQjrYunQgIM2fG2LZ7U+qnjeA5kdCrdMfmTMVwqRYB9MwbFlkvO7hsCceVGgcMzvKnYPZN2Mub9qTMm9oDUPC/bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OL5Nao81; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e02b571b0f6so960178276.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718893525; x=1719498325; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SQMNm/Wgloa85H/6Ml/z+UyGgCgN9Pm78Q6nwvCTYt0=;
        b=OL5Nao81oJKls2x2xNXV9G/VLUWSItD0Hd5yBzxZJLJGqX9SgVyy8wVwhM+yLR3Pt6
         VOmNxrF+DkaYmKE/3PIJU7OlYgDBiw5J32MA5T3egKvH3nwuOu17c3OpzwWVC+/Sr/Wc
         +uoGBWMVqX4jjUQoWheH+2bByYekd5OpcBXVzVVCajXw8b1o7GFQxrPzuEQYQhUZTgpk
         Ia3I60JHSstYsf12I4wXrEnQJwSSVFXLhBlkltpMs9G2RDxnNbwIk7cspOMP5/LnCP4O
         y+o9oVIEFY5qGPvpEZQw9/MRcgpz+EMbDnxh6ZGVZtMDSs0mf9ZTmOvQGBml8eRBw/aU
         6CNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718893525; x=1719498325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQMNm/Wgloa85H/6Ml/z+UyGgCgN9Pm78Q6nwvCTYt0=;
        b=p46yJ+0kypSdr48wxCCAyGhWDlIsc5URgHduWx8VF7H51fSMxTR4B4MG/uzk4siO95
         F9hH1OYOiRh5zkS4KTbg4TYn9ztYYL6OVzdsEmc+ahjhyU4/OZrrZlpKrFmGE2V+y16g
         xKSaBuVJ7MnrVM/tIGIZIQm7nsySt1HQLgPIbh/jzxkHEdDnu70WFzN5RAZHyLnd/L5/
         DoaVJNVr1qN7i9ql/EAe/ezBSItKE4WAjlOFvl0hKxpbTkbDm7jBTUzWuuEaKb5sE52t
         R58lFrQY7z+2PiGvayvDCQigX22FXGl4Iwp6sOJq0EzwVNRKZ3EjlgJxdX7M1hnzONJK
         oKiA==
X-Forwarded-Encrypted: i=1; AJvYcCV1koLpHEp0Y0eURCgp+0rZzJXddEGx/UfriwQQhUKOWXugn+4ejokgCJeIhg3FlJmZ97Ss4nfg1PLJ1FSdcGCAd2nqNebHX70ZdiLU
X-Gm-Message-State: AOJu0YxpN5OesbLGSYixjQ3FTeTj+Vcj7c9CYseoAkdSHPy65vt8mUZ1
	itaemPYgLArLvoO/6xrO4Ik/TEmoBRSSWLPn84Qy4wcnVu/FT+KsoqbnDl9YjjgNUXNUirBonc8
	aEFhc/8pzRGN/eyMNztylnoVDpRXJidpMy0GJlA==
X-Google-Smtp-Source: AGHT+IHR7fpKdExIeayYO8J71ywzwR+4VpYOIFbdfii6VoqwkxcVhItB0QotOZnRgehcLXlgkNKGKaigbbl58w+Xms0=
X-Received: by 2002:a25:8188:0:b0:dfb:1ea:23ee with SMTP id
 3f1490d57ef6-e02be17b1bamr6168497276.37.1718893524724; Thu, 20 Jun 2024
 07:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612-brigade-shell-1f626e7e592f@spud> <20240612-dense-resample-563f07c30185@spud>
 <CAPDyKFozcUPuMooDHVSBZomHTGKzseVf9F=YBY_uQejh9o3x7g@mail.gmail.com> <20240620-sabbath-ambulance-b8764fb386e9@spud>
In-Reply-To: <20240620-sabbath-ambulance-b8764fb386e9@spud>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 20 Jun 2024 16:24:49 +0200
Message-ID: <CAPDyKFre12rqqwar8sfoWyc6duS3psp4OT=W5ToG9r_EdqH89w@mail.gmail.com>
Subject: Re: [RFC v1 1/3] mmc: mmc_spi: allow for spi controllers incapable of
 getting as low as 400k
To: Conor Dooley <conor@kernel.org>
Cc: linux-mmc@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	cyril.jean@microchip.com, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 16:12, Conor Dooley <conor@kernel.org> wrote:
>
> On Thu, Jun 20, 2024 at 02:50:15PM +0200, Ulf Hansson wrote:
> > On Wed, 12 Jun 2024 at 17:48, Conor Dooley <conor@kernel.org> wrote:
> > >
> > > From: Conor Dooley <conor.dooley@microchip.com>
> > >
> > > Some controllers may not be able to reach a bus clock as low as 400 KHz
> > > due to a lack of sufficient divisors. In these cases, the SD card slot
> > > becomes non-functional as Linux continuously attempts to set the bus
> > > clock to 400 KHz. If the controller is incapable of getting that low,
> > > set its minimum frequency instead. While this may eliminate some SD
> > > cards, it allows those capable of operating at the controller's minimum
> > > frequency to be used.
> > >
> > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >
> > Looks reasonable to me. I assume you intend to send a non-RFC for
> > this, that I can pick up?
>
> I do intend doing that. How soon depends on whether or not you are
> willing to take it on its own, or require it to come in a series with
> the spi driver changes.

I can pick it separately, if that makes sense to you.

Kind regards
Uffe


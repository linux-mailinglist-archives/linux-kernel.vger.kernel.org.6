Return-Path: <linux-kernel+bounces-369863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F7D9A23C0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 339F02854F1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D03E1DE2CC;
	Thu, 17 Oct 2024 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rnws0rIu"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B181DDA2E;
	Thu, 17 Oct 2024 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171465; cv=none; b=picKREO1d2Yk5I/AXXARlWRNjIPuNpQnbaBW0rBnSsFps/IomRc66Y3mjfgiKjvi6SBw0iqVyD5yjDzH60kPJwHs9vKMD725Vhr5QfxNjpMJwc30BNekJQFg8l8ggbeg/mgnUdiTDjC6xfeSUz6Woy5k0oLp9/TWLp3iWynaNLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171465; c=relaxed/simple;
	bh=Gz6h/cWpfDus+Fv6R8OuQ6KhEA0lGGLgJfyu+vZc1Ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c12uBhRet3C/QM01js9MIKirKG7Q7wNshnFjS4oqNIiY00aatlvFvPJSRan+Aqxex+y6c9OWXJFaaDT37JrT4Hg59L8CHCY138w5GiQKgN2gZU1j8gDfUOi7t6igVaWrIarueZcw2LL40L5wD721F5N7hTNmPc3dydOnr0QHaE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rnws0rIu; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso15268631fa.1;
        Thu, 17 Oct 2024 06:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729171461; x=1729776261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gz6h/cWpfDus+Fv6R8OuQ6KhEA0lGGLgJfyu+vZc1Ng=;
        b=Rnws0rIu+1ixHg26H8F79SSTIS2XuzXvKjTzONhiM+ubY9E7gxS7YzWjz7DkkRd3ib
         itlWKUuP0iV2tzHgGdFWPtc+OrQ/wgTd9gO5OzxDpTJyXk3fZpd/IvspGaED3dSbxAbt
         iYvCfpKqfcNhVYd4gqMg7W5//4243In58Xu5UTUrMCQ7diVJqeBMwe5nSPSIVjQrG3j6
         kPTBBCS4WpeZjRgFbKua0TUWAvkJI6xj/bhOe3DT5q/eGaFukU6B8ZduXH8Ezbd1NTzE
         eard/yGWVQQ//GM3CHgbDf2iZ2dsVr6GewXvLqSwK852m+LQRPTD3C3KHkze15vGqNeo
         OGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729171461; x=1729776261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gz6h/cWpfDus+Fv6R8OuQ6KhEA0lGGLgJfyu+vZc1Ng=;
        b=mSoseT56ebBjQEVgW+1uemvr4+Sk9gaQtGrB6K7fPFN0BWcQ5NUJ6ZbfjDddsVwu4G
         OgxjKsmsRfj0FBrBqlvCv6PJMd96LioMRl7Tumki8tuTao2X0cupdPrKpmMlL6CQ2CST
         ZQqBYdmBD6ubEUbSABVNCCfRAdH81uj6UkdyKhg/uEOva7ipqmdz9UeRfTRJpn2SX69L
         oVtloFojv+Fz/DNjJ9Pq+Vt6sHxAnk1OfFVXVtmymWihvG+SZEP7G/PJFGEbyttM8Uf+
         TvBALowUamvIAvDjw9puPdxfNqwZpBcRPgPikd3cEucjlHxVmKA/sWgprAp+1OKj+CwF
         EpMw==
X-Forwarded-Encrypted: i=1; AJvYcCW72iMsntU5eZUiA7BTCMOfECW/y0C7Wa8oYzprsjGfvFS1W4Kf4ReHVWMYUbuj0nnpgJUA/+7pyzDIUhI=@vger.kernel.org, AJvYcCXVnyQVtw6qRiSerKyvlkiwN95yNnZ7x4KjyRIkVNUn54OQMUmRkPrYZjszjT80LJq6r+SYs2AQb6Mi/L4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCotxbhbKP2b3iG4kbuw9IKEkn8+ySRcFBv7HmOsM7VuKfgQz6
	Tzfp0E9IbQ0FdogYaNolGf/2e6An98Og9uISPuPEtoHC/sO8JFr2O2LiK70ZV6B8XzuhUqCahnw
	1W/yt5SPoEc+ET1F4jBPNWdnpV8w=
X-Google-Smtp-Source: AGHT+IFD5qDdg80DA9mBb/Ba6kch83UqlhH3993pbPsJRFaEwYd7KQ9tdLLC5IVGXX1NzhH891rsRl8NvWZZ4Ml9Hqk=
X-Received: by 2002:a05:651c:1987:b0:2fb:4f8e:efd with SMTP id
 38308e7fff4ca-2fb4f8e10ebmr126203261fa.32.1729171460504; Thu, 17 Oct 2024
 06:24:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017071507.2577786-1-chancel.liu@nxp.com>
In-Reply-To: <20241017071507.2577786-1-chancel.liu@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 17 Oct 2024 16:25:18 +0300
Message-ID: <CAEnQRZABGsL7rL+qrwNhyaYDX22D6M2fg=4RKRRRcOAXS9yKxg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_micfil: Add a flag to distinguish with
 different volume control types
To: Chancel Liu <chancel.liu@nxp.com>
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 10:15=E2=80=AFAM Chancel Liu <chancel.liu@nxp.com> =
wrote:
>
> On i.MX8MM the register of volume control has positive and negative
> values. It is different from other platforms like i.MX8MP and i.MX93
> which only have positive values. Add a volume_sx flag to use SX_TLV
> volume control for this kind of platform. Use common TLV volume control
> for other platforms.
>
> Fixes: cdfa92eb90f5 ("ASoC: fsl_micfil: Correct the number of steps on SX=
 controls")
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>


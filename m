Return-Path: <linux-kernel+bounces-553476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1D5A58A27
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 02:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7815F3A5452
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 01:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4675C1531E3;
	Mon, 10 Mar 2025 01:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZHR0dqw"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D06AD2F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 01:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741571645; cv=none; b=rRmwZxC4tweC+JQObuqJgnhmPz2ag6j5MRsrJcnXYJczpXbf3JNq+zjqplSFCraBSEyg41S6pxOdPpC7H63ZxlgZnZwMmiXszQvfcbRQMls3hR4Oq8Be7CdpfFrfuv+bJuY0SSo6Im65Gp8ZVTr6YqmMj3rzssndqjGVo6OLIQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741571645; c=relaxed/simple;
	bh=wdat+WCOkZ4JmE2C/1DVtDfQaU2ZDt6SDSd7f/S31nA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uXaurkCkjZakM5ySn/1TyDFUVwdWO0OF3O2v0JsXm8Il2YsyPyybINBrqL4rR6IQ36adcJKMSIovnEW/4QCKiq+30HMqLcg/1HxPieGhtTjdXCq7r6lEScRnfsfl3jTzMGFb4mSha7bYfWzjN3BUMcFQYrXwhVpmndktIPULnX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZHR0dqw; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff187f027fso5991149a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 18:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741571644; x=1742176444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaSBUV8N/ebDsE7fpzXbVC4hqASSEdkTygvbNPsCwaM=;
        b=mZHR0dqw+FtiHc3JdpWFBWcYusi1KcWowRYuShsWe5ZMyBZRqrqE0cWAlXlMGXL0BF
         O/H3VdHLRN0qV5EOTM5fVqHqWPwNkHGTF+tQjm2q3gjBvTA0XYz7JLEqIkaePkIPzU2Z
         xS4n6cZtQJsGXIBrsIh/Oaom7s1b/8xdEydBRab1rcmuvE7k0oiYJWmit6i1RVz9agos
         pu9c0zAFUNPnZYVQSmbGEJ8Ms1rd+wYgJqH62RaZZAh8GN2zOkghRSMnEZLY8NGbYGpv
         WmlXYmiLJbsH/awo97IqFEhdwpZHXCDajs7GD05rnEhifiPOp5sCT4SGLtw0s0pfi6e2
         8/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741571644; x=1742176444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QaSBUV8N/ebDsE7fpzXbVC4hqASSEdkTygvbNPsCwaM=;
        b=EqaKhL1zP0ofMnGRQms/8pnlJvIFpQv2Eut3C11+afjtJaSjsv3wRTDBblPqQotEMb
         zjxNqxTdanyNW388SoJ7zSUOwHQ0xIemJlzp7W9cssUTL0ZIyJHI4aGWyjFc6ZJdlmew
         UdE0yyu1Xc3YXf1MGikKYNIgNrLS0OfY7HmE1GLkxon0xe9KqtHTGvYNeEQINOAXz5Fp
         14MlqUjjHuppkEILuKBRRrIHm1wgzMnvJxUALgPtBsvA4bMrzB8tLwpGF4k80NNab5IU
         k+V3l/0E2UzRZVeJDHFh7J0oePiE9grzvTmv1KG1xGH/+5ZjBNR+q8Xypuh0DkIsjs8G
         Lxrg==
X-Forwarded-Encrypted: i=1; AJvYcCUt4EKvc+trFYGYwaOPeVSXaPSMO96mQlOwTv73RjalIEaRvQlsswcrYivTjnGuCcxk9DckV1BS301QU+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt1cxmdGRKRzmQuf82aO8PBmrk5G96ztBfrXzwih7qkebYq3QL
	KFwl4l1++wNlmjz2IgZ0qO/xgIG1J2txeV+lh1Pbc3hV3fm/xz4SsysmagaOGz5QEH7Gnw47DJN
	y/OG7YFwvEhCcvBjOxm5CLBW20k8Ucw==
X-Gm-Gg: ASbGncvNjs/3+x45uujRvHzaJa2oGF3bqsouhRZaTQ8DjSl5Gdf67G9d2jTDcr8bCoA
	JJu06XfGrz9BQ+qOPuHlSksQ+aq1lFadLDZ8z74pipR/P8mHXgBzZan7RM6kz9Uu8U+fCSsJqON
	cN2U/vt5BWn7BGHSXYhF+45yB5ag==
X-Google-Smtp-Source: AGHT+IE8NzjtBSV3cZ0KaECQneUGiXO4kldgQPmQU052CjW33SbT5GMLvacughdx9blP9lVGeDjGlhE9MkslZOBxYHE=
X-Received: by 2002:a17:90a:da8b:b0:2fa:2268:1af4 with SMTP id
 98e67ed59e1d1-2ffbc15b91dmr11948511a91.7.1741571643482; Sun, 09 Mar 2025
 18:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211063028.382169-1-linchengming884@gmail.com> <174132918169.12801.10830790202971847088.b4-ty@linaro.org>
In-Reply-To: <174132918169.12801.10830790202971847088.b4-ty@linaro.org>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Mon, 10 Mar 2025 09:49:11 +0800
X-Gm-Features: AQ5f1Jr8Y_iiAIyEIGB7CcDNQGieP3avmmbG2sucJTdF2G0_pofHf3LacdZvPt8
Message-ID: <CAAyq3SaWnxgW+Zy84mSW5BROxHYhFstEVa7P8-eC6noVjc7V6Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add support for Quad Input Page Program
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: pratyush@kernel.org, mwalle@kernel.org, miquel.raynal@bootlin.com, 
	richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, alvinzhou@mxic.com.tw, leoyu@mxic.com.tw, 
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tudor,

Tudor Ambarus <tudor.ambarus@linaro.org> =E6=96=BC 2025=E5=B9=B43=E6=9C=887=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=882:35=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
>
> On Tue, 11 Feb 2025 14:30:26 +0800, Cheng Ming Lin wrote:
> > Support for the Quad Input Page Program feature.
> >
> > Some Macronix NOR flash support the Quad Input Page Program feature, bu=
t
> > the 4-Byte Address Instruction Table definition in the SFDP is incorrec=
t.
> > To properly enable this feature, a post_sfdp fixups implementation is
> > introduced.
> >
> > [...]
>
> Please rnu ./scripts/checkpatch --strict before submitting. Fixed alignme=
nt
> to match open pharenthesis, updated commit subject.

Got it, thanks for the reminder. I'll make sure to do that from now on.

> Applied, thanks!
>
> [1/2] mtd: spi-nor: macronix: Add post_sfdp fixups for Quad Input Page Pr=
ogram
>       https://git.kernel.org/mtd/c/798aafeffb36
> [2/2] mtd: spi-nor: macronix: Add support for Macronix NOR Flash
>       https://git.kernel.org/mtd/c/797bbaa7531f
>
> Best regards,
> --
> Tudor Ambarus <tudor.ambarus@linaro.org>

Thanks,
Cheng Ming Lin


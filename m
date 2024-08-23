Return-Path: <linux-kernel+bounces-298181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DF895C388
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 05:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5574FB240AD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 03:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E312E3EB;
	Fri, 23 Aug 2024 03:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aA/AAU6/"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DDB26AC6;
	Fri, 23 Aug 2024 03:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724382215; cv=none; b=TS+uSAlh0MPByCCL6CQBiz+RJ37KwT8UX+Y3qKjPo32twnYZnfyz7tptHtynCvG0foGqyJhpQMV5wEvZTZt4TTHv4XSvEQ6SpN5vCNo/GS75zuExD2N6zxDc/yRTnCdmogSAI9KMUT5ZrFndtGMc76mhnSvHCTNAns30BR4hLm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724382215; c=relaxed/simple;
	bh=OpUizcF5iX++1eqZ53wXDHtHkp4ptwu2/RX1CoTTmNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwuLJtgBH62/UuC5AaTW7c+otfg5NNKG81AWq56mji82KpbIHBk74fUaCtQwRgJjwb1aUpwUbj59kt9h+9fxXkcu40ng/gMVjnkAKq9DHZmquYyGMdGiv2fPFTbLnPtDQFGHVb0YYCRGxnGNyP0ukLEExDJWbhJ9BKGGI0TsUOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aA/AAU6/; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f3edb2d908so15067631fa.2;
        Thu, 22 Aug 2024 20:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724382212; x=1724987012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpUizcF5iX++1eqZ53wXDHtHkp4ptwu2/RX1CoTTmNs=;
        b=aA/AAU6/zSYSxM2BvPE9Lmka7rPkFY1rOu24pATS9QKLKIlSBLTThuaaEt8iTdivWy
         72Y2Ov0w3WNw09RmTPYffwLeiswUWm78fuW3SK3JfcA8HzuT9d7WciPNWmxwqZPQhLKG
         YjlyXbjVcbKweAXjdpUYdA1TZjk/YwuQpmD+DhJFfmjJrL2EH/KyNfC1vYiBFJ4dw0SJ
         LJcRTSOeroZb5NA4YJ157+UTZg0Q71ecBsVpvQyisp5OURj2vdxv1XEuJNQznqhmBK5+
         ghBAB2W6t3F89bWFZKQEqlMlWKcxnbSCohT/B5zDSCxy2IC4pVIw14Y0/nyxSa3QFaHH
         4upA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724382212; x=1724987012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpUizcF5iX++1eqZ53wXDHtHkp4ptwu2/RX1CoTTmNs=;
        b=RxA26HABC1QUpLOP767UE8RfKPjo8lWelrQeCCQqY5ViEFD+I5MkNPLO4GzCscc3ti
         Mt08IVqFzQj84pMgQv86wsrDgwi3ZIVu1NeO2MfpBw01OUWPk+Q3OgkpkL5R2JHx2V7Q
         uVjAUT2uVQFbR9Pr9Urr+e6QPHXQJ2Ocf81comi2A+hXb+9Ewum4yxwR6+X2qu4qE+xT
         JUxr/7VD1LLMRkpKcZ5Iipm7hTekVk1mlCh2Nb935INDH4t+P/yFW0T/ijBo4BYc6Gar
         mRY3jpQCjYtQJ5jrZNj1BnC4C8ICXDRCpagX13I+x9pJrw6w8yHiJJaVuWF7Ey+7TFE4
         3EAg==
X-Forwarded-Encrypted: i=1; AJvYcCUR+3D6WvAaXEJktcqCgpntfCo02k6IRF2UtY1cPJ4C2BE53wR7ZEJX6O252KNOA8I6M6ZfQaV+lh7auD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YydEZPamTEXsupBFAj2U2PGxKuN6lmfdNuIXG+ih945QCAc2T2D
	wGbBJLR5S01FIykjGcY4fuZ4FjAKDwGiJFZNdO1Sxd8+BGNSR0NDqoqIHi/Iz3ooZxBHK6RGiOo
	bGd00xhUNgRaFEYNpLY/L1aHz0qQ=
X-Google-Smtp-Source: AGHT+IFZaVNNIfhPnYJ8j60zWzA9Ojbce9+zckAj3ipZC4+X1F65rQVGMBHi2Pgu4DqPCK85AMDX07WkOMChwVZOuKw=
X-Received: by 2002:a2e:6112:0:b0:2ef:2490:46fb with SMTP id
 38308e7fff4ca-2f4f493f0c0mr5419161fa.37.1724382211399; Thu, 22 Aug 2024
 20:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823021257.1067054-1-victor.liu@nxp.com> <CAOMZO5AN=yx5RSkVuMrym1QF7s622gm8+Qnf09r9mgZKr5sypQ@mail.gmail.com>
 <cca0af80-8265-45dd-aaa1-e28887f343f5@nxp.com>
In-Reply-To: <cca0af80-8265-45dd-aaa1-e28887f343f5@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 23 Aug 2024 00:03:20 -0300
Message-ID: <CAOMZO5DqXQD8Emd2sV1_GDcDMDmt0kxtvVeOn4nQftnz=vL9sg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mp-evk: Add native HDMI output
To: Liu Ying <victor.liu@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, 
	alexander.stein@ew.tq-group.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 11:50=E2=80=AFPM Liu Ying <victor.liu@nxp.com> wrot=
e:

> reg =3D <1>; is in arch/arm64/boot/dts/freescale/imx8mp.dtsi,
> so it is not needed here.

You are right. I haven't noticed it was part of imx8mp.dtsi.

I ran 'make dtbs_check' and no warning is seen.

Reviewed-by: Fabio Estevam <festevam@gmail.com>


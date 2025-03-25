Return-Path: <linux-kernel+bounces-574954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21030A6EBF0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C25963B2D13
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3F61A239D;
	Tue, 25 Mar 2025 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVOnmoX9"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C609D481B6;
	Tue, 25 Mar 2025 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742892558; cv=none; b=DG8GqvzVgBGvEXnjfuBuNe7Jq52zY9RbBq8vT2KgRzFgc6W9WS/ux3iu7PnbOuCY2UdzO3z5D4s1T5ho9zs8QPpnnzb3cp27EIPoFv7N+wbjaaLD2LjeLKTOiAYC5594ZWquOXQgpTWXD7EG1JIy83vpAlpGspVDMbQiL2vNksI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742892558; c=relaxed/simple;
	bh=UTMqa3/iThHUj62i5Lna3n7hgfqWAVpg9kIVXMcn2OA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8nEc5oxxP3gfarTeoq14507Njul2d9iEZoWApuaTJ6+y9xQtRhKMB82gnfZYWT7NEKuXUn1COCH2PJo4nsyS0FGyWLKTngsYz8sy/NMAALyURHpMBGt1Kp0UJix1EHyox0FEYA036Q9W+0dilBKblUQDN7i7wwKnAbPxCW+IBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVOnmoX9; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so12336459a91.3;
        Tue, 25 Mar 2025 01:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742892556; x=1743497356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTMqa3/iThHUj62i5Lna3n7hgfqWAVpg9kIVXMcn2OA=;
        b=YVOnmoX9jive5YIjppaYTAfgrUjifJ8LR77P+mfFb0w+hb9RVSiq+JUFDzUtcMYoBd
         6dIME2sMyKcZtDOyVN0WHKhviOBVDYul5ecN/opT+E6Y4mDiAJBQdOnSbxHcYmwANbPf
         Uoi3TLbU5irxj999kZE3g4pvZ8o3wzHCbjFBlDrGfYD8aqGRFpd//GJZnOuw0LhBlsar
         kUJKzeyUTYAfLzVkkKm0VDEtuHvYqT0LudMWB1DPd47LcQmGPjiWGL44YiNg9kzZnyWF
         IwcNIkU6jdST8AX8XU7471+oS5v9Sead1KgSLV0EssdognzjWDD9xFjvgORpwanOm+EP
         3kog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742892556; x=1743497356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTMqa3/iThHUj62i5Lna3n7hgfqWAVpg9kIVXMcn2OA=;
        b=nwGHQza2oC9xzd1rhK9RtZfPTCudin4YpoOGD4KSk57rMZFcUAOEW7wFasvRAACqeO
         LeIhiKIkg4/YEIfosqQ5YGXcpnaNJR6bYfyR7YEbtTbk9Jwgbr3LtKh2EdnVZGdCoDAo
         QPjThUItCtSV+DhAPmlbsCLZ3OCsUA3kv2otl+LbZbGFTlzxzJKwXEIAwxrkS3yUxnWi
         sU7TN83UcIZg7SkcjDUDFctqaEnBmq220KLe56d34hOk/ni56/1vhA+L0Y0vVXbsqpho
         vRZOyTVtXnCMXu2phYBzf9AE1vhLMuNSssZDGFDHpcWCnyD7DuRNh8l90axbIqb0dxyb
         JKMw==
X-Forwarded-Encrypted: i=1; AJvYcCWA24goVu1NDM9B5NfW2Sw8Pipv7drM+um6aDfOK0uygRi8LOxWkJtHPOHRhbrKLdHQmc7eC1OW+ooVpSc7@vger.kernel.org, AJvYcCWycoHalPfYmKAS+v/v7MoA65TTxkOwiE1PhwfgE9KrwYZHvGeGvCKuyvnvrmfroT4B2rl9pSjOby9t@vger.kernel.org
X-Gm-Message-State: AOJu0YwwVklbgF7g8+X/Zz7y79bwHMqJoPyp5NNk5/eoK0bjCSap1+QR
	o/d+STc7EsW8Eyeh5My0Hj8/xPhOofFtPBDHxSLpwqhiQc9I1b9Zax9iWpn4I7s1febZte7Ef2n
	0+DNHUBewTyp3WBKfxmQoSpI84aQ=
X-Gm-Gg: ASbGncveLiipdQj7rSg75ar5HlfZhSqH6dwKPQExN+uPVNZkNYWJwxJmDTjLLQdTycg
	w8GNVklZe1ACxDgVD+A4/9sjfYdAgPZ+whY0zUdhrRlWAWefhWFTg5VHrZ9+1hJj27XkzuP/y6S
	jUC7og2zHo5cNGUi15D9x8hgk=
X-Google-Smtp-Source: AGHT+IGdUevWbt9B6OCFjrfKlwOyeQ+1e0MLr3UjHCkhv56/tA48akFvVsynr6iH2spJ/xGrmJk6TrqDw1VcLtJz89Y=
X-Received: by 2002:a17:90b:3d8b:b0:2ee:ee77:2263 with SMTP id
 98e67ed59e1d1-3030fe855d1mr26348075a91.7.1742892555925; Tue, 25 Mar 2025
 01:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324234013.140440-1-marex@denx.de>
In-Reply-To: <20250324234013.140440-1-marex@denx.de>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 25 Mar 2025 10:50:42 +0200
X-Gm-Features: AQ5f1Jp83_swMO_7jm3Y2fbbueh5o_M1drf9oc9W2FWr-Vtdud0qx3Z5t9ySw6k
Message-ID: <CAEnQRZB068dzjLmeoFdPtcX_Wc_Or0idd_J0OKi-UqgD=Lmcaw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: imx: document i.MX 95 Verdin
 Evaluation Kit (EVK)
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Conor Dooley <conor+dt@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, 
	Frieder Schrempf <frieder.schrempf@kontron.de>, Hiago De Franco <hiago.franco@toradex.com>, 
	Joao Goncalves <joao.goncalves@toradex.com>, 
	Joao Goncalves <jpaulo.silvagoncalves@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Max Merchel <Max.Merchel@ew.tq-group.com>, Michael Walle <mwalle@kernel.org>, 
	Peng Fan <peng.fan@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 1:40=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> Document support for i.MX 95 Verdin Evaluation Kit (EVK), which
> used to be the Titan EVK.
>
> Note that the SoM used in this EVK is a derivative SoM from Verdin
> line of SoMs, an actual i.MX95 Verdin SoM is under development.
>
> [1] https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx=
95-evaluation-kit
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>


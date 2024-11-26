Return-Path: <linux-kernel+bounces-422506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1A49D9A6D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF17284252
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A711D63D8;
	Tue, 26 Nov 2024 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0l+cgm8"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4541917E6;
	Tue, 26 Nov 2024 15:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732635011; cv=none; b=KYGB42Ur+RFACOWe3YlZK9DNPFJ27dl4NLIlBPovkwNJwv2LQyn2cnDAU1/+RbNJ2okm8hsYcTYV8xXvKuY5GTc0LFPcQSUDmIlezMVk8a08bOwM3ohsTl8h4Byh468VwPhXveN2mB8DnvsOm6GKmZyP1p6bJcIOIYzuO2LJcbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732635011; c=relaxed/simple;
	bh=3lCN6+M4YRWXxu55EQBJT4kfjQmI6NsK2j4LNx9CC/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YG1QYlv7JmlAtNKCQug3+DpVsCXhfsmmZBom+1Y6FGc/tIltF9lBJSlXCpMUz9ApHiLsscN/A8faAr4ir48wPSTANtrxNvFdwCeQdbghoi3ZPkzqp4ZE0k+Hx1DXZrlHouskPywI3ETpDoh10LAXH6+IAoL60gjPCVOkN7Ncfuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0l+cgm8; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-724f42c1c38so2826242b3a.1;
        Tue, 26 Nov 2024 07:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732635009; x=1733239809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lCN6+M4YRWXxu55EQBJT4kfjQmI6NsK2j4LNx9CC/U=;
        b=Z0l+cgm883SbWU1oQT1Zvgbj6yu2vAfbvWldBJD5JOD8lJr3BZ+kVU4HbqMu5MnLUO
         uy6ii9S7/tbcB6fheuYgYntloEpAHr/xyjCaFwnGZq8PGiJyBl9wQTtd2hCToOWGksHq
         UtTsVOa/cxWBlsxJwN9cmp3HDKyawYd4wHqXLMD1fN8XWW0aBpmBdyR6ZtnhZGFK58zT
         NApjpYWqpYAkcL+j2Pt+N5LERK7VIDKUqNNAWspldW3q8P9twLLFtKTUgxkQLuBZDDaN
         /9ymxyoqBEZ44rx85BhqRO2ZLQ/s7LLjmSVfN4LLGEokteKm4dCysBM0zIE02WeXF8SO
         dhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732635009; x=1733239809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lCN6+M4YRWXxu55EQBJT4kfjQmI6NsK2j4LNx9CC/U=;
        b=NrsloLBIfTWShSbDkc0NKJYs/mvTa5k2rPLs6iogZzuDy0yWiRKIyEQ+MyW3y6l+/G
         rovKsn+Mm4i675FTfo83MgM8U7o+9WXuWcD3NSA2tgEYbXTj7OMp7XkAcMXP/oeYshlz
         VzEnG7b82p9TzoSX57pAMNEwoYOdFvFHAdWBAACy15FCTM2R2DYQDZdCcPhRcmDeIWly
         KeD/of7+28L57+NtAo/dkaymM5g93XUME2BQwWyRWmbwFcV5xQfXLM/VppahTSnFBc9R
         sVrwXF+I3qXUqN11ozH1XP8qErSwoTEUzerxoCPxHeCTnSwzqKMHzhrsozdLNkfglmYp
         UvkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0ytaEZqHRWYzTEKYcZOgpa8ftYw+35FEk0eOb07SDpG5O5/uwx+8J/bbve5ii1rF74EDerrnl/hc8WCnY@vger.kernel.org, AJvYcCWWxiW3TTX4mkBjZRjGTTHrE7icXIFtt/rnjqkURATzjR4O9PF9cwWVAJYar5s0wfsC07BghERMUGfW@vger.kernel.org
X-Gm-Message-State: AOJu0YyQtHuw0mefBdiXp/bbu0ddlLA77D7fDrdha4b8taXMMWndaab9
	vQLbHMnD/hZKMjLmRQhZICQ7sT/QtwlzBPOYAcz/lJYIus6hnXZZsa3y0mIUfBDa6Rwav13+G+S
	FEKDOpeP9CNppbdoMKfvRXb0HCYKvNRwh
X-Gm-Gg: ASbGncvhV9wXTLnhsSisCM8ylx19sOwqNUKptG9atv368Wa9bNvvQdohjFPGBLc5EcL
	j5fT5ROnCibjj3tUu0rPYNrG/nvk=
X-Google-Smtp-Source: AGHT+IE+SmZiC8p1bNoQl+mNZuGid7/lVlvbrYFavOShe+NZ2CQZoGtsNSljGtzXmRs6oybFN33p4fu0cBJQOnn1jEM=
X-Received: by 2002:a05:6a00:92a2:b0:71e:f14:869c with SMTP id
 d2e1a72fcca58-724df5d4b2fmr22690572b3a.6.1732635009446; Tue, 26 Nov 2024
 07:30:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125152427.136883-1-daniel.baluta@nxp.com>
 <20241125152427.136883-5-daniel.baluta@nxp.com> <Z0SvF2tQR14jrHet@lizhi-Precision-Tower-5810>
In-Reply-To: <Z0SvF2tQR14jrHet@lizhi-Precision-Tower-5810>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 26 Nov 2024 17:31:21 +0200
Message-ID: <CAEnQRZAVmza+A5QC1Xq4dsw1WBtdp0EoM505+UzrCKe15+vqhA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] dt-bindings: clock: imx8mp: Add syscon compatible
To: Frank Li <Frank.li@nxp.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, festevam@gmail.com, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, aisheng.dong@nxp.com, 
	laurentiu.mihalcea@nxp.com, shengjiu.wang@nxp.com, iuliana.prodan@nxp.com, 
	a.fatoum@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 7:08=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
>
> On Mon, Nov 25, 2024 at 05:24:24PM +0200, Daniel Baluta wrote:
> > imx8mp audiomix contains a set of registers used to control
> > the DSP.
> >
> > The dsp will use this to acquire o reference to audiomix registers
> > and handle the registers to control the dsp.
>
> Look like this is NOT good method to direct operate these register. If it
> is reset, you should export it as reset interface. If it is clock, you
> should export it as clock interface.


Hi Frank,

The code to handle this is already upstream and used for:

Remoteproc

https://elixir.bootlin.com/linux/v6.12/source/drivers/remoteproc/imx_dsp_rp=
roc.c#L991

and Sound Open Firmware

https://elixir.bootlin.com/linux/v6.12/source/sound/soc/sof/imx/imx8m.c#L23=
7

I'm not sure if it worths the effort to refactor this for such a
simple operation.


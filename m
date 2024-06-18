Return-Path: <linux-kernel+bounces-218542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 643B190C1B1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 04:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A398AB21ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDF51AAC4;
	Tue, 18 Jun 2024 02:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGtMe32l"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C842DF6C;
	Tue, 18 Jun 2024 02:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718676324; cv=none; b=L4MINMMTcIJzFZRlOtQlZQqtpBsSdUYc33Xv0LPg1j/BuVp90gff1a068PZpQtGlI7d4BNFZ2vmZr3a0m5yIilHmlJAIQnqHihmIs2XWRr+I0qMZyskiGITD69PZWsAZg1dte+RoVkpt+dk4XIfPrlzRf7pkFQJ4Kj+1gdlDouM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718676324; c=relaxed/simple;
	bh=H49IrqUDcg3thpDEGnSkFiRW0yaw7ZnZfWWUN/Mp6Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yy/Twgj+Gpxq+VD8FSv3gaEgx+Ir9RR6Wfry2ehfLFy/SvCj0f/CbQlEAwgmkle6JYnI5NkqzPXGU1pSCCZvlA1wK7mlSNtuRj6PHDhL8mJfsKCrc3nuJf7b3LqSQGkOYuUsRI3q8qlvi/rTfJOpSLShQ45OIg7A2vsIUs+BLkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGtMe32l; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c2d2534c51so938375a91.3;
        Mon, 17 Jun 2024 19:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718676322; x=1719281122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UC4CCPVGAK+nftSKrL1x2cOea/22VgZIo6YoyrbFDH8=;
        b=RGtMe32lD57bZJXfD7wTkEUQBzyq4JCwielgVL+xDafdb2pHtZ/36Tx3JyIRwUm6c+
         fgotmk8dFuBMIGuOdjDUUZCLWAD+V3zY5E51cDAvFfDGRYzNkvhSeCFSPBucH2LzzY+j
         JM4AyN2kTzqqBOSgx8uySD3eKZMFqHRTRN/8ikz2s/SQhwmXVnturlq1mY0FNAWp6NeZ
         VXtf1GlraVAVn1xV9zoNCW0zcIjVMeWC8ayWv0cE8CexEvqA85MmvxmVysNF8o35nB4M
         qz/rNoyU63BF17TdwqbcoeOwAWoPQRDFZpTfuzWg8rnIr0r1GCHDXK8Re5nn0czDqHGf
         kyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718676322; x=1719281122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UC4CCPVGAK+nftSKrL1x2cOea/22VgZIo6YoyrbFDH8=;
        b=kwPZi7G1Bbd2k3KY9o9LusraTe5+SeuOYTwjQQ/es3x9z8ez7j7/4ZfZ+svdrP1Gxv
         1ykkwITMAiDP1SPchoS6Jbc1Y2I4KWheFEBckO5pCoqBHHOWG3jFAmHtmQx79UJ9gDjv
         9m30mU1f4FWxenOn/lhJGx7UTPuW9HoQq1Rl08T9+aGAurIvFGK5I7qxD5JxbyrKgPC6
         gOKcSWY98ALJUYg0b7FTrI3w8XbcJIY66uk4/k8xb1rtbBZLA9J4eDS/tUN9A+Xu9PgW
         /s/y1QnsIysaAZQC4rgAfUVEpbh7Ve1eqhaeoKHC409GNTSXxZBHyAkwJWu2zFpyiHbY
         qnPA==
X-Forwarded-Encrypted: i=1; AJvYcCVH1FTdbvYnSBsSRgL8+hL8LCKeolXJEzof7ixSm7fzGiSMjk3TCJ12/dFLgicgRn0p4K/JVP+JGhYQXgLq+2hrw/ZVu5FX4kN2/SJEtqhPdgO4U6MlziN4ux4zRge+ratr4/QKB9WmnA==
X-Gm-Message-State: AOJu0YyZ6ViVvT4vEnxLVy8nZ4zLrVbcTE/ZRdyDn1/x4Y8LCt86PF8m
	ONCwCA1p828NitrjUZ4I+lyrlvsa0DZ5WCN06B3crGn0P0IO55LmPzaSEQOEvsn2vzsWThvGiBb
	mTThOeL3VCpiegPno6RQd9EAiZT4=
X-Google-Smtp-Source: AGHT+IGgeBKXqH2kvONTccEkgODfF9O9I+AblF0WWQlymfGDP4JfA10Y88jwvdPmqB7Trl+X1SXo8LhJrNHDFFvMR4A=
X-Received: by 2002:a17:90a:fe0b:b0:2c3:42d2:ca91 with SMTP id
 98e67ed59e1d1-2c4da9cb5a2mr10866239a91.0.1718676322329; Mon, 17 Jun 2024
 19:05:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617223100.1539796-1-Frank.Li@nxp.com> <20240617223100.1539796-3-Frank.Li@nxp.com>
In-Reply-To: <20240617223100.1539796-3-Frank.Li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 17 Jun 2024 23:05:10 -0300
Message-ID: <CAOMZO5CwaXVzkJY+TP+JF78mv=9FfO2v8cFwXNiSNp+_n6Yk3g@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: imx95-19x19-evk: add lpi2c7 and expander
 gpio pcal6524
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 7:31=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:

> +&lpi2c7 {
> +       clock-frequency =3D <1000000>;
> +       pinctrl-names =3D "default", "sleep";
> +       pinctrl-0 =3D <&pinctrl_lpi2c7>;
> +       pinctrl-1 =3D <&pinctrl_lpi2c7>;

The default and sleep are the same. Is this intended?


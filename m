Return-Path: <linux-kernel+bounces-278241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8927794ADCE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D07F1F21932
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3761D135A79;
	Wed,  7 Aug 2024 16:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3gCmAAK"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B85364BC;
	Wed,  7 Aug 2024 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047072; cv=none; b=QSNPlz8MS+u/lrxCD773ASmBbOVOBMVOoXDTVRS3lrqu3vZcuc3OsvxIcgFfQqdxDf7LGGR+n6PbDvVDqpN2pUD1d5ni13AAMjJyXsRNtllsWE3gQhgt5+8AflAJYizTpWdRhSSsPdnsppfr4bSXDWqXaDNoG7b42azREshmy9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047072; c=relaxed/simple;
	bh=7PYhDLkb5CGgKvkzWQlcN4kr1/hoOgEEWyscq7uwhBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCgJXbsBnJaVKccN/pYTBUtjTPQcL6LbGf3AqwnOSSDshbzfOWsnoZNAszjqz/qYK7H+dDKUlqKUk/vPagBcKv1MjsVOZY/L7zfvyQ6JOmfirsO2mMqBVQkAoyaWerCfADE680wa8/AvSCiGKnPoeSc2dTHw35cbWhsbVm3Fwa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3gCmAAK; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52ef9714673so277508e87.0;
        Wed, 07 Aug 2024 09:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723047069; x=1723651869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PYhDLkb5CGgKvkzWQlcN4kr1/hoOgEEWyscq7uwhBY=;
        b=B3gCmAAK0k7zYwoQVsp2m3x4v89rX7gKyk/ZAauhoUk0+vV0X3LhLSBi2fdV1FE44r
         r2vi2KU8Sguk9iHpvDwSTGIf7eQEfi/QlCQ/wlJN/E35r/sW06HNGqT041AIlYn1hGzr
         Vqxdj8dQOLVYqUAjyGc2vB+YEFUG4ug3t88u+3OJmT64YLySDlLyJykGK65FuwU6wxaI
         JHqp186awAPjV64tXPWTKxOKVmIPjhGWaXib5hSicU0ilyJRXDeMo2jsf3xqG9Lsls2E
         tSt6x83bvdeOSIxl6czf+/DgaabBZ0cQ+2qWVcUfMJwjy/A6U4ABL8B0foVTFCbBUL2c
         x+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723047069; x=1723651869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7PYhDLkb5CGgKvkzWQlcN4kr1/hoOgEEWyscq7uwhBY=;
        b=qiAmAftbGSMkB7uoshrk3bp/RmA/9D2GTMqWdCioV3gutj7fD/8bl2qETCCZkA0/Yq
         23NSzKyvO+x7xHEz03AQT6Reqb+HeYk26MKdGWNSmEs1+MvljuMA4EK++I6WfQ/+fexe
         xxqbuN8Wx9hBp6DDWhK28BJh0keIBABw/SaBxPwvd/coW99h3df81b50xsOxsLIgVKHP
         z5Rx+Z5n3vZ3/X7kcE/0ECCSm1Nku9+CYqo4aJuOfpPe9t6a3ouso7KQNYq8JDB2yJoj
         OT5ux+nLLATZPEqBBurC8/GJiFylR44vfYz06wpErfbdZEIZUyQqrCjC3xjtYG0xj8hE
         XeJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlLDTOIoPvcfFLU9UojYMIUNLiI6jtQAV3DZgjFv08b30iZ4WiWQRwFQ5U9KDI6z8dhfwvagYzWACYYSFQ6yZzfzGsjswz5Ez10ftf2CVPO3HkCaKu1bb7B5/OXyxOD3GL1961/ug2tw==
X-Gm-Message-State: AOJu0YyUch326h2rrad7ZKEg408Xi5suelKEmoV0UUWIXfPcmHNNTADl
	eDX0xbpU8/RCQwgNXXyBruba8DaMFmMlZLZvvW6tGmRzbi/oQ8W4GJXzQOZerL7+CpFquYFpSs+
	oEsrhJDnrsJh3ygCGbp4VomHEkCs=
X-Google-Smtp-Source: AGHT+IHox9JCDaYxyNIZTGdSOmDp4HMcrEkIpYcD5GhRVV++7cQDvoYE/rWhIq9QG/msfeowwn5UpIyCKEG2ETJ1dw0=
X-Received: by 2002:a05:6512:39ca:b0:52f:3c:a81 with SMTP id
 2adb3069b0e04-530bb36e47dmr6914029e87.3.1723047068457; Wed, 07 Aug 2024
 09:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807-imx8mp-tpm-v2-1-d43f1e8f70ac@phytec.de>
In-Reply-To: <20240807-imx8mp-tpm-v2-1-d43f1e8f70ac@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 7 Aug 2024 13:10:57 -0300
Message-ID: <CAOMZO5AYRgao=1i1hnLCN1ZX8G66ysphykeikoDLEb420vs3pw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: freescale: imx8mp-phyboard-pollux: Add and
 enable TPM
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Teresa Remmet <t.remmet@phytec.de>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Benjamin,

On Wed, Aug 7, 2024 at 12:18=E2=80=AFPM Benjamin Hahn <B.Hahn@phytec.de> wr=
ote:
>
> Add support for TPM for phyBOARD Pollux.
>
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>


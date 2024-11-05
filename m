Return-Path: <linux-kernel+bounces-396288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA979BCAD2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2979B1C22384
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B7C1D3181;
	Tue,  5 Nov 2024 10:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/5UFAHA"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC591D2207;
	Tue,  5 Nov 2024 10:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730803724; cv=none; b=dRSqWlAETqQf+ri58yzmurdBWiPo6zsQC4cVBWC7sQrg2at0lhqzYL+ihfFnwnxCkIpIVtMwYtyBSYvXfL2WHgr8OH1DuN8GSIqyaGa4mwhhC2D6fhYYCYBT6q/BJMFjSPIk+b3bWBT/1kp/sBJdqDo1fWpQNAdD4DW9s3F3n08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730803724; c=relaxed/simple;
	bh=Htljkb5sM4UHGgyg7DdW14XUQpoZ89uy5qDRXjOLODo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZiUfXTgXt9eAiPN19bX5MT1Wl/csmdxAKbWh3ykZbU4B4DUHac/UOt9JwiwnhsmNEx9Tr9SW6Y5lLpxEGG3qV5JRnLSnEQMO0u9ozZfIlapiTgHH2kzd9L6d74V8GdfjEBpzPjIV+kpyAXETHuENQ1f/P9XUMPMdAkVbLEAXD9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/5UFAHA; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb3ce15172so58911751fa.0;
        Tue, 05 Nov 2024 02:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730803721; x=1731408521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEyErTaFotgB2UGJ1zywSwEt27+ao/0XQEozI2hYQys=;
        b=T/5UFAHAzMw8NfyRAqUOcIeyXoe+PBe2DUd2jjWxCq3Xegt6bD4wYGiCRVOb0LeGi5
         mzQAjGRtwLPjwb5+ValIcXEVRywJ6bf/bdsVFlCoMZuH7HvmNC6+Z2+AQ2kbnxlWNiT3
         hSHu/xR/x5uOeoBxg+sZn+ixxcmJHPxhD/ePKm9sgRl4pMjN3l6gP4C6ILterl0pcETa
         qw7hI5MWkS0EwSaUBplY1EXOe/7e30mmPceFBRqpFiKtCeGu9oyz4Ub3LBMpv09dWeRh
         +ak8Ve122cu7sKZ2nPHxU7m8+huI8SyOb4G0faI4PW+tQTMuCBYhblkaaY+6EYXbEDk5
         uaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730803721; x=1731408521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEyErTaFotgB2UGJ1zywSwEt27+ao/0XQEozI2hYQys=;
        b=Nz9mFhfBlpGLe+CALnfvggHd6Tl0xIpud6DgOErKHWnAXWiprq+MUVZ9OK8S2Vlr3A
         T/7CQXM35jim8XfkX2wPhK5bcymWztANz9upvffAbsHYoaTmqlsAm0+FKe06zQT2XlXX
         RnKUo3MveBvk9Mv7BIYB9TAyXjAalXnTvuM9lD64adqZZgP4dl28VTDRhTL3dsIscQw1
         DwfDf/pALy6O/F1UM6AeBv9MKxDlhRfJphg23NwmTX0oflizJFwGyV1v2rAd+KAhTatM
         eaq3HOSOgXEfivKr7kKv8syrbxfp+pOGRuIwrMR5wFiMnOKEYdV3qPKoFclTMIU8NFsq
         NfHw==
X-Forwarded-Encrypted: i=1; AJvYcCVHTUP/XzuRI/6kh0UX7c3LG3OZV7tFlvxf8A1inUN2ke9uz1K0MDUVekbiawM6XLHMGkxG9FZVmOlM@vger.kernel.org, AJvYcCW46qZxXaX7Y118JII+FMD6M27/Fr0uVqxcLJ5MVw1ReQBBfi0yqakBDCK0ol/aU0PUqRitbeYH5ChmFAqO@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu+zX8vRvpgZeE9lAvTCccsJGId15pjE7AqE4IUN3DU7ue2T/m
	AtRH/IhoBVwUPRUE14MZ0FBfnSTHIQPtjsyMIkd7T7zfjCaYqZ6hngztxLTl2ErkqGrgGM5ULUl
	ARoJKbjm2HqrjoB7OQ4NQn9gMRWo=
X-Google-Smtp-Source: AGHT+IG8lyaNErIet7KUEx+3Ey0QVQ7V/6TntPE+9Abi+rJ104OGSqERWvIyDPQsR/HAb5AxwbvCpdFNKdNm6ESk1Ss=
X-Received: by 2002:a05:651c:158d:b0:2fb:4b0d:9070 with SMTP id
 38308e7fff4ca-2fdef25741dmr57407361fa.10.1730803720362; Tue, 05 Nov 2024
 02:48:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023185841.1183706-1-festevam@gmail.com> <20241024-pep-proud-d714705c9ddf@spud>
In-Reply-To: <20241024-pep-proud-d714705c9ddf@spud>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 5 Nov 2024 07:48:28 -0300
Message-ID: <CAOMZO5BSZ4YAZ7Lqa3eGP9Wx=Ed7cgug==_UZqc7F57=XCJv3A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: timer: fsl,imxgpt: Fix the fsl,imx7d-gpt fallback
To: Conor Dooley <conor@kernel.org>, robh@kernel.org
Cc: tglx@linutronix.de, daniel.lezcano@linaro.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Fabio Estevam <festevam@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Thu, Oct 24, 2024 at 2:05=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Wed, Oct 23, 2024 at 03:58:40PM -0300, Fabio Estevam wrote:
> > From: Fabio Estevam <festevam@denx.de>
> >
> > imx7s.dtsi correctly describes the GPT node as:
> >
> > compatible =3D "fsl,imx7d-gpt", "fsl,imx6dl-gpt";
> >
> > Document the fallback compatible to be "fsl,imx6dl-gpt" in the bindings=
.
> >
> > This fixes the following dt-schema warnings:
> >
> > timer@302f0000: compatible: 'oneOf' conditional failed, one must be fix=
ed:
> >       ['fsl,imx7d-gpt', 'fsl,imx6dl-gpt'] is too long
> >       'fsl,imx1-gpt' was expected
> >       'fsl,imx21-gpt' was expected
> >       'fsl,imx27-gpt' was expected
> >       'fsl,imx31-gpt' was expected
> >       'fsl,imx7d-gpt' is not one of ['fsl,imx25-gpt', 'fsl,imx50-gpt', =
'fsl,imx51-gpt', 'fsl,imx53-gpt', 'fsl,imx6q-gpt']
> >       'fsl,imx6dl-gpt' was expected
> >       'fsl,imx7d-gpt' is not one of ['fsl,imx6sl-gpt', 'fsl,imx6sx-gpt'=
, 'fsl,imx8mp-gpt', 'fsl,imxrt1050-gpt', 'fsl,imxrt1170-gpt']
> >       'fsl,imx6sx-gpt' was expected
> >
> > Signed-off-by: Fabio Estevam <festevam@denx.de>
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Can you apply this series via your tree?


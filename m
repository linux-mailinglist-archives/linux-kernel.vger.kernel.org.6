Return-Path: <linux-kernel+bounces-328718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 464509787C2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51961F22DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727781386A7;
	Fri, 13 Sep 2024 18:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b="bgxjMJHy"
Received: from sonic313-20.consmr.mail.sg3.yahoo.com (sonic313-20.consmr.mail.sg3.yahoo.com [106.10.240.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C9112DD90
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 18:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.240.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726251867; cv=none; b=XgF0mcTVPROs4X9uLLhh6DTwIQIc8U5okq0BRWAjBu/xr/kPSZFvUAvLPh/FDkOnkMEfOwYYobC+D0JEohUPkRs7oA6F8w8tes6E5hNBBKQNfdtnQep0a5Jmsuu8zf8Owrg/e9oifkRwmztAZ/tUnWe3VLCAETRLMVgxQ5EkUh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726251867; c=relaxed/simple;
	bh=fRKox5SNoyy2vDPC3eBkvadzCRw1BNEcwpCRalvjwUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/yKU/E0tc80NQw2qsAuWSMFrHug2z2KfMnLprZSscDwZNSQX7UUIRCGb9aHXSr7MKUHvBwcuM+LOuLQnVZnEGUygpS5DqqlFckQEPNxEcTIuR2uXKtBmRScycFTc6I/K3dY0ab8gOVcDoG8bXv/O6W7PnWmUC2Ked1gxhM1D0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com; spf=pass smtp.mailfrom=myyahoo.com; dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b=bgxjMJHy; arc=none smtp.client-ip=106.10.240.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=myyahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myyahoo.com; s=s2048; t=1726251857; bh=7UOSrNM18in4I9n71auRdfBt2rYt1y64soBQ9GzZh6U=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject:Reply-To; b=bgxjMJHyODs61Cj3dQn9/jHSrHW2dS0mcKUIMMow0wpKDfcgyJbchv1njXSksfTYCQrNJs9m+ZoxKz4HQW7a1P9vaDSwEyytLhhBydoq+cTJaBZfMP8CHk2Jy/s4HhMnTF4V2rYsJzqaLxd8fz1vJeVvRUDqEeOaTF9vru3/DovNRzCewFK4Sx+2D9RFfiAanHPHLUnve+A1X3azAfy9EQLag3CcAULiCwByu3oQXi6tIPhh3KENjFXeG43a9XOJg/aPeQuBvxNEREr71BR/gXx1+sQ/Lt8N/duJFzqvSw8SNu074tmza2SRGjj82hmgVTPh3R5Ww62jaQGyYDnUAA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726251857; bh=8tB5b7dw3Pb0UR0SLsS1nXl4ujsnljARvGSzY5E3STX=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=tJleaYxq8QmwTnyyE9H19MDXIXIXjG0Y/dW6EOTUWVD22DjKk9/lsHgb3J6l0haXTmNVQX0Lozwm9GMVjYhnBGRrkoYh41qZi3PNwbnAP6n6eCrAIIC74t044zVlaGNz8h6NrSICTIjL0HxXldT3PUZYJUEUII1zbpI3u+vK/51COiQf6T41riMSGgaJjjwNZFF8itpu6qqG7cPYoslw+5/f9mkIrLifgt2/zPLM9cM2HNQB15QhSh18eRUKHQCk519nTU1mWHIyxDEyyrxTx7KsYT+5bDCEumBJqa0lCQtHgr8T3D4ghR4M9WR0npGy1acJ1zfpqwD38XrsuQuoxQ==
X-YMail-OSG: 3xtC2S0VM1kO6Z1LN.60ElWfoxDR3prrtX21M8wfWI2TH2kE8ctqbPJY98mwzPg
 ZIfE2qLJV2TBlB93v1TWESOVU_nJsOT8Oixud52nWW8bukc4m7CuEJqavOFHrBhkGD_GKwmCW7HR
 jEB_kv6iWjg5MbT9ifHsT1diH7f.SdAy_Fsa28O3k9Wxm6ouZXrZZs.Iq9qBKbzk1A0fa6DPiv8H
 9PDXJ7Yj7w.7weH_EsFfFMxs_WNSVxEqAI4wA0jOgFQm5gtlIpxFeONu2cbby74bOROUWrzzVM6Y
 PYM5ecByEs4UiWkS28T3V7SSVwoQFC6vre3e.qnWPyhBTB.E5fl9PTsL.0uQGmx7LTKdlnTOizn0
 zUVOypXMrEQEYDv8aXepskKZ2q7qPbXr5jLmCzoc8qz863a1ATrNdHrcOUBbjcaOJJVKYWP.73Qz
 XbiFllCBQLakB9AdIvbesssohizJ62ziziXfu.PxwGXkyh5jedaKNph.ZmW1HgK9k7300s6oHqci
 mXhWqb8hhyom_.l4UEt4x_z.NXlZ.opt0lX1dfExSTwTIrWcB8jg6HQnK_NE7oqDp6YRk8STZHwu
 dR_lx__OtGJ5I_7VJQpoLWKSuvB_4LanUOHiCshH3FTNkxDMYIOeVl1NdXqWMCe7mzNsPp0CsBK5
 pH3Km6xRwqJVBDD5ysYiqPLcwjsbKWEswkzjMXYQ81Y6.Ny0dwvVVraQURDbwIZ6lInq_8TKMmKE
 xg7RzfNiPMNVI8KuNeNK75I.f55D7WafPdRqnkZeUJIOBGocBTcUF2KR87yTwBXDMTN6yUwNRxeW
 m.hj9.4AUlwreydgMbewvK.gx51eJ_wfYLSkGz8NELdTxV0D7RJuwbSDCVL_jg28l2_KxXPgL_w2
 hCIFWhok3OSqRe9rEB2H5wZcKq9py29IYf_TOoY3xaiXqv9bXYfnllUsmrq0zu_zV7xOBtEMQoI1
 dFmHdxYrO16yZCvwY_KuVlDfNyh3osLacxssYm_06jr_Zrlprq14ZrSh6f2Cx_9ncVVtGzqavtmr
 dSlDSqOLV4.7QlDDBCCIVC4JIARz7cL01oZjQwTs3VVNij7avFiOx237IXeYW0Gmb72fsdZf1Ilu
 3d_US471O_COaaLa0OjDSKAsv_CEX1qyqWxTbXI7C9Hv6hmesysmySRWTGx896YQb7.r4cA1V1BH
 NG9phBz4cVvZc60_oDzMp_e42C86mDG1IMB2nyR.U0FgDIye81ujudMu5WcCPwsjw6j8rnl0GY3A
 TN0J.hTDSJ_6UVBJbXJYpUZQHUF3zals1uiWoKI0vTqCIlMXDaPDsAMricq05iPcJimoWwtnkt7j
 WjVEBTe2irOmwci5Tnk.oa8ZOu4tiqhRg4fZhMQeG0SXJMYrEl7uDkJ8XotFTHYzs5wSMf_Mqsn5
 5uG7Zx5DOeKfNzzWPm3l9JJijVwW07zl7Lj37OtH956SSjWWjC.e.QPsPmCoNUo4tE59M32Krr5I
 PPeVp6nCYWNH_.bHNTnGEgBnqn_ci59lVbR72kv_hszi27L.MYJwLH1M9ukaB3NeInSeZIkA1ZCN
 ot9FkcmN3A7eXH0xkhiPXE47JgsTKTp8eBR5QH21jdeJuk54NcKyE2fCB80LZ70vuP0XuVYYTtTy
 Z0lc9nEqaJjbFUkHOc0iSA7ScMJE8t4oZ0HEMe6IVP7i03JAGTQi1l6pSRrJG.TQZ7jMVayBDd2u
 E.VLRej9wTkQugfioQQ8R_7Swwyefo0yl0DNwzhqp3g74qn6a1klNyNdqvJrowXI_7leFIRBww1i
 AJn4kcaLbyqwOqXJi30.2AOlPl2yHPdO8uGgrkxVd5WInUR1kBCR1qPF4QWOdMcrT2HMd5Pzuz4u
 _HYnpy6Sveo2_dJV8tbn6JtQYXbu91TS5x13RJf_Zj9FmB7eAgRxmuQOHsTmKfTRjFSlPp4abDNA
 Es9XoxDTVaM_oBhF.23RPYv9rjZqYBHd95vu3yW406Fp6xc6IaDkxtvAiWUKStIiUe8m1xb2U8Rf
 MxXMQidPhQ944CkH4OlMNWhyD2asHYdmpkNouuQfl0JjsJf2R.cbVZ98Ys0TBNz6xNX6qLt2PtW6
 y9rRdvnr_Ajm8l0ZCQ8rzgQvguo_dhiL.XFad9FKO_f8yHnx8m6qzaP772CdugIoQt.AHGm02Fuk
 ncEYUrfbR4IBFWqhBl8IRhZv.hTq.byrjtretzriJ0zyjx5uTm3tTO4QeCXzfQ.Z68PE9bn.QgFs
 9XZHnPtqWrSSyohJ_9eKyKUggIM1Bw8amD5NdikEEi6AQSjjCOISm
X-Sonic-MF: <abdul.rahim@myyahoo.com>
X-Sonic-ID: f49a7cd5-60c6-466d-83c5-5c27634a8619
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.sg3.yahoo.com with HTTP; Fri, 13 Sep 2024 18:24:17 +0000
Received: by hermes--production-sg3-fc85cddf6-5gxlp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bbb2b3c39204d44886eab7401e7346e9;
          Fri, 13 Sep 2024 18:14:05 +0000 (UTC)
Date: Fri, 13 Sep 2024 23:43:59 +0530
From: Abdul Rahim <abdul.rahim@myyahoo.com>
To: christophe.jaillet@wanadoo.fr, rafael@kernel.org, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: thermal: Use strscpy() instead of strcpy()
Message-ID: <f5v4xfazs7i5ukiddclapab35fgze4waf6upfurc3s6tvm5zvh@madgaseqrqkt>
References: <20240912205922.302036-1-abdul.rahim.ref@myyahoo.com>
 <20240912205922.302036-1-abdul.rahim@myyahoo.com>
 <693e5874-30bb-4076-910b-feb6488e7d85@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <693e5874-30bb-4076-910b-feb6488e7d85@wanadoo.fr>
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On Fri, Sep 13, 2024 at 05:17:58PM GMT, Christophe JAILLET wrote:
> Le 12/09/2024 � 22:59, Abdul Rahim a �crit�:
> > thermal: prefer strscpy() over strcpy()
> > 
> > strcpy() is generally considered unsafe and use of strscpy() is
> > recommended [1]
> > 
> > this fixes checkpatch warning:
> > 	WARNING: Prefer strscpy over strcpy
> > 
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
> > Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
> > ---
> >   drivers/acpi/thermal.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> > index 78db38c7076e..a35e40976763 100644
> > --- a/drivers/acpi/thermal.c
> > +++ b/drivers/acpi/thermal.c
> > @@ -796,9 +796,9 @@ static int acpi_thermal_add(struct acpi_device *device)
> >   		return -ENOMEM;
> >   	tz->device = device;
> > -	strcpy(tz->name, device->pnp.bus_id);
> > -	strcpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
> > -	strcpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
> > +	strscpy(tz->name, device->pnp.bus_id);
> > +	strscpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME, MAX_ACPI_DEVICE_NAME_LEN);
> 
> Why the 3 parameters version here only?
> Is it needed?
> 
> CJ
> 
> > +	strscpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
> >   	device->driver_data = tz;
> >   	acpi_thermal_aml_dependency_fix(tz);

You are correct, it's actually not needed.

"The size argument ... is only required when dst is not an array" [1]

And destination buffers here are actually arrays
from `include/acpi/acpi_bus.h`

```
typedef char acpi_bus_id[8];
...
typedef char acpi_device_name[40];
typedef char acpi_device_class[20];
```
https://docs.kernel.org/core-api/kernel-api.html#c.strscpy [1]

I will resend this patch, with the parameter removed.

Thanks,
Abdul Rahim


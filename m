Return-Path: <linux-kernel+bounces-544936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E36A4E704
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C4B462C9E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832D8292F9E;
	Tue,  4 Mar 2025 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wMw6IyjF"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17495292F93
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105337; cv=fail; b=hy4bNtBMzCB41xJtYgQxLmvuFjdkrRT89apME3P+IVnC33f7WvoigMqclD60c5obQNrCFemzhl7PIHlG9YTQqeRyqowH1Ntv5Q+tmDcofbXhtJm1l0VycAwp1zYR2eA/zMtJ/Wf57l76LUYUwxF2VpPb4BqEpNCMX0cLbCgTsLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105337; c=relaxed/simple;
	bh=jDjHq/WMj3cfpLHU5/vJl8bgPYFOO4LeedyyZ+V1aB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXzqSuOKO2eDLp4qmeSDTn/rPSn5lTJVt9fW0y9JGmJ3Pn9TkYpXm/GlCnLUKCU+RW4WG/pnxccWLDEuKTAQQ9szXn3lTxyuSSDXwuLTqadpZ2mpJjaHyodzwtPnY0xnqb8vlH6O5FL4xXlbwUrqCV6D12pEEaXsWXdCXQ2W3gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wMw6IyjF reason="signature verification failed"; arc=none smtp.client-ip=209.85.218.49; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 360A740CECB0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:22:14 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wMw6IyjF
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gs84BKgzG2mx
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:20:44 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 5C26242731; Tue,  4 Mar 2025 19:20:38 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wMw6IyjF
X-Envelope-From: <linux-kernel+bounces-541458-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wMw6IyjF
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id C964042EC2
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:58:34 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 7B2642DCE0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:58:34 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DEE17432C
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0C71FBCA9;
	Mon,  3 Mar 2025 10:53:51 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9FE1F9F70
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999227; cv=none; b=d3l2vOyiWZIEXIp8tiZoAE6LhMa8srPN6zO2g7xwjQo8bF85t5ggopseQNA7vaEgMsyXzEI9/GqORY0us/PSvPNlVZsOO5Q+gFpAQg8mhJ5rlJIchz1aEbZUr/+f0aD8qpTsZbpZlLtnjx4lsxGbtjgp4B04zmGiw/EHkEIHHP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999227; c=relaxed/simple;
	bh=Kj3rTWIoDmPt+SLfBxnJONe1BtBMU+vHFup+WxsAQuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E00wejY6/WFym9yPOnwkX+mzIRyobMUrB0r29QAi1u6DmMwbQVKRA1QSjpHEE4+GlBIkC76udrbBTeXty+OXY4U0g7xd8JFtWUOEgNlDc8LOqV7FwJyBv5x4m7cRgJWb3akh8lf+PCbTjfETh9HP6cAKKcFSnz5TS+TN9Vl4ESM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wMw6IyjF; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abf48293ad0so340420266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 02:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740999223; x=1741604023; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gSR1fSju11GwT3CmV4RSTFrBeqMpZeqjsL4Nu+lUL6I=;
        b=wMw6IyjF1vxftNpwe3TiSYPJorx0sH1PenG75GdY8cZ3SGYvNdyoY65gyx1fwqGgq3
         ccKosqU9GeKwLs+tn7feTXe96ARw33I00otRm55hQYokhl3hnMLdUfivY1aOkLFLD6C/
         0arSEXxWRvqwl6ZcAqiwNrkYyv1GJlBtLo9obA/ntCpDrZ6/r53LPK8BK2UaiNa50v+c
         irXlpOwMkmZtoWawPh/0Ur8DAdwXZg9mJ2Yi1X7G0tGFa+yNjFqq8Qm4O8FmUTT+mX7t
         umnUJw43gjFW+5eEvl7ftYizOoaLde7Yzc4cMOp5NA3gb0avHVW+ceQlfxsaB8ncnaBZ
         0W+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740999223; x=1741604023;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gSR1fSju11GwT3CmV4RSTFrBeqMpZeqjsL4Nu+lUL6I=;
        b=bx3zY3LvKjN4dI3w/crqn8C/ThVwqbnVh7IDQerbUMpGJx8FKkAXsXbglPxyPoDFLj
         4A4xe132NVUnFPE4+4pS8K4SCEqWiylFM6ZpI7IaaNQNk+zrv44y617BRnl4EqqrBQ8Y
         RfMEWXs+UxmzIpmu1KJRMnIDkMLKKLbmXBSwU73mLem1aycNzIcFcGMEHr+p3BrzqQZH
         f9wL4bxDQrR0B1xqjEQ92/t5ZEG2q43vphDMzaZJnMjjZBo5S5+X7aJLhzGeXeHL5kcK
         h2gdorqPQn7E9ums+qTY82fefbrKZC4OxH56Sl+LcqVF/jPcKQidB84eNDLSIn7f4sIq
         8zWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLwvF8lkjtHHrJOrnd3GHUeo7kwMN8XGVFhrl7Yi0yUqF7fDDjXd2ZgHcf4tee7fzVFushIk/6yeBNHyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPMcejJeE11D6q6jrjYDiVLaxh8xG5bYadj1ctmixDb5Eyy3F6
	b5Up21pN+TMJd31Oo1Vd9u7tFxDUZaagjuEMDmN7XcTbJCWjHvWyrArlYtirVwZ0+VoHtIe0WIg
	R
X-Gm-Gg: ASbGncut36iTUFUjCF8kFrBl5ol1zdDDoBQRvf0MHS1nTBIHTmryUlXsyA9vcw6DsRM
	inaeO9Gm0XnSlB7mgyWIftamL5aybRKs7FIDSqe9lv1fkXa6MUQ/0Fj02sKjclMzlrfMiwAZ79K
	2lqHMIIn6TaKoxrCX36nzLrsjydp3Jkom1/hnruoP2N/d+Qbqnvlbc519E2QUgES+tMbpmMCeln
	uyYy5OiYtsP1c00A4Kz9hjK6GhSDoy0HHy+igFtyG5yfFJzGOkJa5NZAxjTUZbbC5A87k5E6geO
	Qlq0v2rR/o0kENxvNyapU41RCPqg2dIeILxD3hni21dEc40Ilw==
X-Google-Smtp-Source: AGHT+IF878WM4Ac0lwU3U8jWhqiDwhdQ1OhLRZrdD2ubBpWef4yPS0ciLaeLOsRMTVQEjBD/4tiTTg==
X-Received: by 2002:a17:906:7310:b0:abf:13cb:c411 with SMTP id a640c23a62f3a-abf25fabbaemr1560894766b.18.1740999223509;
        Mon, 03 Mar 2025 02:53:43 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf55e88748sm421511766b.54.2025.03.03.02.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 02:53:43 -0800 (PST)
Date: Mon, 3 Mar 2025 13:53:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, kernel-janitors@vger.kernel.org,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Antonino Daplas <adaplas@pol.net>, Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Yihao Han <hanyihao@vivo.com>, cocci@inria.fr,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] video: au1100fb: Move a variable assignment
 behind a null pointer check in au1100fb_setmode()
Message-ID: <47c37d1a-5740-4f48-ac0f-635d8b6f51b2@stanley.mountain>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <86551e6f-d529-1ff6-6ce6-b9669d10e6cb@web.de>
 <3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de>
 <ugymllbkcsg22ffgyofvkquh5afbvoyv2nna5udmy3xfhv2rjz@jhgghzldzm4u>
 <eebf8c0c-7a6a-405f-aaab-2a8a8c2bd91f@stanley.mountain>
 <hwk2nf62owdo3olxrwt5tu7nwfpjkrr3yawizfpb3xn6ydeekx@xwz7nh5ece2c>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <hwk2nf62owdo3olxrwt5tu7nwfpjkrr3yawizfpb3xn6ydeekx@xwz7nh5ece2c>
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gs84BKgzG2mx
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741710060.87586@TKM3IF8+b3cIR8Ce0a1gvQ
X-ITU-MailScanner-SpamCheck: not spam

On Mon, Mar 03, 2025 at 11:30:46AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Mon, Mar 03, 2025 at 01:08:29PM +0300, Dan Carpenter wrote:
> > On Mon, Mar 03, 2025 at 10:19:06AM +0100, Uwe Kleine-K=C3=B6nig wrote=
:
> > > Hello,
> > >=20
> > > On Sun, Mar 02, 2025 at 07:02:12PM +0100, Markus Elfring wrote:
> > > > From: Markus Elfring <elfring@users.sourceforge.net>
> > > > Date: Thu, 13 Apr 2023 21:35:36 +0200
> > > >=20
> > > > The address of a data structure member was determined before
> > > > a corresponding null pointer check in the implementation of
> > > > the function =E2=80=9Cau1100fb_setmode=E2=80=9D.
> > > >=20
> > > > Thus avoid the risk for undefined behaviour by moving the assignm=
ent
> > > > for the variable =E2=80=9Cinfo=E2=80=9D behind the null pointer c=
heck.
> > > >=20
> > > > This issue was detected by using the Coccinelle software.
> > > >=20
> > > > Fixes: 3b495f2bb749 ("Au1100 FB driver uplift for 2.6.")
> > > > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > >=20
> > > Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> > >=20
> > > Should also get
> > >=20
> > > Cc: stable@vger.kernel.org
> > >=20
> > > to ensure this is backported to stable.
> >=20
> > It's not a bugfix, it's a cleanup.  That's not a dereference, it's
> > just pointer math.  It shouldn't have a Fixes tag.
> >=20
> > Real bugs where we dereference a pointer and then check for NULL don'=
t
> > last long in the kernel.  Most of the stuff Markus is sending is fals=
e
> > positives like this.
>=20
> I thought a compiler translating the code
>=20
> 	struct fb_info *info =3D &fbdev->info;
>=20
> 	if (!fbdev)
> 		return -EINVAL;
>=20
> is free (and expected) to just drop the if block.

If you dereference a pointer then it doesn't make sense to have a NULL
check after that because the kernel would already have crashed.

In 2009, we had the famous tun.c bug where there was a dereference
followed by a NULL check and the compiler deleted it as you say.
And then, it turned out that you could remap the NULL pointer to and so
the NULL dereference didn't lead to a crash and the missing NULL meant
the kernel kept running happily.  The remapped memory was full of
function pointers to get root.

We changed min_mmap_addr so that we can't remap the NULL pointer and
we started using the -fno-delete-null-pointer-checks compiler option so
that it wouldn't remove the NULL check even in places where it didn't
make sense.  We also started doing more static analysis.  We've also
tried to randomize where functions are in the memory so it's trickier
to hardcode function pointers.

A couple years later we had another bug where it turned out you could
still remap NULL.  I forget how the details.  No one wrote an exploit
and it wasn't publicized as much.

Anyway, none of that applies here, because this is just pointer math.

regards,
dan carpenter



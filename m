Return-Path: <linux-kernel+bounces-369757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1E69A2237
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525011C21A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 12:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AE91DD89A;
	Thu, 17 Oct 2024 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjBOg+R/"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CB71DD861;
	Thu, 17 Oct 2024 12:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729168181; cv=none; b=mRAXBYkQYLkl3AZZ200stk4vAw7Bzomwf9b4xt0CCgoL9+5wTtIE//P7CNAV8hZHBZUQ+C5U3p62Anv74sVQ5hLGNPTMJLOO0taevyTh3nuC1YqpdA+dzCuzhEF9wqYJmbMORNno8ISJKy7/JkFMC6w6YpN+lUeL++xcWoFFvf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729168181; c=relaxed/simple;
	bh=uBNdVo/uyyko8HmVrmGuRG2dupFW+2pKj1lgYwhttK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sURqZ2vRBQ2dk4lPEtW+rGKZ/zpZfoP70uxMiG5FIbywS8JTjRiXeBxQuylbZJX39CYyd8mWOgND0igMOzZw3yHn+ZfZAOkWuA6wZc7wXCebudpnSuDvR4yeOkqmd+nAJ9YQALdh2Bu9tolms7A4wT9Byv6FcRhDbdieTBodxfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjBOg+R/; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb3da341c9so9196651fa.2;
        Thu, 17 Oct 2024 05:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729168177; x=1729772977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBNdVo/uyyko8HmVrmGuRG2dupFW+2pKj1lgYwhttK8=;
        b=kjBOg+R/ETXEMbbX3keLV4Xqul53ShCw+wHlkRYzupOmqsrzQr2L9nMjsXnEtkNIBD
         cy8uq5ueH4Zbcd7OTksjv8vw0VrpvF8KWArnqrTuC11rrF3mUGEljRn7N5tRRdLcte4G
         y/F0n/Ohs/JzKtyiafKko02qkQcjzNJW9yBvpHZ4S2GA9Cl0j0WOSAGh34jWef4rM4Vm
         Mn8Yx6I+iKXsdTa4DuBho+dqwr2ifA3tA0/LQDGOHvb+oOm1dllelZdXzQ2mQ8PAluPK
         0gKbziS7ilo2ebXLSaHVAnYwDRJMwZN6oaRRmglKTyEEaGWDttRuGeoPw9qmxx1DX/KF
         YC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729168177; x=1729772977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBNdVo/uyyko8HmVrmGuRG2dupFW+2pKj1lgYwhttK8=;
        b=jJEltzPgAMbl7rbgf42jYoLuQLg8Sr/Hx4MteeAu12Kwez9A3VF0kn0a89fBSWMKDi
         5+YMxjRM2prPtMHQXMLKdyLuVWaFpSbNqSlmC5f1eyEekZze3md9KSlgAY/LzSQ0mvmP
         OKNEDO1rSEDzCH65NaT/pXc/5MJdkb5wXb1G7yhzWmLCR9eJeE50pdGXzlSa8p/NkrDg
         Cmh5fzj6QGuoNVgIdybCUdOXuQ9jaR6DW4gWHPJNvBTfAMTaqcyVhKA2EGANXCNdWz9F
         pGxy0hpPH35IPoaEn8hB6VqtUuUAcPFMhQsm9dhX+ocvfGQdOzObaHpaQ7F8Qu3uo95C
         C6MA==
X-Forwarded-Encrypted: i=1; AJvYcCUUbXeFE2ZINjIW8+N17JBwuK70jtLPoXMO28yyaTIgVMLbGfCbS1vJiAsFzUZLBxz/6rHxVditNYOk@vger.kernel.org, AJvYcCVjCfJ6F4X07OprCdDeysEDi/G8P4JYr8yso4jSqQDOY6qfpf0exaqtxvlK0v0jqrplouxnRQrZ0ybwRJbb@vger.kernel.org
X-Gm-Message-State: AOJu0YyhyhjRsl9z23lVxAX5883GclvjuRS08SF08VYz/6o9pqZiJx+Y
	QyAB9cGqs1rBqlissZYMr1vt63fsu7Q1mk6AR9KTh56Uu2w5t2ptdi4zIJt8++AlLTE7bgKVNIF
	pZ5NhnMKFKXVpasTGVdJklAQs0uI=
X-Google-Smtp-Source: AGHT+IH+wIkNQQJwv49AlH/Jot7v0LyPIXnBGMQnVxq1LQbrD5aQivp1GxINI83KObx+Xsyqa1ZfQiYHil/PVU8jViU=
X-Received: by 2002:a05:651c:546:b0:2fa:fc98:8235 with SMTP id
 38308e7fff4ca-2fb3f30d3aemr91995251fa.42.1729168176388; Thu, 17 Oct 2024
 05:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010081719.2993296-1-lukma@denx.de> <20241010081719.2993296-2-lukma@denx.de>
 <20241017103534.259584f6@wsk> <CAOMZO5DkmU4C0YQoVwCbHTBo=DTRGcz+9K1qHY=3V29eWAfEKQ@mail.gmail.com>
 <20241017141818.2cf462ce@wsk>
In-Reply-To: <20241017141818.2cf462ce@wsk>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 17 Oct 2024 09:29:25 -0300
Message-ID: <CAOMZO5AdrZTNpkSWn28Lc2yp8vgCGgE-Yq_Q7z0OfmwY=CjdZA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] ARM: dts: mxs: Add descriptions for imx287 based
 btt3-[012] devices
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Stefan Wahren <wahrenst@gmx.net>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Thu, Oct 17, 2024 at 9:18=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wro=
te:

> Another option is to adjust the
> Documentation/devicetree/bindings/display/panel/panel-dpi.yaml to allow
> only single entry.

IMHO that would be good.

Please submit a patch doing so to get feedback from the DT folks.

Thanks


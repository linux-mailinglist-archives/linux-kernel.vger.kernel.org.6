Return-Path: <linux-kernel+bounces-428889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5829E14A6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3076D160361
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD761A4F2F;
	Tue,  3 Dec 2024 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="5mreDrvi"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068BF1B21AC
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 07:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212383; cv=none; b=sB+sxW5k7/zgrq8o5xsM/BFr7QPIzattoZR0HYUBDSvXpq90iEIiJjrbR8jJr0eUcv13/CpRAOvOua4U4mU4xWFAbI1t7uNdHmnHkt6v/UXDvDlTFPqz8lBWUaI2nvASCTBLBslSiFYvvh3M6OzqHn3b7HS4Oj/5tgVQy8tEf2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212383; c=relaxed/simple;
	bh=7rsJx8PPlBUPhNYZpY4C2T1GcmfaUB0tv/4wQt6eSwQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qPlnX6HbMWJjPXGKPx27I2n8X+Jk24FL6LghaIDk+Hp4Mfs2PbfeWv28NJCDIYqUz1geitH8VLrMQs7d48LviFa3kXWFG7v3q3GTtDreeVvHLhmdnRxMRs0nO6iLwiAfO/aQigvVUBo8PbcxS2rM91XKQ6sxWewsS6ZfPpu83TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=5mreDrvi; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cec9609303so6137326a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 23:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1733212380; x=1733817180; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0D7zw9MHhki0fQyrcbsaXtFGQSkwrEFiOvoXEAaY/xE=;
        b=5mreDrvisXdmU0+p8DFDxeGIiyupLJoDkLv8XDdd/CHi1lEy02hanxmk6zWLfyowjR
         NgwFRMJhnZUkHQCmbdMAwZ9oaIgmrnI6bHF0UbKkxXXBX4idrgEOQxE1V7WsnQjPqMcK
         LWB5Wn4HAXF6vAVBCGDeMMrC9xLJbivTWv/Vw68v3bxumnEP+D8B9s4De3u46ttvBdI1
         R/5OB80A02susf0LbhHs3YlOcHElYWGW5LRqF5prvB0ohAq1rcZKHjqZQ1o6qS8bvAfB
         uW/d6CyPf2N+HUBOkMofkRBU6pBkKW7m9DyGXnH3xkl5iBb9v2C9eUBTS0B9samKgHCW
         /EwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733212380; x=1733817180;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0D7zw9MHhki0fQyrcbsaXtFGQSkwrEFiOvoXEAaY/xE=;
        b=UUdgxeW/GevEqqdT7DloVFQCLsFq3wTepnCL81wFNbkO5ERPUbv++4JqC742tUlIFj
         MEmKniPh0sJ09FJfJKus1qx6PzhmXxVjyQiJ+bfmzk+gkzcVXrnO63cfH5oNBzIKYYKG
         AK2rz84KRau6Mas1+nvgdQ7BD1oVKK5++rc4R+2hhGczUCUGhE6eYZxAOlwtsyfzqbRj
         Fq8Qp/hM+3GqAvZ/v2pVWPpIqfXzu7pSAk+UyI1BW+/4YOuyOsm7rlPqbv3xOhSdSC5l
         F3/SVRspPW1oy6gMddmfZyLxj+Ws2G1bajqCWDsJ8g37iSu3LFcvL73bhiCMVkfpFIlt
         UBIw==
X-Forwarded-Encrypted: i=1; AJvYcCWZSgzZPuXwTFH26QGQDr85AL8Umlk1KECcyIXisFSS5WHBJMh0+Iava3s3dMInyHXYPbRDf5diPD4r9yU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3sO9v9FJq18b6viTtgX95nOriPTU5EYQ87QdJLSD8M6I/jLeP
	YxfB4D/ethdd7CF+zi2BC3STeq3Y74+Otg//GYQ70i9E6WNsvCreibn6Nby0/kU=
X-Gm-Gg: ASbGncvlLVpR0Ifr3wUmlVln43es7/SxomWHs76D7j3carbMVXtQXKqAvUxGWbnklwG
	UZCSq4ZF+aJKCBRHMGKQfPDDoE1o/9JtRNRedOeGi6QAmMdVj8IYQg7cnWRS4oe1xFNEhMfXdX/
	O2e8emd6x5HDBcUnixMcun33MaEete+YpnusblVlYW9hRI5IYEZefW/4/R2WrHp+ZvJ6zIjezuA
	dqO+155O9BaTvRJd5sGLw8MsO5qrWV4iBK5oWoj9/UGzdIso6576ypTl8hri4v1eNXzlfp/YZsj
	mnKNWXYtF+57vwSNa84=
X-Google-Smtp-Source: AGHT+IH5Y4Euy0lKtptex0iUPrTdDlymLHlyKHDlm+teFEcJLphIHtL9LraZ6mJjjupisyuttL8ryg==
X-Received: by 2002:a17:906:1db2:b0:aa5:152c:1995 with SMTP id a640c23a62f3a-aa5f7eefc47mr81228366b.45.1733212380291;
        Mon, 02 Dec 2024 23:53:00 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5998e771csm591681166b.127.2024.12.02.23.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 23:53:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Dec 2024 08:52:59 +0100
Message-Id: <D61WIF2XWKL8.MWU6PK2XGX4F@fairphone.com>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: power: rpmpd: Fix comment for SM6375
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241202-rpmpd-sm6375-v1-1-12a4f0182133@fairphone.com>
 <yo5cc3cvvwwdrqrrgwlquztj52sijip3ffyyqag55jrnztxi2m@hn75ylkhnxie>
In-Reply-To: <yo5cc3cvvwwdrqrrgwlquztj52sijip3ffyyqag55jrnztxi2m@hn75ylkhnxie>

On Mon Dec 2, 2024 at 9:00 PM CET, Dmitry Baryshkov wrote:
> On Mon, Dec 02, 2024 at 04:45:02PM +0100, Luca Weiss wrote:
> > During an earlier commit, the comment from SM6350 was copied without
> > modifying. Adjust the comment to reflect the defines.
> >=20
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>
> Fixes tag, please.

I thought for just a comment fix it's not necessary / desired.

Anyways:

Fixes: 2d48e6ea3080 ("dt-bindings: power: rpmpd: Add SM6375 power domains")


>
> > ---
> >  include/dt-bindings/power/qcom-rpmpd.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindin=
gs/power/qcom-rpmpd.h
> > index df599bf462207267a412eac8e01634189a696a59..d9b7bac309537cbfd2488e7=
d4fe21d195c919ef5 100644
> > --- a/include/dt-bindings/power/qcom-rpmpd.h
> > +++ b/include/dt-bindings/power/qcom-rpmpd.h
> > @@ -65,7 +65,7 @@
> >  #define SM6350_MSS	4
> >  #define SM6350_MX	5
> > =20
> > -/* SM6350 Power Domain Indexes */
> > +/* SM6375 Power Domain Indexes */
> >  #define SM6375_VDDCX		0
> >  #define SM6375_VDDCX_AO	1
> >  #define SM6375_VDDCX_VFL	2
> >=20
> > ---
> > base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> > change-id: 20241202-rpmpd-sm6375-06582e126d7f
> >=20
> > Best regards,
> > --=20
> > Luca Weiss <luca.weiss@fairphone.com>
> >=20



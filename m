Return-Path: <linux-kernel+bounces-334975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0970497DF21
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 23:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62FDDB2100F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 21:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516BE153BF8;
	Sat, 21 Sep 2024 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yd0aZS+X"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B86D18C0C
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 21:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726954997; cv=none; b=sVmAmBrOqtFbxlx687gcE+oM8R6fYwrfpvYInRX80LqwXo3Kpqlmf46sZ6I/ExRDziQPiMYqQ2vvV2sChQrel5uM1RvurkAYvhROXzxm8vQMYNFRmC0fSNitXrSYHCgoWBUPd05Hv0j9cNeNdQM+eBdDDbHBqh+nS50gVejfrHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726954997; c=relaxed/simple;
	bh=xx9cnyaQk8owjM+Fhi+pz3uyfUXXmLCkLdaXxWh+BPg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tQaObiQrzU6XaGsI9b/EQgscRZ3OUnzWXpHl7znqsyQmq1aMTOYJLQ/LaNh6Cv9dBvRSQYCpNfj1OJtvN3lgGaNNzDsiUEMU6YcCnDsqTBcdAM2C8pRYDxcztYtferSt43yfFKfOLL6npA/22TkO5sQ30jJUtt3YUKaY5w1G7Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yd0aZS+X; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-375e5c12042so1700371f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 14:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726954994; x=1727559794; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yb4OyiPNxrTvGPVFmvMiyAR8oFtRRhpHywjs9QOCzAQ=;
        b=Yd0aZS+X4cvjKlkP9f143/TZhO5V5XpBY0sXGE9EazmFe4BVdjvpU2ABphTlVKw5dM
         T8ccc2WLBxLuYS3ji5uwxmYgf43TmQzyoP36pROL4AB6wuWm7+rrIotbSAwJdbCXQmqg
         LH1Kz8u3Q5KSkTbsm2TY3uh286DTzJJg6EhMHZjuq/aaa3/4tf7Reft5ZzdqOagOwqCC
         oGjgsvfoUvoINQQbuwDwI9katllEKWwnyRBuA4yh7NrLmeMRc6Nb7u04+O7Ag0r+m21j
         HMfivVedHaXhwNjutILul2eTGQQ2FXVyvH18ulVZXRUjZntFR82WwYbc877qKw3vziPa
         SfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726954994; x=1727559794;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yb4OyiPNxrTvGPVFmvMiyAR8oFtRRhpHywjs9QOCzAQ=;
        b=RA/ySZrR936juVmEKbUxZ1TqYiiPFh5oF9L44Ay4UgF1EfiAQw4Cw1RGLQWfbAJkov
         GAZJ/yWIwyOIJfmacShy1XGmdZTk9r9wl15Js2VfykJWNyDQm7ONvTzZ1lQuhLEPhmgO
         q9NNLTzLA9Uhbp70CBkirSHpJKrS7hph46xRhewikFHV9AlnAfTgtQ+y1dzbyy9iulRe
         eIytZ9PskicgEKFf6NCaqpABHZWyH2/SDKYiU49IlES983E3MigP+kQewdJNkmUyMuOl
         6jtv+U0ogao9c73kFbfSEwei+gZkhD4Tg7A/Id6DDWO6TF/L/5n0v+ZbTIaTY4FBQ1H8
         ehxA==
X-Forwarded-Encrypted: i=1; AJvYcCXH70CtKbsw39fovHuVJ4jhwobDm0OtnfSg5i+tVZuWLzOP4RoUSMx4m4KES2dnOosc3V+mMI9Ir1wjMNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcrmb7A08h4b2iEMQsB08cJnTB3lONnhIpFLLEpgzMawzag5Iv
	eeChXM+KVpqwCNIJYq6NYFecZ7hK+oDErxzgz7zx0Cxs49L4Keh4XenIYOVb
X-Google-Smtp-Source: AGHT+IHegw/BddhsJ7E2GHhXUjYBEK8DEWnZB4ZEfyUMYoNCepCPvbjtWa1J71AM7bpfW/mmTBKFkA==
X-Received: by 2002:a5d:6b43:0:b0:374:bcdc:625f with SMTP id ffacd0b85a97d-37a42398cb5mr3295798f8f.51.1726954994060;
        Sat, 21 Sep 2024 14:43:14 -0700 (PDT)
Received: from giga-mm-1.home ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e71f062esm21042133f8f.7.2024.09.21.14.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 14:43:13 -0700 (PDT)
Message-ID: <68fa22ebdc896adffe42c0f101339c61f2dce86a.camel@gmail.com>
Subject: Re: [PATCH 2/4] soc: marvell: rvu-pf: Add PF to AF mailbox
 communication support.
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Anshumali Gaur <agaur@marvell.com>, conor.dooley@microchip.com, 
	ulf.hansson@linaro.org, arnd@arndb.de, linus.walleij@linaro.org, 
	nikita.shubin@maquefel.me, vkoul@kernel.org, cyy@cyyself.name, 
	krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org, 
	sgoutham@marvell.com
Date: Sat, 21 Sep 2024 23:43:33 +0200
In-Reply-To: <20240920112318.2722488-3-agaur@marvell.com>
References: <20240920112318.2722488-1-agaur@marvell.com>
	 <20240920112318.2722488-3-agaur@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Anshumali!

On Fri, 2024-09-20 at 16:53 +0530, Anshumali Gaur wrote:
> Resource provisioning for virtual functions (VFs) is done by RVU admin
> function (AF). RVU PF and AF shares a memory region which can be used
> for communication. This patch adds support for mailbox communication
> between PF and AF, notification of messages is via IRQs.
>=20
> Example mailbox messages types and structures can be found at
> drivers/net/ethernet/marvell/octeontx2/af/mbox.h
>=20
> Signed-off-by: Anshumali Gaur <agaur@marvell.com>
>=20

[]

> +#define M(_name, _id, _fn_name, _req_type, _rsp_type)			\
> +static struct _req_type __maybe_unused					\
> +*gen_pf_mbox_alloc_msg_ ## _fn_name(struct mbox *mbox)			\
> +{									\
> +	struct _req_type *req;						\
> +	u16 id =3D _id;							\
> +									\
> +	req =3D (struct _req_type *)otx2_mbox_alloc_msg_rsp(		\
> +		&mbox->mbox, 0, sizeof(struct _req_type),		\
> +		sizeof(struct _rsp_type));				\
> +	if (!req)							\
> +		return NULL;						\
> +	req->hdr.sig =3D OTX2_MBOX_REQ_SIG;				\
> +	req->hdr.id =3D id;						\
> +	trace_otx2_msg_alloc(mbox->mbox.pdev, id, sizeof(*req));	\
> +	return req;							\
> +}
> +
> +MBOX_MESSAGES
> +#undef M

While checkpatch is wondering about _name:

WARNING: Argument '_name' is not used in function-like macro
#399: FILE: drivers/soc/marvell/rvu_gen_pf/gen_pf.h:77:
+#define M(_name, _id, _fn_name, _req_type, _rsp_type)			\

... I ask myself what actually happens here with "M" and "MBOX_MESSAGES"?

--=20
Alexander Sverdlin.



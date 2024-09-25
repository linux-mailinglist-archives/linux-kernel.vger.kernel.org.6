Return-Path: <linux-kernel+bounces-338308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490F0985638
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3761C22EC5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D525A15B54A;
	Wed, 25 Sep 2024 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIP7WKZb"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB87312D20D
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727255944; cv=none; b=NatrF7C4T2FxGqsT6S6d1/Xp/TxazM+H/hi72di4fytKilT+yEdy28XGBF8+RLjbOw2/kBNtORcNiblXnl3G6hJZFlbCwtBf7JOd87xt+pf+vqVD7JPAH6C/lDcEDISbBa3IohA8UuZupNHGOARQ44M+sXezMMdfgreKCGcQO8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727255944; c=relaxed/simple;
	bh=1OTcKS+CE2UJDhgIiCWLRSkoE2cwcDUu5rz5KSxg+os=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HI8KIjxV4nXtur57l5yhTIBP7szkRAAlJeQJgLtWFXnDP1Or6RNwbUhy7l5oryM5694ll9wTVE2Cp9SLqbvieQgtPUtoEsKXfvJFJbc0OmEm4cU7otlyDd/onVPztwDl8ZM312RRq0uk3qfxWmhhMiXHs3tK5lvwlCrtzusLdMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIP7WKZb; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d2b24b7a8so136584366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 02:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727255941; x=1727860741; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bq8dybiW3GsDuKWx6xAabtXxqwLD6QJvS7jRf/Aa3qo=;
        b=aIP7WKZbTrReZxAjX+aibNK2ormOI4rNZ5ONty5ULt81EscoBgDaTgK/3cC/lgTC0P
         189w+EDyc2djffhtk1Xum3qPwcDY6uBDCZhxBRSIvhfky4EaSIqlk4ealDn74ZXeGcp3
         af2pWhNE+8cziByFfEC/8MXCSDMdkQoaGjYUi6QXkm93NhG4J8YkxAoP3QLDuv6ax0SO
         lAu6xgFonKTewT+SCJWn0ZuRjdQ9bohdWM3B0kUqG/0/haGQXn7o6SNwAvEbKMY3Bkmq
         EWl1vVdl1aL+n8rSkAx5jmskLkTF489JK1KYKSsOUfCx8/ljfZtQaaiJeaVU3p+VE+1Q
         4/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727255941; x=1727860741;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bq8dybiW3GsDuKWx6xAabtXxqwLD6QJvS7jRf/Aa3qo=;
        b=looSBRREy9afzy3ZPUbQUHAwE6m66NGvy2RFI6t2nQ+/hOjEUv2z/z2/Goc8Iu5xVh
         +o2rdvwbx0RL6xe5AOPzC7Chene6f20jRKao59XMrikNlSqGzhLR6amFzSeMEUIcG4Lv
         bjTvMwlA1jMc13XuTtBaEqjuEg1uaYOPgKbz/8wkZac5MuhQewXa9uPEn0d7TNu+vDcV
         IOwxuzpdTkYV6y8XkeBckrmRKzCl2qMslEbx3viSlsuGjH7M1CQH2F4wnw+omy02EIpo
         52F8WU4qAkY/jy1rHXvuSMW9UaOFhJFmJrp2V1mTGXGQXjcRT+LX0Ka7clx39gPa/qNj
         wzzA==
X-Forwarded-Encrypted: i=1; AJvYcCW9H4mQwXvHhD8/hPQslj8REzvSWmGFiZYyAsBeeCATt9umjkecD8j2wMHwdosFnmoQ1kTxqN7hsKyEkvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf3tTWlCX6U69dSClIyr71XweNSnNAcw4S/6w01lTEUbmWhyC/
	RCptMSNde7kr+MidGfqj45SPD03Jo2UPbQGIw7GHmf9hA1B2sigG
X-Google-Smtp-Source: AGHT+IHYYhr7eu/FoEy/IZgBUSR1wpTOIWtSVFVVIODlBXA94u4Vw6ErWLXjS7HHyKvIIF8Svw/bOA==
X-Received: by 2002:a17:907:7f8c:b0:a90:1f60:7b2d with SMTP id a640c23a62f3a-a93a0df4b0amr197117366b.0.1727255940667;
        Wed, 25 Sep 2024 02:19:00 -0700 (PDT)
Received: from giga-mm-1.home ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f500casm187942866b.60.2024.09.25.02.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 02:19:00 -0700 (PDT)
Message-ID: <9d0bac264a62f4b5f161a53bcaca35b6cef42376.camel@gmail.com>
Subject: Re: [PATCH 4/4] soc: marvell: rvu-pf: Handle function level reset
 (FLR) IRQs for VFs
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Anshumali Gaur <agaur@marvell.com>, "conor.dooley@microchip.com"
 <conor.dooley@microchip.com>, "ulf.hansson@linaro.org"
 <ulf.hansson@linaro.org>,  "arnd@arndb.de" <arnd@arndb.de>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>, 
 "nikita.shubin@maquefel.me" <nikita.shubin@maquefel.me>, "vkoul@kernel.org"
 <vkoul@kernel.org>,  "cyy@cyyself.name" <cyy@cyyself.name>,
 "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sunil
 Kovvuri Goutham <sgoutham@marvell.com>
Date: Wed, 25 Sep 2024 11:19:04 +0200
In-Reply-To: <DM6PR18MB3289700364A89C7714973C70B8692@DM6PR18MB3289.namprd18.prod.outlook.com>
References: <20240920112318.2722488-1-agaur@marvell.com>
	 <20240920112318.2722488-5-agaur@marvell.com>
	 <8f3c9f97d2de59ba73bf3c50f16d262d68ef4b2d.camel@gmail.com>
	 <DM6PR18MB3289700364A89C7714973C70B8692@DM6PR18MB3289.namprd18.prod.outlook.com>
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

On Wed, 2024-09-25 at 09:13 +0000, Anshumali Gaur wrote:
> > > +static irqreturn_t rvu_gen_pf_me_intr_handler(int irq, void *pf_irq)
> > > +{
> > > +	struct gen_pf_dev *pfdev =3D (struct gen_pf_dev *)pf_irq;
> > > +	int vf, reg, num_reg =3D 1;
> > > +	u64 intr;
> > > +
> > > +	if (pfdev->total_vfs > 64)
> > > +		num_reg =3D 2;
> > > +
> > > +	for (reg =3D 0; reg < num_reg; reg++) {
> > > +		intr =3D readq(pfdev->reg_base + RVU_PF_VFME_INTX(reg));
> > > +		if (!intr)
> > > +			continue;
> > > +		for (vf =3D 0; vf < 64; vf++) {
> > > +			if (!(intr & BIT_ULL(vf)))
> > > +				continue;
> > > +			/* clear trpend bit */
> > > +			writeq(BIT_ULL(vf), pfdev->reg_base +
> > RVU_PF_VFTRPENDX(reg));
> > > +			/* clear interrupt */
> > > +			writeq(BIT_ULL(vf), pfdev->reg_base +
> > RVU_PF_VFME_INTX(reg));
> > > +		}
> > > +	}
> >=20
> > Should anything else have been performed in the IRQ handler besides
> > acknowledging the IRQ request?
> >=20
> We are just acknowledging the IRQ request here.=C2=A0

But what's the goal of requesting the IRQ in the first place then?

--=20
Alexander Sverdlin.



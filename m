Return-Path: <linux-kernel+bounces-237488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4860F923991
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEC32B243B5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6559715381C;
	Tue,  2 Jul 2024 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="LWOxqZSk"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E5A152500
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719911600; cv=none; b=PQZ97mDLHZbu+44NdoRIro9ZVeEox7VvHeqBghKsXug9gG+O5Tl9/mtIcH+lPeDqEGxhuyy8B2sZf+RrS6jI5g2PFvh54TbLmNG5kzhneG4g32z8JZiwsZlQs9VNavDkf7siZbFV1trA6HHKRXbbJLoSWjWMnUl6TMCXZhGOhNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719911600; c=relaxed/simple;
	bh=Cj/ExZo5KegJayf9omvwYrTwM3WwmmvC/v2iKfUUqys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hPF2GQtiRWb6EiNG3gOcEwBvIJCV9OLXIt5naXVoosasEePE/vktW8mVZVLeim/XBMfLpU3TQ71gumA8e11j2qRNBv/92mTD0mgEK2F1g696vrVLOvvA1/okVWBByRm0RbPBNBeKE8f1NKCuXRv/NH7VO4AcoZ12bokxBpAqIDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=LWOxqZSk; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b5932383e0so40138816d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 02:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1719911597; x=1720516397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNCRj5+WTS2zLnBy60cKB4H7fdiaThTpR4MM3eLLC+M=;
        b=LWOxqZSk9f90D1lpHC3ioWGCt+9EyatQmc2ZogjfpVYMTVxRoEFSTxQUAy6vvLsDVx
         ZC2hmgSj/K3jjEhWrZBdVPi+087UMmwwsn/d61NfdEKTXEVact4KIOyHykfTaqG2Gq8R
         spHiuuly4AbgtN/df2k+/SEuozJOBmVEYFHwKlkqws+G6topELcwsmzUDsyRU96p6rKO
         GGh5h8cGiixRe1TfoVpa+tJXmz+fnTNiCCasj2g2fZZNay9/mcKtwnZad6JfnJStxci+
         4GpzMxw1iA6D4URwKsPddMdRsZSph+8mxmKBp7QNxxLoK7kncvR2UbX8SzUjlC67fhk9
         U4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719911597; x=1720516397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNCRj5+WTS2zLnBy60cKB4H7fdiaThTpR4MM3eLLC+M=;
        b=F02PCLgdX8VrcM5+UQnze2N91zzUn4TIGVXV7GHR0IIJCJL2iD7Ra7ptsBxTN8bTWb
         q56EkD9vdNvNjfQbtvanlZcJGiIyQRhaaNebS66ciUO6PvkZueWMZA7RZJ170ABe1VO6
         TV5GghUJbfVp9+1TbGorHOOZroaZxBFi9LmWZbC55nysweguUhJ68tLKlNvrNJlNprxT
         ngFYbLAJ+MMINr4zGNUfJvXAlJkKPtTJWwhOoZcbETWKYDEz6s6UAiu6TcFkqqG6ZkVu
         TNBZ6kAIJ5i6bh0c1OQ++gj36N/aYjQVOKGY0GOOOM5xSoPDW6D22TkmWKtCDHJUsofw
         3aQg==
X-Forwarded-Encrypted: i=1; AJvYcCW4/gY9Rg3QmMlWQzwZpANquUq0rnj5D6jX/QsGTT1Nrgy9VIp1dDEQLx8PHwezQq5CrMrHjkpHJMlC8sBWkpRJpbI5tM9f3quPJUXu
X-Gm-Message-State: AOJu0YzNrecthI24U+FFtlShy52h+8rYC04LjNwZlIw9eKWmrcjPG2aU
	jz23ku8oBBmxLnPS0coeZEUX+Loi5JR7cTxESqkA5sN5XK1fCOIjH5zfTrfzKrn4JSMjV1V2sQ1
	cg6HcTX5E84Oh6Xp4sqmJXc26gcHyRzH01/Zkbw==
X-Google-Smtp-Source: AGHT+IEksGpwMqWlcG2UmMwDj/u3dj8gsEuKSsiaTnE/PE6G/zcQs9Tki36CrUO/LfzjGUlMpfNogpKWCk0jvx3CAJc=
X-Received: by 2002:ad4:5c4d:0:b0:6b5:2c82:7d7d with SMTP id
 6a1803df08f44-6b5a545b22cmr230774936d6.24.1719911597497; Tue, 02 Jul 2024
 02:13:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628152543.281105-1-piotr.wojtaszczyk@timesys.com> <dudh4jdce3yxwv5yw345gw23diwparhwvsl4jrpsyzpv3sgge3@ojtdgsdgwcor>
In-Reply-To: <dudh4jdce3yxwv5yw345gw23diwparhwvsl4jrpsyzpv3sgge3@ojtdgsdgwcor>
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Date: Tue, 2 Jul 2024 11:13:06 +0200
Message-ID: <CAG+cZ06sqDuOer=fBcGhQkTUgWt9XqaLkAW0cmT8g=EJ+e8pWA@mail.gmail.com>
Subject: Re: [Patch v6] i2c: pnx: Fix potential deadlock warning from
 del_timer_sync() call in isr
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Vladimir Zapolskiy <vz@mleia.com>, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 1:01=E2=80=AFAM Andi Shyti <andi.shyti@kernel.org> w=
rote:
> > @@ -653,7 +624,10 @@ static int i2c_pnx_probe(struct platform_device *p=
dev)
> >       alg_data->adapter.algo_data =3D alg_data;
> >       alg_data->adapter.nr =3D pdev->id;
> >
> > -     alg_data->timeout =3D I2C_PNX_TIMEOUT_DEFAULT;
> > +     alg_data->timeout =3D msecs_to_jiffies(I2C_PNX_TIMEOUT_DEFAULT);
> > +     if (alg_data->timeout <=3D 1)
> > +             alg_data->timeout =3D 2;
>
> I don't see the need for this check. The default timeout is
> defined as 10.
>
> Thanks,
> Andi

That's the timeout value which was in the previous timer in i2c_pnx_arm_tim=
er(),
without this I had time out events.


--=20
Piotr Wojtaszczyk
Timesys


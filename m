Return-Path: <linux-kernel+bounces-449068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C39C9F4941
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D69C97A5EC4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CF81EC4D6;
	Tue, 17 Dec 2024 10:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RuEIcyqL"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2220F1EC017
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734432812; cv=none; b=nFC2okzXv4oE79kD/SVmC+9Xt85T3X6nhKRbXqI4u3IpaRFTQupBWxyJ/+uKx56JUiLwthCEqo2E3uL0CTTop7p67rRWaANUxNJ+P8Gp8cCOhaKin8he6yqi05Av2Y19C7+7WUW01zd6Ob+sA6lXVZq27CUeZjlZA30LeyYtv1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734432812; c=relaxed/simple;
	bh=A/aM+u9cBp0KR4NFJb/LlpGJ+AOLbCqCZ9EikrcXiNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvdHfQIvDYKdL674XM3kFHS+t921etuplov8osHdN+EvaeK+A/90bgiK7WKNSU9OjFTeIw5/FISv2RwQxbIXk3oPr/qEYtmiNbdR0PfNC5ykpdySNz0Th8qVzo7iozGuz0AyfNxC+kWp2OGKJyDBNwQ4CJBJDIyYC7YYWS0Jk0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RuEIcyqL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso37034315e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 02:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734432808; x=1735037608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=akvBumgmgr5EIX4fsmxm3FaGCKKx1kkyhh6tnIk6jL0=;
        b=RuEIcyqLtXGY0Wia1+4OIYR4i6LOWGRFTaeKSVoZkVd7xBH/+zd0Qxd3IT7QuLo4rl
         IJmelTW4mz/jLrYgwmTM8SNrchjJHvuJg8kGPcLojkpmAYbJQZyYogOnnxJxIYb9XAMv
         5Jaqf2hU//XJs2uoDADybpCef7N4v0zDNeXhsbc5TADdwx122vjoP2VfsyOYue/5dxF+
         Yt/bXYoXiopqFOE799RCVtcbsWkUGqjMaKdHO7IrGfWeOWP5j8auRh6GqzOsyVfrhjZq
         6PGVh0jXKBJY9qFEqJz6A2cPOWviaIMNDX5wvmDYSfqOjr3Cb/aUqi8lqV1gnlTZ7kNu
         44XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734432808; x=1735037608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akvBumgmgr5EIX4fsmxm3FaGCKKx1kkyhh6tnIk6jL0=;
        b=pA05S5cjC/5GagtkHFLjfDKWVh1WDRLPiBo5lB4aoTb3FFA55je4+NSfcEmq3mJOD7
         HNpbBi+qG3vhBYmCrr70fDSDob+xnGqSAtVLgNvHoe5rdBzKjgDuRRf28J0WdQFNH9pM
         uEBl6FBHuwCJxXjHxgr3BX5Uazoezfx7O/GzhSWBbAhqThlIpc7PihaJuujh9QMmDQaT
         nR25vIVvBeE1VZD8HG6tZBl5cvJYNN36I7U/NYcw74Cvv8pefs5+ViLBhe+1uGsRYiAa
         t8YFXykYMNulD603cozyD3snaaR2GGD43jIfbOl0Gl1MY4QcSVWf4ewLPzCmMeidC6Bx
         kxpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnwLJWFJBGGExGHx6Nz1iS+bcICzOLqemFFPLKdEhEU08lqcS1M9VBya8D4JTwte9OGdOfOdvJgAsugZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF55kLifOaX/J1ViNJ2zw8CevA9QX0rpA8b5aL+X3UaBJv882i
	V46jFx+zVeDt0EBoXeHHmvb+VKYNY2+JJO2vbNJggeiTSq4P/bb4F/sgJ2OqaQs=
X-Gm-Gg: ASbGncvo7k8CtGZY2mNmcnn+8wAZOa+F7VMxuQhEgvZPp8WJuib3cTFxZmoWrlUDznp
	jPC7YxilxmJ6ntPl8jiU8z/ev9KsIpapUoqgbLStCdq636G1oK3or+VXDgk6DayZnL4aptcYrRP
	ZN2UewctmR4rul/cuPIILGxZ/qihWrgkSATmV6iZWqwwuUCEAQIJsNL36I1OlfPBGRJ/EhjpDyj
	2LeU6bM/snerWKyB2NDoigl7fFo2ltT9UsRkAht+60CIMNHcN2GcAcQNGc=
X-Google-Smtp-Source: AGHT+IGp92CezacwNyyBgdqfZsg/E3xcoJ1kubOcalO3L3TCWN+rSaASKAUrZ56PuWjll0XGl+cLFg==
X-Received: by 2002:a05:600c:1c95:b0:434:f2bf:1708 with SMTP id 5b1f17b1804b1-4364767f07cmr27712575e9.7.1734432808447;
        Tue, 17 Dec 2024 02:53:28 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4363602cd11sm113466875e9.14.2024.12.17.02.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 02:53:28 -0800 (PST)
Date: Tue, 17 Dec 2024 11:53:26 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Jens Axboe <axboe@kernel.dk>, Boris Burkov <boris@bur.io>, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-cxl@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/9] blk-cgroup: Fix class @block_class's subsystem
 refcount leakage
Message-ID: <xsq3bdzz2tbz64rlvmqrbjkjddiguvveuqo7rrozyyl6srrrsb@aclt6fr2qxvc>
References: <20241212-class_fix-v3-0-04e20c4f0971@quicinc.com>
 <20241212-class_fix-v3-2-04e20c4f0971@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="civnhrgjz2qrd32h"
Content-Disposition: inline
In-Reply-To: <20241212-class_fix-v3-2-04e20c4f0971@quicinc.com>


--civnhrgjz2qrd32h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 09:38:38PM GMT, Zijun Hu <zijun_hu@icloud.com> wrot=
e:
>  block/blk-cgroup.c | 1 +
>  1 file changed, 1 insertion(+)

Well caught,
Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--civnhrgjz2qrd32h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ2FYJAAKCRAt3Wney77B
SY6qAPwOR82VBxA4fcXuVjjlE50/+vko8njeFm9ZpNrkqTGBXgEAhl3ipTTb7Auy
jtbygdF076YfrTkoHALOll+fPhlPtQI=
=AXzW
-----END PGP SIGNATURE-----

--civnhrgjz2qrd32h--


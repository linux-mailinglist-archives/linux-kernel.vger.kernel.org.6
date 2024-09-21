Return-Path: <linux-kernel+bounces-334988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E012597DF66
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 00:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1635281FAF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 22:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D038D1547CD;
	Sat, 21 Sep 2024 22:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWIWO2Hx"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3387DA6E
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 22:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726957342; cv=none; b=ZFH3g7kUJQMa9EdpJvQtWUoiQvJ900eMe3e3d+aCE9r4KbYp8JpnLL8ENQIHK8OyQigz/bXU8J2TNpJUq+8f6hBBqX+bq7B7gNMnQFnAIt+so0knJCHHW9ZvaEpytuDjQ02eqHA8QDm3gab6YOcVpAU5NERuiJ24mX+exBo3rDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726957342; c=relaxed/simple;
	bh=1vjykTWiZgTHm4rQj41S+2YXR33wxjh4ChiIq7tWeKI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NfJfnMmuReOEx+mEPfduSXUUEEk5ixJBo4XsEJe6Oi+ZS4nZcUGTEKHx+pvk+e7xZ+gNambuRBNAzYGd1j2EFCl6Wcv+DNbL8FbNxDCEWVKyHpza1UQURe860VRY+IfG9sTTAqOKXKIRI1VJi6DentPNbivmLcadtiKiUYgq7uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWIWO2Hx; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-374c1120a32so1978663f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 15:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726957339; x=1727562139; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vjykTWiZgTHm4rQj41S+2YXR33wxjh4ChiIq7tWeKI=;
        b=TWIWO2HxKVWG/dycmv25h2RQ9IYeBWlPVaM1mwmbZ+BUA/wYU/3v4i6lnhtZ94bUMq
         nSxfUBi/u49lWyM7pXrPZhnN6edR92U91C5dPi3GbJsUHkFXVxK7ztQGD/Jl/KO8sGSo
         vJ2FzwsqdWz42P5O/T3afk1xEKy588VcU/g7RWyj2EJq9Pdq80WZ/hFn5e+Wc4HOof+D
         jCfSiZ0S/n1/0Fpx0mrPspzMKmPCpEG/D4eZF+nxdb6Fw9Fb7gqeFIsYVhw4UYNRCtAZ
         w1aIAXaHrUXiU/g/W7PubgWT83EyuN80TbVFdoFsraoz7SR7+WSU9fsfSFhKJ5gQOZX9
         KT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726957339; x=1727562139;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1vjykTWiZgTHm4rQj41S+2YXR33wxjh4ChiIq7tWeKI=;
        b=OwQ5Mi7Cfa0d7ijfgHIHXPmeza+cjlB5qo+1Nfy+W0Rb0/FEFabNtzNhjJI/gVvvoF
         mAL8kGrGqdsxuvW9q/tNJwF5++2phbGDoiD8N2WFM609bRg39etloK+dCyiehczzrVw1
         hOcmrVLQaHuWyczC+Mlnu+vU0bhBz58FllUX55arQnkbOUTTEch0Tmdqq1VyCL1YbvQe
         Dyue/0Y2Bt2sLQ2WIwOdRkwCr1N/S4yhc1OBTXJdOVbHnPRSN8xaOW3oH7pomOW53LvC
         NzDfNJZjXZEZ7+Ac5Y7Nxpw9TSNyVBojsBI0tYfo2vbl9eRxNc9xkfWL7kv6hl+N2oQN
         M6cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtx2fet8gBrnPqIrWGUgTrX2r1aD+Mv2ipzDYs37GyJkbTTk9lHYtXgxreVDEDObIaeuR930+Tr9a9Hwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7YcPez5LOYKw7NmBSFdhMSvGkaRPDjled2Sd5XiXZRgllcmDG
	CYbimWCGnmnpBLKXtqNJxAKY4tnPKzs9r4QYWj4R/VdHu+CSVQ3I
X-Google-Smtp-Source: AGHT+IEoSBVDdOR7MuNF7bz0rr8w1ZmyQrINl8WUoGnQ1nuMzO2cXalJOB1xiTV4pTuyUq4iSkuAWQ==
X-Received: by 2002:a5d:5506:0:b0:371:8eb3:603a with SMTP id ffacd0b85a97d-37a422c5ef5mr3906183f8f.27.1726957338840;
        Sat, 21 Sep 2024 15:22:18 -0700 (PDT)
Received: from giga-mm-1.home ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780da68sm20891211f8f.111.2024.09.21.15.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 15:22:18 -0700 (PDT)
Message-ID: <d4f922130412d74fefb4a0ba0212721a6c47b389.camel@gmail.com>
Subject: Re: [PATCH 3/4] soc: marvell: rvu-pf: Add mailbox communication btw
 RVU VFs and PF.
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Anshumali Gaur <agaur@marvell.com>, conor.dooley@microchip.com, 
	ulf.hansson@linaro.org, arnd@arndb.de, linus.walleij@linaro.org, 
	nikita.shubin@maquefel.me, vkoul@kernel.org, cyy@cyyself.name, 
	krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org, 
	sgoutham@marvell.com
Date: Sun, 22 Sep 2024 00:22:39 +0200
In-Reply-To: <20240920112318.2722488-4-agaur@marvell.com>
References: <20240920112318.2722488-1-agaur@marvell.com>
	 <20240920112318.2722488-4-agaur@marvell.com>
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
> RVU PF shares a dedicated memory region with each of it's VFs.
> This memory region is used to establish communication between them.
> Since Admin function (AF) handles resource management, PF doesn't
> process the messages sent by VFs. It acts as an intermediary device
> process the messages sent by VFs. It acts as an intermediary device.
> Hardware doesn't support direct communication between AF and VFs.
>=20
> Signed-off-by: Anshumali Gaur <agaur@marvell.com>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> =C2=A0drivers/soc/marvell/rvu_gen_pf/gen_pf.c | 437 +++++++++++++++++++++=
+++
> =C2=A0drivers/soc/marvell/rvu_gen_pf/gen_pf.h |=C2=A0=C2=A0 2 +
> =C2=A02 files changed, 439 insertions(+)

--=20
Alexander Sverdlin.



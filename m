Return-Path: <linux-kernel+bounces-196616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C998D5EB6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A6A1F23479
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA855139563;
	Fri, 31 May 2024 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iROFP+Am"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB1924B26;
	Fri, 31 May 2024 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148733; cv=none; b=sWDPVEHmaImbdZXfO7wo0G1jyxXxdD4LdURkAt/kUTvJVjl8LxEbyY5w8+4eUvRSQ3GO5hyBaZ82S6HEUW0e0y1hdMTRWUoAtxukejcLPTQQR2OkfHAXXWQR7T0/UthDQkLJdpQ3/az30MG+EyFbWDXYEcmQ3TmQzsgTytMmOb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148733; c=relaxed/simple;
	bh=lERvVoyJAE/jeXnmH1j9lxgnxLnRxdAv4vYaPklDwFE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pTfUAMxGhIGUXn/RhdzSJ0M0qinT/whz0oAHdZ/RxOmhYITotIOK9g6Z9DJMKA20jQQ3B18nhuLG4Gsxf1KCRlmPC0O4RuS+YaOv+w0Pob9l1ApJbd3T7Gf31bUtYpCD7M0T0CbPYfwe1RuNn2XU8vRvw00mJPEsA3s8JUZy79w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iROFP+Am; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59a352bbd9so292091366b.1;
        Fri, 31 May 2024 02:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717148730; x=1717753530; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lERvVoyJAE/jeXnmH1j9lxgnxLnRxdAv4vYaPklDwFE=;
        b=iROFP+AmyemW+k/xYH1mkWxyfFqaSyg/qMbCJQOmEYICIslZLFTXc87RVj9/0MqHdS
         NLIaynR0Q5Bb50+CZ5wRnc2FroOis5t8LeU+Nf6kbaRXrVcB/lGMGEryUHWPLK8y0oIL
         zxfbdAWVQogZWfy5YNzBrKN2b2XuCjT5Nx+wud6p2I4IFzFfgj8yz6JGXH0MpXiDwTZi
         LpPgyLI2l2PRD9QMPzp9vrAV980evHYPLyZBMjxy5KK5X7VIiU+5rNYbbikpz0Xe6rhz
         p63ckITaJz5VBv4as+K06ooLnCFu/0NW0rNYQ2cr0vc4BfEUNWU+AkeXZUMm8zztRHI6
         5W+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717148730; x=1717753530;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lERvVoyJAE/jeXnmH1j9lxgnxLnRxdAv4vYaPklDwFE=;
        b=BIx90/83KNPIkkutabrbUJLIaGPA3Y+Zjfmh4iLhNIsry6s4S4EgNmLApnQoUd/dpq
         n3Yer/XcqQzNMSH5kAyipI1r3n0DGsRSsgV7wabJyqz4Dgi/UQ2lezb0kmpeg/F6bgkO
         t2Z/Lj8P0SmoanvrXt03nc6csXZjX9Kb/YXfz4dmT4RD0B2dbqfWb921833lr+fSG167
         IW7MTyV3WUavF/EkY18QSvlCb+0QBwYubogm31rsfWfP0rUV098/0WvQXrTd8H5pmIfe
         8V2CbM9ZMyRR/WbueHa7b5glcIwL6ZMOWcd9/HPEJSdxAUeXu95Bk4gC6450U3pRIHKm
         xegg==
X-Forwarded-Encrypted: i=1; AJvYcCUY8rSzVMa8xRAqbMBLw2iX8UajxzZLUnVOhruEKVbJmvGenxBV3FACySGItOHGTnRYO5q1ll4fAwIRd7m5hBHRbGluPufzTm7GybZNCBXGuMSlpbDkAF1GmvVeW+zxJhmRaLazyOFpE8zMPL17nXdgH7AwKKEgHBzKa5rQCaMWEMLffO0=
X-Gm-Message-State: AOJu0Yz/VbNSYszDvs/jyVaoVYrDdpfucQi+/z2MCuT+IvCbmtn74iJT
	R75uHglyjscu7KqdUqIj/HtHoN3X5VPu9e17KMmaEUEFnaIg8e0KSDB1F0JfR7M=
X-Google-Smtp-Source: AGHT+IFTFMH2jNPbQ/gcHw6Zpbe+myU3YyJ7m0d+2DIQGeRbcHm78hJ6xn84ifk1xVD6VmkTxOYzkg==
X-Received: by 2002:a17:906:414d:b0:a59:c807:72d3 with SMTP id a640c23a62f3a-a681933565fmr134693866b.17.1717148729683;
        Fri, 31 May 2024 02:45:29 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a682ea1e5c4sm50888966b.115.2024.05.31.02.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 02:45:29 -0700 (PDT)
Message-ID: <635356d36f5d402a3a921da12e352a95926ff03d.camel@gmail.com>
Subject: Re: [PATCH v6 2/2] drivers: hwmon: max31827: Add PEC support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Radu Sabau <radu.sabau@analog.com>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
 linux-hwmon@vger.kernel.org,  linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 31 May 2024 11:45:28 +0200
In-Reply-To: <20240531084645.12935-2-radu.sabau@analog.com>
References: <20240531084645.12935-1-radu.sabau@analog.com>
	 <20240531084645.12935-2-radu.sabau@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-31 at 11:46 +0300, Radu Sabau wrote:
> Add support for PEC by configuring the chip accordingly to the hwmon core=
 PEC
> attribute handling
> Handle hwmon_chip_pec attribute writing in the max31827_write in the
> hwmon_chip type switch case, approaching the same code structure
> as for temp writing.
>=20
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

- Nuno S=C3=A1
>=20



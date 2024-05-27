Return-Path: <linux-kernel+bounces-190698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B40E8D0181
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AFB0B29311
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3383215ECFA;
	Mon, 27 May 2024 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="PqcNajA2"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E7A15E5CC
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816598; cv=none; b=Pb9IDw4SX7QKzMfWeyNcsx+UVroIMcLeb3VOUWERZMh43X/wwuEyyPq7FwoiEhjSqk243UYaOB1QjD5Q0MVv9ozxcbn0DirbIVYAnCWd+sr/XT+S9tj3WrfuMNpBgyeXtp395V/uk7zDJF0/et0j88+RAS9/6l72CYqWtF93h/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816598; c=relaxed/simple;
	bh=LWDWRx2hI9lviIuJZ1uHrq2MbJn9S35DQwXdtkJC0eg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YDjVG+nVEupEvdKI/eEbRakv7csIEviqVYGcU3kns9o4KH5nJKJVmp1BOp2Numk/OiQaSv+J5NA8jyYfZ1VaAF8GJYWHzDsDQehXyYVrAAaafcqYsViytDphJAEwv6yO5NAxKG4CMNuzUzudxEX7Hv6/jHZASdCy/kAk5TGjpIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=PqcNajA2; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-523b017a5c6so15748715e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716816595; x=1717421395; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWDWRx2hI9lviIuJZ1uHrq2MbJn9S35DQwXdtkJC0eg=;
        b=PqcNajA2iqlK3KMa9mVZYuvbDiRjnslRyUtPk8TZ+FMpEUMj0eH9wPhVEmRdbWy6qh
         EyfmhY7EbxCqnSxsSd75mnYxhXxlljNpXhLwaVcPNoqGu2SqLSJwMrh5X4ZlPBhj7cjZ
         +MziJcHgXm1SaR+znqudJ5yKxS8vqzaJpFuT+76C0B+UpeGyK1ieWaiK9prPvPcl0niJ
         DyfRPbcz/iCWDIdsxYoF1babh993DbpccnvTA2cuJwqOHllqxoMZNPcfTdbxAxfFiDTs
         7iQXFYdEuBV0X+j9mg5vgUeyixEO89TeISt6Zbp0y+uDXFJwH06J16HFAk1reyp41zc6
         IcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716816595; x=1717421395;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWDWRx2hI9lviIuJZ1uHrq2MbJn9S35DQwXdtkJC0eg=;
        b=PIh2PSBIkasyvuf1cuJ2nfCyBC1iTni05NsP3x1QIZvAeQh/K90XX/th7iP1Jp8auw
         wlF+e07DWANa4eUpms2JgDJtteCuFIypi0P3AFryufFAA/khSKQMLwFAyYK4bMEJvlui
         28cihc06IlUsR4+iWoJrUh36DhpzKG0InYj2mFrGaC2ez4ZFyAXUNdq4j85hqey5rkph
         VboF2nyUN5+BxYkTCFY1/Mju3Ghsmbb7gu5Gx+DVC+eWD8JMJnv5lO5XM3ueN5WJrwbi
         NI1FFZDjdS9M6FFWLNvOk+qseWZc1BbDp+KQ8jJi7PyQJoXLMKDG9zNuM5JMq0+jZ6jM
         f5gw==
X-Gm-Message-State: AOJu0YxPWCkQdGPL0sG7pFQOt/mCcAhMTO1qoqbcKu7WZTYfSk4Fu9iD
	VIU6DnuhG1pGVD4BXYuyACl2dnDRHDgLA22S3xixJeZ4AevZQ10vsb5B12GLoxE=
X-Google-Smtp-Source: AGHT+IEm2szHWhY0KHxywC8YT1CC8IO/Es5s4I3Im5uDaIxIxINP0zGehUOvCCebefhTuKU5HDEysA==
X-Received: by 2002:a05:6512:1305:b0:529:b6d2:2550 with SMTP id 2adb3069b0e04-529b6d22971mr375297e87.36.1716816594877;
        Mon, 27 May 2024 06:29:54 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:aa3:5c01:f57b:72f9:7de2:6b32])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c93a828sm493860566b.83.2024.05.27.06.29.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2024 06:29:54 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] w1: Fix number of bytes in error message
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <98f19584-9851-46f0-a9dc-8dbae1793b72@kernel.org>
Date: Mon, 27 May 2024 15:29:43 +0200
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C3C8C8AE-C5F8-45CE-8319-0985A78DA91F@toblux.com>
References: <20240513154354.185974-3-thorsten.blum@toblux.com>
 <98f19584-9851-46f0-a9dc-8dbae1793b72@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)

On 27. May 2024, at 13:51, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 13/05/2024 17:43, Thorsten Blum wrote:
>> Fix the number of bytes that failed to be allocated for a new w1 =
device.
>>=20
>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>> ---
>> drivers/w1/w1_int.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
>> index 3a71c5eb2f83..677e7167806c 100644
>> --- a/drivers/w1/w1_int.c
>> +++ b/drivers/w1/w1_int.c
>> @@ -34,7 +34,7 @@ static struct w1_master *w1_alloc_dev(u32 id, int =
slave_count, int slave_ttl,
>> dev =3D kzalloc(sizeof(struct w1_master) + sizeof(struct =
w1_bus_master), GFP_KERNEL);
>> if (!dev) {
>> pr_err("Failed to allocate %zd bytes for new w1 device.\n",
>> - sizeof(struct w1_master));
>> + sizeof(struct w1_master) + sizeof(struct w1_bus_master));
>=20
> No, instead error message should be dropped. Core handles printing
> memory allocation failures.

Ok, I'll submit a v2 shortly.


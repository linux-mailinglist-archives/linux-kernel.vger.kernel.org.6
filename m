Return-Path: <linux-kernel+bounces-290876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC80955A69
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 01:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA371F2176F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 23:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A541553B7;
	Sat, 17 Aug 2024 23:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tja5zMtM"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440B9143759
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 23:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723938415; cv=none; b=Y62gp/tohjkzRdVFzpWFxQ+U7a1NZc9lLpdXEEQnLMZI1VxfwQLiTptyakS/vridKxt87JK0HY5kMFlWLCwZsBkmy48nQqBWSKBMALzXGFRLjjhK/c9bpVGCnLP2beawMG5jHqrilQYk71CFrAJ2sObllkp6Tz8ucwisZkHhpbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723938415; c=relaxed/simple;
	bh=l+v85gKWtxhzD66uOw4BW1TzyQEIvhfDX4xdo53zdhA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aeIuomYNr03/ls2eI3KPr3m8Ft38pAra3WVW8kMTE10XAj7TytNufujuSTGO5/Rfl9k0sWLHRRk9QR5nLspQlu6tmAb3T8RPdBFnzjxdGijA/uR2FLuZAewwoJuqmtf4JrJ1QoLh5OpD/iU/5HIoflPGkONtPrrhVwe6NrTtcP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tja5zMtM; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42819654737so22767305e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 16:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723938412; x=1724543212; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l+v85gKWtxhzD66uOw4BW1TzyQEIvhfDX4xdo53zdhA=;
        b=Tja5zMtMpyFYYZHzQwjDiecs1ZmQT114TQG9eQwdwbGVG1ZgizpePwBSPj0hXLUANo
         cXBtlAeRjr/m3lMxSEhg7CVpiqNhYtEMsU0YHGtUQz8v7a6hom7a/lgdxKs0/g2O5KKY
         FVqqQIAO3321dcr0Pvfpxjvnnk9HeCQ7S6shJQTXbXthSWx0nSugrwEuv117FFLcoHA2
         Zy3lVZt0S2NRTAJRSyUKj5rgMBzpPf8CRvg+FxPUYAHl5riCWG1ax/W1aEx6dRo1RJX+
         SyY8+VImkshJSrrhKNnlOFcQysCcL54ozxv4MKsnBAzNUN+BY/UpOCR0W9SvNYDAK3Ly
         Hc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723938412; x=1724543212;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+v85gKWtxhzD66uOw4BW1TzyQEIvhfDX4xdo53zdhA=;
        b=JAIeRQx1EXB1v1mAS8HfP0dbwu20HO6y3PfyajEpkoXtVElsDJwoHICxN0zdoHwpVa
         NqlrN43LGMmGE9HkE5bgqiY6bqi0mD9WiXMeDk8AQYfwWFRbo7dywnbb+4iLFWLhtI8Y
         aZPYO9hmNAxkQnjRhnNDNbEu9POSeVjbpd2W1Orxvo88vv1gz/mehRHGWJr+wDmOuqs1
         dhSG6VRFg8XAd0wzxkZl/VdMl4Korz1kPpgEEn2Ero7fyn79vb+5vpdEYGiMVwSYmwtn
         Jv26oTxmKLZhnxJcOeqM2nTIZxYXMrqOAFHmJnu2ShMzE91yuC27Td5l0RG/hv7TWMZK
         mnPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFrWT1f3IbsS8+IFoqTe7cZo7kGc5CLFJqloRgxOiYTPRxzhVJyCiqiZZUuPpUm/fVlC6ywKA9vD+37RhSVWqW96ZfRAJFUcBemi/G
X-Gm-Message-State: AOJu0YwuJqj+dfZ++ZgO5VKTdddIy0TO6pvHa/NkjoAhS3Uv6ciJGP/0
	tDdpkt4aJpzknFAgXa5j/+Xgz1E9ykjsmXpX91TBi+xjfSDQleeS
X-Google-Smtp-Source: AGHT+IG3UALrq/UQ4xcK92W6vqfpkfsnEizhUqmvHtg/EglYTF6LB8XWQKQZog25XQ6bIkcF1BOx2g==
X-Received: by 2002:a05:600c:4f45:b0:428:1b0d:8657 with SMTP id 5b1f17b1804b1-429ed7ba9a9mr49075005e9.22.1723938412168;
        Sat, 17 Aug 2024 16:46:52 -0700 (PDT)
Received: from [10.33.80.43] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed7945cesm60488635e9.40.2024.08.17.16.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 16:46:51 -0700 (PDT)
Message-ID: <1e962f52a2b1bb243227348dc998273eaf19cdab.camel@gmail.com>
Subject: Re: [REGRESSION] Brightness at max level after waking up from sleep
 on AMD Laptop
From: Filip Hejsek <filip.hejsek@gmail.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: alexander.deucher@amd.com, serg.partizan@gmail.com, 
 amd-gfx@lists.freedesktop.org, mario.limonciello@amd.com,
 hamza.mahfooz@amd.com,  ML dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
Date: Sun, 18 Aug 2024 01:46:50 +0200
In-Reply-To: <77KAHS.13UUH2XVHQQF1@gmail.com>
References: <77KAHS.13UUH2XVHQQF1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

On Sat, 2024-07-27 at 19:52 +0300, serg.partizan@gmail.com wrote:
> Hello,
>=20
> After updating from 6.8.9 to 6.9.1 I noticed a bug on my HP Envy x360=20
> with AMD Ryzen 5 4500U.
>=20
> #regzbot introduced: v6.8.9..v6.9.1
>=20
> After waking up from sleep brightness is set to max level, ignoring=20
> previous value.

This issue is tracked here:
#regzbot link: https://gitlab.freedesktop.org/drm/amd/-/issues/3474


> With the help of Arch Linux team, we was able to track bad commit to=20
> this:=20
> https://gitlab.freedesktop.org/agd5f/linux/-/commit/63d0b87213a0ba241b3fc=
fba3fe7b0aed0cd1cc5
>=20
> [...]

This commit does not introduce the bug, it only makes it possible to
set the ABM level without requiring support from the compositor. It's
very likely that the bug has existed for a long time, it just hasn't
surfaced because no compositor enabled the ABM power savings featue.
Now that power-profiles-daemon can enable it through sysfs, the bug has
been exposed.

So I think this actually might not be a regression, just a new feature
that exposed an old bug.

--
Filip


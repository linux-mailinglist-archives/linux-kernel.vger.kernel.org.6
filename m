Return-Path: <linux-kernel+bounces-180129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1BC8C6A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E626C1F2307C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E788156652;
	Wed, 15 May 2024 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XJZd/uq1"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC1343144
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715790069; cv=none; b=LGL0IVJFN7ooOQJp2AhoJbOSyQkfmlQWYga4RnaobDS7yRK16ZWX81oJdXOsoxOmtfsHv8Y7cu9FsbSy2xO6sbrJUKIxMwfbVPnaeUKq6jNOBuEWsZkis3eXlnXO5lhYOBym2LKlqiLOjfr0JnyqLIMtVghixBbtXKJqt4gTBVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715790069; c=relaxed/simple;
	bh=VTAKupd41+vwdD2+AAdWUtgNtPv+N5S8/ZucUcvM7XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLLR4E10WLWme1ZvMQ8spzSOZdnC02R9KTXWzO7ENxOBshIvADAVTz2MpfpOnaIRYJCPDRg2y0YXosoBa5S8ohjMkphm6b6JbJAkKxhpxMJiNAJW9zkkNq0r5njvb5+DAM9oSbHr9952pBWILOVnYaFrw/D7GFaS8aGL69/UnnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XJZd/uq1; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e576057c2bso73528501fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 09:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715790066; x=1716394866; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VZ4/RopXS5f2WiCBIMNF7eOCyIDKJ+KDv3FhPq2DLoA=;
        b=XJZd/uq1wfCMacrqtkrbBvuuv27luGpFAfQPOJwhokSEnLjyMXslScfGXvlu0ZtrnY
         78Ak1aXBM9JA/zwDOtRx5FX18Eu7RC2rSaFOlCmypRkxr9lQDMZNvNAJpGK9NLCyOZMa
         P13A1yaX5gTejbcx3eh2uzLFyRxLBC9pMN/IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715790066; x=1716394866;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZ4/RopXS5f2WiCBIMNF7eOCyIDKJ+KDv3FhPq2DLoA=;
        b=Fye4GklLCfJ+aNzity1NgOGi6Qe9H3Dv7lcb5CKag+7IWifvOEz2+PLUrQFNFbQlMH
         iReZIk77BANv+lQx6qc9FGP879J/I2EqnYD7Wkcbnm341M9CPOlDQAyKlmZJ7ym4Dxgp
         rixRYEJeBtcmZJwvTYsNACQIPla66dlqpSZ58zAOEhkeEyjpJ1UDn70yndOnOx/eWhX5
         tCTpsb0XwfaKFB8ZWetr7sdKI1Tq5AknU26cav1DYlxeD5/AktG4igi4ULUa/X8CZPHh
         QVgR5tBGpu4ABXRvksgwZlFMI5k+BfCdgXBhVkjXgan5rbq5dO4aQlnPVampjMYSh/pw
         PDjw==
X-Forwarded-Encrypted: i=1; AJvYcCV3jjnwNkYDg+7Hy5rQ9ptmAMRyb4QUHgFZrekoQ5fNHvDW3/W9KaHtpfT/dhdl+ONq3qWZHUABktahI2m45Wy6b3bCQyZ/ofuqcJAv
X-Gm-Message-State: AOJu0YynZxj2CNeJDiT/vMeoEE+lUla3wjdtY9fvVFg+8mr4KvcUsuLN
	Nbai2YKDv83QxgnXR8UE137uGSLQayicJrhnBfolOHe8l4lxSUMwyvFtVBiFVnp4JSPDQR4CuGZ
	G9HSBOg==
X-Google-Smtp-Source: AGHT+IFFS+19Cu/Lg3J3MpFFCh+eCpsBYmFEWlxGMeJvwhVhaBgThBvPksYmHU9D7DxbsLEkeOzPPw==
X-Received: by 2002:a2e:461a:0:b0:2e5:2414:a205 with SMTP id 38308e7fff4ca-2e52414a255mr118882841fa.27.1715790065853;
        Wed, 15 May 2024 09:21:05 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d0ce30e1sm21545341fa.38.2024.05.15.09.21.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 09:21:05 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51fdc9af005so11522060e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 09:21:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHbc2ntzPJnTZ90SwlVu7b+ENvUAwUpCW8K0fPE8x5A8cL9c5bzoAt21VgpZHMtK/9uitbj/7RXmUr9nXHZmv0mJCrShVDbeRGVhM0
X-Received: by 2002:ac2:5f59:0:b0:521:92f6:3d34 with SMTP id
 2adb3069b0e04-5220fd7c838mr12720657e87.22.1715790065107; Wed, 15 May 2024
 09:21:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515082456.986812732@linuxfoundation.org> <39483cfc-4345-4fbd-87c2-9d618c6fdbc6@sirena.org.uk>
In-Reply-To: <39483cfc-4345-4fbd-87c2-9d618c6fdbc6@sirena.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 May 2024 09:20:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjntFiQ=mM-zDHTMnrqki3MN3+6aSXhjnJozBaKqLLUDQ@mail.gmail.com>
Message-ID: <CAHk-=wjntFiQ=mM-zDHTMnrqki3MN3+6aSXhjnJozBaKqLLUDQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/243] 6.1.91-rc2 review
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Doug Berger <opendmb@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 May 2024 at 09:17, Mark Brown <broonie@kernel.org> wrote:
>
>     A bisect claims that "net: bcmgenet:
> synchronize EXT_RGMII_OOB_CTRL access" is the first commit that breaks,
> I'm not seeing issues with other stables.

That's d85cf67a3396 ("net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL
access") upstream. Is upstream ok?

                 Linus


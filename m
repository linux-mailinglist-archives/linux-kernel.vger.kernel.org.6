Return-Path: <linux-kernel+bounces-415161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6919D3227
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 03:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CBEBB23B85
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 02:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96CA374D1;
	Wed, 20 Nov 2024 02:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="QCG2nKtH"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1091F5F6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 02:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732069482; cv=none; b=XrH3fOKDQfXDXb3/Zppphp/XgOx3o9L6+cbX0nXYvRy/cveObksUqOzxvpquyF2bqtMzGfl5Z56Nb/B+toBuj+FO35snAD1zDp4PYe5Fv//7F7e/vkW8IVW5LJ8iZjIv80O0ampGEercw09gr0Wh4EX2p0mVXYbAohrCG6LZz4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732069482; c=relaxed/simple;
	bh=aAlrz0esdSuZ8vCc8kqANmnXxvM7o4Ot7dbvvGrbdVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=hJ/x2gIFIxTQzmwk8H0tLNo1NlUgTiCc5t9n7T6nrxFCMX3wwB/611WuXFHbWiDkMM8lt6rSroaUX3XiH5L68gYBxCBvL8qEeGprafbrURSA6n+sSJwvGl6Nsg7OHikoOQNG5nFc+q3Ydel+fEe8eIBVK1RLlyIO5yLhrqYWcDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=QCG2nKtH; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BAA2A3F0DE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 02:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1732069477;
	bh=rUHH8kj7vroPTHkOogrCHd4roUG4m5heL0V7faDtLls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type;
	b=QCG2nKtH2mG0wOMDhPEqbGdY0gXJCT3QIGiiXB1TkQmdPMvDN72YzM4wYSUwoeeMY
	 utp6GS9tYslcB2JJ0+98utbXth4TM1X9fxITrKC3xKXZnIH7ADMIfENrPB4mDPYYmi
	 vFr6Gr3rN1BGUedVhXpe36Ypbnl0hp0T4C6Q8fDsE+SpT1HjIc9M2MvoluVV5p4VOL
	 Dn6eeQuNKmgO8e4Pya7ekvpFFlHPGysgojUbu+EVmD+07UVvwIR7DRHq3m9VtvoyXq
	 4he1hrzAXH2480crch5MV/mHf+sJLfU8cUm18VeCzz7bebxT6UTirqZ0elKAB2hlGT
	 d8ZD8iat4xLrA==
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-29678d451b1so2004071fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:24:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732069476; x=1732674276;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUHH8kj7vroPTHkOogrCHd4roUG4m5heL0V7faDtLls=;
        b=Q8VfSciKiEYfp1OYpx6GPvE8ksKNJ4q4EECYaKJabGLJBcZO5y7le4RvJMER+umOux
         0vBVpeAUIcyv82DYgomfw/BW1R80oatO2PAwroRBkZGk47QA2+0kKUkdOHPaSVYWBa98
         pBSGbHE0bpb+OKJVOM6le8ACLnK/5XiJRpMcVk8KcTdNFlniilUnbbE6w74gMBx1d3op
         PgJr55Hv7W/HKc8nYpFa1w+ZT8QLH3AkqvsotEFVF4JgjjwawElFt3RV5hbNm56tOQ4U
         xHGOfn/CmX7tbunNfYhRDG6QrSvvPU/FC954qaNODxeUL4jcTtaHslRfUXkNr2vHaPR0
         fVhg==
X-Gm-Message-State: AOJu0YzPjZLeN6YYExodaO420uicJEWaZnNUfVLhN0nYMWhou8tE90T9
	/mF7IvmkTrL8w4UX856azCjNd60qROE7fNo5T4bakcNDATo51POq1Vs9P5wu/SsaPCyYeYCuoKE
	rIdi/bYXZ89AHWr8VTqvsGp/44vaOvrYlWO/pY1G7WYZ4ebEXSwRFvZcdJ/rIwffMZOaONDyK2Z
	pbmEg62PyVp35juGGypG0AqJfmQ7l8LoZXMY2Rs9tprynEWzbUGxBgfU0GhNIN
X-Received: by 2002:a05:6870:aa0c:b0:296:504b:8f2e with SMTP id 586e51a60fabf-296d9b00dfcmr1291663fac.6.1732069476559;
        Tue, 19 Nov 2024 18:24:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEA3iWeKiaM7iph1J2imn8YKlYNbOlAADSI2d8yJm3L2uXiE08++55amwatq1zyiVb8qbEx/7slomq+DO1yvmc=
X-Received: by 2002:a05:6870:aa0c:b0:296:504b:8f2e with SMTP id
 586e51a60fabf-296d9b00dfcmr1291652fac.6.1732069476318; Tue, 19 Nov 2024
 18:24:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120021205.1590999-1-masahiro.yamada@canonical.com>
In-Reply-To: <20241120021205.1590999-1-masahiro.yamada@canonical.com>
From: Masahiro Yamada <masahiro.yamada@canonical.com>
Date: Wed, 20 Nov 2024 11:24:00 +0900
Message-ID: <CAJ0jQVwaWS1b9ZsjrA100vASdfAiau80QO4J64mwEc74Zw+SSg@mail.gmail.com>
Subject: Re: [Plucky/Unstable PATCH 0/2] Avoid arch-dependent source package
 (step 1)
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please ignore this email, as it is unrelated to LKML.
(I accidentally added incorrect CC due to my tooling mistake.)
Sorry for the noise.


On Wed, Nov 20, 2024 at 11:12=E2=80=AFAM Masahiro Yamada
<masahiro.yamada@canonical.com> wrote:
>
>
> Ubuntu kernel produces a different source package
> depending on the architecture of your build machine.
>
> I tried to resolve this issue in the previous hackathon last year,
> but the patch set was not merged.
> I am resending my patches with smaller chunks.
>
> 1/2 solves one issue that can potentially produces
> a source package that depends on your build machine architecture.
>
> 2/2 is a trivial clean-up.
>
>
>
> Masahiro Yamada (2):
>   UBUNTU: [Packaging] Avoid Arch-Specific Certificate Creation
>   UBUNTU: [Packaging] remove unneeded prerequisites of
>     $(DEBIAN)/control.stub
>
>  debian/rules | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> --
> 2.43.0
>


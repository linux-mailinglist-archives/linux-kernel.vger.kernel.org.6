Return-Path: <linux-kernel+bounces-267645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11759413E1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5899F282F51
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBB31A08CF;
	Tue, 30 Jul 2024 14:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dI+y8Zft"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD221A01AD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348432; cv=none; b=F3T9bavdTkoLmHSYaVDkJltZ4mITDlAUApZ8vo08qh5ciqh4rSd8Qe6IGA8fdTWfnMz5P7SiUvKfZZ1R7z3yoqmcqt35Pil5lBRBisqQFSwpkwRwycEpi1cg78zzneiqC4opByV9IUCNoabzOICz61M+mGdI81OXee+KCiqty/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348432; c=relaxed/simple;
	bh=CK+bybF3K3LJRLU/R+ssPheE5Ys3SzcIIRnfg/kt/WU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rOh7u7BmO7jqfTsevO0UKquLJVtcWkiBvpKkBHcORDq7j2EUt9/75Tb0EFGWvyGkMyTfjT7ZmVfFj8xaquXwugKszFmT62MrBTNuR8QurRH0Fj1CgUBX3irqaTtbBW8gXpc2u8VKRHFCvKlJo09SGhqfRmCGz50fYrOBmlYl1Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dI+y8Zft; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52efef496ccso4545291e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 07:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722348428; x=1722953228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTKuflyLw1iTJ2JmIVJ3X3gPfHfyPbB1R2kyRCNVjfk=;
        b=dI+y8Zft8edx8j3MRQ99ONv7KusrebkzztR80AtEDJ6jOUeZ3yg3ecRNTeo5P3OE2F
         X+MvrsdiU0zBV3jh4bR97qTXTaILRVP26CoYmfIEb0FdRR0tIROi71vznZt/frdR2f1N
         tqVeTJyeEf9HoCcPqPruK4LMvJ6fN5jz8iKBroMs67A1UiRyu9u5ZvCC9jmysRnnVfFm
         nQ8dzDlWcHrYmRzvhDL+uBGGHSokPHu0a1bl1TERmyjRe4uPsLYiWY1TqOncV79zS/OV
         fSzmy5vIr6ULwQ92mgPMqRnZ7kZv/d3vvcfPXMflL3ck7O0tIRU5AozCzYdK/EDnO4GN
         2Tbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722348428; x=1722953228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTKuflyLw1iTJ2JmIVJ3X3gPfHfyPbB1R2kyRCNVjfk=;
        b=qEutdrb0C+IR1rQVpd2axKathCaQ7dHZio4sE1bXEK8t/hiyRW1nIOzocWN7HljRLc
         2DqbIStlw4c+0UTAJuxufeWMnP+0Chrzj/tgG+RleLQnWIfD2Su4+34WeGg/g0XRJ72a
         p82eixUeUSAl9WT++WhXoHUTXGAKKISjOgdYP/PbfaQqpsQloMJV1icuycHOfS815ROz
         3bMLGYlWBRBQkq8AAWDZRqRDkwqjp+4vwUn+aC6lLw6uR59PImoc5TcLFEiA8RBU6ZlO
         Ihmn9xkNqP7o0EIv5zhsFLfCky103QWl7htrmQghHtpmt0E/2DlHn4LC/XjTCeXyirhQ
         jDXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiY2hou2dYX39mqXXeQPCfqnMpAstlRghML8bjGzfvYD7cVDeIxvcFVxMMhyswEXl9Ejxge0Mx5W1ZcLGsuuRoTAdQnn2r1OP90rBw
X-Gm-Message-State: AOJu0YzpHV8Qld7kVA5W/0M2aNBO5tL+v2GNVtyPQwhgoXlvQdWhymnB
	+/hsrJ2dPBACWXxzAhtH/krkSvYVloqJCAehmUs9tfoBn9HWnF/94mkbJQZq1rg1lCKuf3i3ktL
	G+8Vu7aXC4KHkH+AfEpEFexjkGuk=
X-Google-Smtp-Source: AGHT+IHZByFFGlOMEWTuzBd5quvj1T61o4kWtgtOT93plirMJr97J38lufgr6tRt/wSlD04OWA7x5MCE2eK33Ji4XG4=
X-Received: by 2002:ac2:4e8b:0:b0:52e:9425:3cc8 with SMTP id
 2adb3069b0e04-530aa8a5106mr579549e87.19.1722348427490; Tue, 30 Jul 2024
 07:07:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729085215.3403417-1-leitao@debian.org>
In-Reply-To: <20240729085215.3403417-1-leitao@debian.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Tue, 30 Jul 2024 23:06:54 +0900
Message-ID: <CAC5umyhvgC7t_UAnQWXfcotvMYX84PARSco0Fs=kgh+nYvUTGw@mail.gmail.com>
Subject: Re: [PATCH] failcmd: Make failcmd.sh executable
To: Breno Leitao <leitao@debian.org>
Cc: akpm@linux-foundation.org, leit@meta.com, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B47=E6=9C=8829=E6=97=A5(=E6=9C=88) 17:52 Breno Leitao <leitao@de=
bian.org>:
>
> Change the file permissions of tools/testing/fault-injection/failcmd.sh
> to allow execution. This ensures the script can be run directly without
> explicitly invoking a shell.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  tools/testing/fault-injection/failcmd.sh | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  mode change 100644 =3D> 100755 tools/testing/fault-injection/failcmd.sh
>
> diff --git a/tools/testing/fault-injection/failcmd.sh b/tools/testing/fau=
lt-injection/failcmd.sh
> old mode 100644
> new mode 100755

Looks good.

Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>


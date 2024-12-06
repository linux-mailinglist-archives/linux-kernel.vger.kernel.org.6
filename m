Return-Path: <linux-kernel+bounces-434269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1C69E642D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 03:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 816F9167C91
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 02:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110CF16132F;
	Fri,  6 Dec 2024 02:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTFDjYaH"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F534437A;
	Fri,  6 Dec 2024 02:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733452298; cv=none; b=ngsWJEDw+g4OHwWtxOxLtqJKRVw4+60zdZqwmgIJ2O1MUZa4pmCvJvqDL64kOX52wxJvvzLzGgSpLtb8BNnWUdvYY5X1EEDNhzLq4EEUebvO9bc9JlbhaT8IQS67u89lpSLZAGZ+hkDeTGpcevo8sgRE0Qpm4lSIHLtK5qc6/Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733452298; c=relaxed/simple;
	bh=0UuH1MtYw+LLHX8LyKDaC1SBcVs4Nw9nTN4k6fZafQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oy3AuDppKsp0tM1N5v60m8EAkQ3JchC7sl1jxIxCG0H9XSdPG6mtk8W/B7HUokIBUrZy3q6ohZo3m2homJa/13WeKfSemRMCbqXY92XkWag562KYX47yNsNLWm4OjYuMz8YRtHQ+72IWBz26/WboJaQMsQOsjQ3bN94uEzRAwSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTFDjYaH; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-841a9c504d4so106417239f.0;
        Thu, 05 Dec 2024 18:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733452296; x=1734057096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5G5neezgsTGxLzETVl0pMokr7OCbZY4F/agzhpz39dI=;
        b=lTFDjYaHmmqLKoLN+RLHFc9+/iRX1ljQ9Rv5bzJW+/ER8cNJXq/+qyp4ASPjeL0SgB
         b5GDH2MntYr9lRlUAWAtgll+iye8Btagxklo1QFgvjQ/8lXZZJ/dD9CynzE1WykLhWJ9
         PXIkcazAg3E2NQdktT7JaDxxGArX47eXl9sTUozwjXWE4h1z6dqerZ96/TgEa45knQ+n
         Ss6ek/Y3QPj603uXi6F3y0gT2XMxJVSz9TLlHUtCMZlzeA81NaFHvFQpK6xGZlCEObiz
         SX8Sf7axZ8nVgXoStNK/+rw8w8/gHl+U66lOY/2s1UhOKhbEBuhygIoOW9a0MQL0UuB3
         x0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733452296; x=1734057096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5G5neezgsTGxLzETVl0pMokr7OCbZY4F/agzhpz39dI=;
        b=gtQjix4NB+udoxE1LVgeXUwReheLcA57v6DffjZ1vsvPpLNpe6oKx3cllW4UAlZkbk
         CV0fpHvpOmCJhGGMdWamkIXFBNOsPd3VsHk/Ey5ogntyRs25/3WVW3fN/LanXULTirpU
         FtrosmPw6+wfcbnQE6PKbu3dSm7/VQO9/lCOT3xQnhjrtHX3wVETzl3oFhFqeq4pSiP8
         8VobexPyo3WNxY7Omg5ko33Zb6QpXUbxaoTfDL1wcz21s4lTIlpsC6bt+dh2BzQ73uPU
         eTmOdRTviyrv4TaGzQF6gZpEH+6TsAS348VhaawhY3ZK+NFjp4Rx51oXtQY4ewx6oINK
         hWcg==
X-Forwarded-Encrypted: i=1; AJvYcCX/W6CC4Krjna72of2kBp2weXFcASKLJtOU24Ux34mHo3GKJIImOXIot7RgTcW0p0mt/qdVvb8jrIQk+u0=@vger.kernel.org, AJvYcCXqWy9FEXqWzAOKgcPgeQB+1id/e+V8Ulgxq3zKyvMvgLbycyg4J8jX1PeCyERpzTb9BmmuA6sXDU43tiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpbCy2LuC1f7k7x9MEFPGtm8KWPWRzZYO8D52o7XCly5IUO43x
	PM7Hw78muZ+iPZ93bwXyh868rjpai0AUBz9QqsPqR1kkAXfPMVp8Q2nTxHbxGiDqjre1domgppz
	HODMVzvEIU3mnmUdPYBhG9oGV1lc=
X-Gm-Gg: ASbGncuRrsPVu6QvqzR23EsLfa/z/aqm75qYVeu0rUEAQZ3dzKGHoXUymUar8xZjWwI
	tN6i+KjRICVI6YGndZjpl6VtrJuBVH8o=
X-Google-Smtp-Source: AGHT+IHBwODJh3fSmtZCBLrwIs+Ngf+HZUOxxOtohdvIuiHQgJWd2OceEpnS1WS3tUvHKi17wjDrahJ2yPiH9dCDQ1w=
X-Received: by 2002:a05:6602:6d01:b0:837:7f69:eac2 with SMTP id
 ca18e2360f4ac-8447e1dac49mr181291239f.1.1733452296087; Thu, 05 Dec 2024
 18:31:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126115440.3929061-1-chancel.liu@nxp.com>
In-Reply-To: <20241126115440.3929061-1-chancel.liu@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 6 Dec 2024 10:31:24 +0800
Message-ID: <CAA+D8APMm4K7m-aa1XbGJuv9pfP1fXz+QoohuSieT9Zo4-BJtA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add function to constrain rates
To: Chancel Liu <chancel.liu@nxp.com>
Cc: Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com, 
	lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 7:55=E2=80=AFPM Chancel Liu <chancel.liu@nxp.com> w=
rote:
>
> Platforms like i.MX93/91 only have one audio PLL. Some sample rates are
> not supported. If the PLL source is used for 8kHz series rates, then
> 11kHz series rates can't be supported. Add common function to constrain
> rates according to different clock sources.
>
> In ASoC drivers switch to this new function.

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Shengjiu Wang
>
> Chancel Liu (4):
>   ASoC: fsl_utils: Add function to constrain rates
>   ASoC: fsl_micfil: Switch to common sample rate constraint function
>   ASoC: fsl_xcvr: Add sample rate constraint
>   ASoC: fsl_sai: Add sample rate constraint
>
>  sound/soc/fsl/fsl_micfil.c | 33 ++++++++++++++--------------
>  sound/soc/fsl/fsl_sai.c    |  7 +++++-
>  sound/soc/fsl/fsl_sai.h    |  3 +++
>  sound/soc/fsl/fsl_utils.c  | 45 ++++++++++++++++++++++++++++++++++++++
>  sound/soc/fsl/fsl_utils.h  |  5 +++++
>  sound/soc/fsl/fsl_xcvr.c   | 20 +++++++++++++++--
>  6 files changed, 93 insertions(+), 20 deletions(-)
>
> --
> 2.46.2
>


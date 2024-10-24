Return-Path: <linux-kernel+bounces-379198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F219ADB53
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B6A28183A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D591714C9;
	Thu, 24 Oct 2024 05:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDYsL2KW"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B8E12CD96;
	Thu, 24 Oct 2024 05:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729747053; cv=none; b=H1QkbLmbEnxinn/YpAIaCZeQm0DCCHJjdWJnWhAiY4pprhEo4j17ImSHiy4tBoqjLN5blMNPH+BjhLbRcQ0S851raileC9bh6JANT/keBCbrjYHlJ6eh0V405EIl6+Vsq/3HKH0K2BSlFBxop1Yn4oDEnGrB+lrLMEJDQ7Ykr0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729747053; c=relaxed/simple;
	bh=sfyjJTBmSWUuZLLjvEHRHWjJuJqURZIA/bbiyxiMLBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhudJl/nbJICchvFOdGpOq1hXhEP53ebt7f8xHnj4CWyPAJE17b+ekp/+0icoUDL6v5EEOZR0WHx+3Xqmu7Q0t5RbJogb/55JzP9J6yWMbD8rTNMqaWjzwBKNcGOTIpfPZ9asuG5gL6bkLv3iR712KHHnFl0JA9UG/wE3WqiYdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDYsL2KW; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a3f8b5fc45so5057405ab.1;
        Wed, 23 Oct 2024 22:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729747051; x=1730351851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ea5E0CUqTApv+zwvwXAvyODO1+mnbcCQh2rAZz+WNMM=;
        b=EDYsL2KW2/s16J3j89ntkNQEn5vcAqenLoMwmSqpoV8BcW5ZkosSEnlQlAsrfMJeqa
         ZrD0kdK3ecWA1UqdeRsQoi2dKhdWoNUqppDrA8lmMiN7FfxAevRZlqkqrID7p7C/KoPC
         4nYI9iHO28QNRiq/k73Z16ZY585eFjTeZbrpjrMccSZyvhx6510GXSYPVfJ/pMTj3Cxz
         GAoaE5kbeYENl1lBrjvSh4MomjGmF2oasoFezgeJeuIn6JCSsxhMvz6p2H24FImpto+K
         4/8yrQWGEz9aaWnq3ufaoqRQ5snk0Io7EyDI2fIqR0A7jWgoGpK+VLTb+R+uJIS93l5Y
         PpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729747051; x=1730351851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ea5E0CUqTApv+zwvwXAvyODO1+mnbcCQh2rAZz+WNMM=;
        b=UqWjdYJmaa1irl9dPyAbyUSReSLTPbzw8l6+5ycXDUJydXInN+u7Klh3bICyUfpYq+
         qIwMcSazHtFo5y4L5KSAjb/TCNyGrIhH8VO/pisYb2bcPacOPBpVMidRDYwf6OAJnl/D
         xWZCyAmdJ8lnM5/1Oz43pJnfCI7tZxzMzTCSLqbxIAajJ8y2eKs5Ie1Xh1iOTvMHTicS
         yQpoFu8FJBrYMqqkB/BX2sKkL1GVQd2d558jD/rsks/d6xY/dRZaBnHgPjp8kdKAH9Be
         ttA06Di2ygmOZLwybJVdcQKYnk6fw7JCTCX+07lmZu+0Rr3LXVHKGcQF9Fjn14XoWNjI
         85eA==
X-Forwarded-Encrypted: i=1; AJvYcCUXE79n1uZB1jhqZktBPtamnVTQv6Laroc6yUoZUuqzRHdtFa+QEoErBWqbEN0/M6F8rHH4Bdh8pU4WTDM=@vger.kernel.org, AJvYcCVdcqBFSJirxsoIhXRNt4h2GlZQfcTQFgBXshoflU9tb6RdYvnD7GU0kVDCV2NVlnAkVOCNYqaC3JVaKdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy04pnhhCSjOEnshZM85QmL4pdvkBTjKS3almuzwdcZenqO34Iy
	dGbvJxnZjdtEULE9u2wNFXKqbYxd5Dz23OAapond5d9EIlfl3AW8w9TnvxC2IYTrGBMfEy6tGYt
	HD3+niDwJjoBeCJUjgxLRFtRr5kw=
X-Google-Smtp-Source: AGHT+IEDNxSK8qOUKRknMFAvP1j4nHhQxGJuBuCD0rhR+4p1pIEFITHngRl61dN3J8puKbloY/+3j3q7ZwSl+ywaA+A=
X-Received: by 2002:a05:6e02:5aa:b0:39f:325f:78e6 with SMTP id
 e9e14a558f8ab-3a4de685e50mr5077685ab.0.1729747050765; Wed, 23 Oct 2024
 22:17:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1727247316-16156-1-git-send-email-shengjiu.wang@nxp.com> <ZxiKdpeuIhe/DiV4@vaman>
In-Reply-To: <ZxiKdpeuIhe/DiV4@vaman>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 24 Oct 2024 13:17:16 +0800
Message-ID: <CAA+D8AO7f3z4oetm=2wseSAwN=eFnNePK8VnC31mNw-owZF-ig@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] ASoC: fsl: add memory to memory function for ASRC
To: Vinod Koul <vkoul@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, perex@perex.cz, tiwai@suse.com, 
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 1:32=E2=80=AFPM Vinod Koul <vkoul@kernel.org> wrote=
:
>
> On 25-09-24, 14:55, Shengjiu Wang wrote:
> > This function is base on the accelerator implementation
> > for compress API:
> > https://patchwork.kernel.org/project/alsa-devel/patch/20240731083843.59=
911-1-perex@perex.cz/
> > Add it to this patch set.
> >
> > Audio signal processing also has the requirement for memory to
> > memory similar as Video.
> >
> > This asrc memory to memory (memory ->asrc->memory) case is a non
> > real time use case.
> >
> > User fills the input buffer to the asrc module, after conversion, then =
asrc
> > sends back the output buffer to user. So it is not a traditional ALSA p=
layback
> > and capture case.
> >
> > Because we had implemented the "memory -> asrc ->i2s device-> codec"
> > use case in ALSA.  Now the "memory->asrc->memory" needs
> > to reuse the code in asrc driver, so the patch 1 and patch 2 is for ref=
ining
> > the code to make it can be shared by the "memory->asrc->memory"
> > driver.
> >
> > Other change is to add memory to memory support for two kinds of i.MX A=
SRC
> > modules.
>
> Are there any patches for tinycompress to use the new IOCTLs here, I
> would like to see those changes as well

Yes, just create a pull request here:
https://github.com/alsa-project/tinycompress/pull/26

Best regards
Shengjiu Wang

>
> --
> ~Vinod


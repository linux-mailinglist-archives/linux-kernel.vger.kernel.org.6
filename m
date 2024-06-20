Return-Path: <linux-kernel+bounces-223382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692AB911222
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9101DB248BF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFA41B5819;
	Thu, 20 Jun 2024 19:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k8YSA4ZA"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DB61AD4B6
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 19:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718911670; cv=none; b=TNIjij9k+jeVp6pyguGara15/ddaQfrPOq7RI/fK8EaNyQSvnzx+8W6msa7KU428W6NSf8eSZbpZUVcPOc2nV/2IksekbiaJ2zs2OrjCqmT02jHXD+Kp84odt8SZOZoDuhTPoEgqeXr6rBu45IiQQwGC/1xRV6r+swfMge5n4A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718911670; c=relaxed/simple;
	bh=pdG4nCgSxw/YgFVj+Ej3ol4v6FdjqGrmdWzOvnnEv7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFx+kre8NNqus+NGIy8A97y1qHCH76IQuYIr7bnnHFGq+fiKkEYaC1umQHTEXEFC4U29oIrZRJeCfxYFOCWGBcuPjOV0BqfS86MP4m+rUDVBFxu6hv/5lAesko3UQUPcPk7/jEkFZVa9oCnpHecQrdoDlKmeTo1NQB7NwrnJdQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k8YSA4ZA; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52cc9b887f1so1549053e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 12:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718911667; x=1719516467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdG4nCgSxw/YgFVj+Ej3ol4v6FdjqGrmdWzOvnnEv7s=;
        b=k8YSA4ZAB6x6ni4CIFuUv8oQ4Or9Xdq6Gn9PPdblbkPEjWFGLc/lkeTypoyrj7/4Zb
         nw27Tk091KosjgLmAI2sGEf2tCb+vd08UODUYTIGfommrRzec8Q7TtEB2wW8tVMR12RE
         xC1vOC6k2+4xBDVw2dAaKfnzKSC7gWl3Mskms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718911667; x=1719516467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdG4nCgSxw/YgFVj+Ej3ol4v6FdjqGrmdWzOvnnEv7s=;
        b=JSH9YBTQ3H7MBnHdsdq0KvxEGyoVXUW90LGk3hmlve8wRVCc/kC4YV9qzT0/wK/WWd
         NkuRO75iHGRiOS2cG1fodWwqDyWjjdPt66UiMa0ABtYQ4zZpc1WN/q7W9nMy77UFAFBH
         K9E1z3x4k/p/JO9tR6nO/pPAXJ8zN1K0NkcWnA+Yh7uqzSMwK1x/HseeTP8Fk7opscVF
         xQUiv+YunCq+LAWeCOva+WzjWpXaF5/0cC2qfU/0bik4/1TSpQrdG1fPpXdpGCmiyCAJ
         gmApvAS5c16Jefg4YVfspKL0hBZLQ9k92YlrEHXscuNEX75mgZ0g4ATdaN0uIzhdwRZ7
         h79g==
X-Gm-Message-State: AOJu0YwCsT6YYkDOlZjA0iCmxnCXlyAbwuNSFviqdohy10OV04BBqxfT
	onl81IBGbsjSkPgpzlyfaK8tfBz8aLFhhtcjgonLZC2G74/GPDyhfFGpyM65L0d9Nn8+VSn4ErL
	HXCDmRUBwXmqu+ukBwwEnIavbcL1tFykQqLim
X-Google-Smtp-Source: AGHT+IFpX4vdPR88vzuw+qOy5LYQoEq2bxuX5ZqXaSLgyv7S8qAFNOakpP03z9BJy6HfhH21zcwde47uzX4pXKbYFYY=
X-Received: by 2002:a05:6512:3043:b0:52c:84d1:1812 with SMTP id
 2adb3069b0e04-52ccaa58704mr4469058e87.7.1718911666694; Thu, 20 Jun 2024
 12:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430212838.1.I77b0636d5df17c275042fd66cfa028de8ad43532@changeid>
 <83e218f9-29f5-4f35-bd0c-b298e3bb9e8c@linux.intel.com> <CAEs41JC-vJaMHj6fzmNO=-bu5oURRA-u565sN2=yzBeVtKb=4g@mail.gmail.com>
 <b2375610-4044-49e6-86e9-5c172abb2ffa@linux.intel.com>
In-Reply-To: <b2375610-4044-49e6-86e9-5c172abb2ffa@linux.intel.com>
From: Allen Ballway <ballway@chromium.org>
Date: Thu, 20 Jun 2024 12:27:35 -0700
Message-ID: <CAEs41JAPPr3xRR42H6vKic5rVrtV-on4HyT5wNCXxbJtwijnCA@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda: intel-dsp-config: Fix Azulle Access 4 quirk detection
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Brady Norander <bradynorander@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
	=?UTF-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>, 
	Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org, 
	Mark Hasemeyer <markhas@chromium.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Cezary Rojewski <cezary.rojewski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I filed a bug and after sharing the requested information it looks
like this device won't work on SOF without vendor support. Given this,
would the original patch returning this device to using HDAudio be
reasonable, or is there an preferred alternative to force this device
into using HDAudio?

Thanks,
Allen

On Mon, May 6, 2024 at 11:02=E2=80=AFAM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
>
> > Unfortunately the above patch didn't fix the issue, nor did I see any
> > of the change logs in dmesg.
> > Are there other alternative solutions or information I could gather to
> > make a more general solution?
>
> File an issue here: https://github.com/thesofproject/linux/issues
>
> and attach the NHLT table:
>
> sudo cat /sys/firmware/acpi/tables/NHLT > nhtl.dat; gzip nhlt.dat
>
> as well as the results of alsa-info.


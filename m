Return-Path: <linux-kernel+bounces-311749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF333968D04
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6830B28458E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7D71AB6C3;
	Mon,  2 Sep 2024 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="bV+q/phb"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4900D19F102
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725299734; cv=none; b=Jza4f8nBSSSLihg3zgNAPh5J+/6xFYGV/M8uyITK7CbBK6umcKMK2ibmIY7yHQ8IVqx/LCYBycxnCLdCQB9hzefvTqn8DL3EBGoewLLttKX9sB0OBsukfEBP0vqFSGaGQU6V2TJSeo3oRomR4sY/wiZpkMd2TeaHx1Khw8ttl2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725299734; c=relaxed/simple;
	bh=//Na6Hi4rDiO4895tLMEcuNAy+QDtfagRuZBVd68wrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlTJFbVoPGx/BnBtGx1WdqQ4E+Z1aczEVfh8XzvfFVTvjlD14FUjzPQjfpxRKXcpXxTPjrEGRfbN7wpD0KKJD01pvK8gOXMLVsLQkjD2JjRHoTz1C9sU/MH0qXGeRswiT1BP+El8FNPx3FL0e+glItHqC96eYz5ZSwfWnVVKW2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=bV+q/phb; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e1a9dc3efc1so2088410276.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 10:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1725299731; x=1725904531; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vCJzaUoCKrcZw/EzjBDtDnLpVKWW7JylBU8q8eZQRSA=;
        b=bV+q/phbH6+HPgjjrdx498zLe5mOov9SnQEt6Wfu9Y4uBu/cazAYuyCPVdicrkJGsr
         CfSPTJt+zYAMKMHJmcxYvLMrIUZFY+/xRAjhuoB9f1vrtSMtOdx7oVqjxMeWgJOft7OZ
         6caghFSXMpsukz8ZjOfG5NNlsIRL55z4UtMBIdmJDutjLraBxc3DgNUcmTe3irKpyEbB
         Lc49ZJ70YhYhs8fgub9VPi7bMbGJGp2UWqTgD8K9FO+kIKP+E7BTN94G/5HeHJ2qwXwy
         zXc9QFjhoFzvkrCABWofLe+Zfdq4EkbHK/eQSKNMkXY6ZnYmg9crrWv6camuXNd/3cBv
         Rrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725299731; x=1725904531;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vCJzaUoCKrcZw/EzjBDtDnLpVKWW7JylBU8q8eZQRSA=;
        b=F3iouA8UgEs0BU2IHfYoXXHQzVCHq2QJ62WMiVinNFDs10jHnT8CX2b6NKxvhiPSmH
         diiRpjnVRkxtIP4CH6XoLKJCvLYVBpetpcY+wYTM5hTGxqXuCj1AsCmG0+0eM8cv82bH
         W3iIxLBLhZ3WT/MWmDmgPe+XxPN4jXgcHc8kEHTQTDp9eipNj930oeLDzMvfE36VwXDL
         c0dbDnEhNgV1uoRVvaY5HH8Qa0QzX75Jf7cx32BaqseEbbM8HyJTcU/LFoTtFxl5qkCd
         6jFB6/VaLX5BSRjdeWuO3enaYrgnOOk/jydeIWytZws6pk9swfld1RQl351Yihw6tGXK
         sQTA==
X-Forwarded-Encrypted: i=1; AJvYcCX0as+65zE3Z3vjxk1TluBz1Liq3T+aOi55fXSkDWi7DajqVbrkIh68sKqhTvajGWWoJMcWQhnlthMkVLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTPdz0/StNVf+qxdVhrgo5ezqcdcYB1ji4dL+yxCIwuJSPmX/w
	UY6Fbc9Iy6jhfeqLMx0o9Y4IeHCaG5/4W9jzfNSxWqr/BPiLHpTaNifgeywSN2p7uCfc2aRB4pY
	z9v2q9Pwn+FyOMykFA4vI91IiO2cYbPi6tQmB6Q==
X-Google-Smtp-Source: AGHT+IFkIAQ1M+OVnEFIGitXBb7fG88L/LBxTisootOKE3vjhJev+dHje0375x4EiTulExj5Vo1MDLb7fEm8f6OStkg=
X-Received: by 2002:a05:6902:138d:b0:e0e:8adf:2e80 with SMTP id
 3f1490d57ef6-e1a7a1a48abmr12639791276.44.1725299731211; Mon, 02 Sep 2024
 10:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902-imx290-avail-v3-0-b32a12799fed@skidata.com>
In-Reply-To: <20240902-imx290-avail-v3-0-b32a12799fed@skidata.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Mon, 2 Sep 2024 18:55:16 +0100
Message-ID: <CAPY8ntD4tbSF41+ShJ0WdP5=N3uJi2tWDEyr-ypcKha40T+Q=Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] media: i2c: imx290: check for availability in probe()
To: bbara93@gmail.com
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Benjamin Bara <benjamin.bara@skidata.com>
Content-Type: text/plain; charset="UTF-8"

Hi Benjamin

On Mon, 2 Sept 2024 at 16:57, <bbara93@gmail.com> wrote:
>
> Hi!
>
> This series introduces i2c communication with the imx290 sensor during
> probe s.t. the v4l2 subdev is not initialized when the chip is not
> reachable.
>
> The datasheets show that INCKSEL* registers have a different default
> value after reset on imx290[1] and imx327[2], however I am not sure if
> this is a sufficient identification option - therefore I just removed
> the current CHIP_ID register for now.
>
> Thank you all for the feedback and the discussion, I updated the series
> to contain some of the ideas that came up.
>
> For now, I kept reading back the content of the STANDBY register, as
> suggested by Sakari and Alexander. If not wanted (as suggested by
> Laurent), I can re-add my "optional read" commit from the first version
> of this series instead.
>
> *Overview:*
> Patch 1/7 is a split from the old 1/2 which defines the values of the
> STANDBY register and uses them.
> Patch 2/7 is new and defines the whole supported range of the controls.
> Patch 3/7 is the old 2/2 to drop the CHIP_ID register.
> Patch 4+5/7 are new and target the avoidable communication during
> probe(). I decided to use a variant that also works on machines without
> runtime PM active, and falls back to the values of 2/7 instead.

I was reading through patches 2, 4, 5, and 7 and really not seeing
what you're trying to avoid here. Adding an option to avoid powering
up the sensor is one thing, but we've got masses of other changes to
fake HBLANK, VBLANK, and LINK_FREQ values, even though we appear to
still have a pad format defined as 1920x1080 1x10 set on the pad. All
those controls are therefore declaring invalid ranges at that point.

If it's solely trying to stop imx290_set_ctrl sending register writes
when not streaming, isn't it simpler to have a basic bool in the state
structure to denote whether we've passed through
imx290_set_stream(subdev, 1)? Set it in the same place as
pm_runtime_resume_and_get is called as it's mimicking exactly the same
behaviour.

> Additionally, imx290_runtime_suspend() is using v4l_subdev, and
> therefore depends on the subdevice. If we move the autosuspend stuff
> before the subdevice creation, we basically have a race between the
> delay and the subdevice creation. Although it is not very close, I don't
> think it is a good idea to potentially autosuspend before the subdev is
> created.
> Patch 6/7 is the old 1/2.
> Patch 7/7 is a new PoC to decide to check the availability based on the
> power state of the sensor during probe().
>
> Note: dummy-regulators, which are used when no supplies are set in the
> DT, are always-on.
> Note2: The "off" mode is currently only active after probe(). If this
> approach is of interest, I would also ensure that it is active once
> streaming has stopped - need to dig deeper if it is necessary to store
> the "old current" before stopping, therefore only "initial" for now.

What extra data do you see sent after stopping? On any system with
runtime PM, imx290_set_ctrl will stop at the "if
(!pm_runtime_get_if_in_use(imx290->dev))" check.

  Dave

> thanks & regards
> Benjamin
>
> [1] https://static6.arrow.com/aropdfconversion/c0c7efde6571c768020a72f59b226308b9669e45/sony_imx290lqr-c_datasheet.pdf
> [2] https://e2e.ti.com/cfs-file/__key/communityserver-discussions-components-files/138/IMX327LQR_2D00_C_5F00_TechnicalDatasheet_5F00_E_5F00_Rev0.2.pdf
>
> ---
> Changes in v3:
> - probably better readable in the overview
> - 1/2 -> 1+6/7
> - 2/2 -> 3/7 (added R-b - thx for that)
> - others are new based on the discussions/suggestions
> - Link to v2: https://lore.kernel.org/r/20240828-imx290-avail-v2-0-bd320ac8e8fa@skidata.com
>
> Changes in v2:
> - dropped 1/2 to ignore the read value in cci_read() (old 2/2 -> new 1/2)
> - 1/2: read-back standby mode instead and ensure that it is really in standby
> - new 2/2: drop chip_id register definition which seems to be incorrect
> - Link to v1: https://lore.kernel.org/r/20240807-imx290-avail-v1-0-666c130c7601@skidata.com
>
> ---
> Benjamin Bara (7):
>       media: i2c: imx290: Define standby mode values
>       media: i2c: imx290: Define absolute control ranges
>       media: i2c: imx290: Remove CHIP_ID reg definition
>       media: i2c: imx290: Introduce initial "off" mode & link freq
>       media: i2c: imx290: Avoid communication during probe()
>       media: i2c: imx290: Check for availability in probe()
>       media: i2c: imx290: Implement a "privacy mode" for probe()
>
>  drivers/media/i2c/imx290.c | 153 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 124 insertions(+), 29 deletions(-)
> ---
> base-commit: eec5d86d5bac6b3e972eb9c1898af3c08303c52d
> change-id: 20240807-imx290-avail-85795c27d988
>
> Best regards,
> --
> Benjamin Bara <benjamin.bara@skidata.com>
>
>


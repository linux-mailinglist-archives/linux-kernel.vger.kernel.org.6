Return-Path: <linux-kernel+bounces-192754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 206D38D21A2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78FA1F25862
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C03172BD4;
	Tue, 28 May 2024 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D0juCU8p"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD22172BCB
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716913684; cv=none; b=lwTo62ov569cGADEN4WGl7qMW8ku7gZ/DBm8RmNZwbN9ohcl6gyPxW0tBUDVZwG3AY7+4f5mnPOG58Qn+Pn+1yGlaN+Ef3urq15lD+01tbKQLq69+8bZKothF6+9kKk5ASmQOeANxOY6yv8ElGvFFS1GP+oKa7p/jVLFLc8uKyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716913684; c=relaxed/simple;
	bh=t74W54+/Ll0YLi8c76pQC7uwzEIjWDtBfp3CisuTzmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mmE7cjv7qlnsUMpECF3Yvj51CQ3971QSZcSpghJh4sqiFjefTm4Gix0uX7LJJ1lnvQJOJxZyHLlAVM6P1c2zcHWz3I9NuHpQuLfxHSj3iMChp9J/2TaHTWyeYXkCcSQSiSDEcKLJmzVmRqQI4wkLM27AxvUnB8sEEgxSicRtmws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D0juCU8p; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-43fdc18a89cso3735071cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 09:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716913681; x=1717518481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t74W54+/Ll0YLi8c76pQC7uwzEIjWDtBfp3CisuTzmI=;
        b=D0juCU8pUZP//lXn5tCCCCJJOcaXMhCl0Qi6bLWCnk/aynCZwKnWzhSlTVHysM8f9I
         lawHkALP+QdtgIFJRbeU8a+ne0kNdmDuwAPvrTpY9cW2k6RNTjkHF8aSW/GSj7VPVgi8
         LBNdE+tYJCiWHSO7LU1egtt6NuLKc6AIMimHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716913681; x=1717518481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t74W54+/Ll0YLi8c76pQC7uwzEIjWDtBfp3CisuTzmI=;
        b=cxri3sfxVLDJCI+frwsBSLBo0LZGJhFCBRsa5xgNSzoOkUHL6I75FsiNebA4Aq0M+/
         D6nbTRPWLYPLOSPpg5YKYZzcQsNj2kE/xboKeXrdCfbkGkv+SdBXK/Hz9M0fPSHT1PEY
         +3wileie4Sn2NAu1iTYGF/5evgcae3wqSHY7cjH4WRk0Pc9gCHjnk5SJet7/lQGpIPz/
         3k4sHMxvBMNekOSN+RasTpLhdeIP3jciSsQXbKPzfZVAGth2gWeFmkQN3r18PSXEe07R
         cx7Lkxl+x0VIxBOg09VNYUCFIQHK4RW7JfhHzLn1gLjkRiyyix6JjISxAc4fMCjr6AR4
         QUOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNyoLYWpyEi15EK9IO7fFcTAkPlEblp8I9f9zSHGLFvWpFPHHPaxgdDJ4og9Qd3a3+Pe+J1EzYjuLmCd/WO8K/D/EbBgHaOXWjKimo
X-Gm-Message-State: AOJu0YxBv4oPXZm8r7gjqCz7/91R3h+Q5NNXR4IALczWQf5fG189njp+
	IdGNfDfMtG3e1qByntz1AH+UEak1L9Q++nqKc/CriAL6r5VWMHWxx+VM3oDOJrDvWEhcVNWJxdc
	=
X-Google-Smtp-Source: AGHT+IFoh/C/8yuXe7M8pA+620kHflzwzRsoBbHn6+H1eTZfstQX2c/GdsdqRr17avCc30cNhLgFyQ==
X-Received: by 2002:a05:622a:148f:b0:43a:712d:414f with SMTP id d75a77b69052e-43fb0eeb3afmr151702351cf.42.1716913681481;
        Tue, 28 May 2024 09:28:01 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb180456fsm44508601cf.50.2024.05.28.09.28.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 09:28:00 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43e14f0bd75so857341cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 09:28:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7jDs/oq6XhoRVDkhYeH3W9EXxcXZIm8wmqA2UqAHMEgGbpnBSNmV+8nP5piSQOklwPQzxmJ/MaLr3Ezc6/fAlnF9C8rBv1VgtZgkd
X-Received: by 2002:a05:622a:1ccb:b0:43d:85ae:bee with SMTP id
 d75a77b69052e-43fbb0588e9mr7721931cf.7.1716913679727; Tue, 28 May 2024
 09:27:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422060811.670693-1-xuxinxiong@huaqin.corp-partner.google.com>
 <CAD=FV=WRLLuOkCJeM6RdAb6xLN-cPH+hfWbOv9-LujB-WMGEFw@mail.gmail.com>
 <CAGoogDB-mj8_xu04w3V2ZxOBTWoXcPKrVR1NRt6BFcpjHX3-7Q@mail.gmail.com>
 <CAD=FV=WwsR9e-ZXJRY11FvdUZ66YPy9vqmY_=sGDw5Wqk1eV3w@mail.gmail.com>
 <CAGoogDBCzfKwkAA-VAs3_Cdw_4oFO94mt7yjy47Sp2RAtqtPxA@mail.gmail.com> <CAD=FV=WYiD-BUpksBnZrkWvORepZqtaAvm5645X-_oJPea0s0w@mail.gmail.com>
In-Reply-To: <CAD=FV=WYiD-BUpksBnZrkWvORepZqtaAvm5645X-_oJPea0s0w@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 28 May 2024 09:27:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WMC0XZBc3UKP+Qzb5aeiWBnXrYDf31PNP5cGeAT-8XcA@mail.gmail.com>
Message-ID: <CAD=FV=WMC0XZBc3UKP+Qzb5aeiWBnXrYDf31PNP5cGeAT-8XcA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add panel CSOT MNB601LS1-1
To: Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	hsinyi@google.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 6, 2024 at 8:54=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Tue, Apr 23, 2024 at 6:55=E2=80=AFPM Xuxin Xiong
> <xuxinxiong@huaqin.corp-partner.google.com> wrote:
> >
> > Hi Doug, thank you!
> > We had reported this info to the CSOT to correct the vendor id.
> > If they confirm to fix this with the same product ID, we will submit a
> > patch to fix this.
>
> FYI, "top posting" like this is generally frowned upon on kernel
> mailing lists. One such reference about this is [1]. Some folks are
> very passionate about this topic, so please keep it in mind to avoid
> upsetting people in the community.
>
> In any case: did you get any response from CSOT about the improper EDID?

Just following up here. Was there any response from CSOT?

-Doug


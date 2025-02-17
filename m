Return-Path: <linux-kernel+bounces-517469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED8CA38146
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F723AC90C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B27218AB9;
	Mon, 17 Feb 2025 11:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iutbun17"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633A721883C;
	Mon, 17 Feb 2025 11:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790176; cv=none; b=blNajp0MrcuIHIw5ViF8smTkPk2F94Dnu4vlKR9w5aoDWHLuSMYTFOTXviPK7+XliokbjBioooDaZUmQ5uxV3ufEgg6lUIoReOhajFNVhrFaBFX18WCUPluGqGXxUT345GhTnXqVpWPudAEJUYGCZrasmzm/uH4UXcmtYtPG1rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790176; c=relaxed/simple;
	bh=Lnnx7lqkVv6ZqmP5mfgdpriJczWPd8VLGObetQMxOio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5ob88wesANzsBxJuswp0CPsrXvNvJwth31gnypiyVrIC/ZzvXSG1/e2F9KO3CvsQp4kkLAjGNW/B/zXfe/vhwuYmLkjZEWeTEuPn1eZU15TOA7ge1kGgauPpatVoAQR5v/xmarNb+AmIU5zNVLqhEuBD8424FCM9GJgywRkJac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iutbun17; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3f3f4890596so583264b6e.2;
        Mon, 17 Feb 2025 03:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739790174; x=1740394974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lnnx7lqkVv6ZqmP5mfgdpriJczWPd8VLGObetQMxOio=;
        b=Iutbun17Mfxm2S5U7QTUk4xD4sTeP71dO4sYEKw1BNhO9BkkAqE//5Vabh6tbDr4A1
         qq1wExeZ+xEzVnIf0gIExIZ6o/WJlpPUa4bmT/jtjxvD6+ShmJybTWArmQlJRDZu8aWO
         J457YYdvNVgOt8CR4u9B6cM0RGSlsJO7kxzTBjwQ7+cEBbZQMnNth72HA4XcMtY+MpJa
         8s9ZaXr41ZTXVCR2qY1U6/szMtOAC2F0ZpZ38+VJdySs9b4sJCLlZoB2cCYYTQKTnsqA
         5seljHueJyneX8Pi0VTw3Jn5RSthjyfWhAd3/II7dIGdJq/dEDM2Fv8KiX+ExwbeNWqK
         M/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739790174; x=1740394974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lnnx7lqkVv6ZqmP5mfgdpriJczWPd8VLGObetQMxOio=;
        b=m5viS6+eDkSVd7XV6svw8pZ9PEVqsEjm9UA4jr6FurhlPtzri3K+MzA9xOsAqw9Wtp
         XOUPYKouRea6HQCLV2OaGSD9iS/66C7Nxl5fRadrzk4GF0edUo75f3vf9htrcQnKVUwf
         FbUow11PIvsbS5oL5QmkRHKHPMt7a9P2AegUb2qunGBWOiCYjCmInK7gD3aG4QXTU3VS
         jLEIjW8akDB/QdVAOagJkS2sLFGXWpenPnYRaqVgrNqI6Z17W8RVq5cES+7ht6zNgdgx
         xArE6U4+FhGPmLMRoFOcVJZMXk7d+t/M2Dui2sxcwSfojZlpGd8AeurjvrWOndGtCPiw
         V3RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlWMFje+l204kkKYYYmsSfslpnWstZ6XsoLFjWUGEVC+cePbR2Vm6lF3rK4c+CBWl4PBhxQg0MjKWQK1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAeYCPnaV71Roq781Ih1VsLlstv9dGhfAC9EuxRyuuEPIRngRq
	yKEO5t92NsWwd88/B48E7/EE2/1B9EcXBtXRggqv29wQr+PEAT3cIcbsM1f8mQ3Swq0Txnu2UuX
	GeR3dsD5vBqG7f5Fx3Bbp06Z7h+vsTxwS
X-Gm-Gg: ASbGncvnqo39Gn2X8pWDwR9nRaLIP39QKipTLHv3ZPhL+/CJl5efy1m4EId3LT1j41z
	UPpur5T467Ckts6mAemn9ZwLdw7jqmYI5pGdJYy3VBhx8+3PXFeyAju6v9gv3dM3IshuskzL6zQ
	==
X-Google-Smtp-Source: AGHT+IEFEkiF/WCqbVkDsd4BcEKjAzfg2QzRNR8iqV/Jtkhr9nKPgfjEhiwrHu3SRlyw97JNkvvBkwMwlo9X63iMuQw=
X-Received: by 2002:a05:6808:1a0f:b0:3f3:fe6e:75ed with SMTP id
 5614622812f47-3f3fe6e8401mr1213317b6e.22.1739790174245; Mon, 17 Feb 2025
 03:02:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHhAz+hmga0hLQcGtOjxuB+xoOsJ9xvFvXXUWfe9HpFcMRNUpw@mail.gmail.com>
 <a84d675e-3b42-4251-b575-9e6a28cf20bf@linaro.org>
In-Reply-To: <a84d675e-3b42-4251-b575-9e6a28cf20bf@linaro.org>
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Mon, 17 Feb 2025 16:32:43 +0530
X-Gm-Features: AWEUYZl_QRg_C1G3AtxNAAu9AarRZfqbY18CDpOUqmjK-osvsRYuJptIUO0fYeM
Message-ID: <CAHhAz+iUdm2Ko6hz7jgObiL=pgZiwYFnyoCmk7wftONbKEnrEQ@mail.gmail.com>
Subject: Re: slimbus: Inquiry on Additional SLIMbus Drivers and User Space
 Test Utilities
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-sound@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 3:58=E2=80=AFPM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
>
> On 12/02/2025 15:30, Muni Sekhar wrote:
> > Hi all,
> >
> > I need to work on the SLIMbus interface on a Linux platform. As part
> > of my study, I see that in the Linux kernel, the SLIMbus interface is
> > managed by the drivers/slimbus directory.
> >
> > I would like to inquire if there are any additional device drivers
> > required to comprehensively test the SLIMbus interface on a Linux
> > platform beyond those listed in the drivers/slimbus directory.
>
> SLIMbus is used as audio transport interface on some of the Qualcomm SoCs=
.
> Qualcomm Codecs (WCD9335, WCD934x and some of the BT Codecs) use SLIMBus
> as primary interface.
>
> w.r.t to testing, its audio end-to-end usecase.
Thank you for the information regarding the SLIMbus interface and its
use in audio end-to-end use cases on Qualcomm SoCs.

I have a couple of follow-up questions:

1. If audio is the end-to-end use case, are ALSA Utilities and the
ALSA Library involved in this process?
2. If so, what other ALSA drivers are used in conjunction with the
drivers listed in the drivers/slimbus directory to comprehensively
test the SLIMbus interface on a Linux platform?

Thank you for your assistance.
>
> >
> > Additionally, I am seeking information on existing user space test
> > utilities that can be used to test the SLIMbus interface on Linux. Any
> > references or recommendations for such utilities would be greatly
> > appreciated.
> Am afraid am not aware of any tools that are public.
>
> --srini
> >
> > Thank you for your time and assistance. I look forward to your response=
.
> >



--=20
Thanks,
Sekhar


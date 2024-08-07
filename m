Return-Path: <linux-kernel+bounces-278617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5282A94B27A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 006E11F22039
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781B81534EC;
	Wed,  7 Aug 2024 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mdq5QeKL"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4DD14901B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067788; cv=none; b=BIl+Lej6tgUmrSSgRzVyp4ZI4Y9gShf1ctRup5zBlqu8gmZx6R9yG9/OBzNadamI7T9pGnJvOc89vHxL4lolXRMgoycHAeiJ46wqD2tVb3l0a+0xl95uGHXFOvN2FkhmQG2KLXDUfQ3sc4uZOanbJSx8NUkT4qYKk0JfxaBem6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067788; c=relaxed/simple;
	bh=XPRl8AKc7BvHuB3QMo2rImKhhrZI5XkY4l2t0/ndEuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCoqZ0MMcFu65UFDeyhK4/82/6oqa8LFMFwNjjLObeuT1ihXGoot83HEo1eDDMJ0QYN1vbF7muJ8amaw8vTb9NRYo/3iHSJeittfANh0cTXn4piEIHnYlvHLYBUXKPGOsA3QycJ7vflLNlpRuezMZ7SAcNYYHB9IisQjl8cAxAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mdq5QeKL; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a1d6f4714bso26137485a.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723067783; x=1723672583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVodnowP0eaUum6OAuR4DXp0pjV1BAajzdmmLHEX8NY=;
        b=mdq5QeKLuPhs0rkooCwz4hHjSL4EK2R1Gjbr7Trxj0YqP7TgHhMwNSAALxEnfU77tz
         1ext3HnOzob5r7Ku/uNhWIOuZd64ddl5+JVSmzQQaBV0IDfKV3ZIgweMwhwzMG7QuItD
         J0ojQcEBd6QAOUHOsV6Erum1/TISQkChsbEMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723067783; x=1723672583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVodnowP0eaUum6OAuR4DXp0pjV1BAajzdmmLHEX8NY=;
        b=Ky2CUC/send7bmagXc6xjvCxh3/UYsue4wKHogdSi4gQHLk88zQASsyPZrieQE0URp
         4IALqF+YlnkDllH/TjoVrH9MRtzS5edd+zfRvv98/6DlumFXgF2TjebwywMIEdnL/HIc
         jqwt/LI/dvJeYsBYtFeSeamuZxONTHMikYoRJyPR2QWn3dd1apqGcaC1oi2d6qi5E90e
         p+cKpBYQ5ZSqLgkZGoPvN1it+Ej5wCeprSV5TP6Sq0wdZUV5dasnswIA1/QOdJbBiRPM
         usk4bOWx9tLxF0OZOimhD/tJ5H3ESfUgJph0oNGZO3O+lVZlYw8/V3RuATR5LopwXAFW
         ZV7g==
X-Forwarded-Encrypted: i=1; AJvYcCVU7rHzP8Bn4jjI2OOvbGElKsNMSwIrMMX70FbI/HKb/gLJJ8b82HKpMvdIf2G2JRac/T8vr8P7PqrJIvugf1negYMft4gMrebYyxJs
X-Gm-Message-State: AOJu0YzH5ey+CZhOV04Ics60Tif66G9bO1+ifjHMlMB49tyYrURdoud9
	CtThBC/dtYppHnj0bgSRzTanFakxkYKAGWcu02ZKrz886MadYV10XtiUxqVJ3y65ktOH18kuOHs
	yrA==
X-Google-Smtp-Source: AGHT+IFWqgVlYMX105Vx+4XY5wwuxor68chk5QLolQoFOr2Z1i97tPViQxSZGXDIwOejK8ROmam2UA==
X-Received: by 2002:a05:620a:2910:b0:796:de79:f577 with SMTP id af79cd13be357-7a377be7123mr645479785a.7.1723067782928;
        Wed, 07 Aug 2024 14:56:22 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3786f9562sm94971585a.136.2024.08.07.14.56.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 14:56:21 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44fee2bfd28so57401cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:56:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9Gyrms0QXR22K2sgwtdQXqHQ/uMYTpVoDXMf+FJNj0vv00tmIX5y9ONp81hgIO2MeHrY1w/phfyjoRNnrCpI1UfbEzphdVS3Nm5yj
X-Received: by 2002:a05:622a:1906:b0:441:5e6c:426c with SMTP id
 d75a77b69052e-451d382a2cfmr401061cf.17.1723067781326; Wed, 07 Aug 2024
 14:56:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807100429.13260-1-lvzhaoxiong@huaqin.corp-partner.google.com>
In-Reply-To: <20240807100429.13260-1-lvzhaoxiong@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 7 Aug 2024 14:56:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WCw6pAump-PUFCW0cgbRY+5_2tPNLe=hN3-dnXD=B6MA@mail.gmail.com>
Message-ID: <CAD=FV=WCw6pAump-PUFCW0cgbRY+5_2tPNLe=hN3-dnXD=B6MA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Modify the method of sending "exit sleep
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	hsinyi@google.com, airlied@gmail.com, daniel@ffwll.ch, jagan@edgeble.ai, 
	dmitry.baryshkov@linaro.org, jani.nikula@linux.intel.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 7, 2024 at 3:04=E2=80=AFAM Zhaoxiong Lv
<lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
>
> This "exit sleep mode" and "set display on" command needs to
> be sent in LP mode, so move "exit sleep mode" and "set display
> on" command to the init() function.
>
> Modify the Melfas panel init code to satisfy the gamma value of 2.2.
>
> Changes between V3 and V2:
> - PATCH 1/2: Modify the commit message and subject.
> - PATCH 2/2: No changes.
> - Link to v2: https://lore.kernel.org/all/20240806034015.11884-1-lvzhaoxi=
ong@huaqin.corp-partner.google.com/
>
> Changes between V2 and V1:
> - PATCH 1/2: Modify the commit message and subject.
> - PATCH 2/2: No changes.
> - Link to v1: https://lore.kernel.org/all/20240725083245.12253-1-lvzhaoxi=
ong@huaqin.corp-partner.google.com/
>
> Zhaoxiong Lv (2):
>   drm/panel: jd9365da: Move "exit sleep mode" and "set display on" cmds
>   drm/panel: jd9365da: Modify the init code of Melfas
>
>  .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 137 +++++++++---------
>  1 file changed, 71 insertions(+), 66 deletions(-)

As per my response in v2 [1], I feel like patch #1 would be best
reviewed by someone with more MIPI DSI experience. My current plan for
this series.

* Snooze for 2 weeks. If someone else has reviewed / landed in the
meantime then great!
* After two weeks, send a warning that I'll apply the series soon
unless someone yells.
* After a few more days, apply the series.

Please yell if you disagree with any of the above.

[2] https://lore.kernel.org/r/CAD=3DFV=3DWrMxyxkuCYEbd=3DaYFaTJKNqGqXr6Re+V=
=3DB_h9jnjHPvg@mail.gmail.com


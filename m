Return-Path: <linux-kernel+bounces-170301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5628BD4B8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 20:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04E91C214E6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58298158845;
	Mon,  6 May 2024 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AFeijI+J"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2E73D984
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 18:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715020716; cv=none; b=Y+Nxkei8JA8UW1JJzpslfBVKGAHxfWdcdVeNC6Dmy4v/OoQgPXqgY1Z/hDyKFfguEz80OQhZwaZXUY3OyDazG9W6D1j9akC6ZiLSFLgEfUlrh/9EVsPxFmZK2uFuPdwxr4ZVZQHvqi8ad+p2OmO+/wB/IU/jv7dFyjU5JwdN4QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715020716; c=relaxed/simple;
	bh=41XkVcsAUi7RHQrRbNaV4xF05Bw3iVhPE+6NRtdz0aM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=OcGAg2EA7nOYP+E9bpog8WOw/3sSYvrBOGFPU+2DcY0VZ1f9J0UsR7+wZFoa/OS+A8df1WVw21eCHk/3Gj5p5pyXyR/9siYkjx9Zdvr+OCcSo5XniJVj9GYOOideCkmMvavLHBWBhjY7bm2BeqJQ34cQl2pEDFIcIH87TK5VCGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AFeijI+J; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-43ca9047bd2so33417831cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 11:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715020713; x=1715625513; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wc9Ykp5KZiv59MVDuw6AEA9atSsYjCqiDTLg4L03H+E=;
        b=AFeijI+JH/NRyBDf9aGv1OsuTo8jnqh4ieaDeFBisnDZ8vIGkUmlGL/0cWF06kqY9x
         wfWF1adQHsYw9m98+rT6+dO6O9nPeykhDXqLb+9ZinuFqT+0A6AmCo+xNQiSk3T+AOFT
         BLVr7/4zCQqTAW4bMxrqD7FzIt37bpCViaPew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715020713; x=1715625513;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wc9Ykp5KZiv59MVDuw6AEA9atSsYjCqiDTLg4L03H+E=;
        b=Ozw1aF1He/kL4b4EiMKZCil9rvxTVpstRZInv0blVZRORSVjtEi43qm3uaEOtRAxQI
         wh8pOlYBUKzcDZBCCnpodzBEOSTLtH7W9+8PjpEMHy6dNwe7hkJ8j33Dq+79gVlaOD/4
         llNcknIpQ61dVhg6jeoFkC4MBBy2s2xtBXLysoCbuheQJ0rDNf/K08O0Gw5049q8wiDR
         lXkEtIrFJqhm8Bo3t9ymoz7cG1HQLPvB3Vz8EDRuWLBD1oFvZ/my17NlZjCBoihBKfzI
         ofQ+ZjwoKbD6D6ErQaX8LuqyBezhA77kBbGE7gogTt+gcsd+7gUnziaOAXolOoMFHAWB
         bm/g==
X-Forwarded-Encrypted: i=1; AJvYcCVrWdqH1IRwBL8ZUyGivuHXam1b1VxI+S3W92bUXIRA6qSFh5i3k3ePSx5D/1qhokOsyaEC3yADMMdckRFn3JJTeZOAL1ee5fWzt52m
X-Gm-Message-State: AOJu0YwPxD8O6G7sQOn2mPwF74g8BVoTD182z2Xyv5Ocs950b/lOIuaD
	e6pZVrVzxfFfcvsPlEywahOp+eUki0N09fuMa6uhF7eafXxsnO6fMiBxintQBzjiFif9YXc7wHQ
	=
X-Google-Smtp-Source: AGHT+IHvynVvkktEJNOZRfJZC3n5l5rzbZN0sa+aDeo8aXBhK/9wCGwD7M5aeubC4L9taT/L9Z5ucQ==
X-Received: by 2002:ac8:5a8d:0:b0:43a:4b07:57ec with SMTP id d75a77b69052e-43d8f32b26fmr8886951cf.9.1715020713332;
        Mon, 06 May 2024 11:38:33 -0700 (PDT)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com. [209.85.222.181])
        by smtp.gmail.com with ESMTPSA id ex8-20020a05622a518800b0043a51b452a3sm5410928qtb.20.2024.05.06.11.38.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 11:38:32 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7928ec5308cso210388185a.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 11:38:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWj8+NRfU/f+OXzZ12c8XLvtDgzE2tm9U+tDzeiEhbOHWTBHPFSmFg6m/nhHrBY4TMykEL1lFwVAPk9u4rvtaPL0+lhydqMGuZy6d98
X-Received: by 2002:ad4:588a:0:b0:6a0:f0eb:1679 with SMTP id
 6a1803df08f44-6a146005801mr7792556d6.8.1715020711735; Mon, 06 May 2024
 11:38:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 6 May 2024 20:38:15 +0200
X-Gmail-Original-Message-ID: <CANiDSCs8i5Eid-FhDkgxTghFu8Sk831SojZwAohJ-CbKRch5KQ@mail.gmail.com>
Message-ID: <CANiDSCs8i5Eid-FhDkgxTghFu8Sk831SojZwAohJ-CbKRch5KQ@mail.gmail.com>
Subject: Conditional guards
To: Peter Zijlstra <peterz@infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter

Probably a stupid question.... but I'd rather ask the expert directly :)

I am trying to fix some of the cocci warnings with guard() and there
is a  use case that I do not know how to do. I have something like:

void use_hardware(priv) {
  if (priv->model =3D=3D 42)
      mutex_lock(&priv->lock):

  // DO things here

  if (priv->model =3D=3D  42)
      mutex_unlock(&priv->lock):
}

if I replace:
  if (priv->model =3D=3D 42)
      mutex_lock(&priv->lock):
with
if (priv->model =3D=3D 42)
     guard(mutex)(&priv->lock)

gcc screams at me:
drivers/media/dvb-core/dvb_frontend.c: In function =E2=80=98dvb_frontend_op=
en=E2=80=99:
/include/linux/cleanup.h:119:9: error: expected expression before
=E2=80=98class_mutex_t=E2=80=99
  119 |         class_##_name##_t var
__cleanup(class_##_name##_destructor) =3D   \
      |         ^~~~~~
/include/linux/cleanup.h:164:9: note: in expansion of macro =E2=80=98CLASS=
=E2=80=99
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/media/dvb-core/dvb_frontend.c:2776:17: note: in expansion of
macro =E2=80=98guard=E2=80=99
 2776 |                 guard(mutex)(&apadter->mfe_lock);


Is there a way to support something like this?

Regards!

--=20
Ricardo Ribalda


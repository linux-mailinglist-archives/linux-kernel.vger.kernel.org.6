Return-Path: <linux-kernel+bounces-561778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D64A7A61605
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F071888DE6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3037202C5D;
	Fri, 14 Mar 2025 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRd5c9m5"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1F712B63;
	Fri, 14 Mar 2025 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968953; cv=none; b=kCiPxG3fto8w+jZtBm+vwZJ+3X6s9c35wQlSo8bJ3feEz9Iu5mRYoe0Jb6VsFr9tNlsBz3FudQ48C2YHMC8Uu3QHV4qoCJCRY0ETcRl81UshjWk/NFY8W+2nOVhvxVR+ELKgA7a5IjWgir7UT1e082W3U2Hg8eBjJIX864BDXL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968953; c=relaxed/simple;
	bh=nqtk7IJNV0Jlogzo2grgXmBklKukxwQuYjeZqgeesfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVhPuqZlxMe0A7Jgs7irkyA+S6YrHThcYDqhE0EN38OpDZ+YrQuiV7akY7sfdM3d9zLgntF4Hmkjx+1KkJza/oNSOI5tLG887tbSC41QZ+8FPNH8fajh74JpxI11ktFNlfPAN19sKctlFLTw7vpeFW9YbBpWNiNbjjeI+nCWIIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRd5c9m5; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-548430564d9so2579052e87.2;
        Fri, 14 Mar 2025 09:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741968949; x=1742573749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqtk7IJNV0Jlogzo2grgXmBklKukxwQuYjeZqgeesfY=;
        b=YRd5c9m5+Tz8MacuG+M4wwqDbTdJoNXXAyLlr2Ff67j46VP9zUILQjtDcRyMykAV1d
         251kwe7ijokAzMDdmqKoiK/h3dkNCkJGO/2OdkcAwXuyPHOZxZxqFRI1k04isB0IwTIm
         3VTO5o431rj60W0FsVU2CU05QU18DVyIYVcyBgAVVlcdkDoY6PawAE6d/Ht6PGCqs0Cf
         BadmwgEAdUVGo38+PPmC0AJH+RejVzvNMEKWDhp5AMVEeceqVy8GPChFacCXAdAsbt1c
         NRsadH0YDBpYnTf6uO64OwLiiwyfc8LstkkM7jKNOmiH8jaTgOWeOd4hG83yVsZBdstN
         9bGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741968949; x=1742573749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqtk7IJNV0Jlogzo2grgXmBklKukxwQuYjeZqgeesfY=;
        b=ItWZIC50SFdeHc+eJxrW0NjqRMrF5khkEbo+y4kGw7qFTD5+aYaAsEgKEw6sCm83mg
         VRQNoLOZHhm0FypESg6K7d2VnBPgfQyz93Z1LU1lg+NU0X/8skvwxh8a4VKxNQk1y/Sq
         rCOiA9d6WvR7yZrc+oL31e7xyFYnprEHpdvqDwLPfi/eXvBbwyIYOmkcduHr/SAZn1m+
         esiOt0x7kVcB/F1ArPQsZY5HBjjMnZ5I1Xm3Kk8/EFLd71Tnx0nJVi0eyTQeTalbW8Uc
         x4LRtoPQls8VwcKqPEfMHn5wBh8jEQiGAALDYLgbj8kILbbbaQzukAjay1NJQ7WEKiIO
         aMrg==
X-Forwarded-Encrypted: i=1; AJvYcCWG54/jDcze6PRa+Aeu0/rs0CppUTK5/wVleqed3cgt0cSo1cT6HcoJpum66bw3ma6ymZUZ7YIgbAaPBZwB@vger.kernel.org, AJvYcCXFdLyvxeHd8nX30p4QWmUruobmRhPhJAMCnmf/F6H23+YumTQcZd8JlEuCnW37kuXPT74PTQBM93L+@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr1cXz6QDp7jBuu8rcqY0oSy0rxuQ6JA6NknZoGmxQ9eJjx6ez
	nKdfMZj2RL3UTxlhuB4EGYxDIBbRwGEN7ikBnGlqYa9VZ9c+lj1hMC/bhoqe62gwaqUIJdcJrdQ
	cgMEwmrpoGbA4PCeQkpc+6KTDaWhWZIrL
X-Gm-Gg: ASbGncuK/EIYDfntPHHJ++cY3tLAZ1Om8jg+JLNWIv38AKprVK1rC0vc5t4g/wQz41o
	byZY6cDak48S75W5aDtShLCeoyvJONLGyzUC/wOaJ8t1cDzEMzK8uy5FIe02cxqK5shWSzkdY8c
	uVcjWTUjVU6W7I2kbsrAzJz4jpAuVHOpBq8TSjVKniLUWileOQWchA0qPMnw==
X-Google-Smtp-Source: AGHT+IHs4vHG3o/VoTCk8BvZAkaA4ZWrJ6VUBnc+4V5f4RD13xhlVAn9aENqaNp9snNvosmgj0yTWM/vq8qkdSSAfs8=
X-Received: by 2002:a05:6512:12c2:b0:549:9078:dd46 with SMTP id
 2adb3069b0e04-549c398613emr1113102e87.43.1741968949238; Fri, 14 Mar 2025
 09:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306222359.797855-1-Frank.Li@nxp.com> <CAOMZO5CL-qQSHuSoCtb+f_mqNG8vu4tTVDi-ThoHq+m9SeagxA@mail.gmail.com>
 <Z8oqhGmVOBCPlJUI@lizhi-Precision-Tower-5810>
In-Reply-To: <Z8oqhGmVOBCPlJUI@lizhi-Precision-Tower-5810>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 14 Mar 2025 13:15:37 -0300
X-Gm-Features: AQ5f1JpU2myyIHkRjTA1o08t3hT9TDTNqBiNNH7ei9kP-eOpdOt4OgxaTqhZts4
Message-ID: <CAOMZO5A9ggneYjfR=R4kY7DY-BC2pMh+ayiPEtOTOipCdtBWvg@mail.gmail.com>
Subject: Re: [PATCH] ARM64: dts: imx8mp-evk: add ecspi2 support
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 8:06=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:

> Thanks! It is actually to get spidev. From commit message, I don't know
> what next steps should be did, use "rohm,bh2228fv" or other method to
> support spidev?

You can add a specific spidev entry. Take a look at:

https://web.git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/=
?id=3D10254a6c6073b0be171d434a3aeeff0256e59443
or
https://web.git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/=
?id=3D9783da2384c5623d376e4641bbce9339be1001eb


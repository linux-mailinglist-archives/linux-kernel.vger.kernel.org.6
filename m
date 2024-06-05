Return-Path: <linux-kernel+bounces-202050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 969438FC729
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AC4F1F212F7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ED118F2E9;
	Wed,  5 Jun 2024 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+rynhMH"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D4418C33F;
	Wed,  5 Jun 2024 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717578180; cv=none; b=uaOsNbKMqlDU6Jj+cOo2XAPJlXEltEAd1IDsQJ57QMatnZ1ne4N+5ktVkMZr/EREkFoB0KeFDP8pxlyEiFeB6y1bOP4Oq15ucQ/aob+cFacVKQpqoRGW0SRKqiX5xVn7x9ewHrdscezb9z7wEVANYhFDEYxC3OQxhzybJ7Axk2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717578180; c=relaxed/simple;
	bh=zmwcNvVtzUsW3WtiypS18tlVDvhRnlBrSP64622/u4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GhEGZq+EZKTprsKtxbqESYsdjbp4NkDY+d8rMKtFSpj5yZxRJPYCTU9c0UGlJsDsmHJSybAuaRQSh/AmzAmCqHtBK+XeEG4JzZ6XsKWeHsWdv9T9gUvNO/1Z8fHEh4iSS/5IgGLzth1YvHPCSYpvbbyjMH9kE3vityifOuYi1T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+rynhMH; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e6f33150bcso67456481fa.2;
        Wed, 05 Jun 2024 02:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717578177; x=1718182977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmwcNvVtzUsW3WtiypS18tlVDvhRnlBrSP64622/u4s=;
        b=e+rynhMHH7UozbswB/Gheb2ArJIfEuzAMM9xeGPwHw/TVDkBbuh2k+1OjW3n2GoojN
         p0vS1Fmx43enP4blIpuKtkO6SiL6BsampSwmooe36WFe9H37KHixZskKK5kubLmkxsKN
         Dxr7TQQxsz9Wc4ITH4R13KAV6MxMDCVFvSrUEBgKW2FxQjlHX6N4okwtT0npsDE6K6Bj
         V8ATi15HWdq9kzuxyL3ugzQ5gB/dnkTHrGvL246Zp93bD4CzMh1sxbrNavrK8eGI/F0u
         ho5hcltoAzi2EY1qoZIPPLVVpAjfFq1xGcUCZO1Jtuu61xYye84fAc5rXbYIX0Lo5o9L
         O05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717578177; x=1718182977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmwcNvVtzUsW3WtiypS18tlVDvhRnlBrSP64622/u4s=;
        b=kYXfxCU0qPd7Z83bj+Z25fVbj+J1BthUL+8m+wUvDlahQG787A6tM2s74Ie04JhGtK
         7JUjqVHzT9FvwuqqwzFT+dLcfJMTnZscfnF4hDtFjGnE6D260khObi02eutRYmIFVM5r
         WYCxuGb4iyyIaA0R6EwrDN1bxtlK8o6PVM2Y6yugb68V3wwgYgU1Ammi8HdYSTZnSr6/
         4M+21ww0CwphHtqfir6ppiirMf+wKSl04H5kEvYiuG9U5BDw8yOcgRVEf4Tj2ZGsESZW
         ynvxLn3sLtP25NfF5Y3Z3uslbsi9pH+sR8SPTe3f2fZEqtLgh3DM4ubGrco4Mp2jFEfU
         6H3w==
X-Forwarded-Encrypted: i=1; AJvYcCWTX7Yrhez/k67PZM/SyuwvsPGppK16Yb6hwXshzEXmk+h3SCfbyPAsUlJ6vZv+rcr2lmwNAdFX919Rs4QA5qaN4WhWDQEhFc0FnxPw/k9iRAo3FkSPRO4dZ4T+XEg+rIua82KZn3iA+JB1KXUGbKE19+4EXk/lMKGsUbbq2a6Lz76rsZJ/
X-Gm-Message-State: AOJu0YyWTi7ePZYXBG58xkMccPx/0e/dVBMu/OIaPG6liCJnF13t63wS
	bZP1SQN4Yi8/A9xAb1bsN0LjaMXLBvR9L6vqJ7TtaFRrJUJbPTpJfxRTpYHDXRXp/WQyiEInBs+
	kRLRo6cXy+MZ7vwuKUfElObyZBsE=
X-Google-Smtp-Source: AGHT+IHN2AaAVLuIQp2KMpJW4wj0q4+lo/QPRGkv+6938AiGZHczF1I3ZCYJIuWJApinHAoUBYl8JtVX9orN7UhkuUA=
X-Received: by 2002:a2e:90d6:0:b0:2e9:881b:5f02 with SMTP id
 38308e7fff4ca-2eac7aa4f5bmr9743891fa.53.1717578176545; Wed, 05 Jun 2024
 02:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530111205.1764-1-bavishimithil@gmail.com>
 <7845bb1c-47d5-41f6-bf08-bd7b357df02c@kernel.org> <CAGzNGRn=e46yYrK3o8JhUmod4pGFFdEK31kUWUU4jn+JTgZjQg@mail.gmail.com>
 <6af56d35-1874-431b-9e6b-97214940b89e@kernel.org>
In-Reply-To: <6af56d35-1874-431b-9e6b-97214940b89e@kernel.org>
From: Mithil <bavishimithil@gmail.com>
Date: Wed, 5 Jun 2024 14:32:44 +0530
Message-ID: <CAGzNGRkuMqXn+XP79bGMFgNQ4vzcVFvit3DjUn+YZ_sr1cZo5A@mail.gmail.com>
Subject: Re: [PATCH v6] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: peter.ujfalusi@gmail.com, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lopez Cruz <misael.lopez@ti.com>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 2, 2024 at 8:49=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> https://lore.kernel.org/all/20240528164227.1988357-1-andreas@kemnade.info=
/
>
> https://lore.kernel.org/all/20240530211654.7946-1-ansuelsmth@gmail.com/
>
> https://lore.kernel.org/all/20240522151616.27397-1-pratik.farkase@wsiswed=
en.com/
Understood, thanks a lot!
So something along the lines of
Convert the OMAP4+ McPDM bindings from txt to yaml (dtschema).
Drop ti.hwmods property as it is not needed since the sysc conversion.
Add dma, dma-names, reg-names properties to match the DTS so as to not
break the already existing ABI.
Update example to match the existing node.

Also update the changelog from the start noting all changes.

This much for v7 correct?

--=20
Best Regards,
Mithil


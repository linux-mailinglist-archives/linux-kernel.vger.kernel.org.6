Return-Path: <linux-kernel+bounces-186551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED978CC587
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A6ED2847A0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749EE1422C8;
	Wed, 22 May 2024 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mw7GoOCi"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7182E5223;
	Wed, 22 May 2024 17:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716399056; cv=none; b=B8pWS3TwLE6NfY47zPiMigvY5OS3DpFWf8QBdP8GUS6PICs9Jtab44lHjxZeXhFxhxHn2hiPo+P9o6IySYLQ6QQMp7lBeS4+COU+z3k0SWxIdRs0VobNB2VlWMdBQwpCeXfkolNqfVGoVooQzooTCC66SDoRw0GhiEeQ7w7X+dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716399056; c=relaxed/simple;
	bh=pgVOtAMYcJLOL5rY1GuVX9oZsXUI0zjls9R+s3vhh7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYfg4ycMaqylDvux0z7VbxeBFhPwq8iKr28O6GgaJ3OPPNWFFMa8yBnJgyY3jz3REun0pUmlPNCmYirK4XKxZwdPyZiV8AF3fBwcZDyl4p/y1/z0YZUTNXhEc3z13PpkPkEbnwC475gA6kKMbiMjV9MKQaEilHHqHT4y4sbdo18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mw7GoOCi; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6ab83788bf5so4684846d6.0;
        Wed, 22 May 2024 10:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716399054; x=1717003854; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oioJ37cLyddSrjaAU1ulmlInPWXjX5bMilUDK/7ET7s=;
        b=Mw7GoOCi8VtCXmImr2tA/6ix4S3ak4ZuAwnP+Mre5QVLXx1E33jH/luFhyPbDvymhk
         rEjhdmwMrdDvGCaxDVL2+fmrxounT70c2PfhDCKXdDAHJAOxjUggj4dBqGyLzBzBnLeN
         +Fq/HOE5AKAEL0hp7XDqEOWcHFbHysUoZyxWZhXSFPOaZCZh0RU6jLfokMQNNuvL1D0s
         cS4XTg1aZKEOS4vnugh/SC1xT68xm8m/kvoe5vt7phjFqV3IKEY5aMqPwSJKjeSCKj5d
         BrMfGdAyYpjn8MCecI/hLVSmygcR/l6hIgkhKRiGfkQ7K24pmWf9mne/tZ8YHaUXJF+b
         w7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716399054; x=1717003854;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oioJ37cLyddSrjaAU1ulmlInPWXjX5bMilUDK/7ET7s=;
        b=mVzXFW3IWndlk9keAfX2XKMliwn7PdHdzhFbFOf0w24X8sSdW/cvF4LH5mCGxZGuFv
         eIS8PReiGNydoXFKy6sPtulaTjUkeDBaiW0i8fAftpZMwN+TEY5zr3yIBERJtBc5BydK
         4Ks3AdFIGXehmE/56ieynqp2aC7cbcWthyuyYeKl4X9aTGMa0NveVJIJ1bJItxq64haQ
         rlpZ44EUXoLgTUNw6kyVn5pdU66LNfWH6h6rexID+pjrfU2ZcxrqhxSownJv+Pl08H9k
         jv/UYpuHvND+vPqDqH79cqQibypmTr6mGSfeG6s9iM5AB97fURHgF1iKHaNGS/7qlStC
         K0vw==
X-Forwarded-Encrypted: i=1; AJvYcCVQYaVCO9x3qJqekIdJ48DZa49cIw1EtWVPEHrE4gLIHAAlWGDbCUd8pYqdCR0D2eox4Maj7TGJo/rJQEpqMWqic2LHElzdHYlQ3hS4DYRI8kRhAslwNJHrqvWaFwyL0sDMzXuG3RBHvpx5RsyqMB52XKX37wVb4HcLZzqV1d+obHEx07gE
X-Gm-Message-State: AOJu0YyXRtg1tqG0eaKCF2exiSRglhWlVkJpLqHlVH6mwnvJLWXy1UVJ
	AOi4yp5/DRZ0vriVLf6cMaTLXNF8B5joKpzZ+OsUOHdCBt4SpX783ypwcSJ28JwiXgCUZ3aLmPc
	eqFe/RVDTi85QhjVF+JdHxlnLvpU=
X-Google-Smtp-Source: AGHT+IHDP1WY4e8aqcII+jTqWULSqgYOoJokIdckgEsVizApYaeJaCjXUQm46lslJCkiV7Iq2xd52mYFyZy6ndEuuwU=
X-Received: by 2002:a05:6214:390a:b0:6aa:9bea:9302 with SMTP id
 6a1803df08f44-6ab7f34efd5mr26235636d6.14.1716399054308; Wed, 22 May 2024
 10:30:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522075245.388-1-bavishimithil@gmail.com> <0594944d-c158-4840-8724-b3f2edaab1ca@gmail.com>
 <4f722e53-011f-4176-b6af-080522165007@kernel.org> <bb44d588-9316-4509-b545-9bbaa2d240cb@gmail.com>
 <3c6c5be1-fb8e-4bf0-9f58-cfb09672e8c1@kernel.org> <d999bc26-9bb1-44a8-92a3-bcbe14c5a1c3@gmail.com>
 <58ada5ce-5c02-4ff5-8bdd-d6556c9d141f@kernel.org> <CAGzNGRm5i8zvnXiPzMg5=+tr9oyBcRA8LFvnmgGzE=MzSNTXug@mail.gmail.com>
 <e384272a-4dfe-4653-8983-6426f8803c84@kernel.org>
In-Reply-To: <e384272a-4dfe-4653-8983-6426f8803c84@kernel.org>
From: Mithil <bavishimithil@gmail.com>
Date: Wed, 22 May 2024 23:00:40 +0530
Message-ID: <CAGzNGRnsmRWzimUX5tEC2-Y44aa4i9Lbdp8YJ+oneV4ujs4qBA@mail.gmail.com>
Subject: Re: [PATCH v5] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lopez Cruz <misael.lopez@ti.com>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Binding needs to be adapted to match DTS or DTS has to be fixed to match
> binding, depending which one is correct. Mention any changes done in the
> binding which deviate from pure conversion of TXT->DT schema.
The DTS is correct so will base the example on that (and get a better
changelog in the next version)
So the checks will be 1) dt_bindings_check and 2) dtbs_check

> https://social.kernel.org/notice/Ai9hYRUKo8suzX3zNY
Noted, but here I'd assume omap2plus_defconfig would be more relevant.

arch/arm/boot/dts/ti/omap/omap4-duovero-parlor.dtb: mcpdm@0:
'ti,hwmods' is a required property
        from schema $id:
http://devicetree.org/schemas/sound/ti,omap4-mcpdm.yaml#
We already have ti,hwmods still its asking for it?

arch/arm/boot/dts/ti/omap/omap4-duovero-parlor.dtb: mcpdm@0:
'dma-names', 'dmas', 'reg-names' do not match any of the regexes:
'pinctrl-[0-9]+'
        from schema $id:
http://devicetree.org/schemas/sound/ti,omap4-mcpdm.yaml#
It also requires a pinctrl subnode which isnt used anywhere, the
parent node of mcpdm that is mcpdm_module has a pinctrl how would we
go about implementing that?

-- 
Best Regards,
Mithil


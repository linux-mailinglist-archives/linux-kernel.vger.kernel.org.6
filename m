Return-Path: <linux-kernel+bounces-417679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9FB9D57DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 02:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ED41B25F1A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 01:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E386167271;
	Fri, 22 Nov 2024 01:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wj5FJ8IK"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34811166F31;
	Fri, 22 Nov 2024 01:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732240372; cv=none; b=uIVP5ITOJjh+WfNXoc1ur6/MnAY+eISbbaDsZKZkeEj3Aq5bmcKq3eTX5s1HkrJumiMBSpclIXCIKYC8Pbr7xlzWTCGXILCP8HVlcCOvEBGO5GvXRktj6gPY3jrbL0kf0zzvZwaiWlF3F0IuyuVNl4GEO6iadVqIlal2qHBcM1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732240372; c=relaxed/simple;
	bh=mbFaO9tez8qpqQxYtfq9BotE31cLqD95Co6agCJWCiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hamt3lcDcs6IONkNyaVdtg2i5RbJ9IJmjn3iv8C288iJqrNsxkSmR2CicAyhdajShNk5M1aU6wE2gDEPmU0PJ/GitLOhbVdz2S2wJSj7qQWMqbToDZwxfqEf3pjgk2iZM7952+ns0oA/Mv6WJAx8MWxjoWU0aUjYVxorgN6uhbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wj5FJ8IK; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f8490856so1679486e87.2;
        Thu, 21 Nov 2024 17:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732240369; x=1732845169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbFaO9tez8qpqQxYtfq9BotE31cLqD95Co6agCJWCiE=;
        b=Wj5FJ8IKozc1z2ZCGQXEjEmqhQzyy1Ta5kK6IdIxYkj8LASIqZoahVBM9my96iNuBW
         gekLv71TBhu0I9ovc8IzY1OMBYB5JtlcYPTXuUIPcaf8Mnj7G5ISa+NXdEIO0dNfYWEP
         vt/nLwG4jqFOs1txgtBOCrH3MlQQpP/SsNU6jK1bIDaA1qrXSDwLCekNjhmlhv282nGC
         uNE5If3Nik//yQWcssdpn0Kmv7gTjnLQvKkR8NdjI+o7jRMrMKWCbx5aofqO0J+/XQDF
         NJaEq8uo6vS4icoEfKSOIek2LWXjceZcG0QgGbei4F9DxiEss38SzMF3WlayvTlXjJPg
         7kXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732240369; x=1732845169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbFaO9tez8qpqQxYtfq9BotE31cLqD95Co6agCJWCiE=;
        b=gVdPfDQUPgbijLMBsCpR7hS8Mak+dlcBF2jBX11OYKOsbLM2An3QLxPavANLZ987a4
         U7TM9UzysKPJZuUwyeKKlPuSv85AwE9HwiticKQ+uBEvN5ZUxxLL10DdWMlXf8l29Yhm
         ihKCOYDKO1M3Y3v9rfrnb3NQw2KTe71pvofzh5/DKtDKWYpmy1MDJwxnfCUrAjVPPj7s
         XwRA+AEIf127ZrHlZ4rcT6SZz1bh0gDELhJvqCdX9Bn+ZeuzTfPMGTJmsEfPHqw6DVL/
         T4W71XQgP8s26bt24Bbdq8iPOkaCe6Q2vlcrDqJcaELonljmsc535nFkh5HBA7VAx6p+
         NfJw==
X-Forwarded-Encrypted: i=1; AJvYcCV/7N6Kaqwrqaw3FMHrSFzL5UxkaX6wipbg/rGq78CVXaPIZMhX2YwgpNuKJtfLcTlIIH1lI5R8eyvMEMM=@vger.kernel.org, AJvYcCWhCnxoSlkPrRH4UScoBxZ/Bxw4NOM2l1VICKFFR3xoqzntQ8d9l6wSGYoHNmELNrt9ZCNjXaYDRLknKNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8GTSF+t8UMCHjz9cNwhkzrVUXys6GT3Fs+TEk8c5VarAOJSNe
	xy16f8cAOq9Ozoo2ZOWSnx3xjpzpgBXLkkRy2ch9PtY7Rr0VEuzTt7o7FZYha/1TnkbvvrRojFX
	qLrvbkz4eeSBr+l0HGuTGL3NH39Q=
X-Gm-Gg: ASbGncvruy6dpeyP2PW9A0S7/lVe+rtKFq3hCaYX3NTtBC+55K8JxGShFGnjvyjtI1x
	VBEAEMpG1S0dwolgFng6z+BhxUDTQXs7Xt0rCWxuvHyPhce1F4mw/OSOT/iPFpQ==
X-Google-Smtp-Source: AGHT+IHM9SYHUS840AKyk8frq7eVMfvYJ/7a2ZIQ4e3JhKBpwblqqJvz+6okd9WeuY9ETsGuSmUNrbjg33EZCqp2Vos=
X-Received: by 2002:a05:6512:3d28:b0:539:ea49:d163 with SMTP id
 2adb3069b0e04-53dd35aa4b4mr363247e87.21.1732240369055; Thu, 21 Nov 2024
 17:52:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122014941.503789-1-shengjiu.wang@nxp.com> <20241122014941.503789-2-shengjiu.wang@nxp.com>
In-Reply-To: <20241122014941.503789-2-shengjiu.wang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 21 Nov 2024 22:52:37 -0300
Message-ID: <CAOMZO5CwCLZAM62CtNrLrCAFfQFvKuTArV3auR1WcE0+s0BnMg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_xcvr: change IFACE_PCM to IFACE_MIXER
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, 
	lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 10:50=E2=80=AFPM Shengjiu Wang <shengjiu.wang@nxp.c=
om> wrote:
>
> As the snd_soc_card_get_kcontrol() is updated to use
> snd_ctl_find_id_mixer() in
> commit 897cc72b0837 ("ASoC: soc-card: Use
> snd_ctl_find_id_mixer() instead of open-coding")
> which make the iface fix to be IFACE_MIXER.

Should this have a Fixes tag?


Return-Path: <linux-kernel+bounces-385248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE2E9B348A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1422F282640
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D741DE2A2;
	Mon, 28 Oct 2024 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P44ENAXK"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF89155747
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730128550; cv=none; b=lxZY/ack1fVDHSNzJbW5kaYe5RCLdYKgU2OE8K4rMvYlmFhzw3OVRVHwUTA4ExnYguAerd7ZGe8sVt7AKfYhbIc3Xw3o+1MaUssS26EHG7RYdvyyA1jtgvofd/LZ4/qU1mEJOjg3kvsISMoeAnbQXiVmonfCTCtTGGpCxImqoQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730128550; c=relaxed/simple;
	bh=8kijLKCe9/u6hJG2B0Upu24V5HO2+0j+WKWv+aXrPEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7cXR4GhBwmDGjEv/G/siibv1b9Yi7VLlboDkNr1UW+h1boFOUCowNLZM0FG8Uw1oUl1/H2PKwxYjeNL2U6aPnCmPkuYFOfamk6GacLDa20k0XnMnwBgQ7gVmMmAStR4yhb8BbEUDEc0BP+jBpltUG/o9uVrLJvacfF4Pe1wCfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P44ENAXK; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e66ba398so15710e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730128546; x=1730733346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kijLKCe9/u6hJG2B0Upu24V5HO2+0j+WKWv+aXrPEI=;
        b=P44ENAXKDGyxhPjZtHokDN8gEGexkYihi094LnTU3vOQNaR92zW6KC0zjf1WmhHnDy
         5yxd3xwGNIwxnOrecO8nClOhrCzp9pef+AgMJgLy5mkxtj8qOhLs/ETGFjdgy69lelOS
         a6rO18/uGo5balAEBJ5lB8Th8KYAvnQzQtW97J2z7uWef5zaSv3Ucd1mr6V1ET6Lq+9v
         5lerhx0Kk/bA1KPptXX/9NiLtAbdcFgpdqogrMlmABW1V9soC8ZBAiAF/oOMwod/DN7M
         yw4XLiuom+b/+PZexSqtPiY25xCreNA0Gzf4876/F3D8AO3R42uXoqrRRhVwPoU8sKbY
         y7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730128546; x=1730733346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kijLKCe9/u6hJG2B0Upu24V5HO2+0j+WKWv+aXrPEI=;
        b=dM4g+6dlg095IOqo2ZPrCDgbmlyQ/dyS9/YcbgJl1w26MF9M0WKuX2zQz6B2w3Pxra
         Tk37SeL1DsKZMKZDhtrgEuo0ibN4kbIuFD5v/OYUN2l9+Sl2vxLc+lQnR7lqO1+Vu6Ay
         dXuEDaJlSjKEVpesJ61KYzAi1KMqJ83tAdDu0+x84V1sBH7g6XmQ6ZO29scZ3NLxcT69
         CvWfgxKXzmoyHfuiFXb7EZSaS3qvJgx6ZVaJwugHv0n5MR92zengplt3Ct/wALvTaD46
         4bHp81/RXz2ckpjYtVpPcrjNICDpqBhu2SGsoeWL+7q2b6xqLIPneb+tfD9J24EhmBFX
         ILcA==
X-Forwarded-Encrypted: i=1; AJvYcCWJSF+GOgh6nOj4qYBlgv6X7/YNVcQFBEXT6fwiV/Aj7BCtOjC7qQNtmB8rApz+gcN32cHmaJBGPWq51xM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCVsZoVPxICK2vjmTekxMKCuxtcXDYQ+dy5nDScwIChDiwMLKB
	PvL7g74PTiufZ4kfFOhYMnNIAEFPm3pVu/YJgUU4fCNJ1qyUzVuFcUvkfD2y9c8QOtW1gciwLqD
	r/rXzFTRgrZO7fX8g3NSszCOGsJ/C1lueHkrz
X-Google-Smtp-Source: AGHT+IHhlr80qnjoc3qPeloimsNoLpzMT+nVpsqmMp/GNu8LTEZexj0DumIAuFBPOq8X0buSO+lGjgFpbMJGOi/NiT8=
X-Received: by 2002:a05:6512:10d0:b0:538:9e44:3034 with SMTP id
 2adb3069b0e04-53b348e3504mr295422e87.6.1730128545894; Mon, 28 Oct 2024
 08:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202410281414.c351044e-oliver.sang@intel.com> <CAH5fLggdtev=scJ1C9EefZf-fVrMvgMbfD+b_T5vFfHqNTn8Kw@mail.gmail.com>
In-Reply-To: <CAH5fLggdtev=scJ1C9EefZf-fVrMvgMbfD+b_T5vFfHqNTn8Kw@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Mon, 28 Oct 2024 08:15:07 -0700
Message-ID: <CABCJKudR2UwvR8x4MwKYPmHETMz+aoiXEXz135BoufTF9Pt2Gg@mail.gmail.com>
Subject: Re: [linus:master] [cfi] 8b8ca9c25f: CFI_failure_at_do_basic_setup
To: Alice Ryhl <aliceryhl@google.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 1:34=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> Hmm. This config has:
>
> CONFIG_CLANG_VERSION=3D190102
>
> Sami, is the fix not available as of llvm 19?

Looks like llvmorg-19.1.2 doesn't have the fix, which means it won't
be available until LLVM 20. :/

Sami


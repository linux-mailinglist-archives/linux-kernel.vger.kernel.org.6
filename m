Return-Path: <linux-kernel+bounces-381277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6703B9AFCE3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9756B217DF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C830B1D2B02;
	Fri, 25 Oct 2024 08:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YTRZbnzd"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442061D26E7
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845877; cv=none; b=a4encY6+FmWFzFs2Z+uZDevmEXqg340DMqSKru5GVEBrx9MsUROWrB2MJMmRiHBZsEswcBdJpP+lXWiZNNssWHzGIE8rUddbEJIc0VGmFaMVRvcEn3Ig5cVfT8FKuPqTXHFqMaymX1WMhIlH2wnhFpCi+1nS5VYe8vyCOoL3ZU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845877; c=relaxed/simple;
	bh=4qWYQwpgnp9wGLrZEx7eNUmfV0DYrzDjQkJ7UWokRTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AgiFqtCPb2szH0RvJBZPBxpWkMK79LNxLGhHTt1RUxuq2PntSu44M1sEK4b8vdqOO8B4BCn11Xu5iEJ9/MF8i7hPgr9dc6/8VQLKwK6jb1dYee0/VuyFmzBCTbVNsELJdhsh50nNX90gL7PSUpu78XO5IqtOY72kGVUgJ//jTvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YTRZbnzd; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb58980711so17179971fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 01:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729845873; x=1730450673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qWYQwpgnp9wGLrZEx7eNUmfV0DYrzDjQkJ7UWokRTI=;
        b=YTRZbnzdqrDhKLNFwlehYySWp8Hrf3WswYrs9cVfhiHZvLwo7xd9TNbQlXYdSA6iGg
         YIc6PoCJpziYe4sII/E7HYA3MmAN24h48eGebqPq71ToPNsGJysyhyhJiZ8k+NN/4Pd6
         jn8zStEsm59zmAwmo9u3pDB1OoV5iNkv5Oomho5PNfwKDTw7tA1/wp4iGcbdaohhLKx1
         BROkfhjtnIN079QsTpDZ0KQNbgzZeuKXXjoGQncf7VTeNX+QlEr7HBytl7h5WZoev5t6
         MmDsMTd3FCC/HYZdU+hDaxl41SJEVLvOqVofomzhq3DuW6XeEmk9+cfSRgLHVWwVIjgH
         1LTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729845873; x=1730450673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qWYQwpgnp9wGLrZEx7eNUmfV0DYrzDjQkJ7UWokRTI=;
        b=OorvxheUS0itIvj3/5bUK3Z6PX6y2rQqJk0bYG/bj/nq2pjNH8t3rJQDMpbyB9vzJn
         y2TQU3dL7Ph02L5IN8nv08yY1PZ63bviDJA/cubggrwpT7i+yZ1SyqX2AvFa1BEw9GIh
         RObEES6Uo4fx+JT66fRwq3rBCKH6JHW2mQiMG09dvY5eakOh5G7YpSFthLCNhKuXruIw
         1y6/IW4F7FbaOw9Axj5oaGDPo0I+VM2epreLq9Az+uhDW9zScYXnPyIhL/+ffi3VbUcL
         Xx7z5VhAWGXfJtypgBxyK11rRPNrJA7LCGj4PgAJqrVug2OmccTIEuXT+D8KvVde2twM
         s2cA==
X-Forwarded-Encrypted: i=1; AJvYcCVvQX3L5VHAwNXERBmA/qLOHBMrUthzDv5mHGT64Q1p1yoBjRPFnCQMBy78XXaR5rHaSsJocoXVWEwgia4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx29wQNK1YVT+HUY15gHhWGIm8up9slDioPz7SPvOfRVXTGhdtg
	LO031jD/c6KUWgEe4g0rZfDD4IFNhMlhhY2LHSO8Ezfy/WbyjZKGf6PXTuiAKoaqznB73ZG3a4O
	8JMjZDjrYxcLO7PbSLz2U3NWGYS2/BOMNunKAsg==
X-Google-Smtp-Source: AGHT+IGM8SVFA2+ONvrSEBYQyTktV2bCRrYinDhFgybJMVbPg6fS8Zwi9AtvDP/3Lg36VB3SvrKMD5hmMAsbxh0UbD0=
X-Received: by 2002:a2e:4c11:0:b0:2fc:9b6a:a894 with SMTP id
 38308e7fff4ca-2fca8209a92mr22092931fa.17.1729845873286; Fri, 25 Oct 2024
 01:44:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022064245.22983-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20241022064245.22983-1-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 25 Oct 2024 10:44:22 +0200
Message-ID: <CACRpkdaoVksj5V=wqnf-w+LK8fi_mS5-MXgPHo3Ecsu5mRnd+Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,sm8650-lpass-lpi-pinctrl: Add SM8750
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Melody Olvera <quic_molvera@quicinc.com>, 
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 8:42=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Document compatible for Qualcomm SM8750 SoC LPASS TLMM pin controller,
> fully compatible with previous SM8650 generation (same amount of pins
> and functions).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied!

Yours,
Linus Walleij


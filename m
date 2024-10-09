Return-Path: <linux-kernel+bounces-356624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401D299644A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B717EB23BDE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8831E188A1B;
	Wed,  9 Oct 2024 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yvV6fD5P"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2D1156242
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728464373; cv=none; b=jC6B7ZHX98mjViQUsP39OuySBjYnJzA4YO6luzAMmxqh5Y9uVObQfzFeObkaEf5xv9hz98/UhCBnsGRmzbMOnTEb1TtaeHpI6q1Hwv1W+qKPH48z2wJwArtl/5w31V9ftzQpN5ATgfjyt8QKMAh5iKGqEKXWW79iaQ8E0hlyyME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728464373; c=relaxed/simple;
	bh=Fg1XN0GxX/Kla6xLUfQtPJ1bcuD9q+/DrBFKS3emMBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vh0VWMkV1o+8hZquwxpd6W+r2Cfp/1ifsEABT0RgChbWZ36FUrrDKAfShl+cArcv44TZdMphAxuhFtGQvDROTqfHnuTaQ5/0MInCgTlJKRDmIargeuAxkcZo7kSgohs0HO5GQ5QD2bwr0Fh3O0cbN82mEhpQwR/oL7jEyFOXscI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yvV6fD5P; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c8967dd2c7so8120640a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 01:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728464371; x=1729069171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fg1XN0GxX/Kla6xLUfQtPJ1bcuD9q+/DrBFKS3emMBo=;
        b=yvV6fD5Pclo4YZcxjNTCiwPPq34ltVo2CVS6XTqcJKS7mlf08jwAbEJomL54khjZuG
         +wx5LktCotmHyagNSpXm39ySsMFPulyHaXefiO0NYwCPdmRxuS5dAMLWYc1Eeour6DPH
         pTanHAVh90SUGR3QE81IJWt03cpZOXTw9tPAp/xL58KN+mY5kqt9dwXNtrX8rwjgOdXp
         kksq3GxoTfMHqsQQhR4YFABvF7FDz1veAsIz+VzbUrHgem0GY9SrbUGRShngssdVbLI8
         L2Eyvl1pCCpD6Dht0LNPcDIa4vubwL/E48Xrt2DdWNe4wFejbeD9AmSipV4E/FJm5C+f
         3guw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728464371; x=1729069171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fg1XN0GxX/Kla6xLUfQtPJ1bcuD9q+/DrBFKS3emMBo=;
        b=q869oxB3GDAsAk83KpPPuuM2AOlQCd6cquwdCzXqMXjkIMWhDHX+lZ5QFRTATYQqtn
         0hmmJePX24+j9u7A9YzJAvivUtaRuhJBZuUWe27rEH3e+kX+w+NpyGL/kLRnRs9VD2aD
         Ley1vf52KZPoUzqXMi/q85EIIF3Fh2tuXYblgHbywSunv9lGaTBR8kZAITeqp0MdpWhy
         BTJn/Q4CM/7efBM5vd4d9MjBV/JzxvuPZ4Bn1T7ZpJj0oAxhBA+rc49pTm4/RZqTxg3J
         TRcFT13KJe9u5wbh1kLmxwzAe+GRncGJH+CYIBJa8bPi3KxbVL9PI6hI+BnpBdMAh9zR
         XEXg==
X-Forwarded-Encrypted: i=1; AJvYcCXtvXHJ6+9//s4iaRaL7ujZ1/2yFrBUx6AJaGTs1LpwaNHBW//d6zGT1oaPMqMuM+aWn3gXvhoOmJA9lI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi7UwlvFJZGNgEXm402KFwbIEeWgvA5j4xj7a4JyLC2b5VemIP
	FOe0eSiJxzs6jwzxFvCRSju8ZapXMTUmeXP+2vjjm9i5R0aPGLGOgVgj14TKCdyxx4tIqYWri/S
	t9RU1DgTyCOFpL4ML+ATPHuDXGgSzITlIZrLquQ==
X-Google-Smtp-Source: AGHT+IF5e5okLD8RYMY+0AoiICHKx1edgmljuMThgQAgpMLA2oJJxnHHHurgh1/t1QXhU0PNT2KsnIunoqJl2lcEQHc=
X-Received: by 2002:a17:907:96a7:b0:a99:4ebb:a400 with SMTP id
 a640c23a62f3a-a998d1b32c7mr166641966b.26.1728464370570; Wed, 09 Oct 2024
 01:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003211139.9296-1-alex.vinarskis@gmail.com>
 <20241003211139.9296-4-alex.vinarskis@gmail.com> <CAEvtbuv1OUekj5=fzafJKby6jBiZ6BzgT4TrrihDNdiQQM_vQQ@mail.gmail.com>
 <CAMcHhXoRgBS5q=70=nj72_dH3R2eHf3bPt=ZxjsUQEV5FZxvsQ@mail.gmail.com>
In-Reply-To: <CAMcHhXoRgBS5q=70=nj72_dH3R2eHf3bPt=ZxjsUQEV5FZxvsQ@mail.gmail.com>
From: Stefan Schmidt <stefan.schmidt@linaro.org>
Date: Wed, 9 Oct 2024 10:59:20 +0200
Message-ID: <CAEvtbuuW6ynBQjZce28X3qZ8EYaCKYM2nH9212GGA7hMxyk8ig@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: Add support for X1-based Dell
 XPS 13 9345
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, robdclark@gmail.com, 
	peterdekraker@umito.nl, Bryan.Kemp@dell.com, tudor.laurentiu.oss@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

On Wed, 9 Oct 2024 at 10:55, Aleksandrs Vinarskis
<alex.vinarskis@gmail.com> wrote:
>
> Thanks for taking your time to test this.
> For the record, which variant did you test it on (low res
> IPS/OLED/high res IPS)?

OLED

regards
Stefan Schmidt


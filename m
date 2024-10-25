Return-Path: <linux-kernel+bounces-382130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F4B9B09D8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2EC2283B8F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6DD187874;
	Fri, 25 Oct 2024 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xPh6jeP3"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1180B186298
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873488; cv=none; b=n7+KNSoNhxwpwdA6eV+cOiBct9kNoZMLol0bwJqILKBmeZeL6M+2l4Z9ODgr3i6ccsEzkN40EudjjzaQhZ2FlIRwO5xDbPdgv3cds6z//NPWiS6XeDrFdnMAhHq+9nc51Z4TdKS6L/g4xx542dz7D5Opr16ha6kc4XEC6ACB0gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873488; c=relaxed/simple;
	bh=uFxGQ84TzgKb5slx95M/+bzD3Js6QUjK6CpY1vcd89A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4jIsHI7rpmOssdWL8J2UcS7xwVHgIODyydKkX7a3gPVjCVYwszHgsBdczDcTqRB2fwjrrj4MKtvTS7qvIrYzV2z37IAAgUEH3d8nAG1gsoaCJiRULEkwolISKYkPiNzzTIoDqJhEkulW7DD4J1wBZo0kqt4gRa+SYLo8FQg7uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xPh6jeP3; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53a0c160b94so2692559e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729873484; x=1730478284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFxGQ84TzgKb5slx95M/+bzD3Js6QUjK6CpY1vcd89A=;
        b=xPh6jeP3PdUW2F8GuUQV8vrs8ZeMQPPxoDBRqqZpbt73lxfbDKnGjaXqyJLtG/HM46
         mtbf6CeEBmdkQRVJaPVoGW6L7jxMwZESDpNMINs5c+x093d3EwN3wohaWihfMWweX2UE
         ehiWwm6/+ICJyfzY4mzYumlE9Xc+UI5seI3F/aDU8Dic8+4id1oKlqgfVxLjWeinZHSy
         PC/j87eOF0z/K9ew5RH0rZVrgiTlYPxj60JRFVrOEFEqMYFcnrXkKSf1XQpYZLBBXLFY
         CNSVlEepod6sXiCe3srKnNwBCPANiZGxY27avP2jRrxTG0AGUNiWz7yG2M2GLIF4IXs6
         qXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729873484; x=1730478284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFxGQ84TzgKb5slx95M/+bzD3Js6QUjK6CpY1vcd89A=;
        b=WNpYu4MLPYC13sLPrmCyg542ibIda3DQ4AhWp0zzS4ec5rhZqp4TVXXBcO/A326o9m
         MnN/egaIw37BuBcYaoSyokcHFUS5XaAu9Y/7Gkiqka5FcUrQxhFBVRedISgRXVQiyP86
         Q6OB4uGACoAGaoC69CjyZeB/IT2Ld+ttkKee2UbiD2JM1oICtN89k8EN4Tph1k3Hs1m2
         9BNRCCEQPSmYzb1dBa0NRLiHkjzH/m59k8IG5SYO+VQ9oKdgCZulbDj8cgjI2BvRbjj0
         gaKFK2SJoX5FAy6ZgUgNizKx0M2SlvzpXEHa2Svrv9/BX5FanM0mdTAdaq8ncQJS1MDm
         f1QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWousH+mxlaUaJxLUnVc0YCtRlkytq6D6oqanUWZPBd+KqGz3aH5X4cfP1apgS1sso0rwHKEWR323g6a00=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcOf1Pmq0B3b1o8pGCUeLCTy3e54Zt/qh+rZSXPtDmnYUNsNWw
	RUbJprBCgGE5lxoAZKBE3LfDPx8m1NGa3n65p9QERDAIswYjbavpWdybMjfrw9sBb02ZxaBCkDr
	eyrEt3Ec7ivjuTaeEZFXdoJVHRWWEOQ8VgT+B7w==
X-Google-Smtp-Source: AGHT+IEfpJ2a3ZiZX+RQPhobkt4J8q70FA0o2YD9ICo8hjOQkce3gRZLgqbQg03WL2CrnH1fCWI3UEeT8tJywgVGdn8=
X-Received: by 2002:a05:6512:12c5:b0:535:66ff:c681 with SMTP id
 2adb3069b0e04-53b1a3615demr6698254e87.48.1729873483988; Fri, 25 Oct 2024
 09:24:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729738189.git.jahau@rocketmail.com> <1a3b08a4bc9944ebe05ee48bcd8ea11bcf3e9103.1729738189.git.jahau@rocketmail.com>
In-Reply-To: <1a3b08a4bc9944ebe05ee48bcd8ea11bcf3e9103.1729738189.git.jahau@rocketmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 25 Oct 2024 18:24:32 +0200
Message-ID: <CACRpkdbPgku6qAkaGN-AC5zSgwQTs0JnXT5RYOgWddU8TA301g@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: display: panel: Add Samsung S6E88A0-AMS427AP24
To: Jakob Hauser <jahau@rocketmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 5:18=E2=80=AFAM Jakob Hauser <jahau@rocketmail.com>=
 wrote:

> Add bindings for Samsung AMS427AP24 panel with S6E88A0 controller.
>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


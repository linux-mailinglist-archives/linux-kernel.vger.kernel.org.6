Return-Path: <linux-kernel+bounces-193793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 880668D3240
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C83A2898F8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67720172BB5;
	Wed, 29 May 2024 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bcensdPR"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECDB172BA2
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972467; cv=none; b=IbxbapCAKOYw4CED86RWxk+shtKMwW3r7QYVESU2lUT4jqzan7yhAAVmV6xHwYmPfZu8FWtoL7JIw1GS0APFdasnzKwGx1OpcbGHu+E8zOZKGw6KtVDcFofijxisrE4pFqynDRiDlu08HLd9MSszynJ4OWVevIAvOxKWuo86Ies=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972467; c=relaxed/simple;
	bh=IpLrYynUPcGnN44fpYmeg2e+T+0uVvq6OO+E/pX+kdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TobzRPlSuaWWE3Vnxhpo/IP0a9jMbKXjI4pe3xx+LSGq4k7oMN/I9CBKKLJ4epHKbNB4BgHECkPMpVA+1P/8ox5+ImPZVNZHGSyQtmq636Sdb5Egkk4Z3CPVGYR/JPENh+n8tGZVjCrNBgrhh+SrlKxOHYHW8RUBonYb92gFDGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bcensdPR; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-62a08091c2bso19105517b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716972465; x=1717577265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpLrYynUPcGnN44fpYmeg2e+T+0uVvq6OO+E/pX+kdM=;
        b=bcensdPRMarAQD0vc5olm3y7wDrmMxvAZhIqyHx16K2B+y8vfgMy1aDLPwEQszAL0+
         OQHG7xRsCRv/TyACttNzzeov743T/wjWssj+/Fh1ySSfkFu9e4HCfQ9/UGHcUL5cToRQ
         wNYslPnt28zkLs0tnHSckGFOFwBGAHIrk4mgI37FBbxSPLpeNmzIcDhpYeYEhMR91fep
         KlRzVllLoWJbwMpUM5X6x8G96+WEz8ZyihmTw/UJ8McsCFdyyEq2qkguQtDilbDZyh4k
         pn1e+fIbrTSsgOvfacy3Sji6TL6bwoMbSiQvr6qNxANrwHwvGq14i+CSzmoLNAN7tXHD
         KUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716972465; x=1717577265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpLrYynUPcGnN44fpYmeg2e+T+0uVvq6OO+E/pX+kdM=;
        b=QURHpipzXj1HV8A1gZRzu9LBDOKrzbp4yLSH4aO0ot10O1Q5QwYeVfeIX191MUq6zK
         UIFCPjRPQLQgQZ8jZwmlkiCbsROxRHwRlG1vhXaciw2hJAc/FpX5QsnY890nSHOBty/9
         6NbZUkNyoSXfExfPrR46qOkePT8L4+EpabrTuxVkwmXIWfqnoVovf5FVsyw8JSeOC9dJ
         OXzpqcg7DVEBUoFoeZl9y44blkmqCYWuxhh8wqVNHY7T75ohHEtO4WpSHLcNf+XJBFOp
         a19NieduWQzfwHXaHCLO41pT7UKIFqckPz0353kyTbQ0kXGACb58Vq0Mfv70Nc9yJSxI
         kjtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcvWatzQSpDczNXgT77sbfZkYSQ4D1/vKaAbVvZgvQPNSkg2gez7x64g1ZrCBFfJU6214KgU6+3ynVzJRV3V7Y6xOHhAYP8uelZ4in
X-Gm-Message-State: AOJu0Yx1hVWX6FUyvfjeYkX+NuIOpZtfzfFO+U6As0F1SRKfgWd86VSi
	3Yl6ktxW3ixF2CCjt1JJdYWDEwIKNx8slsW1qglnSaCT7ZVGIiXJyop4a1ogWHyEElZOfOB6DNP
	6CPFgXEuFBRmd44PwmWl+Aal3GZ7Nd6kQJEpP2A==
X-Google-Smtp-Source: AGHT+IGd/vmJitGpaybRz5aemUbpLx02og4W+Vhbz8nzpaQebVx7YF0/2G3viEH0CBNgwAxA7dqKRl5SApiWa9JZm/8=
X-Received: by 2002:a05:6902:2747:b0:de4:603f:cc2a with SMTP id
 3f1490d57ef6-df7721e9296mr15812732276.45.1716972465270; Wed, 29 May 2024
 01:47:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528191536.1444649-1-robh@kernel.org> <20240528191536.1444649-2-robh@kernel.org>
In-Reply-To: <20240528191536.1444649-2-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 May 2024 10:47:34 +0200
Message-ID: <CACRpkdbxrwnBU_yRAeeqQU96J_M8wqrKiFsCMUqHcLgZPT18aQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm/arm64: dts: arm: Use generic clock and regulator nodenames
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 9:15=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:

> With the recent defining of preferred naming for fixed clock and
> regulator nodes, convert the Arm Ltd. boards to use the preferred
> names. In the cases which had a unit-address, warnings about missing
> "reg" property are fixed.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Neat! :)
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


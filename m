Return-Path: <linux-kernel+bounces-216723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E533990A506
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58841C26D12
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 06:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9437818F2C4;
	Mon, 17 Jun 2024 06:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eSmumMh0"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA1818413A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718604494; cv=none; b=NLYCCLlhMr9xDi+TGl534WDjrJAxJC4bug+9okMqhSijozEtVxs1avyONfBxbecZg0+HGLF3YecoLo3BQlIhh/aPUIP0d56G9fStRDGTfjWCa6pqDbuTEZDgl7R9Llx4RQTSOAObp0HfQ+RWGwHMQbJUQlUctCx8ERZafw43gF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718604494; c=relaxed/simple;
	bh=mgUuVohalOi7r0OHx6FioJYNj7swU6RbeOigo3AIq0w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hRDylE8rBQtqrI9cEFZ9aeIDslEUJ4e4BRQgDVLDjUTP6sH2NuIZIo/F6zXoKH2EhylysTyb5sA0tzmEV4TPClEanXlmKab4aLMOe87MkJT8Aw3flOruCcCb7+Z1ahas8t6adc0v2qTM0SspoctijDNE5q2U1tc1PRhFCddkKuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eSmumMh0; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57c5c51cb89so4618591a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 23:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718604491; x=1719209291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKO8P5Czfx1WnhafBBluB8wH3SA6wYMPe7gjBVA/Pmc=;
        b=eSmumMh0yRzDtQ8ou2GMw+/m3arcDoRYRMnYaVdvxXkiz1acB08onHcnaDneWg9aZl
         qAeVNuxEivdSfdX6aauN8KDq2IcJyJjrf4NCXUNiLux+HJwK06K8X48khUaC7NUl0u0N
         l4TJU/qjHtPrv68T9kPEoAyll61CBS2Jn8TZjcvVXoXBBWGihM6FKbOCeJiZBY3GRYdz
         vsHCuGmNhaIrdSFM7wD99lyRFMX5851Ql3jNHSr8LLM3m/8pe1t6Y6t1hz6sPgF7wsWE
         bER4rweoTqIjbwQCNs9Yg/IhHmOggTpGPlBI/KXBbafm+f4xuu5eSf5Ak+WivxuYGKkg
         2/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718604491; x=1719209291;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKO8P5Czfx1WnhafBBluB8wH3SA6wYMPe7gjBVA/Pmc=;
        b=gK0YqwAcQMVJKpcrpgUJNXJs3cRKMu/pML+F9n7aC1fhAiD68HU1BbH5TV9rfBMp1q
         3heHYShATBShXkR15BQdzHwvYSsAswi3swXr7hIzdfkQrg+PN5Qk5ULxhSxVCC8TgC01
         Tg5lcimuBbFBVHPV0o1Vejcko+t74ZDgu85C4uzXxPw11sbNoMZ/+bFs465dKjAOCzXi
         wX694anDZwFlJnH+lwf4dj40tQvowy0bW3Wgo9bdW1jvVjiOO2OlHykKCTXuJWuRjRkH
         JMUG/Zux+yi89Z+qoy0dDYbvQpmJs7H8ny/JgiAT5+xpTB2eE56EVcPkIhjQt9lGDTDY
         FuWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf2mFXRGwz1kcHJcb4YZwVVGfh8vve0iPs7eCOP9yDjR9WZ+ii8th5FUyzVVVxBlq9+oz2BcfCR2dPzK7l843+pRsCeUzZNcJ8PQlW
X-Gm-Message-State: AOJu0YyX48uN0cSqY9W5tjowbXc8A4h7CRYWUhFuj+iYqG715v1uUh3m
	82T1rEWbgysXmBg2trjnQ4WnFtL8FCHRXo5Q0YuJN7EZH+Vc/91rH6dPsHa9FQ2tSF6lCgboFLX
	i
X-Google-Smtp-Source: AGHT+IHRI8/tCYc6BnuV/uya/p/psKWyF0ePa5AAATsxGYnpRVPJ3Wrjsh2wX3DrkHiS5SaLt/GHeQ==
X-Received: by 2002:a50:d6d3:0:b0:57c:6d9a:914e with SMTP id 4fb4d7f45d1cf-57cbd69e7abmr7621408a12.30.1718604491461;
        Sun, 16 Jun 2024 23:08:11 -0700 (PDT)
Received: from [127.0.1.1] ([78.10.207.147])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb743ade6sm5937491a12.95.2024.06.16.23.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 23:08:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Michael Walle <mwalle@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240604142249.1957762-2-mwalle@kernel.org>
References: <20240604142249.1957762-1-mwalle@kernel.org>
 <20240604142249.1957762-2-mwalle@kernel.org>
Subject: Re: (subset) [RFC PATCH 2/2] dt-bindings: memory: fsl: replace
 maintainer
Message-Id: <171860449047.4724.10770903267718231915.b4-ty@linaro.org>
Date: Mon, 17 Jun 2024 08:08:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 04 Jun 2024 16:22:49 +0200, Michael Walle wrote:
> Li Yang's mail address is bouncing, replace it with Shawn Guo's one.
> 
> 

Applied, thanks!

[2/2] dt-bindings: memory: fsl: replace maintainer
      https://git.kernel.org/krzk/linux-mem-ctrl/c/815cc7715ab183701de42b570a28b4e3d877ef6c

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



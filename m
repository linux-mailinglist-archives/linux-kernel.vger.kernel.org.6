Return-Path: <linux-kernel+bounces-272236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9A6945909
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FEF52873B0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1841BE87E;
	Fri,  2 Aug 2024 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hxAcGpTI"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DBE45020
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 07:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722584297; cv=none; b=R2PWcy4E2xy/DjmnrjHWVrjuwQjroOymTqbl7ld8KI1AxMrWD+gD1gIAT40XHdQD2R2+WKU3+HnMHH2IadBonOJiYkVMCQiSyKPW8WpIz9mVUBJZI4v1DWRqw3fUBDYs5Sgz8KCi8SzXIvcCiQi/2vd6QF4xv8O3xz3bs5W6BNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722584297; c=relaxed/simple;
	bh=rK36YLmEHXyHcBpojAAHflTF6/XQhbKo4k5vviqbXbI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VW6warbBbTS1nN9m8Xp7AFDx8Seq60emobE0E0xwQ/bHMuRy+hA7V2/BbOBDCjm5venHE422GB1TJWpMIIOjt6uWUKpWuQ8fMEUIh//MLOCtbZAb6uQNNkwKuQUXZXEXheMmQKSOmIOQQCmDS/26gFG3KmXW2mtCg0yu2OGp2Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hxAcGpTI; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f149845fbaso42711261fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 00:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722584293; x=1723189093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itaowdVRqVaowO0NH/uRD65hZMp3wIyP9mWOSrOCjEg=;
        b=hxAcGpTIVBB8aJ0/mRD7itoz6I4cu97rtdOyq8NKTdvAVZXKuYBPiow/8gZclxY5eZ
         UhKuRoTSXTS/BHjc9bcfGjklxfcr/Ah6m4D9xYDAAlaIf2FyPYLIwMMaNchn93hJ+OZD
         9d6MYo47oIBOOlTNWUrGY65mTNSS0g4iHmCTo30oorQv091VzQ5/RPlqC9Bb+CHvceNs
         HkBYIgVSspUrAu07VnPi9Q+lKUYty9IthPciltWf6XtdRc/gDfbpR06Bk70D/PB6JJoU
         ygNvSq/3eAIFMrP7z2/P2GA1i69E3XkJVpMYZbocMexYQ2yuBUYA7AXsGEdNg+CWyA/W
         CoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722584293; x=1723189093;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itaowdVRqVaowO0NH/uRD65hZMp3wIyP9mWOSrOCjEg=;
        b=E/NwIuR/z1sdDYbQyvmfUZifOrWVNqKzPNNZ6PC8mSpBMkL1sS5qWuOGs0GBKoROh2
         oCBVi/LDkXEyLEy29sJtfVTgFYsXDRHpmXdu5CgNaV/y3RtKOypY6N4ZIgssSSE5R8Id
         +bvxiw488kkTOcsxuO/nSuXuq8jWsZgCGYmETI88fk1Oc8NgRedaz+Bu1x1wRnwTck71
         P00sTs/EsVCRIXVrw78NqsZbc46MWrB3nKz7QlJR1vVch0ZOoIf/lNO+tMgs/abXuaBg
         NMzu/TCazk2vTjexu31BsXCtaQjnBRVXUJugYRUCm6pwrmCjm9YkpH0J3++cp/SllWMQ
         BoiQ==
X-Gm-Message-State: AOJu0YzF3py26qquBJ9q+WS2SlSBHzY4M3RPOBOgt72Pi7rhtgRSYhjt
	DhqQI6oFmSX57iXlfh1rZSzFLNHuHzAh3LGzFcUWfJVzH473oNQmPv+QziFBPTVUeyqnTOg8thr
	V
X-Google-Smtp-Source: AGHT+IEC8AqMqQ32hwgNeNwSmdJ/rcYjzOLDU/mQ8UBzLaExRp/mThe+UTqdSRW7SGo1oTi5ebsQDA==
X-Received: by 2002:a05:6512:1243:b0:52e:768e:4d1f with SMTP id 2adb3069b0e04-530bb3a2b2emr1721488e87.36.1722584293282;
        Fri, 02 Aug 2024 00:38:13 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b89a878sm83383995e9.8.2024.08.02.00.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 00:38:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Santosh Shilimkar <ssantosh@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20240731191312.1710417-21-robh@kernel.org>
References: <20240731191312.1710417-21-robh@kernel.org>
Subject: Re: [PATCH] memory: emif: Use of_property_read_bool()
Message-Id: <172258429200.8886.16303789412209094456.b4-ty@linaro.org>
Date: Fri, 02 Aug 2024 09:38:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Wed, 31 Jul 2024 13:12:59 -0600, Rob Herring (Arm) wrote:
> Use of_property_read_bool() to read boolean properties rather than
> of_find_property(). This is part of a larger effort to remove callers
> of of_find_property() and similar functions. of_find_property() leaks
> the DT struct property and data pointers which is a problem for
> dynamically allocated nodes which may be freed.
> 
> 
> [...]

Applied, thanks!

[1/1] memory: emif: Use of_property_read_bool()
      https://git.kernel.org/krzk/linux-mem-ctrl/c/23d22b0fe6a12317e9d17bb17720285ac4ba4d54

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



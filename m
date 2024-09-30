Return-Path: <linux-kernel+bounces-343801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB36989FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B24DD285344
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF33E18C354;
	Mon, 30 Sep 2024 10:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JBqFL69k"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BCB18A6B9
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693188; cv=none; b=eFgNpmYxPxHGEXcB6/OghsxTA+7+SwM6oOX5Jv45N0y31q/bWGNZXjyTDjB6SyaZijC52Oi0kZmF0hhFJTAC5XuRFeWbBRp+DV5a682BqtKcRbIzmlS7vEO6ZwWWDOv5ohWufnY7/iZscGGbxuJKUh1XAt/zvIJgEAL5BNece8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693188; c=relaxed/simple;
	bh=lCnldRJj8EcKbLxKLQnv0DM8eJKx8fW9IhUNQDrxfrY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pO3ihOV7oOxEtdqmIQYkJS2Y5u507v+TzL0Cinnh8nIqDZOXXssUD8yb3ggmdK/dWDdbGMq1iWck77ZH+En/NXbjT0CBTU/s09jd3pKRAlAoTjMfAvUU4qaucQyIWtIfCoC3UkTQhQEHKkLkYYEsdzzTTHFNj0VI7cWgMlDXTgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JBqFL69k; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cb1866c8fso6238035e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 03:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727693185; x=1728297985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFE4eZeZ6weP2RRCOdMmrLdR7nkC0PcT5+tx/WtcMug=;
        b=JBqFL69kvrRGqqj/80SyEaycFQfdc23RsxTKn0JpLuTZHXti7sR15WNGnAcnX3eSVc
         rQdNZn9xwU0zlpIvuNsqdEKh3kgxZwTWPpQwz9D/7LZEuBLl1UeeoZm1MTvuRKC0I1Qu
         m0pKTIdw/moMoKCszBsGRarqo948OGVye53n/fdD4A6rIoPjqUcAcdHrlqE0BHryHUpL
         LDzhE0+pJAwSRlIsqrpJeSjCvK3hL/BbKmmQdH8XGo03q+4/3DW4r8Gd2d31+47jgYzM
         80709mEfWh2WSvLk/wmsxhbVGpstO4wWuQUveBMNTElNmPfXDU/NiGx/6IwgPK5cMqKQ
         aIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727693185; x=1728297985;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFE4eZeZ6weP2RRCOdMmrLdR7nkC0PcT5+tx/WtcMug=;
        b=saiyfMped5K1WkW3IDVxZ9w03zNntk6YU5MdBBxlbTA4cADFV7ASFeQb49PbvKdibK
         BZRAOlE5ftrM+LRTluHWBVU/hFerFVVnL6fCaETFxY4hyAVToXBk3Vwm0vBdSzIqFs7T
         aM+U9lq2VMQANF6qePwcZaazCOpYB2bYblQisfPMY8CcUQtNqEVZ4Ft6xD52NmH1XeP+
         HfOA60TiWOoaQs0QtNptJeHo1u6kBdmFci9OJ74hzbBdpamvFK9f/cEdoodwwuyrzKuv
         HqXYt2iYTisHjtmUhmmtVMcM5dUPCX1cXjMKeHQT5RFahrdtvZRY3y571ID78sTRYPEg
         uEew==
X-Forwarded-Encrypted: i=1; AJvYcCVbOQeN0aeGmLcWskWEguVjZrBc7XHuHmlntoJK4tQP4azwkpvFqg2Ju5lXaeZmuVLpr7qddUyP6NJ83QA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd4Dp8gbkBXkBKcAmf6Ic7O1D6FNWYIO1KwptNhSDmi46w0SW1
	EW2J9/Z7PM41H+LcjXzWAZCaFixw+2l6YJ4Bwgs3OVTNJtjN9GoJefxUm1ZUBFA=
X-Google-Smtp-Source: AGHT+IEvk9FSbIzVEgOgXx9J9NrpSRuywz0Be+b84peORC+sZmXG2Y362BoPxHOnga7dUHz35qh/lA==
X-Received: by 2002:a05:600c:45ca:b0:42c:c0d8:bf49 with SMTP id 5b1f17b1804b1-42f582a34femr38710925e9.0.1727693184931;
        Mon, 30 Sep 2024 03:46:24 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57debe51sm98808695e9.20.2024.09.30.03.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 03:46:24 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: krzk@kernel.org, s.nawrocki@samsung.com, cw00.choi@samsung.com, 
 alim.akhtar@samsung.com, mturquette@baylibre.com, sboyd@kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Varada Pavani <v.pavani@samsung.com>
Cc: aswani.reddy@samsung.com, pankaj.dubey@samsung.com, 
 gost.dev@samsung.com
In-Reply-To: <20240926145132.1763-1-v.pavani@samsung.com>
References: <CGME20240926145332epcas5p2aa65366565950cf3d4f25b6c064a5fbe@epcas5p2.samsung.com>
 <20240926145132.1763-1-v.pavani@samsung.com>
Subject: Re: [PATCH 0/2] clk: samsung: Fix errors and warnings reported by
Message-Id: <172769318322.27024.16019922061491208567.b4-ty@linaro.org>
Date: Mon, 30 Sep 2024 12:46:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Thu, 26 Sep 2024 20:21:30 +0530, Varada Pavani wrote:
> This patch series fixes clock driver errors and warnings generated from
> checkpatch.
> 
> Varada Pavani (2):
>   clk: samsung: Fix block comment style warnings reported by checkpatch
>   clk: samsung: Fix errors reported by checkpatch
> 
> [...]

Applied, thanks!

[1/2] clk: samsung: Fix block comment style warnings reported by checkpatch
      https://git.kernel.org/krzk/linux/c/3ee92799a212963bbd8f860b53dd8b9b5e6bf812
[2/2] clk: samsung: Fix errors reported by checkpatch
      https://git.kernel.org/krzk/linux/c/97fd5d447beff9643c2a333ebfbc95fc1d625342

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



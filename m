Return-Path: <linux-kernel+bounces-551249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3ECA56A13
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 018667A3519
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC5121ADD6;
	Fri,  7 Mar 2025 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q4pF+Hjt"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01742185BC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356780; cv=none; b=fSkDQVoS5FnDkJQuj50uDf0m3o7/A4INq1vHqKiq5+ezZSMKyB/atfPe4VHHisLx5jdooiAAEk9YUkt8GbjHUns+iMVXaj5oRfqRcOvcjohgQJSw65hbPOT8JtsBUGi8S3hjgpnXjtS/Zxzok/S2B8/H2Okv9Ymb91ycPNocdn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356780; c=relaxed/simple;
	bh=60re8BiRqNaxfgjZjOXpMIdToHtt/3wVQ2TQ428IPn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGf3f3hMJsH00U112k/2tiOTL0WquoQLrqT/WJg42PfiwSCjhLv/LD42MQns0CNSsgFhInAlMmw9IM08rY4paGl7VYxw6qvqQpD52GU4D2c6WYOS7erXSH3wB0nBSaISGC+sBVM37PFcFOVBKEYoudqiwqNI3PEwYX9fmtDopkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q4pF+Hjt; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6004798156dso675523eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 06:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741356776; x=1741961576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=60re8BiRqNaxfgjZjOXpMIdToHtt/3wVQ2TQ428IPn8=;
        b=Q4pF+Hjt6fmAMzrfiFom+p2VaMdCzP+ZMQ24GRgOHZE7TRwB6OxbesBD2DKj6Cj3ci
         ToBn98bzLWo9oJOg5t6L+s21a9rqnELOW+ljJD/OgZ6G2E+mTpKpRmmJ1s1SIICO8/K5
         MhVbWtTyBYkIeV1W6XJOd/Akzir0XcVkF1FkCIgztuwGYVqjL6OC7bGcDrgI524WxZxj
         Wz9GDm/ZS08h2yeRfCA+hXhcjgrAJXZT4noYghzV9FmRALNq+zCPdXbsGiINwVot3CSa
         thmXXSC+k+H/qToUcqO6YHhWxjQ/8XVo0sMlktoSR2XkdV9U+Nhryhf+6gStokaQ93FL
         3nJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741356776; x=1741961576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60re8BiRqNaxfgjZjOXpMIdToHtt/3wVQ2TQ428IPn8=;
        b=Wsal7O/fsZm4wnFXnxICxhVpG3Jgol2xyzhyIIkCHE4Gei3/nD89xZkkAuOTAizyLi
         gD24buYuHh8+0gPdXcYHmYOZDiqHp4sfwFp2x6W+M7afr1x+tUOckgr2Hi5cWkW7Unhk
         gBhY51fzEvzjEA5MG5e4tB7PfH+7GZ8h3TSv+oyOzbiWO5At6XWwsR/S5OORkmSBzV9m
         VHGRArweGP/gLBJbsaNi0txXL+pO9F8xgCk/jt/KwxmnVQUkvFdvxhu6cDrBpQ84cLIC
         gMy3eFJMIfsltxijvVq/jtqOt9gY4xiJRZL5kiFF5TEJ7KoGxCVI0QtGEV/eOfVyPFGp
         YDCg==
X-Forwarded-Encrypted: i=1; AJvYcCUDWR5vPG2qfBwLyM1am5UKg/lRxW3Q05yjpF6w1MSY5fN3EuBGGYwIXimaKC6AwxsBnD8V7b2oXRk0AIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2R0jS1IYJRNNaRIeOzQNM683gIIJPuNWIE3VVFJb1H7VdB0ZO
	1YjqAtEyrNBh6zKNhOEa1ogltHerXrP89qhAmsGbR+ubMGsG21BlpE6h+1XCnXW7UAsBbipeDbY
	TeO/A5iXK78lYP8Jxx4SV8c5blB3IUPbZ4eHldQ==
X-Gm-Gg: ASbGncsqFTRaU+W5WpIR+WXhNoWHZj02ekKa7Depv5Fi9aImahkoXwaNNZSEfKTnYpE
	AAov5FTjS4ejKEq4BeSMv0dfryDHv89ktqyq7jfXn2K0LbUr4g1OL+8h6C6SXrkDERoJA4LvlvO
	F/e3TJmD+9//BoHsiRfIaaxk+Hyf0=
X-Google-Smtp-Source: AGHT+IH9L2ObJ6dDXOCpIMSXNSBNafNehee0qnPWJxOsmaTrt6AVB5PDvXlGpGJ+NlBDx4GXdCpmmJeVhirk9krz6vY=
X-Received: by 2002:a4a:ec4c:0:b0:5fe:9a72:3dea with SMTP id
 006d021491bc7-6004a767138mr1732794eaf.1.1741356776690; Fri, 07 Mar 2025
 06:12:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305-clk-samsung-headers-cleanup-v2-0-ea1ae8e9e2bf@linaro.org>
 <20250305-clk-samsung-headers-cleanup-v2-1-ea1ae8e9e2bf@linaro.org>
In-Reply-To: <20250305-clk-samsung-headers-cleanup-v2-1-ea1ae8e9e2bf@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 7 Mar 2025 14:12:44 +0000
X-Gm-Features: AQ5f1JrAJDWL1aZmpxNwroG6aOpF70B9j3ySId9aUtSrljkJO2C5fdV0SfrMx24
Message-ID: <CADrjBPqxTiy8D8PVpZBzYnes-hxqKX+gd6a4WgJeDE=x7YQKAA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] clk: samsung: Add missing mod_devicetable.h header
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Sam Protsenko <semen.protsenko@linaro.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 20:03, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Add an include for <mod_devicetable.h> in the drivers which use
> of_device_id table to bring its declaration directly, not through some
> other headers.
>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>


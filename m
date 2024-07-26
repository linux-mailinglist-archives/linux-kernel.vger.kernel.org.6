Return-Path: <linux-kernel+bounces-263742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E06193DA0A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D73B91F248BE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7F7149E16;
	Fri, 26 Jul 2024 20:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TqiMfGi9"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633CF143C6C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 20:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722027128; cv=none; b=E/pTNvlnXl+5rkY8d7fF805X4zOLERrwf9THGMP3QxQRwF0tvIpneZ8SG0GnmrgIF+4cO8YUKW+nQcwjo0JDj6rVQ3ucsVwppcvNOAwyDa+0n1zKGyIot7cKLH5mNRaOQt3yqeCmGmVVfG+aRr/HV7noKCvK+Chk5jITzwomocg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722027128; c=relaxed/simple;
	bh=JI5ZgaYoPgocYBo33Z1jABDgbCrXDHkgPxPPgMs9nV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSWHiLhRHNeLRJz4M0PSoJdnlbqzEw8dh7mxQXVmChscwP/emZOa+zZeVBqykj7tHibFzzp6Oae/oRhlmpv0so3l9PeRNWXibtwMWwUXihyNdC0xvqxOCJsI3bT+ygulu6tyIv9n5J5yOd7NFdB/V2DgZ/z9Lc6epxNmJWm3qEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TqiMfGi9; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52efc60a6e6so2536323e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722027123; x=1722631923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JI5ZgaYoPgocYBo33Z1jABDgbCrXDHkgPxPPgMs9nV8=;
        b=TqiMfGi90LQBATxl7Jc1lrCY7TrNgs31n9x5ELG7BGinZWnm0F7JJ1r02rW8SqSOjU
         cQpuu9u0NoHOV+09AQBQKQdCq8mKQoP6W9bHtYhzAMDHZpQEO5g5HmM6SLeUFfJ/YtD3
         jyw4kPWJouqEQdGBnU8IXBQeaovFG01nP004WT0Pfx+KVGIIXk2/S3GbrXdVLWRlMna8
         RsQ8qppwlKM2D5XdGndUpVJr0ZOA+knD6jQff5qJuf966Z7IMS0DY3JJp3U1ra56INIz
         SpPTGZOfj0xjjsCnFER33mBf7fcvRzlqES1wuWSU3vvE4/jgFn2lgaT58bvbegY58sbm
         J5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722027123; x=1722631923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JI5ZgaYoPgocYBo33Z1jABDgbCrXDHkgPxPPgMs9nV8=;
        b=Ar12FVxszNqtCKa3yXEk7LtqbXXqQZlTe5O/kQdOAsq1Wtu6bziYSiUI1CF6AMrWL6
         R8E7VwmS9YDVG6MDJPgLZVs/DPjdBY4o7vP+xdb8hynXiS1jQhbgbKkJRdQwKvaq3y21
         iSALsGqaZXBkBbUaJDsZPmWmbyZ39uqDh5TSKTD6LMMoSXgvxxN3AXj6bKgIQ60ohMQg
         p6wpr0El+hZCctITH1zpLLpQwMIxnI8UTDgxUaqnAwcRWkWXV7L2E3S9w6a3AdtgZwUs
         PsK+Z10r7hMt5j0SCFtHyc3SnUlFcEPp5XX3ELMr03JPoyKNjXMJSWaSfApunpdC6bMJ
         6nOw==
X-Forwarded-Encrypted: i=1; AJvYcCWnYvS3GL3InunQUEKTGTJgq/DMcRYjurtNXUOM5Gg/wsnaX/MmE5vaeQdPVh3vXRRmwLvN9WlutIQQ5C0kMdj3ajMsWjDxkLHng5Z3
X-Gm-Message-State: AOJu0YwA7Tm822egtvcDGecKDSm0ER/wzARqGAUCcbO2ZhMH3FF8Zx32
	RjnVW4dy0qudM9ASXUUKkpqWPNWahLAzzy2yrnoksCs4l4M2ZxT2NVO2WkIhfnfglGz59mpqgWs
	jhjIR7eHIGYiL2Hfmv7wbqBZN19KVEg0PRUubzw==
X-Google-Smtp-Source: AGHT+IH/KQBHFp7cfJBihyPHNXUeZIXrpWHpjT5Yz8yFUhjBSqezUgduigKjzduYz++qkwRoe4y39Ba5yjD6sVnh/bE=
X-Received: by 2002:a05:6512:2c94:b0:52c:9e82:a971 with SMTP id
 2adb3069b0e04-5309b25a25bmr604398e87.7.1722027123520; Fri, 26 Jul 2024
 13:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722160022.454226-1-valentin.caron@foss.st.com> <20240722160022.454226-5-valentin.caron@foss.st.com>
In-Reply-To: <20240722160022.454226-5-valentin.caron@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 26 Jul 2024 22:51:51 +0200
Message-ID: <CACRpkdaSb0T3ZH8+oQNHXddSg9gS-u+6-etggqNK36sNR7nN0Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] rtc: stm32: add alarm A out feature
To: Valentin Caron <valentin.caron@foss.st.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Amelie Delaunay <amelie.delaunay@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 6:02=E2=80=AFPM Valentin Caron
<valentin.caron@foss.st.com> wrote:

> STM32 RTC can pulse some SOC pins when an RTC alarm expires.
> This patch adds this functionality for alarm A. The pulse can out on thre=
e
> pins RTC_OUT1, RTC_OUT2, RTC_OUT2_RMP (PC13, PB2, PI8 on stm32mp15)
> (PC13, PB2, PI1 on stm32mp13) (PC13, PF4/PF6, PI8 on stm32mp25).
>
> This patch only adds the functionality for devices which are using
> st,stm32mp1-rtc and st,stm32mp25-rtc compatible.
>
> Add "alarm-a" in pinmux functions.
>
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>

Looks good to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


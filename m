Return-Path: <linux-kernel+bounces-385189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAFC9B33BB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5394C1F222D2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA0D1DDC3F;
	Mon, 28 Oct 2024 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OQnVhn/N"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA301DDA1B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730126274; cv=none; b=LdZ2XvjUPT/eEJZREcYYObHWusomwyAXBRpNvFtScoq1NgUJXqUvgS9mFQmVlntsIRonu7nhrLkREHZGfI6UENJAGDi9ooDWr752TrZYNKIvJ4iSmWqFVCFUP3APneKngWZtPee1lGkLW8pqDVp8EWTl1wOdPaRFDwa0fRZJnt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730126274; c=relaxed/simple;
	bh=PJVoaxehblCKmdHBph6FbwKv7y3g2I/GW3hKFWio3YI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLVBHgnC1dLAW1/X4xlUuPp06fT9Z3/j0bB0d3JHoPDJV7FU0zQw8L5LnrZrGE/KyEqtWjFD+H2Kel8f4unS+IKxRvzEiAjdpoICFmKIGdcvaOFs9tnDeclIgflmi21i0nz/+U9rj24pdKIhOgN0iYaPONxcof3WrLtGc647Chw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OQnVhn/N; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539fbbadf83so5568780e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730126270; x=1730731070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJVoaxehblCKmdHBph6FbwKv7y3g2I/GW3hKFWio3YI=;
        b=OQnVhn/N8/D6c/oj56VpWqg3JUssn7bHqdinu1yQ3JmkevE56tscPfhTlJn0REzNfo
         TSeMrV3WGkBY/fkTmKIgeGaLR2F53JXtAFv+QDbARLsU8ehJPWukvtSKl/zOKbvPXwys
         w1nklOmHodvj56yKaQA6Po9ZHM6ufz7rFK9aP+uJIMssLUzhxtoZz72sFZYSZRAjr1Js
         tvO41conZHi4LX0E8Dlq0f/DqrsL1JNk76B8oRyqG9e99sjF1ZhZbYG4lz0IDuP7FNl7
         geKWLAj6i1W78vxKUWJIcQx/v8LtwqnlBKpkwXM+/0uBxGYJ6iWI3V0lc3xfNOTd//Fc
         vRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730126270; x=1730731070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJVoaxehblCKmdHBph6FbwKv7y3g2I/GW3hKFWio3YI=;
        b=l+RCAkzKQs3K9NOiOZW8vRsNWbTSqKrdB1aKCEvqn9kmhwGQQqfcYYvrDoE0EVOsh3
         KA+vz3PJEssjE8ZP7Nlmh7PaN19DkM/ePTT7h2csoCFA7FeHFUt9eZ+D+NzNW68iXHRz
         VMfy2IztunTs/Ge4Uf8MFlVQalEqmigv8cyJlPrcM3ATQf9kLgsbumk5rSSflBj3W5hH
         98Z0QNPPmX/rgQuxwuH2s/eT4ALfp6pDcfmRtu7cB3JE3RfJoqsP801V3WYNccQAwx/X
         czS3veeM2nc89sdTUCXId7h+zUUoe5U/L1wF/zgwvlKHkEZRnCmSf/1MKC99Av2bA0W0
         hguA==
X-Forwarded-Encrypted: i=1; AJvYcCW5mFkylhZlfNNz1BXqocSn612hlhfKvPGpqG1Wk4ARJrb6O/1xNUP4clVkAN71YdlD5KxhtqjqaM3eSwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH0g66P9hWpJFpG2F3BoECh97ipxnBczaycv2CKR2CrXslikWl
	KJY93nbegK9sSHHI6VHe1T9o4KbgqHxPaAOJmmgFnTp/jfWP9KO9N2X7SzVjJyueGvcD5RGEv37
	jKe7b2qWJtrRUuZURpTYiR2IDyIsO8h+4ny6xkg==
X-Google-Smtp-Source: AGHT+IFM0/yV2rcX60bAr1jwz7/ljMj4gRvX4g1B3bqoWSs6hvQQ1s7ThycVBCr4zTDLzqa054swjVaA1m5A272EI3Y=
X-Received: by 2002:a05:6512:3f03:b0:535:6992:f2cb with SMTP id
 2adb3069b0e04-53b3490efc1mr3742461e87.42.1730126270080; Mon, 28 Oct 2024
 07:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-kselftest-gpio-set-get-config-v2-0-040d748840bb@collabora.com>
 <20241025-kselftest-gpio-set-get-config-v2-5-040d748840bb@collabora.com>
In-Reply-To: <20241025-kselftest-gpio-set-get-config-v2-5-040d748840bb@collabora.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 28 Oct 2024 15:37:39 +0100
Message-ID: <CACRpkdZONPzUOzYiN0+kd_wFdiF-2Vk+wKC1psmR8P9zF2c=AA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 5/5] selftest: gpio: Add a new set-get config test
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Bamvor Jian Zhang <bamv2005@gmail.com>, Shuah Khan <shuah@kernel.org>, kernel@collabora.com, 
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, kernelci@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 9:46=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:

> Add a new kselftest that sets a configuration to a GPIO line and then
> gets it back to verify that it was correctly carried out by the driver.
>
> Setting a configuration is done through the GPIO uAPI, but retrieving it
> is done through the debugfs interface since that is the only place where
> it can be retrieved from userspace.
>
> The test reads the test plan from a YAML file, which includes the chips
> and pin settings to set and validate.
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

Bartosz needs to review this too.

It also looks good though, thanks for expanding the tests!

Yours,
Linus Walleij


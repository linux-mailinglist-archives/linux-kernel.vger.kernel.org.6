Return-Path: <linux-kernel+bounces-569331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF490A6A18B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162AD1890C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4720321421F;
	Thu, 20 Mar 2025 08:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M1S9IfIi"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2BE2063DF
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459880; cv=none; b=LJcVOd4AFB26Bc5n7L40ZboJcnrT+pLRe6sEEnVRMbvImS9Qo2bPypueHlaXbqk324+++fEOQeP6YlJl5KPUPWhIZsR304FRCX6Je+u7WU1gXLDYhiUwEZxksnVC9ixhlDP2M5c/CffkAfIXhyP9GRhuOOfgnn7raw1tI22RxCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459880; c=relaxed/simple;
	bh=Hjnm6h6VbKdAmP+BYdeTLnUhxywAbAPx3ODECnQc050=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBnNvSKdUr6R5DNK5gKTkBjS7vhkEMubKuVXUQUrmsQ/Z/iL01kIcbTWULshQqmqAAo0IKNYUwHDp6HBAp5VASJUx/PPg5+aPW0uBZvEtvL0QNChL3WqsP5tM0byJDUIXQPRWYWYAi2HKevfLquadU9JJ/boieWxDco4BcMyrWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M1S9IfIi; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54ac9d57173so1799953e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742459877; x=1743064677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hjnm6h6VbKdAmP+BYdeTLnUhxywAbAPx3ODECnQc050=;
        b=M1S9IfIil12HIpBsTto0dlZfzxEPbTItzJyQmBvzufxsjjBdQv+7BxEwJjotUgo4nt
         ux1FX19G+uUPodUKec3GvPcVK+8ojUgFlW2ttt3ZI1GK09DYbT1fZxar24XCwnFM1zYs
         cwW4KDNREDl2E7oiOFv1tvskN5CUEIGl9HJAmb55qMNpcrgvOcN53oUixeIvoE9N1asV
         wAptLZEm/RmAfA9RPj0zwlkfPPauay0IZiPgXmNfA+ACg2AZflMTfGGZmIcUaTwCcrow
         5kg6raNDQ7AsqatYL1d8b7Nh71EE3HBEqMoACwPrxAxlCwXe3AL75YHKWDO4KbEBUd6B
         GRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742459877; x=1743064677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hjnm6h6VbKdAmP+BYdeTLnUhxywAbAPx3ODECnQc050=;
        b=OElRwIRMdemc2ScTuHmhE9FtmBRZqzNjgCTrdT1m2ViaKna5VIezFotnZ+b+jqHoGF
         I7qkWcov+9z4PcCcQAPP7jjXVoo70NwybUAcoWWko7fS6ZPeGyXwPxpK/0OKMn/mv+3M
         GS+tj4vmZdAAWCelNbrNUWO5CNax7+2p4wYtGDFkQitb6sVxg00S7EMm2Qejs6ykgFq2
         uJgmJhtrn5qhXdYS/lxuJ96AzYU2Bw6ZxRRQ+3U1hzk/hMo7nTNwt6KV5lDvB2cFhdbs
         lc/yQAwDr0sPMNxP0RUugElic0EgUfiBJumeQl0MgTCsttnuKrTIO7cJSLKG9sQlO328
         GSmg==
X-Forwarded-Encrypted: i=1; AJvYcCVRX/MRWlXRFBu3dxjoVvNLuYJjFVw2iRvHtmhpXzW2+JuJzJ52IbqYQ99gpnbzZ8H3TT1ci7cetxWJA0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqAQgJVS+fdpCrUdnv8dlL0Xc9peDl3lQLjO/p+ZVTB6VhJ5C8
	5wmJ2cTYgd6elVmge8JkhBzonjFdAwl0UGJ15WvNRPEUbey3csR+T/O2o5EZPuRuyXNXa36t9a5
	NqpKJlgN82bwFCDAqKqJiCyM0z/IKo8NYZ8uHDg==
X-Gm-Gg: ASbGncuck2iuMyUkCeGlOYjgFbHRD9F5mQRBWfqBwUhV75AhfKSNvUNr97pmoaK3tVE
	VRU0LspWoZEqomd3bS6MbcBuRhpt0EBU28af52Y8i6vJjJeeZNfDSmWDt6fR1/CnnpLd8R8mBId
	69RX4tAFbKmIqYplB8Ve/XriE=
X-Google-Smtp-Source: AGHT+IG/qAFRD74EC6DfOcOqkvgWE0hQdw3vhe6S+Yk+NWo+wi1lPVjn1cyc/Bi7/s/7IoSWdNyFqFlt+2nxrhzoVuo=
X-Received: by 2002:a05:6512:3da5:b0:549:90ac:cca2 with SMTP id
 2adb3069b0e04-54acfa81eeamr1107537e87.1.1742459876900; Thu, 20 Mar 2025
 01:37:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319092951.37667-1-jirislaby@kernel.org> <20250319092951.37667-44-jirislaby@kernel.org>
In-Reply-To: <20250319092951.37667-44-jirislaby@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 20 Mar 2025 09:38:06 +0100
X-Gm-Features: AQ5f1JqSSwrQ-z73spgQxCBP5NfYJlEiFwR6UtMfH3ZSL2iZPsZZ-Fc9orX5jF8
Message-ID: <CACRpkdbh=eei7RRFOeKdEeDQLDtiydnpLzYOGy0SmBbUVXOLzA@mail.gmail.com>
Subject: Re: [PATCH v2 43/57] irqdomain: gpio: Switch to irq_find_mapping()
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: tglx@linutronix.de, maz@kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 10:33=E2=80=AFAM Jiri Slaby (SUSE) <jirislaby@kerne=
l.org> wrote:

> irq_linear_revmap() is deprecated, so remove all its uses and supersede
> them by an identical call to irq_find_mapping().
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


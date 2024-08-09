Return-Path: <linux-kernel+bounces-281315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B115F94D56D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72403282C4F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115527E76D;
	Fri,  9 Aug 2024 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OdlI+B+3"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20554EB38
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224453; cv=none; b=bfVw0+I1zK7PQi0QYM3tFVgDQOAcJTSf1nNwnGC5UvncRmTye5TLm/UibudQ1FknSTwGbJeUHRfGcfXY6QzTLxEcKbbhWo3o5exakKSBCvC2v0gtYn9/8n7KUmu99Mos8a74K1qFu6Btnzb2nQx0Ny7kvfXJx+v4wPELGuY0FpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224453; c=relaxed/simple;
	bh=E8vvekebT+o9aZPEr0peeFB1FrcFbUQ0v706isrJR/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucCL+373/12ChyQWt+nsnwn5kSTAwWPVDitwgp1WTEproGieLMbVBuK9tRXCB6/YHCNZWfLDzGb78h8iEPPvD6KnHTLkFojBkRPPV0ijr93OSbI1FjkQ1r4sz4C4l9biLeS6mwytFC7C3XwXjxIqP/cz9Eir9vYRRnUfwlKLrQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OdlI+B+3; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a3b866ebc9so2734751a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 10:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723224450; x=1723829250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mUUC2zt5X7wGSPTIR8Ixuv2LhaewZy5GwmEU0+51Nm0=;
        b=OdlI+B+3mGuQZ9OJ6Tc47WIiyaBF7VK8KBNkgywuhY7mjTBc5esNYz4pM5nS+Z78b0
         LEJQ5abPWA9GWsTwA0ycNMeMj7yJ1NPWyx7cuiQC13XSPySQ3KL16IrGlEyj1vSriFjU
         HWOkB6ZlUd+XRukmDw9mW6VaMxq6iRQBxl0ioArHioU0lb4WeHvpftLEeUB0RavCwkfE
         H3zDoV48LTU98ho8j7DwcH3nAUTHwtaKrpKRCxWstiIzyCRKCriA5dMo/jDlcTSrtIoV
         Ltmw8ifCYKDyepm2d9RuGkAD548VQpl9f1Q/2JrREPyai+T8pp4zrgCW9Itv37u5bsBe
         soaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723224450; x=1723829250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUUC2zt5X7wGSPTIR8Ixuv2LhaewZy5GwmEU0+51Nm0=;
        b=GjCD1t1fK9DIgd99mYEHN7tsf6klvjjc1TxQgjX1uFFogh+/vtKR23FWsdN1VFkox/
         EqJWeEwsh37iWgp0qkRKw1ZeX2uroz9VHl/tyd82BFGDJCYSvTu3p1JSzWHKUk1MJgFK
         /Rj0CilesWg2/VqshR1PoFOws4Ndj9WiiyDggyalNDVR7FoxLLzyddK+mF7eHYvEgYJn
         k/cNYqxqAP9dl+T30Kw+JYVoaVfJ11GTvrkd06qEu3nxpXxbnv+E8dzXz5sJqdJeSclS
         +ZSuV7k3xWfzP/BWO0O3tLuHIpjXrb4+EgNRc2qii3cgll8Pfh343Kv7sL8YqMcuAMpv
         baxA==
X-Forwarded-Encrypted: i=1; AJvYcCW7qb5cUhVVUY5Hc/ECk1YnGd79sWr1wA1AxRT9ZtRLdmyTkeU7PMI/Qdu9dhEiTjgewSKe1Xf7wc07c0emdixxzKuBldcPUFgo0rIe
X-Gm-Message-State: AOJu0Yxbzwhc3a6i98A1kjgLG0EfEe5nJRwTDwTdjcIxtcmaP+0Kz6Bx
	iospZXTkTOaP5oWr6BTzV4yv1q1b7WLjgBnY7Oh6sJQoI+SE921FE0SmnOiojsc=
X-Google-Smtp-Source: AGHT+IEt/sHmuz7dJKBZZUaDhX8rTZoWgVMRduT848TvSQgHICmUMTu+jIQDGGf6Tbh7WDA/00FZDw==
X-Received: by 2002:a17:907:94d6:b0:a77:dbe2:31ff with SMTP id a640c23a62f3a-a80aa67c935mr191733566b.66.1723224449833;
        Fri, 09 Aug 2024 10:27:29 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bcadbesm855994366b.21.2024.08.09.10.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 10:27:29 -0700 (PDT)
Date: Fri, 9 Aug 2024 20:27:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, jic23@kernel.org,
	kernel-janitors@vger.kernel.org, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: pac1921: add missing error return in probe()
Message-ID: <c70e6337-fd03-446d-b890-4c3df0ae87f3@stanley.mountain>
References: <1fa4ab12-0939-477d-bc92-306fd32e4fd9@stanley.mountain>
 <36b1a47a-7af2-4baf-8188-72f6eed78529@wanadoo.fr>
 <66b5c5df76766_133d37031@njaxe.notmuch>
 <93f18533-da95-4f29-b6d9-8b8337a4cc90@wanadoo.fr>
 <66b63af81a153_27fed37066@njaxe.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66b63af81a153_27fed37066@njaxe.notmuch>

Just delete the -Wconversion?  I'm not really familiar that option but it sounds
an even worse version of -Wsign-compare.

https://staticthinking.wordpress.com/2023/07/25/wsign-compare-is-garbage/

regards,
dan carpenter



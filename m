Return-Path: <linux-kernel+bounces-173847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEA68C0652
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FACC1F22A85
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1990131757;
	Wed,  8 May 2024 21:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cEiCB+MT"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11B9131BA5
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 21:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715204277; cv=none; b=pmnHFVT21LLoo/spxxLB5Jwv5nW1+M1eKCK5cyhcJsm3UPO55W0JoMopIeAuO/hd7IscUuFnFHk5t6qDSIB5EaEdEgcWqzP19UvlYVLC+jt32fUTNsFR8WdsvSivogho1eZzbq3+hwZYTBYMkRU+CqTEv/0mpp1vb3iLlBpN04k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715204277; c=relaxed/simple;
	bh=cdiw2GqERNdLWGDZvevrJt48BgO16kBf3IU18v8JIos=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Content-Type; b=c21JhrikTe+bZ1PhO+A6lS/b0yNElIttpnOPo1V2pDw4dm4xt9vVk/ii8qnKdLPDruIg/0d1EKh0QFinxmHQaLvMLJJlRqeB78zi9qu3d7Qd5wPU7kkrJ6KAercAT5nTn3b36RFSJ9v7KyrC8HWVKwJj/25fGnARtD88YJEBBms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cEiCB+MT; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7f3c389c04aso59963241.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 14:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715204275; x=1715809075; darn=vger.kernel.org;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vl7q+Vd/XNfdKR8l+61j2xnN8aYOLCMAcOO4Md3z7L8=;
        b=cEiCB+MTm6baDeHuSmvaVgbyEdu04MT5UyQCglzn+u3GWqtLiYinpUaeEK/Sd8WY4G
         Az7rE2DkSYBB2MVmjviG6FKlFu5MkmsG7edd6j37JmdLzbeEs7TjbXy85L1XOkW2OWTu
         KqlmIm8NcNwjMA+Sp9+zDcGbk+47uba/LmG4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715204275; x=1715809075;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vl7q+Vd/XNfdKR8l+61j2xnN8aYOLCMAcOO4Md3z7L8=;
        b=jC7tia5S9/vnc69GPI7an9Bt/EEugrFWWQaXTP+VDoUjS1/7fJTEtyYXtP21uEx5cT
         oAyuTFiKuEeg/mEwytI3lxfJSbpO3XX+LmzW4YEtBHbZL9914SOgzRA82yCZfN3sA0Xq
         TpIisVfa9X5qbs7QlEh2QgLXI4rlF/ktlP3A3pMrTWmuajHi4dkw0vArmx/+5RuLh5kB
         1bm+qc6ruPzjlRNiktvx/Uw6wKnVinQR5i7DZBKzHMNf6GUANb8eitwqHlFZbSLcU/Oz
         SnAXOZgBwVt0ekRSAeb7QofWL0KOYliVf9EGcvItytQOm4xIpQdur7zMzIDWJy4kpPmK
         3LEg==
X-Forwarded-Encrypted: i=1; AJvYcCUDhXbvpyUBDfgmw3/3HSEIcy8HXb4dHLgi+S4Z55M110Zl8XSbPcYSGFDVGrnl8XcmZUZH6e4VUrL0WztaaHwe4Xms28pAGDiTxnjy
X-Gm-Message-State: AOJu0YwLYeQV+5o7YGbN1k10G7HpQljQWLV/YnMUI26G5cFLc7aXCzrW
	4IeZ82pSn4iNAPQRg6Rb11RGSahyrk3FAuOdp9ikUbe4Hbq6Gq2MQXTRKOwct+UIrM38te7woSp
	ZT5uUMv1BPEcHod116i9bPR8/hOnsFlzzE16q
X-Google-Smtp-Source: AGHT+IFDBHDLIE4wJPMlNwvqUB0sQp+V/1Fxh8SHcJYZP2RytnlelrlqQIMuS+CypwEE50UCpKU5Q0Co66NzpmqG5BE=
X-Received: by 2002:a05:6102:b0b:b0:47b:ccb0:979a with SMTP id
 ada2fe7eead31-47f3c1a1623mr4778528137.0.1715204274742; Wed, 08 May 2024
 14:37:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 May 2024 17:37:53 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240311-decode_stacktrace-find_module-improvements-v1-2-8bea42b421aa@bootlin.com>
References: <20240311-decode_stacktrace-find_module-improvements-v1-0-8bea42b421aa@bootlin.com>
 <20240311-decode_stacktrace-find_module-improvements-v1-2-8bea42b421aa@bootlin.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 8 May 2024 17:37:53 -0400
Message-ID: <CAE-0n51sER+JsJed9406D8D74dh7dnYOykz9NVv1jHb8Pd--EQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] scripts/decode_stacktrace.sh: clarify command line
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
	Konstantin Khlebnikov <koct9i@gmail.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Sasha Levin <sashal@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Luca Ceresoli (2024-03-11 08:24:55)
> The syntax as expressed by usage() is not entirely correct: "<modules
> path>" cannot be passed without "<base path>|auto". Additionally human
> reading of this syntax can be subject to misunderstanding due the mixture
> of '|' and '[]'.
>
> Improve readability in various ways:
>  * rewrite using two lines for the two allowed usages
>  * add square brackets around "<vmlinux>" as it is optional when using
>    debuginfod-find
>  * move "<modules path>" to inside the square brackets of the 2nd
>    positional parameter
>  * use underscores instead of spaces in <...> strings
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>


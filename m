Return-Path: <linux-kernel+bounces-229429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9CD916F78
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDBBDB22F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D9417554C;
	Tue, 25 Jun 2024 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OuCy10oO"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A7F135A69
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337414; cv=none; b=GG0aL190ezFrJ8iHOB5hh267dAY1gHuqnskBHaSEI2J4VJTpytyYxxEaKuAS5VGiHZGRFUHNFQVJUcV7vStPGPxyHXBraB2EEzpeX8gnFAzmDPfrHj1dSsRMk/7Kp3jjp1vix/lW+4QrY1rylspvyPG1EwYPfU42GZwk7fVe+Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337414; c=relaxed/simple;
	bh=zhOpRhnIOjLhIPQbQ88jS6vvBNDxTzPQUPHVdQKG4B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qxguLqMrIzUJ30R9DDPqVbVEQvb4h5+y22EDRu26WpqqEjojTtV7nF/COYsurYvafRa3ksWfcySGa0HXnQiSolrW+y/6/rqELLXaRQRN/LNb70t5y9mA5X9EDqJK8fRPHRyfP4OBWyJxQqBlZ8amlalS5uFqEC96YF3OoH/ZnNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OuCy10oO; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a724b9b34b0so328960866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719337410; x=1719942210; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uzVgUsCCX9BTm0IzqnKAAox23KAf8QNQ5ErJoiP6+dc=;
        b=OuCy10oOBgq7rRHkdeY0tqugVH4Bg65OfqCTIL875AjzD1cVfbVERkS/DxKua6faxg
         F46X25VGFJoG8/67EoIOpZx4Ju8myATfuCXg3w7WD51EZyS3cdtVuJje3kkFxYz6wexs
         7ypgs824XSNA5x7IPglO4S1Tz1pIJxgdddDWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719337410; x=1719942210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uzVgUsCCX9BTm0IzqnKAAox23KAf8QNQ5ErJoiP6+dc=;
        b=fwvFEHqRpmRMIo7pBOer4VDaP4tev0hbvtAeyWBsR9nVQ0agtPoRxSypIXVkLKrCec
         ZnwFj4cSehsEMFeCooyuz6obB1ogisM25kfQ+Shi+w5I4qvtrVuEszhOK8Rmf8yAYKoW
         84KwuGJYnUZ20yaacQsPOYsgYdaTV9PT4+kYwzwKCEWVIy4J/RP52qbZIFEGd96T4fTk
         10wxNjV+Wnv3XAHTA5oq3y4tOs669JJfW+bK3oJbivYxubzDLDVZ6jzYVhqdxWuT69Na
         gsZNGbNVt6Jbc/kpsV68FmFjmtVltS/PiWDXmoVHklruIq5k/ucpYB6wn4/oUbrSh6El
         W8GA==
X-Gm-Message-State: AOJu0Ywx0CgxFyx4Uv9/1Uh03UPkmL9gOxqK9gBV1VjP13vffizJsUCf
	fhalUXpaL9bmJa16iX3U4jZqbpGxp4U8zkaC3K9Vh9JUbUJW0B1AZ5pFBwA2iFwx47V+kRKClLn
	fIZIUwA==
X-Google-Smtp-Source: AGHT+IFc083Czc1mmXhtU1/req4JiNBYzFtlE8zuW7kITqbtbOCUIpiSJVDnebe8VT8aZ+oSUfN6gA==
X-Received: by 2002:a17:907:c281:b0:a71:ddb1:37fd with SMTP id a640c23a62f3a-a7245cc4a0dmr613170266b.65.1719337410040;
        Tue, 25 Jun 2024 10:43:30 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72457301a8sm335433366b.90.2024.06.25.10.43.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 10:43:29 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a724b9b34b0so328957966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:43:29 -0700 (PDT)
X-Received: by 2002:a17:907:8b8c:b0:a72:6b08:ab1a with SMTP id
 a640c23a62f3a-a726b08abdbmr214490066b.46.1719337409082; Tue, 25 Jun 2024
 10:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiMMT-2pfJZ8ckbnGTbSHy5mvvE=+-MyA_ARPUqiy_C1w@mail.gmail.com>
 <59fc40ca-3ab2-4227-948d-e18a0c713bde@roeck-us.net>
In-Reply-To: <59fc40ca-3ab2-4227-948d-e18a0c713bde@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Jun 2024 10:43:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjqctCputmUNDPnf7W+TT00uzYs62cr4Nq4tyE9Yvbp_A@mail.gmail.com>
Message-ID: <CAHk-=wjqctCputmUNDPnf7W+TT00uzYs62cr4Nq4tyE9Yvbp_A@mail.gmail.com>
Subject: Re: Linux 6.10-rc5
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 10:15, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Nothing to report from my testing.

W00t!

        Linus


Return-Path: <linux-kernel+bounces-173845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3207D8C0650
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C241F2289C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBD1130E27;
	Wed,  8 May 2024 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="USm7C+JN"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003353A1AB
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 21:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715204156; cv=none; b=eCsuw9EO8h122HBGg6xRSlYitWGGPtFot8tt2K3sV7T6D6Es6wJUHe93ZMdEkaaPkgwuzb8MMagYhvWQoLLr1sNeFsVG/vOAf7D2YPIyvfZp2TZmbI5IIeZJGo0+INJXza+3MinIZbKldS2QYEmc1L0Pw7W+2KywPqRbxF3wqRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715204156; c=relaxed/simple;
	bh=TItpyl1t0DXLCCEbXrOYaW4CWjE/M37i078bhWzEMyA=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Content-Type; b=k8kwbbz8XABoYKAzzmIpWQZo3/oIQYjBTBFO9yEGhIOMVoF4bWeG5f5BpVk92iz1gsjRQFMk6v34Pg6FIafDPYyLRigNNfXNvxw0uR8TCTAcWc/hvF+K5paQPfKgEr3uspG8AxQf5eu6A/6kDk5VrzNCKmIp/QI9du+ikTvSbnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=USm7C+JN; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6a0b68733f5so1953306d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 14:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715204154; x=1715808954; darn=vger.kernel.org;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3gYCZ7oFAMec1ZrgXeVWypvnMbMyJT9MYWUz9Y1dIg8=;
        b=USm7C+JNWffsKHNigWyJbeDSzgGm3DZCzC+sZy9D8jpibta/G6OrF4QwVVvNDf/1fH
         1n14rpOztosk0q73Eq4ONepjz6GG/nYlcQHmJfkASVTUbbmEZ+Ah5YnW8RwUey2yq7A0
         0tUodQ5HPLd3+vLzkBpZACbfiMKWvGSNKECu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715204154; x=1715808954;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3gYCZ7oFAMec1ZrgXeVWypvnMbMyJT9MYWUz9Y1dIg8=;
        b=dUR6EXfr1H2XrALwsMtQWXj8SFvsh6vVb3k6k/xwxNnD5IoBfR8bSRHkit5DkiUW8x
         BZhqL9U2kuPI7zMYfZZWysBmrw1TTrBkKs6/YWSNAG/3XdormOZHTuRuLMrwklg0NfFu
         f6T/kYGnydwZJeJFscXINN2Vu7c6Ift3ooNG+6QAocJf4b/YbDred5D7e3MNvC1DQxZC
         nT14pvz1+4lWsdHgEWmWa8UAUeBHN9t+VJkUwoJjJMp8s8O4RMw6h8h3lvF8hF4fwDzh
         xPvEKtOsFEezlVYzUwHNxM1JQpl9PMkrfFIdQG2LC8D3aeyFILv05soUEqyd2h0M+nHJ
         FlYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQYvRHiHoly10/s7l52fEJ+42j162aiPwFavoebwfNwRx0Sz5oRJZgJtK+OD4ArBAm0D1ETOy0PrH6QAZvoMfx8j2lZiNuyLQUEf+r
X-Gm-Message-State: AOJu0Yw2TSqI7tzMT2nY1ooBaCFlfAg5WNWdms85VsuJc9zBwSoQ1h7o
	y422JqPIhmFhVEuqYd9rVwDX/Hh9ipGRKQ4meDFk6bckaytCQdVrmUzqX+OwPAPvrqWi0LZ/Z85
	lYNTSLdkqYXcziuliW1t+88tzZEqXK0hOYvVK
X-Google-Smtp-Source: AGHT+IFZNxebi22TlsEERMHQx17gy2mKTrpsZi/0tZWOTRFXXyKTkZ+BTLUu9XLHL3gPzTq7v8I+/UedXLdrgPAaY2M=
X-Received: by 2002:a05:6214:d88:b0:6a0:ce1b:e75f with SMTP id
 6a1803df08f44-6a1514bd656mr44299346d6.45.1715204153925; Wed, 08 May 2024
 14:35:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 May 2024 17:35:53 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240311-decode_stacktrace-find_module-improvements-v1-1-8bea42b421aa@bootlin.com>
References: <20240311-decode_stacktrace-find_module-improvements-v1-0-8bea42b421aa@bootlin.com>
 <20240311-decode_stacktrace-find_module-improvements-v1-1-8bea42b421aa@bootlin.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 8 May 2024 17:35:53 -0400
Message-ID: <CAE-0n52cX0qhTWdNtJEvy_GUEbXonf9LgmU253Rn8xTehj5OKg@mail.gmail.com>
Subject: Re: [PATCH 1/3] scripts/decode_stacktrace.sh: remove find_module
 recursion and improve error reporting
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
	Konstantin Khlebnikov <koct9i@gmail.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Sasha Levin <sashal@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Luca Ceresoli (2024-03-11 08:24:54)
> The find_module() function can fail for two reasons:
>
>  * the module was not found
>  * the module was found but without debugging info
>
> In both cases the user is reported the same error:
>
>    WARNING! Modules path isn't set, but is needed to parse this symbol
>
> This is misleading in case the modules path is set correctly.
>
> find_module() is currently implemented as a recursive function based on
> global variables in order to check up to 4 different paths. This is not
> straightforward to read and even less to modify.
>
> Besides, the debuginfod code at the beginning of find_module() is executed
> identlcally every time the function is entered, i.e. up to 4 times per each

s/identlcally/identically/

> module search due to recursion.
>
> To be able to improve error reporting, first rewrite the find_module()
> function to remove recursion. The new version of the function iterates over
> all the same (up to 4) paths as before and for each of them does the same
> checks as before. At the end of the iteration it is now able to print an
> appropriate error message, so that has been moved from the caller into
> find_module().
>
> Finally, when the module is found but without debugging info, mention the
> two Kconfig variables one needs to set in order to have the needed
> debugging symbols.
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>


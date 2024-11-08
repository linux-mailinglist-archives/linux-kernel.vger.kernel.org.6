Return-Path: <linux-kernel+bounces-401098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC1B9C15F0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 06:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 067CFB23F45
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BFE1A2564;
	Fri,  8 Nov 2024 05:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4gN4sWj"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F871610D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 05:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731043028; cv=none; b=Bb3kepyvf3F/pbMQiKgqfC+ldHPXulOi5TufEr2kAs6zzq/JRYx188akgZZoLSfUCvQEIOYHumr4QEhuBRyckdmLtX9iCruLA0Qr9jogFfXSTAqccfR2yEwc6xjM3Er5lYM+VqIOczbJuPsFLZIoUV372SwmPibQPQkAXeNevcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731043028; c=relaxed/simple;
	bh=CrR1dP1e+6/xdKuQ11j2BbQQY5/fv/bsAhs8/u0WDT0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fOAItfIefULsmOIN7+gc1iSt+9v34LTcZz3vXCFlhEq36D1hPEE1Q3BIsQpBUAXeyUvfa/t/PnxXaBYCgAKPaKJRO0vgM8xWvzOoPE8mw5nOqR1m/I8arhP75qaa9sYN34QhhOVCU+J+YrTm7jbhq+KXEnlGTf7hgKHTcrl4qW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4gN4sWj; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e6104701ffso1194619b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 21:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731043026; x=1731647826; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CrR1dP1e+6/xdKuQ11j2BbQQY5/fv/bsAhs8/u0WDT0=;
        b=O4gN4sWjMsl2AKCVL/dFPms8V1iaSMZMYkB3IXYZQoPYSh/y9f1EzYjrjCfz7PMzxw
         kU2tU/HasxMwbu0ktvgAjJzGcyS/+l+Jevdg9vf73M2jeZK133enDdTNPZ+Zr5z08TLR
         1cYLS1YWugSs8l8r8O9o57dpO1cyy5TDll2V5OZwM6iVRQSGMotj8vHeWf2pm5bsTe0g
         ssjGmh8yQHRwG5h1jCxGW3snGmuTZQw4ekxfMVa5BVpKzeRxaBBrKrWetAAFuXKbCeNN
         Emle/er65O1Ktuc72XOVPJDMkO1Cm9UWEGPDU/8Kh6vCbBrqv8/c0A93mXXrGWxSuiPP
         3BdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731043026; x=1731647826;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CrR1dP1e+6/xdKuQ11j2BbQQY5/fv/bsAhs8/u0WDT0=;
        b=rHi0vCbEiBB/R4dXJSdoHX+1QUkncGpNE6NbtOVvGiMhTDZUAcut96SxwwJbps9QQd
         D6D1of9bmbVIaQi1qfFRTx2DF0GZg1o2RaJ4NlFXWIZNxWI+znGALqUTRcc/KpzvUDHG
         1ZrsURvQ1wELf4uksjy6JTaZJOkvXQZh6azhuz7htlVVV6oC/vCGeAJa9HuoVGDgW0sk
         kL7JmjgcZs7nkjIxtUKUC6F44ilIR8KHPvQ9ms5oKeeVitNqrlqgRyk64lSOhjjOXInT
         17Bo5umu566l4JRp0gODj5hQpecGYsqZfTSXzKtCkF3+UPDwJAjJnM7MNUKNZdWi4W2y
         fFYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX62Cs64qYJ3GOOUV+eICm+rBy2Ii2v1pHs0TXOAEDbT8Owco3nI1tZfxRS1CxJMj4hZU+5s7KQV9SUUm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw43LQwKwCg2r2PDsgsG91HZihhCk7byef6tH3WDl9qcqYBkDQu
	dIGat54OudCAth3nRpuLeK7q0G4xI9mJw4jCybYSCAfsTQex0wVA
X-Google-Smtp-Source: AGHT+IHMaGoJod9V7kdVUIxYTBfPtnmvUpb1uVIbjECmp/fAn5mHECQvrwe1vftSgzrPcmkOjQYBxg==
X-Received: by 2002:a05:6808:1819:b0:3e6:3205:1a71 with SMTP id 5614622812f47-3e794699f41mr2047858b6e.15.1731043026129;
        Thu, 07 Nov 2024 21:17:06 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f643a60sm2482568a12.56.2024.11.07.21.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 21:17:05 -0800 (PST)
Message-ID: <961720ed43b3df26042efc260d433fb6ddf5c44e.camel@gmail.com>
Subject: Re: CVE-2023-52920: bpf: support non-r10 register spill/fill
 to/from stack in precision tracking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, Andrii Nakryiko
 <andrii@kernel.org>,  cve@kernel.org
Cc: Tao Lyu <tao.lyu@epfl.ch>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  linux-kernel@vger.kernel.org
Date: Thu, 07 Nov 2024 21:17:00 -0800
In-Reply-To: <emjjveewgoegvinmjmba4ys34vbmb3sp6r6qefv77i5mtettmj@hsvm5vm3qivd>
References: <2024110518-CVE-2023-52920-17f6@gregkh>
	 <emjjveewgoegvinmjmba4ys34vbmb3sp6r6qefv77i5mtettmj@hsvm5vm3qivd>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-11-08 at 12:42 +0800, Shung-Hsi Yu wrote:
> Hi Andrii and Eduard,

Hi Shung-Hsi,

> I'm trying to determine the security implication of CVE-2023-52920, or
> more specifically, what does commit 41f6f64e6999 ("bpf: support non-r10
> register spill/fill to/from stack in precision tracking") fix.
> Superficially this looks more like an improvement to the verifier.

It is my understanding as well, that this commit is an optimization to
avoid some precision marks. I do not see any security implications.

Thanks,
Eduard

[...]



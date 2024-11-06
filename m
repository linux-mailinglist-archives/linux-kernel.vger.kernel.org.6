Return-Path: <linux-kernel+bounces-398767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3919BF5BF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0661C20E20
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176CB208992;
	Wed,  6 Nov 2024 18:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="oPeTTcgh"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5183208236
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730919018; cv=none; b=K1loD5j0XmEWcE0Ni0d7/jCkb0gyJc3ZfpC5JGubmFqCxlIAdcgUlzlHr6/Oa696Y8nS7IlMTLaT1r25PHtpo0c9BMssxyP9aX9+HqRYvKdm4jGOStcWw/92J/e5KbnMlz/fxWxEsR9g8gk74hEqDxHJd+P1YlOCoEggipODY2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730919018; c=relaxed/simple;
	bh=m/jP5PT+AmPTonBurwprv2eoMljxeLQUdoQIl1TZrSA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=DpNipZ587czJzPTmkz4cWTL51XxakQhuQbgoBSBbUt97jclbI5oWn4nR/y3Ok+3JVlRsz/+GovqacuOhYEntBT/t1wI6V9yqm1sWZVYShXdQPs7Lnup9RDYdXtYaPR6iuF4bqqPg0uqtm7O7D9br7FUxgOkmH35KWcEvf2WhjvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=oPeTTcgh; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539fb49c64aso72813e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 10:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1730919015; x=1731523815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m/jP5PT+AmPTonBurwprv2eoMljxeLQUdoQIl1TZrSA=;
        b=oPeTTcghue+YtA9EHr99Gfsn9Tnx00lrti58Uh0I/Wb0gP/JgVmxrxWXBRuWgqIYX0
         xYazM6LS7Cj2Xrn1HaOUd1ebCyRPDeOoavKD/o/KYXuz9q25a3DX3Jn6DiaOTTXu8KLd
         x/rAGN17rr8uCx2CL1LlnHGa4NbiKtzBFBCLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730919015; x=1731523815;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/jP5PT+AmPTonBurwprv2eoMljxeLQUdoQIl1TZrSA=;
        b=mQMMZuKWPVdx3PGr4QGbO0n7m+cbIsXz2puNYFmdNXUmcjnfe3J7z9fVCGIeWb6dq/
         7rkQkZjf9uS6UVkwp7UqvKLzM8ObmVkcmwmadFWXiNCuu6BLkBh99KSm+thgkfnCm74L
         Iqzv1FECeKePAyXOUQxtXuGUaLnBGmhamdL1N4Kq2rL8Frc4W137/DDHkD86VV7fUGAK
         TM0tjmIsFR/d6iC/y2trDald8OIF7yn91n+I8yWYpsWUhGQTwA+wJKGD6U/10JJOQcyh
         c8+3fj4i2ma+t7+ZO882RaK3CczsonSzCqQw9TA6thBIwLQ6h3S7nW2Z3nSX3m7889Yn
         qwwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7MFvAuiVdMVseC4TotxjT7jAQc+BmQc39+get7O2Z9isxqMU48o/fhqSpZJGtqBxJTuDk4gdkRDePKrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAn7yz/eAUBYvUIyxND2C7tXUHPEQBbObJNDKf/bfSho3wJSCo
	mimyfWXKqyaAvphikTzMlpF/cv38JnHFMQS4J40MCI9taYa6MlMxeaPcnO7f/XQ=
X-Google-Smtp-Source: AGHT+IHrBZualZIjo+yXzXOuH9W/Qa3OnPeFKyRLr/uYJ3aHzcooB3niS5GxzRC4oz5EaJIIU2dcOg==
X-Received: by 2002:a05:6512:12c7:b0:536:53e3:feae with SMTP id 2adb3069b0e04-53d65dca682mr16913344e87.11.1730919014705;
        Wed, 06 Nov 2024 10:50:14 -0800 (PST)
Received: from [10.125.226.166] ([185.25.67.249])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16d5a4esm316580166b.47.2024.11.06.10.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 10:50:14 -0800 (PST)
Message-ID: <6449aa6c-43b1-40eb-ab54-48803481d11b@citrix.com>
Date: Wed, 6 Nov 2024 18:50:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: thomas.de_schampheleire@nokia.com
Cc: bp@alien8.de, linux-kernel@vger.kernel.org, x86@kernel.org
References: <ZyulbYuvrkshfsd2@antipodes>
Subject: Re: x86/amd late microcode thread loading slows down boot
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <ZyulbYuvrkshfsd2@antipodes>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Hi Borislav, all,
>
> I am encountering varying delays in the boot process

I recognise those symptoms.

https://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=f19a199281a23725beb73bef61eb8964d8e225ce

We found it in Xen in 2019, and were instructed by AMD to insert a TLB
flush immediately after patchloading.

Looking at Linux, there's no such workaround.

It turns out that a side effect of patchloading on some CPUs leaves the
mapping of the blob in the TLB (at whatever granularity) as fully UC. 
When this happens to be a 2M/1G superpage, it causes whole lot of perf
problems in unrelated areas.

I suggest Linux take the same approach.

~Andrew


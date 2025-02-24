Return-Path: <linux-kernel+bounces-529311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 139FBA422FB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A071D3AE6F7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E73713D52B;
	Mon, 24 Feb 2025 14:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UH5yxxyT"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCA3A32
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406573; cv=none; b=cRVNvwK8I9GONqlQcMOAJaEhIqb+P1CTFigXgkPBNmrI/3fuqyUh0LWTd9remULunbaTs895oaCqjMrjwrY85SFNp3tCLIQKLQ+a4a1ntbfvLKX9PS94Jdecl+NYBAdx/2YBHUGi2j+Q0AgSSUHnjFzKCcgV3lnXxgPq43/Bycg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406573; c=relaxed/simple;
	bh=aS8ErUHqnqmTTd15VPwiT8bQ/m0uizg6loCba6Pfz3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVsV6imHVF/4SjFaYvjaIwM0beGzaLVmJ50pADiK0qelu37hhClwCQ+qgwmfgll07K3eYYgMnAVUl7NVjigljWiu6BD2Z4CfQHQjCI13HDO4VoWyrJ5iTDBNrQdqCHAuE/bXHD3Jx6gYVFfD/m0qCDvuyvq1O3ym+TgBDIo1kkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UH5yxxyT; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaecf50578eso874253166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 06:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740406570; x=1741011370; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aS8ErUHqnqmTTd15VPwiT8bQ/m0uizg6loCba6Pfz3A=;
        b=UH5yxxyTN9KJhpXa3bS00GSJF5GQB3dYT5/go2xRli9Nv524DrClx4eHURncNRka0T
         Yq2vPQwWV+XTOWKdgcT3kxAZYZJm0rr3RoCOk9E1SWUhuUVSLNnFN5dwX90lmUOgyDup
         KP0a+Zcx0TidtmQOKH3bWGFzArjDTq7ukOBU/j+eTDoGlnAZdNdFrsXPefTv1XTTzoD2
         HMLZUzlCWf93o0EZExp7Docno/M88ssnm9RTV4Qb57XYW1wPsXhex4JM74eLGI4VVibW
         rwny6Ff8r+Z4lZk/NhIKp8IR0ELrBntgy5X7dK1rRv8MIAjrKYM8d/pVIAFnwtVTZZRF
         9/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740406570; x=1741011370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aS8ErUHqnqmTTd15VPwiT8bQ/m0uizg6loCba6Pfz3A=;
        b=rqIl1Vmpu+JPRVBb19+FQXSflkw6gQlMDcKXTDXk7jCki85x86ReZwbsfSejolyDP6
         XiRY7S15EAiGDk5ToWZaRuPNeh6pF9MkQ2PFjQa0NoeMfIjuiHdGWvOcwxZsdG33QC/P
         A0B7Yblxj87tuE+VNTr4mo4t+d2UR5jG3a9w8zBPSAlFNTdLdp2yR+3FIgf7nlCHdjN1
         H5VXT55pblc+MkADLbD3MglG1e3IDqMmU0IEbPUsjJlRz4Z9vcRMIwvG61yUICKy1/SC
         jZhTfj2+ZtWHQuTX1pmLXYXkojl8rtbujLVpGs+WoPtgMwkZnasPYSFqZvQiT76xBGGb
         jKYw==
X-Forwarded-Encrypted: i=1; AJvYcCUpYvSz/u6gg3Ia4NS5P9yAZ8aR8+tWIZWilYVTqYz5VOJDH2PasfPWsvfJx0Fu6sWjZeqK/QOqOqKadBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuNsMoXq6yHkglsHv9NPJ1PvMXj2zesaQsT2BKMQflqIT0as1W
	REgEQN+RryVw2XlyAt7R5wCF0zasWAmH/QUNNSLzpK4H8JTu96s+ZXqREXqRLOcTbo/Mr7PdmeO
	XNtVRgSE/SJuuUxsbiRyFwlENiMSeIgQb+vRGaw==
X-Gm-Gg: ASbGncvpkDt63LPfvuipgBqMTw0wUpuggagRhY6rtX/YcNV1MVYQIZWsJCP3dpkK+7S
	iDxs1eTxWyobIidZN4JxB6YcQ6rPexKU8Dnx5a+DwYGTC8f33zj/akqnQsZ5lpKK77onYyQ0mK3
	oE1UHjNvQg6/G9vEZMt4Qs18mqSO1kG2N2bCJh
X-Google-Smtp-Source: AGHT+IGtHl/SZrGyc1AWo9c1khNZ4P1W4YG+bacC1AKRz2RGq9pQXAu8n2Cbgmh3c3ktkZJ/9fEYte7wOsB9sIwxADo=
X-Received: by 2002:a17:907:6e91:b0:abb:eaf3:a815 with SMTP id
 a640c23a62f3a-abc0d9e8682mr1329692066b.22.1740406569986; Mon, 24 Feb 2025
 06:16:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208074821.11832-1-15645113830zzh@gmail.com>
 <20250208075322.13139-1-15645113830zzh@gmail.com> <20250210012931.ym337oexdcjmwwzv@airbuntu>
 <20250210091352.GC10324@noisy.programming.kicks-ass.net>
In-Reply-To: <20250210091352.GC10324@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 24 Feb 2025 15:15:57 +0100
X-Gm-Features: AWEUYZlucmnwKy-2_gNAFI1vkNNkIdocVEHLy-oyIzBtu0He9paMT-TAosy-XWA
Message-ID: <CAKfTPtCLg_kuRtknPsiLwRdKpvb4CYHqv+BRh5yJV8Z+o4oQcw@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] sched: Reduce the default slice to avoid tasks
 getting an extra tick
To: Peter Zijlstra <peterz@infradead.org>
Cc: Qais Yousef <qyousef@layalina.io>, zihan zhou <15645113830zzh@gmail.com>, bsegall@google.com, 
	dietmar.eggemann@arm.com, juri.lelli@redhat.com, linux-kernel@vger.kernel.org, 
	mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Feb 2025 at 10:13, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Feb 10, 2025 at 01:29:31AM +0000, Qais Yousef wrote:
>
> > I brought the topic up of these magic values with Peter and Vincent in LPC as
> > I think this logic is confusing. I have nothing against your patch, but if the
> > maintainers agree I am in favour of removing it completely in favour of setting
> > it to a single value that is the same across all systems.
>
> You're talking about the scaling, right?
>
> Yeah, it is of limited use. The cap at 8, combined with the fact that
> its really hard to find a machine with less than 8 CPUs on, makes the
> whole thing mostly useless.
>
> Back when we did this, we still had dual-core laptops. Now phones have
> 8 or more CPUs on.
>
> So I don't think I mind ripping it out.

Beside the question of ripping it out or not. We still have a number
of devices with less than 8 cores but they are not targeting phones,
laptops or servers ...


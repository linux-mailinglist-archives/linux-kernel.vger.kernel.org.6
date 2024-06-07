Return-Path: <linux-kernel+bounces-205280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EA18FFA5F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9738B2141D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10121B806;
	Fri,  7 Jun 2024 04:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SdK4HvgE"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93531E552
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717733817; cv=none; b=TQ11AhfQlcRtbef77zVyPIkkkSkTiA29rK01s+30DyLyK3LoD5J9sTCM3hkHbaNBn6j4McG+fUQocpz7TNNt57zjAd/75MnPhXfVbD2snuS+Huf7XEhi/LtfZtE8+4EVcl9ZhYgDq/N8ZAlF/ikGEwSdsiUZWarjxee4prQQCqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717733817; c=relaxed/simple;
	bh=DMbihTk99Y2tG0JnDlVtms8BBTQYzqRpGPUu/qD3n24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nqn2sd/FRgvU/HJIOvzx10+F39YN5yVCjloiI6PA4R5Cqy2njFqw85u8qTBBLTPheGTiimRS3jk0jcMGYiMtTlomDi3LB2HRLM3uRPNp14WK3EtdmmPCcNzTiQCyHhFXFvzg6LeeM5vyBT91Y8R6bFPNMzjJZcW0fuq00wGI8To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SdK4HvgE; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-44036ce0adaso208621cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 21:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717733814; x=1718338614; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DMbihTk99Y2tG0JnDlVtms8BBTQYzqRpGPUu/qD3n24=;
        b=SdK4HvgEBhUX4Ywnx4mMF5ChkPLD5wbYL274ve8P85ub3hx705a685Fu5hXxGCXQ7L
         ugSybnMlFaEIMHRpOEiAp/88TTfcIA80M1qF3ExHkSOlpMwJJEhyTiDQQIhtN6VhL94T
         5/marNyls8/1iCf0WBkRUAq/t3ELgVwrwHmi1dNJsohfHcyJeqBPaPWxRAqMkzaAm/KH
         IbKtH1QH5mQQWVLlg6fi5+bv3fgsENPqZAMqwcFM+PYLhH2uYNYntrnzEkfr4HSZTs8a
         b4BGMC+1gGxJeMC8S5TyFdnYYbpotlWadXSGk1WDMJBoC2+/ff4Uayu/Yvcadq+SJLyG
         lvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717733814; x=1718338614;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DMbihTk99Y2tG0JnDlVtms8BBTQYzqRpGPUu/qD3n24=;
        b=O2jAt9/obCmGotGah1M1QqA4iIAHRHAaBU2koNeu/G5X9Jq0TKskTVCPK7BEsSURgz
         c7kYx75ywAKg34PrEmeGOoirTRLp95FpiM6If0qtT3iIaXsDjeMCxRLFfvUKJYprMmCZ
         9p20xLvg/Z64BbhMZwvRZcr+e+hV+alwW3sW8u5c7jqbqnpURgwGV2VTvOaz0qxbwjy4
         SsgV/UV50bsT/mfXrI6GjgPYyq0siNv7/HCqzQ/8AGXl8OgvY7svvXS6S1YeeUwvFAUI
         EIj/eeHlnahA+5xnIrPXZNwD9VRIc0TpXub/VG2rnEnVRx5f0NvdH3YqCnh0fZzjUobp
         5jXg==
X-Forwarded-Encrypted: i=1; AJvYcCV1FqNvis4qqP+RBkJpXmpNlcVLQtEtsSLwkWiU4VOVVd5iCCOecBKHAR+Yb1DEf9zkq4JtUpT37rgmXXae57PzqELW776HPGj3m4Nn
X-Gm-Message-State: AOJu0YwqnEb9iMrzdtUVdV+xISSOz9OgVmaUYsUh95jptfsJXm/6mTW5
	CzJt1anTNCxdSxIEP0T3TOVdL6go6wmRErqBpqaAsVn+tnMixqLE42KkKc8wcQ54cmudhxcTNkE
	JGUgvC+8CRPzGFyGhKVhT7EQUo4mDDMNEDtIz1TJEBGmvcc2jOX7YWGo=
X-Google-Smtp-Source: AGHT+IH2a5qXdRfNX/zxko6YepsoTAqxNXFMDSMTGlVEN08PoI6GKDaJgSwsz00DG1hTqGncJ0e9awbuoyXbrHqwh7Q=
X-Received: by 2002:a05:622a:1e97:b0:43f:f0a0:df69 with SMTP id
 d75a77b69052e-4403721dd35mr7985311cf.12.1717733814021; Thu, 06 Jun 2024
 21:16:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606124816.723630-1-aniketmaurya@google.com> <3c6c319f3aaa60428fd28f4d95c71dc9a8150081.camel@codeconstruct.com.au>
In-Reply-To: <3c6c319f3aaa60428fd28f4d95c71dc9a8150081.camel@codeconstruct.com.au>
From: "Aniket ." <aniketmaurya@google.com>
Date: Fri, 7 Jun 2024 09:46:42 +0530
Message-ID: <CAMmmMt3u=DB5onXdayMN5ZHvCmdnam4wOo0hKizve4K0LnZLZQ@mail.gmail.com>
Subject: Re: [PATCH] i3c: dw: Fix IBI intr signal programming
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Joel Stanley <joel@jms.id.au>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, linux-i3c@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jeremy,

> I think we're OK in this case (just not reading the value out of the
> SIR_REQ_REJECT register), but any thoughts on adding corresponding
> switches in the driver so we can support those configurations? These
> would be represented as DT config of the specific hardware instance - at
> the most granular, just by the specific compatible string.

We can go with some DT quirk, but I don't see the strong need to do this
here. I guess optional registers like IBI_SIR_REQ_REJECT, IBI_MR_REQ_REJECT
should not be relied upon to set other registers.

> Could we use the SIR mask for this, but just read it from a field in the
> struct dw_i3c_master, instead of IBI_SIR_REQ_REJECT?
>
> This would mean that there's no possibility of the counter going out of
> sync from the SIR settings - say, on underflow if we get a spurious
> disable.

Yes, we can keep a SW SIR mask instead of a counter. It would replace
all the places where we read IBI_SIR_REQ_REJECT.
Both methods are okay, but if you think the mask might come in handy in
some situations rather than just the count, we can go with that.
Let me know your thoughts on this.

Thanks,
Aniket


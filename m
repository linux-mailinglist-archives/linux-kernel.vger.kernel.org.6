Return-Path: <linux-kernel+bounces-226888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443EE914545
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 899F3B24208
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA126CDB3;
	Mon, 24 Jun 2024 08:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WQ0MRE0o"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D233EA7B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719218906; cv=none; b=VxZC8Wm2zczgMhU5Lz/QE55DR4UCz4JnvGi8M1xZUe6vYvC0Ys0IFYu8Jgt/g2YjmJEkhs2X/YnOwKHcsTClO3M2xJAcGv8bJrqLu4jVKccG7/GDHbRSp2hTDLBKxeruI+iLu2jBVwwCE894o8C19nikLtvBfUPlEkVusYF3aaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719218906; c=relaxed/simple;
	bh=5tg8FQPxEAdgsMy5r6wK3+Fb55nIGfOe5i0pltcrAY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rn8lE4GlW3mFyFsb+gyPPJ0B1UEcSe7+oHR0pGlEi2Z7qSLDIbFtb+6/Gy5K4JrMCaWkHQdZERBfcBGPPBfqUqCtsFgclv8h9mBKtPfSb0iZ4cwQvSYpaG/NA7yCcK+d4FOahrQc+OuOoxQAXFnNZzKkWjfU53koJtL2CTUJRME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WQ0MRE0o; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-443586c2091so1058731cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 01:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719218903; x=1719823703; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5tg8FQPxEAdgsMy5r6wK3+Fb55nIGfOe5i0pltcrAY8=;
        b=WQ0MRE0obldBaORG+RtzENoyWKeST8NuZ1iehLSag6JZLBprn+f/P+ZiGg6xrX9d+3
         oEXLaSlS4L/SL5WTgmWsPy13XCksSUVcSP4Lx9QudOaqyPBGlvdNNJq1EkxDpgtWBpLG
         ialLJgwjFqpbL0Ok7Z+u+SWhW2tTyvr+olGEhY95PHy+VXF8ZaT7LyqXEp2Jxe6V2+sv
         k+QGcKp1mWRxh9N80WJifILSLox/ivwJevND4k3OyC79iT3p76cbHrqp4kC/74yaP0OU
         Gxfsk7zIsa2PxUC9stkqaqU/ehjJ0UD8BVFbilIXbFXm7egtZqRuVfkQVWZEa7zBUBxL
         21UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719218903; x=1719823703;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5tg8FQPxEAdgsMy5r6wK3+Fb55nIGfOe5i0pltcrAY8=;
        b=bJQUgbDIL3F7D83z+hfLpVTWEdzKhTO15NceES9y44mxUXCbpdjGBq0t9aT26yeBlD
         dwQYgObGxaZfcHOPje8wRzRwuo9It2y2px244C5UmCKEhwbvwRcFNSc1xtjBGRK7SX4t
         fXdDmziN0gnczPqodBcih1zK1h+cGz+GvnYnR51UIpYuLeVuiZq99e+wwdhYRVv3DsWF
         k+lGTgVXKZ5Gi6yFpC9z6b0F3nRTSLv3gZFMrOb+DukZZnS3yPtsHR0jZtVwxZsfEUfN
         HtHWsiKVujxBgFUMyD7xExWsWiWjh9zGU9O2rWpzYB2dDov2N4icqHjqQo4wql7TL6QK
         uRCw==
X-Forwarded-Encrypted: i=1; AJvYcCWvtlPPeZZi3+BEHyYOQEiKytDYq+6+0f0hcBnc9Rb17GE78Cv3XzZdX81cf4Yz/gNAy98Td04wduWv4XtoP3klQ8nRc1PnXG0VeTtj
X-Gm-Message-State: AOJu0YwGeOSi72IlNlT+9U2Noyv6edFxHraA9vgfiNgV1CwuFFAGPCFH
	8WUZV4W1ooHHrJ7fz71rXjn+bmp349TZ2Nbk5MKXDztMwgLY0ousuT40VWVC8/HfxpOek6JlVPL
	nl+yCJc/M28FAmU1TfnifxEebO6hD49MnU/qJ
X-Google-Smtp-Source: AGHT+IHHH3rbfM8HbKt7NrhzLinrp/ljSBxeHNTlEVCPczmxbmT44rj90HeYiqkVOVpeugBhZL+gWJp1KQDIv56AB7A=
X-Received: by 2002:a05:622a:189f:b0:441:5aff:a5db with SMTP id
 d75a77b69052e-444ce38f060mr3807121cf.25.1719218903398; Mon, 24 Jun 2024
 01:48:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611171600.1105124-1-aniketmaurya@google.com>
 <20240624052851.1030799-1-aniketmaurya@google.com> <3c053c47-50ed-4487-a18f-4439d3f2e7f6@linaro.org>
In-Reply-To: <3c053c47-50ed-4487-a18f-4439d3f2e7f6@linaro.org>
From: "Aniket ." <aniketmaurya@google.com>
Date: Mon, 24 Jun 2024 14:18:12 +0530
Message-ID: <CAMmmMt03L7ymosG8CYaRPvKZWdXrnMxHNRQJxHMycs95c5ob0Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] i3c: dw: Add apb clk
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jeremy Kerr <jk@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Where is the changelog?
Sorry, I missed the changelog.

Changes from v1 to v2
- extra example removed from yaml file, minor renaming.
- 3rd patch added to migrate to *_enabled clk_get APIs.

Thanks,
Aniket.


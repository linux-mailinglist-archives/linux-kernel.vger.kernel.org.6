Return-Path: <linux-kernel+bounces-230088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 228ED917836
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1BE0B22084
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 05:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51F214600D;
	Wed, 26 Jun 2024 05:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="vqLnR0gY"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E6C2F5E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 05:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719380206; cv=none; b=ttIp/8pilJDxb0e7myMuJXjcKAZZ3h7oiPmrN7YmwAuBvpKS/8NT/dVI8EYidLPE3bisRQxU4gC4DxWRI/uQOeEUL3Uslxdszb4mJw8/lXIdUaHqoA2uKhwsfx1A3niS/gynMKso4za9QPT7SvXQpMBKQHI1hg3Ub1XOs+kTt9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719380206; c=relaxed/simple;
	bh=HMR2KyYL8Z2r7JjFAwLkfq/xdGrtXmiJ5Wwg40Ii2sE=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=LdE6GN0LDVGXcE6V1N2EAfJ+nP9Fq9jVaPuYX07o/ZSVPSBrDgsueBZiifTH04m7St6zRXYU/A4MYvt4p65xbVsZmiU7aHZQfXzWQGm/NfM2d+p0X5o+j6ARpg+A+wJYvPC8weDMJq8lFn2WZqsiXgr4bvZE05Skiz/6xfttu/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=vqLnR0gY; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5c1acd482e4so3411352eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 22:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719380204; x=1719985004; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xoGmgspSdBUAHUJqXx7P8wqOEZDQ8GrzwQ5Y9V0VsI=;
        b=vqLnR0gY4vU/won87C1CeA4c8yB9+owekpEf893dVovj9Hsv2q+StT5at+A/TljyhM
         pY1PUSnn0auy3Wf81ZQY06e9Kf9MW/L3kVw45igGIIcj/7dt4d/kCUIQC3LzZcBZNh/P
         ZlW93yS8GLegzZUKTiLkisPPk0OksLI07WMC0fCL7e1vm2Syl19by0BKazS0u9Kz7tRj
         6TZZmGBd5m0UOUiXqWnOkdVu8eWKztf5L2ZKNvIjZNoD4E28XMrBwHhOVQPYMsmpHPg6
         cNkxExpNSMdTnVZQZmVekHLA7RiEKG+6HunnioWk2gRUUfNVIwfbNWMlKhz77eiReayY
         s+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719380204; x=1719985004;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xoGmgspSdBUAHUJqXx7P8wqOEZDQ8GrzwQ5Y9V0VsI=;
        b=fAFNETC7QZRUlD3DzJyX8HzL1XVAFlg89Wcm5zcP0DeGJ8JISXSS1YB3gQ/uiT7Z7t
         9670kdQd/SCsu6kljteCKcjmrqPFq5n4a6l0PPEkk4Kcp+5KnC6F+jsxFJZarIdY7bk4
         O7zLnykbS14J5wzs1T40jRCaXmj3VZRbhdLqJhlAGSgAy2r/ggm8E+EiUhybeuAcEW7j
         qZleLe1pqvWEU31+rBhK3A5M2718mVMsOEPFwSJca7F6uh61XZx3e2aobjoccoaJug01
         Ky3wilLT0X9z2LhOmFrE3w+14ZSE91QbDU40WDA75SkRmNfyIMTXZ27oqyzZi6yxX1Sh
         zG5A==
X-Forwarded-Encrypted: i=1; AJvYcCUb8zusiwFpr3fZC+PUQZfOhLt9+w5G3zQVnze7byKtbd6fuPIG5mshGXccj9aBFwCM6QMTkT5EpEIDBKJSzuTpc6T/zSMsENNDM8yW
X-Gm-Message-State: AOJu0YzSXRvggzkc89Uy319a1j0JBUdZWye4SsN3qLKpxRB8mPrhUmXF
	bYj3rlsx0hZ54N028khwvW7kma15Q+aEPW33xHMzx1IdHmYV9sscJ83XzWYPpQM=
X-Google-Smtp-Source: AGHT+IHIm4hgF1JV++efoOuA8VVxoHAW1Q4zjQmqoslSdwHThRFL0aUyjbdMSUOiHfb8JQhkCNjnDA==
X-Received: by 2002:a05:6359:6ec7:b0:1a2:5bf6:2266 with SMTP id e5c5f4694b2df-1a25bf6c9c9mr349095155d.15.1719380204009;
        Tue, 25 Jun 2024 22:36:44 -0700 (PDT)
Received: from smtpclient.apple ([2604:3d08:8e80:cf0:8977:5a8e:a205:ae3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-719e81277b0sm6308830a12.82.2024.06.25.22.36.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2024 22:36:43 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] timekeeping: Use min() to fix Coccinelle warning
Message-Id: <3F9C4695-42B1-4A0A-846E-6FC3BFA7E97E@toblux.com>
Date: Tue, 25 Jun 2024 22:36:32 -0700
Cc: jstultz@google.com,
 sboyd@kernel.org,
 linux-kernel@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3774.600.62)

Hi Thomas,

On 24. Jun 2024, at 23:36, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, Jun 24 2024 at 08:24, Thorsten Blum wrote:
> 
>> Fixes the following Coccinelle/coccicheck warning reported by
>> minmax.cocci:
>> 
>> WARNING opportunity for min()
> 
> I'm fine with the change, but not so much with the change log.
> 
> You cannot fix a coccinelle warning. You can only fix the code which
> triggers the warning, right?
> 
> 'Opportunity to use min()' is nothing else than an opportunity, but
> what's the benefit of replacing correct code with it? What does this
> fix?
> 
> It fixes nothing. So calling it a fix is confusing at best.

I think it's pretty common to "fix a warning" -- there are thousands of
commits in the kernel using this wording in the summary alone -- even
when the change doesn't actually "fix" anything other than removing the
warning.

However, how about 'resolve' instead?

 timekeeping: Use min() to resolve Coccinelle warning

> What you want to say is something like this:
> 
> Subject: timekeeping: Replace open coded min()
> 
> Replace open coded min() because $GOOD_REASON
> 
> Discovered by minmax.cocci
> 
> $GOOD_REASON is not 'coccinelle emitted a warning'.

Removing a warning can be a good reason in itself to refactor code,
because fewer warnings make "real" warnings and potential problems
become more noticeable and thus more likely to get fixed. In short, it
improves maintainability.

To me this is obvious, but I'm happy to add something like "refactor
code to remove warning and improve overall maintainability" to the
commit message.

Thanks,
Thorsten


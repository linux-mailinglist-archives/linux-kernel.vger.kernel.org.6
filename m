Return-Path: <linux-kernel+bounces-283646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B61794F744
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F861F21AF3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A3818E772;
	Mon, 12 Aug 2024 19:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilkrG2+c"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B9D13BC02
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 19:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723489758; cv=none; b=R5Rwu7gH3f5aZBOw3C4ETIhAFnM4NBDvhvZ+SsLetLB4jTr4umkr26Vgm2jUHwmjbpB5NLMcwsI5fzwmafBeMJdoqEU5SB0VLpb/rrxrV+BjmlPCRXBwK26idgMI1F7KQyfDluGZQFS0tfsO78vFulzfuYQg98PVYEez9ChPcak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723489758; c=relaxed/simple;
	bh=7uvpmIhxbIocfYb/hMv645GS82LikhuM+Q7oY8y/9QY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VByk/nMrugS6CgbykKhhym13h1IlWd2ijLMSMrKvrKxOx9EGhbmLjvvgeQ67h4/4MB3FewAGYQHs5MZwyn86a+YmmOAKhRBRPgVuisUOwN5F+7KxuW/oP1aaF/RESpFKEUXgvksiLZBZihbhUM7IczYGWDkELoL9/L9j398pzuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilkrG2+c; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bb8e62570fso5698038a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723489755; x=1724094555; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkXHg/pBTxMP39Q++aBgkiez1mlXNsid7wQXSGrgxwk=;
        b=ilkrG2+cNNRGWgKTo0P5P+fL9bKFmv2gpNyzD7/5HX+FkHIauPFyje6i4qTfqbl8+N
         7ZjFoHevLPj7krwgrAJhRJh0C6IQAracXRUdXiSTGC4hprZtjsOHCSdE1SJBAQEujt+h
         7102tn4psxfL3WuvjOHfW+aeUwsec2q0BWgx2ttgPhkrLG4NfstQvM+gvhnwd4v1uMko
         5GyDMBsKuH78IZiYx+peA/ocBjfJOtWNM+sAvDEyDNI59p7WBKk06xJ2T/hLuNLhqYmS
         6VEeoiQnKBuWD8ncSLDJScmFq46E+pa8W0uhKf3AqhUaDR7HNQF2PKzK5PN8mnYkB1WG
         PVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723489755; x=1724094555;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkXHg/pBTxMP39Q++aBgkiez1mlXNsid7wQXSGrgxwk=;
        b=PbuId76SklOJNti5hzBU0Ly+O/4sD507D06o64MMKGdbIPfjYbKLJRpaPE/LNAdw04
         Io1T43gJgpt8cgQYeUse3szPJIPWWTPCglYEW4Obtvgn6b5BYvTzoJ6ouap2NqML8lQb
         Gj/EeyGkq9UBmEynDN1tnKXii/ZNFXlu+QLF08IrQua4cT9Ss+gmmmzdN9Ufc0YdHC7R
         fKdRw1yb8NHFNIz+5NEsvPVI2rGvqKfP9UnLtdNTUvjnC71wc1Ashm3hWJK33e8dmhON
         CUSYujoZxD3LQZX0tXIoTbwd3pF+DxOsIi41twhxb2cPoUGFMv0S22tSZ5tmZipOdm31
         h+vg==
X-Forwarded-Encrypted: i=1; AJvYcCUGZb/U4LIG0S++Ihgv2Ee0nLQriNy9jMSfO7IitNL1SFxi+zdpYjYyvDJrYqyUlVkvmf1MM1DFF4z5/9P/nI9v5zRxzvfX05XNwdOa
X-Gm-Message-State: AOJu0YwfLRvpqHnLtobhNYppEN8pD4MidbOwwFGHG8hYCmEtdNUsUOdp
	hjTz0jdUdIs8sg4+yLXiSMKSAs+8c8SPmYNzQooUJ84cqYyBlZJxxs5K8Q==
X-Google-Smtp-Source: AGHT+IF0aL2sV7fWpzA0EKx+TXDHqWWnJ8VWgTzpRVweZBkiQQXgT60/GxErjheVWLBeOPJwn0ehwg==
X-Received: by 2002:a05:6402:5505:b0:5a3:5218:5d80 with SMTP id 4fb4d7f45d1cf-5bd44c409c1mr700223a12.21.1723489754238;
        Mon, 12 Aug 2024 12:09:14 -0700 (PDT)
Received: from smtpclient.apple ([132.68.46.55])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a602da2sm2511882a12.93.2024.08.12.12.09.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2024 12:09:13 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [RFC PATCH v2 2/4] percpu: Assorted fixes found by strict percpu
 address space checks
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20240812115945.484051-3-ubizjak@gmail.com>
Date: Mon, 12 Aug 2024 22:09:01 +0300
Cc: "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>,
 Andy Lutomirski <luto@kernel.org>,
 Ingo Molnar <mingo@kernel.org>,
 Brian Gerst <brgerst@gmail.com>,
 Denys Vlasenko <dvlasenk@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2EF46123-30B0-4A7E-9414-EE25CBCF255E@gmail.com>
References: <20240812115945.484051-1-ubizjak@gmail.com>
 <20240812115945.484051-3-ubizjak@gmail.com>
To: Uros Bizjak <ubizjak@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51)


> On 12 Aug 2024, at 14:57, Uros Bizjak <ubizjak@gmail.com> wrote:
> Assorted fixes to prevent defconfig build failures when
> strict percpu address space checks will be enabled.
>=20
> These show effeciveness of strict percpu address space checks.

[snip]

> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -1231,6 +1231,6 @@ void devm_free_percpu(struct device *dev, void =
__percpu *pdata)
> 	 * devm_free_pages() does.
> 	 */
> 	WARN_ON(devres_release(dev, devm_percpu_release, =
devm_percpu_match,
> -			       (__force void *)pdata));
> +			       (__force void *)(uintptr_t)pdata));
>=20

Since this pattern of casting appears multiple times (sometimes slightly
different), I think it would be best to give a name for this operation
and put it behind a macro.

This would allow both to audit the cases developers move data between
address-spaces, and also make them think whether what they do makes
sense.



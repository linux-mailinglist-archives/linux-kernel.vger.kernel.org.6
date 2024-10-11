Return-Path: <linux-kernel+bounces-360346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A00E9999E0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 03:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B8D21F23D38
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 01:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0547A17BD6;
	Fri, 11 Oct 2024 01:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrlogXWC"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A22171AF;
	Fri, 11 Oct 2024 01:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728611824; cv=none; b=UC0ItjqxtjMYFUjAkAaLs5qvkr/DbeHBZeUNc1aLL3DVkOAxNV3pK/DuYhN9DO9zGPDIx/LOxGtYkLgJgabtbHCxuEdJyvwGLNTw1ypAEHRmGiupFvrdzuhAGQ0VWtLSpfMk+tj+E7XFcXMtrZFPz/xNWiBMtSrmUvIkXf1okC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728611824; c=relaxed/simple;
	bh=xZiUD1F8+8hOMFDOimFNVQlFWhfsipTnTdbeOQnFycs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=hQjJIrYC54yanX3f3UwgesEP9wT9Ixk6QL1+g9UZzy/9M417IRRixt0wFUztg/RndJ0UBsxd3B5X3InXSaJadhurDgiMVlm1GrRd5cBooOn10TiUNUaVpHtErIqal6YUoRxabEw+x6M13XbVBU/zSIw4+6OKvhaFLV2dDSsUdHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrlogXWC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b86298710so12806085ad.1;
        Thu, 10 Oct 2024 18:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728611822; x=1729216622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtBaAoSYK2l1/NrVwYYW0HjZbRAs+I+XEhcCydhFao4=;
        b=JrlogXWCDVNOb58VZBKwQFVHgayXsgCqEPwsjW9hrU+qauQB2tWDJrGxhYzDbTg1sK
         ulMsyLXtpx5OmmGO5AZtBTxTO9VuNkQu8be58fJbHggFcq20uJ5XNjGjRP3N/WR7rdFJ
         VNVFQstPgslLCE49fx/vUQqvRKh0cCxnzud4KxVCj/O4bBBgFTuH4kr8FRF61DMcaj6r
         jXr2H1dXQnVoBWAbQrQobrKqhG3kFtVaXoDLbQXw8Hbn7ahGpGxfsspoRzLygMYG7Oq/
         docijkfeVfs37z/CJS3D2x2J6hJxXEz78F+NO8gTdVK3ajlUt2wxCG6MuFLCXL7zpmai
         F7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728611822; x=1729216622;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CtBaAoSYK2l1/NrVwYYW0HjZbRAs+I+XEhcCydhFao4=;
        b=mVgQbLWTs7CaAANyqUXBiy+1C75hE8HHE+XRBRs7sFIAz/VhDaJOw7RfXAUl9hHgZJ
         OnAmJbdP4dJ9g2/qnXg3TGpFf16lZoroTnZ/TVQE7ZEX6vr34+mJ1W5+jQz9pCVzCZyA
         Qb5biyMbm5r1MTz5uOnqpxZ5km85HFWK9t/TTWzcSIfcOdncl7TPXozQEh9YPQMGjtLZ
         W6K2TD9i2Z1SSTzjpqNM4+Q+JR5FH00Od84zUX1bSz3Uy99gkNLha9U7nHB0o33QRsPP
         RqK7HbvfUBO2Kz7FlHncIhlOIK2FveYsJX3jSVwKUHykO6vF+Ep2Wbz13A/EaaB8BgDp
         Y2mw==
X-Forwarded-Encrypted: i=1; AJvYcCV72J50dNGDBEnAsvrzjpHiM8p/naJaBnnQqCNKkxczZ+7YYoC/nRLS1D1NpbF+bsQaw45beZ8Gk1jHTbmP@vger.kernel.org, AJvYcCWSsiPUOpW6rLwj8yuMCgcPXS0tWJ2dm44RIH/mYm8B+o/QN7fhldh9TK0OutJNb1H7HUml/FZUHkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzv5hpQydtuhUmKU31cKk+WQC3sZTptvvLj2XcW5xlt2I35fEg
	k25PoyMhgzZfZL/wOxnpLMB5Vv/cBqaUUK0OtnCizx9WQnGsrlAt
X-Google-Smtp-Source: AGHT+IHeObBOZkcDrupjYHF1PJnFhjX9zBEAO9WF9umKcXO8XkfQS9PV/2odEHrSsncf0xmuTfSIHA==
X-Received: by 2002:a17:902:f709:b0:207:1826:2f0d with SMTP id d9443c01a7336-20ca16f077dmr12283815ad.59.1728611822126;
        Thu, 10 Oct 2024 18:57:02 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c215f0esm15364775ad.219.2024.10.10.18.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 18:57:01 -0700 (PDT)
Message-ID: <fc144f6b-ad35-461e-a8a0-0395c9e69b46@gmail.com>
Date: Fri, 11 Oct 2024 10:56:58 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: corbet@lwn.net, jiang.kun2@zte.com.cn
Cc: alexs@kernel.org, fan.yu9@zte.com.cn, he.peilin@zte.com.cn,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 mudongliangabcd@gmail.com, qiu.yutan@zte.com.cn, seakeel@gmail.com,
 siyanteng@loongson.cn, tu.qiang35@zte.com.cn, wang.yaxin@zte.com.cn,
 xu.xin16@zte.com.cn, zhang.yunkai@zte.com.cn
References: <87ldyxb6by.fsf@trenco.lwn.net>
Subject: Re: [PATCH v4 RESEND] Docs/zh_CN: Translate physical_memory.rst to
 Simplified Chinese
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <87ldyxb6by.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, 09 Oct 2024 10:15:45 -0600, Jonathan Corbet wrote:
> <jiang.kun2@zte.com.cn> writes:
> 
>> From: Yaxin Wang <wang.yaxin@zte.com.cn>
>>
>> This patch translates the "physical_memory.rst" document into
>> Simplified Chinese to improve accessibility for Chinese-speaking
>> developers and users.
>>
>> The translation was done with attention to technical accuracy
>> and readability, ensuring that the document remains informative
>> and useful in its translated form.
>>
>> Signed-off-by: Yaxin Wang <wang.yaxin@zte.com.cn>
> 
> So that is not you.  If you are passing on a patch written by somebody
> else, you need to add your own Signed-off-by tag as well.
> 
> I would love it if somebody could review this...

Not only that, this is not ready for review.  It can't be applied by
"git am".  juang.kun2, you need to use a capable email client.

As this is "v4 RESEND" and you've been failing to see the problem,
I'm expanding on what you are missing.

Excerpt of email header fields of your patch:

----------------------------
X-Mailer: Zmail v1.0
[...]
Mime-Version: 1.0
[...]
Content-Type: text/plain;
	charset="UTF-8"
----------------------------

There is no "Content-Transer-Encoding:" field.  Unfortunate for you,
7bit is assumed by default, which is incompatible with UTF-8.

A known-to-work option for you is to use "git send email" for submitting
patches with UTF-8 charset.

It will generate a proper set of herder fields for such patches, e.g.:

-------------------------------------------
X-Mailer: git-send-email 2.43.0
[...]
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
-------------------------------------------

, which should be good enough for "git am".

        Thanks, Akira



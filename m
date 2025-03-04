Return-Path: <linux-kernel+bounces-545565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83512A4EEA4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF573174BBC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BD4276038;
	Tue,  4 Mar 2025 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="F4hb/6xW"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D9B2620EC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741121088; cv=none; b=D4zekhzgrpenZKHg82J5l54OC0yWealWNcTBn0Iod0YYbtS2Xryvdz3aKUlreIxn9s7e9EU0PfIi1nz2BZY5+NVa5pDMpNcRySuKAjCziPhTR2hwqwpBQcCkCrw9R+lBtgfRtZFqQfjGAkMfzR7B+GlblQsDY2AdXWZShDLabjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741121088; c=relaxed/simple;
	bh=idw9ZvilSuHtkU6iOnnuLXF/HG3irgXsN8QUX4wGQ40=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=b1O107b9/yJ5/Y7jgMXzetQP1i7q4qc2l6eft8oUmIFf1IK8KehlxF0oHHOtaKwnFH6AlzER/IDgM00pj8pIcA04BgC9MBdTqtjWzKAPszol7PF4Q9+io/5ujcCoqPkiUb7ZWxrYHbDUvIwjhOV8UnJyjLvWVixCFKVGsnLZV3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=F4hb/6xW; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c0ade6036aso20575385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 12:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741121086; x=1741725886; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wnI/HKF2BJ2DE+F3QNufti1w5M0knTrq3arpcVmTfsg=;
        b=F4hb/6xWGLhLDHF3UhZOHuErDzYxnhnVmSq9HN6T4P2QJ785XmOa+E0OVe2XuN96ZQ
         MILoenHIICKuuWHkCMNYV6oeqKBbkq2vp1hFDxTSyRuYH8F493BRqW2nTjnscFuTY60U
         EPFZoiLtyICZB6kLDiD4wUe8KkqWGyNUzODgyAQsv2TNyUkXy1NZSbFF/WMl7/BUVBV4
         9jWECoqm/qwkBWPFxv5DsYMXnctANS7ixZzWCCMoPtY/Ql/v91h5/7LsOZC1dpeg90Lr
         CQD5eOA9axsvz2VLACYozFq+JrgLb4b3+ryO8BVAguCbwBEs7B3fprOvZr4Mxi4K4x42
         Li8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741121086; x=1741725886;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wnI/HKF2BJ2DE+F3QNufti1w5M0knTrq3arpcVmTfsg=;
        b=GEQI+YWe+FANsn9tjmMK3jXhL867Re35FkGYj7o7sIZz5TegInP497d7mm7MyfSmsb
         pvk3frQkWmcL8Q67fpcEFnBW8YzNxwyWt9HxA5WyY2ifSB8ITP9B8zDeBFln3uNgJBXq
         rNLq+1tnRXMu7GYOKAyRTBPSfr+ieJ8RCRMWVv+Xx7Wa2VG9K37fb7+LOeBljfvEKEqI
         6cEdNuaDfhfLNOtoaWZxjuNw1g/0sL+jA3PDsuV9p4oqJuzXNan3fhqCXXel59pv2lWI
         EVUvTcDKuco+ti2jAtYuLWsZj0Kx7CCzPx+E+/nCzCUlHoOK65Am1ml7c5vRDrDWPKWR
         jDmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrWNdFZVlOrRxrz63qHiHRLZUUj+joX7fQIKHuiSKf/079scJP7rohCu829IeayskgIeynDcGRY7ma+mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycchg2O2dsPxpvSOdpiG6+bK+rY6YR1jBji2hGmOT4z2QWEHlB
	4dqDmZ8hwT1tLl4gpnk/a1u0JzLlka+ixTPfc+D0OI2jSTHssbkm1RtcaK8ejg==
X-Gm-Gg: ASbGncso6pCpTYD0fNkuQYCbS5URbXm6hiELXimLZrvYe6XoQJ0rZrRaP5S4bNj31xQ
	iy6Y6FflBPJ7k9aRjU2XIDvgG6/Xz5hu7rdpIlZHF5OI0RwrUAf5jnOKlatnL9RWnolOlDfZ31y
	LIh169gXV/HmdXSHF5PTzx1pfEXMGq4Trf7n8lWz9v/wObzlaMSpeOoF4SeQKmKb9h7FBRHTJYM
	e1byhMbn3HjLjgbecLGCW1JqUVghVuhACTh3h6GlOSBzUkCir7SD6kxvjxJYETba3w6aNBh4Oqy
	FTCAqzVk2JXQacwqiXz73T6CB0f6HIADpacGgirhgN5NqS/dK/Cc9WW5Z1OU613h0GFYq6Q8IJj
	pC6rgk1jGV8aMKg==
X-Google-Smtp-Source: AGHT+IHS4jLQv2ArJ6GHx3UL9v6MsZDGfjsA8pdO/0HW7TnyapGyetgLLGkaTBXzkDVSJZ7Yu3DODA==
X-Received: by 2002:a05:620a:2b94:b0:7c3:c9e5:e4ba with SMTP id af79cd13be357-7c3cc37aacbmr691510185a.29.1741121086214;
        Tue, 04 Mar 2025 12:44:46 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c3d8e51df2sm21617285a.94.2025.03.04.12.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 12:44:45 -0800 (PST)
Date: Tue, 04 Mar 2025 15:44:45 -0500
Message-ID: <c4d75f7666dac40277a9504fe1754f5c@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250304_1539/pstg-lib:20250304_1539/pstg-pwork:20250304_1539
From: Paul Moore <paul@paul-moore.com>
To: Alice Ryhl <aliceryhl@google.com>, Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, "=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH] lsm: rust: reword "destroy" -> "release" in SecurityCtx
References: <20250304-secctx-reword-release-v1-1-e8e9a7ff85ba@google.com>
In-Reply-To: <20250304-secctx-reword-release-v1-1-e8e9a7ff85ba@google.com>

On Mar  4, 2025 Alice Ryhl <aliceryhl@google.com> wrote:
> 
> What happens inside the individual LSMs for a given LSM hook can vary
> quite a bit, so it is best to use the terminology "release" instead of
> "destroy" or "free".
> 
> Suggested-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> ---
> This patch is based on top of:
> https://lore.kernel.org/all/20250304-inline-securityctx-v2-1-f110f2c6e7ff@google.com/
> ---
>  rust/kernel/security.rs | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Much better, thank you :)  Merged into lsm/dev.

--
paul-moore.com


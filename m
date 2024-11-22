Return-Path: <linux-kernel+bounces-417918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013DF9D5AB7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB8C283A77
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463B2189F32;
	Fri, 22 Nov 2024 08:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnCPeqTp"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3586722075;
	Fri, 22 Nov 2024 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732262996; cv=none; b=eE5j9PV2ZBrA6MfmQ35z9iNbcCA2uNRtuXuzT90jAlxGkmjZqlTdb9HPWYJLYJWcI8KqV30m84tZ2nL3+Xx98pvrhkmnecgcKlMUQPacliu81fkmP8NeqdlK9UwZg5UNCOo3IJ6ZYtdghqLPKsSgW19qU+ToiA7YjvwA54M4/KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732262996; c=relaxed/simple;
	bh=1F3WBFGPE+8l1ot5J3aP1LGTc9TvvB3m3qvwqL+bzUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQdWgsNgbIzxCt+5j+SvdFaaooc7EsTAWnIllVYoakNMaKB9C+0wJISYDEJy3GyWhjpX5PrKZ5aaHNNOrkFbm2SICkSZ8vu/eBq0VLJBRpNAbI5tDOSUcgCsAWGdCyTVvMC2wmJOd6ZkbkaUUMvsfM5WzWU9loIi0/JqbS0WTI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnCPeqTp; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e4b7409fso1889189e87.0;
        Fri, 22 Nov 2024 00:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732262993; x=1732867793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3pLWmJxBRV5wsiL9qha43ITKedUfMhF5iYbTNJojCIs=;
        b=RnCPeqTpEX1mqmJMtLqL5O0tGhRzXRvB4gWIQeuPCRucs5JbkiSPwY/tlTsthBBAbG
         m9CcyvtaZzC+fV9nfRLyZyM5YvgHa15n9Sz98olfW2LRJle34FZsHfdIyjzHeNW1T1VP
         cPHgUc04i12///l8wGaqY2rPcLLjy3XBJlPojtl2TJrqnYYo+bj6nbuWClKtwlbYwDVK
         uGEVnVugsA2G+28vg7Fc0RuvC8KDbnSdkL59Qc2MEGU0CGAM7cVIk13aWxUd4acwdYTa
         BHAr1EIpZmdopWe8JC14KDwWJGok8iZY5D7syKKTJXHZHSD2NMZJ/oei3/dhOidSParR
         2+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732262993; x=1732867793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3pLWmJxBRV5wsiL9qha43ITKedUfMhF5iYbTNJojCIs=;
        b=YjByJmYWey7PJHDg6CJ0M7sKHOrOgFQxI5zBUH8MkJAZuFgtACZDKyooDTCE/T08qu
         XGtgT5fevhkNwe/IIQ9gXOKP9El/bDx5RBqs9v9IT1BSIR/ZlwEl928agxKWdbJCFlzS
         EhvJOLVuAjs8UuQL8um1ptlA0p7OtMkAJWT7G8gEOZx7sP8YTk1gLvumlOwOIIy/q/je
         HDjKrxp7uJZMxI8G8j5Ho0miwilKFxX1uLpY6cD/EhH/OohEAC4+h42+fhwpffj4q2Vl
         D+FFnUm0I9kAiBABFI5ymczNs3ra2CS3QcIPM+fJVoWbSw4rm/nbU/TyJ/H0+Y++ZARC
         i0Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWDjLCOnoT4kEkndmurU1/M4HH8XFciK77ywZMzpNCMTvWeG1JdzeZ9ym6LWFtFwO2GH6cqcXqgi/c9yEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza1ihsGwQJUJzR4ieRfKQJqekM9dJjRkbL1eAvuB29YP2iaKD9
	rPH3SXZ2oSUn34o6Q1mgODTWt+9VHbK0SEq0/QzOMv1PS7kADv03
X-Gm-Gg: ASbGncsuRCxg2fq0ZQ/Q/owJ/THsq/MjkCk4fUpeqcQkCLdR26iHZMNcwVHxIqGkYov
	wYc8dsGFgEs60DFW/s+cuc8Fv+VYfZ2mk8ieU2Y3yBgaYmOrIHTEuPxJMDLZH/0/CWGjxx+nuWh
	oavTs6OvVVZJe+ZL42uCaqyH8agICr4iN7jX8XvXflWwZTe4unN2GAMR1XFAATJXGJVeujDW9l3
	U5MqbunMq/ngkj9fNOK1m5vQSVXVT7Sozz2guOm3qgUBdj9j36mBff6Vni2MXkmVX9nU5hMzOsw
	hL81RZMfR+5kflhpt4JW
X-Google-Smtp-Source: AGHT+IF9f8FjoZJkYIQ/sAYs81J/YYuyIbxRnRdtrfF5glPfQG0UjZvivPQNO4GT17FSFb3XXeaPZw==
X-Received: by 2002:a05:6512:3e18:b0:53d:c287:338d with SMTP id 2adb3069b0e04-53dc6182e9emr1946973e87.17.1732262993099;
        Fri, 22 Nov 2024 00:09:53 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2481e86sm270678e87.129.2024.11.22.00.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 00:09:51 -0800 (PST)
Message-ID: <1cb1a118-7cc2-4ba5-bf56-b51bfd84cd63@gmail.com>
Date: Fri, 22 Nov 2024 10:09:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] rust: page: Extend support to existing struct page
 mappings
To: Jann Horn <jannh@google.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, airlied@redhat.com
References: <20241119112408.779243-1-abdiel.janulgue@gmail.com>
 <20241119112408.779243-3-abdiel.janulgue@gmail.com>
 <CAG48ez3fjXG1Zi=V8yte9ZgSkDVeJiQV6xau7FHocTiTMw0d=w@mail.gmail.com>
 <43a07c04-2985-4999-b6d6-732794906a36@gmail.com>
 <CAG48ez1uzoEcsFG7Tsfj2WCXor9-mhffoWO8VFoit3j_mUC7-A@mail.gmail.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <CAG48ez1uzoEcsFG7Tsfj2WCXor9-mhffoWO8VFoit3j_mUC7-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/11/2024 22:17, Jann Horn wrote:
> 
> Does Rust also prevent safe code from invoking inc_ref() on the
> returned Page reference? Normally, the AlwaysRefCounted trait means
> that safe code can create an owned reference from a shared reference,
> right?

While it is possible for someone to *manually* convert the Page 
reference returned in page_slice_to_page() to a refcounted Page (one 
could wrap it in an ARef). However, by design, page_slice_to_page() 
explicitly returns just an ordinary Page reference. We could add an 
invariant in page_slice_to_page() to warn against such usage just in case.

Anyway seems like the consensus from the other thread is to avoid 
refcounting the rust Page abstraction. If we go with that, then that 
moots this issue.

Regards,
Abdiel


Return-Path: <linux-kernel+bounces-519680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB43A3A0A8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49A943A1411
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D7F26A1DA;
	Tue, 18 Feb 2025 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+17lSJJ"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B82230993;
	Tue, 18 Feb 2025 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890748; cv=none; b=Y6FRlNErTFTUDU+9M10Fgbux54iV3ZQq8vRqGQydD5viGcrRzC0CGAqRLwV9p+wxV3utL0/18TmlLihK2C8DEY2sSKOyy7CiBZwvWdo1NdXHxj0fScNqd67XDQWMpAXPNC2Mi8eu6EmN6cu21nmuMCAb1qnxLd9DO8MVEZoDKgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890748; c=relaxed/simple;
	bh=bnikpV9vWi9NNkaOO5T2BkhMOZejMFIE+U6Sht1hRz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZBAZl0Mp67VMwHpPGZur1UDUta3Ye6zMe7LupbxP7ZLj23Btoz2c7ydh2vSkeNWqMW69qkzEU2Z3VMTiSm29BrC3wiLFiCvhvvjU4iwg+mp7CH4Gb+Rqw8tIWQBclwIqe1J9jZwFJsRN2eIdSth201/w86yz5FgmUKXLZtapek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+17lSJJ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so4763816a12.3;
        Tue, 18 Feb 2025 06:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739890745; x=1740495545; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAIrJ/LjqF3PZx6DSjpQeC5ZYl3v6fqCgyrURh3Pa9A=;
        b=J+17lSJJJZV6XYaNvDoZnUqKennHU25+JAVcQYkAf4xR2ArI7a1+tWfBiabekEN12o
         2APagjpALlhuvrVSrXVNozP6cag+wB60zWG0v7snREqpVIANSYNBwQtWBOqsZivpr/8E
         UPnwkvLTd//j+cOexX0GgnagJkB3DYATLwiG1jIPsm1SO8Lx3/vQwh1Rt6L//bbHYjXT
         dtD4bcfgBDR7kq80QpRH8x9d2Jda7JRtX276BnqiYTZlp3mHw4SMm9pmz7BxwgCBgpOK
         TPE6YG3211C4g0mdOtTbLsgdIvyvHB6lpx3wKMLZkGd7EZcMkHJm/PgDpB734am2vE/u
         5a+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739890745; x=1740495545;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oAIrJ/LjqF3PZx6DSjpQeC5ZYl3v6fqCgyrURh3Pa9A=;
        b=Q3C+VL2/HqwIkpKibPbak+cQFetupyQKZpLGWmZShgy7BGvF4jvrQkpRyOTXyjWO18
         uU5eUbankhn7lBzdyL+4Q4TMkWrlM+/JeMOIdeKv+vvw+CZ+YqegN3E5oFLRIeIEU5Q7
         rJuNUS4ZnQu3/taKLodlDFg5mZJZ6oHmzPn1YjlcMUPn7Hkp/9Bu+IXFWm7cNblOPC6s
         f/m+aFA+cZlllEto/5JOea4iOr8iWTEVGiX7b/ShCPD3XSRfpzZoILPAPSLjrE1ISvx8
         bdxgUqTC+0Xsvi/6gD66jsyyuJKnudfqudHoO669fBdsLxyiq+OacuGduH5Dwby813rv
         cCKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFDadNpSkTCqeuP64rDNUMIR/tpUvGzkBdD6+frD1rWe/RFgd1rdSF43JxQx4CA945avAR5q42xmbg@vger.kernel.org, AJvYcCXnouf1tAgPE1NaM1dRRZVL80ICcvaXrkr4nejjmK/I1AIXJErpSBGj3MB+Zp7f7k6QzVOUtVVrW+8H@vger.kernel.org
X-Gm-Message-State: AOJu0YwTTMRqzUEyORSoJFDbktYZSdwtmqtPvaJhxXzhBUNwjuCbiVBe
	sPwUIj6IZal7N5E59YONm74aMILJ7ILAOTwRwNfwvHwQ8xLYPzVh
X-Gm-Gg: ASbGncvtIjbh3p0B3CMer00wBTH4tGxKg36Hxr3u5DaSvTgqJVA396a++JtnknzY6I7
	xZqk8esVW/1FNQ2PSBYpOvC6XJe+bRCNsHfBA3Mf/IxSyIcuwpcoM0/lzh2xhXoot/yh81Ysr1h
	Bz87DlnveSi/Np2xaQpYXmiaaCpGIxImAFOdNQxuKcz11w+uRr+4H664W9jdk/EfiUW1O5Bqyqw
	MkDXsQv0sXyo1r27KFxl02wGDsFTdDq0k9TPngP/YZwtc1INLm6MNF9dA0+I4ntL97sQoDiYjm9
	BVtTOAZ6oiMnE6U=
X-Google-Smtp-Source: AGHT+IHfGUb6DAP5PY1vAqYBMMTlEpLIKDLmvPxJw/HfikZVPdieC7mOeVaDwsd2Oi5vIHAKZzcd1g==
X-Received: by 2002:a05:6402:2386:b0:5dc:6e27:e6e8 with SMTP id 4fb4d7f45d1cf-5e036139cb5mr24069087a12.24.1739890745271;
        Tue, 18 Feb 2025 06:59:05 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbbc841eb0sm121224966b.128.2025.02.18.06.59.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Feb 2025 06:59:04 -0800 (PST)
Date: Tue, 18 Feb 2025 14:59:04 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 01/14] mm/mm_init: rename init_reserved_page to
 init_deferred_page
Message-ID: <20250218145904.x57chhz3whvckzu3@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-2-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206132754.2596694-2-rppt@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Feb 06, 2025 at 03:27:41PM +0200, Mike Rapoport wrote:
>From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
>When CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, init_reserved_page()
>function performs initialization of a struct page that would have been
>deferred normally.
>
>Rename it to init_deferred_page() to better reflect what the function does.

Would it be confused with deferred_init_pages()?

And it still calls __init_reserved_page_zone(), even we __SetPageReserved()
after it. Current logic looks not clear.


-- 
Wei Yang
Help you, Help me


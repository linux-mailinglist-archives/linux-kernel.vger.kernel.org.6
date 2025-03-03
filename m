Return-Path: <linux-kernel+bounces-542780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6540A4CD9A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8430E18929A4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FA223643E;
	Mon,  3 Mar 2025 21:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NjTUyC4t"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BBC2163A0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 21:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741038056; cv=none; b=fdOHr2q62rRMHnU5VAt7YC98ki1ELo0fvxH6b/BitJmK2qww/cfX31upkfzDIXlbtYHWE9kzgO6KbB/7a1ZuqyGTOc7WSL9VYyjui2lPCaThloYOl/d7SGddohHRk8OUYC2Eg8ql9noMkhfToqpTxNAoDtFT1w85wpeZdDZcD50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741038056; c=relaxed/simple;
	bh=t48prv4ltqZBgmpiT8R/ZTVb9z8qZJulguu49one7U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IE4NgKq36k9wfG2UUuLjMPev7mEFwxsT+Prfqs1hbD51p25K1/yUiSt2UJb0hbejrIpPZBXssLsmBvjdYWB8l/4NHJmVY1OCTR87EH+8Vj+DlJO3awrz3cLf+NNEVQM7e06thL8/TOi31Ov8q5XHKmsgvpYmTQjXp5NMnHqheG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NjTUyC4t; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2237a32c03aso15755ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 13:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741038054; x=1741642854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=//CA4dP1gRO/1RNRixCqJrbqKaw0YXw5wU7J/MVaxKg=;
        b=NjTUyC4tnMMbS2ZkzEQu+tumClDu5ho6F4m5Q+WN1K2Va0/uPSgzO5AEhDDBekPa6L
         Dah8MBZnU/1mxnVqV0WmA7JTbWKPXkxxuMDFW7tVBm/Rv+0nTucILMzPqN4JE2iRI66r
         +QfJWlBg/iWxfeOt9MT/kyRgayw+yR3ksBXyZ42ySyZmAx9NbTgZpxiDDqpcDfJrJBVU
         wRyC6H1r76w+vpTCeIcOHPjg23ND8SxN8dqGGN/A4YGaHlmdZmPvi/BRk5Xk+u3sklBz
         efiGFYH6bQMtDebloPlYoTJbhviL+fdn5Uoet5qVvEjdHuvAGQGiU4Bv74Py3P9tdmK8
         XUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741038054; x=1741642854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//CA4dP1gRO/1RNRixCqJrbqKaw0YXw5wU7J/MVaxKg=;
        b=eL8Mvyh/orv8iHs+2x5w4tEDWCpgE3dYRVFq3omMf9nxtLbq0tOIp6vFzwVBKAm2oz
         agtyFeIn2vS/1hssjF/gL4IO5oFFuvihDr1/ER54IUhEPsAl5ZVwyF4zbRCyUbEAIKCc
         cbE4OMqaiknO2U//ZII8nblfdmEcti06btPXn6Dcx/iaxbVF1hM+zNruxhcGwrZALVJY
         H9ZTQh2LKWnC0LWaPafNgML4jGA499cSW2vpfOECJ6zkY1WuG9hI85CYkY4jhUCBmReB
         6zYzpfQAq0AKsC+DDkHh3M8x86oyS+2FIaNyfyI0F6FZfqDo5i8kLaue6kw3oEYAMVq0
         EXmA==
X-Forwarded-Encrypted: i=1; AJvYcCWp3ZE/OJDNWxuw526l9A5/kw7/ySm6copxf74pw+H8CTRzcghP5CdGW4Vl1Umy8kB2JEYew2F+E8i5bJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5DbAbMNGom4qlTBqWlUaDdTd13HAXZYDCvcSXkD5Vmr7mz8Mf
	T94MU8+FM6G9b99q0w61mK/ZtIm/50B7dYCbDm5I7edldmKf/aQhu2i7G83fVQ==
X-Gm-Gg: ASbGncvvxN5N7JjfC5e44lMPinAay5y7lx1aC6+KVIuT+2BBbrsAeGrTQY73MFyYkG4
	ihxir0E531wfCZjoCGbRzDfc7ZufditaRd6UdawpYsSZAroAHDdrrNwuDX/lZ4Vwb4pB4WxmIN+
	I2gheHyqP4wOMSZUPnZi4BFg7fO6HWy8ouBmW22lMFhMr8VXD3IqB7RL9hDALa54ykA3AJzIvNN
	KXuJj3q8+Gj71QFmzI7eQA6J6tBDT2LJi1IJ30VfDVpmvU5FgMv3OvNpq5I6Ot1Ynqmteq0qSlr
	x7Kq4SI65891+QcegusuYpBqWeV1P7P4Egj9Et+w25A4/vUInlLJifnub2gs6M3GkROQSHhhVXu
	BHGE4z/wBtrqgseM=
X-Google-Smtp-Source: AGHT+IEwj6zn3l1n1mEvrRIOd0S1KGWs/bgL/3cFaL+tQsr/6cABYrLinWLfgT7M2GWCtuDNAUdgLA==
X-Received: by 2002:a17:903:2592:b0:223:2630:6b86 with SMTP id d9443c01a7336-223db3fdecdmr77895ad.7.1741038053846;
        Mon, 03 Mar 2025 13:40:53 -0800 (PST)
Received: from google.com (227.180.227.35.bc.googleusercontent.com. [35.227.180.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe514besm9424721b3a.71.2025.03.03.13.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 13:40:53 -0800 (PST)
Date: Mon, 3 Mar 2025 21:40:48 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: peterz@infradead.org, rostedt@goodmis.org, mark.rutland@arm.com,
	alexei.starovoitov@gmail.com, catalin.marinas@arm.com,
	will@kernel.org, mhiramat@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, jolsa@kernel.org,
	davem@davemloft.net, dsahern@kernel.org,
	mathieu.desnoyers@efficios.com, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com, kees@kernel.org,
	dongml2@chinatelecom.cn, akpm@linux-foundation.org,
	riel@surriel.com, rppt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v4 4/4] arm64: implement per-function metadata storage
 for arm64
Message-ID: <20250303214048.GA570570@google.com>
References: <20250303132837.498938-1-dongml2@chinatelecom.cn>
 <20250303132837.498938-5-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303132837.498938-5-dongml2@chinatelecom.cn>

On Mon, Mar 03, 2025 at 09:28:37PM +0800, Menglong Dong wrote:
> The per-function metadata storage is already used by ftrace if
> CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS is enabled, and it store the pointer
> of the callback directly to the function padding, which consume 8-bytes,
> in the commit
> baaf553d3bc3 ("arm64: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS").
> So we can directly store the index to the function padding too, without
> a prepending. With CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS enabled, the
> function is 8-bytes aligned, and we will compile the kernel with extra
> 8-bytes (2 NOPS) padding space. Otherwise, the function is 4-bytes
> aligned, and only extra 4-bytes (1 NOPS) is needed.
> 
> However, we have the same problem with Mark in the commit above: we can't
> use the function padding together with CFI_CLANG, which can make the clang
> compiles a wrong offset to the pre-function type hash. He said that he was
> working with others on this problem 2 years ago. Hi Mark, is there any
> progress on this problem?

I don't think there's been much progress since the previous
discussion a couple of years ago. The conclusion seemed to be
that adding a section parameter to -fpatchable-function-entry
would allow us to identify notrace functions while keeping a
consistent layout for functions:

https://lore.kernel.org/lkml/Y1QEzk%2FA41PKLEPe@hirez.programming.kicks-ass.net/

Sami


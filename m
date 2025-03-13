Return-Path: <linux-kernel+bounces-560275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A86DA60171
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C12189766C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DB61F3B98;
	Thu, 13 Mar 2025 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAyhe5lB"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147781F2B90;
	Thu, 13 Mar 2025 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741894879; cv=none; b=GRR0pEHDzUs+aZEihxcpQ3JukvfwFQIJcoZD8nTgePL0/ebYI+5rrRdLWNFHctvv/Q8VGGy+ubOXv5+8rwB01yyeEBL/Zj0FNVqxfdNcqjKXPH6rkFjS2G04BdRdfY8axpm3AnQIQuNUhvlnG1zqQvW9sh52Up0OKqZkhryN7Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741894879; c=relaxed/simple;
	bh=WUH2ocflO1cNKNmhbkDZJYgN2wbCaTQAVsBuQZ+M57g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l5d5vgYtZGcNhXAbk4IZ+DblXpopktAwql7iEH80AME/Q+J5bETqMDdQ6ie7w7z1o4F/8LKM1/T+7kfEBLwJ0j7iFAIvNCOrDNt4ZIScFMKhm3McOCPLPz9BM2Fa9LZ1X8FXJ67D5ZOm/cn4O+FF5WNO1OAK+mtQA2Sk9aWt+nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAyhe5lB; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5e1a38c1aso1688152a12.2;
        Thu, 13 Mar 2025 12:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741894876; x=1742499676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FXEzxEd8+oNnzMOAtWoRdYumhlynnfDozmjfwkSl2KA=;
        b=MAyhe5lB55KauvkpIW17ZW5VLS9mjTjg+rfwtDww0VZ5ORu+z+bJ0h10PVruk3CMwj
         kfXMamr1J2V6RZNr3b1WXyYyTdI4an3RcvCm7mY+F+l+iDTYdQdweXLjtweLGeoZ+VLO
         414O1YUsP2db+So9s5DGeIR8TYuBZns9PExvRZfY9ldcuxl7RBA5duaYNiGanrSyhvFP
         HOAemBDr1aVvtz1muI6ybc8hEFOO1WqTw8Jkh2XTjgHqrMwyszX5q7XVnA433e+Tr7kD
         jmqgORXUT1JMtwJkus4Q+yXxtns1JKaJBeNpAyNF0VUOlJ12v70pc+UHbEdNWRQGAa6t
         NnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741894876; x=1742499676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FXEzxEd8+oNnzMOAtWoRdYumhlynnfDozmjfwkSl2KA=;
        b=ekqVkKmVc2AySKwffkSiQHyTxMtdih1hkHNvk+Ghs1P21s15mp2HODHXkTjhX1I77Y
         hgvHStMeJvVPf9ic10W3+xJbDV9KDJMtVXosbIhBPPab39pWZWtBzHY45mre9xDk9ikG
         Ov3pM8A8U/D6bI8EARj6We6bJbdRX0/PDG0l9joDSW2ZmIKttC2mupJ+5Fnxa7rC8xMZ
         Pp3cp9VKCcVWTc4DLh4xAwDFM0PETCOzHRxMpFlk+hOpIb+JzPs7NpHZvt/ciZ51FlR4
         SZ/yX4MHQiujgxx1/mUYnd76VppX0EC5jkaRn1BWWQc9dlRQLcGkzMnxVtMnvAkDcbBO
         nvIw==
X-Forwarded-Encrypted: i=1; AJvYcCUBioa0wGptYbcq6UDvVGYhtZVPdHP5Bjte8nK2eGL9ZGkwnYGlTInEOUWn8wlIkHTLYKVgjXMMXGD7izw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDK67GXNR/OR/jrIeDb1fDDqZpkvhGLYuQjyoK0bM9ZKdvIBgU
	60BmQqmKTuhUBzssFMurt4nkrMSltEt9O4c+StWgbPPsp1p7WEL5
X-Gm-Gg: ASbGncuhUC2Qt288YhyDouVIpbe6PsDybkpFEyyx+a3aZ7AtkZ2UVCgXalvNnJQqAXN
	w1UkOFVqGFtG/1ey3guM8pcl7J1wGrwaQsmdLKk8rQMYeF0XSi1gWcDbhVKUPZK3FDHpx96ob3W
	BpMwUEkA1oT/oBBsCIAOrubMWSQH+OmWI8LEMnakyn7H+vBIWsvnJijo0pbsBCLa9CPggjyQ6a1
	nThS0jQ5BOoQt/kZstbjaBdjQux+FQJ7yZofZgYkApON6qvmnal2iHvvUGn6vo6tjwdRTRE+hdN
	d4xApeKWNVR7fDq7H8QS5LlskRXqcvAGd1zAeSTEWWBck1UBG9aSa9SbxA==
X-Google-Smtp-Source: AGHT+IGVbzc4ZfepwBe4lwL/vFzF6ib86XY2NgsOo+OqcPI5LcBFDNIpsOtJiAgTucImNxYYSmd+dg==
X-Received: by 2002:a05:6402:348d:b0:5e0:49e4:2180 with SMTP id 4fb4d7f45d1cf-5e87c45f948mr637025a12.25.1741894875982;
        Thu, 13 Mar 2025 12:41:15 -0700 (PDT)
Received: from ?IPV6:2001:871:22a:99c5::1ad1? ([2001:871:22a:99c5::1ad1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816afdfd0sm1072154a12.75.2025.03.13.12.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 12:41:15 -0700 (PDT)
Message-ID: <9a516b5f-8509-4643-9c54-26caadc42348@gmail.com>
Date: Thu, 13 Mar 2025 20:41:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: task: mark Task methods inline
To: Panagiotis Foliadis <pfoliadis@posteo.net>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20250311-inline-c-wrappers-v2-1-72c99d35ff33@posteo.net>
Content-Language: en-US, de-DE
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <20250311-inline-c-wrappers-v2-1-72c99d35ff33@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.03.25 4:05 PM, Panagiotis Foliadis wrote:
> When you build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
> toolchain provided by kernel.org, the following symbols are generated:
> 
> $ nm vmlinux | grep ' _R'.*Task | rustfilt
> ffffffff817b2d30 T <kernel::task::Task>::get_pid_ns
> ffffffff817b2d50 T <kernel::task::Task>::tgid_nr_ns
> ffffffff817b2c90 T <kernel::task::Task>::current_pid_ns
> ffffffff817b2d00 T <kernel::task::Task>::signal_pending
> ffffffff817b2cc0 T <kernel::task::Task>::uid
> ffffffff817b2ce0 T <kernel::task::Task>::euid
> ffffffff817b2c70 T <kernel::task::Task>::current
> ffffffff817b2d70 T <kernel::task::Task>::wake_up
> ffffffff817b2db0 T <kernel::task::Task as kernel::types::AlwaysRefCounted>::dec_ref
> ffffffff817b2d90 T <kernel::task::Task as kernel::types::AlwaysRefCounted>::inc_ref
> 
> These Rust symbols are trivial wrappers around the C functions
> get_pid_ns, task_tgid_nr_ns, task_active_pid_ns, signal_pending, uid,
> euid, get_current, wake_up, get_task_struct and put_task_struct.It
> doesn't make sense to go through a trivial wrapper for these
> functions, so mark them inline.
> 
> After applying this patch, the above command will produce no output.
> 
> Link: https://github.com/Rust-for-Linux/linux/issues/1145
> Signed-off-by: Panagiotis Foliadis <pfoliadis@posteo.net>
> ---

Reviewed-by: Christian Schrefl <chrisi.schrefl@gmail.com>

Cheers
Christian


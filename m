Return-Path: <linux-kernel+bounces-303361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1B0960B2C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EBD01C22A94
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501DC1BBBEE;
	Tue, 27 Aug 2024 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bjJT72R1"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE80F19CCE7
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724763396; cv=none; b=nlE+ajAipUks5o7XToUvwvD2HueRnacPqjIGiGX+fqfq6Gat6C2+PYlGu3v4GxD2axWz2gpVji3pi38yVuTTV6wzjU2M6CY6DmYIFlAg+F/6D2l75I28kP/vrKOHQCU1Vtjy5ys1bpzg5CLSgvP1XTaArNAxprUb6POMJI9Fzmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724763396; c=relaxed/simple;
	bh=AknLauxDD1Mv5hAL7BethWIapkBYihgHPf4DYrN55VA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yk3pusuYrE3XyizrTgp/OelqkEduOqiIJMKmeofBFhGM7xI0s0F6woZOG8TSj+wtchN3Tzeaa3hfutn8JAgjhX1phnwoCAqBm53cIr8QdrfYCp/ugp9LGB0HdZEhpLBPpvkMDrdW7OTfdF/FxlDn2M/cf5szVg70Unl+uabNr8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bjJT72R1; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-656d8b346d2so3261664a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 05:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724763394; x=1725368194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EmZpKe7MLcOHNkgyeSYy3sZKtuvXgWu84ON55407EKI=;
        b=bjJT72R1JAy7wrVDoPBVNFssRR7T9zXNwX5HWIRKbQ9g24e16+pTomyS5wvDEyhn+Z
         VNSQobqOQFgPwZHJj3sM483v7oFqLy2zKgxxxTfWtDvx/WVGLjac1tWDyRpct8vm1LbF
         C4ZCHXLnH926rVR7hg5pzgzfdI0qlqtfCQu6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724763394; x=1725368194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EmZpKe7MLcOHNkgyeSYy3sZKtuvXgWu84ON55407EKI=;
        b=llHo73xB/TEVvE8drFiHUAa3JalhcJeIkkPmv7yxn6Wj0XVt3RZooCK+w+ovv6OU1d
         HEHforeu0Isv+zYHiyARvL0OTRVgYQUM6PDj234aDsthvDqgPrUT8SUqzWjKaIn5FU4X
         AiwJMQkHe7mDj6jP43UHuqQs8FQVoU3S+n0Fb/gka9+tEGCCcxCZnGfjdPN9cbUW2AY2
         LEyxT0XBsqIggAbY84Zf9oVIdSOzT0xTby+s0t7ai+Sfp4HgaFBXQbs4VebRHLkoaL3g
         ft5sgc4eB+sAnX6t6apOUbc0mWphvSMXwaBDPyZ/7//QEjK3VNbY/EzIfPw1doaXjoV2
         m3ag==
X-Forwarded-Encrypted: i=1; AJvYcCW+cY9nr+V7W/u0r4WlFxbWJGh9qPV+Stphhn/VD91WK/uglrKC93KQZlUjQUfowGuvM16x7gFUrwwHThw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxft87VFMYRgC7IfyKyRsmrJc94Bt4boDwYuTqCZtcWEP79Ir9/
	rV1dCdfx7AZ//9St7ZYMAPghNiejieCrMWunmOCEUukgmkm5fvPV0ceMEqPF/KLFqypGLLR1sXw
	TFC4=
X-Google-Smtp-Source: AGHT+IE0e2Vl8s3aYWqxRCmdsyFnR2yDhcsM4WIlUyT3P7B5c2RI3JtNjOKz1GUKgELwMN8aJHFX1g==
X-Received: by 2002:a05:6a21:e591:b0:1c8:b336:4022 with SMTP id adf61e73a8af0-1cc8b590291mr12710934637.36.1724763393933;
        Tue, 27 Aug 2024 05:56:33 -0700 (PDT)
Received: from [192.168.121.153] ([218.49.71.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb90c72dsm14260993a91.22.2024.08.27.05.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 05:56:33 -0700 (PDT)
Message-ID: <9de5090f-038f-4d68-af96-fbb9ed45b901@linuxfoundation.org>
Date: Tue, 27 Aug 2024 06:56:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nolibc for 6.12-rc1
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <3b9df0a1-7400-4c91-846d-b9e28982a7c3@t-8ch.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <3b9df0a1-7400-4c91-846d-b9e28982a7c3@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/24/24 12:53, Thomas Weißschuh wrote:
> Hi Shuah,
> 
> The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:
> 
>    Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git nolibc-20240824-for-6.12-1
> 
> for you to fetch changes up to 25fb329a23c78d59a055a7b1329d18f30a2be92d:
> 
>    tools/nolibc: x86_64: use local label in memcpy/memmove (2024-08-16 17:23:13 +0200)
> 
> ----------------------------------------------------------------
> nolibc changes for 6.12
> 
> Highlights
> ----------
> 
> * Clang support (including LTO)
> 
> Other Changes
> -------------
> 
> * stdbool.h support
> * argc/argv/envp arguments for constructors
> * Small #include ordering fix
> 

Thank you Thomas.

Pulled and pushed to linux-kselftest nolibc branch for Linux 6.12-rc1

thanks,
-- Shuah



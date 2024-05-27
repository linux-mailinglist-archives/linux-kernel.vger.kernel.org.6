Return-Path: <linux-kernel+bounces-191267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B82DD8D08FA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 19:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8CB71C221C5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF2315DBC8;
	Mon, 27 May 2024 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6CNCGDy"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EED6FB0;
	Mon, 27 May 2024 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716829235; cv=none; b=Vhm0bpZQ/PeN04fSEXHW3sxUFfI7MKOBGJUkgZ3vuw5xsbNopZonOWJ6h9hyF+fOwR4gzNMD2bOs54GUEMO4OpGlJaCS/ytKbnBxE0z0vYq28smxDrlO0o+hhqieh7yXvkR9DX0NkvOVcWUjnConVz5oepVgxpMMm6r9MHNAG0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716829235; c=relaxed/simple;
	bh=8MLNb2bRcbp/oLUAripV2zX69ZK7bOk3ntrl8bKbv7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2ZhoKwUzGGa3mp+UEs3F67+Lb5VzPJPeED3igy7rL1yrPECpRcdMPAw4HyZUXWuvokewUcITymDgOqIIM3yGDEkQKnultZ8T35qLRl1tFrByE2SB6mhXueMvu6UXO5YLMTNqcc9ICli9RQ8zOpXDfFMw3COSCZphD9lY2wzRt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6CNCGDy; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f480624d04so13909515ad.2;
        Mon, 27 May 2024 10:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716829234; x=1717434034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pnYD2vB9if3b0Pw8B9yj3OZSPzEecAxuxqjy5zfQk70=;
        b=e6CNCGDy8hNGGL2YZWY/ZvWRPvuMMRYYv6VePDFcYjkxkpX0dENQEhCThcSHWgmrk5
         tYVgo+STgb7JonTXR7fXAv7t5yALRiivIOvAqTzA79lsEGCsMHuzjjvo9M15JtsbjEHb
         iSPPzr22fNUXppwm237sbPa38ZVVLafhzKFejn8W6Qh4Fg0iK4p1vfrWOI7QzffalM84
         PoXlpVmHFPw+dg1IJTEtu8CZhnCiHcibvUJtcn6wXIkZxH+j3uAKpLIbCtxXHO/+h7tR
         rm9jjcF63yyQ2wZMgjt+dlhjzkLNMWjyzWJOYGt2QOzCzx1BjqY/hyjE4FPmlYbg5TMl
         p02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716829234; x=1717434034;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pnYD2vB9if3b0Pw8B9yj3OZSPzEecAxuxqjy5zfQk70=;
        b=v7GwpEEloFfKMDjMe1rd6DLsDZfFY0eUdzGxzkqc0DinJBo31FcFL6c8pogMETStC5
         g4UTgnYhWJrqKjuuZdqzdQeLo5x0IG4wIlZWa/v3ewVp/FnvckJfgTuSqLVg3uWI5V3t
         dI2i/E2a8uFGC6lGhWMte9lyJeqIz3gtspZXwzpyFPPDYsNprRU+BdmuepYaxh9txIQ2
         97jeT7pQEz0d52LTitpgVuU61WCLo/3Lrq8gbT0eFqRM4g9/2GYeLmQw5ZKag/p4RH/T
         VLU//Tug6CcKz/X64lYlhVZ0DuCEceHmdp8ZyC/3y9mAFXG/Y07JXLSHPXC3auXiQ+RA
         jK/g==
X-Forwarded-Encrypted: i=1; AJvYcCXjeXxkIC2ov/Aqb8KokMFhkzP3wpnn/sbmGp4+78OUMSMtdBnTpEtRiLqb+LCpXBEsnWzog+bs4JMFfddU4rWX24X36T5hPebzrKVBbBBzwLdjunblyN5J5/4EfzB6nAAKWtx42LoaK6G/NDCkPFb3+2ieL0pqQjBEl/eXUQsimHDo
X-Gm-Message-State: AOJu0YwRk3OP1zAWRMdYW2Ih1oTBJDQ+GomI/yEkl71aZZVAouwLca+3
	fuwrfzksEcgfEj80fp7e9os5FkXRL73XBISTqLnp1ugsFx2cvM0I
X-Google-Smtp-Source: AGHT+IGmgWeyiRNe9+u2BnAS1T0LPl+16VQSq5K+KtGP+MlwlyWvOvoH3Tc4mPXyjH2k8Qjrfmh4Hg==
X-Received: by 2002:a17:902:c94d:b0:1f4:98f4:4763 with SMTP id d9443c01a7336-1f498f449a0mr38374615ad.53.1716829233424;
        Mon, 27 May 2024 10:00:33 -0700 (PDT)
Received: from [10.59.0.127] ([210.178.66.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c99d23asm65061795ad.208.2024.05.27.10.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 10:00:33 -0700 (PDT)
Message-ID: <f8a8c06a-9dcd-437f-ab75-d0ddb608662f@gmail.com>
Date: Tue, 28 May 2024 02:00:28 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Documentation: cve Korean translation
Content-Language: ko
To: Jonathan Corbet <corbet@lwn.net>, Yunseong Kim <yskelg@gmail.com>
Cc: skhan@linuxfoundation.org, Austin Kim <austindh.kim@gmail.com>,
 shjy180909@gmail.com, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20240527103003.29318-1-yskelg@gmail.com>
 <87ikyzpgqz.fsf@meer.lwn.net>
 <bf37bf39-32d3-457f-abd6-115215d631af@gmail.com>
 <87o78rnz3a.fsf@meer.lwn.net>
 <8880b0ec-9315-428e-b9c4-e578690d3c08@gmail.com>
 <877cffnw2i.fsf@meer.lwn.net>
From: Jinwoo Park <pmnxis@gmail.com>
In-Reply-To: <877cffnw2i.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024. 5. 27. 오후 11:55, Jonathan Corbet wrote:
> It does look like the patch was reviewed, but no Reviewed-by tag was
> offered.  *Never* apply a Reviewed-by tag that has not been explicitly
> given to you.
> 
> Jinwoo, would you like to offer that tag for this patch?

Thank you for taking a close look at the content and flow of the patch.
Jon, yes I want to offer and apply Reviewd-by tag for the patch.

Thanks Regards,
Jinwoo Park


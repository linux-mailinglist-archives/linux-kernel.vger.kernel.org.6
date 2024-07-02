Return-Path: <linux-kernel+bounces-237268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E32CD91EE53
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 07:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C9C1F22761
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 05:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893E247F7F;
	Tue,  2 Jul 2024 05:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LyCwr26f"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D0179DF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 05:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719898363; cv=none; b=p5RfitgGt8dqtkpvg3pUmOFI7A3912kdqiQRh3UGnEC6JvB2u37bXBYq25X3SbU+Q7fKHR5blU/k8CNmUZXVvT2cyMetCSYO28GR5JZDQPY5DPEuxVnNEdQ39+93zTQWMSu/S12G6vqJ/8kfmhF5/vOpIo6vrswR8f1LywEI5fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719898363; c=relaxed/simple;
	bh=uBWcSgUI7yAfzyZ0rCSxqkB9CQ9sGfUKFE3Q6TwIN5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAKopupzXVJg4Q5qLxsu8YelPg01EpzyAIsb9U3ke75c8Sprx3QLlC2eN+jPyPPowsJXuwLIHlRtbuyk3sQzcc/FhL37bupq01RC6nq+uEZktUnuqv+4+Iz5wcJTO1f+UOz89Vx8D1HhgIoPzcKKIxHCs4rqaTQvjARB5Hgp82E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LyCwr26f; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-58bac81f341so130121a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 22:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719898360; x=1720503160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7RQmNimGTwbyU0lMcgMTmjU9W8YZSy3um1R4GV8sDAQ=;
        b=LyCwr26frA6T6dfzLxZk3l+GQVUPpnTCFIiprZdi0Cs7Alllpn3BTQyRAe1UBwDhKD
         yJMmBmZaHC1t4DpgAAqQex9NSna0PrfmVLHb/PNBkFWdNRRwM1zwF9IJqrAuFxOWDQKm
         qxrEOOf3kt3phvE7kZnq6eHkC8xe8aoEd19JtNJL7RWttuLPaEfe3jsT3j2YAw6hLyNB
         2dFDAy95GVEo1t2FssaXQ+vC7rnphZ/mMhmzg7sNYgjbE6Uk4u8T6kIVbswg3CKCbRlS
         1U6BEZS01DrSzXE7HyUpjfDnoyN/qWr9bct7wWHj/9gVPjno8zdwAzdoPCTET7FHWHoc
         XHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719898360; x=1720503160;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RQmNimGTwbyU0lMcgMTmjU9W8YZSy3um1R4GV8sDAQ=;
        b=PIt4P3VB6zGITpOp+CqfPfATqFFZi3XFn1SBaEcMs6UDYQEoeKci/qYT/HHcVm303F
         0ZFky/1yf3WqINjT3bd77XcRsKNS2ICBUEgGYZ+3HTIc2RoEx519iD30p+gDUymDVeT5
         rrCORVASaQgeVa1JsdgtQA8MCQ3ufgP5JWzLHTlXxXesDIh90sSHJIWvzE2+4S5nve7s
         4rlFhMgvE+vqN3fAH5BxiZIgQk87ySPUbks4lJoCz6WswsFeDSuznkamxOkXwSAs6Qn4
         P2kWZqXefCZ0tJA38ouhL8h7iE0n6lm7Yw8jDwBQB6X8uQdQYdSbsUZfeLtlvsvg00VK
         X0Nw==
X-Forwarded-Encrypted: i=1; AJvYcCX+tui3lvM1BgSX82QsUpLtpSLNP6mA0pMILeuNT4PcCGSJArJPZE/83V2SavBG1fTjxEqMXhrpakSyvSthnim8xV5MVWVjykWicF29
X-Gm-Message-State: AOJu0Yw/cyCVrs5oaPW6DWeVkOnmX+teNyuG6cHRGscrJESXgJcQodGf
	l5ac8En2SdRY/Frv2+tSrhD1Mot5xVj5weSuBfEU1Am7e4TucSrYgdTIV1hUsf8=
X-Google-Smtp-Source: AGHT+IG7s/PANsQ9QBr6GFjCz2u7TSS1xPzmScR7zZMqRAiIi0fE1lWFC3LJwuAC5VdzYjnW+FNGsA==
X-Received: by 2002:a05:6402:84f:b0:57c:f091:f607 with SMTP id 4fb4d7f45d1cf-587a0b0379emr5364857a12.29.1719898360020;
        Mon, 01 Jul 2024 22:32:40 -0700 (PDT)
Received: from ?IPV6:2003:e5:8729:4000:29eb:6d9d:3214:39d2? (p200300e58729400029eb6d9d321439d2.dip0.t-ipconnect.de. [2003:e5:8729:4000:29eb:6d9d:3214:39d2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58614d503b1sm5172349a12.67.2024.07.01.22.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 22:32:39 -0700 (PDT)
Message-ID: <001b72ce-8ffe-49bd-9f63-f10eebe61745@suse.com>
Date: Tue, 2 Jul 2024 07:32:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/xen: Convert comma to semicolon
To: Chen Ni <nichen@iscas.ac.cn>, boris.ostrovsky@oracle.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, jbeulich@suse.com
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20240702031010.1411875-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20240702031010.1411875-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.07.24 05:10, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Fixes: 8310b77b48c5 ("Xen/gnttab: handle p2m update errors on a per-slot basis")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen



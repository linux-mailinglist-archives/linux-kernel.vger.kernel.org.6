Return-Path: <linux-kernel+bounces-447739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D18C69F368E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803751891C31
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829BC205507;
	Mon, 16 Dec 2024 16:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dmusf8Hm"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB7E20457E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367422; cv=none; b=BcGDLIaKUvfJRKsdsMUV/32FFDoElC2QqTF3LtRQPICRMLq6VLb1Fap/zknMDMcKEc2ppv/h2H3Xk8EdPT67v0DTQ4JkxsEmegVCaZUDHIcPQh9aLZ0moSOsRPeh13nLKEp8YUGpRXdBCNyp1q294rUP1K4NnrBD8VbdGMQzl3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367422; c=relaxed/simple;
	bh=QQWdPEYlmc+nZpMpl4HW1ioNsquXtY6DnMtqhLHrBBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B8fqQ0fsGtwopW8I0Ml0iFEncSq8S0584jdBimpLg7rYuok/VSiyGeGQtdV7DlSjt3a2iRy5b/Fiod1YO+axFqvYKMLkXPnkhNG3Pir9WmAE6DpL69PDbxUhFvkTgOfc23wjjRPsXeth1RvMhK4c0KDePDJogYZPcUr7pkYYIOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dmusf8Hm; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361815b96cso28470905e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734367419; x=1734972219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eizGnDqNqlNpffP7llVarsh21KPFCtOjd1jz0iLgr2U=;
        b=dmusf8HmSeJWpefuvUAMrMSBUAq9wAznbx0p8qh+HHRrJVJg9njwCmJEw7WNpVw/+N
         5Ih3TaMKWNxx6eQB8uvw88wWBkhuhSg3Dind/PM8kojQrf5PMdZIZ0aR7Z72vDwt+7+v
         F2w9ZXr7ysXlrtm1j39z+fijjEkuuC2VEQpq9p81ptD4ERxMwuMmVAQLDGrWCaSToA+3
         vUdNLCMNlnwjX0uNqigu9CHhx+ijXdov2NtoFLWvsE5txcMlkwn2uJOuMJ/pBPzEZHJi
         AoHO/boldi0lFIQ6/buiuV0D43mqW57vWGBI+cR1zHruhB+0Tb3385VCBVFXYCPxxQMN
         vQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734367419; x=1734972219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eizGnDqNqlNpffP7llVarsh21KPFCtOjd1jz0iLgr2U=;
        b=ux707e2Hh7LDk5JXC/tYkGwRE4tXuRqaPQcD2Dc5BtSX6zkJ/wZbq0eWpm8oUyodQr
         Ed4wvAAphpCaK0fo/fjC0xbj2/b/IKWIuXYKBwq3IMV6uz9d3qcieB48WK71wwIgFAwV
         XGilsig+ks7NX3ijQtzCvR6zI51kmwgPMCRhS8XRnd84md6QsTtoB0nuyNkmjkyFExU8
         qieDTsd1r5I53uP9vDKbqH/7CknHqHXCCYQe0Kwi5cWg+FNXBVXSFyOUuzF7Ekblj9w3
         7XIL1tmT0sHWGMMQ2qhPkHukDoB+P8dt/JDBf/t+IUUzxn5jF638tAk4zxhFql+XdtO+
         XR6w==
X-Forwarded-Encrypted: i=1; AJvYcCXW7l1j7YJoxzFEhkqo7bPFLreHe3pDI1Q6zCnt4pv5WA/qjOwXCY7tQVe0t8BK6PeF7Qz+T7YOeX233wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEToTnZArhjvNDV/qQf5Csay2a2PBPmjWu8NSN8EpFSgcoaO4x
	oUd9cH2o+TGIcYO14LBjavmkQg8461JvjzqOTxLQnMV0FoIHweNTc591nluAyYc=
X-Gm-Gg: ASbGncudeTgjlCgBRBT4BfhQ80741PKy0ZwTWbKGBqSwxZ3yPQf41R2EdJXv6dZyBwW
	F5DlOGyUaUPmUDqebYMSKXbCaMPBYHTGsIHwZgt9p4Ko5/fMOdrEE2OzyTd8A3Oh1kjRb6oIWJt
	m1gJfylwXjn2Zfjg6xlGYN/D7uXD/g7v7iO0HYNTL/LPT/oO+OFHasfJQCbz1FLA9EAohx/qChf
	H58PnMnxPTxWhvdX5giFvnKqL0/Yo2WqaXhGHyXoSrr/A+37eUTQQGIaA8G
X-Google-Smtp-Source: AGHT+IEnPqo6gzVE3wILQI2tAtOM1/JutXdXz6dZd9o0VO/c42CFODH3r558QfMtWWjDDh1uD5CYkw==
X-Received: by 2002:a05:600c:510c:b0:436:1c04:aa8e with SMTP id 5b1f17b1804b1-4362aa3e398mr132593275e9.16.1734367419204;
        Mon, 16 Dec 2024 08:43:39 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436362b64a5sm91261215e9.29.2024.12.16.08.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 08:43:38 -0800 (PST)
Message-ID: <94bf84a7-13a3-4701-807e-fc0f10d4dc88@suse.com>
Date: Mon, 16 Dec 2024 17:43:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v2 0/7] module: Strict per-modname namespaces
To: masahiroy@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, mcgrof@kernel.org, x86@kernel.org,
 hpa@zytor.com, petr.pavlu@suse.com, samitolvanen@google.com,
 da.gomez@samsung.com, nathan@kernel.org, nicolas@fjasle.eu,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kbuild@vger.kernel.org, hch@infradead.org, gregkh@linuxfoundation.org
References: <20241202145946.108093528@infradead.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20241202145946.108093528@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/24 15:59, Peter Zijlstra wrote:
> Hi!
> 
> Implement a means for exports to be available only to an explicit list of named
> modules. By explicitly limiting the usage of certain exports, the abuse
> potential/risk is greatly reduced.
> 
> The first 'patch' is an awk scripts that cleans up the existing module
> namespace code along the same lines of commit 33def8498fdd ("treewide: Convert
> macro and uses of __section(foo) to __section("foo")") and for the same reason,
> it is not desired for the namespace argument to be a macro expansion itself.
> 
> The remainder of the patches introduce the special "MODULE_<modname-list>"
> namespace, which shall be forbidden from being explicitly imported. A module
> that matches the simple modname-list will get an implicit import.

@Masahiro, I'd like to take this on the modules tree for 6.14. Can I get
an Acked-by you for the changes?

-- 
Thanks,
Petr


Return-Path: <linux-kernel+bounces-187431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C3F8CD1A8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A351F22B43
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076A513BACB;
	Thu, 23 May 2024 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F1rghimA"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1989413B7A1
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716465721; cv=none; b=OZf1Yxn8ILdUI9u7UkdVlIGjgf/39yUCuXhszP1dE76vr7rBBJLks7OzQ93IemJQaKgjrb8MjqJBvfc5QToQ4hZxbRc6wpNWsBeSHjLDk4AdF4HmwRd5i1qyjw1EZcNdST1yoY1oNc81QybzYNI1pS1TDJ+mt+tv6HVYHS9LGjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716465721; c=relaxed/simple;
	bh=Tk/UnYB7NdgjEuYtt7p9NXYfWCDtEh/hlQ8P2WX9/Iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z69h8PWv+9ufqNM6XU3bzTwOg3GQEDfK/Dwt+HcShILc5Ciiy1UczV3JtUbqbJ+skKUZ5IzXPq/906vg/gOEFOlRE7qnwK65qZV4SF076RFm7gNpCpn6drAQOyb818FjbOPTOSbKH0VNjoueE3hKH/UbIPaiT6c70nybn0aH/lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F1rghimA; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-354de3c5d00so883935f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716465717; x=1717070517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AykWLRMhfIuqWQMOvQrfDGTd9ZVzX1cGKkmAJORqxQU=;
        b=F1rghimAS6F4ee1UXOxdWXZk0jU3kg7EWm0aqh33Z+QRR2Cg5EOfm+F9mvLyV8Gb0W
         /bfBM08ufp8yMn/6iYoetCu0Nk+jNVUhjlwa5UMAFwYsn9nQQeOMzwjamPgfjNZbVJqg
         W+j9HOBj+g56rWC0QevdnA2nfSl+vXHlmVUD7p9KmfJp7AVsH2exN00qEHQJTpnDzWbF
         o4KZiaAqjyoy0k+RZ/OZkFg1t1Lj7xTyOLZoXc+gWVfMdS0qEQb8uY0Cobp8ENop84bx
         T9XaMc9mbXuJVwG1T2qxSW2Z15LCkdKsk0fzW8JW6IKirMFNjsmJmq2PbYD4jrKFD6pb
         a5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716465717; x=1717070517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AykWLRMhfIuqWQMOvQrfDGTd9ZVzX1cGKkmAJORqxQU=;
        b=dtOCUjP6c5ZTgruqn8nt+ADTyqitlo4UoGsXz0fHnZEhakUxlMA4zdp0VHUuDsNYzv
         cOyqM49dNpnM9TWZW9+fCUqtkauj/AsrxERWcOcqqqgeYuxwInfx6NwpBoWrOUTiHjfM
         gvDGaFScHsulg7NOYaHh3qMLWS/WUOe7UhnJWspnBAaqgMpbQhVVcquwqQvRKmF1JlDa
         4B+0mDawE0OHBe65Jj3k7q81UvnLoBT4Uc1atLny+weRr8IkrJs0svcVCcdsdBdeDH14
         iJeYS0FMykPt5lM0BPwGZNDzj7zyUzj+gEtjF/f/Rozt8m89lKMK/OqbZKwcC4bmSGEo
         VSLw==
X-Forwarded-Encrypted: i=1; AJvYcCWCaMFSgccF7C54DF3B5OyFD90Rn51atK5Vcr9L/+Vbua3GwN3SJhISR2tvXKCS7oFVpHiCS5z+xlIFXrte2opccxY7So9/ScQ7cJa0
X-Gm-Message-State: AOJu0Yz432fwqS1ZmKHNvELQCsV69TXqIBEgnGKMkFctYApoayVrGGeB
	ScGzrXLecvvNzspMsl4t2YfXWNtFMTrUqKJ5AV+fGawhlKLPoqL8FKkyDrPKQC/wm13ExbBqW43
	d
X-Google-Smtp-Source: AGHT+IFi7XOybuT2T0K5bGfhxgS5aB5gz/y/urapYI7H/O61zC0HgZ7qtTQepUscjXk1/8lMq6eLxQ==
X-Received: by 2002:adf:fd85:0:b0:351:d2e3:68e9 with SMTP id ffacd0b85a97d-354f74ffd53mr1873455f8f.1.1716465717387;
        Thu, 23 May 2024 05:01:57 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7315:e681:bab5:4646:cf21? ([2a10:bac0:b000:7315:e681:bab5:4646:cf21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42106a158a6sm2766795e9.25.2024.05.23.05.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 05:01:57 -0700 (PDT)
Message-ID: <5ea91ae6-091d-4378-950b-833561eef48c@suse.com>
Date: Thu, 23 May 2024 15:01:56 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2024-35802: x86/sev: Fix position dependent variable
 references in startup code
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
References: <2024051738-CVE-2024-35802-959d@gregkh>
 <b3a6ea47-8628-4edc-aee5-e5051955124a@suse.com>
 <2024052334-cable-serotonin-fa2b@gregkh>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <2024052334-cable-serotonin-fa2b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 23.05.24 г. 14:21 ч., Greg Kroah-Hartman wrote:
> Isn't crashing SEV guests a problem with "availability"?  That term
> comes from the CVE definition of what we need to mark as a CVE, which is
> why this one was picked.

But availability has never been one of the tenets of CoCo, in fact in 
sev-snp/tdx the VMM is explicitly considered outside of the TCB so 
availability cannot be guaranteed.


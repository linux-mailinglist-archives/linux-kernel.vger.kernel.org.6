Return-Path: <linux-kernel+bounces-528123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E27BA413D7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 04:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70720170125
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A9B1A2388;
	Mon, 24 Feb 2025 03:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZd+7qTP"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02474400;
	Mon, 24 Feb 2025 03:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740366167; cv=none; b=iqK2fDixKEpVow/qVzKlMVB7fnD5hW6Lj0tVceDmMCjSpOLNHN4djefHExb8gl7xaI61PnhX7dl1sJj2Z5QpaJz50zYodMEBEfR5GkPOtHP1Ksy977RNJEexLThrUuAKLQFabIR2EbtOa0pmtpkI7RCMXWOGNWoqcpRxOxE2ikM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740366167; c=relaxed/simple;
	bh=okLaKNQi/XaGBc2dOZo/598nX5rCudsKpkSc1bgNRSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INqUKcY8wlkX+9zttJa4woMlVs1QWDSYuROzmCcsbBIm86WViR/wkDNhRjN4JFB26dUohw3aFOcW84LV16PNpNLLPrFUWIQ4XNOIasS49HaoE24pEy6qkyvtQtIizWXCj/AV++vUbLutrevqf/kbDMtXSMqJ+bfRPcm6clYdABM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZd+7qTP; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab7430e27b2so624606866b.3;
        Sun, 23 Feb 2025 19:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740366164; x=1740970964; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjsUMYFp+Mx49YvN7hD/3KWP7s9neIA8zwh6iIzC7CU=;
        b=HZd+7qTPSzqmnxAzmjX9yjCjW302VONxiL2jwHpjcjLI/MsR0fPRrPaf8AcVfRqO52
         vqOvvrRs/1orxyXXQXu7foHOuiNAUOOiabu29gJwy97cExjU2wh38VKfclg7dVNZVFnI
         Aufil20b7Rk9wsQf5Sk8B/2dPsB3EkC9HciVhUPeXqV6hognuRPT0ozmT1BPnPkoQHsV
         ToGNDd/UopqI50yRmnzjt/ek0ZHwm9RTUFlVpukkuhRuHh3KoWRbL6Qg+pVK+C5m1eXO
         dTvzOdp5U5K/vPBqxHk6yFDnfjEjrWlDi4iL0WHdnK7KJfGVOZK6CUV/qURa27K3vkIT
         Tfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740366164; x=1740970964;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SjsUMYFp+Mx49YvN7hD/3KWP7s9neIA8zwh6iIzC7CU=;
        b=NBQguMgnAoaGO7n7FwDffTsUFJtBJAiHIN3rKGw6Lp0nQieXUlYfjHTcJoy5dz3qWX
         XqRBaFPtNc/T0rqGR1+gR1+4Q+TzYHvm2lAjcgKzYG2NJk1vmy7TbE4m2UbxljUQm1CI
         vlglZEQi/w9FathWFtJCoqMlsc8VBUtyv0ECcwrKTuenrGnoTcNRt5LuFKUt+sK6AURU
         BVVwTY6ICxqfYr6ZLSQMVYw9KNOq9ZaNx2VPog3FwJalIeh8tkx0AKagFcKPzHKtU28H
         MTGopPwVO396H7nEeY+yYv387MldJBXfSDvPjNSgo6TgowQhdhQat92CVh06AToOiaEb
         /1ww==
X-Forwarded-Encrypted: i=1; AJvYcCWHoI3QN3BiZHbLLRUbVpJ0+ZdvFpoi19hK8S9kAnZNg2xxinJv9OM0AB2WYFOqSiKEe3T+03dRYlu8@vger.kernel.org, AJvYcCX1edPPMKF60onEggA8WXUpuxXOZVBwFwAUNsMcoWfZqmHpWHUH7vVnh1KN8r/A96Ab4SmlvYVHgp3u@vger.kernel.org
X-Gm-Message-State: AOJu0YxmnRegnPIt7Ai3faXg7hXgREAN2jDyd4S0ZrAs+hBMFUdnaTIl
	EWXNyilvDaH+HGTJh7x5ETuiU5WdBuRf8wgVn9lfUKHfbYqmsaLL
X-Gm-Gg: ASbGncsNXeIop9gTofn6EDFd7sWU0yREARDTsRt2iBokHtR18W5TlgZb+Tb9BFmeXiB
	IYka2Y5WG8+nTXjzna/olziOvo0CzmvxVjEn+uT6qwY3tP3k4FguZZpId4kn5ZAq8VTsFZn2/Kr
	r3p+3a0goFvKnmXKKU0OAfzXOgO6qboz2mj25hTvjgvhzOa5Nshf8Y9pkMJPNf/hOEmVuzTTghl
	jr1CBGWmtdmZgEzsdywE/ss0Ul7bJ+LfiFhad7qzkhX+QbE/ToesP7tf7YS2wcwR9f93y6i8Nqo
	S1TAfCi5qjLR5iuG2jJHDEilMA==
X-Google-Smtp-Source: AGHT+IHzUc14TKjsGWWce5aAn1HH4tsAMVuHoPc6eeAzqtQVN04INfU1hh5sqPpMyJ9gzD/SRveTag==
X-Received: by 2002:a17:906:c148:b0:ab7:b250:aaa with SMTP id a640c23a62f3a-abc0df5a73cmr933979066b.54.1740366163994;
        Sun, 23 Feb 2025 19:02:43 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb961594absm1510893366b.111.2025.02.23.19.02.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2025 19:02:43 -0800 (PST)
Date: Mon, 24 Feb 2025 03:02:42 +0000
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
Subject: Re: [PATCH v4 04/14] memblock: introduce memmap_init_kho_scratch()
Message-ID: <20250224030242.rdmzcdrth6qmlims@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-5-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206132754.2596694-5-rppt@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Feb 06, 2025 at 03:27:44PM +0200, Mike Rapoport wrote:
>From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
>With deferred initialization of struct page it will be necessary to
>initialize memory map for KHO scratch regions early.
>
>Add memmap_init_kho_scratch() method that will allow such initialization

memmap_init_kho_scratch_pages ?

>in upcoming patches.
>

-- 
Wei Yang
Help you, Help me


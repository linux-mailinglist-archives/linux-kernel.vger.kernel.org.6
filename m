Return-Path: <linux-kernel+bounces-428619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 911F69E1171
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625DF1620C0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 02:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B091313FD72;
	Tue,  3 Dec 2024 02:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qpwt6OGM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53868364AE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 02:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733194029; cv=none; b=s80+UvMYc3CzuuJJhAuB9wFaBJTnoIJKndBmRX4wxJnLgLjF8fwMKXPOI3kKh9PcY9EDc7BYKiRQbmGS/Fyvh7zgZUtoZallM8Eo9TS3pxzjrinREw9GbNjffpsK9MjWOLZj56qhx+uykKR7fjEOwvYJHxgzabF2pooN548TyLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733194029; c=relaxed/simple;
	bh=/1Hu86galPiO1j46qkPprgYcMn/t3TD7cqWMxQMt5s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmHkAjLiUTzXYya/esNOFunPEilx5X6DlyLt8g27tSXmt70dc9kdoTMXDaU8sQvHoKiAxNXac3kLqatKhAddjsd4J45iV9R0/cnD1xE7sr/f5Cd7eDxnKfxjoxYBcIDsQeFxHliOMwoJXRdZyOwrW0bLS5hsVfXQo9mII7zk5/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qpwt6OGM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733194025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ClTlVFTFurX5oXTNx4i+KqY1w2R5KKrVUj+CsjT5+JI=;
	b=Qpwt6OGME3Ogfrc+Y3JRQNnOA2E6a1NzBRPLMv0TevI16DXX8wupZzWX6D2kgEeqa5FleP
	8HrK4IUClO0c/QFc8boxKbblV4y4+SioDakb1MIXzzcS4p+zsH6ye2UnipREmXhx+Z1/pJ
	9Ta0gz718zqNaWmTPgw25bxWgIdwF3c=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-gZUZcilfMbO7gl4GFk5hNw-1; Mon, 02 Dec 2024 21:47:04 -0500
X-MC-Unique: gZUZcilfMbO7gl4GFk5hNw-1
X-Mimecast-MFC-AGG-ID: gZUZcilfMbO7gl4GFk5hNw
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7fc1becad32so3879428a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 18:47:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733194023; x=1733798823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ClTlVFTFurX5oXTNx4i+KqY1w2R5KKrVUj+CsjT5+JI=;
        b=dd9TD92YE0KxtFfx+bfCAnOdNb59NbYg82RQzJrNFprkrf1Xl2e6Yskkb1DS/AtHaK
         hvK1Ki5Ji621Wh4/PGOGriuG5c/Kai41zhQp9UXCj4UUmH6i18hLLvPpSrqlxAhEZN2p
         4zFZzTXmNPux67SfN0uMuU80ZlesMYitHQmvAX3b18Vd4RLTXr5eFS1qb3P3m0TEpAHv
         +se/KnNU71zzp1fVHygp1xP+OlDMUISg6ZfYn2HHB269FzG7DtkocqF0+GGWiFq3GdaM
         hLuAhECbdaIM/cX/C+tTmZWmJksdAxpi6UoEeZPDVFmPKKsliG4TISHMpZDbqMqit/WK
         XoSw==
X-Forwarded-Encrypted: i=1; AJvYcCW8nlADhOFgdlDGBggRZH9wV78BdICAokXyYWA+XP9bECPJaUgGnHu/h1nccE0LD/FKpC1tru2baMNmzGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGgn2HaE4E3guvDRuOpE1zrzfyEOJOSS4SRx2e6m3ajOSS1Uwm
	Zoa3Glv9I4297SCXdX9RPTYC0S+qgGfz3FjCjUSLB20IdjVZns6Rv+MasUznRhc0MVx61rLArUi
	ZRKj3CXjo+iBY4T7BXhxxPn2IkvujCW+7u6wHaa/Nv9r8zaT1sWVNP4QvaqZqsw==
X-Gm-Gg: ASbGncu9rFql96Qt8YpWYCOBRIbtNNAUw9vihwYERlcHUsUbxn/ov1+85xoVBv7yNW2
	p7BZRRfMnryVTidxhxK+Jm7YgXsY4A0cam8Z2uYSod1DbpEv/T0kBm+a7VmeLWv5irxhSJDP8Jz
	oan7gjUHAKY8k5L1tm/Ytwojj3lAzK0fZ3Y6cvA/LmEFGlzBTZ8qXdxFxwX0v3ahjfY9hUjTlX1
	qUOmY6ArsPUIVLzmr1QCaQe6hTTUYRwvbE7Ft+Rdj84ZiiPaoM=
X-Received: by 2002:a05:6a21:38d:b0:1e0:e042:59fb with SMTP id adf61e73a8af0-1e1653f6b74mr1564777637.30.1733194023099;
        Mon, 02 Dec 2024 18:47:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9eFzD9WG0Hqv5IQOxlc3XDhwP+H9Hs6Mbmnq+pKxPw+93nYH2bBH5+6wJ1GFGp+i1k+N1ug==
X-Received: by 2002:a05:6a21:38d:b0:1e0:e042:59fb with SMTP id adf61e73a8af0-1e1653f6b74mr1564759637.30.1733194022801;
        Mon, 02 Dec 2024 18:47:02 -0800 (PST)
Received: from [10.72.112.107] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fbf2fsm9271296b3a.112.2024.12.02.18.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 18:47:02 -0800 (PST)
Message-ID: <498151ad-6fa4-4f16-9044-e0b1f78d161a@redhat.com>
Date: Tue, 3 Dec 2024 12:46:55 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Replace open encodings with PXD_TABLE_BIT
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
References: <20241202083850.73207-1-anshuman.khandual@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20241202083850.73207-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/2/24 6:38 PM, Anshuman Khandual wrote:
> [pgd|p4d]_bad() helpers have open encodings for their respective table bits
> which can be replaced with corresponding macros. This makes things clearer,
> thus improving their readability as well.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This patch applies on v6.13-rc1
> 
>   arch/arm64/include/asm/pgtable.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>



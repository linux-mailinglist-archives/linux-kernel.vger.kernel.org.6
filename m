Return-Path: <linux-kernel+bounces-560487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A09A6055A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954B717E2E7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242161F869E;
	Thu, 13 Mar 2025 23:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VAKcfUKS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D204D1DF975
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 23:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908822; cv=none; b=PmHHlfjLXOLl2M/PgTuGGV7pBZUKkgsPDw1mVxCypIQQm/OPkTbs4TtpHH3VENV9QutR6YfRqJizUFTD4FXmNEe1S5gIxXSwtwC6bOnrU9gm0YAxNaO/7cF05lQghqrKUsxMbVJnM0wOZ8NunYq90sCmznlMCK/zxcNPcG+SLGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908822; c=relaxed/simple;
	bh=d2BbL6crT3zxbAoUuy4Rpuun0vagGQKtPIulLfRfm+A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3fK1zdWRL0ENX1EyNf16ywHK6PxeyrHtTNkbLzzD03y4N0ntGNwK67SVfEFBxaSDqjPbfsNPNjkANJJR7jPLZTsi1gzDd6OYE36W0ttLLeLSEQy1QsPKNXkuSBokhP5e41EtpCSlWfI1MRaeOfr0blwmdB0KbiDgb8uj91ZqPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VAKcfUKS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C/3v9hCM3XgZQG/uWDAc5eUlEb86hfweiLW/E08xeso=;
	b=VAKcfUKS53dCtOwsOA1nXiU1VaTayIrNY/DRuiQ5aguYNbahssvQtcuEnF6IgMpFxl2o+e
	z98fBVOJomLKEa/WnFvrc1I8en5fIxTskWbUbu9gsl797uneyj1HYBH1tP2BWKLJGqLZmp
	XjqcecqS5zpKYXWnh0BM5dpInT63/pQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-4o1SrBtNN1GUQSqkJGjA0Q-1; Thu, 13 Mar 2025 19:33:38 -0400
X-MC-Unique: 4o1SrBtNN1GUQSqkJGjA0Q-1
X-Mimecast-MFC-AGG-ID: 4o1SrBtNN1GUQSqkJGjA0Q_1741908817
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff581215f7so2427501a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741908817; x=1742513617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/3v9hCM3XgZQG/uWDAc5eUlEb86hfweiLW/E08xeso=;
        b=EnXA/YmwcPh6H0nE/r49REyhlaEItJMEWWzKrnJJ4OrwpaBQ2lVwH5wWgvB/t3myiI
         swTSjCiRZDLfhmH15Qsw+uees9h3stpuGEXU6n4xZrNqbxSlNT2BRNe24Xp/UVRd3WMG
         v1ryH5EQ6srUC3GKrBF6YsF/zBWB/UXBuTdiy7LIoGgymqc7CrhPYDXFBlj761+NvaxI
         1aKUwgfm9puBEN/gPEgENoXNVvsJFjPzMEBpwxpEmeAJ3Lxm8owpkyMd814Jc5oz+j8f
         Kvz1MKFfEV1wUViShK4IOvGs9Iq2TZYdNqvunwMKAhuzUuJAe1ACd2h3hLDjtft/bO6P
         2WnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ0mehOy9EwdpvQt3PKOBZQqsIodQ2PtazVlo67koE/+6ULvO8jWb4HcyhWjd3k3beMAxTpM6IeKVGP/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRa5JkdPSW84KYOXavmMeXdRcmUWZqMj/GuFPkN+40Rbel01BG
	izm41eoMxkVEJFFR85k5vkqtJEJ+9qVZd47FfakqoEoNKHQZwrhYqtnNGJqfUIAI0h4dPD7q7IA
	MW1keKwHCbS+V9yXl4avf0YXA6ZbZ/+nf/+n01L3XKO6hjx5xbfvJ+yvhUvCFOA==
X-Gm-Gg: ASbGncvu4r0CQ+Z3zSfih/Wr3Wrp3en0BoHPqSQ9UXQLt8701saRHPS2bkkzADo3+ZY
	KpXpN/cRUNz2ox0XJKzNCXbInhje03GzsG1F5d9W52efu4gIdZLlU5ENoS42EAUbQBCpVNUcR7l
	vKbyQir9dAmDI0YX56t1DUM5Ad4s46fzawuRV31zsQXZUn7bRH6fpTOFHTpdAabyOIx5CX4U4eM
	hntdJgjBAQJXUOr8KxvJezdvOeA9OM3gNeJMd2SHkr1MZPXUlAsH1TWY9GM4uf0GyOzWJI=
X-Received: by 2002:a05:6a21:6f12:b0:1f5:6f61:a0ac with SMTP id adf61e73a8af0-1f5c1194398mr713914637.5.1741908817087;
        Thu, 13 Mar 2025 16:33:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg11jUSvdZ7myHt28bo4oT7WuIlGER6PePCSXTF7sXbwm4FqFaH8DdomvUNIg5u14ALbu+uw==
X-Received: by 2002:a05:6a21:6f12:b0:1f5:6f61:a0ac with SMTP id adf61e73a8af0-1f5c1194398mr713902637.5.1741908816799;
        Thu, 13 Mar 2025 16:33:36 -0700 (PDT)
Received: from jpoimboe ([2600:1700:6e32:6c00::46])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1876855a12.6.2025.03.13.16.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 16:33:36 -0700 (PDT)
From: Josh Poimboeuf <jpoimboe@redhat.com>
X-Google-Original-From: Josh Poimboeuf <jpoimboe@kernel.org>
Date: Thu, 13 Mar 2025 16:33:33 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	tip-bot2 for Josh Poimboeuf <tip-bot2@linutronix.de>,
	linux-tip-commits@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Brian Gerst <brgerst@gmail.com>, x86@kernel.org
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
Message-ID: <20250313233333.bdkv2xmmj5j6uwjt@jpoimboe>
References: <174108458405.14745.4864877018394987266.tip-bot2@tip-bot2>
 <90B1074B-E7D4-4CE0-8A82-ADEB7BAED7AD@zytor.com>
 <Z8t7ubUE5P7woAr5@gmail.com>
 <20250307232157.comm4lycebr7zmre@jpoimboe>
 <A669251B-7414-4EE7-B0AD-735E845C0B5B@zytor.com>
 <20250308013814.sa745d25m3ddlu2b@jpoimboe>
 <1602F93C-94B6-40DA-A2F6-B8D4C0E24C1F@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1602F93C-94B6-40DA-A2F6-B8D4C0E24C1F@zytor.com>

On Mon, Mar 10, 2025 at 07:49:56AM -0700, H. Peter Anvin wrote:
> >> Alternatively, you can co-opt the gcc BR I already filed on this and
> >> argue there that there are new reasons to support the alternate
> >> construct.
> 
> I should probably clarify that this wasn't flippant, but a serious
> request.
> 
> If this works by accident on existing gcc, and works on clang, that is
> a very good reason for making it the supported way of doing this going
> forward for both compilers. Per-compiler hacks are nasty, and although
> we are pretty good about coping with them in the kernel, some user
> space app developer is guaranteed to get it wrong. 
> 
> Frame pointers are actually more relevant in user space because user
> space tends to be compiled with a wider range of debug and
> architecture options, and of course there is simply way more user
> space code out there.

I opened a gcc bug:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=119279

-- 
Josh



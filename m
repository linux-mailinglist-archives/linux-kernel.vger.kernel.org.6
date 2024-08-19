Return-Path: <linux-kernel+bounces-292498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F4D957030
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1221F2248A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E851175D46;
	Mon, 19 Aug 2024 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YLMHzLay"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FE316D4EA
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724084767; cv=none; b=UwHpZOFJds7Vs3uzuzxA45HhU1eMQRG62qeZviQbwFvKdxPm3WFAT1d4rD0ze4h9NOQCxW/daIeJelV8SxIdVKWEKMnVQT4zdE8Uo7IW9AhBv49k/LjuPO96bAbieHR0BXfw/vfeSqGrjEv51fO6AbnOWc9E9yjHGOUe8W+Yyjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724084767; c=relaxed/simple;
	bh=55JxwM0QiGmgymGNIEqaoA6B5iyOWQrfd8q4LPRGb7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HsLIKRMACtADlQZujOe2EIeGawQOXmErdh/5y2lYLbdWmdQz/z1zXyVz47mjdO/i24uOxTjfEUaxt3yx1C131J1Tvd49QwT0WLMi1WqNtClqNb0RbSaE8Xym6+ooN5ag2n5waipBVj38Jd1P8SVGgMhVuLHF2ZG3ubNFOGT4q0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YLMHzLay; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5befe420fc2so1397562a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724084763; x=1724689563; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M7P4eY0Md4aCcpS7AezFHQ7BubykxjGjE1JXmClsORw=;
        b=YLMHzLayt8b0OyrEiJizlZgO2cTfcVpvNnmfxb9hDmEBFRcNxbSxc0LQ+3sf9gsohG
         8Wx2QBVCpcZbap1aQ9AdVsLw5oSatA5wzsFV7SBcqUCmUJ7QelJc6mxoSptNr5hbHCwT
         RzTJs7fnGbC9mwAiSmsneP1lJy3wj/QPmhNLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724084763; x=1724689563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7P4eY0Md4aCcpS7AezFHQ7BubykxjGjE1JXmClsORw=;
        b=BRa5vYqYgtfkb0NoJwi7dK7fIcYhztL9HdO9QB3T4MH/jBW9X4AuFSNUyFsMRfk+tC
         DGGEd+OhzGmNzPn7MUCEMIytoYnceQToNffap/dWKWF73nU0BVAM7GT10ktFnlL7eE0u
         UQfRrz+qoC/0IPe+dcCEV5tokka9jpj8Fg2pc24hl6MU6/J3tVP2lAAKzqDJRQBjut/g
         QEvuFCf/oAoLiKh2BXFZb+Aau2YZ8eYITXQCiqMvXkWogdg8CaZiX7V7eGQ7rYMqIpIb
         WD0JZ/l3UPWFbIgj48zCPYQDm4tHSiwkvF1oJIwm5VFKpOUydc3TGXWYuvDNKcUa1FMZ
         l8Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXV8p/8EzPrfsVbGT9T+aOZEHnBsiDJ0Nuk7LpLi2+cqLJtgQjhqrvFQgtf8gwvOknpnGkJz12UsGjPkyeOp1FUmKlRq8Ffb/Se/1ac
X-Gm-Message-State: AOJu0YxMnZWUCHrlQG9/Ll9dgQfL3DwcySPuaUqDwisS7JEoTOu2l7oT
	veOoHTF1fC/2gKEf1jJum4eNt8WpSZfMIdNdPldp1lTFKPuvXzlEyy9xeetT+5+g0BxPahqW3Ht
	DFSwVFg==
X-Google-Smtp-Source: AGHT+IGct/b/VKwaAd33aF3bXYO8Ref9tG8HDiBXFsYGVUxN/d1C1z5ktrtMhSvks2H6lOMYCncDXQ==
X-Received: by 2002:a05:6402:27c6:b0:5be:db15:b3b5 with SMTP id 4fb4d7f45d1cf-5bedb754d16mr6675513a12.31.1724084763263;
        Mon, 19 Aug 2024 09:26:03 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebc081dc6sm5701475a12.91.2024.08.19.09.26.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 09:26:02 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5bef295a429so1816126a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:26:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHGavRxs8DtbwpExN0IfPbES7C2CS1IMclL4/AkYICbyO7Gx2P0Y3TdJN3nfg0oRMLrKg6iG5Z2fGHXK+3scpYrtyxFoO6AmsxpkZu
X-Received: by 2002:a05:6402:254e:b0:5be:daa6:9139 with SMTP id
 4fb4d7f45d1cf-5bedb6f274cmr4310212a12.20.1724084762085; Mon, 19 Aug 2024
 09:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813-seq_optimize-v1-1-84d57182e6a7@gentwo.org> <ZsMGRIec1y8hdKRG@J2N7QTR9R3.cambridge.arm.com>
In-Reply-To: <ZsMGRIec1y8hdKRG@J2N7QTR9R3.cambridge.arm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 Aug 2024 09:25:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=whTtu-7NxtsVMzxVWXaRM1rcCWYEVL8hwNxEVEqpfZETQ@mail.gmail.com>
Message-ID: <CAHk-=whTtu-7NxtsVMzxVWXaRM1rcCWYEVL8hwNxEVEqpfZETQ@mail.gmail.com>
Subject: Re: [PATCH RFC] Avoid memory barrier in read_seqcount() through load acquire
To: Mark Rutland <mark.rutland@arm.com>
Cc: cl@gentwo.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 01:46, Mark Rutland <mark.rutland@arm.com> wrote:
>
> If you cannot disclose that for some reason, just say "on my ARM64 test
> machine" or something like that, so that we're not implying that this is
> true for all ARM64 implementations.

It's the same machine I have - an Ampere Altra. It's a standard
Neoverse N1 core, afaik.

It might also be a good idea to just point to the ARM documentation,
although I don't know how stable those web addresses are:

   https://developer.arm.com/documentation/102336/0100/Load-Acquire-and-Store-Release-instructions

and quoting the relevant part on that page:

 "Weaker ordering requirements that are imposed by Load-Acquire and
  Store-Release instructions allow for micro-architectural
  optimizations, which could reduce some of the performance impacts that
  are otherwise imposed by an explicit memory barrier.

  If the ordering requirement is satisfied using either a Load-Acquire
  or Store-Release, then it would be preferable to use these
  instructions instead of a DMB"

where that last sentence is basically ARM saying that load-acquire is
better than load+DMB and should be preferred.

             Linus


Return-Path: <linux-kernel+bounces-524438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A10A3E31C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A342E17B7A0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA90A213E6E;
	Thu, 20 Feb 2025 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="es5nTpLT"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E155213E60
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074083; cv=none; b=EqnXCtdct5GumtRVdWgOOSn6uVa1epu+T+c03OSGJSjK7PSm9+XYdafDA1hudDhmS5sVwJq/AZ8SvbSzz4SaxJED7XIKdY+keAmtiNtSXu/z80qvxLlrV6Pb7mgDAa/PTN8o1IZywO06dwmFAsf9AbqyflPsSJ+1Q96Xl6NS0vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074083; c=relaxed/simple;
	bh=ngtjcQl2dxY483rE2p8Q0D/5KvXvnzVLeK0XBQaaEwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDrZz3DofZX8+HZpuFedi0ZpUQbvUGVHHGCBIHHJvrMzM/LVvCcA4WOEkB/w3y5ShDnNgNykGveChBvosp0xxpgS8M8SetxTk+o6ROb+lP6DOKhxLxNA0rBhauJaBFjNiaZqU8w5IefxQLdVVDHrkQCr2yof7i5/fXJ0RILUoUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=es5nTpLT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220c92c857aso22765015ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740074081; x=1740678881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zfm4+2wMHxBuEgR/pkI4Xb42FdK22RoBZq/RbEvYIX4=;
        b=es5nTpLTwPe4BUKyvE9Stosc2s11SHjUw0HO0XFaHLGFrehU6LnjQgyeXEWwCa740A
         gglD47jNN7TZO9mp4KIQcIa4G1XKxemGrhl3T9z1VqcU4+LBIaZXqqESNbamEk9kpdaV
         aap9U+pck/TnjsrCCtWdY0w87Qqim2igYmjkbkuP8bmuxt/I8DIRs05mUQSxc3lx68iF
         4wng4ICn/CuCx/RRvZCi/Wnz3RTAqykuen4GsVYZvsWNP6yZ+mdq58OFqgMIsNOCicZ0
         ulrvGj+FSLVYGXEvNAQXeiDN/ahSXBL0xI0HvyH7DxMpSH6M9sFPjREldfQdtOgJCvi3
         k88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740074081; x=1740678881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zfm4+2wMHxBuEgR/pkI4Xb42FdK22RoBZq/RbEvYIX4=;
        b=ZPQ6xLlAZfDUPhiLW8dcTSHzX7UVcyh7YrelhzHyGqvnPhbDFYvtRHTLhEWr8v8KHv
         NgbvP141w6u0uIPvnifjeANjU5epEWkvDgqlLW1avcqzdanzyZzYfNFGSO6S+eIZU2pl
         +Rlgr4eTJH/PRTIqAU/PwLqOssgdHKk9oSW6lrtPCVzLiBvLwOrg/owBydPDe3iRXF1B
         b7Wi2DCoYrdW+kW0hcHZLxljC9R7sxALvO1clVaYZ+ew8Pt1z1CmkGx/zFeAD+G9xBba
         UJQ+Va+8jiTRJYanKLHoof0nfuAJKqu6iAIoSTR9+0EsNVWUkIHUTnqvzOd8YweulLIJ
         w3NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeITS2OvY2hsPOjLbxu9cvSos+zq9b4vb1Dk3g5dCOD6KW2cQm6Ab5co7d4NpH4+u8/1O1E2u3JrFpLYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOpjbpAnlXXapo9oDdcabERNYwLEZBJkcRYKxQ6RHmO5oLKOkm
	7j/IOOHGLi7aFXubmX50DW1d88zQ+9cAXn85mbj26ir+NmlFCesp4hFQKkXVZSo=
X-Gm-Gg: ASbGncvtq3gy9Jb8TXbeFQcCFE/Bi8b+R887Ti04MSOibRI8GoImGluFNvpDaTpNWOU
	01dIN8okuIOwOhdMDzPQRyWza/sgMQgJBdzkojn7KN3yPxHXtMeVj36KC3no1wbSLu2ZZ88J2hl
	2gPEwAVHePkzxsU/eiealzZL+iYqadmnHIkdQj/WFIldskRHwbIHlxkqH9JuPTeXHgyRv4C82hx
	s5TcZXWKZliG+1pP2C7gMkIhwXLfJsNyUh1bobwyv9oEdI0PpHx2ZVbIaZZAWt/zAfk67IyNH7H
	j0eHNs1wO47HGmA5PtpbrnJPOhDpG3yw3k+pZDJSLIgdSsJ/RJraC1M=
X-Google-Smtp-Source: AGHT+IHfhNFiIjRnUDJ8pOyevkfFLBmf9HLRmR2xhgVM3ljK0tH9naWXCQaDCNRvY4VzVmepHx8rgg==
X-Received: by 2002:a17:902:e846:b0:215:8847:4377 with SMTP id d9443c01a7336-2219ffa35a8mr654545ad.15.1740074080801;
        Thu, 20 Feb 2025 09:54:40 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53491b3sm123234955ad.40.2025.02.20.09.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 09:54:40 -0800 (PST)
Message-ID: <45155869-1490-49ab-8df1-7ad13f79c09a@linaro.org>
Date: Thu, 20 Feb 2025 09:54:38 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Alpha: Emulate unaligned LDx_L/STx_C for data consistency
To: "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Ivan Kokshaysky <ink@unseen.parts>, Matt Turner <mattst88@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Magnus Lindholm <linmag7@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2502181912230.65342@angie.orcam.me.uk>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <alpine.DEB.2.21.2502181912230.65342@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/25 04:46, Maciej W. Rozycki wrote:
> Complementing compiler support for the `-msafe-bwa' and `-msafe-partial'
> code generation options slated to land in GCC 15,

Pointer?  I can't find it on the gcc-patches list.


> implement emulation
> for unaligned LDx_L and STx_C operations for the unlikely case where an
> alignment violation has resulted from improperly written code and caused
> these operations to trap in atomic RMW memory access sequences made to
> provide data consistency for non-BWX byte and word write operations, and
> writes to unaligned data objects causing partial memory updates.
> 
> The principle of operation is as follows:
> 
> 1. A trapping unaligned LDx_L operation results in the pair of adjacent
>     aligned whole data quantities spanned being read and stored for the
>     reference with a subsequent STx_C operation, along with the width of
>     the data accessed and its virtual address, and the task referring or
>     NULL if the kernel.  The valitidy marker is set.
> 
> 2. Regular memory load operations are used to retrieve data because no
>     atomicity is needed at this stage, and matching the width accessed,
>     either LDQ_U or LDL even though the latter instruction requires extra
>     operations, to avoid the case where an unaligned longword located
>     entirely within an aligned quadword would complicate handling.
> 
> 3. Data is masked, shifted and merged appropriately and returned in the
>     intended register as the result of the trapping LDx_L instruction.
> 
> 4. A trapping unaligned STx_C operation results in the valitidy marker
>     being checked for being true, and the width of the data accessed
>     along with the virtual address and the task referring or the kernel
>     for a match.  The pair of whole data quantities previously read by
>     LDx_L emulation is retrieved and the valitidy marker is cleared.
> 
> 5. If the checks succeeded, then in an atomic loop the location of the
>     first whole data quantity is reread, and data retrieved compared with
>     the value previously obtained.  If there's no match, then the loop is
>     aborted and 0 is returned in the intended register as the result of
>     the trapping STx_C instruction and emulation completes.  Otherwise
>     new data obtained from the source operand of STx_C is combined with
>     the data retrieved, replacing by byte insertion the part intended,
>     and an atomic write of this new data is attempted.  If it fails, the
>     loop continues from the beginning.  Otherwise processing proceeds to
>     the next step.
> 
> 6. The same operations are performed on the second whole data quantity.
> 
> 7. At this point both whole data quantities have been written, ensuring
>     that no third-party intervening write has changed them at the point
>     of the write from the values held at previous LDx_L.  Therefore 1 is
>     returned in the intended register as the result of the trapping STx_C
>     instruction.

I think general-purpose non-atomic emulation of STx_C is a really bad idea.

Without looking at your gcc patches, I can guess what you're after: you've generated a 
ll/sc sequence for (aligned) short, and want to emulate if it happens to be unaligned.

Crucially, when emulating non-aligned, you should not strive to make it atomic.  No other 
architecture promises atomic non-aligned stores, so why should you do that here?

I suggest some sort of magic code sequence,

	bic	addr_in, 6, addr_al
loop:
	ldq_l	t0, 0(addr_al)
	magic-nop done - loop
	inswl	data, addr_in, t1
	mskwl	t0, addr_in, t0
	bis	t0, t1, t0
	stq_c	t0, 0(addr_al)
	beq	t0, loop
done:

With the trap, match the magic-nop, pick out the input registers from the following inswl, 
perform the two (atomic!) byte stores to accomplish the emulation, adjust the pc forward 
to the done label.

Choose anything you like for the magic-nop.  The (done - loop) displacement is small, so 
any 8-bit immediate would suffice.  E.g. "eqv $31, disp, $31".  You might require the 
displacement to be constant and not actually extract "disp"; just match the entire 
uint32_t instruction pattern.


r~


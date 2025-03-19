Return-Path: <linux-kernel+bounces-567290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFD9A68434
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 05:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8803BF2B0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 04:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABB324EA9D;
	Wed, 19 Mar 2025 04:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="UbibENQP"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1900624E4C7
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742358278; cv=none; b=XN/FsTU/e7GN38niXEA16P/8noTj+2NjqZiZPBKeCCbVzAkuop8rPeQAszN0IzXusUDpt3hboME6ha0ZdebrFaFynglS52+c0Va1FDUs3eB6/0mAhvJe2RmpsYdIjWabaTy8YeVPWxuCkv5BhiMmcCfL3xQznR6v0SSrebOjzTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742358278; c=relaxed/simple;
	bh=0ow16mkjxkaT8T/qgwX33RDIUinYj0CawCoNVoyzG5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMn27NBAtWx5C3Ik7CX3jqHK3XH0d7tfHvAhdhs47UpcJHVmwIdnfKnCoNycPQ6nogcpzOP1JeULnzGo0YGtvsjgvD/MXVJsq87faBtUsgQ2L9uF9Dy/nG7PpMzQouZc3PEzXzrWxWpWUHWj0OdlRoh+QNBRFd9RF4N2yNg5cys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=UbibENQP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-226185948ffso57570235ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1742358275; x=1742963075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D4F+5XpwBlo6A7J8PT3rf6KdPFObjOeaat29Z+tUAl4=;
        b=UbibENQPlFsHWlXkdqrpACuCBGim5qNONEQemtlduG0fiXfws0jxycCG4X1MfdfKZg
         pRiu7iEWHgJPBrWWKtzE4VRaoV7KMQslW4pJqivbZpOpcHaQ6KJJfreUrKp44eeuLtQ+
         joK0bOgm05Zqv8wmzWS1keo9ZrJlNa9WT8TlGQFIfzmfwuLCCrlYORhTlf6Y3w+/07nY
         IuflofBAmZb6sdqyZr8Js/4rc2tf+L926JeD9Gl8tVowHvWrLCru4yJ+FaFFtbUnknJW
         P5ixb/kNO8KyA721Fy+Ai5thX3Y6nWMFl1RzPFn8grZfEe1R4JPjDAFqWmJuCrKgWIWB
         kpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742358275; x=1742963075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4F+5XpwBlo6A7J8PT3rf6KdPFObjOeaat29Z+tUAl4=;
        b=kT5Me8Jz4IVBpBv6S83kDRoNraps+A/uc8EtIEnujKK7TgC1/0xOvNaQmm+/kOBFlt
         0KDFMaF61glacSKyyP80S/1AIVyDJr9p7r7x11qkWcg9FSnqjDDysLboYDaLWjYNsS0r
         8D/WEdlPNl3jd4xGzJ+AFOcR96k8xzBVktEHF+p0f+7rkTgrYFphIXrCWVv8gwPGlOeO
         d6c2zkwri4UgUuVWLkQyFV9iEkCteU3fEMR7M70w2ql5qgKASou25ULGndwWLvOy6O3b
         ni6qKByi+d8ovdysz1+EkGEa4St3JzhKuSPdj4o/P90KQGeaF+qSuNoPWXXyO1nwuIsM
         iHEw==
X-Forwarded-Encrypted: i=1; AJvYcCV89s8PnefJ7vR9JaTmvky5siz8JbxwmgSCOAitRiIcNMbcbqlQC9FhgdKdtaRmYINpnUae7dy8z/yCtf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Alj9hb8MIVtSP7roPfx48LuOXnvzlFC4n+NurkspW/YTK5iN
	qV2xT+uFluhOrS0+nQXGrCVFa3sQW8fpR7xlJEIWo2ENvoLuFJl4C252p6VuRA==
X-Gm-Gg: ASbGncvAOMSGJMP9ALRD2ctc4+Mj+LcbmQNskmHL+L6I5OXl2nSaHZRfNhJBi10+Nwv
	RB+h/roPV9RrrnSRbrWSIASzYxKZ//oKnvrqZyPVmLqV5JFKRkZdvq8J55kSHE3qyWMGltA8uvU
	B5YkxUQONE03Fhf7hDxNS6BcZlcnbPYUR3VA3EMs5fMu+aYsvsRLUkAps+YlawKd650zVtFhHkE
	h7KGIPZpZs1KGftjgJA9qLVHoMb5BDo4dKboBpV3eZS02Qjc7mEjGgSM1RUyT0sOqOL/LInpP7Y
	1GtfgKafD4jqMgTeDCSCEjEyimuYwA18EcA0WC1hMbxN5uT13FwiqIMm5i6+TGytyQ==
X-Google-Smtp-Source: AGHT+IF5Kokf/3D6IznTV3Y93r7zaXDK9pmKSWn6ylEux22EwdaACa3yC7dDh7Wvn/nDjNhefacJww==
X-Received: by 2002:a05:6a00:3d54:b0:736:5544:7ad7 with SMTP id d2e1a72fcca58-7376d62cb88mr1927818b3a.14.1742358275073;
        Tue, 18 Mar 2025 21:24:35 -0700 (PDT)
Received: from [192.168.50.200] ([202.172.96.87])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9e1beesm9963281a12.27.2025.03.18.21.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 21:24:34 -0700 (PDT)
Message-ID: <518bfbeb-6ae9-4b56-b55e-ffa4b9438188@tenstorrent.com>
Date: Wed, 19 Mar 2025 15:24:29 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] riscv: implement user_access_begin() and families
To: Alexandre Ghiti <alex@ghiti.fr>, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, paul.walmsley@sifive.com, charlie@rivosinc.com,
 jrtc27@jrtc27.com, ben.dooks@codethink.co.uk
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 jszhang@kernel.org
References: <20250221000924.734006-1-cyrilbur@tenstorrent.com>
 <20250221000924.734006-2-cyrilbur@tenstorrent.com>
 <9a94c74f-4826-479f-aaa0-e87b3bfd30ff@ghiti.fr>
Content-Language: en-US
From: Cyril Bur <cyrilbur@tenstorrent.com>
In-Reply-To: <9a94c74f-4826-479f-aaa0-e87b3bfd30ff@ghiti.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/3/2025 12:28 am, Alexandre Ghiti wrote:
> Hi Cyril,
> 
> 
> There is a bunch of checkpatch errors to fix, see https:// 
> gist.github.com/linux-riscv-bot/98f23fd1b04d6da7c23c6cb18245a158
> 
> Why isn't there an implementation for unsafe_copy_from_user()? Let's 
> take the following example:
> 
> user_access_begin()
> unsafe_copy_from_user()
> unsafe_get_user() <==== This one will fail since unsafe_copy_from_user() 
> -> raw_copy_from_user() -> __asm_vector_usercopy() which enables and 
> disables the SUM bit.
> user_access_end()
> 
> Another thing is that with this patch, we lose the vectorized user 
> access functions, can you fix that too?

I've just been looking at doing that. I think teasing out an 'unsafe' 
style vectorised version and shoehorning it into this patch will be too 
much.

Would it be possible for me to do this as a separate series? I'm 
motivated to have this happen - we have a vector unit, we'll definitely 
want to use it.

I will add that a 'standard' copy_to_user() would still find its way to 
calling raw_copy_to_user() and so could be vectorised if all other 
criteria are met.

Thanks,

Cyril

> 
> Thanks,
> 
> Alex
> 
> 
> 



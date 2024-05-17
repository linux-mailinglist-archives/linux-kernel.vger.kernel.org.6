Return-Path: <linux-kernel+bounces-182297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0CD8C8953
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F86A1C21EED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC4712CDBB;
	Fri, 17 May 2024 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JvPJME/S"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA8B8479
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715959664; cv=none; b=k8ldD7H3Z/ZgnWVB/wwTytwQ/ffdkrxujlszCObfyoFetOUGiY9D88cup1aA0fGdSIRZZpvWIhe2RMPv3rcMT/SVurmNpS928FJ3dzSdgHFaDGJzdTBa4wWjLN5Co03hijB7loIN7Z/HkplmPY+ltblouV+0YC826Bq23InA/9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715959664; c=relaxed/simple;
	bh=WAuIDB4DY45M+bVTlaGSn+0hYnImjNyHWBTEeeC9auI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YNi8a3tvR94qgdFchiZvfIbt6aPqP5cyARFgZVWtl3zDndrK9of7C4h/8OfraoUHTxuC9PkiDSPIG1fo6VHZqKL0MZrVx97mhbLYl78zezGydTvlSaVtE1a8LpLkeLtX360B5uQjmF5RuEHn0XIzWsfdjzoFrQ7NRdLckOQwZn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JvPJME/S; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59b81d087aso436630266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 08:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715959661; x=1716564461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CYtZ7UWXlfZ7PHH7Ttm340cmOR2Qtx6Db26PJMdTdRc=;
        b=JvPJME/SiWE3Sxn+rLrGVrI5QjVGc0H9557fUUEyM9zDJtHk3MhF989Hyp2ivZ4OIM
         IOxNcDKFmIY2Q2GNeKqBbiENIhUI+s7DI88Ugy7noBoriHxlPBkLXJgF0TY/ogwMl4tD
         RYB6GlJ0RC70RGDRfnbFmS5YGN3sLx0UdBC4YPID7xF9iHJPnQRJxPNOm7dQpFOs+VIh
         L1qtVwv5co7HbcqRRw8dKqq9tERn0jypwmhQ+nUAQaffjeoco5q4SojuEx57R2zL4bdn
         SyOa4dUNGXJ6Ae/3LbK5CJcdqy8DDaIS9jk9DQXMe16aP3VdfVS9jg7EBxrLcSk8wfZa
         UeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715959661; x=1716564461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYtZ7UWXlfZ7PHH7Ttm340cmOR2Qtx6Db26PJMdTdRc=;
        b=X/tQCEgojuVnSJl/U2pqjnxTlASUhpNdSiDRPhkCkI05y7m4dbk1ylwe/lYU8PMsQc
         9y1m3D/k1K9GF5NHKYWC0F+Huze3azCnVwxAkWokcmjztvvCMmNu+OxRYlx9VqYxCB3e
         u9qT3axzrjlPfbL16w42j0c7rbhWxL48ZN8rdJsgrurnmWE+h7y7GR5Df8lnQx67BgDC
         LuYLeSgHH/Shw/pi5vugdVbd+zl55tEKff8zE4jHcBjr7riqK/xmnVVJ1qdDArK0BS3P
         Q06AlsTwibxLz4/r+xtFCJKgzrVmqpabj5ak6V9fQBCsIcyGvd+SQd/kZtguwl926MGS
         RGzw==
X-Gm-Message-State: AOJu0Yx3ZiT7Z4bDM/lczt0ZV3KBrhGV3ektC1TeTc+yd869T2UHrgVo
	scbB5RjvZG66Xhcf1XkyWkMWGGdAWSqZaF3lVo+DPkhndgXHAqxt7rKSBc2N0aA=
X-Google-Smtp-Source: AGHT+IEC/tVX5gdvgjdMELjSwKwhEoU8VoXbtk3n4tBN5yocUeBR05+5b+4MM+ubgkd9fbBP9nWoaQ==
X-Received: by 2002:a17:906:3551:b0:a53:ed1b:f3ba with SMTP id a640c23a62f3a-a5a2d572c03mr2111033966b.28.1715959661067;
        Fri, 17 May 2024 08:27:41 -0700 (PDT)
Received: from ?IPV6:2003:e5:873c:a500:6aaf:b7a7:7c29:ae5c? (p200300e5873ca5006aafb7a77c29ae5c.dip0.t-ipconnect.de. [2003:e5:873c:a500:6aaf:b7a7:7c29:ae5c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17cc5sm1118947466b.205.2024.05.17.08.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 08:27:40 -0700 (PDT)
Message-ID: <c0067319-2653-4cbd-8fee-1ccf21b1e646@suse.com>
Date: Fri, 17 May 2024 17:27:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/kvm/tdx: Save %rbp in TDX_MODULE_CALL
To: Dave Hansen <dave.hansen@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
References: <20240517121450.20420-1-jgross@suse.com>
 <ohvjbokpaxagc26kxmlrujab7cw3bekgi5ln7dt46cbsaxcqqh@crvqeohfazmf>
 <f63e1217-3dbe-458d-8c14-7880811d30ba@suse.com>
 <2a2guben2ysyeb43rzg6zelzpa57o24ufai3mi6ocewwvgu63l@c7dle47q7hzw>
 <03d27b6a-be96-44d7-b4ea-aa00ccab4cc5@suse.com>
 <fc0e8ab7-86d4-4428-be31-82e1ece6dd21@intel.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <fc0e8ab7-86d4-4428-be31-82e1ece6dd21@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.05.24 17:16, Dave Hansen wrote:
> On 5/17/24 07:44, Juergen Gross wrote:
>> Just another data point: Before using this machine I was testing on
>> another one with older firmware. That one really didn't support NOM_RBP_MOD
>> and I needed to build the kernel with CONFIG_FRAME_POINTER enabled to get
>> past the check you are mentioning above.
> 
> For all intents and purposes, the modules that intentionally clobber RBP
> don't support Linux. If buggy modules are accidentally clobbering RBP,
> we can debate how much the kernel should bend over to accommodate them,
> but my preference would be to ignore them.
> 
> I'd much rather put a deny list in the kernel than try to tolerate RBP
> clobbering universally.

Would you be fine with adding a new X86_FEATURE (or BUG?) allowing to switch
RBP save/restore via ALTERNATIVE, controlled by a command line option?

Or maybe by adding a new CONFIG_TDX_MODULE_CAN_CLOBBER_RBP (probably using
a shorter name) option?

TBH I'm slightly puzzled that the firmware I'm using could make it outside
Intel. I'm fearing this might happen again.


Juergen


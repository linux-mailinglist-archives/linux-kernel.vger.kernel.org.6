Return-Path: <linux-kernel+bounces-566812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61266A67CD8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60BFA883267
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CFB211A3D;
	Tue, 18 Mar 2025 19:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="uyDZTQCE"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23BA211710
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742325004; cv=none; b=GCQ4B6JzxplJZZfHgGOwn/PCN+xSgBEQ+tRiuZQSZPZT7+3UsU2PtCMZi0o4vsm2cOs2rA0ZNIjouc/p/tj6VVl+etjJGgHcky9RktxBh7WY0Vbh2UKSerLMpeQCLw5PP9WQp4aEwklBqZmpxftmUiHHVvpB5pi+qyOirHPDNfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742325004; c=relaxed/simple;
	bh=ZFKiEj2ew+I9p/lw2jBfSrAXWrBs9wQtztERiHSEaGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VmDyhKPGQmKfsrGO0j9YgPwu0Mg/sLtSoSTaftl7Y4wcQLpBa2ltctKbpXWjRP7wLg2Kmrd3BfUmpEdzVR1XQzLFxSq94TGT9HOZlpjeg75VH8I0IV3X8a/C9hQw3+Af3wksi6VFwxUHgzOsdEgxKXDJj4paKDvBYMJ5lJO00pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=uyDZTQCE; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3913958ebf2so4935155f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1742325001; x=1742929801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFKiEj2ew+I9p/lw2jBfSrAXWrBs9wQtztERiHSEaGc=;
        b=uyDZTQCEEI0HE7cz5YKDYBtEvnnatgjsSD07IXPU+ZU4J2YX2epqD78wjHlrDps2ch
         ZkUGasksNsh6zYJhVjetb3Egp7/qtFDXL9HeSmj0l5B5lyOkKjeVX9CiF1D1lpacu1ak
         kYarBL9OXgi1v1W5vPey3A9Mm5LbeP9z8hgTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742325001; x=1742929801;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFKiEj2ew+I9p/lw2jBfSrAXWrBs9wQtztERiHSEaGc=;
        b=qBQG0PM2pIS5pOGdYddDXERUPh/CoH0wu1O0lhbIccUoAx8HJeGYdiR3l47j9hAz+g
         Hre+NCEzQtEEtaIkXRAQMJE+KHL9NLgOwOFFR4rdzoqJjm8rnMUvvmn5WOyxI5x2Ed/6
         77knOlFsZrYIOc1HmuW/92BmsiiYOs3K5r8HsrsKsYD/hr9iiRHjOVNvCd8zCyF/rhZR
         zifT3sSmzkNHFPvd8+p1+6cfehU/SJdYXhMzfnzeqI+aV71/Ief0M3tEb2CRP+4Ey5Si
         fZmwlkDRFBUADI0k7Iu1lT+x3VwTPlxXkBIPmXeSEAbW5N2MdqNtFL/+IyxUGgxu/ljx
         43tA==
X-Forwarded-Encrypted: i=1; AJvYcCXcVGZ5Ruhs/naJcjTH9bAfH3WKLCy9B5a5YhJgKmBt2GdmbOYfC34g6LEfems/SHvNeqIQF3WqflWWzsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2cjB1FpmK3UJpGiBgcch849g9CyGFAECt8/Qn1rCGh2zOPG99
	ZAJe2rXvarh7QOgCTa9rsgZan0rrMeIwxFV+bbNk0F5qx8VLgiClfmSO1KXqVi8=
X-Gm-Gg: ASbGnctd6d82ADqcZ43nskDdKnaMGtsX0/HNicHJmwH58VsYEzkJVIEjYPK/ld/sIZC
	k40uBc0TEfeKDaYQLiJldjNF74/q3aUUkBhSZVasTWT/7OLxRPDY+KtK9mK9TwGtz00YJmNlFdE
	tSDsFK0wD1oaJ/xU+LCHARSpKOTxlPjSWYyEUto+QGIKc+/k8A9CmAptK41opJjntrX8x0HMhl+
	zbk97nSXhH9yhyVYE+z1dq3CMqL5twOcGab74JsWmL3rfPEFcgr0Th10/j6SaI3qQlRhRGHgFHW
	ThaNhw7eVFe4NuqyJA6krVpqtDwyD5dVPxsvZqCXSvieYB1xCfe6feorD3Bel92xvkqbfiSpsmM
	Vvxd1E3Ka
X-Google-Smtp-Source: AGHT+IH63GbPQHU6er6BXNndKNo5TaK2ImdA5HBDWLgLyxF+IKvR+K9lQyOLj8jvUPlcPiGD9jhoAg==
X-Received: by 2002:a5d:64cb:0:b0:391:268:64a1 with SMTP id ffacd0b85a97d-3996b4a151bmr4759482f8f.48.1742325001066;
        Tue, 18 Mar 2025 12:10:01 -0700 (PDT)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c888152dsm18634484f8f.48.2025.03.18.12.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 12:10:00 -0700 (PDT)
Message-ID: <bb1d6eb7-7dc8-49be-a4b5-aa461e85ac0b@citrix.com>
Date: Tue, 18 Mar 2025 19:09:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] x86/cpuid: Standardize on u32 in <asm/cpuid/api.h>
To: "H. Peter Anvin" <hpa@zytor.com>, mingo@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Ahmed S . Darwish" <darwi@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20250317223039.3741082-1-mingo@kernel.org>
 <20250317223039.3741082-5-mingo@kernel.org>
 <5D7935C3-8CAE-4821-8E31-A43169B8CB83@zytor.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 xsFNBFLhNn8BEADVhE+Hb8i0GV6mihnnr/uiQQdPF8kUoFzCOPXkf7jQ5sLYeJa0cQi6Penp
 VtiFYznTairnVsN5J+ujSTIb+OlMSJUWV4opS7WVNnxHbFTPYZVQ3erv7NKc2iVizCRZ2Kxn
 srM1oPXWRic8BIAdYOKOloF2300SL/bIpeD+x7h3w9B/qez7nOin5NzkxgFoaUeIal12pXSR
 Q354FKFoy6Vh96gc4VRqte3jw8mPuJQpfws+Pb+swvSf/i1q1+1I4jsRQQh2m6OTADHIqg2E
 ofTYAEh7R5HfPx0EXoEDMdRjOeKn8+vvkAwhviWXTHlG3R1QkbE5M/oywnZ83udJmi+lxjJ5
 YhQ5IzomvJ16H0Bq+TLyVLO/VRksp1VR9HxCzItLNCS8PdpYYz5TC204ViycobYU65WMpzWe
 LFAGn8jSS25XIpqv0Y9k87dLbctKKA14Ifw2kq5OIVu2FuX+3i446JOa2vpCI9GcjCzi3oHV
 e00bzYiHMIl0FICrNJU0Kjho8pdo0m2uxkn6SYEpogAy9pnatUlO+erL4LqFUO7GXSdBRbw5
 gNt25XTLdSFuZtMxkY3tq8MFss5QnjhehCVPEpE6y9ZjI4XB8ad1G4oBHVGK5LMsvg22PfMJ
 ISWFSHoF/B5+lHkCKWkFxZ0gZn33ju5n6/FOdEx4B8cMJt+cWwARAQABzSlBbmRyZXcgQ29v
 cGVyIDxhbmRyZXcuY29vcGVyM0BjaXRyaXguY29tPsLBegQTAQgAJAIbAwULCQgHAwUVCgkI
 CwUWAgMBAAIeAQIXgAUCWKD95wIZAQAKCRBlw/kGpdefoHbdD/9AIoR3k6fKl+RFiFpyAhvO
 59ttDFI7nIAnlYngev2XUR3acFElJATHSDO0ju+hqWqAb8kVijXLops0gOfqt3VPZq9cuHlh
 IMDquatGLzAadfFx2eQYIYT+FYuMoPZy/aTUazmJIDVxP7L383grjIkn+7tAv+qeDfE+txL4
 SAm1UHNvmdfgL2/lcmL3xRh7sub3nJilM93RWX1Pe5LBSDXO45uzCGEdst6uSlzYR/MEr+5Z
 JQQ32JV64zwvf/aKaagSQSQMYNX9JFgfZ3TKWC1KJQbX5ssoX/5hNLqxMcZV3TN7kU8I3kjK
 mPec9+1nECOjjJSO/h4P0sBZyIUGfguwzhEeGf4sMCuSEM4xjCnwiBwftR17sr0spYcOpqET
 ZGcAmyYcNjy6CYadNCnfR40vhhWuCfNCBzWnUW0lFoo12wb0YnzoOLjvfD6OL3JjIUJNOmJy
 RCsJ5IA/Iz33RhSVRmROu+TztwuThClw63g7+hoyewv7BemKyuU6FTVhjjW+XUWmS/FzknSi
 dAG+insr0746cTPpSkGl3KAXeWDGJzve7/SBBfyznWCMGaf8E2P1oOdIZRxHgWj0zNr1+ooF
 /PzgLPiCI4OMUttTlEKChgbUTQ+5o0P080JojqfXwbPAyumbaYcQNiH1/xYbJdOFSiBv9rpt
 TQTBLzDKXok86M7BTQRS4TZ/ARAAkgqudHsp+hd82UVkvgnlqZjzz2vyrYfz7bkPtXaGb9H4
 Rfo7mQsEQavEBdWWjbga6eMnDqtu+FC+qeTGYebToxEyp2lKDSoAsvt8w82tIlP/EbmRbDVn
 7bhjBlfRcFjVYw8uVDPptT0TV47vpoCVkTwcyb6OltJrvg/QzV9f07DJswuda1JH3/qvYu0p
 vjPnYvCq4NsqY2XSdAJ02HrdYPFtNyPEntu1n1KK+gJrstjtw7KsZ4ygXYrsm/oCBiVW/OgU
 g/XIlGErkrxe4vQvJyVwg6YH653YTX5hLLUEL1NS4TCo47RP+wi6y+TnuAL36UtK/uFyEuPy
 wwrDVcC4cIFhYSfsO0BumEI65yu7a8aHbGfq2lW251UcoU48Z27ZUUZd2Dr6O/n8poQHbaTd
 6bJJSjzGGHZVbRP9UQ3lkmkmc0+XCHmj5WhwNNYjgbbmML7y0fsJT5RgvefAIFfHBg7fTY/i
 kBEimoUsTEQz+N4hbKwo1hULfVxDJStE4sbPhjbsPCrlXf6W9CxSyQ0qmZ2bXsLQYRj2xqd1
 bpA+1o1j2N4/au1R/uSiUFjewJdT/LX1EklKDcQwpk06Af/N7VZtSfEJeRV04unbsKVXWZAk
 uAJyDDKN99ziC0Wz5kcPyVD1HNf8bgaqGDzrv3TfYjwqayRFcMf7xJaL9xXedMcAEQEAAcLB
 XwQYAQgACQUCUuE2fwIbDAAKCRBlw/kGpdefoG4XEACD1Qf/er8EA7g23HMxYWd3FXHThrVQ
 HgiGdk5Yh632vjOm9L4sd/GCEACVQKjsu98e8o3ysitFlznEns5EAAXEbITrgKWXDDUWGYxd
 pnjj2u+GkVdsOAGk0kxczX6s+VRBhpbBI2PWnOsRJgU2n10PZ3mZD4Xu9kU2IXYmuW+e5KCA
 vTArRUdCrAtIa1k01sPipPPw6dfxx2e5asy21YOytzxuWFfJTGnVxZZSCyLUO83sh6OZhJkk
 b9rxL9wPmpN/t2IPaEKoAc0FTQZS36wAMOXkBh24PQ9gaLJvfPKpNzGD8XWR5HHF0NLIJhgg
 4ZlEXQ2fVp3XrtocHqhu4UZR4koCijgB8sB7Tb0GCpwK+C4UePdFLfhKyRdSXuvY3AHJd4CP
 4JzW0Bzq/WXY3XMOzUTYApGQpnUpdOmuQSfpV9MQO+/jo7r6yPbxT7CwRS5dcQPzUiuHLK9i
 nvjREdh84qycnx0/6dDroYhp0DFv4udxuAvt1h4wGwTPRQZerSm4xaYegEFusyhbZrI0U9tJ
 B8WrhBLXDiYlyJT6zOV2yZFuW47VrLsjYnHwn27hmxTC/7tvG3euCklmkn9Sl9IAKFu29RSo
 d5bD8kMSCYsTqtTfT6W4A3qHGvIDta3ptLYpIAOD2sY3GYq2nf3Bbzx81wZK14JdDDHUX2Rs
 6+ahAA==
In-Reply-To: <5D7935C3-8CAE-4821-8E31-A43169B8CB83@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/03/2025 6:48 pm, H. Peter Anvin wrote:
> One more thing is that we ought to be able to make cpuid a const function, allowing the compiler to elide multiple calls. (Slight warning for feature-enabling MSRs changing CPUID), but that would require changing the API to returning a structure, since a pure or const structure can't return values by reference.

It's not only the feature-enabling MSRs.  It's also OSXSAVE/OSPKE/etc in
CR4, and on Intel CPUs, the CPUID instruction still has a side effect
for microcode patch revision MSR.

There are a few too many side effects to call it const/pure.

That said, when experimenting with the same in Xen, there was nothing
interesting the compiler could do with const/pure because of how the
existing logic is laid out.  Removing volatile and the memory clobber
however did allow the compiler to make slightly better code.

~Andrew


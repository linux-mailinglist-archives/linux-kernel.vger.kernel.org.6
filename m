Return-Path: <linux-kernel+bounces-325751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C3B975DB9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1921F1F235C2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 23:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E81186E2C;
	Wed, 11 Sep 2024 23:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="WX62aGbp"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04F113C9C7
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 23:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726097733; cv=none; b=YNsUC1E1cLvK+txA8/cn2ZlhlUY+IQN9WrTj6cO4F8+8mKSbHXnnnQw66zpDAbGGlYJYmepE0cv74i5xZVA2VnXrn6kNfB5DO27d1nX2a89ouWASWdSBWeBHkLirDZk+z8zhPbkLqNPxHOieudsnl7fB8YQX/l/iLh8ayBn+4Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726097733; c=relaxed/simple;
	bh=z9t7GD3q7wH7nyRtL5NlLMDxo6BX1EFuWgnf9taMrzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8qohPCY9ADQW+hbcVBoCQkEo17ddIJ/4oucDjFWOPBcOKKGMqZlVde9Zy4jCQU9BnKqhPe3qiS5Pmm/ukHvkRu6NYRu0LxwRcm1HuOs0iZepOW/hcjbAhk6bwmkdI2OVO+KuvRpNBLBS3CAZO6wZBhA7Op7+CNDmvzGetJc/4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=WX62aGbp; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f761461150so5811431fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 16:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1726097728; x=1726702528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z9t7GD3q7wH7nyRtL5NlLMDxo6BX1EFuWgnf9taMrzA=;
        b=WX62aGbp1Kd1RVOYDlbIRLBVJtuYzkM6dX08txq4XunfOaOpcsedCQcr6QmgliqwUC
         Rtcq5lKJr17Lxl7P0jGodJ+3vNkxPPtPLNzOQukdKqIfcNRQXVAmpIupAjpWwhpdajlL
         GI+9+ki+ebSKoIH8oCH+HvycgQRRbxNhD8r2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726097728; x=1726702528;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9t7GD3q7wH7nyRtL5NlLMDxo6BX1EFuWgnf9taMrzA=;
        b=UxuM+24iqFP+CZ9xIt28viKfxaqHO5l+A5v5Bsgl/Dc/xvAvebmKRVZs3MNM3pBG9H
         38O5gNZ3lSN6RSrZiGMOSN4740WgpzBeIQWetgUWK8rG8iHnoPLTUTz62gxCK7Ymfb/W
         PzCdVdKcnvPT284pMHvRj9PkOnMFfl5LMsGkMHyhXUnSEm39JceWu/pLHcADx07ljKSx
         rN/JghYBOOS84n+9dWtgDixZz+ZXWTECJ/6cq4j64NDTqQdrMYuc50o9TCdWpxSc7ilf
         IQ7kObGHa9kyJuqlBicWkHqJ2eAxFIwxxr0PxxTgQHran2nrkY2idgCBT9GfIt683Las
         ATrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU5f18MPfLPGsn4+XsjZW1ehu8nS3ejvQJ9Q3wEY/pxV/Bbuaf707pMkXZds76VyFPgDhZzl2cnTuMTCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQrAE8u2nz+MTKpChdJuwWKM9d0qwG4Sxl8V0eb5XQz6O9NdDo
	SGYkpq+lVor65GPW0yT/CvV+CHMnMb5osoYr0g1saWMQIErfBX2QidsGvb/28Ks=
X-Google-Smtp-Source: AGHT+IHM1j/JtJaxt0lzpDPF8EzivlZK5vPMOg7xXw13mFkHwFoUErpayKv4CZeArZh2FQCGuDfGAg==
X-Received: by 2002:a2e:be09:0:b0:2f0:1a95:7106 with SMTP id 38308e7fff4ca-2f787f41c71mr6127761fa.39.1726097727059;
        Wed, 11 Sep 2024 16:35:27 -0700 (PDT)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25831875sm678430966b.11.2024.09.11.16.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 16:35:26 -0700 (PDT)
Message-ID: <04674df0-a026-42d1-aacf-293f3018329f@citrix.com>
Date: Thu, 12 Sep 2024 00:35:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] x86/fred: Clear the WFE bit in missing-ENDBRANCH
 #CP
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org
References: <20240911231929.2632698-1-xin@zytor.com>
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
In-Reply-To: <20240911231929.2632698-1-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/09/2024 12:19 am, Xin Li (Intel) wrote:
> The WFE, i.e., WAIT_FOR_ENDBRANCH, bit in the augmented CS of FRED
> stack frame is set to 1 in missing-ENDBRANCH #CP exceptions.
>
> The CPU will generate another missing-ENDBRANCH #CP if the WFE bit
> is left as 1, because the indirect branch tracker will be set in
> the WAIT_FOR_ENDBRANCH state upon completion of the following ERETS
> instruction and the CPU will restart from the IP that just caused a
> previous missing-ENDBRANCH #CP.
>
> Clear the WFE bit to avoid dead looping in missing-ENDBRANCH #CP.
>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>

Ah - good.  Finally some evidence that this hole in CET has been plugged
by FRED.

However, I'd suggest describing it differently.


By definition, all missing-ENDBRANCH #CPs are a result of WFE && !ENDBR.

But, in original CET under IDT delivery, any transfer for
interrupt/exception/etc that does not change privilege will clobber the
WFE state because MSR_{U,S}_CET.WFE is intentionally set by microcode so
as to expect to find an ENDBR at the interrupt/exception/syscall entrypoint.

In practice, this means interrupts and exceptions hitting the kernel, or
user interrupts, loose the WFE state of the interrupted context.  And
yes, this means that a well timed interrupt (to the precise instruction
boundary) will let an attacker sneak a bad function pointer past the
CET-IBT enforcement.

In FRED, the WFE state of the interrupted context (even if it is the
same privilege) is preserved and restored, in order to close this hole.

Therefore, the intentional #CP selfchecks need to clear WFE when they
are deemed to have succeeded, now that FRED is causing the state not to
get lost.

~Andrew


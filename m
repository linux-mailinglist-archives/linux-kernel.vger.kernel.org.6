Return-Path: <linux-kernel+bounces-564865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D98F0A65C0C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D9119A03A0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6101B4F1F;
	Mon, 17 Mar 2025 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="LyVWeNsS"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460241B0420
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235033; cv=none; b=r/4ZOfayvpV/ZPrk3+pm8AgxPsXim/h3y3ooHww+HOk03icUUGnGAMBIpCnujTavwjYGNgTBL0m6Et1YVt93HfxBnqWOUEuuj93xoIfZfKeatgzMHnJgHgRQ80HdqDq55I/GYG/m+MT1KbtQzN9fqN/4gg95F5behWnhZM+pytM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235033; c=relaxed/simple;
	bh=CVJOCHJfJzP/mZXBMgiM3WiL0WksiGocnoVR/Q7XAzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfY8nuDxDKuLJSOPVJNL7Bv90yJVk1AFt3T1QchfhsGHjYiol8jP8PSc7wHbp6fxGLwQeLb5lR/KIAFoodmnTGLNCYA+ezmqru4QE3bGDcRcaCgaZ3SodG0zBF4HxKc9QucdRPNL9qpX36iKANyp4gm0ziJuOwoC4Gddq5pamiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=LyVWeNsS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso17648075e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1742235029; x=1742839829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7PG+DSUNNqrDtOfspeMATb4wbiF406ODvqeweE5sJnY=;
        b=LyVWeNsSXWqeI13eHMFqsQShORGacPej5UKBF6Ty7TdKY245PqKGr3F9ZWjsY4lp5J
         BYzPlIkIrJ+q95u/kQa8/5+nBGK4g4YqW4YQU2Sgj5/QiEmn2oePAtDfXUqOHy4Qv8AO
         ng2l6wow5HAcsGU47NScIFY4yrxrFVJpPeNEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742235029; x=1742839829;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PG+DSUNNqrDtOfspeMATb4wbiF406ODvqeweE5sJnY=;
        b=Q4aCQ3cE6T8Z/RldnDYq4udNz5NfzWNq4vRLjwgxA7ITi4CraqRaNso82fmq7ovbD5
         9LPU8xgFR90gLD//a43EhyoPqiCuCjxk/8TFmHhOJdV8A3nZPI0AypzmHT/YhIpNMhLN
         6dkPVqsOoARJ0dbArBgdPDJ93CU01Uipu9aVANfnQsOJ5c9pMEn8q1lRmo2KNbXUhB0o
         P4+Iue8JAjA0Y49tdW+L/l8I8WH8X7WHClfzLzj+3BCD+S1JnncDQh+rEqMT0vTrXyqQ
         kEOd9Ow+jpb/ZCVRLT2wYIWfJyWTlngdNiyWAyIHzNqpAzfW8tqYhp4FN95cquwn7fZ+
         vCow==
X-Forwarded-Encrypted: i=1; AJvYcCU67HSK4Ze1MMDPouhImukxVJoI30F9u10YHX2exLfcNkNk47mVdxJhYoq5zMeon5dtP0S6fr8EeGxMX7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYXg6s9OtMeCFUS8995aaoGbG1QDxPHz7/MWK131HaFZYgRrN8
	99E0169w+JBWQVIH6tjqlAZFkGaSwCJ49A4Rm6d5XNqRDx5HMyAHZteLa8uvFys=
X-Gm-Gg: ASbGncvGCaJEOoGkm0xjCfUg3oZLRa0HBxoEJTSu1jnV8+4IvFYbFYUgyRgT+1GQJ3r
	LGjfkM2QXmFEl1BQEuLiqNkv6oU3gQTC69d0NyVkrK6nDY2QDeCguSZHrb0UoABpakry3bD27wl
	p6751rqhmn0J0iS00X+X3NmD7+b8snKxigvqPq8pJmbO1BxJnuPNOwz8B/Gg2EGt6XkSJ+EmZyF
	wWYPdulA5W8EAaMM5dDcJ/9PrD9fcuHKd6BluSewFIi8onJ0sp+GWW2v/j35JSLn/3Q0aqnxBL9
	5JS4xaatYHvl64Zfif9j2WKWYbw4zXPDP5lE/6Bn+bfCZX3mJqHz8VZ6agg7dDwWoALE70QHnAh
	47YCi6ZAr
X-Google-Smtp-Source: AGHT+IF0jpwwb7NnROn6rGqUzAtjNtG/HbHxw9ICAsr83jAN0VJNxhgmSiCFYIZ21rQH3TKyi5am9w==
X-Received: by 2002:a05:600c:154c:b0:43c:fd27:a216 with SMTP id 5b1f17b1804b1-43d1ecff43amr120475995e9.23.1742235029500;
        Mon, 17 Mar 2025 11:10:29 -0700 (PDT)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe658d4sm111134425e9.33.2025.03.17.11.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 11:10:28 -0700 (PDT)
Message-ID: <ccf47e0f-cd5e-4669-b75a-bbba9e56243f@citrix.com>
Date: Mon, 17 Mar 2025 18:10:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/29] x86: treewide: Introduce
 x86_vendor_amd_or_hygon()
To: Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
 John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
 x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
References: <20250317164745.4754-1-darwi@linutronix.de>
 <20250317164745.4754-2-darwi@linutronix.de>
 <20250317173216.GGZ9hcoDICYl1fBtBG@fat_crate.local>
 <20250317174848.GJ6888@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20250317174848.GJ6888@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/03/2025 5:48 pm, Peter Zijlstra wrote:
> On Mon, Mar 17, 2025 at 06:32:16PM +0100, Borislav Petkov wrote:
>> On Mon, Mar 17, 2025 at 05:47:17PM +0100, Ahmed S. Darwish wrote:
>>> The pattern to check if an x86 vendor is AMD or HYGON (or not both) is
>>> pretty common.  Introduce x86_vendor_amd_or_hygon() at <asm/processor.h>
>> So if we need to check "intel too", we do
>>
>> x86_vendor_amd_or_hygon_or_intel?
>>
>> Nah, this is silly.
> Would it make more sense to have a Zen1 feature and check that instead?
>
> Because, IIRC Hygon is simply a Zen1 copy.

AMD and Hygon the most often compared together, because the Hygon CPUs
are so close to Zen1/2.

One trick you can do to make this easier is to define vendors IDs as (1U
<< $N).  This leaves all existing code with equality checks working, but
also lets you check "vendor & (AMD | HYGON)" rather more efficiently.

~Andrew


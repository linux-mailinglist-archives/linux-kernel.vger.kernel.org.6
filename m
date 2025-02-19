Return-Path: <linux-kernel+bounces-522065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA41FA3C562
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 221E47A1792
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2B61E1C09;
	Wed, 19 Feb 2025 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Carv8L+i"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292AA2862B2
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983634; cv=none; b=uBYhFnk2nHnb31pLlujI+an62ZgrTSxWGvBvkq6/8L/pAoask7VRthoA8f5r9fDQ5+w+Ep56Tb/GM3ja+QPgF08pNh0o1BElxvBzeMI/uJuqPAbAcZ1EvnhlRwy5FqIsFwrjCmOvBTHSHRs5BIUFYP2Hrhc3FHqgpXRpnR0G7Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983634; c=relaxed/simple;
	bh=x/fvdGe4fM6GbOIaBXj8Y8Eg672/NmIBjJ0OnN2H+gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eVncbHMCxfg3FcgNaUEa/mGQQ07zH7Z+Nf1MeKVhpbHpw8ihhvlHlLIg4NdQMC8n2TeMvLWroNwjKZRdpQsVe3lSqUAM0qFWC616Bs/ABO2bNzmgXV5sD7qTdGMUKTBcOhe9jBkcqW6ONuwpjsvuybuUBEHj0jzKzfhqvT1gmeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=Carv8L+i; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43989226283so22702055e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1739983631; x=1740588431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x/fvdGe4fM6GbOIaBXj8Y8Eg672/NmIBjJ0OnN2H+gg=;
        b=Carv8L+i+b4fSSxN6v9RSePJ2kr7ElkaCw8cs67ZMNWZK5gBujQOMBeH6xH9rsIGbS
         nVQ+L4/LDUeEPtOiQsG26mmhLQRRflRuqKpMBEnlftZS0W4Xqk2ztW3agX2UMOpEUpgC
         7pC651cgXk+hx5thRdfqoyQiPOQXeSKkQHaBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739983631; x=1740588431;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/fvdGe4fM6GbOIaBXj8Y8Eg672/NmIBjJ0OnN2H+gg=;
        b=lDt4cq/CCORZH3IUa9LnTUtXsq7xlEXhHMIv1TNa5DXcbhm1HEWaY+2KO4qoFbOnIX
         axBZYaXWFrTIPVth8If+BmE4bCMgiRSIWlE28M/ZaBDPMNrH2Fncz47amoDJTZrWgY/k
         m6sJ+F7h6IXJZGOX6Yg3Gnds3p5D1Bl0roseW5ZP744syZjAU253XkrXbWocnf/wM4YN
         aEHgR4UsIatSAKCv1a5mMX1Nkw6Tc0mX14N00/YmhRgZbSM9wUwW19lYhfuDxX3se157
         Ydtwk4s0d/whtCAc1kdKN3zW64cvx1dYJC0fkLYpHtjDpxg0ZVfCG8r9JUmThISmGPT8
         /Mrg==
X-Gm-Message-State: AOJu0Yyi5RP4m6nhiHHyH2kovplU/V4pTdqHTrDierZX/cFsE2kKUhRt
	NavPdgja0XOXB3lOAN87iKnE0MN6A+dw6u+48Ex54WYO/NjIyMIufic+BISqdW4=
X-Gm-Gg: ASbGncuqWdiQmXkPH9ggbJLIMH4L7EE0NQbePQH6Lxv9d8LUJgLjEVQcegggSBVRIen
	wnrHNlyqw2ykaI/SBR3i9YNel4AmQnyO7xEbHUM29A/XUqPXgpI6Qr78ntgiqQjUyNM3iWFNXMZ
	58I+311jmDEAkzBGZsDsg9ZgIDZLR8xJc/yfTQxXPIhxv/iSbba0B5hwzovNkknrzLpLmYaIA01
	nhxtdOv0Sj2KPxJKYcpucL9d7ZLyGPrKHhYvCVkzC4x9RBtY5104lZ2wvQv9eGty92+9ZRQDvPS
	SaWRN6HbLL8vmnESSZGIW0qtQ3SewfjBR4z5T9Sqb6bvPoBsqia4+gw=
X-Google-Smtp-Source: AGHT+IErcedkwVwmzxaoluRvTv4nIw/hdVirsApP2PgEnRYV3xvQ2Qhjdn1Myy28aZGowRv9hPEh9w==
X-Received: by 2002:a05:600c:3541:b0:439:9c0e:3692 with SMTP id 5b1f17b1804b1-4399c0e3a83mr30344255e9.28.1739983631296;
        Wed, 19 Feb 2025 08:47:11 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25915146sm18554586f8f.56.2025.02.19.08.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 08:47:10 -0800 (PST)
Message-ID: <101d4be1-9090-4d3f-8f21-d1ab6ecb79cd@citrix.com>
Date: Wed, 19 Feb 2025 16:47:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/10] x86/traps: Decode 0xEA #UD
To: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
 scott.d.constable@intel.com, joao@overdrivepizza.com, jpoimboe@kernel.org,
 jose.marchesi@oracle.com, hjl.tools@gmail.com, ndesaulniers@google.com,
 samitolvanen@google.com, nathan@kernel.org, ojeda@kernel.org,
 kees@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
 jmill@asu.edu
References: <20250219162107.880673196@infradead.org>
 <20250219163514.581527735@infradead.org>
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
In-Reply-To: <20250219163514.581527735@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/02/2025 4:21 pm, Peter Zijlstra wrote:
> FineIBT will start using 0xEA as #UD
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

FINEIBT probably ought to gain a "depends on X86_64" too, or this is
going to go wrong in a very fun way.

~Andrew


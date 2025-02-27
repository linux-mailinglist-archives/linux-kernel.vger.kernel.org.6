Return-Path: <linux-kernel+bounces-537213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5D9A48937
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98423B4A5B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EDD26E658;
	Thu, 27 Feb 2025 19:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ihyOonte"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A17E1E3DD7
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740685791; cv=none; b=pAB7oLPfc96gySV2Mn7pOUPAwlVQSqKP+JzJfNXLnxpP1TugCb7lBSiMfRC0vzbo7epCIuzkISN1fAJ0WqYEYqcV8s9Yuin3aFdOBnYMH0ysz7Pm6sqdJBzsEyA+jlzhP0aiNVFN8nSrJ9JApf3Zo5CzqGnKphaaXyWlSdj9oa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740685791; c=relaxed/simple;
	bh=XnP5Q5NaTI2uQh+0H54ZF7+mJPH6YUq/p0TtLFICYiA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=qZ88yjYoyCFGsHUt6K+RdVGk3MMnBw1JmrGKDNEC7q7j1mkueBMczu8cBzcbCn249qB7dTMq7A6PO4MO/fa+PdPf5KezIOnJMF4nRrGLK9WpSzRkX/nCud1nkPc54P26u2gKfenLOz3kJd7v0j/AxB/79WQIqtxUiEP0bFrlZ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=ihyOonte; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4398c8c8b2cso14595315e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1740685788; x=1741290588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ivU8/2XDa6DusyTf1RdTOJIPkH8bpyxwj/mORydKA1w=;
        b=ihyOonteNVB8iy0crXblYZX7xWbC6Zhew57CpaJg0ZL60KBuB7lq+MitFITpN3IdVq
         2CshBslnogvzxsoD0OMYppdbMyQHj1/AkkEUOgbpJvRz/Nt2M7Uw5HiGfk8F2VZ0YA3d
         0rSGPTa1dL9tOrBqKHBulXpoNCdxEqQhX/1U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740685788; x=1741290588;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivU8/2XDa6DusyTf1RdTOJIPkH8bpyxwj/mORydKA1w=;
        b=EmVa5SmnX49MaeCsD3pTWMncji+B6Iz0Dk5Ct1XLmdY0XxEb5KwJTW9q4KaiK+7f5i
         jSsGLxRbtpadJ5casbQKMBt/yNufIcXs1EA6jBEKmRoWBTiBoUAzxJ//k0pAyYYDCSpp
         NlwiROAgFmLUN9ciPZOvgtu3MlOOeNxhc0sUvmzkMriGZq4pRUp87XwV345VFU6Qm9mK
         QockY34KuJpnXJY//L0/vSwqsKrQ4NbztYek6CYa2pMmyy7pET4Se/qNuocLCsCpR+st
         l6v7Y2JX/dsBfiR3xcJ2w2YOK01GBK4WcJlbds87JL8ggWBjU+FMMSp4dHOu8O4tARHG
         p4Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVmPwL/5ze/i21pyL7ybrP1TT0LwFOeHiULpgwD97Ywe4dc+ByXQCmjTQXM5jn77mMTz5jV8OEnJJbZRUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw33quUC/VfmEPwmTuCDUTDf5avY46E4tNVdTJVBPcAdOoogZ48
	EnFKb78ww6kLCnqMll2v4Gz+HDAYBMvlSLyoadBQ36yM8dNGdo9T8UD5ilXAMXc=
X-Gm-Gg: ASbGncvPCc7L40gd3gThrQS1eOYsU/7GMWkA6w5tMtlBpPwwlKb1MtozmG3To83EilY
	y5BA6KF53w3sR+akx4LZCbb7gxurigbtNvz2Frb6K29OfPvQoe3SFEyXM62dENn5ii9iE3rkFoU
	dkBJcX8dmiHOm7SV91o895pQfulSu9S1b6yeEq6hJoonduR8vtjp+wJ72xX8UztnDxwhah9rsjw
	B+pzfG40Fndwa6sukS6axGNdgnrC4hy80kBgfvGLxOLKciHJ4ABl6fZElEveTTnkp7DGQk3i9dD
	aC0TS9JJr4VRvpa6mlpwzymaTE0Xc/YBC5ga+R8dNYjnKqV+JQrfTGGKRaRIOnZWow==
X-Google-Smtp-Source: AGHT+IG2te1kUPc56csSytRh9Nbxn+k9TcKZ2Hi05w0xSW0gKmUlMU+n5A+MFiQaE7J8cDzx3ZYH2A==
X-Received: by 2002:a05:600c:1c1f:b0:439:9eba:93bb with SMTP id 5b1f17b1804b1-43ba67049b8mr5366965e9.18.1740685788324;
        Thu, 27 Feb 2025 11:49:48 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b736f839asm32947055e9.2.2025.02.27.11.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 11:49:47 -0800 (PST)
Message-ID: <94083f1c-dab1-4b57-bd45-a4d4f8ac262e@citrix.com>
Date: Thu, 27 Feb 2025 19:49:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: mingo@kernel.org
Cc: bp@alien8.de, chang.seok.bae@intel.com, dave.hansen@intel.com,
 dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
 tglx@linutronix.de, x86@kernel.org
References: <Z8C-xa7WB1kWoxqx@gmail.com>
Subject: Re: [PATCH RFC v1 02/11] x86/fpu/xstate: Introduce xstate order table
 and accessor macro
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
In-Reply-To: <Z8C-xa7WB1kWoxqx@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> I really don't see the issue:
>
>> There were basically three choices: 1. Reuse XFEATURES 3/4 (MPX) 2.
>> Create a new out-of-order XFEATURE 19 that reuses MPX space 3. Create
>> a n in-order XFEATURE 19 that needs XFD and an opt-in #1 risks
>> breaking old MPX code in weird ways. 
>
> This is a false trichotomy. ;-)
>
> There's a 4th option:
>
>    4. Reuse XFEATURES 3/4 (MPX) only on APX-aware kernels, keep it 
>       disabled for old kernels.
>
> Problem solved.

Forget breaking MPX code in weird ways; there's very little of it, and
it was distinctly of negative value.

What options #1 and #4 will cause is the virt people to come after you
with sharp implements for creating incompatibilities in an ABI.  The
XFEATUREs are the tag(ish) of the union that is the xsave buffer.

That said, I don't see why option 3 would need XFD support.  I can see
why Intel didn't want to cause APX-userpsace to need a ~10k legacy XSAVE
buffer, but that's not really about XFD.

~Andrew


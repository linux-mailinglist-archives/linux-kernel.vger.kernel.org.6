Return-Path: <linux-kernel+bounces-388950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEFC9B6686
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0960281FE9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A28C1F4FAA;
	Wed, 30 Oct 2024 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="UAsHcZ5l";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="YcSzkCjq"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB72D1E9071
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299917; cv=pass; b=rkocYM8pbrse7QFyFTlFPPpOB5J5+A+cHgPNNObymuqOnPbccdCQdFFmf8FJCM2WpsVo78k+pyFx4KxRBUDWuHMRBsFhbATm+2PgUkUbiYf+7I6WTPZVePJP59GSFZwCH8BJ3ULMKQUOk1CZauB6yW8URmnuzBhpnuSbwXPVLqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299917; c=relaxed/simple;
	bh=3jY8Kgy+LpuXlpppOKIHRBOb9u3OHZHuVCGhDVd7j3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0GJrebQsjJLpJdSI0OcjKweDaFO3I8+Uz6GaGABeHJFYSfTqze8fwlPSE45AW81FpfHkvcwEQYRkWcQhgBEp8wHQcgD3YcYsMRj5tj16BPArwVO9Ag3HgT4WtbU2G3/PphBEjRs2Y1p3D7PfcYfEC6EaNZvoSTFb9czxKH93eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=UAsHcZ5l; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=YcSzkCjq; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1730299906; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=a9tinMbquyoF1Dy5WGg69V3dWX3KgUMB5KOrsIHdkb2ZLQqh80DIKvh10hnwf6CQbj
    qJJKFuqy44YeOV8MAZpvJU+xqSMc/bxZXwSk1dCFE25EunkE9rMDbfORfSL03t0hhLFb
    k0FA8FZz1FKFYUfMIFX+voEVWpRkvXV+9WlaoT3aAyrnklZst5d8M7kerotDQwP5gXbl
    JScIHcYRkxuxykvSHQHC6E1CEpCtYQaRcSqjXjXlXiUUCzgYdcf3CinqLGS7P2ECmdxs
    h5krrxthQ1fJcqXz3cSXj+lpH6zDDQ1kb1TvpJZUx2JY+ev3WiBh3Lpdoz4OZOPYefsD
    vVvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1730299906;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=rWxzFi/jlSCefMxUC5ktlSzRn8EpKc/opsVKICOJOk8=;
    b=bKH+6Kmwzsy5+ZNfHixuZtvoPqCrYc5ZvXdDYmLFi1Z7AxEFLQtQoAbMarwKX74kzl
    GG8WnjLrxTFBjrcoA5n6kjPLIcBgIPJgZgCT3aqrj8uyfpF921aO/qb7tMWlb7/V0VaR
    txekqJBzxLzONVMCJBVUpOwl+aNwphWLsjoqLhYnzPCDLb2KQaorPmz8v2LjzimSKGOs
    xX9+EenRj6GgT9PQuvuir9+2wJaCrpw9a1G0ACd7g4Qb6Xcz4wOLPJyKyLO0mX+avN1d
    Mt1Cv1aWh9pljqb+qMEvXmIkuDFO2hSd4AZ4R1qKlBXS2F2ydAARXPmEpQexvkVtV8hN
    rjXQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1730299906;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=rWxzFi/jlSCefMxUC5ktlSzRn8EpKc/opsVKICOJOk8=;
    b=UAsHcZ5lk0vx616WWXPO+Y96W4ZtsjwOfWaQbM6FxHbT1dhtlYp7XWRebfdlGsaFQG
    ARdBZYUbTx1KOEErPCiWBoPOJIWvgXCOoLLvXwmnVJBW83ixDzec17GZX7e94mERgryo
    E3v96l/5Xoe/ne7/rXI+Jaf0Mh3rkc4+jXk/nBNC++tEfkJ+px/EqgZNiHaYdDs1eqXk
    MOzbn4a+fWBvwqTJuNxoH+TVKLxqbckXvTUTUcPzc31uaMRV8ijChEU8EYpZLk3ugtMu
    PY/ZJnk11UET3eGwdYghSGD3/M+FcEye0CeCh7l/dRNgcXC8emBf1tRi/gGdMqTO5hkC
    DHlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1730299906;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=rWxzFi/jlSCefMxUC5ktlSzRn8EpKc/opsVKICOJOk8=;
    b=YcSzkCjquztEOygVQN+Ad/DtPPaon72WCLD8VWOyk7LXHL8Mo2e1UZx0mWcxMtWTlm
    C/RQLN8c065++1XUg5DQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5000::9f3]
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id K63ada09UEpkLqV
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 30 Oct 2024 15:51:46 +0100 (CET)
Message-ID: <d6055bd1-c0c6-42ad-bb21-7ffad98c9882@hartkopp.net>
Date: Wed, 30 Oct 2024 15:51:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/21] can: bcm: Don't initialized an unused hrtimer
To: Nam Cao <namcao@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
References: <cover.1729864615.git.namcao@linutronix.de>
 <4e7dc11aa9ffb116678574889cda35b3cd5b7385.1729864615.git.namcao@linutronix.de>
 <203a1560-76c9-4c47-b1b8-b44ddf40cd16@hartkopp.net>
 <20241030121533.ioTNvYpX@linutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20241030121533.ioTNvYpX@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30.10.24 13:15, Nam Cao wrote:
> On Wed, Oct 30, 2024 at 11:49:49AM +0100, Oliver Hartkopp wrote:
>> On 28.10.24 08:29, Nam Cao wrote:
>>> The hrtimer "thrtimer" is not used for TX. But this timer is initialized
>>> regardless.
>>>
>>> Remove the hrtimer_init() for the unused hrtimer and change bcm_remove_op()
>>> to make sure hrtimer_cancel() is not called with the uninitialized hrtimer.
>>
>> NAK.
>>
>> There are several other occurrences of thrtimer that are not covered by
>> RX/TX distinction, where the second timer is canceled.
>>
>> This one-time init and cancel of an unused hrtimer costs nearly nothing and
>> is not even in any hot path.
>>
>> So this incomplete patch only adds complexity and potential error cases in
>> some 20 y/o code for nothing.
> 
> The "real" motivation is preparing to use hrtimer_setup() instead of
> hrtimer_init() [1] and deleting hrtimer_init() [2]. The new function
> mandates a callback function, and since the TX thrtimer doesn't have a
> callback function, hrtimer_setup() cannot be used.
> 
> Your concerns are also valid. So I can drop this patch, and use a dummy
> function to make hrtimer_setup() happy, like how it's done for the rt2x00
> driver [3]. It will make the driver a bit ugly, but it's obvious that it
> won't cause any regression.

Many thanks for your efforts!
That's a good approach!

Best regards,
Oliver

> 
> Best regards,
> Nam
> 
> [1] https://lore.kernel.org/lkml/e4ce3a3a28625d54ef93e47bfb02f7ffb741758a.1729865232.git.namcao@linutronix.de/
> [2] https://lore.kernel.org/lkml/7bde2762d82d30dab184c7a747e76afc41208da0.1729865740.git.namcao@linutronix.de/
> [3] https://lore.kernel.org/lkml/49f2bce487f56eb2a3ff572ea6d7de0a43560c0f.1729865232.git.namcao@linutronix.de/



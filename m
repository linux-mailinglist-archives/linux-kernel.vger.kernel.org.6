Return-Path: <linux-kernel+bounces-286555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98112951C6F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2258D1F21536
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF881B3723;
	Wed, 14 Aug 2024 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GPEMgoXs"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB9E1B32D1
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644025; cv=none; b=WYOFUjB14+WsCnUu4qn9klsM+y/tUyZ9GZZ92RHeqD65F+UrcLtb0PW60F5tMec6BYfRfY9eyNHSfs5R3YTzFJ0RyrL9SwBn9IdXmfMMS8liFLBeqSTV4mUhyDx+ygVNA+By5tfyuhSoROhyvstn8WmInAaNQT7MOU1vn2MDOTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644025; c=relaxed/simple;
	bh=Rm/3lW+0YffOquvhbtAmA9ex5ArcP5gTJnxyJkmvq/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oUZ+SO9aDLi4sPWB3f1F0OjtmrphzHoHGzbAqj2abSLU57r1lexLMScTPch4fygs48Z3csdUlOrlm/x/jXeGXKtW+K9kc3CR9YLuYSzPUUyMp/WPoCddPI5D28kSXLcSjksAVIeR+yGCKYtVYqu6M5o7/izCyWdG25Nw0wKK/Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GPEMgoXs; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-72703dd2b86so40411a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723644023; x=1724248823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pPPbcnH9ElDp0HrPGBFxxmp8KGuGyOIeFoZaRnlkCRk=;
        b=GPEMgoXsSmAEvWDQVhP2rFop9ZJNj/3fFNafVSOWaTwYSBOlJuKNzKXFQ9KwxG2bsL
         MczgC/FPJ8/gK9YONMDqMXYAhE9phmsVUK2C8Z5BQKKYipxOef2+wgIlXFjniDg1IccP
         kMNg5iFv6ARx+mU8XPwGQK9oFPTRIBbxadeHjetJ3Mxp+yZFsxMSiC8hUOkEEuoulVF0
         /qvVLc8bZk1RXo4s/y+YPWm1rokwlGI88+jTXLXqIgPq9tTjl8gWENDDSbLVyW0zOMuz
         JjLEgL4NKbq/X1de6faEUlJFErtODtoA9Z/t+6fKaEPDUExdBo9pt9n0/DLXbqppdYsN
         OKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723644023; x=1724248823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPPbcnH9ElDp0HrPGBFxxmp8KGuGyOIeFoZaRnlkCRk=;
        b=eLaM2+PCE4o9BroKWD2wjrOl1HMmswVIRu+liZLuTc+OfXlqZSk5ku0dXyME/mUhKy
         +bT25mX08p0SiWFpO7GpLzu+MPvgBYcS5Rmp/ebo+cDROv2HVa7oSbhLiQYmGspW/g0Q
         nfGbNS34c3Mnte6k2pN5ytpQUdrXtKBfxics9QlSzjXPR4nTFBZhsDqeEQZB+nmALlp7
         1y+ULx8JBx1hLM5EG81wULdynQiVQ8tb3X0gFz+7SBdjHwOTziNekk5Yg7+JTJ+dCRhS
         LgWragMicREyhZGNgrVr5ToIFdd9EIf6v7eZLRFaqIU3Kvgi/0RyMYhTwaMQQohrIdvu
         lLAA==
X-Forwarded-Encrypted: i=1; AJvYcCXFjMJegonjLAliPNK1QCFg/y67CiFbXO25mcQqWCNu+w/rGIWUWd3ksHK1ZjGdfMd/6x00AM1kTkINjowyQSeHvrmhZA+1G7RUoebI
X-Gm-Message-State: AOJu0Yw3a44FTR6w6Yp+rFnU02Mn8vO5iLN7QkGi3h36ROqOv386qhWg
	JnDtFa+MZv8SKf+RhXOiJONbjeV4admhV4fOdi03s0K8Vma44Qv6Tpsk1ersI18=
X-Google-Smtp-Source: AGHT+IFej6G9ENKms8sCLz4PlMZguobfmGkOJPwW8ux5QRbbPWvSalJ7KlkeiZXZ2VIdS4yhHVtNqA==
X-Received: by 2002:a05:6a00:3915:b0:704:173c:5111 with SMTP id d2e1a72fcca58-712673ee118mr2053455b3a.3.1723644022755;
        Wed, 14 Aug 2024 07:00:22 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58a0b5dsm7350482b3a.47.2024.08.14.07.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 07:00:22 -0700 (PDT)
Message-ID: <0f19dd9a-e2fd-4221-aaf5-bafc516f9c32@kernel.dk>
Date: Wed, 14 Aug 2024 08:00:19 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] softirq: remove parameter from action callback
To: Caleb Sander Mateos <csander@purestorage.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org, netdev@vger.kernel.org
References: <20240813233202.2836511-1-csander@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240813233202.2836511-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/24 5:31 PM, Caleb Sander Mateos wrote:
> When softirq actions are called, they are passed a pointer to the
> entry in the softirq_vec table containing the action's function pointer.
> This pointer isn't very useful, as the action callback already knows
> what function it is. And since each callback handles a specific softirq,
> the callback also knows which softirq number is running.
> 
> No softirq action callbacks actually use this parameter,
> so remove it from the function pointer signature.
> This clarifies that softirq actions are global routines
> and makes it slightly cheaper to call them.

Commit message should use ~72 char line lengths, but outside of that:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe



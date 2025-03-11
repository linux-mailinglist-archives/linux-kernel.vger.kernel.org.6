Return-Path: <linux-kernel+bounces-555291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 298DEA5B3B3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 01:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5FB6189321B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 00:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7246817991;
	Tue, 11 Mar 2025 00:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P676gk13"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADF92F56
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 00:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741653175; cv=none; b=mlW+fcWlIoMQWvghcka0R2nMoUd+5izhPqhyS2n9ywjHbbwlzm2sM1yUcqIyDJ2V2eX4HUMrTf+zPa/st1eFnSfoGWHQTaqP4+EkoGqT6B+ZrboVxbPUgqozb+NIxxzNC0DAAFx7eQJRuW2+KRwAC4XopiVF2zuWg+yi2sazohk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741653175; c=relaxed/simple;
	bh=VzdRAXVoKVmLJqAlDJYWoY9x50Z3i8HiRWx+ZRrGixY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCEI2JNg7O/TRd0qKQMIhKAWVs3yluTUE4OoQqwnFbMoE/ExkBF26h61xZhz7X8YNphr6iUsxZQh8Rh5IK22NT0kL8c/5IsCmMe2varGyLJsreWlEUUxc/xI8snZ3SZhTiR6t5HbvajT8IVP2jQHEX88tU92goMRVwTI/d3k00M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P676gk13; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so5014459a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741653171; x=1742257971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M+NqzMzHbZXk+h6w4tXrOYz6KUMPIha1ekpgVhvukzY=;
        b=P676gk13dYyFCCiJquT2OAovg33vmsCWEZZchho4xxukiYhAtHyr4kegOuJQu7NgDH
         6xtWRTqFWI0gC2DKSfKj+Z+iXGfUV95iZzcRfjUjr0q1eq3IAR3sO7g5GVnfUxwIRxRM
         e/pKcLCl1ECTIhBd6L1s98gBpkglk4sIaWym4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741653171; x=1742257971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+NqzMzHbZXk+h6w4tXrOYz6KUMPIha1ekpgVhvukzY=;
        b=tMi9ZVMEPimNER9BPVRYrGpzcjVms/G/YTATVHzJ5dgOfLTBqxuM/p2RKeaO1LRKSK
         fZ/drqoS/KLraWIsS7Yf3Hhycvdsa/gwcGgDPrsEdnqR3+MrjAztVkeyRoPFmKtqPbSM
         mHGrGoe0a4wwhKYRiGFBum5igxJQnEVrBYDowbXAEnC7s87YI+rUfNGBztGIHApXnh+V
         Fr8mWB9fDYbr7ftE4IAxQ9M7VgeptQJsfeqkrrV4nZvJV/T79ZfPPVrvNKHX2AB2czrF
         nQ97sIaqd/gGzhj1Dn7mflRI6ZpysGRxoD36JX9gYzixGGfwHGHa3nNYskuvV4VGupzo
         B3aw==
X-Forwarded-Encrypted: i=1; AJvYcCVd6ufxS6RmKyeIzVowmGIaEsTUr6XTf6SSGeDOJ2JkthLqqC19mQZrBo+2KA4m4k+dzPl8+smNyglEUHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX2zMyEWFwp5NAnkq/LWCRcJT1kQoIFCDFyjHhp7K/xR60U5CH
	RJ1oqSgt0mrcRNJrGnrekkscpdiRci+mJ6crYnSMFiSu9x7eZd3psu8BeLUL7rsy6XdCH3HoqzI
	JvfgnKw==
X-Gm-Gg: ASbGnct/KiXUQypVdTEcLfeMWi/Cy/7UEbr8VYXg1EqHySGJ6hoAF9JMv9Ze+ec6Jno
	ljkNvVxuoitsOnuzn21JeAFfAStBKQFJU6asaXN06XMYCxMi94QubQtehnEx4GC9JRnD/zk6e83
	Cqi3aOzh1QUVJf9zOUSIEWJjkO77t3UJzDG6qQYru/Usn3+3HZQwsaEB0u/DP/IPcn4xLGNm3yf
	i8pmB+dl3tG4R3TuPXFbfMZACZiAW1Qz96T4BAdcBum6uLXC63ALKIBmZGMr8hh/M+AP57qQ6wO
	x9MiYYWO5YiUnZ1WMJlAJXY4gcJDEE95fBLMYSFSIdJ5l7xJYDxYKWQehJ/8wsubHCrxDe3VxKk
	2mq10NdcT6LtIU+3mQXE=
X-Google-Smtp-Source: AGHT+IEKMjXSrwIq0sECKJbUgSy0nl9vV6plwg1DqweRBPZYxt0dYmWK4l0rpA6ENjqhPts3sLb+8w==
X-Received: by 2002:a05:6402:4617:b0:5e6:17d7:9a32 with SMTP id 4fb4d7f45d1cf-5e617d7bb68mr34408983a12.18.1741653171132;
        Mon, 10 Mar 2025 17:32:51 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2394826absm843298766b.55.2025.03.10.17.32.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 17:32:50 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso52836025e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:32:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVs0AfmMXItGGH9wdv85D3Z1vRSOfhrfhrBINJ3i7w4VRuZ6YMG8f32HI/eOiGwImiED1xpHFJm4JLxI2Y=@vger.kernel.org
X-Received: by 2002:a05:6402:4617:b0:5e6:17d7:9a32 with SMTP id
 4fb4d7f45d1cf-5e617d7bb68mr34370545a12.18.1741652794918; Mon, 10 Mar 2025
 17:26:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304102934.2999-1-hdanton@sina.com> <20250304233501.3019-1-hdanton@sina.com>
 <20250305045617.3038-1-hdanton@sina.com> <20250305224648.3058-1-hdanton@sina.com>
 <20250307060827.3083-1-hdanton@sina.com> <20250307104654.3100-1-hdanton@sina.com>
 <20250307112920.GB5963@redhat.com> <20250307235645.3117-1-hdanton@sina.com>
 <20250310104910.3232-1-hdanton@sina.com> <20250310113726.3266-1-hdanton@sina.com>
 <20250310124341.GB26382@redhat.com> <20250310233350.3301-1-hdanton@sina.com>
In-Reply-To: <20250310233350.3301-1-hdanton@sina.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 10 Mar 2025 14:26:17 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj6TE6axJzYURaq=zv2UNjm6ikRqN2HKgLHHRpB9XnEAA@mail.gmail.com>
X-Gm-Features: AQ5f1Jqtj243jyxEZTOcRM5xlgqlawFKyahf8z2U2YCV0F6kMW5dTuQ-rcMhxww
Message-ID: <CAHk-=wj6TE6axJzYURaq=zv2UNjm6ikRqN2HKgLHHRpB9XnEAA@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: Hillf Danton <hdanton@sina.com>
Cc: Oleg Nesterov <oleg@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, "Sapkal, Swapnil" <swapnil.sapkal@amd.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Mar 2025 at 13:34, Hillf Danton <hdanton@sina.com> wrote:
>
> The step-03 in my scenario [1] shows a reader sleeps at line-370 after
> making the pipe empty, so after your change that cuts the chance for
> waking up writer, who will wake up the sleeping reader? Nobody.

But step-03 will wake the writer.

And no, nobody will wake readers, because the pipe is empty. Only the
next writer that adds data to the pipe should wake any readers.

Note that the logic that sets "wake_writer" and "was_empty" is all
protected by the pipe semaphore. So there are no races wrt figuring
out "should we wake readers/writers".

So I really think you need to very explicitly point to what you think
the problem is. Not point to some other email. Write out all out in
full and explain.

               Linus


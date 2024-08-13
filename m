Return-Path: <linux-kernel+bounces-285433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C40950D6D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10BD7284B2A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDC61A4F37;
	Tue, 13 Aug 2024 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi0WMDrn"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9334125624
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723578881; cv=none; b=WYuiV2cqmfIDtog3IIxK5kZCH7X9cAgA34AS/h2lMJ726QlEKKSFWKCBQj4SY8894OlBHhkt1V++UmY8hOZSG+/zhTHiWxP4PMrut95u/AQFD6aJ34WhItc/1M/ZaNzlXe+8Hi5Io1e5Y+Ad0mnYPiQcWl5Mr3zMqxv4fD7z/as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723578881; c=relaxed/simple;
	bh=zUjDM2t3bwT39jUD5Qd0Sm1A/O0Q0Hhrjuks/PdvVNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRZrmhX9prq4BeXWYEqywjRbZGYpfaQZr3dnCkCnOoHiSh3AqdlxEJg2oAJg+ZBxBc5LCbhEdv+TxxS0FHubvvTlFUdOdvC+Dj3qYzP2vlrXjkAZw0dSZxGND5egaR8ukSRsYq9LTqDlgYJS+TqmSJpfdlqFnYNMDEy8k0AnZAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pi0WMDrn; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7c3e0a3c444so147469a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723578879; x=1724183679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwk6wx9vC+ScVyYTyHMlUIumRSBmsEhwVYcduyAvh+E=;
        b=Pi0WMDrnifK9VFAKeFhiZ8fSwlZ4MFlaMqKWfPtFmD2GUdG4TXUYhGLuT0RqCMy5Fj
         SZ5h782eAMsCl0jOHiZGdZDjT223H1x9gdBD0oMxkwAQR+LRQrbKtDULTIlnDEmMwnEZ
         FO0TzzHWoHor9jMBsEucFC9SDuydGVat6BvrmkWVnAZ1h5u6PSpjIn5qj/C1TKYRrsZt
         JwqS6K8dejpw/51bfJGXZPA8JnywnrD4pXSGg0zZpFbvlwDjUrsg9JTl9J5fHfWLcwXJ
         gbmUZN3GHsDQHm4g3RwQNq6WNFuD3ANmlNBN9jI9W8VUzQOtAGEmsvrcaFB5SJWKbv8H
         Acyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723578879; x=1724183679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwk6wx9vC+ScVyYTyHMlUIumRSBmsEhwVYcduyAvh+E=;
        b=c2c3eQjJ4c1da+XuL3yKjbOYOoiHjcx974g/CQFvycZIZv0Hoq0uph3hIYQinVWSzq
         KbFfTnUB63fyvYxNcZ5ePuYcMJdkOu20Wv1+To7s3UyIAMSZExszXskMV054c5dRc595
         OiIVpfrCUuC0kfRYnzPIfgztjiqiew2nGF/9GNxW4V1JOHJsv91ZHJYEFktIvHCVZmmm
         xo9vbdO4R2wd4+YyaJ8fGKn9lUdR9ihi/w22fc4dQu263WnqktKHcs9xo9nJXfOGJF1U
         haQkX/w9L8fsqi053amQEyNcpBR9RNa1HBaqSYmn/Zl0D6/N+qaaQUk5euqfDs2UNJWR
         mC3w==
X-Forwarded-Encrypted: i=1; AJvYcCXfFYemGS355yer2ILUjmeP5zUny6Htly9GraBqAhqyOblP0UVm9loCqmyPWklnL6dSxF6Qn3HCfzdDbamgLFd3EJyNCqPONi0Q+v6Z
X-Gm-Message-State: AOJu0YxZGF6Fk4unGLsuGv6KtOQ5OeKR64bs79aPAYiCOCW5esLwf3Ya
	uAWFFuvLCSKUK/BWvuDewvfRbVekbNJLz8Idh6EV8RawnXIMEJInITs6nA==
X-Google-Smtp-Source: AGHT+IEdTlaCsI2FvXGKEYj1hs2HCjrGDzHcDUc4cpjDAoO5WOxcn4mBwOPs6pokq+qoZLXxidMsLw==
X-Received: by 2002:a05:6a21:3414:b0:1c2:8a69:338f with SMTP id adf61e73a8af0-1c8eaf48892mr1162299637.12.1723578878680;
        Tue, 13 Aug 2024 12:54:38 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a43e48sm6270789b3a.98.2024.08.13.12.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:54:38 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 13 Aug 2024 09:54:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: void@manifault.com, linux-kernel@vger.kernel.org
Subject: Re: [sched_ext/for-6.11]: Issue with BPF Scheduler during CPU Hotplug
Message-ID: <Zru5_UmEmWhNaPyo@slm.duckdns.org>
References: <8cd0ec0c4c7c1bc0119e61fbef0bee9d5e24022d.camel@linux.ibm.com>
 <Zo3PgETt43iFersn@slm.duckdns.org>
 <dde4b09001da2641f9679b9409727e2147c5e9a6.camel@linux.ibm.com>
 <daf2370f5456cbf1660bbdc13621559fb3f2f6cc.camel@linux.ibm.com>
 <Zq1NksrG9blyN-KR@slm.duckdns.org>
 <e3069da05fb1676f8faad88b9a4dfc4a6cef4175.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3069da05fb1676f8faad88b9a4dfc4a6cef4175.camel@linux.ibm.com>

Hello,

On Sat, Aug 10, 2024 at 11:54:24PM +0530, Aboorva Devarajan wrote:
...
> Sorry for the delayed response, I just got sometime on the machine to
> run this test.
> 
> I applied the patchset on the latest sched-ext (for-next) branch and
> tested it, but the issue still persists. I did the test on a PowerPC
> system, as it is easier to reproduce the issue there compared to x86.

Bummer.

...
> I'll see if I can collect more details, and if there's anything else
> you'd want me check, please let me know.

Can you trigger sysrq-t when the system is stuck? Also, can you see whether
the problem is reproducible on x86 w/ the wq changes applied?

Thanks.

-- 
tejun


Return-Path: <linux-kernel+bounces-235071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 918C491CFA3
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 01:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052CB1F21949
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 23:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FD64086A;
	Sat, 29 Jun 2024 23:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="cTeMCaXM"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72FD381C6
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 23:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719702790; cv=none; b=mmoPwa3zxBMLGfQEAII5cP0vXw4YvbUONtl37LZt0h/z4LYj7fqh3QiZzahIgexS8U+frAKmlj9MrbZj3N3bNMKT8Avd6I1/qfPfrTZbO2fehQ4g2Jx9vr8WxvSEKbTuGCwQNMVq5F9CtzghZgEQJNJZO0L0vESNNqbbzwyOCgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719702790; c=relaxed/simple;
	bh=j5qcz0h0i7y7MHjm97bA/C9ZOybm2ojCQT0cECZ6HWQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UKG3j3FZpO6rx+cHs3973Nin7g04dSIIXfBoExNrwCd1GvNjs72kHviwxxLdsgZ16bMDsnL7q+8Zz6CcFOOXTGFSBv7iOHY8mBO7vIDTQ7fszorCPtTfe+5wv0hxqM7jCxUI3C2oCFwpuqmb5iqf6V6ZGkNPpUnWtNQAxqnrxXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=cTeMCaXM; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70a078edb8aso708204b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 16:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719702788; x=1720307588; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61AgYHQFGvAbz2ESicTT6Rs+7JqvueyMAM0eFC+Kxrc=;
        b=cTeMCaXMrq1NE35spVXJdNDq3SPN93rhu546LV8WSOY5VNzbI3yY76tHOuh8HvnHyU
         I/Q8SzA8ih3X3G9mR63MuBaab4lVpIuj8JS05Wq4BwSC45WY/tL8WJZKx/avV7gGEh5t
         cH6TZ8AobyZ2irguPQQ0oVDrItpu85x5iahDglO9jqOEwqVmdmixxv1rf4un0T4FU5yw
         swosRm/CeACTYcpqDrmaOK+ZwAm1/3QBTy86fhjpUwwRFW1SwfdRo9hUfulml19UkJIG
         /3Dw4hULLRo0Tb4ys839aZi+csWSGviOXXO5MspfHvXkapPTVzD4k/TitnVabZZRMI/j
         as9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719702788; x=1720307588;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61AgYHQFGvAbz2ESicTT6Rs+7JqvueyMAM0eFC+Kxrc=;
        b=wXzWgnZt/GmY+xUne2bG4qdRl4CK+GCoytKMASrcyrKh5eit3J1V2ikSMB6MHgS3tD
         EmA//fkJjMyFNGw4mtmPBk2GZWA9DsrP9J2Bt8KjY/eYpND2Kn8JkI917rW4yoq3PzDJ
         VAzd7P0Jx3CXJ43Ixsly/U4aKvB3ESlO2ZjbAUL26GV/Orf5dlPtP1l9S8QqbGKvlJVv
         fGGrpkdls7C26VPbaix0mQfXAyJEpg7h+VMPSTRnInl0rX3U1npV3fTUfW8PEpncL5Ip
         UqrEoFSopqan/6QuRZh8B1+bgpfHCe87R/OQ382pFKO5XxfYYp9q7sLmuyB/NfebczRW
         cwLA==
X-Forwarded-Encrypted: i=1; AJvYcCW7e3/XhBQNIP6vycjy1a3oJWv/G3mPzd0gaxA9IbmpKe1mH9CZQIcgHZnT3axMrGxW4hUQHYldIAeLihxYwv3K0DSALQs1Q5s8VT/7
X-Gm-Message-State: AOJu0YzasPo2dR1ziPFrThWglHpY8XkeFqCkpHR9r2IbiKUXq99aXbbb
	2JU5NYG1W1MjVMXZYIX+U35mff55pfrQ/82K0Mt6JCijN29RITnpgerq98lhQ9s=
X-Google-Smtp-Source: AGHT+IHJthOWju7Ws1F8x2pg5oNjYrc1S6+E89JXVqRU7YKrZQ9Sci4NO/2dCX4rNOSOLK/TRzOcZQ==
X-Received: by 2002:a05:6a00:17a2:b0:706:938a:5d49 with SMTP id d2e1a72fcca58-708531f3569mr9890049b3a.14.1719702787954;
        Sat, 29 Jun 2024 16:13:07 -0700 (PDT)
Received: from smtpclient.apple ([2604:3d08:8e80:cf0:e96f:a4b7:9660:e524])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecfbe9sm3773222b3a.114.2024.06.29.16.13.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2024 16:13:07 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] timekeeping: Use min() to fix Coccinelle warning
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <87jzid7cmc.ffs@tglx>
Date: Sat, 29 Jun 2024 16:12:56 -0700
Cc: jstultz@google.com,
 sboyd@kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <E601C587-4432-472D-A13A-6C03E88BDD59@toblux.com>
References: <20240624062411.321995-2-thorsten.blum@toblux.com>
 <87jzid7cmc.ffs@tglx>
To: Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3774.600.62)

[Sending this again because editing a draft on my iPhone and then
 sending it from my Mac somehow messed up the message id and didn't show
 up properly on the mailing list. Sorry about the noise.]

Hi Thomas,

On 24. Jun 2024, at 23:36, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, Jun 24 2024 at 08:24, Thorsten Blum wrote:
> 
>> Fixes the following Coccinelle/coccicheck warning reported by
>> minmax.cocci:
>> 
>> WARNING opportunity for min()
> 
> I'm fine with the change, but not so much with the change log.
> 
> You cannot fix a coccinelle warning. You can only fix the code which
> triggers the warning, right?
> 
> 'Opportunity to use min()' is nothing else than an opportunity, but
> what's the benefit of replacing correct code with it? What does this
> fix?
> 
> It fixes nothing. So calling it a fix is confusing at best.

I think it's pretty common to "fix a warning" -- there are thousands of
commits in the kernel using this wording in the summary alone -- even
when the change doesn't actually "fix" anything other than removing the
warning.

However, how about 'resolve' instead?

timekeeping: Use min() to resolve Coccinelle warning

> What you want to say is something like this:
> 
> Subject: timekeeping: Replace open coded min()
> 
> Replace open coded min() because $GOOD_REASON
> 
> Discovered by minmax.cocci
> 
> $GOOD_REASON is not 'coccinelle emitted a warning'.

Removing a warning can be a good reason in itself to refactor code,
because fewer warnings make "real" warnings and potential problems
become more noticeable and thus more likely to get fixed. In short, it
improves maintainability.

To me this is obvious, but I'm happy to add something like "refactor
code to remove warning and improve overall maintainability" to the
commit message.

Thanks,
Thorsten


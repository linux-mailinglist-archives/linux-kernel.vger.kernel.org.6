Return-Path: <linux-kernel+bounces-336153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F6497EFCE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87441B21710
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE51419F40C;
	Mon, 23 Sep 2024 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QC2T+nEQ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7E319F134
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727111963; cv=none; b=Z1UVvMWY8WNSQ5alC9JmZVedkg5LVyev8uIP38P6UqojZPrZZl/9YGDQ3dtRDawtB8o568FH284TJLVL9HpXajTcX5idV1l5JyjIhPdnHc1+j7PWVoWrDoB6AQ3aO/KRZ3GVXutYxiBtBpoDhjIVdYYgyN+Lc36dJr2A5NFc7Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727111963; c=relaxed/simple;
	bh=8CzslkZb0sUznqump5kOXrXFXRvqNxrUKdCua2E89hI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7egL2rWZEd+pruLs4BvtYfT7EodpwrS401frpIm2OtLUxMKQnLbt1JSNaZxKh2dSOJhh9+NhwdGXukDNtTuLWtNi65acP9EI+9RYMKN617JBwpmIVNniMKVaouWVLkc0/ZUAUtygyE99pogVdOXDijDwJByGemVI/1FSBSwpN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QC2T+nEQ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c5bca6603aso1750783a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 10:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727111959; x=1727716759; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/88YtmKHLqGAFWhvYULFA4aDXhjl5wiNzxfGpypDRso=;
        b=QC2T+nEQ4zjm1hAyc8Ust5SwR2l6+krMKc6TwZOyxoTy5ejx5G+/lCixQ7eEH9+xU6
         +TyMoBepH2b7ooGUZ5to8kDCm4kM2txTsZpErLjXqIP9LP6qtlmXMko6zMeRT9dHOt6I
         0om6YGh05gsSkwzdWTPuj/oOapBu5qa00OLp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727111959; x=1727716759;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/88YtmKHLqGAFWhvYULFA4aDXhjl5wiNzxfGpypDRso=;
        b=W2ea/mtXTAEay0D8pYfWIL9lk4tkhPZ3pPuKb1fA3gKVPdt+PefnMDkbgWwA7W6Tde
         4M+bT7zLGRQZeHL3AHRHdZhqhlpzbwMl4c0Yi0g9n0zw14JxKPnXcsesN28THAzIwWjL
         9OMaHorKPbHY3PgPZBX5p/+pcw5IH062qhF0eJLrsVqXWyJTsi0wkpd/d4HF0KzSynR9
         A9Qq6sKIRsRYpPOQX9rhiWPzRacjeoEb7D0Ulo0I9zS3K/WbE+LT7WElQzvNrnq3Uxoh
         p/dWEiKWnEcp4obtojXKSgDk0uhit8G4drwQ4S8B7XEUrByUTwkE7ptw+a6a8AKVn/uE
         dR/A==
X-Forwarded-Encrypted: i=1; AJvYcCWfKuW28UWfBCVjGMXGqcNcNlrRmMzsVLuX1zzJ9VuWICDBtdUBOim5QeWZKg9jAiU+kLUBPYU7hX04MQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhHRaKAvM0lZ1flmxC7d4yRY27cSJiWjDsunvRQgs9bcd9cpBf
	TJzEYp4J7/d8r8OJL/mHoUuNk2073Tksd08jFUyXwndhLgEUhFgmxmC50oveJ2XC3HNuJGQ23Gg
	Dny8=
X-Google-Smtp-Source: AGHT+IEJqVjW957xFzVzk3IsfONTp0QVPM0g0RJUk/2Ik/DEL1aix4f9e0MFLLVyC9W3Kz6T/DawXw==
X-Received: by 2002:a05:6402:3588:b0:5c4:2b73:636d with SMTP id 4fb4d7f45d1cf-5c464df28efmr9267627a12.35.1727111959490;
        Mon, 23 Sep 2024 10:19:19 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb8a218sm10648146a12.62.2024.09.23.10.19.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 10:19:14 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9018103214so669711466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 10:19:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzNCxiwUj/o1OmY5jL1DP3KeZEpUsOe2rmVYMYCArZQ3feO4YIDsaR601NKJeUDY31OjDOeM34YyMTd/M=@vger.kernel.org
X-Received: by 2002:a17:907:25c1:b0:a8f:f799:e7c9 with SMTP id
 a640c23a62f3a-a90d566c9bdmr1174018266b.2.1727111953883; Mon, 23 Sep 2024
 10:19:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
In-Reply-To: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Sep 2024 10:18:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
Message-ID: <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 21 Sept 2024 at 12:28, Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> We're now using an rhashtable instead of the system inode hash table;
> this is another significant performance improvement on multithreaded
> metadata workloads, eliminating more lock contention.

So I've pulled this, but I reacted to this issue - what is the load
where the inode hash table is actually causing issues?

Because honestly, the reason we're using that "one single lock" for
the inode hash table is that nobody has ever bothered.

In particular, it *should* be reasonably straightforward (lots of
small details, but not fundamentally hard) to just make the inode hash
table be a "bl" hash - with the locking done per-bucket, not using one
global lock.

But nobody has ever seemed to care before. Because the inode hash just
isn't all that heavily used, since normal loads don't look up inodes
directly (they look up dentries, and you find the inodes off those -
and the *dentry* hash scales well thanks to both RCU and doing the
bucket lock thing).

So the fact that bcachefs cares makes me go "Why?"

Normal filesystems *never* call ilookup() and friends.  Why does
bcachefs do it so much that you decided that you need to use a whole
other hashtable?

                   Linus


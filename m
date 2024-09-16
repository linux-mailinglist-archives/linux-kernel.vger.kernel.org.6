Return-Path: <linux-kernel+bounces-330756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7EB97A3D3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490B11F29118
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A3515C15D;
	Mon, 16 Sep 2024 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LTR0hKBU"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE63215ADB8
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495713; cv=none; b=n8lRdWggpRlNGqYYkDxFXdHtyrc5S4l0q2TLpBAXWtxCNcmZbz9jP6suolfBbGnUvp3V2e/YYsbfuTAs3+VtHYXbBlPzORtd6mpYLJ7siou5FbjziKUR4dOeE7E+xsMdkW39WBKbdE9LwU1E9fRrozksOWS0M01aKb/7fwRNW6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495713; c=relaxed/simple;
	bh=q8U5kapnvPe+kOauR5iQm9N3ZQpVBSaRPSAKBVrq7g8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdYUa6LUcsba4qaVtP0b7WK4keEQAyY3gY4br9FqkxVlV/kfDRzncEyc2u3oo4EZF06FkHim1SRxtXLr8mRX93oJg+1t460OZ3rr8QtoBiOcpnZvCQzvfVaFcYLOAJvd5ftkxd42xBKjLrGni8ciqCvVRcYP64IEcX/FpAsizDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LTR0hKBU; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c25f01879fso5257633a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 07:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726495710; x=1727100510; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QAADtAg3pKG46cUtxD35BjgID9lOK4j2QBKH3zg5m6Q=;
        b=LTR0hKBUh0VlpAKuyFHUwe98BsSrWM/Wd8yiNy5IlE0lwcpjJ8zmQBNU8mo6Ie6iT3
         eMjr+302IpdTvIsWY97Tjmo9GHvJzj+BkK3gakZBDUuNNg7IC5h+kHkbFrwKASV7Zxys
         KZYTw2mgxupq/soDjPlyuEfgBPbS+DvSUuPFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726495710; x=1727100510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAADtAg3pKG46cUtxD35BjgID9lOK4j2QBKH3zg5m6Q=;
        b=lNEO6mTSdT2Rcyr15rrvl9bPpOnkQB3v4Fv8yCCn3iOOrBpFhmPIRqbXu9fFjd1/b7
         8KIc/IAKlDIOSxsP4dBvVOGFk37Hy5XoJi1EuzgAYTonFohxMhtIWsEaZjheSlAZ/BYb
         Kr+VTbmI4KMugt9cHQ6es2FMSPqmSDpXD34aPfdLQPcFlB9+7XjBryVGXizJnwlTEWFF
         8nLLQndKw+INs5dgoBQ90Bvr0vWoK+Q7pw10xKx84zQJ0fKY7tEEV/iDOFRwZYgklbzO
         wUCyFXcL3JNLTk99BoZpqYHKbSppoXJ76akwcUrFN3OuXoTMnGMwDeX06l8KMIKZTNBA
         rl3g==
X-Forwarded-Encrypted: i=1; AJvYcCUGhlEhaVq+o84irwYN3t9JUzaGxkWECc9szofHcFsO5K3R4lakJHvcjQ+Qq3nrh0mqGgWwB2UmS+rnM14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8fweYenyqCw/evJ3tFCuSjdDK0i59wmMDY8bymjUf9A7ll8Jt
	N/N5nFMCNWpc7zLxB8e0e022cMC36241SF8AewNCQJTtDTt48jTLJEBqSLmK6zgMmhqPG0DATEA
	wBpOe9g==
X-Google-Smtp-Source: AGHT+IEm92EDmHZgq3jiqohk78lA0orx97ob26O8Y9dMZvcc6wspjUvl0eg6NfHzF5cHxI6LcIaXHA==
X-Received: by 2002:a17:907:3e9e:b0:a8a:7d13:297e with SMTP id a640c23a62f3a-a902966f405mr1578232566b.55.1726495709479;
        Mon, 16 Sep 2024 07:08:29 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061328e61sm321832666b.196.2024.09.16.07.08.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 07:08:28 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c3ed267a7bso5727983a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 07:08:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXgWVAJmv8peFMShXCdqawi6kkvH3Qu8Zk8yNeVzqILEoPevpDDHBknFYiXlNYFvBXwUqadRRyyjDUOc74=@vger.kernel.org
X-Received: by 2002:a05:6402:3209:b0:5c2:53a1:c209 with SMTP id
 4fb4d7f45d1cf-5c413e4c638mr14300449a12.25.1726495708331; Mon, 16 Sep 2024
 07:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913-vfs-netfs-39ef6f974061@brauner> <CAHk-=wjr8fxk20-wx=63mZruW1LTvBvAKya1GQ1EhyzXb-okMA@mail.gmail.com>
 <1947793.1726494616@warthog.procyon.org.uk>
In-Reply-To: <1947793.1726494616@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Sep 2024 16:08:10 +0200
X-Gmail-Original-Message-ID: <CAHk-=wiVC5Cgyz6QKXFu6fTaA6h4CjexDR-OV9kL6Vo5x9v8=A@mail.gmail.com>
Message-ID: <CAHk-=wiVC5Cgyz6QKXFu6fTaA6h4CjexDR-OV9kL6Vo5x9v8=A@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix cifs readv callback merge resolution issue
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Steve French <stfrench@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Sept 2024 at 15:50, David Howells <dhowells@redhat.com> wrote:
>
> Fix this so that it is "false".  The callback to netfslib in both SMB1 and
> SMB2/3 now gets offloaded from the network message thread to a separate
> worker thread and thus it's fine to do the slow work in this thread.

Note that with this fixed, now *every* direct call of
netfs_read_subreq_terminated() has that 'was_aync' as false.

The exception ends up being the netfs_read_cache_to_pagecache() thing,
which does that 'cres->ops->read()' with
netfs_read_subreq_terminated() as a callback function. And that
callback ends up being done with ki->was_async, which is actually set
unconditionally to 'true' (except for the immediate failure case which
then sets it to false after all).

Could we please just remove that whole 'was_async' case entirely, and
just make the cres->ops->read() path just do a workqueue (which seems
to be what the true case does anyway)?

So then the netfs_read_subreq_terminated() wouldn't need to take that
pointless argument, with the only case of async use just fixing
itself? Wouldn't that be cleaner?

             Linus


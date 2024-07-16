Return-Path: <linux-kernel+bounces-253860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D5D932805
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2751C223D7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDAB19B3C9;
	Tue, 16 Jul 2024 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H/EmzLpH"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE5F13CA99
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139093; cv=none; b=IvWiCRSSNH9L5iic3KerSwzFIMSm7hhzNCNthujp/enStIUbQeIjAjKU8v15ye1dJt5yNqdXTqV8hJt9MFX8ZxmKYwU1wZfhAWYjspzv0DJfXhJ2aMNC1gCYm0OxLzPv8JT/HY7y0bXd26aPAncCzwHUpWKoQD2oEHyXsS8Gt8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139093; c=relaxed/simple;
	bh=hO0GPFmh/HLMhCeNAbcbW/66SZs3FuNYPDv8kM1b5fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIjfAuMa2E2Zz6RqTfY5j7ctkBGiF2RlwJhQmSduBMWqUmOLXXzwznHh/+A2+n+J595Eyw1j/M74JkgJAm0KWc6F0AJ/YG7BAIOOP4EV1CIbhl0rmIh2EwzKrQmL+EC3X5MwHC1jxttvsWid8LT+OSe/h9mqgdSVWuXsMCYWCQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H/EmzLpH; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-78512d44a17so4045623a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 07:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721139091; x=1721743891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LMhrIhzKgKIGB9nzoEar7WI57bGhMjucU6qQ1Vl4qeM=;
        b=H/EmzLpHnbnNNdPgRgaOIcULvffr90HPSyqFBYxFLu8TOhNZa/gpMv350aqNdNAooH
         FhNl3Pnhh+fs2vyeKVHLah977cf3kHhSermKeMjcy6dWg1ezF9o2BgvAbyzQqhD6/V2b
         /2ld2r3myTKs72JmHJjyzAGr5SBcxFyaBRTzKndXDii1vkjWwUyDjLi84YPFgiMQBPsJ
         KRxR7oiwFKLBgCjDuiXJtgcJLkeg2FdFJwtQJNxckGK6FBg/63ogSvMm/5KR7pg0jElY
         VyBUKrJhez/3ZrTLbRmIcJrWdiGUJdBM+2hkPGWEHzusx09p4B8AZHe51H3k334rXVyK
         bsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721139091; x=1721743891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMhrIhzKgKIGB9nzoEar7WI57bGhMjucU6qQ1Vl4qeM=;
        b=AS9g1uXKoDQ5AbPn3orJACKrgMsjBQ+eGmumlIn9OFn1VWcdgDNHMBMoOt/fNQNtPe
         jN91Ny3UfC8klGi0Axt7n0P2EiUPvlDSuMG6wRjHXbiNYhwD8JB8pSDvCnOxXHPRMLsa
         MDXDzqY6r+Q6CrLq5SeXUI1BHbkuFMgwCQ4Nr6TkaMFcxiuSVR9cgIJk24JG7L5ED3A0
         96u9BJVQW6S40hCo0OtFtcjHDCpWpXuIypCiMIM/wsRtdO/z3b5+ukGhf6wVLefC7P5Z
         yPX6G53vt9vZvr3/b8wCEMqLQi1A29n5hNTaV1PqUUSRGUs5I1gnFRyyQ94hxx+NWRtR
         rcwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTk1CDO3NBN2zB/QkkUwSp+nIsb24NSDPKkcoXr4jJKnaaLJ0lfbptslBiDDJ41aTGkD8uQy8ebrCEWND3izyw/fxrlOWemZYTL2QW
X-Gm-Message-State: AOJu0YwM97GQARBMZzi84+LV7bjP/orJbs7eo4N/s20XIoA7V7rYfVAj
	mymnEeoWRFCjegsgJZ3//2ehDPWMmRkB+sIhQQPMmWlm+/zR4vYvuRQKso04Ew==
X-Google-Smtp-Source: AGHT+IFWO+xFFI3Lr3vgv5cXLwSpXJX+ZGbQfvEZyOjk6fVB+oNr+E43PHlKhaCRpcB6/npLwI487Q==
X-Received: by 2002:a05:6a20:a10b:b0:1c0:e329:5c51 with SMTP id adf61e73a8af0-1c3f1227571mr3066957637.13.1721139090933;
        Tue, 16 Jul 2024 07:11:30 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7da19sm6321904b3a.133.2024.07.16.07.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 07:11:30 -0700 (PDT)
Date: Tue, 16 Jul 2024 14:11:26 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Yu-Ting Tseng <yutingtseng@google.com>
Cc: tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
	surenb@google.com, aliceryhl@google.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/2] binder: frozen notification
Message-ID: <ZpZ_jva0L5DorZPh@google.com>
References: <20240709070047.4055369-2-yutingtseng@google.com>
 <20240709070047.4055369-4-yutingtseng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709070047.4055369-4-yutingtseng@google.com>

On Tue, Jul 09, 2024 at 12:00:47AM -0700, Yu-Ting Tseng wrote:
> Frozen processes present a significant challenge in binder transactions.
> When a process is frozen, it cannot, by design, accept and/or respond to
> binder transactions. As a result, the sender needs to adjust its
> behavior, such as postponing transactions until the peer process
> unfreezes. However, there is currently no way to subscribe to these
> state change events, making it impossible to implement frozen-aware
> behaviors efficiently.
> 
> Introduce a binder API for subscribing to frozen state change events.
> This allows programs to react to changes in peer process state,
> mitigating issues related to binder transactions sent to frozen
> processes.
> 
> Implementation details:
> For a given binder_ref, the state of frozen notification can be one of
> the followings:
> 1. Userspace doesn't want a notification. binder_ref->freeze is null.
> 2. Userspace wants a notification but none is in flight.
>    list_empty(&binder_ref->freeze->work.entry) = true
> 3. A notification is in flight and waiting to be read by userspace.
>    binder_ref_freeze.sent is false.
> 4. A notification was read by userspace and kernel is waiting for an ack.
>    binder_ref_freeze.sent is true.
> 
> When a notification is in flight, new state change events are coalesced into
> the existing binder_ref_freeze struct. If userspace hasn't picked up the
> notification yet, the driver simply rewrites the state. Otherwise, the
> notification is flagged as requiring a resend, which will be performed
> once userspace acks the original notification that's inflight.
> 
> See https://r.android.com/3070045 for how userspace is going to use this
> feature.
> 
> Signed-off-by: Yu-Ting Tseng <yutingtseng@google.com>
> ---

Thanks,

Acked-by: Carlos Llamas <cmllamas@google.com>


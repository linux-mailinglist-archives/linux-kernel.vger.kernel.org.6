Return-Path: <linux-kernel+bounces-557876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B84A5DEF7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45CD3A91E6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8458324E00B;
	Wed, 12 Mar 2025 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="W/zK0WwO"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5934124339D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789781; cv=none; b=bTiGj3e4x69YZpmGYO9zI8MZHbYMNYtz2qjnDAk/hjLu9wzZNKZkowNrxd5HmQImkLPE1DH5fLRyojzZ0qvC2HPGdtxsnAWKGF1oJJu+DY9En6N6+KIvBgDxkOg8HQVRoIeJVq4XMq6AWZxM3mKj5earepdvLNwMXOESLS1n+DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789781; c=relaxed/simple;
	bh=X8pxtdRpsPpZOYZuFTy8zEFwpuoZpgIK76UeyJOgRac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lq/tAj/+6Vb7HlKBpRtmJM/ghTW0VJVP5I4qJS7xUlzPiaSHGa0XsadWmpIWzmvyt7qSeQxeBALoY0h2g50f2L04qPAbnR73zcjyGbFg6afwQQ5dcljof3VMsgPDKnLydZcMSv6vHXN78eB7DjXQdLqycby7YPmPCt5v/hI3aPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=W/zK0WwO; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fec13a4067so10620479a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 07:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1741789778; x=1742394578; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X8pxtdRpsPpZOYZuFTy8zEFwpuoZpgIK76UeyJOgRac=;
        b=W/zK0WwOO4kMQ25plT/Y2wdMt1/k+vksfK6zlESMHcyPOMqJk7uL8WDDxp6nackrRm
         kquf9wldsLwU5W7sDnLtxeuj3/pHBo4xZ03rvRfAwWTFUxe2pLCmfFNin5IBGY8fOOfG
         ER8dFnwMIGjOF1HgXDUb2F04Mqe2Ma2fF9+HbuPdk2V7bnCBBcK88IpwI/Ms1tQwF+vd
         x6YMW1AQgB5smCr9c+im5EwqjLJGQe3YwRrzesJV9SL/1umE9s3NDLrz0HS7WFWlBaRC
         0BjMjCvQ/5Qxt/+TyZ0q9uVXnpvuIc52nFUh7h4EbrhqphXM7rpHuWn6Fmcjnp1t3Mx+
         dOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741789778; x=1742394578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8pxtdRpsPpZOYZuFTy8zEFwpuoZpgIK76UeyJOgRac=;
        b=mAB/QaerM21odhVNpDBeldDopBcLWqr8HJvw7OrQ5bkkVBbNPKybEQ46OUkrdSn9Vq
         znceXR0MVCLboQ13vDftSKjRycCvwqNtc/7zc7lE+063BiZnTYYJq50KLDm4zpr1Wim9
         9k8UlYarX7JtMGHlJKkxB1rT2lH81TG44JRTYZCcGh2OUNkUG9p+A+kpHRPS65I+GJQk
         7hULR52QCB9MLK8jLGE/0kGv6sYPJhpdwYf7n+C+f8nM6oUz25/eCla0zWKaUFdYyLXL
         iFtFWB8SP1IjB9lRf5CKVMRF6i0+gg41adnU8WoZvQ4auM/Zvwot+OCGPe60b4uuPwix
         4qlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWor3Og4wud+mv7XcTrlBlGQu1scx2NDdGzq1JWaak7FOiSZnq9OZgCLBnH5rSxqjF3sYY+Jf7F+jXxdss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1sKW92mPPg7/YuBcc83ecbyd42v6bIcCgkDHAIMDOCOUXAupK
	StNNCDb166ywFGsbFbm0umVaYIUDnqCobyDqFfRPdyMhnl/vVVzYe3oVmyanJV2HdivlTxAgwWz
	o2rL3NOAoFfcers+nVfD8tPMY8+16ezUqQ+2rCQ==
X-Gm-Gg: ASbGncvGWmN8BQQvqGMrRrCRFGOI1ZTpARF8R4c+9kudxnx+WBTZvwBISc2nPen8pcC
	NkM+wtq0ltX+xBIl5NSGDA2peDRGLi9p4HnXFOeMhET4VhlDLRPBUKze7tL9VL5JZ+OdyVA1OWJ
	UnlmBQOyAeTTqcwEI4wmCOB9plfg==
X-Google-Smtp-Source: AGHT+IETJKYtg/DF5Euhl3NEpsP7422ZyOmePKod/1vWPbnUODAPUSjHcLwOV2kB3kv1sQPyXi2rGpS6PKwXKU7JgE8=
X-Received: by 2002:a17:90b:180a:b0:2fe:9e6c:add9 with SMTP id
 98e67ed59e1d1-300ff105730mr12025199a91.18.1741789778465; Wed, 12 Mar 2025
 07:29:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312111915.2970032-1-naresh.solanki@9elements.com> <66b24018-0b7e-42b6-ad86-d80f37538678@gmail.com>
In-Reply-To: <66b24018-0b7e-42b6-ad86-d80f37538678@gmail.com>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Wed, 12 Mar 2025 19:59:26 +0530
X-Gm-Features: AQ5f1Jp2p9IbWmabPvZV0HmFdAOLWDdp8XS4s_j1FhPNtDYMwNYgUj9DQNGNhBI
Message-ID: <CABqG17jaPktHnQLqT_07xfAQaR=b5LOM+w_p3mHG-6PEG7NWbQ@mail.gmail.com>
Subject: Re: [oe] [meta-oe][PATCH] meta-openembedded: flashrom: Update to v1.4.0
To: Gyorgy Sarvari <skandigraun@gmail.com>
Cc: openembedded-devel@lists.openembedded.org, linux-kernel@vger.kernel.org, 
	"Signed-off-by: Patrick Rudolph" <patrick.rudolph@9elements.com>
Content-Type: text/plain; charset="UTF-8"

Hi

On Wed, 12 Mar 2025 at 19:47, Gyorgy Sarvari <skandigraun@gmail.com> wrote:
>
> On 12.03.25 12:19, Naresh Solanki via lists.openembedded.org wrote:
> > -Upstream-Status: Submitted [https://review.coreboot.org/c/flashrom/+/51960]
> > -Signed-off-by: Khem Raj <raj.khem@gmail.com>
> > -Change-Id: I55c4e8529d36f0850dd56441c3fb8602c5d889fd
> > +Upstream-Status: Inactive-Upstream
> Is that really the case? I mean it is just being updated to a new
> version, it doesn't look that inactive. That PR seems to be abandoned by
> the submitter at the first superficial sight, is this not the case?
> > +
> > +EXTRA_OEMESON="-Dbash_completion=disabled -Dtests=disabled"
> Nitpick: Could you please fix the whitespaces around the equal sign?
Sure thing.

Regards,
Naresh
>


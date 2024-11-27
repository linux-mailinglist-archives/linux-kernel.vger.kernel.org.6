Return-Path: <linux-kernel+bounces-423603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 135BA9DAA38
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89614B223A7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BDF1FF5F8;
	Wed, 27 Nov 2024 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="CdE2JHVQ"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FB8B652
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732719533; cv=none; b=PW/uAaZkIfZZKGeI3oE8H35k0yAyLDOq66P0cy86+SbkuVNr9VHbgZCAQSngqXwAMXA3QLHb9yqDv6d55LG1bziBnarXX5QGWwjA97/+8kC31pqbclusQorLUJydjGydOwDvEAwXR4XEkM75ToRYMC+I0Y1RHJK3vMseam0smLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732719533; c=relaxed/simple;
	bh=P3sQ3dDyiw7WHHX9zHzo1c/AWxHC2DQfNuXRWSfEP4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNHYRRYUEvTRR3sUPW2yIfBuij43JCG3HUkdLQmCSc/zBKKDQpgaDdGBzypzPsT94ySOA5DVv9XbFfJSF2DCR+t9ssj+wEhjWZ2pr+UkoqTYjxFjCyRBwHmMlxaTl8WMzxPaIkx3rI+N4RNBl6PODvLQeB47n7BvKUMPSnD191Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=CdE2JHVQ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4667931f14bso33527101cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 06:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1732719529; x=1733324329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IrpkrINn5pD5+SiCki+QuL3YaMO5H9h9HqqlyJ6ayLo=;
        b=CdE2JHVQYeQTm3mmEN5eENE1C9b6r7UklYuYKbcHb8BbmChH2YPjHRNEjz0e+H4jDo
         fm9+K+dO76TgffGmYY4Ox10cjg4TilHUlUtFicvZgCGU223mRYAxbekbZ9Wp1kDBZI5Q
         eeHv0Qp1F02sOpJVQttxgN1HrNEmi3JbN93lP4uuBhO4Pm+7IQfmXDixvzEFzGm98YqF
         DhRbTaJfKHKydJU9eXDDnrRanEEJTdS/Njm2jIiqlmlTKQpnHRKy6t0gYB5S3X2hv6YP
         YKbI4mUs7gJApZMBhqWu6STzvVitsiFImw6/bjgT9hjC3OvXmgKbIROvBIO7ZSomcMgm
         1Bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732719529; x=1733324329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrpkrINn5pD5+SiCki+QuL3YaMO5H9h9HqqlyJ6ayLo=;
        b=XBLheIQBqduSUcj05ATmrYzuYM/y2csp1Ex9+uXs14qKaYm+uQHaYhka9cDJj+XqnZ
         XB6KnmvNHg3XR7Vp72jMYHec99nn3sx+KG2XEXZblENR+PV8/UrCR0shn5pnPjsWd2Y+
         A/LLFXwy2z4pGGI5f/3c75FsPtOM/py6fBSoPpYta5ppI2tOXHiPHbIhT/lACtlH99bF
         B6kb5/1vD+jUR/3Fos7DKWDk1MwU9w4xdXA62EyrSQOd1i6pDO+rCXuTY0wB5dKN1qOU
         bkIJW6rSGujRVFSpPV9COFBPS906eHPXLi+4s84YKCScZFYFQgP2Wm9S21Xup9zuDkRT
         gHrA==
X-Forwarded-Encrypted: i=1; AJvYcCVDNBZGwR76mc++I8T5wgF2GX291MOCN9ZGWwFV2RPJE27vPrw+Lhqr0At++6SB3YLrbCPOCamcJvvN8ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEzZbKwbpajz1q6jW48uEMI6EfszpP1DAuaQEfCaDxC0Ftdesm
	QmZ/sRTh8GZT8F7KYgQoRnUbNHDGG4CWESVC1Vixa6M9Lg4dpe6Ul47dJ2QjHYE=
X-Gm-Gg: ASbGnctRK67XNdLsd+ek8ucXwyzHFU/r4aig0A8sfj/CKwOV+e8Nsmaj2UDsmV3o7+B
	kBdLFnEOBWo80oLR6Fh7yqSMmwUkh6hDB8AVk9iSokAfDz1bbxrvc0EmVl3AlkxVlpI7Q85m3nz
	Z8HBegfL9D7M4OR3KLPK1fL/yJ/s/PBT8F7EVDk/z6Rsb5tWh/BaEC2pgHYBdGrZBsEhm2Cj5V8
	/DsLbBwGiP5e0KMYtvrR749p7gB89vBEHBM/uWxnwKARGj1
X-Google-Smtp-Source: AGHT+IExRfPwLdv/Z497p5CIs23V4feTJd7h/vCTI2eXoJH8QYp2dn7srLGDUAGnHUtkVFA9n+glBA==
X-Received: by 2002:a05:6214:d04:b0:6cc:11cc:6f36 with SMTP id 6a1803df08f44-6d864d03a97mr42530426d6.3.1732719529635;
        Wed, 27 Nov 2024 06:58:49 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a99714sm66704306d6.35.2024.11.27.06.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 06:58:48 -0800 (PST)
Date: Wed, 27 Nov 2024 09:58:48 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/zswap: add LRU_STOP to comment about dropping the lru
 lock
Message-ID: <20241127145848.GA2508492@cmpxchg.org>
References: <20241127-lru-stop-comment-v1-1-f54a7cba9429@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127-lru-stop-comment-v1-1-f54a7cba9429@google.com>

On Wed, Nov 27, 2024 at 01:53:29PM +0000, Alice Ryhl wrote:
> This function has been able to return LRU_STOP since commit b49547ade38a
> ("mm/zswap: stop lru list shrinking when encounter warm region"). To
> reduce confusion, update the comment to also list LRU_STOP as an option.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>


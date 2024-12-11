Return-Path: <linux-kernel+bounces-441681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 570E89ED25E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9BE8288F84
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0F01DDC14;
	Wed, 11 Dec 2024 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dpt8QJ0r"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1BD748A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935376; cv=none; b=YjhFHvBcUgGlvA8VuQrj7oPNyZhIVp3gH2e1vf63CdtpTBMOR7/gxf6i3Ij8H/5S/jsukMaf8p/VdgzhiTcux3lrliwGjrSRc5E85aqLMF8N9qcwA3nH/ichJX7YJZ3QjxB4zMuAa8oBHROoYkN4GmLS1z+IE3aj5p52W5DIFTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935376; c=relaxed/simple;
	bh=+IJL5ABy4FXfBSjS+ZC2D7SmHKapNA3892pbPXLw9c0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=p7AaMdP1e1sAz95Dat5pD/ItOLisQ1jkQHr79AvwVcNdT++mKwgYNtOgr8NwZ1A2RpRIwzZMBrdYrXPxWq6/zZq1Y3DiJK3BeFue1Aey8THF1vDYdcJMcGGQRVRMzgqzK+KEBTxdOcTJW5mEPnqEomuDaP2HqYIK1zTIVfH9FP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dpt8QJ0r; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7c6b192a39bso4753483a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733935374; x=1734540174; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+IJL5ABy4FXfBSjS+ZC2D7SmHKapNA3892pbPXLw9c0=;
        b=Dpt8QJ0rZtSNfNfpZYIp5f52XkHfKGQHnB4GHiZw3M+dMvWDJn8zMVo7TpXmgp4L8g
         vrDk7v5djdXUZppg3QGBlxYmTdKiFpO++UbYv19WWShdDweE8wlI5xvxEooz4KhI/wYa
         l1K4c3A4xwatbHJaVLmYNkZNYRNzKQb43JcBurktjxXeA9WFpMrLmHV/ubk5IZgd5Xt4
         EdWiCmbV2jdGSwHVNObb7AdzLEd1PDrBSdzmwRw+t19c5YF8vAocFscJUJFjCfw3X1yZ
         NZvDauubjp9FFZTXd8mckiZ+32//axDu+lbcipfS6dRW6tR1iBJLywxAa02He58EBanr
         C/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733935374; x=1734540174;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+IJL5ABy4FXfBSjS+ZC2D7SmHKapNA3892pbPXLw9c0=;
        b=Gb4OMYNBypVGCJ/XFuIA0pjIpE5sr/HnI4WI6NsRkZ8IhWfVQNWcFmENXS8NLtu8Jf
         6Xug+0hqOLnCGsrIIoO35+tUHY15pxr9p8ilvf+b9vTYFV3+HMZZMu9WorAZJSmNUKzG
         awRQy1iH2ee+owzTknsjQ/uHVNLtYF3rY6N6HqKdfsOvNH30AWud89CruqrRm0zSxT+T
         rHYpXki0IRbaMzLx2p7jiYYjXvNZxtcCVSWxwVVwOIkdzll1z9JVtKnF4pF4U3OqKfi/
         2/h04nrKWzuszZA8d4ktop+0qjOyUN2hjXBxSIPv+5GuKhxjuIhsowEXbWlG/3dYGZkn
         TMIA==
X-Forwarded-Encrypted: i=1; AJvYcCX9fQF8cnRFEQ+FEtWqY2ccgijY5+z4Z4Po/0uJZVeroOE9et43UpIIU6Di40TEfUKCQJKJPB4GE92Yb6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCEocAqkW22JlJyCwfEQbhKsPwqp/55B4bPfbiTfpqL3V+ewrr
	V8SSf93vJaypiCu8AOVTOsEWHXFCw3AdmCbpB7bGaR2HU63HYwPuIm6YHdhUf7glPp5h1bINCpg
	NXw==
X-Google-Smtp-Source: AGHT+IFcLyF450FdGbFytuLxC3VtC4irjOelUzQ+tfSBiTLeGly2Al7QKHOvKwAGWqA/hARZu+PeJih5gHs=
X-Received: from pjbqi13.prod.google.com ([2002:a17:90b:274d:b0:2ef:701e:21c1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c48:b0:2ee:d024:e4e2
 with SMTP id 98e67ed59e1d1-2f127f565bbmr5844007a91.7.1733935374078; Wed, 11
 Dec 2024 08:42:54 -0800 (PST)
Date: Wed, 11 Dec 2024 08:42:52 -0800
In-Reply-To: <20241211013302.1347853-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211013302.1347853-1-seanjc@google.com>
Message-ID: <Z1nBDDidygRil1vG@google.com>
Subject: Re: [PATCH 0/5] KVM: x86: Address xstate_required_size() perf regression
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Dec 10, 2024, Sean Christopherson wrote:
> CPUID is a mandatory intercept on both Intel and AMD

Jim pointed out that CPUID is NOT a mandatory intercept on AMD, and so while the
code is correct, the changelogs are not.


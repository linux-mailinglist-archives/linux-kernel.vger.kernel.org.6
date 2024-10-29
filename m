Return-Path: <linux-kernel+bounces-386837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF0F9B4877
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C83F1C232BB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B103205129;
	Tue, 29 Oct 2024 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SDR/NzIv"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63507464
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202013; cv=none; b=YhqS6a6v9GMEq8v3IWaaZyCuCAjarIz5ypdfOe6HJpJWvoG8vLDgXrZogStS1xP/67YhVJr2geiIoTtWf1mEWYfp8cUKhy/snjCVUvenMCoj+8qqNJXQCOWjXj+abAUO6sGxH/4En2rIdAxVHroU6e3G6GNHOBoGyYEFvd0+1aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202013; c=relaxed/simple;
	bh=keM86y+OtFDDUxFSAS04yWIBeRc+qIxCeBn7lQGtWII=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UbaAMOwIdnb46pmm7ot4eMP98eDQnoi7xuW3hEGtOP/BtTceBU3LDoOrpDYYSYmtm5oqtv/75hXa5Hdwz26uctjVEaIGi3fvQDemqKT3cuNHXWurw6ZK6RyVUeRnG3Cy0S/oXQodPW7jgJzOhoSYmhJf7h8Q6eWgUMlzwyIZn2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SDR/NzIv; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e32e8436adso77127457b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 04:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730202010; x=1730806810; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=keM86y+OtFDDUxFSAS04yWIBeRc+qIxCeBn7lQGtWII=;
        b=SDR/NzIvq2+QkKxUF5+bcjzF+nYML7kvmmeVc6BsAHDgddF/ubvaazKcXPfb2/jAfe
         WMmPO1lUeFKey6gNKEYPsSqQGBqq9vPbiZLjjWaoCOwqKskHoUwSIPalIbFP/8YpBJEf
         6LbsbJDQpj6szCDoxHnKCwlklYP1s4tYKWsGxIqo+JYKlruezQQZAIO/DPMtBIqenAwR
         13X3dCgErdWR3NDAzT5nZnSoOXi3MgecxVmFLt8jtDMwppq/sm+A528lDAr/du2gTZD6
         U/kTCa9ny02sgUkAYIXRza1Ttnhx6NBhjVaKQPDUNGwMOwRqxmHczQJIbJLZf1wDcSsp
         7UkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730202010; x=1730806810;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=keM86y+OtFDDUxFSAS04yWIBeRc+qIxCeBn7lQGtWII=;
        b=XAuMblak9pnHrpQNiU/4pgl7pcyld/dkWvlswpJCiaibRD2fzhBHD8GpSrRhPlg2vu
         j1xfgm54dZzfkxAwdu6E/Ly+GcEfnldZpl3rAYbPW3ewBf3AbOHpu+25asdx9PVmH459
         K9ekkp42ijfcpyqYsl8KZOr9oiK34vD3mWbIR1/qkfL1ABTdvZpQv1TziAxNmlqCrFaR
         XO1HP53KsV963UAXRWFEfAEP/4C1/YmjzZxsVpsC04H4mKrrhUyZqQcHUxOJYap4uEY7
         83XVaC7oItnzrKOxaHnevkn/yO6RNIxhEPelyFMhMXxkXgp2WNN8qjnT/9P2I3QmXP8f
         WgqA==
X-Forwarded-Encrypted: i=1; AJvYcCVbWewL+ry8son+CFCRfh/HyiJYAaW/XetWXCpUs9JwGwPghqR56OWMa79kVOgUEAnH9KtwLrttNsVtF2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqfaInUESGHxEe1Sh7i0ghj2xVVb9s4ZhsVkNazX+ic37KD6bl
	zi1F2fBloKX30h3BNFgD3kIisk8WXEviYZ1EMgvp0Bh4qOza5XHqoz6eCAeB8GHsJc60gJ4g3fD
	DpfouCf9a4w==
X-Google-Smtp-Source: AGHT+IFcZXhDyGJrE4wz3KgYhZLLQPoGjrMnhm/qsU5Pti9q1Xq8Ll374qmn9x1+Fcj/eIqB3aMYqZzfNz3kiw==
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:f74])
 (user=jackmanb job=sendgmr) by 2002:a05:690c:6283:b0:6e3:8562:fbf with SMTP
 id 00721157ae682-6e9d8b04581mr6230337b3.3.1730202010410; Tue, 29 Oct 2024
 04:40:10 -0700 (PDT)
Date: Tue, 29 Oct 2024 11:40:08 +0000
In-Reply-To: <2024102138-CVE-2024-49993-5b57@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024102138-CVE-2024-49993-5b57@gregkh>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029114008.2436272-1-jackmanb@google.com>
Subject: Re: CVE-2024-49993: iommu/vt-d: Fix potential lockup if
 qi_submit_sync called with 0 count
From: Brendan Jackman <jackmanb@google.com>
To: gregkh@linuxfoundation.org
Cc: cve@kernel.org, linux-cve-announce@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kpsing@google.com, ciprietti@google.com, 
	melotti@google.com, sanjay.k.kumar@intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

> Currently, there is no impact
> by this bug on the existing users because no callers are submitting
> invalidations with 0 descriptors.

I think this CVE could be discarded, the count arg is always hard-coded to 1.
The buggy function isn't even exposed to modules so I think even if we care
about out-of-tree code we should be OK here. (But based on [1] it sounds like
out-of-tree code is probably out-of-scope for kernel CVEs anyway?)

[1] https://docs.kernel.org/process/cve.html#invalid-cves

FWIW, I don't have any burning desire to kill this CVE in particular, I'm just
testing the water to see if this is one reasonable way we could share some
triage effort among consumers of kernel CVEs...

Cheers,
Brendan


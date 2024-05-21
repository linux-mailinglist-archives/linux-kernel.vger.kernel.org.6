Return-Path: <linux-kernel+bounces-184333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C07AE8CA582
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4BF51C20B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 01:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA24947E;
	Tue, 21 May 2024 01:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ngnLFSgM"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A40E256A
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 01:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716253357; cv=none; b=lMyfqvpsS/RiISBePJ2982l/oJK42MVStX21uXYNDzLCZhpoh+amWsiOTUFczmHP1TbEN7rya4k9PVh80+tNsWmxXLru2shDmz8SJcwhYUOv45zor5GfvqMeJhXdBVPrS7XdMqLbTcoOMTjSeAptU0A5FYjc0lWQidV7a8ne52Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716253357; c=relaxed/simple;
	bh=62s9ZBQLECjqwaw8IyELeu4N6Gxe1GRRUiarSV+DbTA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VHdnqNmQMh58gUAaxOS4qpB4Zdfjwey4OOLOSWIrDp1avFhzBtQOckghgptEZA/LXuDZdq87qemWGRe5DK3X6rHrRIXnu2MR+TLtUZnZEERI5MmR0juTVJWmv2b0N7+miE6djo9Wzp9fpUrRs2sVvJCYOi2o8wsJyUkTv9GB3MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ngnLFSgM; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f49fc7b5e6so13183265b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 18:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716253356; x=1716858156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kj18FI+spxVo0wYyt5GLsAf9LnUaY68HrretgdhL1+Q=;
        b=ngnLFSgMBYAqDnM+eXECVqCMKjSpijc4jSlWkGw5T2ec4kJG64E+oRuDhS5t1B6MkL
         gDVNSvnk/OZqO3lw5Bknh66lBq23xfVujP6gY8JQ0LTOrK04gDP7QSfdE3YDCLaE/0f8
         0uO+/nvEfhV6n7Lv3hDDcaITVTe/dOpZGdQX52tfJ8jDwpkAz0VBjPf5Vytu9+67Osjf
         /GYqtinm8/UpkPqQFIuvegYwBU7PKbiWUOhv6lQvzJQ0guUjikqgfZbOnhhtcLouNAm1
         fWA8Rjr7NjV0TUfJLCDGAB3TvouPDYRKBLSanh/U6E5UjsCAr7NEbDVhw7g5HiogOg/H
         w4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716253356; x=1716858156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kj18FI+spxVo0wYyt5GLsAf9LnUaY68HrretgdhL1+Q=;
        b=UXP4UMCQI5G9mGJh693JrekALZsP9lzuEVjXj+hZP4KIxZadziusL3QXAPbNCC7YKf
         Qn822rafS2pOifjObhj3bWlDZ2p4XF9vSiRP8MFjX2kbBzpTIqViS8nNMChp8VxqJSJT
         yhkyVnMBwZL1PJFMKZhsqqBjMfHuyVdrHKthDIJmQOb358L28uqzB1d3sSOy5B4Mn8d7
         dQ1TMiX/HpgU9EAg7u2cwOcxhNRoRXvkBtooG9Kfjp8JEwYDqGHYrju9fYWLBqBlIYab
         bHDBd+zTde5RQger3q7bC4lxbWtF5OwDDTuEUyTUqX2Mn/OZHdDUHzD6aNAdF3JMOXbH
         cuMw==
X-Forwarded-Encrypted: i=1; AJvYcCVDSSCdy9cA4/cI1nhWWtkDW0zxvePPvgU/jbB0n0mMxIO2yIiqbwqqgqoXWrmdtgx6n/QscOANhf1sx7m9iXyW7xyWFX2R79mZUzuM
X-Gm-Message-State: AOJu0Yzwzag9UVfI2K5pUuozd2kwGDOhq5XtPoDGWwbM/mVKrkzaxU93
	YJyl+ImXMKFvip5LSD8iV/ogLcVPmW9KViCLODqDczqN1ZQJIJLhun/B6m0MOL0zVr7AOYlcxFj
	GFw==
X-Google-Smtp-Source: AGHT+IG2yAJanvKyU97focG/MqnEJX7x8reSfJL3QGZKYOWsxkzVO6QuYNNBaybkLhpdSDhQ/N8gw84H7eA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:a91:b0:6f4:d079:bb24 with SMTP id
 d2e1a72fcca58-6f4e0296acamr1399421b3a.1.1716253355725; Mon, 20 May 2024
 18:02:35 -0700 (PDT)
Date: Mon, 20 May 2024 18:02:34 -0700
In-Reply-To: <3e7413b5-482a-4243-be6c-21a0ee232cc4@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240518000430.1118488-1-seanjc@google.com> <20240518000430.1118488-3-seanjc@google.com>
 <78b3a0ef-54dc-4f49-863e-fe8288a980a7@intel.com> <ZkvbUNGEZwUHgHV9@google.com>
 <b1def408-f6e8-4ab5-ac7a-52f11f490337@intel.com> <ZkvpDkOTW8SwrO5g@google.com>
 <3e7413b5-482a-4243-be6c-21a0ee232cc4@intel.com>
Message-ID: <ZkvyqjLoGxuf-AdC@google.com>
Subject: Re: [PATCH 2/9] KVM: nVMX: Initialize #VE info page for vmcs02 when
 proving #VE support
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, May 21, 2024, Kai Huang wrote:
> But now L0 always handles #VE exits from L2, and AFAICT L0 will just kill
> the L1, until the patch:
> 
> 	KVM: VMX: Don't kill the VM on an unexpected #VE
> 
> lands.
> 
> So looks that patch at least should be done first.  Otherwise it doesn't
> make a lot sense to kill L1 for #VE exits from L2.

I have no objection to changing the order.


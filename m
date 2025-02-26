Return-Path: <linux-kernel+bounces-534614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8DBA46928
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989143B0568
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E3A23496B;
	Wed, 26 Feb 2025 18:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r/1CKV8q"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B527B23535B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593455; cv=none; b=WLqyHQbX+g5BIctPUexeUFnwk8M4IQac/d7YETmApT8XYSER4ss6mU//qzbe2VKr+ZNYRkuwY8v751oe7cLC10820qvI99XtPiMvG9fkaPbENicejakOWfOfc9/tPO+4qoaIk30f16SbBoZbLWrvfBM7ayrPmMnB0qyaGZo8Rnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593455; c=relaxed/simple;
	bh=EbaACQr0vW701BtG20JwXpLEEwmHg6MVq+JFkWjYS7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVdryFpUd3fY0XR1sU91C674L1zm1Wkbmt+clYIj59CHRPUE8XvOEXz0Yd71CV8CrmYVanrK9gCKmiSqVxveCln+qFB8IBeTN5Z2xNbPf4/TvxUbjPFuNFdZ/TzVJEWHJG8nBJX4pJtl4uTQ1go15yKV5g58SVQ5Vi2MpIcPFNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r/1CKV8q; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e0505275b7so11421138a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740593452; x=1741198252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V/V8Jj9rYZChtFzsP4NciMXPlW80o7eEp6Sp5AawXIs=;
        b=r/1CKV8qvh0NZI4pB8cYtEz8RKReCDQlnten3tS5b3ak6xfdjFuuVPVYLyucOgOFmk
         0R9f7YWx1CAkqaFb4QBFl3DgP1W6c8rbLrzt3CHSzWFiCiV2PLJ0+lnNaOu2AJZWEREF
         DPFJL9zTFraPR4MSF61OCheX0rpD+QHb7mNfi8U2CWBDQMKjlmsVgnW5H50qeEhEU3fo
         x8qcCBGM/U+P0hACkairgz4EYX35ds3I4LE+ahprNS5OpWK8Q7ecn5vYZySiqUHpCnzY
         T6TvW3W/TYGc5j+Gv1RPG9G1nO0e5/JxoZ7oA6OOnNJJeWcyfQPzC2rKBOaeczTFf07z
         UALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740593452; x=1741198252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/V8Jj9rYZChtFzsP4NciMXPlW80o7eEp6Sp5AawXIs=;
        b=Co/+g1cQw/p3lFYnzVrrBjLm4Zv1H/F1zZRti9ypyoMjJZ35mqqJZxh6j57Eme+5MQ
         PCdAu0E3MBoAo1O4+wCjzPUoeRZhdMhkAVI5mOG4EXTiWNYKsfJEvagCWcPS3TfFfcT4
         TcWO4P2K8/VKyuGyxDmuxah/yXEOBmvKhQ1W2JVcgzp/SRpY2lKzP+c++yOwrLkcyEcM
         exo0+CSgcM5z0L8B3hSKBPCqYb+9jakUrU1q9p5sOp9qfLrHT5HKbZ07sOomOP2DRMm9
         +Dp2gjBPm8j+4+ribL2nmC5Ykvvn+Znx3vk9QMMgnSDbwKsTORl3f9XMO2d5YDsrQrZd
         04Kg==
X-Forwarded-Encrypted: i=1; AJvYcCW5CJ8e0YcuHRw/xfi+w6F09Iw5Mn8rdDVy8oRJ9z8ekeG1o6TcoG8d6nGEIUDiE6Gwchb5Xky9VBAu3Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YySzeBiqKybMvlmEPcH7HJj5CHUyZ1HDl42JppU66Sd0eSODo+x
	DFyWURuqJERMqJ4Ixn5oi1tUTh11Mb5w31Eu5AuyLIkYfElwDnxo1K/Fw8xE7w==
X-Gm-Gg: ASbGncsjMLjdPNpLz72gNXsurzQwzyLZKhGRpi8LQ0WaPgrp2/e1n0IPg6uft7OsAUl
	kng23gdA96drftOoJ4d8dD1QEu/gGd0LkCAkyuAJhFdii29a1dfRjzc1dAEaX9nRJtVkSPTMuQH
	o9j0Aj2+5fcWgRN32qnAiXkmLqmgFGd6YAS9iRytouVpkPXTBNrsvp95sLz7ZTN0dPmteEzLWW6
	sw/OBA7Trp3FihODUVVEjMTuub6BNGXuCMKy/q9/GNy6+saGz23DwnF87HEhsb4NE1SskEXVSik
	zFYqWuq2eeoJFgVFeL7VPqzV+HLO05YikdjKIxD6JSIyg2bPQZcG+8OtaC5s02U=
X-Google-Smtp-Source: AGHT+IFSemQuFVxhcR1OJIBHEWyJQf2Hjrc2hP3J/LbxvQX6+WX1I3uywZ6yJMAv4hfkJ2aaAYgxNQ==
X-Received: by 2002:a05:6402:501a:b0:5de:a6a8:5ecc with SMTP id 4fb4d7f45d1cf-5e4a0d490aamr5970613a12.5.1740593451852;
        Wed, 26 Feb 2025 10:10:51 -0800 (PST)
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e45a8b8c4esm3155601a12.26.2025.02.26.10.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:10:50 -0800 (PST)
Date: Wed, 26 Feb 2025 18:10:45 +0000
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] KVM: arm64: Selftest for pKVM transitions
Message-ID: <Z79ZJVOHtNu6YsVt@google.com>
References: <20250225015327.3708420-1-qperret@google.com>
 <20250225015327.3708420-4-qperret@google.com>
 <867c5crd2j.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <867c5crd2j.wl-maz@kernel.org>

On Wednesday 26 Feb 2025 at 14:32:52 (+0000), Marc Zyngier wrote:
> On Tue, 25 Feb 2025 01:53:26 +0000,
> Quentin Perret <qperret@google.com> wrote:
> > 
> > We have recently found a bug [1] in the pKVM memory ownership
> > transitions by code inspection, but it could have been caught with a
> > test.
> > 
> > Introduce a boot-time selftest exercising all the known pKVM memory
> > transitions and importantly checks the rejection of illegal transitions.
> > 
> > The new test is hidden behind a new Kconfig option separate from
> > CONFIG_EL2_NVHE_DEBUG on purpose as that has side effects on the
> > transition checks ([1] doesn't reproduce with EL2 debug enabled).
> 
> That's a bit annoying, isn't it? Without EL2_DEBUG selected, you won't
> get any stacktrace, and the WARN_ON()s are a guaranteed panic. Yes,
> this is better than nothing, but I'm a bit worried this is going to be
> hard to use.

Right, so you _can_ enable EL2_DEBUG on top of the selftest stuff, and
if you're not hitting one of those hard-to-find bugs described in the
commit message above, then you're golden. In practice I suspect that if
enabling the selftest alone leads to a panic, the next logical step is
to enable EL2_DEBUG and see what you get. If enabling EL2_DEBUG makes
the issue go away, then that'll require digging a bit deeper, but that
should be pretty rare I presume.

> Is there a way to reduce the impact the EL2 debug has on the rest of
> the code? It feels like it is more invasive than it should be...

Turns out I have a WiP series that moves the hypervisor ownership state
to the hyp_vmemmap, similar to what we did for the host ownership. A
nice property of that is that hyp state lookups become really cheap, no
page-table walks required. So we could probably afford to drop the
EL2_DEBUG ifdefery in host_share_hyp() and friends, and just
unconditionally cross-check the hyp state on all transitions where it is
involved. And with that we should probably just fold the pkvm selftest
under EL2_DEBUG and call it a day. Would that work?

Thanks,
Quentin


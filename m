Return-Path: <linux-kernel+bounces-449362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CF09F4DCC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54FE1893401
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431021F7072;
	Tue, 17 Dec 2024 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Og2vzr37"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1461B1F543C
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445901; cv=none; b=q0YAnTGhYnKT8nyjVUriPRddcy7Rtw4jpT5ZGSSJ/BNWw1aYLGmaGCrfiIlsTsuiA24yJvoVFRfBI/iWwzcKZptNN4xZphGCJ+E4ymIYpizIEQrov+Ak5bjfPx6pvoOink/l8EnFLV3cOxPfBhyMTpFKD3VOyMJYUXW3qNRCc0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445901; c=relaxed/simple;
	bh=MCDsTtrRcGELOG9sKHeryzP5B0DQFbLGyo/mki1UYKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDQqL0BLC1MG6/3RL6U9uNY4Fr7Ww0turgUrwtPGL4F1gEfIYZgzAIh1CHhOZyk6Uy8NWLBSLncI7K190coK/TT9i4EPkTs63TtwUEAK6sKICvwps5VzDNxicZoMdUKX8ivfncdcfT78cy7NJRtfyQS9B7nPLoz0/UaSp52cuT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Og2vzr37; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so2372658a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 06:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734445898; x=1735050698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MCDsTtrRcGELOG9sKHeryzP5B0DQFbLGyo/mki1UYKs=;
        b=Og2vzr37/Y1r+gHBLm8iMjSTiupLsl729MMYoAiS6HtLDQjaZaSYI/mFmDx2I1Ar4N
         a+VOwtM/5XDkNGJyK8jbt/zPz1sviVYuWhhA+vLLL9QmUjv0/WslAo4e6w+kOYwqITRB
         yIRUdCAtuRRthDdjimLi6dwRKGwuSCakCMJ+U2pSMG7QvmcwibEpa1JRtwjce4DwIOpQ
         5E39Q15g+Kr3VqXMJbG8bV8zmvV9YTOsN+5KbbZ8i4yMtxCXQ3iXn4BQ5PChQnm8W358
         h1FUZKVMmxdHzJrhuET0o+MaVLrDPvg2cUU0Q+fSKoK+vEliERkr/Wq7SQ2Qb62Y/qOX
         UANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734445898; x=1735050698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCDsTtrRcGELOG9sKHeryzP5B0DQFbLGyo/mki1UYKs=;
        b=mGMT5QxGcShpfH2YeLz5/RLPIzQZdceg3pMgWAc0dEpWEQKC8gKeJNU/kaGxVdcSfF
         uryr/NqbAXP6Tk2PjZjxSlAkmUaTdPW6FMYGe5e1depgTVjoEkfdx3abwk9lQSHJGgnm
         TFkrsrbOdtDn1QF0TZUh6/4TuBeqqFUm8ZYH8PYPXHsL0TVbr3/VQykMbSD2sl9yBdOe
         KOhAAZmxRY4gL4UAc4sQK4jalBVg7zErIQf1vFheC64MbiwpeAbWirsYpZ3YvuYH5Emx
         fE1DxcH9REOJnEtF4oLfEGi23aiDMoNSaVRG0uZR3ZMc7/twqwlcTlGbsC/qJCHFXgZ+
         rlyg==
X-Forwarded-Encrypted: i=1; AJvYcCW5Jph3wXGnIFozvibWaPQSduI3XUd9gdAA6OjHvz6JzQyqOVuB4kd3DM/y1RyKGwsZ5mF13r2snm19Zr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+qoXSBxllBBh0eQK8HabRoCyQBVp89+5TyTd2iM5R8DilPR6o
	0TuGsU/QeuQYIp28DtBrabr4gOJg+QAq+sXMutyiz5c1UfCIUiiNBQnnfCpK6Q==
X-Gm-Gg: ASbGncufJIYKhJECvayyn4b5KuvYagmX7gBtv3rheccCB+FrMWJVQCxOB1ghNgKmJkX
	iM6KuHAg2NAZVJtNF2iqMKg04PWjEc2DjQarbijCqtbNATSHwwK2w1RdNyj9S9HMCnI6vJ53fA7
	dFRAQ95PRovmahkTSSvDuPV1kJ9VjwHCa+A1goBFAvoI/K0ACRqAzlH+9F5p08ruYSMfidoGgH5
	trf/h7lQF1IS+X8ZHDk97S3JUSfVON4/XjMeLMXN4ADb/tMmS0zPO6yVKEetXPxQd6DLos/wPjt
	P0HBTDqQ9VkXh+I=
X-Google-Smtp-Source: AGHT+IHVex9Gn4i1ejnUteG2TKmCzHX4xTSH5m8KzVP1ilACtngEv4xPjgW00hut0PjQct6YRA2HvA==
X-Received: by 2002:a05:6402:2708:b0:5d0:b51c:8489 with SMTP id 4fb4d7f45d1cf-5d63c3067d6mr13054348a12.12.1734445898291;
        Tue, 17 Dec 2024 06:31:38 -0800 (PST)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ad187dsm4505071a12.28.2024.12.17.06.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 06:31:37 -0800 (PST)
Date: Tue, 17 Dec 2024 14:31:35 +0000
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Sebastian Ene <sebastianene@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 18/18] KVM: arm64: Plumb the pKVM MMU in KVM
Message-ID: <Z2GLR8KZzJn1YpUu@google.com>
References: <20241216175803.2716565-1-qperret@google.com>
 <20241216175803.2716565-19-qperret@google.com>
 <86ttb2qudi.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ttb2qudi.wl-maz@kernel.org>

On Tuesday 17 Dec 2024 at 14:03:37 (+0000), Marc Zyngier wrote:
> My gripe with this is that it makes it much harder to follow what is
> happening by using tags (ctags, etags, whatever). I ended up with the
> hack below, which is super ugly, but preserves the tagging
> functionality for non-pKVM.

Ack.

> I'll scratch my head to find something more elegant...

I find your proposal pretty reasonable -- I had a few different ideas
but they were all really over-engineered, so I figured relying on a
naming convention was the simplest. And any divergence will be flagged
at compile time, so that shouldn't be too hard to maintain looking
forward.

The __S2 name isn't massively descriptive though. Maybe KVM_PGT_CALL()
or something? Thinking about it, this abstraction doesn't need to be
restricted to stage-2 stuff. We could most likely hide the
__pkvm_host_{un}share_hyp() logic behind a pkvm_pgtable_hyp_{un}map()
implementation in pkvm.c as well...


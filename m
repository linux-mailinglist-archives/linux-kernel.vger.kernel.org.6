Return-Path: <linux-kernel+bounces-547606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A733BA50B8B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A6EE3AE6EF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECF0253B7E;
	Wed,  5 Mar 2025 19:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9UjWC8t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92EB25332F;
	Wed,  5 Mar 2025 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203272; cv=none; b=taHwNn17Kmb8wdpm/HIiYYYuzBNaf/SLgk0vpe/xbEgbhvQoAJb5bzKwDCPqxVQIBWeeBrFFwVyXYaWo/RlQB9QRPxhZuw4BKB1bUUvViBlZr5yTebrheD8MlHhwjWF7+zsrnxajUriLaechPvtHrSqortE4darsmhA2CHEWuu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203272; c=relaxed/simple;
	bh=A7HpRq/91+8athZq67F20mXrUR/8ioHId6gQWWlCNvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zz/j5IvnmIRXI7G8KKfCNyN/tRL+EjO4iWX3YA5RotuieygHO1Ho0fGeU9Dlzkyxj9x0jtcM2QF4tfaMQL6BaAzPxHf4R42iQhbmeEuC9GY7xQDNB6ACG/V5iY7S8jAyTGKUFhmTXgFxReDUS6vsVZ7KB3i7FOT8lBoKh11J/6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9UjWC8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DDBC4CEE0;
	Wed,  5 Mar 2025 19:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741203272;
	bh=A7HpRq/91+8athZq67F20mXrUR/8ioHId6gQWWlCNvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e9UjWC8tn1t3HK+WiblEvfCTov6GC4SesAt22y7vX2bkk5leWZwCOfNz9psXVZ5nD
	 svk54TZTIwOHgt2DJEA3F36wW4xauzEPNt7CEhSoDJam/XTgVWNMM5v3IoBB03Hiio
	 TfVtTclHQm8WUuj6Jj9p1cU3c7tMtN0XG5+DkSS8VoX7xQa9DSrX7UPAc3BOaSJDdi
	 M42PqSqAnjUTUxN+84AfMTyDsx44Evfz+ETEeIvp5ay9jiqL4zr9ByNOPFR4o1VO4O
	 prbdGEwDF8645jAKGMnio/xfi3F3q5+iobEVSMSKIVGWDFIGJW4aNsRXvlt6UhYJJ7
	 e32naCkRvhmlA==
Date: Wed, 5 Mar 2025 19:34:26 +0000
From: Will Deacon <will@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Sebastian Ene <sebastianene@google.com>, catalin.marinas@arm.com,
	joey.gouly@arm.com, maz@kernel.org, oliver.upton@linux.dev,
	snehalreddy@google.com, suzuki.poulose@arm.com,
	vdonnefort@google.com, yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com, Andrei Homescu <ahomescu@google.com>
Subject: Re: [PATCH v2 4/4] KVM: arm64: Release the ownership of the hyp rx
 buffer to Trustzone
Message-ID: <20250305193425.GA32246@willie-the-truck>
References: <20250227181750.3606372-1-sebastianene@google.com>
 <20250227181750.3606372-5-sebastianene@google.com>
 <20250305004522.GC31667@willie-the-truck>
 <20250305094104.vctshdtgdukno2aj@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250305094104.vctshdtgdukno2aj@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Mar 05, 2025 at 09:41:04AM +0000, Sudeep Holla wrote:
> On Wed, Mar 05, 2025 at 12:45:23AM +0000, Will Deacon wrote:
> > Hmm, the FFA spec is characteristically unclear as to whether or not we
> > need to release the rx buffer in the case that the flags indicate use of
> > the rx buffer but the returned partition count is 0.
> > 
> > Sudeep -- do you know what we should be doing in that case?
> > 
> 
> We need to call RX_RELEASE here. I went back to the spec to confirm the
> same again.
> 
> v1.2 EAC0 spec Section 7.2.2.4.2 Transfer of buffer ownership
> (Or just look for the section title in any version of the spec)
> "
> 2. Ownership transfer for the RX buffer takes place as follows.
>     2. For a framework message,
>        1. Completion of the FFA_PARTITION_INFO_GET ABI transfers the ownership
>        of the caller’s RX buffer from the Producer to the Consumer.
> 3. For both types of messages, an invocation of the following FF-A ABIs
>     transfers the ownership from the Consumer to the Producer.
>        1. FFA_MSG_WAIT ...
>        2. FFA_RX_RELEASE.
> "
> 
> Hope that helps, can dig deeper if there are any ambiguities around this.

Thanks Sudeep, but that also makes it sound like we need the RX_RELEASE
even if we're not using the RX buffer per the input flags. :/

Will


Return-Path: <linux-kernel+bounces-218033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C95090B852
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28D351C2237A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDD41891C8;
	Mon, 17 Jun 2024 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZZS2E4bo"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619F21891B4
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718646046; cv=none; b=OSSDnZqPE8CKeQysvktgM805rqNDO7HzI+ZQ/VXHLi6A57ZnYrMHIGXxM5IlsfUMgYFc8W/pXPjdKKLKgCxntsZXoajIK3JTcLvOxRRNCFAcxg8+OjuI9jUZbNjG1V7k/GQrpecGk/azN+Nm/KDqdSZs2LZN12XaG8c0pZ9t8eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718646046; c=relaxed/simple;
	bh=O44bg5IN3bpweFi97y7tt8VcamC1B+cu2qGxErr7ez8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5bd1ayedXHEjIRtJVukVG1w1pOl+3+s44qf4HsdVKNk2NH+1cSfSPeo+/s5Khm9LnlVkX8NiDhVjBCk5/CTlC+7ISUmHm5Z8WIVIThwjTB5AyMqjIgzrnK33MpHmAZ84iVquO39hM74hY07kyIobQrHoU6j4IVntPjHuDt6eu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZZS2E4bo; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: shahuang@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718646042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=okv/SBVT+t/mscY2NbGXxvwNhjZy/ckRAi7DnSHOqKA=;
	b=ZZS2E4bouTntLdhRdKDBwzqHEL50a8ctu3G8V36RUt1ypOp+M+UED4Hve02PlfU857ISH9
	+2z7zqvoPPesAU+CJb5hrVqJLOOec7PeOFz2fNoIuEuztzqoQCLxUP8QmVYYZegmLfJLQS
	qSyw/Mt5PuufQBHEqPeIIYO+5J3HuoU=
X-Envelope-To: maz@kernel.org
X-Envelope-To: kvmarm@lists.linux.dev
X-Envelope-To: catalin.marinas@arm.com
X-Envelope-To: james.morse@arm.com
X-Envelope-To: kvm@vger.kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-kselftest@vger.kernel.org
X-Envelope-To: pbonzini@redhat.com
X-Envelope-To: shuah@kernel.org
X-Envelope-To: suzuki.poulose@arm.com
X-Envelope-To: will@kernel.org
X-Envelope-To: yuzenghui@huawei.com
Date: Mon, 17 Jun 2024 17:40:36 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	James Morse <james.morse@arm.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v1 0/2] KVM: arm64: Making BT Field in ID_AA64PFR1_EL1
 writable
Message-ID: <ZnB1FPw3Eg8-61mL@linux.dev>
References: <20240617075131.1006173-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617075131.1006173-1-shahuang@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 17, 2024 at 03:51:29AM -0400, Shaoqin Huang wrote:
> In this patch series, we try to make more register fields writable like
> ID_AA64PFR1_EL1.BT since this can benifit the migration between some of the
> machines which have different BT values.
> 
> Changelog:
> ----------
> RFCv1 -> v1:
>   * Fix the compilation error.
>   * Delete the machine specific information and make the description more
>     generable.

Can you please address Marc's feedback?

If we only make things writable a field at a time it's going to take
forever to catch up w/ the architecture.

https://lore.kernel.org/kvmarm/86zfrpjkt6.wl-maz@kernel.org/

-- 
Thanks,
Oliver


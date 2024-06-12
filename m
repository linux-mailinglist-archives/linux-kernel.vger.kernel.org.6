Return-Path: <linux-kernel+bounces-211869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1FE905823
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1EDD1F225A8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91ED7180A77;
	Wed, 12 Jun 2024 16:07:45 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBFAB65E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208465; cv=none; b=mG/6pV/qxb/V57zwoXCs4H/HKQsa8HZzcdQVhJBE0rP6E0k+RbbnF5/ForPoVJK3EJ3ARmvmXmbfPQ0nE26nPYoaLboMDbzYzZaEFF/v7r55htOd9AJrKJgapzfeL0J/l9/BL8s0XiWvdApP495nfZpTCG/48uGI+Y/PHKESSEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208465; c=relaxed/simple;
	bh=w1P/HimdxFTCzwGQh/bzcxtTmdNpJS49ZfDIVK/B29U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZThsrdmLoF4ZHcGxjATYDlqMEGidwXB8HaCZJc4k+0VLcdOt2Ka7CCggJ0yacIkIaclkDZ7gm3XYLorB3kWwCUpnzlbuLrp1SUkO3+slBIiVlEY3QeY+Tk2RQF9fnf4DwaEySZzEZgPbMRFpSpkP3aXVyn5G5CI2gSE54C0hdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82629C32786;
	Wed, 12 Jun 2024 16:07:42 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: maz@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	oliver.upton@linux.dev,
	broonie@kernel.org,
	ardb@kernel.org,
	joey.gouly@arm.com,
	ryan.roberts@arm.com,
	jeremy.linton@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Nianyao Tang <tangnianyao@huawei.com>
Cc: guoyang2@huawei.com
Subject: Re: [PATCH] arm64/cpufeatures/kvm: Add ARMv8.9 FEAT_ECBHB bits in ID_AA64MMFR1 register
Date: Wed, 12 Jun 2024 17:07:39 +0100
Message-Id: <171820845262.4013377.6313187525127617561.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240611122049.2758600-1-tangnianyao@huawei.com>
References: <20240611122049.2758600-1-tangnianyao@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 11 Jun 2024 12:20:49 +0000, Nianyao Tang wrote:
> Enable ECBHB bits in ID_AA64MMFR1 register as per ARM DDI 0487K.a
> specification.
> 
> When guest OS read ID_AA64MMFR1_EL1, kvm emulate this reg using
> ftr_id_aa64mmfr1 and always return ID_AA64MMFR1_EL1.ECBHB=0 to guest.
> It results in guest syscall jump to tramp ventry, which is not needed
> in implementation with ID_AA64MMFR1_EL1.ECBHB=1.
> Let's make the guest syscall process the same as the host.
> 
> [...]

Applied to arm64 (for-next/cpufeature), thanks!

[1/1] arm64/cpufeatures/kvm: Add ARMv8.9 FEAT_ECBHB bits in ID_AA64MMFR1 register
      https://git.kernel.org/arm64/c/e8cde32f111f

-- 
Catalin



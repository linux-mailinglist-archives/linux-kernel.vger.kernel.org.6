Return-Path: <linux-kernel+bounces-379849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F459AE4B6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8A1A1F22BBB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEAD1D5165;
	Thu, 24 Oct 2024 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcaLTi4j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1804C18784C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729772738; cv=none; b=Ozykqurf9skc7TggSwPTTuKzzOPQFacF7hL5iVFITFep/cy53wQ5sifOV1vcSj65kIDa4SsA4oM8KMSGiu8BTXtXMKDcxtBYtpbJ+IdC9jagQSyOcGmMYzlwRSGg1od6h2Aar+Qj41zdIYHQu9rOE5rRsbPYS7BRoAQZXRHAfRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729772738; c=relaxed/simple;
	bh=Fr7inD2Iqs0A99RN+MrWbC0MZ5NUxnu0ZpJwaCBLb2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pojPcDVu4kXU16BFUm+FC+tb/XkzivBxZ7rw+mefILYEt+sXRelDWo8espBLeRbZmeOhVwT7eEgebkidb+V35xsZbrK+dtrniqbi9jVyvAClcbnH5951bTI9LLLYpXMSwx7vSkx43R06hJ2pUmWpQCFZfRBECJwMvnsDBonw2/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcaLTi4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A3CC4CEE4;
	Thu, 24 Oct 2024 12:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729772737;
	bh=Fr7inD2Iqs0A99RN+MrWbC0MZ5NUxnu0ZpJwaCBLb2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IcaLTi4jI2EvY9DwSFCV+9f2bRi3JeLk9qnDH+Fx570+yygvdfFa4EtKABWL66yC+
	 hs2QD3Dj9kDT+mgFeVffsTKUn7YLbRpIwsvwogeH41ZrpSUI4FZCeFb2txqIUmOQIC
	 R/1Mkr6JVK2i+HZCo1emQ+sA5s7mmrJm6qQ+TasAQjdLTDE4BO6h7Xr9cBoBbogv9l
	 1reoNCw7dfj3XXJHgv3dgD4nuCRU2XBpHZLXAeIcSEMqyupKfwx+5ljgEFRFmqK68k
	 Kd2dyOi1jFOALnQjxcMeWVUhxZq+Bei+o0GBb1VHvLW0dGoaqAb0hjAj+W99vtIG+S
	 t1snir3OIhdKg==
From: Will Deacon <will@kernel.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/dwc_pcie: Convert the events with mixed case to lowercase
Date: Thu, 24 Oct 2024 13:25:28 +0100
Message-Id: <172976985183.3761088.10462811188399686482.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241016210136.65452-1-ilkka@os.amperecomputing.com>
References: <20241016210136.65452-1-ilkka@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 16 Oct 2024 14:01:36 -0700, Ilkka Koskinen wrote:
> Group #1 events had both upper and lower case characters in their names.
> Trying to count such events with perf tool results in an error:
> 
> $ perf stat -e dwc_rootport_10008/Tx_PCIe_TLP_Data_Payload/ sleep 1
> event syntax error: 'dwc_rootport_10008/Tx_PCIe_TLP_Data_Payload/'
>                      \___ Bad event or PMU
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf/dwc_pcie: Convert the events with mixed case to lowercase
      https://git.kernel.org/will/c/759b5fc6cc3e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev


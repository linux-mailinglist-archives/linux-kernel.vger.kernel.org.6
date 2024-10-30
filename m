Return-Path: <linux-kernel+bounces-388004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 171599B5910
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B8D1F24070
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4AD147C71;
	Wed, 30 Oct 2024 01:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="brrR1smL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E1384A3E
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 01:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730251388; cv=none; b=MWqxah9lRuzkFM3iRrZ4v7cz0DSjtS+ghgbpl6eDmBV4a0wU94+yzL0f1hqUsdFWNzt1kXkiBJXvt9RSi4aspCH6W7nTUB75N9s42ipxYhhPrb7HYHl3WXSS5eIe7tEh2HCJVwSvmVAbWXPWCItvp8D+eU4omtCL28jxEAvj5No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730251388; c=relaxed/simple;
	bh=9bbL58ucddYOxopOJZWP6bpXOgmfcOxllpK9hPeF74c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QUne0OYzFt1pElo+h0N3QLqv+Pq5Kj2fshr5Ga9l8qE5GEsbBmtMMWy7xOBHpUTRc3DOY82Dsg0OM/NQntSoqp3HwvsJVgBF9rVOh1uSd9foiWIpSsAdut+pX3bp41P8X9vkrAjZPhPD01JTJaFgxQTFcWtcpaZ/FIftbPF4+A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=brrR1smL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284B0C4CECD;
	Wed, 30 Oct 2024 01:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730251387;
	bh=9bbL58ucddYOxopOJZWP6bpXOgmfcOxllpK9hPeF74c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=brrR1smLI2xheqOjuQcdgtzKlJE20MygXvcdbzMzl9VuwNx6hdnuZaiLfV4BsrKEc
	 mfkMdNfQU6KiBgrt2hDARIH9ZZj9i6k3bQrcf1zjuyqDDdaG1UtnyCHm4ts5K6xwyR
	 xwNZpDp/GxwtZyXb5ADIAJcVxsfgDtQS9BtbpnIk=
Date: Tue, 29 Oct 2024 18:23:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
 dyoung@redhat.com, daniel.kiper@oracle.com, noodles@fb.com,
 lijiang@redhat.com, kexec@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3 0/2] x86/mm/sme: fix the kdump kernel breakage on SME
 system when CONFIG_IMA_KEXEC=y
Message-Id: <20241029182306.04c3451808c8b76e5e96fdb4@linux-foundation.org>
In-Reply-To: <20240911081615.262202-1-bhe@redhat.com>
References: <20240911081615.262202-1-bhe@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Sep 2024 16:16:13 +0800 Baoquan He <bhe@redhat.com> wrote:

> Currently, distros like Fedora/RHEL have enabled CONFIG_IMA_KEXEC by
> default. This makes kexec/kdump kernel always fail to boot up on SME
> platform because of a code bug. By debugging, the root cause is found
> out and bug is fixed with this patchset.

[1/1] is a cleanup.  [2/2] fixes a bug which appears to go all the way
back to 5.10.  The bugfix patch has a dependency on the cleanup, which
is unfortunate.

We could add the Fixes: to [1/1] and add cc:stable to both patches so
they get backported into -stable kernels together.  But I think it's
nicer to just concentrate on the single bugfix patch (with Fixes: and
cc:stable) and do the cleanup later, in the usual fashion.

So can I suggest a resend please?


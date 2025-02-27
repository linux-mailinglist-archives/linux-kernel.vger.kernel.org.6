Return-Path: <linux-kernel+bounces-536732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723DEA48387
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587521722F3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AA9190692;
	Thu, 27 Feb 2025 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vI9s8NCS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CDB27002F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671490; cv=none; b=gPvGCZf+r2rsocMRcCTCIY5zi1Ft+HiXj+SCiEfJq5px5yE8EEafavIKAPlLZ1TMLdfWd7GhMcVnhqthSP/Ii28ExWBnDSG7T0SXjLsXIFESsZ/Rc+BW47jT2gk87lEkSY/Q2rDOzpwEXoA2CQXx4nHTmDJeMTaTcghNpMHfIhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671490; c=relaxed/simple;
	bh=PHJN1RpbO9GMEWPKvKo8ZGNRDOt2AAgARtGo6eeodlE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uTyhkIQf4hkiaU5myHg4dt/bQ+w58NkK6gSlRDMiZcmAgPG8OLpQKdwhRWQDvyMFBgaW15Ibn+AdsO/Y9zfEMUGl0Ix5tPI6exQt9Qhr736tDjGstXGiX2o4sSOpOdkbUVxCe/RKkBnqgr43IzXD67qk4JEZYgi6VEFs+GFOMQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vI9s8NCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE05FC4CEDD;
	Thu, 27 Feb 2025 15:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740671489;
	bh=PHJN1RpbO9GMEWPKvKo8ZGNRDOt2AAgARtGo6eeodlE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vI9s8NCSEzDAoFvgPzU1qh5MCL9IOBnnspb+eNUrxnLkhf8JsddPi7oSkjFfPjdI1
	 36YsEp8HvfILAwdOPXaN6DLjMezy2xilcZCbXtAeR2VTO2bGL4Vlo5oPsrGw+kjDfH
	 2a02Gg/aPOJixzHrYEWwHxo1pG9SL9NFuHTfqLNrf3qeQ4Cw+MRZAO26/K3CBstNGb
	 M/Dp6nvD8ugZZS4rF4ZjvIWh7qXSrtMjTIqGI8mSBdlLm4HqHtcxLJQnT3JGPrzb1U
	 wS1A9QkcES7PtlX2rGtFKxjWtkDryIF9jLsXaW+NLE9Ee0QB9ZuqdHi05X1ndpA9I6
	 I3VH7J7Ec9jwA==
Date: Thu, 27 Feb 2025 16:51:24 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 17/21] tests/acpi: virt: update HEST table to accept
 two sources
Message-ID: <20250227165124.221ef1b2@foz.lan>
In-Reply-To: <20250227141603.3957e78b@imammedo.users.ipa.redhat.com>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
	<9d57e2a6ec3f523eb7691347403f05ad40782b94.1740653898.git.mchehab+huawei@kernel.org>
	<20250227141038.28501d73@imammedo.users.ipa.redhat.com>
	<20250227141603.3957e78b@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 27 Feb 2025 14:16:03 +0100
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Thu, 27 Feb 2025 14:10:38 +0100
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Thu, 27 Feb 2025 12:03:47 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > 
> > squash this patch into the next one
> > 
> > Also at this point there is no visible HEST changes yet, so a soon as you remove
> > white-list without enabling new HEST, the tests should start failing.
> > 
> > I suggest to move 20/21 before this patch,
> > as result one would see dsdt and hest diffs when running tests
> > and then you can use rebuild-expected-aml.sh to generate updated
> > tables and update them in one patch (that's what we typically do,
> > we don't split updates in increments).  
> 
> on top of that,
> it seems the patch doesn't apply for some reason.

Hmm... perhaps the diffstat that I place here (produced by bios-tables-test
output) is causing some confusion when you're trying to apply the patch.

Any suggestions to avoid that?


Thanks,
Mauro


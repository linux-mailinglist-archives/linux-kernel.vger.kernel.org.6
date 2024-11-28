Return-Path: <linux-kernel+bounces-424973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59ECA9DBBEE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 18:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0540CB21596
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 17:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA2F1C1AB1;
	Thu, 28 Nov 2024 17:46:44 +0000 (UTC)
Received: from cygnus.enyo.de (cygnus.enyo.de [79.140.189.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CA31BDAA2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 17:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.140.189.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732816004; cv=none; b=OzQL8eTeCr2mLoNs/CC88zO0NWGYCgCPT4rbk3FWXdZWZ3DJzMh0wDQtS812Q5iKyzFUUUCCBgM+g9z220kWxZppSY0fqgzwtqqNSefM2wfqGEQy/uS1SClVzyI01BoLMWeOGbxAO+0UZct5v6hj/9evhDxOy5q7CeFhfvInljg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732816004; c=relaxed/simple;
	bh=RcTkVVYuS7oBf3n2H0uuVQNF42cLbfeTdefPuZ9ig3I=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Zc0bH3d0k2O2CabDTd/n0BAXZBeDNqnxqq93glKND3LJvcJiNmrp2zA5J1TfyHSf4lrl/sTcs8AHOpxz5CS1pnXsjZww8IZGmQpBZEKyWVMGXr8p4/+2VBDhntxXycaEoq1QPeReqUs6dGLDhFhMw49X6924HMLi/kENRBwrFz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deneb.enyo.de; spf=pass smtp.mailfrom=deneb.enyo.de; arc=none smtp.client-ip=79.140.189.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deneb.enyo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deneb.enyo.de
Received: from [172.17.203.2] (port=50781 helo=deneb.enyo.de)
	by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1tGiVu-008fTg-26;
	Thu, 28 Nov 2024 17:41:14 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.96)
	(envelope-from <fw@deneb.enyo.de>)
	id 1tGiVu-000Jbd-1o;
	Thu, 28 Nov 2024 18:41:14 +0100
From: Florian Weimer <fw@deneb.enyo.de>
To: Rui Ueyama <rui314@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Wislist for Linux from the mold linker's POV
References: <CACKH++baPUaoQQhL0+qcc_DzX7kGcmAOizgfaCQ8gG=oBKDDYw@mail.gmail.com>
Date: Thu, 28 Nov 2024 18:41:14 +0100
In-Reply-To: <CACKH++baPUaoQQhL0+qcc_DzX7kGcmAOizgfaCQ8gG=oBKDDYw@mail.gmail.com>
	(Rui Ueyama's message of "Thu, 28 Nov 2024 11:52:35 +0900")
Message-ID: <87ttbrs1c5.fsf@mid.deneb.enyo.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

* Rui Ueyama:

> - exit(2) takes a few hundred milliseconds for a large process
>
> I believe this is because mold mmaps all input files and an output
> file, and clearing/flushing memory-mapped data is fairly expensive. I
> wondered if this could be improved. If it is unavoidable, could the
> cleanup process be made asynchronous so that exit(2) takes effect
> immediately?

It's definitely a two-edged sword.  For example, when running parallel
make (or Ninja), it's essential that process exit is only signaled
after all process-related resources have been released.  Otherwise,
it's possible to see spurious failures because make respawns processes
so quickly that some resource limit is exceeded.  This is already a
problem today, and more lazy resource deallocation on exit would make
it more prevalent.

The situation is already bad enough that many developers have resorted
to retry loops around fork/clone/pthread_create if an EAGAIN error is
encountered, assuming  that it's related to this.

  Bug 154011 - Task exit is signaled before task resource
  deallocation, leading to bogus EAGAIN errors
  <https://bugzilla.kernel.org/show_bug.cgi?id=154011>

> - Writing to a fresh file is slower than writing to an existing file
>
> mold can link a 4 GiB LLVM/clang executable in ~1.8 seconds on my
> machine if the linker reuses an existing file and overwrites it.
> However, the speed decreases to ~2.8 seconds if the output file does
> not exist and mold needs to create a fresh file. I tried using
> fallocate(2) to preallocate disk blocks, but it didn't help. While 4
> GiB is not small, should creating a file really take almost a second?

Which file system is that?

> - Lack of a safe system-wide semaphore

Other toolchain components use the make jobserver protocol for that.


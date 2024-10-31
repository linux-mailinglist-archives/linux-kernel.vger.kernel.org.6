Return-Path: <linux-kernel+bounces-391385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA0A9B85EB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C251F223B5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFA91D0157;
	Thu, 31 Oct 2024 22:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCGMVt5Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CA61CC16B;
	Thu, 31 Oct 2024 22:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730412646; cv=none; b=XOh0mKV2IqQYZ8cOqgmLDdwDNvulF7bBVtcDfG/1Zszx8G7CJ39dAma2kRjAYFYD9boEp6voKb/bPiDT8ZXLZAA/dfubaCWdSNWIol4DAdQsgSqvDT3XFP95hLCftozGb4fobwGeZAweBkUyhPOXmcX0+kCaI1/noIE17KDIpb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730412646; c=relaxed/simple;
	bh=eJWDa4aohLV/Z7xA2xETjGrhQOcKItwfm9HyMbigK1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMKzt4JVkTP+BIGpnpQXl9MvasiCAXYg30AlIGj+BPyNPTpFOhp+7MNOp3OuOezrLDeEg9Zf9CzuB3m/9vfndybGvmrEp3zts3JZSYvmUh/KzmwoeAcA5BxQkG56xIEBHwnr/+DdwhWzC8v7nQL/o43FInSdoLlcj7Eeh91se38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCGMVt5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D429C4CED1;
	Thu, 31 Oct 2024 22:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730412645;
	bh=eJWDa4aohLV/Z7xA2xETjGrhQOcKItwfm9HyMbigK1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mCGMVt5QnrQFSrrinkV6U6+X6+MbhpZLeHAntZF6ihcuMVMPN1Co/j9fNo45bs4td
	 62u3Y1eVaNTlbHr0INFpD53agamzafgSyLdrkDsVVW9vXlFnyZAX2qORqgwsWQIeHh
	 vDXY7QuM2biKlOHjiEV3W+EHbcy1BaO8QGsdEalUYYCo4pREXCBpmnvn5RyDgA9QY4
	 MWcDS4aOkk440yHIr5l94Jha7RwixiFHV8xfACXnb8IFPmoOmc8rbskDbID9E8LLXP
	 gDhQvA3CkHjagc9bUFGrqv+BxsDhLhvUWcnsADCUpkPUQNCwjaU0xjRa4KbtGn+N2M
	 ESz24DC7k+iBA==
From: Kees Cook <kees@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Tycho Andersen <tycho@tycho.pizza>
Cc: Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Aleksa Sarai <cyphar@cyphar.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH 1/2] exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH) case
Date: Thu, 31 Oct 2024 15:10:37 -0700
Message-Id: <173041263505.1781237.9706368369948860422.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030203732.248767-1-tycho@tycho.pizza>
References: <20241030203732.248767-1-tycho@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 30 Oct 2024 14:37:31 -0600, Tycho Andersen wrote:
> Zbigniew mentioned at Linux Plumber's that systemd is interested in
> switching to execveat() for service execution, but can't, because the
> contents of /proc/pid/comm are the file descriptor which was used,
> instead of the path to the binary. This makes the output of tools like
> top and ps useless, especially in a world where most fds are opened
> CLOEXEC so the number is truly meaningless.
> 
> [...]

Applied to for-next/execve, thanks!

[1/2] exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH) case
      https://git.kernel.org/kees/c/7bdc6fc85c9a
[2/2] selftests/exec: add a test for execveat()'s comm
      https://git.kernel.org/kees/c/bd104872311a

Take care,

-- 
Kees Cook



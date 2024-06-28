Return-Path: <linux-kernel+bounces-234215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC7191C3D8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E99284DE6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F411C9EC6;
	Fri, 28 Jun 2024 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ba1rh1By"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457D11C9EA4
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719592691; cv=none; b=dnunI2gb2PqPbE9i3C2LcLjs33pRB+rwbyEZrHyeuvA1ti17bZ1BvhnhPy4MXkqohlyiUYLNWIy6MOAavyofDRbxUcQSgjjJXvClYb39/vG6ujtJNfverqE+4kUU6rOq5clqcjDYDJw5l1xCZxdUsvioE/ba8Ks1guC4Y/KlvyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719592691; c=relaxed/simple;
	bh=PRIA/HadKVCOA077YzGPPpogOvB/jBiSNuxV6mKXcTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7p6nO3bmv8HU8z4cGejMimxNypxsT/YhWjfqjMlnfM3T41l4k4/SlIezBRx40N4Ap9OR43a0wBURcEHzwtd4OETiii1LApUV47grukPh+Uf0a1TzuWlEDRaCO3qZFkDiySLSRNeMPPziUodeV23mNRTcEfnKoD/AkOjXEfZ3FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ba1rh1By; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6934C116B1;
	Fri, 28 Jun 2024 16:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719592689;
	bh=PRIA/HadKVCOA077YzGPPpogOvB/jBiSNuxV6mKXcTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ba1rh1By/NqDL1IesbeiWNcPrZsyuWcsfAgelCsf8jNFlsNzBUsySfYzc69vUYJvW
	 JiSU80oMjYVn8M6SbJIGuJM4NXZP9AopomfgE7ksWMLZmmCEQ4lJ/u9Wu9JkV4+lI7
	 Os67Gy7LerUvszqj+trdhxhMc4+apru7dAMP16BSm8SXC+Y8n1lzGDbdbN6oTvmiKl
	 52rEXCr9W0lkcjsHgxAPxv1TMzt0h6FVeKB/U9utgjNhxR78EjPSNXBaRXoA4mTbVb
	 VOTVsvUEkN0PFKy3d+LfueMCZpTOhNz4Our7bGdOL3gen/esoB9i6w5bH5WzfKH4sZ
	 Sn1ydlwgmDCKQ==
From: Kees Cook <kees@kernel.org>
To: Kees Cook <kees@kernel.org>,
	Andrei Vagin <avagin@google.com>
Cc: linux-kernel@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 0/4 v3] seccomp: improve handling of SECCOMP_IOCTL_NOTIF_RECV
Date: Fri, 28 Jun 2024 09:38:06 -0700
Message-Id: <171959268390.3862573.835182164274208402.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628021014.231976-1-avagin@google.com>
References: <20240628021014.231976-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 28 Jun 2024 02:10:10 +0000, Andrei Vagin wrote:
> This patch set addresses two problems with the SECCOMP_IOCTL_NOTIF_RECV
> ioctl:
> * it doesn't return when the seccomp filter becomes unused (all tasks
>   have exited).
> * EPOLLHUP is triggered not when a task exits, but rather when its zombie
>   is collected.
> 
> [...]

Applied to for-next/seccomp, thanks!

[1/4] seccomp: interrupt SECCOMP_IOCTL_NOTIF_RECV when all users have exited
      https://git.kernel.org/kees/c/6dbfc08fd57a
[2/4] seccomp: release task filters when the task exits
      https://git.kernel.org/kees/c/13eb42e2529e
[3/4] selftests/seccomp: add test for NOTIF_RECV and unused filters
      https://git.kernel.org/kees/c/9b366d69118b
[4/4] selftests/seccomp: check that a zombie leader doesn't affect others
      https://git.kernel.org/kees/c/22cc0f3b4d0c

Take care,

-- 
Kees Cook



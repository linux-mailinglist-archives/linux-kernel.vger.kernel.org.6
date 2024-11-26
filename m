Return-Path: <linux-kernel+bounces-422152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F38A29D9537
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F022822B6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0201C0DF3;
	Tue, 26 Nov 2024 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtWnebvV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1001BC063
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732615890; cv=none; b=jjaZZnybfSy+xfDByJQUm+4nM4eS5eHLB20bKvY5UUAhMbS4eb2Z4/sXkryuWBqp3TGSVm0QQJ/q3zbPhi6P7WbOU/5mWFlZh+bA0YrfgSLh0WBekksyKqItx9o7wdA3oxa+SpxXCQJ6fV2e9Cz4q0d7xnSkvtMe6FRxQS2LsRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732615890; c=relaxed/simple;
	bh=XtbX0PNcobErADKIQDXW4UOVM2C45/klHQncpw6bRBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hWamCMp71mTlBY7c9g/BRB4M80AEad0xWJZIb+EodNhX/VH0zjZGIhvGmEnGZYBw7yaezfCV4DQHx2S4UiNvBdcgTblyAOyc5xgTmFOipVsJsdIt1t2iXtMYkMyfBdlCHkhpfqAM1TqHgOi2wMHz2b3cKrfDjp9edBQPbaFJhdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtWnebvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420BAC4CECF;
	Tue, 26 Nov 2024 10:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732615889;
	bh=XtbX0PNcobErADKIQDXW4UOVM2C45/klHQncpw6bRBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QtWnebvVoGDTn95WHRvF3nWB+VaeBn3skCEuVfaHemk4zfP7d+eMCAoJnWwDKcFeo
	 qwg7jY0cAlw1cLSjxEi0WFZF50qH+bFvn2OmmMNwXbP8qw91AnfWK+nZEgyH6D+x9W
	 04/icMOwr8lbpKOWrQCbqKa573ZRQH1jAJJ8fPEs8RBf6ocnC8z/UeDILZDLYY8W6e
	 KlGjJK9N12tbhydzaQWxrGRT2QwXDvxPQuDE2wa0dtRRQnuEu01Ibn3Bklh6ay+J9J
	 3RSe3TE+9PD0x/vvexXUyUH2H607XEs1dwUaMCP5N6N5+zSjnOl0vyI34yrYzqDvRi
	 SPSzGF0O1HbCQ==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: Christian Brauner <brauner@kernel.org>,
	stgraber@stgraber.org,
	tycho@tycho.pizza,
	cyphar@cyphar.com,
	yun.zhou@windriver.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] pid_namespace: namespacify sysctl kernel.pid_max
Date: Tue, 26 Nov 2024 11:11:22 +0100
Message-ID: <20241126-gulasch-hochland-7c3830e8214c@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241122132459.135120-1-aleksandr.mikhalitsyn@canonical.com>
References: <20241122132459.135120-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1306; i=brauner@kernel.org; h=from:subject:message-id; bh=XtbX0PNcobErADKIQDXW4UOVM2C45/klHQncpw6bRBQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7zju1pSOtTfLdTBXtmy+2aX+/XzNX+cj86fOjdbek9 FkeXnnsYEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEroQz/E9rTO3wLvy2LXfb roVXGfk5p5g6673+dXzSyy+HRRLuaH9i+Cvo9Cj+SM+u6Wb7vd6X3tj/XnN9imJfiOeOS5dEL39 8wswIAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 22 Nov 2024 14:24:57 +0100, Alexander Mikhalitsyn wrote:
> this is just a rebase/small rework of original Christian Brauner's series
> from:
> https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=pid_max_namespacing
> 
> Christian kindly allowed me to take these patches and resend after small modifications.
> 
> Current tree:
> https://github.com/mihalicyn/linux/commits/pid_max_namespacing
> 
> [...]

Applied to the kernel.pid branch of the vfs/vfs.git tree.
Patches in the kernel.pid branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: kernel.pid

[1/2] pid: allow pid_max to be set per pid namespace
      https://git.kernel.org/vfs/vfs/c/b7e4772ef1dc
[2/2] tests/pid_namespace: add pid_max tests
      https://git.kernel.org/vfs/vfs/c/bef328352883


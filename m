Return-Path: <linux-kernel+bounces-529942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2CEA42CC7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B1618985F4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE81F1DC19D;
	Mon, 24 Feb 2025 19:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbKtU+4N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C01E38DE9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740425457; cv=none; b=Uey3uNKcxzDKbw3FEzkDtxoc/q8hXQS0FdIKz6FH+UjOdEAOsJmMxgmUzAVQWVfyHmimjLEUofxq+ZKQllOXlexARaDQ9NkyIXjYL6BSeKKZimP/uyQS/AOr9LfrDsn4t+lfTYk9DqIiQAZxDBKXOldgJJBrfeQH5CuO+sYROOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740425457; c=relaxed/simple;
	bh=i0uJPsGSsd5apbplPgXJf5qL4tghR45S4V3IUPEeFpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gBeEZSHHDnkD3Y2a51aD3y0dsahOF9EQba6JswSGoHNAeCfDt7IaccUN9waKd2AY/o9RfTO3qI58TRewR75C0/n3mm+ygPcOBpu4etcWvbmh3a2iqZ37HfW0M7BDGDnf0Zx4ZQIC7Yzx/5/fsF/2+2DKXXHv+ZODkH2DFVITJiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbKtU+4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB4AC4CED6;
	Mon, 24 Feb 2025 19:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740425456;
	bh=i0uJPsGSsd5apbplPgXJf5qL4tghR45S4V3IUPEeFpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rbKtU+4NS6wy9+daz0I/UXi7ltDPj8TvOWG+2jBn8tOpk91RQ1rw483uzF3VoM3/n
	 NlsvHh0cgtRYxLkGiXfly8durD9h2s3wd04goI4irWrsO6tCIVnc5KdycjIut5x0g2
	 jBKjKwoz7h5a3CNh33UFdsosI793SAfIN7R7jU9nlMGS6lHauYuiZeI2B3JnMdgthL
	 w2cg9yWGNh+ihUnk41NxF3EbiNz+ShEjRzFBLgYwKVi1D+i7dQdfEkwup3kFW/Ahov
	 I0j2OISs/8U6jylbSyrHeHnX4wrMAfVI0vlA6NItFdhM8i3JlVyLCY7Zh7invo5c2e
	 QzxK20tKrlNhA==
From: Kees Cook <kees@kernel.org>
To: linux-kernel@vger.kernel.org,
	Yonatan Goldschmidt <yon.goldschmidt@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] binfmt: Remove loader from linux_binprm struct
Date: Mon, 24 Feb 2025 11:30:52 -0800
Message-Id: <174042545158.3904061.10920343398793982439.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250223223234.13764-1-yon.goldschmidt@gmail.com>
References: <20250223223234.13764-1-yon.goldschmidt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 24 Feb 2025 00:32:34 +0200, Yonatan Goldschmidt wrote:
> Commit 987f20a9dcce ("a.out: Remove the a.out implementation") removed
> the last in-tree user of the loader field, and as far as I can tell, it
> was the only one historically.
> 
> 

Applied to for-next/topic/execve/core, thanks!

[1/1] binfmt: Remove loader from linux_binprm struct
      https://git.kernel.org/kees/c/cc9554e662a3

Take care,

-- 
Kees Cook



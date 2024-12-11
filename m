Return-Path: <linux-kernel+bounces-440825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B3E9EC4C9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 07:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FEAE168A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 06:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A0B1C32E4;
	Wed, 11 Dec 2024 06:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3FK7Wsd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B5B1B0F01
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 06:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733898681; cv=none; b=PE/kOLCRhNL+0hoMa33zuc7hMc+devx3UpV61WNayawjjmwrJty0Y6uwo9nEB4h715FkyadN9MMB6UzV3Z4NQTnGWoYzxHmkVsR8S+G3xUNYpCstNr+0vr85/FJA3Za6IDnQQca0sGASm3z5hivlnNHHIh4dF6LtTb1uZZj7bT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733898681; c=relaxed/simple;
	bh=iKbbAZdqpm4Pf+Okwh5TW/csA+qVL9KUsTHYi6hBx2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COt9V35/T131yy55dmJ7PqoBY39GseAa3uH0EnZ4nL0cmpg/L3+gYO/z2BlWfUH8bdmxKURz80kH1amkq6ImjNfZZFD8YUVgF6j6+TnbtRv2i6uR60/2hyIoVFpskMouBvhno7/Mopac39qqvc7hM65ReO2k40EtSw7KCO1O1yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3FK7Wsd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC36C4CED2;
	Wed, 11 Dec 2024 06:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733898680;
	bh=iKbbAZdqpm4Pf+Okwh5TW/csA+qVL9KUsTHYi6hBx2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B3FK7WsdEcp0VGp6sTBUCzPxTXUS+TcsAR+IaD69T3DKzvSy+hVHlJscMh5iyByTN
	 DYsNspytSZ4DPlDQhCb3Q0nXvK5Htg2ZQ9Vyb8IzkDGBpf6MMKXfvJ69Rubf1tcBcN
	 Pu5vOLJ8MrWCdkllZGAoWYsYaskxjH4bpS/dKiEZ7LPo4X1DzCuYUiXd9riSyjj/WN
	 V4XmMp7zKMSLeUmVa42vQwd7NadL1zpgoPzuZCi1bH5HEmSOrAjjar8aXSN71yqKHZ
	 AmaPb+MuUnjgQBlkXEm/YwFEMcjjvqrNbXMnu5bc9Qmgl/CcdfvmS9KlF5lg132bDZ
	 KdVDYqmBTVVzw==
Date: Tue, 10 Dec 2024 20:31:19 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: sched-ext@meta.com, kernel-team@meta.com, linux-kernel@vger.kernel.org,
	ihor.solodrai@pm.me
Subject: Re: [PATCH] scx: Fix maximal BPF selftest prog
Message-ID: <Z1kxt9ptF6DoKX7N@slm.duckdns.org>
References: <20241209152924.4508-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209152924.4508-1-void@manifault.com>

On Mon, Dec 09, 2024 at 09:29:24AM -0600, David Vernet wrote:
> maximal.bpf.c is still dispatching to and consuming from SCX_DSQ_GLOBAL.
> Let's have it use its own DSQ to avoid any runtime errors.
> 
> Signed-off-by: David Vernet <void@manifault.com>

Applied to sched_ext/for-6.13-fixes.

Thanks.

-- 
tejun


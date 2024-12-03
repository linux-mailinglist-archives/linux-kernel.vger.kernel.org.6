Return-Path: <linux-kernel+bounces-430259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D260F9E2E8F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36CDA166C14
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F121DFE15;
	Tue,  3 Dec 2024 21:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COcwK84S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F6A20ADCE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 21:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263027; cv=none; b=R5SB7BcE6usP+ZKbUHLLFOi0ZC8heZUI6yj/7v2XtF05LlXOzd6JF9j2Xkv3eK7dmNGTM4uzyvdpk1mYbqKqZQSLskOnUyMK38mQun6jj+v/xB/FBJhsxG4hMZgopmECxg3GC31wyE/JH9aR/zskxRnOw2iBW/6v9EPXyhRrTvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263027; c=relaxed/simple;
	bh=vyJc6LdCFl7LMsD4U59BcqsW1C6w77Fu+SKDR1e995I=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=bYqqfzl0bPskOSSdgmSJtVZG9gc1kh0Nwucn5hRUiNqaw+Tbxvh+QqVLbeSKoBZ8eZnRGrHTvkevidz03MaJZvMAfgj/+UDxm+CWe1R2dtQySh1v5IaiT5DSFGP+KHG1mVTgIW3+X4sW6FnMhw2WeeADzpWtRJwbcmulfk/LKK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COcwK84S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B075C4CEDC;
	Tue,  3 Dec 2024 21:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733263026;
	bh=vyJc6LdCFl7LMsD4U59BcqsW1C6w77Fu+SKDR1e995I=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=COcwK84SFOv4s7pGJ5SkIOACkeRc8HKEf25foOanA8Lx+F6LQinlG4DyQj7L/ujEL
	 JlWXXLGplsWkBJLKLQwdw7Ohn/8rapbtCwLcGDsw/LapPgerUSdgLJkzc7eNNoSiFi
	 gVEsV0pZFVCWvM5Q4pFBT1fDotpNCRCHvfq0ONyKTUGM4tDdQ8svgYYJFwLX0GzG9V
	 bsJoS71NL6xFxlk1f+he2FP8oKr/Z7I86DW0qvLBeN9ozPcRYqhXJdqeUs4t7lk3Ge
	 ntGB0PTyc9CwkvdS9zTOK5tqFmRgQ7Imdx4WktjsEYpxY2zkLpCemtJTKHdHs2zjZO
	 fOlNTxx1b1AMw==
Message-ID: <685729f727d7f404d18b43a535505fd6.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241115230509.1793191-1-saravanak@google.com>
References: <20241115230509.1793191-1-saravanak@google.com>
Subject: Re: [PATCH v1] spmi: Set fwnode for spmi devices
From: Stephen Boyd <sboyd@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, kernel-team@android.com, linux-kernel@vger.kernel.org
To: Saravana Kannan <saravanak@google.com>
Date: Tue, 03 Dec 2024 13:57:04 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Saravana Kannan (2024-11-15 15:05:07)
> This allows fw_devlink to do proper dependency tracking for SPMI
> devices. So, better deferred probe handling, async probing, async
> suspend/resume, etc.
>=20
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---

Applied to spmi-next


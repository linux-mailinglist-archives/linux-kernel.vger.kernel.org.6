Return-Path: <linux-kernel+bounces-396785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 670A39BD1F2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0CA1F2323E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD0A1714B3;
	Tue,  5 Nov 2024 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOuEmjon"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C78C5674D;
	Tue,  5 Nov 2024 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730823242; cv=none; b=UY1r8xc6YEmbtVNxc9Fg5CY7Y+HT+u7DmuqB/pUfC6dYa111p62LLwQViXD5A13oyRl/Q2oEYG6jwsqcDBC5SPgIPMedpQxUiT3RkQz8s6R67l7hlugGaLQdD7+Je5xRLksLaTCskwF8TECrjsI8YgbNK52oy5XzGmuMIU6js4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730823242; c=relaxed/simple;
	bh=kNqJvWjI5Xv0aOKUS9RlKFkV67Nc7o5F6Ctjxq01Rww=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k7oNS/N3guFBQG8yRsGouvfrW53NYTlqWr6pVnLmKoqH1L3twgVBSZsz3H96MFpLNrxG2FuZbBRbJSozMhb3z2YplvzfIkYjSBs0k8Q5gSrNlOD3wLmgV/yXN/dGY41jXuLb7qoSN/3cynfRFdIyIKg7rweGMto05Da25IfYRQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOuEmjon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EADEC4CED3;
	Tue,  5 Nov 2024 16:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730823241;
	bh=kNqJvWjI5Xv0aOKUS9RlKFkV67Nc7o5F6Ctjxq01Rww=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eOuEmjonUIcQ+ud/AKHdzCasrXq34DyNNSI03qyar6mjPyoSWLXSFR5nQobdgMAqG
	 4y2986PFA7THO5ZuT+A8xdODk3mNJgfv2ua3DWH2Jlt+hcc6HDlT4Gfw17/w0KJ6x+
	 YDO4TslKf6k0U4h8UXd2ojsBOeDJc1RDWX/FI0HYuZR5tq1LFAUFK7Ubrn7DBbbwBF
	 ysNCUn/tMbfYjEJ+V49DcOeWm6pTYwS3U0hBBc2CNgYK7daQW/etlmCuxuyUopnKXV
	 oLqVSGK38ygkxP6cqKVwHasUI0Hvj/AKZZwUiGqgzPtTAGe0G7U7Fjb2O1zxIhCO4k
	 iz98v4dyGpXKg==
From: Lee Jones <lee@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>, Lee Jones <lee@kernel.org>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <83194335554146efc52c331993f083bd765db6f9.1730205085.git.christophe.jaillet@wanadoo.fr>
References: <83194335554146efc52c331993f083bd765db6f9.1730205085.git.christophe.jaillet@wanadoo.fr>
Subject: Re: (subset) [PATCH v2] mfd: cgbc-core: Fix error handling paths
 in cgbc_init_device()
Message-Id: <173082324035.2963343.17400162256012708399.b4-ty@kernel.org>
Date: Tue, 05 Nov 2024 16:14:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Tue, 29 Oct 2024 13:31:49 +0100, Christophe JAILLET wrote:
> If an error occurs after a cgbc_session_request() call, it should be
> balanced by a corresponding cgbc_session_release(), as already done in the
> remove function.
> 
> 

Applied, thanks!

[1/1] mfd: cgbc-core: Fix error handling paths in cgbc_init_device()
      commit: 5a700e77d6458e838b4882627771cc5f367827af

--
Lee Jones [李琼斯]



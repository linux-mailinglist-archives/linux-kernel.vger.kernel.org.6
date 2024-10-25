Return-Path: <linux-kernel+bounces-382671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6469B11DA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 23:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2161C20D45
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917E6217F52;
	Fri, 25 Oct 2024 21:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Av71RC1g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98526217F23
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 21:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729892834; cv=none; b=tFZnbra9yLqX8SAk88EoFP6qtYGs0i8kRDo1gOuLt709sfLEQMGH9vPBqPr8MHmBWpjiqA2c85qkp+U8kbfvtUTUDoksM4EYhuuEn2E06D+JUavs4ZO7c+yJOkglROIcaieHgUEtRy/dXBZ1S5ULTiJOYbbOdAwmkvMQhotZsqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729892834; c=relaxed/simple;
	bh=7NMbwC5twDhXGNzh3xQwOxFnMlEkyhvPV00ZhQLFnHY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uvFfBIbpVjBeaULmNpW8LAk5yHfiuEHqwHbSt3ft7lNiYMo0fU/g7zq22iT4D5PBCawmHugKDUDvEZOrFNViPNEyQN2rZXyYfmuPaso/sFU5WC9iHuEu8dQrRSTpqJ/78dZDMc7aGgxfUiY83pOoIqlAj7pPgKvJfwaqvY80URY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Av71RC1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6F0C4CEC3;
	Fri, 25 Oct 2024 21:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729892834;
	bh=7NMbwC5twDhXGNzh3xQwOxFnMlEkyhvPV00ZhQLFnHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Av71RC1gaNabg6ndWFT2FYp9vhmSm/xTpU5no9jFvirrMhX8vRsI1p4tbw0zSHOem
	 1pzuclRtn+IGV4RyaL2ctr5XusZZzlzKIWVk0xvgJdMB/np/rXIhJPqqrewUzDeYHq
	 tRktmf281N12oDygInNqqm/VutSfTIbyBebxnTJg=
Date: Fri, 25 Oct 2024 14:47:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn
 <lukas.bulwahn@gmail.com>, Simon Horman <horms@kernel.org>, Niklas
 =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Louis
 Peens <louis.peens@corigine.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] checkpatch: always parse orig_commit in fixes
 tag
Message-Id: <20241025144713.49ec30423ecce710618235d5@linux-foundation.org>
In-Reply-To: <20241025-checkpatch-fixes-commit-v1-1-1b31f9ce178b@gmail.com>
References: <20241025-checkpatch-fixes-commit-v1-1-1b31f9ce178b@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 16:48:34 -0400 Tamir Duberstein <tamird@gmail.com> wrote:

> Do not require the presence of `$balanced_parens` to get the commit SHA;
> this allows a `Fixes: deadbeef` tag to get a correct suggestion rather
> than a suggestion containing a reference to HEAD.

Please prepare a more complete (and more understandable) description
of the issue.  Including sample input and checkpatch's response to that
input would be appropriate.  Then please resend.

Thanks.


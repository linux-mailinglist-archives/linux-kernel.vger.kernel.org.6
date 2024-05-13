Return-Path: <linux-kernel+bounces-178148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 508EC8C49B1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 00:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59B71F21DC6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 22:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79028529E;
	Mon, 13 May 2024 22:41:54 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2703153E30
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 22:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715640114; cv=none; b=I49rKYKyoElNvbW9oEXoIPtbAJN47S/9FvHx7fS4q2PRt3OasomGnFTbLI49Gxr19ESsPXejeZJ0m2SaA8i67ndkAZVks0Ue+yHCktd1CwEWtHPeWzJxveWa9fJBG/KFtTcu1Aan1GurOx7PnmZ3soH3tbiIAXecQQFBE9MmBGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715640114; c=relaxed/simple;
	bh=a4LzCokIiFubFamnVGpZlXQTo+UT76ipM74gha4lRBE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Hfmpui9j967HsohSET05jjCHiE7psL+frjL39BEdSnhObeOrv2ww1Q42vToTzUYRcdxYdxPfNrvumH6znylPaj8gnxuL0KbkcjX2YRXZZ2nj0J+4zIsuSMy/n9RYg0Y5+fZKZkhRx0W0MNqEyG7xLnQr3wxBKDzCFY1lw7klqlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id 4F76040A94; Mon, 13 May 2024 15:41:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 4EE054093E;
	Mon, 13 May 2024 15:41:51 -0700 (PDT)
Date: Mon, 13 May 2024 15:41:51 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Yang Shi <yang@os.amperecomputing.com>
cc: Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org, 
    scott@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: force write fault for atomic RMW
 instructions
In-Reply-To: <6066e0da-f00a-40fd-a5e2-d4d78786c227@os.amperecomputing.com>
Message-ID: <8c6cc22a-5e24-ede5-94d9-06064a68403d@linux.com>
References: <20240507223558.3039562-1-yang@os.amperecomputing.com> <Zj4O8q9-bliXE435@arm.com> <6066e0da-f00a-40fd-a5e2-d4d78786c227@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 10 May 2024, Yang Shi wrote:

> Yeah, I'm confused too. Triggering write fault in the first place should be 
> fine, right? Can we update the spec?

That is certainly the best solution. Howver, there is a large base of 
machines out there now with this issue.



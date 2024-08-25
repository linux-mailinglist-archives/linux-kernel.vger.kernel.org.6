Return-Path: <linux-kernel+bounces-300323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E5195E25F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 09:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5BB01C21504
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 07:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825905811A;
	Sun, 25 Aug 2024 07:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIA3BA+2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB5739AE3;
	Sun, 25 Aug 2024 07:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724570329; cv=none; b=fCB5nXM7099zPtqfkKtrc/uEHnl3+cIr8pzErLe/Dm3hsnXj432NbR/VutZdKHPT51BjOT476uNOFJxICBZbUZpP0vatFXKnr7n+ipRn1egI7+XrVgK8CLte6RRXZhiTXPT9sQSIHUM59+xVWINlFr+2Jr5KJvz8V5u8ychiCL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724570329; c=relaxed/simple;
	bh=xb63LHtKD3tB9UW2G3VObufzQoQ9/LCxFdP///ubXr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCmdlSWcE9gQaP+GOaYG9GOHjuC6qKlHe/hTTNkbyiWivpkW+JZkiX9U0AuzjCYU6z7iWBQCwG4d214WHBKbLJFpG9+Cox/Pyt/8yXiNIokfwCsuwOi+8/8FNfLkLjBBm7xVHtJshGdxcISd1WNFnXpqaGUE/9zMFZOSUgnVGng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIA3BA+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC67C32782;
	Sun, 25 Aug 2024 07:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724570329;
	bh=xb63LHtKD3tB9UW2G3VObufzQoQ9/LCxFdP///ubXr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JIA3BA+2ynbP91MOk8MJEKT5o1jcLyy6/htwtQD0+oqlBslRfcDSTBSicvc+WPxkU
	 iUiGkJ7fN47NtxnZSQYL04dIuZNcxCJbLXEwF+R3grr2nFhIq4d/jXkrs28rx/EXUx
	 U0UotYktg+XFNaNe7EuZkWaB6RmFUwSTY6b7tbNmDccoa7pJPYHSJ/812QQNg0DAeu
	 JkcApt47qLyUc6H5mJQ08LkvWo6+jb+NiIR+ipK4+qSYrI4dwrydK4x78SMkmmTbUn
	 zUxa4I+kXTlIf+O+0Y1Ku35uRu7wOI+NZad1twCkOB0gjPsAUj0C1GX6WkASMXTkld
	 MsDg4kIaY6cnQ==
Date: Sun, 25 Aug 2024 09:18:45 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	chenhuacai@kernel.org, Kevin Wheatfox <enkerewpo@hotmail.com>
Subject: Re: [PATCH] of_reserved_mem: Save region name string into struct
 reserved_mem
Message-ID: <lsn4bkeup4bjmxwgbgwtaancunszsqnnowi7gocyh2l5kftosh@jcrvd2gnkuli>
References: <20240821-save_resv_name-v1-1-b9c17f103ffb@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240821-save_resv_name-v1-1-b9c17f103ffb@flygoat.com>

On Wed, Aug 21, 2024 at 02:51:02PM +0100, Jiaxun Yang wrote:
> Previously only a pointer to fdt string pool is saved to struct
> reserved_mem as region name.
> 
> As on some architectures booting FDT will be wiped at later initialisation
> stages, this is breaking reserved_mem users.
> 
> Copy and save the whole string into struct reserved_mem to avoid
> FDT lifecycle problem.
> 
> Reported-by: Kevin Wheatfox <enkerewpo@hotmail.com>
> Closes: https://lore.kernel.org/loongarch/ME4P282MB1397447C3C094554C7AF2E37B58E2@ME4P282MB1397.AUSP282.PROD.OUTLOOK.COM/

I doubt this uses mainline tree...

> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

This is a bigger problem and should be solved unified way in multiple
places. You cannot just wipe out FDT from the memory, because it is used
in all other places.

Your report earlier probably used some custom patches allowing this
wipe out, but that's the mistake. Fix your wiping out mechanism...

Best regards,
Krzysztof



Return-Path: <linux-kernel+bounces-514999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78240A35E63
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4E53B1091
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2140263F4C;
	Fri, 14 Feb 2025 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M3ePWgON"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37DD77102;
	Fri, 14 Feb 2025 13:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739538385; cv=none; b=k69rwcYXHadkIOyCom38NQQrNmrRlprlQtuFx8CPWqhHEUaBz/1dQa5seTvWmaDw440HsNe/VQtpYI+1BeNONJLJ/St6N8LcBBNQFYff4MrTJL8OnO7k0IvPJbWikQ8iCUR3fXYr7kx+brYj6RSgRY/w8y4g788M7gQO1lH4USs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739538385; c=relaxed/simple;
	bh=LEyZcHxbB0bH6kmEWTT6bdbvEu7Xn6Gm+07xRH84wpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuVW6fnuxV19R+Ev0/PBG5YYTI1k8GGuPs3e0kyYj4kC0MyoGVxp1ZqV6dCZoQLNBWDltstJrTLjsQJXEb5bjgU7p6L2wmz+6IhwU8tMiLGmtSjfLt5E6SVgEE7/JBYqSeRQ5ns2NcZss1RThhKhzlM1yc679r6DDIyCOwnKgR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M3ePWgON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A801FC4CED1;
	Fri, 14 Feb 2025 13:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739538384;
	bh=LEyZcHxbB0bH6kmEWTT6bdbvEu7Xn6Gm+07xRH84wpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M3ePWgONWMI85BY8it36WFO2nyGKiboHTEkRO5tY1tREmvJSQtvaiDPd2NQdImCu8
	 EhN3/MNWvcf25pT0c5IJb4qPbBVVBrQ+g4ImOsnRwN5wObeK0BOLQK5q+a79pcgvlZ
	 6Obc0ULQVKw4nlLT3yQdSV4Ao5i0+s2J8/OtEazM=
Date: Fri, 14 Feb 2025 14:06:20 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mike Lothian <mike@fireburn.co.uk>
Cc: dri-devel@lists.freedesktop.org,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, wine-devel@winehq.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] ntsync: Set the permissions to be 0666
Message-ID: <2025021456-easiness-facebook-636e@gregkh>
References: <20250214122759.2629-2-mike@fireburn.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214122759.2629-2-mike@fireburn.co.uk>

On Fri, Feb 14, 2025 at 12:28:00PM +0000, Mike Lothian wrote:
> This allows ntsync to be usuable by non-root processes out of the box

Are you sure you need/want that?  If so, why?  How did existing testing
not ever catch this?

thanks,

greg k-h


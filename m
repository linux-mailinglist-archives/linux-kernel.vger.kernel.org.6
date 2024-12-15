Return-Path: <linux-kernel+bounces-446380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3959F23A3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 13:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A19B7A1124
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 12:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D1317BB32;
	Sun, 15 Dec 2024 12:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KWskE+Yj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806BC1119A;
	Sun, 15 Dec 2024 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734264875; cv=none; b=hD7KENuHQtKWa+r95DChlhD67xbUeCnb49pRUh4DwhFEUEROayHMkXvOE13Sl2uVqL4Aib+WL4F4mPsM6v6EAfuDBjJPjFxM+rmDLyBsvpXlUfPOevTTBbto4eTHPfiXz79ebhurkCxOjp7/XAR5CqZPUjZCzJPQMAHKL3E6xU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734264875; c=relaxed/simple;
	bh=cMW5VqUe9bWzsqkr7bmrkr+uYgSO+gRHzOF8JFpc6Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LA3t3f328h2ZiZZ4DTBvZoCIBXH8P5RJ+b0GKdI4hnD6gJR3tODIrEA4ShYrThXYP5Y61FPoNrURVRaW73d3Z5tyEK0kB4YpMYA+2m+6aK8Obp0IDaksX6rS1ZHHE3CDE13VzRQl6Y2FXhVqHKPzlQ6PzPQKAV9ftO6tDtAodhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KWskE+Yj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834CDC4CECE;
	Sun, 15 Dec 2024 12:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734264875;
	bh=cMW5VqUe9bWzsqkr7bmrkr+uYgSO+gRHzOF8JFpc6Oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KWskE+Yj5AMDRdbQPRDuup8/j/1bk/VF9HJRTJRqKt9iM0wL2jNX8mwflOG6sYdBH
	 OeoK+CoaBbc44UXgFZK9XibNROLgM4F9Ol7qulwcfOYF9O4j7EMgMpgWBP35N+Zhuo
	 H6/JloubI1Gicso8REWIUgTgm5jbHeORq7o5zSX0=
Date: Sun, 15 Dec 2024 13:14:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v6 0/5] rust: miscdevice: Provide sample driver using the
 new MiscDevice bindings
Message-ID: <2024121502-persevere-usual-de7c@gregkh>
References: <20241213134715.601415-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213134715.601415-1-lee@kernel.org>

On Fri, Dec 13, 2024 at 01:47:05PM +0000, Lee Jones wrote:
> This set depends on Alice's most recent MiscDevice changes:
> 
> https://lore.kernel.org/all/20241210-miscdevice-file-param-v3-0-b2a79b666dc5@google.com/
> 
> Changelog v5 -> v6:
>  - pr_info() to dev_info() conversion (based on Alice's new set)
>  - Moved the example C program from the commit message to the file comments
>  - Changed mutex-drop commentary

Much nicer, thanks!  I've applied, and Alice's changes, to my
driver-core-testing branch, let's see what 0-day has to say about
them...

greg k-h


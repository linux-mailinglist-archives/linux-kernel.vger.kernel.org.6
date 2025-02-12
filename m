Return-Path: <linux-kernel+bounces-510362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBECA31BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874D93A7CC7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA62B12F399;
	Wed, 12 Feb 2025 02:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5/sPWAB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A04827183E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739325800; cv=none; b=LqfMjxdbTpqLOj8IfBvMtjw3RF3MKLofdCRYpdcLng8WTtRrE/Vfdre4oACWkxrwZOZrktd4gxUMxxlgYy6nWqJoq76mqsjVFbrLxmqHz8/lgol9OXCeq709PjfXBge5LO/wDgAnTMJZed2ATLsk+Xaao/28yCYfDwGEMFbXQDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739325800; c=relaxed/simple;
	bh=H40AZ9St58pE3b+FYLNyeQqlvH5wg17OrK+0QrcEalg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uoVAxXH3/InwbqWZZURrD3jzNw5dA+P+9RSVHT3rMs3w0AKPh6NwpqhzPctMIZlwL8AXEgnILIgEo6By/OfEOi99L/zeJ2/gqTrRnF1CXLgXE9qvmyFhTpXmwTjJU2PjtkUVZiFwSiR78eNMRmEWpY7H378MOPHlpFZfBhKQdWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5/sPWAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F89C4CEDD;
	Wed, 12 Feb 2025 02:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739325799;
	bh=H40AZ9St58pE3b+FYLNyeQqlvH5wg17OrK+0QrcEalg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z5/sPWAByxa+E8wE8oMZN0PWZ0nUbrRA1xmZDxsua6h1yQsY8+YmMaV7/KF9DQ9G/
	 5UxIA5FfnwTgXCHsOlivfxv/K44O0oYqDwT8GYBjrpUosCybBuOTRPXqR53YXQdwRn
	 cGut28cgQXXiHtFE1CgOXfXacUVwFIesF4B3ogM5qNziHN1DoSC6HH+Fkc7bDtLIln
	 jrfpkZU3QKKs3D6i9emBA36DZoI7WVq3tHSO0MnsCbM354vIKPB7aU3dAJfuxA+UtB
	 YCJn3qvjbBxzSN/vFf41fOgrD7gmVKFN25pujh98lVYKoDuCo9CwErVgruCNmU3Tpy
	 JISu88TKtuJVw==
Date: Tue, 11 Feb 2025 18:03:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Marco Elver <elver@google.com>, Nick
 Desaulniers <ndesaulniers@google.com>, Nathan Chancellor
 <nathan@kernel.org>, Kees Cook <kees@kernel.org>, Jann Horn
 <jannh@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 27/33] iavf: Fix a locking bug in an error path
Message-ID: <20250211180318.5148d56a@kernel.org>
In-Reply-To: <20250206175114.1974171-28-bvanassche@acm.org>
References: <20250206175114.1974171-1-bvanassche@acm.org>
	<20250206175114.1974171-28-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Feb 2025 09:51:08 -0800 Bart Van Assche wrote:
> If the netdev lock has been obtained, unlock it before returning.
> This bug has been detected by the Clang thread-safety analyzer.
> 
> Cc: Jakub Kicinski <kuba@kernel.org>
> Fixes: afc664987ab3 ("eth: iavf: extend the netdev_lock usage")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Applied to net, thanks!


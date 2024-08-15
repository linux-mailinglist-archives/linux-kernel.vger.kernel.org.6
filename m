Return-Path: <linux-kernel+bounces-288700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1456E953DCB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95032B21E56
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 23:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C8C15532E;
	Thu, 15 Aug 2024 23:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KGsmILbq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADCA14D2B8
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 23:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723762909; cv=none; b=n+vI3rKMEofDtG+P5iixlAWLoFjibLZ0NquEE6EsTKmB0HatHkQWzO7e3u4qPcnVVQFbSDs67bvDkAqg8ShTr/ZCERAIAQIWPYTSpUH8Hj5+Ft6Um21YuMT+18lpIh2bLClr9KV3aQFVNyI1LsrC//VxMhNxV1AZt9Ja4irT04M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723762909; c=relaxed/simple;
	bh=6fQ70VoBaPm8Se49rH2OcnCedp5xVUREo0KNlCHP0Cg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GsXYePPvOw2bZWxUxGsJ9CvTnAx3NAoN6e5vzomyCG7WOLePa4Nf++2+0RCUwksGHFvcfh2UzC695ikX5mxr72j85G9Y/38WpN6FUds2nHdtkLEQXKDQbj07n9aSe53XkUUQtXS91+Vf89eRTV7o6YP6c2lw+XRwgNxgdsLEMIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KGsmILbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998B2C32786;
	Thu, 15 Aug 2024 23:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723762908;
	bh=6fQ70VoBaPm8Se49rH2OcnCedp5xVUREo0KNlCHP0Cg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KGsmILbq8h11rZduj0rH9BdMCpwqnTb7YUQXy+zMfQi9a3xrgQPtVEWQ9GxMlUloK
	 fo0ogFYEmaQBhUTJt9PcWPqhp14Djh9DsSdRu9AFn7YDWN7JK9afRWcvRb6rVluCMi
	 Fe2DJfPuOcJW8RO1Dw0yubUphD6emN/qIQD7yvio=
Date: Thu, 15 Aug 2024 16:01:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: kees@kernel.org, davidgow@google.com, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, erhard_f@mailbox.org
Subject: Re: [PATCH] kunit/overflow: Fix UB in overflow_allocation_test
Message-Id: <20240815160148.be83228a7804c6389393429a@linux-foundation.org>
In-Reply-To: <20240815000431.401869-1-ivan.orlov0322@gmail.com>
References: <20240815000431.401869-1-ivan.orlov0322@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 01:04:31 +0100 Ivan Orlov <ivan.orlov0322@gmail.com> wrote:

> The 'device_name' array doesn't exist out of the
> 'overflow_allocation_test' function scope. However, it is being used as
> a driver name when calling 'kunit_driver_create' from
> 'kunit_device_register'. It produces the kernel panic with KASAN
> enabled.
> 
> Since this variable is used in one place only, remove it and pass the
> device name into kunit_device_register directly as an ascii string.

Fixes: ca90800a91ba ("test_overflow: Add memory allocation overflow tests")
Cc: <stable@vger.kernel.org>

yes?


I'll grab it now, but perhaps Kees will handle this.



Return-Path: <linux-kernel+bounces-246716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7555D92C5AE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20FE11F22E91
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4D1185605;
	Tue,  9 Jul 2024 21:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xnnK1QU+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64C3154BFB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 21:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720561553; cv=none; b=Skuh5grvT8ra5lrbSg1Bhifwhb8EYacKZs14+TkV6yZAVjFGp4vh+ZEv2c2P59uXgnof4RybK+kO0zi6zoPnXsv+iOhYEri7b9xNU+iHregmycdMUgv2BnYWC1A90wDW8WJYRIcJ9w8lbYfr6fjgBEV/fGL1KO5B4qWocHAWMi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720561553; c=relaxed/simple;
	bh=Rwv+9sYnZvvn4tWXY3HImy1P8uq/C+UW7k+0mmp5pZw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mUfd7p8fPAbz8984WxKW61X9MC+Wna7e8R1dOp2YC+j1ghJVdiu0f4fe/NpwD25KDobO9Rn3C1N/gGg7KXs2Hzn9EZBP97xZBJSKAThUKW9DcOQixWMFLmpQe7Aia86hEdwrK1o2jwbJ8dRfOctB4IUdZ8zv++smml9hUwWts0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xnnK1QU+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6DBC3277B;
	Tue,  9 Jul 2024 21:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720561552;
	bh=Rwv+9sYnZvvn4tWXY3HImy1P8uq/C+UW7k+0mmp5pZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xnnK1QU+lum0U4ZNkxVWXrNfbmZYf9dR82xCC4UmsXTS23fQ6Y8tAtLiXIAcy6V0w
	 mJu9x5ufGrPbmFaTvNlwBIJyH0qYoe3WHaYprMy7wQlrhcltLD7gT9/Y4uZOnWcehU
	 EQ2ip+U+8LNB/Ne+UIhDZIh38VkxA13khbdJUf70=
Date: Tue, 9 Jul 2024 14:45:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, ssengar@microsoft.com,
 wei.liu@kernel.org
Subject: Re: [PATCH] mm/vmstat: Defer the refresh_zone_stat_thresholds after
 all CPUs bringup
Message-Id: <20240709144551.e36579b7ddd4d428661bc831@linux-foundation.org>
In-Reply-To: <20240709045750.GA32083@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1720169301-21002-1-git-send-email-ssengar@linux.microsoft.com>
	<20240705135911.4a6e38379ae95c3fc6bbe7e2@linux-foundation.org>
	<20240709045750.GA32083@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jul 2024 21:57:50 -0700 Saurabh Singh Sengar <ssengar@linux.microsoft.com> wrote:

> this data is only accessed by userspace tools, and they can
> only access it post late_initcall

OK, thanks.  We're at -rc7 now, so I'll queue this for the
post-6.11-rc1 flood.  That way it should get plenty of testing.


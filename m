Return-Path: <linux-kernel+bounces-234709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E407591C9B3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 01:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98CE52850FA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D418282D9F;
	Fri, 28 Jun 2024 23:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GGSqFKvO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE23280C04
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 23:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719619160; cv=none; b=MmBvqjpcRFONRFlNWmsV9L10Wsnbh7nOGY0v47q83opCeWCHDaRgapP90gkv/2RHEyf5t/rDoXbDP7jzPv9B4EzpF9Pt9938eFXAh36kN1ROsrLXJpXtjCVPvvq6IGAQzHKnWydP9AtfRbGloCcoAJIO1l4ZT4MboHM5MYd1CgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719619160; c=relaxed/simple;
	bh=INzl0VAMtB9S7QxnFkCqH/p4EcPJarQG0UL4FcqhOq4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UcSVaeZj+MINVTAcqNlq8LteS3EXKX/Q/iM9hMP7b0JhfqDw0uGcGL0SYQsGHR3P03FXgaeN7hkEqQEeiqozwkKT6kWSOuH9YugiO99HDYqbuI/xpBQ0KXLtzh8Wg/yuUKAJ3TW3X2fVdDqzCQ7lr8raVswDH9D3JNnQAWc10bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GGSqFKvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0B9C116B1;
	Fri, 28 Jun 2024 23:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719619159;
	bh=INzl0VAMtB9S7QxnFkCqH/p4EcPJarQG0UL4FcqhOq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GGSqFKvONULBPIcg9d7uxnX18/RdTnWWAQqVSsoj4b5pHffSZs57Dr3JaM4RePolX
	 Tv7BfovQQ0cAI5IRoZzNcHtN2Wngr6lUSt9r6ods1kfLRcdh3gqRCVpDmJLJB0iVto
	 s0ZDIxl+ee+XiqC4APqXH5uKh+xJc6qkaegV/Uo0=
Date: Fri, 28 Jun 2024 16:59:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: david@redhat.com, aarcange@redhat.com, hughd@google.com,
 shr@devkernel.io, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com
Subject: Re: [PATCH v2 0/3] mm/ksm: cmp_and_merge_page() optimizations and
 cleanup
Message-Id: <20240628165918.f9f2d7eb230cf26cd6d0c81b@linux-foundation.org>
In-Reply-To: <20240621-b4-ksm-scan-optimize-v2-0-1c328aa9e30b@linux.dev>
References: <20240621-b4-ksm-scan-optimize-v2-0-1c328aa9e30b@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jun 2024 15:54:28 +0800 Chengming Zhou <chengming.zhou@linux.dev> wrote:

> This series mainly optimizes cmp_and_merge_page() to have more efficient
> separate code flow for ksm page and non-ksm anon page.

Is anyone interested in reviewing this patchset further?


Return-Path: <linux-kernel+bounces-367955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8249A08C3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5422880EE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A481206979;
	Wed, 16 Oct 2024 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="INFcgNcc"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9873A18C33F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079603; cv=none; b=TVYgwrT0RkN8tSUh8sj8BItIlsZ9qKbTYV8h5xSc++L1LdabStCI+PdC3NIz+opJLaYjfv1KIwcskXw9aj2o5bRzeV5tuuqbZ310atf2rBlCqPUtdbg+EqOzSvD9LcZq5JFqiVubDNsM1dLrS92GnaJRR9i8L+2PsIKjs8DPDEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079603; c=relaxed/simple;
	bh=4mo1sKmQ4noUGop4J7iaD9+gu0FfKQqi5iXmOSKhHBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLjQz1QyosGtOqyzpVdF7HaIrMXrMQcpl/hx+j0eBiU9ouIb63MLGHjZUUBRAVeJMQgPCO/dZEjK6cKrGpnXF/oVo8KfMqYQljZKwH/BF/vBteaK858lhBgWF6Ao4HjwNhtioGd5/3GnsFgvvErw0E1Oc8AqzDYzNT3X9Su/TTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=INFcgNcc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=a9m5Zqs1mOasJeAtNhP9Cjg2TlyEyFiJbw32CNHTOHM=; b=INFcgNcc0oNUmqwxrq/18ISd0s
	d37DJ7PeaCYtAG0ghEpQBqB/wG2lHG6/KPXuM172k2pu9Tfu1xUMsnsv41+7hV/od+fmTd35cJ53X
	UvCedXrtIXII1oY7Ub6NqOUMfaneuy0AMU9O4YyjjyFayZwSzwLOddcHQCUH77/2V3M6frL7XprVT
	F5k6ja4775krB5D5iWJcRMUbCkkZpwjgMLzXTTndySenxOSPMbBhvA4pJVc0BH6smLmGCMTLHP9TC
	PL0JnxIpejlyVU42TXKxXynM5aCRm28Hjtc1/udf7+mXVUtpN5hgY4gaM2VB/Oh8CdO3J1qRFNzUL
	xKtD+DVQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t12aZ-00000007pPm-3HfV;
	Wed, 16 Oct 2024 11:53:15 +0000
Date: Wed, 16 Oct 2024 12:53:15 +0100
From: Matthew Wilcox <willy@infradead.org>
To: lizhe.67@bytedance.com
Cc: peterz@infradead.org, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC 2/2] khugepaged: use upgrade_read() to optimize
 collapse_huge_page
Message-ID: <Zw-pK_4wCvJHKfSi@casper.infradead.org>
References: <20241016043600.35139-1-lizhe.67@bytedance.com>
 <20241016043600.35139-3-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016043600.35139-3-lizhe.67@bytedance.com>

On Wed, Oct 16, 2024 at 12:36:00PM +0800, lizhe.67@bytedance.com wrote:
> From: Li Zhe <lizhe.67@bytedance.com>
> 
> In function collapse_huge_page(), we drop mmap read lock and get
> mmap write lock to prevent most accesses to pagetables. There is
> a small time window to allow other tasks to acquire the mmap lock.
> With the use of upgrade_read(), we don't need to check vma and pmd
> again in most cases.

This is clearly a performance optimisation.  So you must have some
numebrs that justify this, please include them.


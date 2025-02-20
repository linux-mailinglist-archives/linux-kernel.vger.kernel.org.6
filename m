Return-Path: <linux-kernel+bounces-523825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C928A3DBC5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF5D47AACFA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC2A1F9ED2;
	Thu, 20 Feb 2025 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lSGeaX1p"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F8C1F6679
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059665; cv=none; b=fztMHHIDAlp6HK+RsyavUFh5TmCgXVCiknYBe0Uu51YUKREclElODS/PVSaVlh2XtII7mmwft8S9fiFySDZ8cXIHTeCPDmh8OdaAxUWv5pCOwV9NUR8dmmbRfIbf1UI7YpLwUKP22+7wngv4Byo7PwNjb9kisjW8ovbfJs1Hlik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059665; c=relaxed/simple;
	bh=GiFVPDoaAD8120zfp9n1d6xd6OyLKR6ml2ISkTBtH2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fm/4MGCCrNmLeBAIXONTSNPI6zjbrl038Qyn6TYDKzIeZYSfXNtatODunxZHfJmy1CppG+7Bi/nQHNkqymGZj+X/mWjiiZcLbaICgh8z8+zmSasMJDXMzkvdymZ12JGEfaSQgDa/UDYtNn75VenmpcMLuj2BCEhQGk/Wf+0vTuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lSGeaX1p; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MrFuiU+UnUEZVdcjEa/1N/3aG0Qe3TuA+6xNDD8hFcw=; b=lSGeaX1pSjHoHqNtlvwG9vTEQd
	PiXngFIMxYfVvumbtViHcmqBcoBM3P0uCVwWjVM1bRN75Rkg4/u4envfYbXbRDE7hzv42pCqh030g
	Pn3Zt5aB1Yaj8aM0GKVtaExLCLDmYhLt3wD6+E9IYaVPF5+o8yYk8zse4tX2WQLa+o19UP6LYobAI
	tIEajjF4fXfImBMSzvbBqPDHq76krn4yh0jQYUtSnfiC41Js1S0Zk3qMWaTdIcPYR0Ug5PeYp/AEu
	MRWjFR9M9uAD5cKp5LiNgt4QDqsnDZiCifCzzh1tSaIa+vDMsbY9bsexr50asOEMxk1DrHlwQvfGj
	KcjxOM3w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tl70H-00000009msv-3kB8;
	Thu, 20 Feb 2025 13:54:13 +0000
Date: Thu, 20 Feb 2025 13:54:13 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hillf Danton <hdanton@sina.com>
Cc: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, conduct@kernel.org
Subject: Re: [RFC PATCH v12 00/26] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
Message-ID: <Z7c0BTteQoZKcSmJ@casper.infradead.org>
References: <20250220052027.58847-1-byungchul@sk.com>
 <20250220103223.2360-1-hdanton@sina.com>
 <20250220114920.2383-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220114920.2383-1-hdanton@sina.com>

On Thu, Feb 20, 2025 at 07:49:19PM +0800, Hillf Danton wrote:
> On Thu, 20 Feb 2025 20:09:35 +0900 Byungchul Park wrote:
> > Just in case that I don't understand what you meant and for better
> > understanding, can you provide a simple and problematic example from
> > the u-a-f?
> > 
> Tell us if it is illegal to commit rape without pregnancy in your home town?

Hillf, this is unacceptable language.  You need to apologise.


Return-Path: <linux-kernel+bounces-308993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC6B9664EE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95131F22051
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1AF1B2EF4;
	Fri, 30 Aug 2024 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZRNq1n3"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D1C61FCE
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725030252; cv=none; b=aj8dLPy/ayfi1CqE32EDXbZtPe18Batf3RhnWOG1917xG4AAaAyh7XXKaQUwzjUnC21uArfJSJsLSHrhmSeIBbacRb/8L7Jcx6b9hD40FfLNPKOMfwPNS62nm0Swb5LgvjZwczVrr2OJyHUYSWuUhBXucebZAtJd4VZWi1V9hv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725030252; c=relaxed/simple;
	bh=lh/x2McaaALFfUgpVmAGYKNv4IHn41KY+7j/fAIATi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdQlW3jWGdqXi3ek5dW7GAHNnBb0Qi6oxyjeBHXIafQGWN4q2Y8hGEbteE3IjXoMotweEHLAeLhpa8XPi+DH2+s6zopRfgVVWdU3J65v8P7+FmBij0Yvkbc42y6n56NcOYE5aQ5jRlo1kklwstE+Pq5fLXa0dAw7SK7FXUXWZjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZRNq1n3; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-371893dd249so1406280f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725030248; x=1725635048; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5+y3zV4EDrHM8E/Avurk5GQvKXIz1DQBJgb/vXY4IU8=;
        b=AZRNq1n34whritUCqqbbA2B/S2QcheeMAEyjxz+PgiojpAcg6v8mnJbLeFTi5CVNum
         3YJ9irUgaDWlcW5gGlQSjx6yjgsS5uAy61udiVguXgDes0C90Ebfj/kCJgqNeurBwbgf
         N8eFoV7WN+R5JnPRdavCRx4OvHTgExFqkeYhUKBI0IJJRH8sXJ4K/PH/BH8TCt57yENJ
         Z3AN0pntQaJMkEYVqEzndg0P0DuBkuRPylhnMbPCgBv4gpYkOy8AqJ3ke+oOyOMtXiv8
         xkM0Cr2HX5whPR2JEqbIYH9j5xrg7uDcLWyPC7rGgZ2xNqGonALH6Vgdqbqa3DLiba1Z
         Qdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725030248; x=1725635048;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+y3zV4EDrHM8E/Avurk5GQvKXIz1DQBJgb/vXY4IU8=;
        b=lNZaLyhRBeTgogmHNJOUReQgRSpBgLctd5DXgNsQrRkbcHNQV9DIHazfGIqyS53sIo
         gUamzHGukL8uVVT5tfggCdaoaSBE7jyJR7lGnbV7CkNFrJiNYSrzEdD1Vzf7P+c+jraH
         2HXCcdySrTSzL06YzdyDiaoeFB25qxXQHqw4KV9guqTdMCJsUQUmCD5YghzQ2GVfaAg7
         tqEK0FDk92d7+oe0aOrXRRuDP5mUBE+xR9H6KJGvVuZWWJv+ps9Kzhj6rL+65MWepJQJ
         VYsOf5WJB3mvqFHcrNWp3kh2oevoSnRAKqqspnN0e+aIpzQH66m2qlZ5q8qvuzZEQWUg
         FVQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF2OzYTKg+pLs3Kghuf026RJTvQp220D8HkB9V/3I/58nTrz1HUHmnjf67Bq/Z9GBMYy2gUYx+R0oEqEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXuXU3U2QwSbH2ZTxQ84LsW7mw8B6zV36FzKOPMH7CeS/sYgFW
	JpV5ZosTyAG+MDAXCbwlA9todxhI6RoC/+som+H3bP3umbmcHkuoDMew6w==
X-Google-Smtp-Source: AGHT+IHmnfdQQ1hfPAXxYQUJZKzBNqemK3VME7LWK8oD3vyz5RbznDMrdodK4EXTUEkVgqcIn3QkAQ==
X-Received: by 2002:a05:6000:1811:b0:367:8876:68e6 with SMTP id ffacd0b85a97d-3749b582257mr4258615f8f.48.1725030247744;
        Fri, 30 Aug 2024 08:04:07 -0700 (PDT)
Received: from PC-PEDRO-ARCH ([2001:8a0:7862:ea00:1d36:5f53:3f57:14ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749efb1682sm4227265f8f.101.2024.08.30.08.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 08:04:07 -0700 (PDT)
Date: Fri, 30 Aug 2024 16:04:05 +0100
From: Pedro Falcato <pedro.falcato@gmail.com>
To: Petr =?utf-8?B?xaBwYcSNZWs=?= <pspacek@isc.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>, 
	Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [PATCH RFC] mm: mmap: Change DEFAULT_MAX_MAP_COUNT to INT_MAX
Message-ID: <mftebk5inxamd52k46frhq2llopoiiewsgdkrjbamg4yukyhqw@vf4jzz6lmgcu>
References: <20240830095636.572947-1-pspacek@isc.org>
 <90f07fec-3f46-4b38-86fd-07c9f8201904@lucifer.local>
 <82960a7e-9013-475e-9b80-7b29a5667482@lucifer.local>
 <5dca8600-0352-4b5b-acb0-0cd4f84733f4@isc.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dca8600-0352-4b5b-acb0-0cd4f84733f4@isc.org>

On Fri, Aug 30, 2024 at 04:28:33PM GMT, Petr Špaček wrote:
> Now I understand your concern. From the docs and code comments I've seen it
> was not clear that the limit serves _another_ purpose than mere
> compatibility shim for old ELF tools.
> 
> > It is a NACK, but it's a NACK because of the limit being so high.
> > 
> > With steam I believe it is a product of how it performs allocations, and
> > unfortunately this causes it to allocate quite a bit more than you would
> > expect.
> 
> FTR select non-game applications:
> 
> ElasticSearch and OpenSearch insist on at least 262144.
> DNS server BIND 9.18.28 linked to jemalloc 5.2.1 was observed with usage
> around 700000.
> OpenJDK GC sometimes weeps about values < 737280.
> SAP docs I was able to access use 1000000.
> MariaDB is being tested by their QA with 1048576.
> Fedora, Ubuntu, NixOS, and Arch distros went with value 1048576.
> 
> Is it worth sending a patch with the default raised to 1048576?
> 
> 
> > With jemalloc() that seems strange, perhaps buggy behaviour?
> 
> Good question. In case of BIND DNS server, jemalloc handles mmap() and we
> keep statistics about bytes requested from malloc().
> 
> When we hit max_map_count limit the
> (sum of not-yet-freed malloc(size)) / (vm.max_map_count)
> gives average size of mmaped block ~ 100 k.
> 
> Is 100 k way too low / does it indicate a bug? It does not seem terrible to
> me - the application is handling ~ 100-1500 B packets at rate somewhere
> between 10-200 k packets per second so it's expected it does lots of small
> short lived allocations.
> 
> A complicating factor is that the process itself does not see the current
> counter value (unless BPF is involved) so it's hard to monitor this until
> the limit is hit.

Can you get us a dump of the /proc/<pid>/maps? It'd be interesting to see how
exactly you're hitting this.

-- 
Pedro


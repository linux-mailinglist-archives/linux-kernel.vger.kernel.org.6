Return-Path: <linux-kernel+bounces-548030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED367A53F02
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BF216AF9F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0664F182D9;
	Thu,  6 Mar 2025 00:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DkcyjH8r"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4124817BBF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 00:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741220238; cv=none; b=Je8xxur78ML9XM94q0LCFlYQf+in5kgYihYkD1bSRwE+CzudnXseDOmXE8CrbgC/h0UcV1e6M/lO4d8eLyaJ8eiT5Nr9Q4jUTLE1c8eV/14gMLYxHJX7DEKbQn2OqsM1aukMsW77D0W4xrBbcXzOae1e01hWLKzhZNJutTYnf4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741220238; c=relaxed/simple;
	bh=1dNtZaEYUyH64OUSZUsw1j2xaeCmpy5A3lwjyzDC/OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCLxT788xPxAGBEKZDOgbQjy7FEhLhSxKE/k1mkKO9WcJO7y6uQFXyFHmlWLrhDKsouLe/462fFlg6uuYNzmQcLku9zVufWMmPWrEmKIAoyLRo4/fXU86eJtD7627RYxFNhDMUlzBdG98kWW1RtaLBqumevzwhL3vZ5v0Tb+Kqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DkcyjH8r; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=857RdM7BMKFORUyrg9uvSh9wnPEcLd9pbt0BXYPpoJ0=; b=DkcyjH8r34+s2URZVZ7lKtQpyd
	7U2QPjoMxMURNZzfBbuF8cQOwLTYt30gHhzDzyf/s+XMVXQcwhCoQSyecb/7quHOFgKgl8EwyJWeZ
	1FNzXPSnYhBxP6lh7SqN3m8SoC/orYp5BZR0Wpr9WLoVwcqwyhFtnPizHXT4qSeLSXdW1MCKsBqMr
	R5pzZI+qxtMahUNMFJDs4B5G5G3PJA+eJ4tJW3KD5qNgY5b+CTFb0BIQWQDmpV5IX6L3RAAUL3kHt
	pX7SukDNzdqPFioslkVPCim/TbRWmSHAgc4iUQqi1Fq4Yj3DcDTAg1SAk4PMOeDQ5q/kz3i2dfNPS
	Dg/ZxBtw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpyvL-00000009ge6-2xXw;
	Thu, 06 Mar 2025 00:17:15 +0000
Date: Wed, 5 Mar 2025 16:17:15 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Kit Chow <kchow@maxlinear.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: pci_p2pdma_add_resource of bar memory rejected by memory hotplug
 as out of range
Message-ID: <Z8jpi5nf63APb8aN@infradead.org>
References: <SJ2PR19MB8094482894628FF87E806CC8A4CB2@SJ2PR19MB8094.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ2PR19MB8094482894628FF87E806CC8A4CB2@SJ2PR19MB8094.namprd19.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The kernel detects your company violating the kernel licensing and to
go away.  This is only half kidding, but the kernel mailing list is
not a place to ask question when your company treats kernel licensing
like this.  You're on your own.


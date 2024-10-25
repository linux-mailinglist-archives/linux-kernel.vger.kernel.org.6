Return-Path: <linux-kernel+bounces-382537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBCF9B0F84
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E1228435E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BEE20EA2C;
	Fri, 25 Oct 2024 20:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="Wd+W+y+Y"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F9F1FB8B4
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 20:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729886778; cv=none; b=YRk0SboiHHlItXUkbG3u7x15o/QxMZdv1uO90suhpg4zX/7VwJ7nd3qr82EeJqE2kp5OrUF97zMsXCgnXw4v9KAhr5twtChfgkr9Yhvp+FZfQr/SdgCuBF13+XdazI2NQVcVI6FEnn9uOz+L3+bPs3PvmIE6s9v3cj+Rbwjn6G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729886778; c=relaxed/simple;
	bh=MbOsSiYy2eWKuYLaJG5kw2j+qSQkdJD10nKxLlbLC5E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YaN/lgy/kfoeGqQNPCjhGpa8kHQcHP7k/xrerWrKk5vHtxiFgzlHBLzbuR3/1fi93RY+IiDCyx1EEgZbZOzPSFc4/wKwqh+3QHoPJam8Z+qWHB8WrFHhVxt/n9WtCx72F+ti96xo2rdLUSufvqBzkDi/SAcW+FDv7y+O4FXwS7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=Wd+W+y+Y; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1729886092;
	bh=MbOsSiYy2eWKuYLaJG5kw2j+qSQkdJD10nKxLlbLC5E=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Wd+W+y+YznJZDDDtsBddhLoMqTvZwvEUN4E4WwbHA9qWJ9+xsxddo6Xbfm7XP4Zfj
	 IuPEX2JJzFN6+4m0VZGSOt4gICUISSEsNCXYMxeC7yeI0moho52dpZhJzkxz9kPCTk
	 QK6rPAvasgT7hMtrR8l8+EaMgEeKU3wsdrDpVkoc=
Received: by gentwo.org (Postfix, from userid 1003)
	id B3F43409D1; Fri, 25 Oct 2024 12:54:52 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id B318840681;
	Fri, 25 Oct 2024 12:54:52 -0700 (PDT)
Date: Fri, 25 Oct 2024 12:54:52 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Peter Zijlstra <peterz@infradead.org>
cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
    mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net, 
    andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>, 
    urezki@gmail.com, Christoph Hellwig <hch@infradead.org>, 
    lstoakes@gmail.com, Arnd Bergmann <arnd@arndb.de>, malteskarupke@web.de, 
    llong@redhat.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/6] mm: Add vmalloc_huge_node()
In-Reply-To: <20241025093944.372391936@infradead.org>
Message-ID: <60081db7-91ba-6139-aede-aeae8e31f850@gentwo.org>
References: <20241025090347.244183920@infradead.org> <20241025093944.372391936@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 25 Oct 2024, Peter Zijlstra wrote:

> To enable node specific hash-tables.

Reviewed-by: Christoph Lameter <cl@linux.com>



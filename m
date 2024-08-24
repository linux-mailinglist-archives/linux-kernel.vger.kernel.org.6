Return-Path: <linux-kernel+bounces-299838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3296795DAA8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 04:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E375028459B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 02:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55ED62AF12;
	Sat, 24 Aug 2024 02:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="IGR28dm2"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B4A2AE68
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 02:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724466568; cv=none; b=BUUW3kQ32JhTV8FSz4hHKG+SgMRbuPu/lsnAaHJYhlidLGhBNrjxHFDJBl/6hkQ19L0/dgPXf9q6zwsYVOOUMLjzB4kt7B8xR2bFHA/hzn8X5B8yXHrcBgpYfWCteL6JfTkuosZEQdkyZwY+63RU7BBxolxDh6Kj9ips1QSfxdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724466568; c=relaxed/simple;
	bh=ZdptpvZunaw0PLSDFJJ841ADB7LgdVYYNI/QYfzS23o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PGsz/QpMMdnN2vysqMnKllZmTHk9RtJkQo1coSJlsaf5dhitYRIfqaTtVHcDUlaUxkg33wfBO+P/C8CawHMuJmFufEK6H0QaPoZBDeiOIqWazmBTITOhwQc+UrooSf+GYQ7kd5/ZKAiw7IHr80DYHsBqJMCKBQ7/3BmRau5TGQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=IGR28dm2; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1724464663;
	bh=ZdptpvZunaw0PLSDFJJ841ADB7LgdVYYNI/QYfzS23o=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=IGR28dm2CK4RA6XwL4MgMGSZTe1cEs1GDTn8cgKqaxGGZ+SpUE0S9afg+1TDwgzrG
	 23mm7f4ggwaNLAoKKl0uA3F3c6DbPOYBhHTgDS/rtPHt47p3f+WCqavMT5Q9I2Po2s
	 P52vHjW1YahXrTaGGRnifE5bDWYlXMQOLTlYesKQ=
Received: by gentwo.org (Postfix, from userid 1003)
	id 7812240355; Fri, 23 Aug 2024 18:57:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 76A234022C;
	Fri, 23 Aug 2024 18:57:43 -0700 (PDT)
Date: Fri, 23 Aug 2024 18:57:43 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
cc: punit.agrawal@bytedance.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
    aou@eecs.berkeley.edu, dennis@kernel.org, tj@kernel.org, 
    samitolvanen@google.com, guoren@kernel.org, debug@rivosinc.com, 
    charlie@rivosinc.com, cleger@rivosinc.com, puranjay@kernel.org, 
    antonb@tenstorrent.com, namcaov@gmail.com, andy.chiu@sifive.com, 
    ajones@ventanamicro.com, samuel.holland@sifive.com, haxel@fzi.de, 
    yang.zhang@hexintek.com, conor.dooley@microchip.com, evan@rivosinc.com, 
    yang.lee@linux.alibaba.com, tglx@linutronix.de, haibo1.xu@intel.com, 
    linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: Re: [PATCH RFC] riscv: use gp to save percpu offset
In-Reply-To: <20240824004920.35877-1-cuiyunhui@bytedance.com>
Message-ID: <e06a3bd9-6378-2d4b-b06d-cc2d58776eca@gentwo.org>
References: <20240824004920.35877-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 24 Aug 2024, Yunhui Cui wrote:

> Compared to directly fetching the per-CPU offset from memory (or cache),
> using the global pointer (gp) to store the per-CPU offset can save one
> memory access.

Yes! That is a step in the right direction.

Is there something like gp relative addressing so that we can do loads
and stores relative to gp as well?

Are there atomics that can do read modify write relative to GP? That would
get  you to comparable per cpu efficiency to x86. x86 can do relative
addressing and RMV in one instruction which allows one to drop the preempt
enable/disable since one instruction cannot be interrupted.


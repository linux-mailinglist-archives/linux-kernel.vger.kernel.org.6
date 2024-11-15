Return-Path: <linux-kernel+bounces-410552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3F79CDD2D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C8C5B27F84
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A801A9B43;
	Fri, 15 Nov 2024 11:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K771JKmu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AD7154C00
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731668469; cv=none; b=NCL8wKJDTjWn7QUdpgwvpME0Erh9fos9dWmqd9l2qz8hGIJ8gX31IZr7BrWR9z/D/pFxUuy81ii5MMiS+aPqFR38Z/7UNjOcavGnAPgc+N2A60G5XjS7iUa3ZSaMxoC7NXQ3LvVb+DaLu6wm4IPL7etv1aQvhOpJjI9moXaNTkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731668469; c=relaxed/simple;
	bh=nl63oeeKgFgZWDzlfNV7petR5YratFleF7vbHWBYqEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uimDFIb54IqdM4FQhPK6zvlzECbecljgOHIS7rty2Zq77u65vVEOEpGIUlfCc44WJcWqYB/WgYGsqQv6xAsqa6Wqg+08RfNkBmIQgLa8kzPTzNjWK3b/upg426BZhWIcMEHkgbV/y4OwJLzCwpWwYR2bzI4eoZZZpcP8BGw8v/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K771JKmu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AACAC4CECF;
	Fri, 15 Nov 2024 11:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731668469;
	bh=nl63oeeKgFgZWDzlfNV7petR5YratFleF7vbHWBYqEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K771JKmur8mNdBLkvEDVbbSGEM66u+7NYPt+AuoIcoX6RR/vmt1po8k+lIgUO4fSw
	 J+fZ8wR/IcsIeMWBPNYmdahQDDOsW4+hwgjRXwK6PSaFRykQ7GqfhNvowOPQPNoMW+
	 gNQvZs5cTV/mUUUt537qV94bxC2ntp1IvMT1ngB9+a790znTWobPdsTeZ4fCZrvow7
	 KvZEg9yj0NFt3+w6Va+rPMFsgZG+5Bmwr8UoXWi2361feagcvUjxo52Hy+XdjscUzh
	 4MnI9+ZhmtR77f/USCIVxfJFJ5HHCbXhC0GbrSg4HqUqQbfdta+PKVJUiqcpPHvrZ+
	 GlTqDzp9JhLhA==
Date: Fri, 15 Nov 2024 12:01:03 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ragavendra <ragavendra.bn@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, thomas.lendacky@amd.com,
	ardb@kernel.org, ashish.kalra@amd.com, tzimmermann@suse.de,
	bhelgaas@google.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch:x86:coco:sev: Initialize ctxt variable
Message-ID: <Zzcp75p3KTFRfW5O@gmail.com>
References: <20241115003505.9492-2-ragavendra.bn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115003505.9492-2-ragavendra.bn@gmail.com>


* Ragavendra <ragavendra.bn@gmail.com> wrote:

> Updating the ctxt value to NULL in the svsm_perform_ghcb_protocol as
> it was not initialized.
> 
> Fixes: 2e1b3cc9d7f7 (grafted) Merge tag 'arm-fixes-6.12-2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc

This 'Fixes' tag looks bogus.

Thanks,

	Ingo


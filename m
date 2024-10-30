Return-Path: <linux-kernel+bounces-387956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3AD9B5866
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14D37B21681
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0F74C8E;
	Wed, 30 Oct 2024 00:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f7NKJC/N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F03440C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 00:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730247278; cv=none; b=Kzs73dRSWTnkws+2Vwy3M6klkynxzFdwBGdbSB79H35DImnq0vX7Xi2UwpzOT6A/H4Y57F0KGySxlMuRe+3EfYZEEa7PdUIeUV4j+9ISfdFtKL+qPS3oCUk/jxenb6rsUgafTkS54SFJT9PUrMkJ605uEGP3a+P7kxOpnsvskKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730247278; c=relaxed/simple;
	bh=vu2etmpFYYgitN/04P9hwKI2HiYdQTVxczs/MzMmepI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+1BiLlqPyjLY9KkM+SNTfwZQ/Cf5GCjArcY3aViSDDxJv19Fo5MFtFwG9KnDmOFv/T4rSSeesJMsUyuRJSN72pWStKevU6cKJBi8h0r6xUMOtcUJ9iDdHhI6J8HA23D8R1PPTBs8DmNCL5RuW7I4se0IJ9VKOk1KcGIYyjbe6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f7NKJC/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52337C4CECD;
	Wed, 30 Oct 2024 00:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730247277;
	bh=vu2etmpFYYgitN/04P9hwKI2HiYdQTVxczs/MzMmepI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f7NKJC/NBtWbVq83DkmUw3cfztmRR+pTd61b5RuOaW/5GrVnZLPAwneiiBiuZi1eO
	 Q3ejIcj594xfmKH8V1+DQaCWU+HIZaISiZC9biVkfDXgapuK5Zl00EfX8sjCsgwUMi
	 6jIHGw15lGBOvazM6cy3ur0mH8D10kVF/8cx4GLg=
Date: Wed, 30 Oct 2024 01:14:24 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dionna Glaze <dionnaglaze@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Danilo Krummrich <dakr@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Tianfei zhang <tianfei.zhang@intel.com>,
	Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH 2/4] firmware_loader: Move module refcounts to allow
 unloading
Message-ID: <2024103012-precise-utmost-f423@gregkh>
References: <20241029183907.3536683-1-dionnaglaze@google.com>
 <20241029183907.3536683-3-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029183907.3536683-3-dionnaglaze@google.com>

On Tue, Oct 29, 2024 at 06:39:02PM +0000, Dionna Glaze wrote:
> If a kernel module registers a firmware upload API ops set, then it's
> unable to be moved due to effectively a cyclic reference that the module
> depends on the upload which depends on the module.
> 
> Instead, only require the try_module_get when an upload is requested to
> disallow unloading a module only while the upload is in progress.
> 
> Fixes: 97730bbb242cd ("firmware_loader: Add firmware-upload support")
> 
> CC: Luis Chamberlain <mcgrof@kernel.org>
> CC: Russ Weight <russ.weight@linux.dev>
> CC: Danilo Krummrich <dakr@redhat.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: "Rafael J. Wysocki" <rafael@kernel.org>
> CC: Tianfei zhang <tianfei.zhang@intel.com>
> 
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
> Change-Id: Ifac9513de2f58a5120d4c0a681e969cd71cd3c68

Please always run checkpatch on a change before sending it out :(


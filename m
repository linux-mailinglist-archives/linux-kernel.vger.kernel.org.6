Return-Path: <linux-kernel+bounces-411057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD179CF254
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5765283853
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622A31D47C0;
	Fri, 15 Nov 2024 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fmXKYvTa"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24181163
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731690292; cv=none; b=O9/v2q1d13z8BrtOUTh5WRFrEShd/nUU+M7nZ0ncfDZCbV7hXp+qHfLf7D4J9ME1x0zBJBD+1K8MqC+qfuN3pZjFePVTPFjvdCpruKrp/avA7OYerj7pboVw02yX19GHJEaz7E3tGrfg17loQqi94/GTcGFyJbW+OK6L173U5jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731690292; c=relaxed/simple;
	bh=h9IOYnlDPDXX7q2X4pLGws5VJDbx+DSMwS7DmUunXbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rODmmRBhSpTNFxuwnmyrwPLherYlIghSxDYI4SrxTzh5BPWL5FPWF8GbrOENSlZRHPmLNawrirgfXHsK0WjCo21qgomf/j+JozX6Id2hmbnWsvUH1Af3H38ttbOSe4ms4bXpce1Shlya2ucmBFBpgEubR7tp/Jop6UFmzSXM54c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fmXKYvTa; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=daWOt+QRGGVwS5QkFZ/T1q1gY0282sg7nLJ38V5gr2U=; b=fmXKYvTaVlfSPUdi1cMGm1nu17
	ajwdDoJ2IRnuN7YsPAdWbxgDW8HKq3FkbHIhfbF0Rzl6piHccjRWhpfCFEIeoh+2u80+cPjgJD31N
	UTMqe/piD45MQ2fCAzwbgz5o/e/CDIeZCPM5tHsdaxKq+xOlru4E8kwr2i+UwRwTZ75SqCns82oxR
	j17fyAubHZQTzC1jw6gUZ8U5J5FfFBP29bUze5JSNIext13TX9LeeljfS0msX7BsZ+ID6WWz1cuBc
	3hVEn47xwynnxZwxJ5gL/klikemaBBSQHZNLmaOczKboQHvdr/CxuSbnMG3s8Zcj584kSmv3QWG1O
	D6adVfog==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tBzkV-0000000FVee-0j0d;
	Fri, 15 Nov 2024 17:04:47 +0000
Date: Fri, 15 Nov 2024 17:04:47 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Nir Lichtman <nir@lichtman.org>
Cc: brauner@kernel.org, jack@suse.cz, ebiederm@xmission.com,
	kees@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: refactor an invalid executable check to use isprint
Message-ID: <20241115170447.GX3387508@ZenIV>
References: <20241115165351.GA209124@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115165351.GA209124@lichtman.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Nov 15, 2024 at 04:53:51PM +0000, Nir Lichtman wrote:
> Remove private printable macro that is defined in exec.c and migrate to
> using the public isprint macro instead


> -#define printable(c) (((c)=='\t') || ((c)=='\n') || (0x20<=(c) && (c)<=0x7e))

> -		if (printable(bprm->buf[0]) && printable(bprm->buf[1]) &&
> -		    printable(bprm->buf[2]) && printable(bprm->buf[3]))
> +		if (isprint(bprm->buf[0]) && isprint(bprm->buf[1]) &&
> +		    isprint(bprm->buf[2]) && isprint(bprm->buf[3]))

RTFM(isprint).  Or run a trivial loop and check what it does, for that
matter.

isprint('\t') is false.  So's isprint('\n').


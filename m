Return-Path: <linux-kernel+bounces-312755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98371969AD2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54A50285B52
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546B41C62D6;
	Tue,  3 Sep 2024 10:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dGYO5om4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68B91B9851
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 10:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360727; cv=none; b=Ea+N7ceXaHy51V5pIPKUgQSrtyJadvf112yu7zEs61hBr43hpvOiwsNPPdNTGLLwKd2IHdeo+DSD5d5pcgVgcoDmys+JikDiknJXwMZRLDB0WcyW7KlkgyNKfjGWdV1SvCAxRWZWICYMtwCyXOpOjqz2HFnqjf233rvDXQGnAS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360727; c=relaxed/simple;
	bh=JRP4K78B43knTz3tmcyCU7/JqkLEGmeMHfo3yYp2mlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJf1ejAbLN/1pWTahCLdydiwtmM4BOP76+c4YzgvsK3z2Lc/Huvf+L3ogG9SlMloAQhiP3G6/nC5s6vSPHEPiU0TdlXT2kXoGAm3MPDQ6MH18q9clq6coBtRYtqMJ+bDItsEpFT1haqy6V24FD0IDanBK2aUhOiiCaywhr1tgYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dGYO5om4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B0EC4CEC4;
	Tue,  3 Sep 2024 10:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725360727;
	bh=JRP4K78B43knTz3tmcyCU7/JqkLEGmeMHfo3yYp2mlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dGYO5om40kfUrousS9gvLea/U2q1fJ9uOiaByZIHwPsa9yLopoA1d1Iv7lMvEmfCL
	 TL45mnqptzLxdctT9ybfTDqbA6MgfRDZU9Cm8/1A4Z/qNef24Oe71kVe2zvXmHU4zS
	 3fKG58NR84BJh/dcLQzZq2II0eB9I6FjRSRf26r4=
Date: Tue, 3 Sep 2024 12:52:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] nvmem: fixes for 6.11
Message-ID: <2024090357-cardiac-foil-6476@gregkh>
References: <20240902142510.71096-1-srinivas.kandagatla@linaro.org>
 <2024090351-monument-hydrogen-f495@gregkh>
 <a326aa34-a683-4efd-af7a-f2f264c7fc4b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a326aa34-a683-4efd-af7a-f2f264c7fc4b@linaro.org>

On Tue, Sep 03, 2024 at 11:45:59AM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 03/09/2024 11:20, Greg KH wrote:
> > On Mon, Sep 02, 2024 at 03:25:07PM +0100, srinivas.kandagatla@linaro.org wrote:
> > > From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > 
> > > Hi Greg,
> > > 
> > > Here are few fixes in nvmem for 6.11, Could you queue
> > > these for next possible rc.
> > 
> > You forgot to cc: stable on all of these :(
> > 
> Sorry Greg, Should I resend them with CC Stable?

I fixed them up by hand.


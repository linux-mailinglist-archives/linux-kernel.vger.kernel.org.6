Return-Path: <linux-kernel+bounces-214696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FE29088BE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2BCF28FEAD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3101946B8;
	Fri, 14 Jun 2024 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZHRpD0X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1946192B87
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358583; cv=none; b=i87JDGu7rP7CieRxrXyxZ/obtCsJxE8RI0E9JEJplbJBURHmqZI5HWDya6iBrWV8Uudu+m5ZI6iO5+8vE/YFfgmyvnC+PghVAbyNWKrkpn96ScBy48SFHIjmHe1Nwo6KfdBJYYFo3SvudoJiZ/Ds0bJZTtrHIMcsZMgsV8ITWwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358583; c=relaxed/simple;
	bh=w7BADFVteaBVpnCvZDp6QW84IGeZN9s0GDOlESO+Vx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrGtI89sGGF64yN1G8jhdCSQNOcs3FmDQwd/AP7hSf5xh9r2/v6uDuSceCUbM2tzBSwKQHj9zgtRy24Puz5aREgY7dJ7Ynktl8q9qrEDlbrSeaZ81U/CpltV38S2c24sHxvK/oLK+eWLiCBPylZxebvj42WtS3AEPMESSpl+BpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZHRpD0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D264C2BD10;
	Fri, 14 Jun 2024 09:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718358583;
	bh=w7BADFVteaBVpnCvZDp6QW84IGeZN9s0GDOlESO+Vx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iZHRpD0X/ZkGyCeQDjVS4RGgjqDXsOPTcWWvbGQRMLRHXJ8V87zm3XChHjyY50O74
	 oTTiuDzViXS1Wa50mIXFd+6wbVwDHzfnhcF0vey5QM003aa7mpVcCImMYUXypo4BF0
	 oRHOFhdnZiDDr2wNssRlUB1s02OF9pFwKyA/6wOKsbhAFMqpjPmVm4iTfqYccSivjN
	 B/csQQ0e186zAIIM2aoYIH27ugtUn6LL6r/jL1eLgu8VuT4RfANaAZPm1PitVr5hJh
	 KgTCFExEhZRxQ/oelaeFcs9F9tzcg2VUQbn6S3KzvZRJPRGD2vynqinaz8eNkq1jr0
	 fpAEtiLS4PmGQ==
Date: Fri, 14 Jun 2024 10:49:39 +0100
From: Lee Jones <lee@kernel.org>
To: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	linux-kernel@vger.kernel.org,
	Gregor Herburger <gregor.herburger@tq-group.com>,
	linux@ew.tq-group.com
Subject: Re: Re: [PATCH 4/4] mfd: tqmx86: add I2C IRQ support
Message-ID: <20240614094939.GG3029315@google.com>
References: <cover.1717499766.git.matthias.schiffer@ew.tq-group.com>
 <18d0348f2f7b70329e44f7759bad7e6fe231dba0.1717499766.git.matthias.schiffer@ew.tq-group.com>
 <20240613154234.GJ2561462@google.com>
 <ZmwQkHvCdB3rPGEw@herburgerg-w2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmwQkHvCdB3rPGEw@herburgerg-w2>

Note: Careful not to cut away too much context when replying.

On Fri, 14 Jun 2024, Gregor Herburger wrote:

> On Thu, Jun 13, 2024 at 04:42:34PM +0100, Lee Jones wrote:
> > Just one question; what is (7, 9, 12)?
> > 
> > And why is it the same as the GPIO one?  Copy/paste error?
> > 
> Those are the IRQ numbers of the PLD. Both blocks, GPIO and I2C, can be
> configured to use IRQ12, IRQ9 or IRQ7.

Might I suggest we make that super clear in the help?

(IRQ7, IRQ9 {and,or} IRQ12)

Or similar.

-- 
Lee Jones [李琼斯]


Return-Path: <linux-kernel+bounces-335514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6612C97E6C5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27960281A25
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 07:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8988482D8;
	Mon, 23 Sep 2024 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIHBAlme"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE4A3C485
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727077415; cv=none; b=g1ljCrQ77LMhTtQhj/SAJU9scJ1WITUOw3N3zgGmxx4xQyfEqFQjrhaqLgRJoUrrm5A5ePCxOrO+hjK52UAnaHbteIHqk2TA0UTwP2I2xyMFIKExwcLZccfin71AQDJtZ7AnED3idtU4UIdWHZwFT36Hui8U4kAQaRSaq+FE4+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727077415; c=relaxed/simple;
	bh=5Agj6cLd65Qf0AqMyAUd7lcCbRBnXVc6YrHae7VLBZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/Kj2CVx61vbrN9SuhdCX1SFIEGYHLuuhVWTqHmF1VReJpeJ3nAhqucsEw5Wtz4eosKyC66vbK2pWKq1I6wAq/aCkRw49cSggP+5ZYwUbh8Dc1CmGWxic/DahIxHrlBJycz0A5Ng9j5kjYYg2+3PfvgilyBDjMUEIBcfbcJhXQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIHBAlme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC72C4CEC4;
	Mon, 23 Sep 2024 07:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727077414;
	bh=5Agj6cLd65Qf0AqMyAUd7lcCbRBnXVc6YrHae7VLBZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OIHBAlmeU0TujBRyqOQFJSoWFQK4xaGqo+yIwvzcHpvNAxJJSkypk1ClL18nmBEdB
	 SmOOS0yPXlo956+ZR7td4I8yEyv39pCC6rcJZOyQR7BKTLOBCfbXH2SUOV4D+5EA35
	 j1DIXnJH8drRIZ0RaUa8ffqLuIRxacH2xuFlc+VHZ8PQjzISD8jSoZeaycEPdyBUgb
	 cHYyxEBa1mJfJs+boALgnEXa/3hHXP4VbDs9lAaXbE0f+1AFXbSQxmO+eAXiveAJIK
	 28UyldB+f8zMLEWEhxp/3tMBLpmuooUVeRreY3K6ZQi4aZ+15il4g0nRAo8/P8qqAC
	 gQCTTe82leTjw==
Date: Mon, 23 Sep 2024 00:43:33 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Wu Bo <bo.wu@vivo.com>
Cc: linux-kernel@vger.kernel.org, Wu Bo <wubo.oduw@gmail.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: do not set STATX_DIOALIGN if dio is not
 supported
Message-ID: <20240923074333.GA8390@sol.localdomain>
References: <20240923063732.2730521-1-bo.wu@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923063732.2730521-1-bo.wu@vivo.com>

On Mon, Sep 23, 2024 at 12:37:32AM -0600, Wu Bo via Linux-f2fs-devel wrote:
> Therefore, if the filesystem does not support DIO, it should not set
> the STATX_DIOALIGN flag.

No, that's incorrect.  STATX_DIOALIGN supports reporting that DIO is
unsupported, via the alignments being 0.  See the statx man page.

- Eric


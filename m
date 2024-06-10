Return-Path: <linux-kernel+bounces-208768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F03CC9028EF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80167282063
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF4314BF8D;
	Mon, 10 Jun 2024 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Mjg4cLt4"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEBB85624;
	Mon, 10 Jun 2024 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718046022; cv=none; b=PG92zCvsEnLFWnLxbifw/GT9gcXVBz1ruFqAtIkgTmOw6lQ7j/ZMkU0HgAApJcupddl0CCTzWV6u1YQ9ZBhDRB9R4irMZ4tsfxSdt6hAGcUXfHCcKn2KKoxbi74u3Jx3Uq6Ja54nchHfpuffW5/il0HY3OjKIROQ78KSI5z5Ddk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718046022; c=relaxed/simple;
	bh=zQdAR726SigiPg0uoMk/TRGQ286XVIrRJskpP1SekGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZoCRjab5CXKp5QCDQIehsJm4xGZ+9tNZzB/xze9WCm1zm3HmKTVSUbnPIiH90P7S2MgsJZr1R+GK1Hyn8KRqlR19R1doiHbL0oGznw7F3tGKzS54dU9YwoUCuU3a/wS2jdAV2GXNWSGKQVPJKIZYnhHtDVJORUryZR47vnFYuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Mjg4cLt4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=B1/JzaQ8pp0yagGM0HegHxqBSzMESLnc9dKVFsKzvqc=; b=Mjg4cLt4JjZb6kMb4kUKfNInpJ
	hNfHM4coruC+nmHcahJFS1Q3SVHCw3yfLnoiycqFgOWbJrdCcYsCrIC720ac/jQv93ofOPMO4iyqD
	B5QlPmZ6fl7ZkPA3yyt+WSt4vJcrJqcfX616M9ZYGTMmcXMPcTkXhu/vp9BqfUeTYedE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sGkFV-00HK0p-Jy; Mon, 10 Jun 2024 21:00:09 +0200
Date: Mon, 10 Jun 2024 21:00:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Schrefl <chrisi.schrefl@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>,
	Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH 1/1] arm: rust: Enable Rust support for ARMv7
Message-ID: <5a8a6b44-9f89-4e26-869c-e9361da4cb5c@lunn.ch>
References: <4e0f5932-c7bc-4878-862c-1186cbecd71d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e0f5932-c7bc-4878-862c-1186cbecd71d@gmail.com>

> --- a/Documentation/rust/arch-support.rst
> +++ b/Documentation/rust/arch-support.rst
> @@ -15,6 +15,7 @@ support corresponds to ``S`` values in the ``MAINTAINERS`` file.
>  =============  ================  ==============================================
>  Architecture   Level of support  Constraints
>  =============  ================  ==============================================
> +``arm``        Maintained        ARMv7 Little Endian only.

Might be a FAQ, but what does Maintained mean here? Should you be
adding yourself to the RUST entry in MAINTAINERS? You are Maintaining
Rust on ARMv7 and so should be given credit/responsibility for that in
MAINTAINERS?

       Andrew


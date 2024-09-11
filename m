Return-Path: <linux-kernel+bounces-325212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5060897563D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AA9528A7CB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7431A304E;
	Wed, 11 Sep 2024 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R4b1WwVU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4301A3044;
	Wed, 11 Sep 2024 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066702; cv=none; b=LQomME88MGk1yPRDiI9ox/Op1I6Fhrug0JRB2uyYEsim5gsn4J3/cz8Y9Xnl14Kx1/1liMSrM/WdJWIdDKkP0R6DBYyUnvELrQ9A2GDup7r2fDiNff/eoR5DcWj7G2WqjgGgN/+F5EPqDOIc9LXwfmg/6tmbo1cL6tpNUeuN0wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066702; c=relaxed/simple;
	bh=BUFDB8AYryukKaEEpiyW0XcV0liEYLh331n+WxwvWQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeBamA6NiDcsfYVKB5vPu0Kra+LNGAmPuLBFZCFa2qSGfdanZ0dzHpLJQr6R40N8Y+nlCgiZTPxWulSv4UOtoIIDSusefTbD6hvJrUcx+0J59cDt2mRDobHCeXUL9+I6UcUrtMSvCGyfrMjDS3GekEtjSou1IH9bCk/vQSIlpFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R4b1WwVU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF5FC4CEC5;
	Wed, 11 Sep 2024 14:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726066702;
	bh=BUFDB8AYryukKaEEpiyW0XcV0liEYLh331n+WxwvWQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R4b1WwVUeOGkOpy4NsdwwzMk8QNQz2edsHwbMTiEn4X6xKok3IcpXoDRxJTOzN4Lc
	 9tTE7+rGMJzr0IiwroIUFsCYEq9d8Vp6XVKDLB5lLxb/AYiKAXgvLWMrZtZqDm2VLc
	 UYoJBfCB6ONsZ2tD1c7xAq/lnaFlJm0PqPQmuzzA=
Date: Wed, 11 Sep 2024 16:58:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ayush Singh <ayush@beagleboard.org>
Cc: fabien.parent@linaro.org, d-gole@ti.com, lorforlinux@beagleboard.org,
	jkridner@beagleboard.org, robertcnelson@beagleboard.org,
	Andrew Davis <afd@ti.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 8/8] addon_boards: mikrobus: Add GPS3 Click
Message-ID: <2024091149-vocalize-composite-6e48@gregkh>
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
 <20240911-mikrobus-dt-v1-8-3ded4dc879e7@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911-mikrobus-dt-v1-8-3ded4dc879e7@beagleboard.org>

On Wed, Sep 11, 2024 at 07:57:25PM +0530, Ayush Singh wrote:
> - GPS3 Click is a UART MikroBUS addon Board
> 
> Link: https://www.mikroe.com/gps-3-click
> 
> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
> ---
>  addon_boards/mikrobus/Makefile         |  1 +
>  addon_boards/mikrobus/mikroe-1714.dtso | 28 ++++++++++++++++++++++++++++

Odd top-level directory for the kernel, are you sure this is correct?

thanks,

greg k-h


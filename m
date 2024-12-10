Return-Path: <linux-kernel+bounces-439246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E779EACB6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0D21614D3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB242080F2;
	Tue, 10 Dec 2024 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Li72AVSH"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBC91DC9B2;
	Tue, 10 Dec 2024 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823707; cv=none; b=rL0oKvtQ/ZdcAOkfVK4lOOAX7Mg7RDNQ8sxoAWvcnuZ3u9xBvCtaZBx7A7FzuZgqdO7ik9maLxloEvqvVwGEFbQHBPI2u/e28YrQBa8tV3ozHo4R9lsT7SW507JP5yCjd4oJPPHUlFjkp2U+YAhUSZkZQpOMBu4m+SsbTqHOa5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823707; c=relaxed/simple;
	bh=m9UkcUHS1gsOxAAhPurltiUYGQMRkE8u/ZHvIojJzf4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c9EEEyByDZwzKgWa3HiucdnzbI3ICrTl0xgxFk9ZQdW96rCt+i7DiXG0d2XBkEqbBvKESGRKM/Q8NKBwDow/xx5JXrSrx1k5DtCzHKUXg0rDyJq81i2dtVhcAr525SK3d+5m2Sah2f5+wYp4vhyXvAgIxzkgaIMcmeuLW4iV6RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Li72AVSH; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C0A7B1BF204;
	Tue, 10 Dec 2024 09:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733823703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MkSoJTJSUagguRx9A3Qz7gE4m7vb0OWuqVCxD40rLns=;
	b=Li72AVSHWd2IXyPGogLd1ReC8vkunySw7ExsJsUMg2uQ3bIYHn7Czd2JB2QPMc4rAOaQSQ
	hjTulFKAe1aGUlHw0T29rH9entYOCktpqBhBj7Cryo304vNf06YtW6uASsvL+VnrVmqcEY
	4MiZyiDXAl8WLvC0gi50oBP91Y72ADOSuN+pF6CZHbupds5AX27j6fm622pN/YKzk8x3X0
	15+bR7Y3E69qiduRpJLhydosLLXLJ8TGIpWFEtUpM5CdACPlzTSUOUBroXHKlHmW554enB
	GlloOyaKnKupBLLDDqs1paLdTJAV+v19zdTiMdEY+R5ccPdO2yqfjJNk73zFMA==
Date: Tue, 10 Dec 2024 10:41:41 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Ayush Singh <ayush@beagleboard.org>
Cc: Andrew Davis <afd@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan
 <saravanak@google.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/7] of: overlay: Add support for export-symbols node
 feature
Message-ID: <20241210104141.39acffb1@bootlin.com>
In-Reply-To: <33c61b28-c0b8-478d-8107-c6ed1ff9e466@beagleboard.org>
References: <20241209151830.95723-1-herve.codina@bootlin.com>
	<33c61b28-c0b8-478d-8107-c6ed1ff9e466@beagleboard.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Ayush,

On Tue, 10 Dec 2024 14:52:22 +0530
Ayush Singh <ayush@beagleboard.org> wrote:

...
> 
> What is the reason for not using symbols directly as described here [3]?
> 
> I do like this approach since it does not pollute the global symbols. 
> Just want to know if there are any other reasons for it.
> 

Modifying the __symbols__ node at runtime (adding / removing properties in
it) exposes memory leaks if __symbols__ already exist in the live DT.
This __symbols__ node exist if the dtb was compiled with '-@' or if you
chain the overlay (i.e. __symbols__ node created by the first overlay).

I think also that some conflicts can appears. What happens if you want to
add a new label but this label is already present for some other purpose?

Best regards,
Hervé


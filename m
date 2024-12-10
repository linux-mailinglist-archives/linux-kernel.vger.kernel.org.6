Return-Path: <linux-kernel+bounces-439076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704C49EAA79
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3089D28816D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C6F22F3BB;
	Tue, 10 Dec 2024 08:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h7Z67N44"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9A822CBD0;
	Tue, 10 Dec 2024 08:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733818891; cv=none; b=tVcIS/X0m0SdHWrilPjJMTrPnZ9bn4udD7VwngRAOh76/YXfX+aUKqyi+0m0zOTiLIalp0HfPXZyYcR78RwSJc5J5SpNbDv/POANMZGkLjCIv/AY68XW4YK9cCTYHvtEMKhShCo3BLd1ZDzPskQb10LldMKAsmfNnNOUG38ZRms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733818891; c=relaxed/simple;
	bh=fK9v0cZTAtqsxeQFFyGcZvjO5yvsqyMJpiYsA2VCctA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nsQw8B1FJRBLzVO7haiSaBav48n7XgQNl1W34N2exi0uwOCLy+N/yxp7JNW6FJtVWJ9iCO9k8dH64+gg/5E8MZ8eTqNefcrBlTSM2XmpdlJTgIsIv0Xb/1xsNME/UczB49KPXTV1h8NuxrD7a9DEfS2p7zgKn9k5g+Ypf4U6mAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h7Z67N44; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D19A11C0003;
	Tue, 10 Dec 2024 08:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733818885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1AOUSLYgmnyJ7HVIDZ3/KMWd0NTwOgKPOQaoYfuH55k=;
	b=h7Z67N445aFInE6NguY+TGyCCtEHwIA/Rgwy3bFzAKDJb/rf44HQMt154jFUdozyASDmZA
	BgMdV03GmwdZjRb/xZloBNOTxy9QlXVDzIrtxCBunhyziBAoiTf2fIUcTMYMleGCMe4ImX
	RsXq/sdJMAQT3u/q591xn8+ZspzNTowK+ylflZIWJ8nc8YPp0Mf8fXLUWd3hfwH0YU+SDB
	gn5BBli5jECNaofv7Sa/Hq6CpkrTFdNAPx3COW9+6yXEF6nX1bDYD6IETDzeSFlp4kZiWM
	Cfbg8XmJ2iU+4ar+g4ZWbGQfHFOcw3vep3y7XlyJ/laBKd0ubrINva7zuYfSPg==
Date: Tue, 10 Dec 2024 09:21:24 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrew Davis <afd@ti.com>, Ayush Singh <ayush@beagleboard.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Saravana Kannan <saravanak@google.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 5/7] of: overlay: Add export_symbols_name in
 of_overlay_fdt_apply() parameters
Message-ID: <20241210092124.5678b53a@bootlin.com>
In-Reply-To: <20241209182728.1ab9247a@booty>
References: <20241209151830.95723-1-herve.codina@bootlin.com>
	<20241209151830.95723-6-herve.codina@bootlin.com>
	<20241209182728.1ab9247a@booty>
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

Hi Luca,

On Mon, 9 Dec 2024 18:27:28 +0100
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

..
> > Having the name of the subnode in parameters instead of the subnode
> > itself avoid the use of an export symbol node that is not directly  
> 
> s/avoid/avoids/
> 

Will be fixed in the next iteration.

Thanks,
Hervé


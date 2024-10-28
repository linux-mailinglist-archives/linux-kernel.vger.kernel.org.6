Return-Path: <linux-kernel+bounces-384410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EBA9B29CB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E5F1C21B43
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CDE193067;
	Mon, 28 Oct 2024 08:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NId5SLoO"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAD419005F;
	Mon, 28 Oct 2024 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730102553; cv=none; b=W30jl9+IgKIWRWD/Wi8+kyUllk941rCfeu6nYlbFtbjoiJYwUdE+yP7YHRnQxgs99dYmxItHmUO++mz8ZbId6YTEM14Xzcq3+YQGHWs2P/xqlTMk3OO3Ur9KLShCF+/irLsY5ZwkuwnpkQgW4mmu10eDR7ltIpd3svX0TxDzXfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730102553; c=relaxed/simple;
	bh=VFyDsvMJP6XxTZGDsHO7Fk7q/AiTFp3vQW+cD/emrW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mck4XDU3Dmkl5GWKeF1W70tgsSrJhxm4f4Dd7NTiGx8g//euuVLvm+qqXkcqRC2yOFQgf9Ip6VshIOgnASKRDZUaOq+TBVAV2Kf85HcAO7I4CanhEpg4OCXZmd1rECOHt08HlNIkR0A8OEoYsf+VBfEPxX0zbAYoXsEvSFAiGkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NId5SLoO; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF9131BF209;
	Mon, 28 Oct 2024 08:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730102543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMdiMphrDVa/6WG8AanOiRAHLQzTBE/3PK643L9hPJ4=;
	b=NId5SLoO5WQXKd5a1otqq2vpVAAhxGahPioxT21lCSi3VIM/jsNDRCtcGVVojv2prUmPCf
	o67wuBKsTOTBaUdCjAZPkK+av73f0yVoNWkMfx7tV0DJkXw3aBPavgULEROsZ5d8BDyLv1
	n39yty4ucmTC8D4BKYjODoil2Y5Q59Gch63hHuuzAHlBiaINn2207epgExQrk0e27zwrb+
	PPQAthe51DupxtM1TSBnNnOH+RkZcYAzQsl37n7pbkCrDWk2nsRJCdw/PTH9eOT1pQ+rer
	qdZ3KRsDw6cw2XsS1DfTP8C3bzkX24C6QmwNspwU64S7dnLOfo/5hrgWBwK1AA==
Date: Mon, 28 Oct 2024 09:02:20 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Marek Vasut <marex@denx.de>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Walle <mwalle@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] drm: bridge: ti-sn65dsi83: Add error recovery
 mechanism
Message-ID: <20241028090220.1fd803ff@bootlin.com>
In-Reply-To: <78a09625-6bad-4fda-8ee5-92b8dd0de381@denx.de>
References: <20241024095539.1637280-1-herve.codina@bootlin.com>
	<20241024095539.1637280-3-herve.codina@bootlin.com>
	<78a09625-6bad-4fda-8ee5-92b8dd0de381@denx.de>
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

Hi Marek,

On Sat, 26 Oct 2024 00:53:51 +0200
Marek Vasut <marex@denx.de> wrote:

> On 10/24/24 11:55 AM, Herve Codina wrote:
> > In some cases observed during ESD tests, the TI SN65DSI83 cannot recover
> > from errors by itself. A full restart of the bridge is needed in those
> > cases to have the bridge output LVDS signals again.  
> 
> I have seen the bridge being flaky sometimes, do you have any more 
> details of what is going on when this irrecoverable error occurs ?

The panel attached to the bridge goes and stays black. That's the behavior.
A full reset brings the panel back displaying frames.

Best regards,
Hervé


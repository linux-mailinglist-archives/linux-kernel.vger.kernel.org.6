Return-Path: <linux-kernel+bounces-226983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCBB9146BC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91650B23596
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5265C13248E;
	Mon, 24 Jun 2024 09:54:24 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC9E12E1F6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719222863; cv=none; b=C61nD5EXtwAB3PPhYzA/bC+gjDSIdpH95mjitg4lS9YIx4zU2UBJl0Fg9qAHriU/GKRE3Bb3tnwbWCjsd/QUOkW3l3tXi3uVM02wLhvzsfjDH5Z+GEUOBOg7J1KhKDBbZVlvJenIbllnjFWHILHBWOgtM2YNCPo9EJP8yYZBekY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719222863; c=relaxed/simple;
	bh=MnNVvBSDsOMIPt/b2tzEfPO7/omY4YQpUvF6zseL4s8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n7dlWVhxGDE/PRiijv2mgab9olrU753O7uV0UaeT9aPOVWOKB/kl+kjPwxdYekryPj/KsIu3ZvtBQ2E6sVN4Ckm9JBBWy/KhnqzpteC2ZXrNVcGOciNEigmUOqVTmvKeJNpmdoWgoj82tXZnhq3dSd7kvrEYEaipLfvBErGKzzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sLgOu-0004Tb-Ql; Mon, 24 Jun 2024 11:54:16 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sLgOu-004cQ6-3T; Mon, 24 Jun 2024 11:54:16 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sLgOu-0005EK-08;
	Mon, 24 Jun 2024 11:54:16 +0200
Message-ID: <a40f77cbf17f6d8ff0de100849bff0c9bcc42df0.camel@pengutronix.de>
Subject: Re: [PATCH linux-next] gpu:ipu-v3:pre: replace of_node_put() with
 __free
From: Philipp Zabel <p.zabel@pengutronix.de>
To: R Sundar <prosunofficial@gmail.com>, airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com, Julia Lawall
	 <julia.lawall@inria.fr>
Date: Mon, 24 Jun 2024 11:54:15 +0200
In-Reply-To: <20240427045024.7083-1-prosunofficial@gmail.com>
References: <20240427045024.7083-1-prosunofficial@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Sa, 2024-04-27 at 10:20 +0530, R Sundar wrote:
> use the new cleanup magic to replace of_node_put() with
> __free(device_node) marking to auto release when they get out of scope.
>=20
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: R Sundar <prosunofficial@gmail.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp


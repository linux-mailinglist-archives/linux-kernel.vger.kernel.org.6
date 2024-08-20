Return-Path: <linux-kernel+bounces-294612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799E7959034
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3094D28407E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473771C68B0;
	Tue, 20 Aug 2024 22:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZCYWS03"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AD418E377;
	Tue, 20 Aug 2024 22:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724191407; cv=none; b=m0UDjWh6TR9PKQeJWQVKawBqWfiQ/EyAEdz0l60usbShNQZGeF4S3RrK8c5Nsi2af0tzH3WigniWmEPbKC9g1K+bU9a7YdpCmD0MERFza+RsGRcAKDRgNx8U+fk1VK3jQfKzArOdIuatbRO2HY2TcVF6EPVaLFYa6OEwGfjwn5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724191407; c=relaxed/simple;
	bh=SCc9AW6PdECIJzs72kTpSb/cE3Crc/zDrxIic/y3TU0=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=iK8lGITsN3hE7TrXhZN5ejkDpszpL7yw+xudKRUV6AJp4dFPJHaFBgfdb/M4f7NFj+e6o/Z2wYzb1HZw6s92zCbDAL2NmU7Dzth6BhC/R5iHBbXOWoyhike/S/HU00fvKOOGuy/lIODTHhbx5CzGxbBBhEKkTVix8sz3hEVR+Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZCYWS03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E719AC4AF0B;
	Tue, 20 Aug 2024 22:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724191407;
	bh=SCc9AW6PdECIJzs72kTpSb/cE3Crc/zDrxIic/y3TU0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=CZCYWS03ve2QKnkOx5niM9W4gj5fly1uKIZxXJ4CoHs1h6dAe9sRUkTqXeO4DkZMo
	 V+hPlW7IsY3yLnRH7uETmJkVPfQoctFj+0eYqxCWgzSuRC3J3XY5h3anHq7IiHGAnL
	 De6drCZWJbkYoyiGYnwMqRqf251m4OD3ms7RuC4pU1Cf+Po+18S+BQzLSWahBxv21j
	 KFCXsOJ/RaFBwMvfwJNV9Y5+pRI8wVhrrANnBBEF2cTFJYBNksdEinP7EYlHKlL9Yh
	 3ex1OHA1OhPTsOaECjXpX8Buosd2QFM5ORKoe+HBCi1JtQZiurI5xaSrgZGaA7/CfF
	 tI9DD1IcmNmdg==
Message-ID: <9b1107439ffd3fe3cf4945a500a881c8.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240820013550.4906-1-david.hunter.linux@gmail.com>
References: <20240820013550.4906-1-david.hunter.linux@gmail.com>
Subject: Re: [PATCH 1/1] Driver: clk-qoriq.c: replace of_node_put with _free improves cleanup
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, javier.carrasco.cruz@gmail.com, shuah@kernel.org, david.hunter.linux@gmail.com
To: David Hunter <david.hunter.linux@gmail.com>, mturquette@baylibre.com
Date: Tue, 20 Aug 2024 15:03:24 -0700
User-Agent: alot/0.10

Quoting David Hunter (2024-08-19 18:35:49)
> Use the _free function to have automatic clean up instead of calling

How about:

	Use __free() to have automatic cleanup instead of calling
	of_node_put() manually.

> another function, of_node_put. This prevents leaking reference counts.

Are there any leaking reference counts? I'd just omit that sentence
unless there is one.

>=20
> The following commit has information on _free(device_node):
>=20
> 9448e55d032d99af8e23487f51a542d51b2f1a48
>=20
> The code was able to compile without errors or warnings.=20

The rest of this can go below the triple dash ---


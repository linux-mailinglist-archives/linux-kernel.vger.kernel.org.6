Return-Path: <linux-kernel+bounces-551797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F36A5710F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D087A3B8B5A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F8A24BC07;
	Fri,  7 Mar 2025 19:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVzz3LXT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAAD17B500;
	Fri,  7 Mar 2025 19:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741374313; cv=none; b=I+4qLbb9wUMNRiZs2ztogyn7LaZcHPLI+rnSCjDnQPXfi6a0BWYZavFoTr9sv5svNyuKe+d9XtMAOepJH396Bu25pNa+wBmHoH5sxEqrfrQZoMfh1uBgscB8Ji3p9riF0NUxDsQO7W1r+96j5HNoQxjiYcxJEWMg9GbIDOs7PjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741374313; c=relaxed/simple;
	bh=s64IwALZ6+g3FKG5BdGcYmKAVZLS+25IDtEaQRS3sw4=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=sqh71x4eweGW7P1U1xgfixIlWSgw8eeWM1IhILE4pccQ8ts9rj3Vomr8sANfVePzD3i2nTPu7FyTvhBLa+qpGOkRW102Hih8pKsfFPyEr8EJX0KZlabISgZaltjlG+MtljBc9gCUAoQKMAw0xnUr9S0D+imjoL1niH9ZznSo0uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVzz3LXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B61FC4CEEA;
	Fri,  7 Mar 2025 19:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741374312;
	bh=s64IwALZ6+g3FKG5BdGcYmKAVZLS+25IDtEaQRS3sw4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=aVzz3LXTC9jrCJfsE5PzH+uFwVWEBwHl+c/5Jh7amhT38ftwJJDQw/VMf+WoncmF/
	 j/giXVAikf2OqQKjk5BqUiPu2NM02zjpaHVGUJMOw/cgtI3ytemVGhqXS+MIyWMg7d
	 Hll4+63kpH34+SU7FWH7sp2Rh+RWX4CnneLusCB7V3CCGCX7dH6Rjkl2SQ2ec7uWYa
	 KVySUYMfAaCvEiX6x6x7MYXx4iRsEBIRQBIUuypNnm2gEUByX1mJNdtd2qqRIndOAd
	 MDQeg3CGRQ5xTlPnRc/Ie+b14YCjPCNDT5Wcr7NmpaGrUl/CEiCgROHWRAmSIWKbqa
	 JZsUau/vbRF+Q==
Message-ID: <5f8c330068fab1a2bc5c29e5bcd7b204.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250307064708.209511-1-hanchunchao@inspur.com>
References: <20250307064708.209511-1-hanchunchao@inspur.com>
Subject: Re: [PATCH] clk: mmp: Fix NULL vs IS_ERR() check
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Charles Han <hanchunchao@inspur.com>
To: Charles Han <hanchunchao@inspur.com>, duje.mihanovic@skole.hr, mturquette@baylibre.com
Date: Fri, 07 Mar 2025 11:05:10 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Charles Han (2025-03-06 22:47:07)
> The devm_kzalloc() function returns NULL on error, not error pointers.
> Fix the check.
>=20
> Fixes: 03437e857b0a ("clk: mmp: Add Marvell PXA1908 APMU driver")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---

Applied to clk-next


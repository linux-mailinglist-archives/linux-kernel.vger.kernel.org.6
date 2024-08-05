Return-Path: <linux-kernel+bounces-275407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9162948514
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D86D281A81
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CACC16CD0D;
	Mon,  5 Aug 2024 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8v+e0Gg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FA014A099
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 21:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722894910; cv=none; b=nVV7C4Zu7fGSXlgBlKRTL/zCm2HmEzDXl15//F5O+rcqhnN0pWBVxm4akX08v+/O1RmBp23uQm+168zbnmd1o6udzIhH5BcGLEKlE0pebV8zZiL2oeoxTVuXvH6GFx498zm4fNaOJ3hhqoOktqt9hwpSdOeJrUwl+A5/7MBPnzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722894910; c=relaxed/simple;
	bh=xJfkjfNoHBgjh/kpG66XeHnHneaw6JzLNkWQnyfOKLs=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=qWvRel7OOMzBWBV7lp5xkk2Ep+BXxJ5GE1/jU++KfVpUbiowLCyx+Pk9LKV/sPEDAXHRtr/6kR6wZ7p602CXEm0JdL/ehd691cJcw5gl8WMLEVV77MUTMGF9ni+h4vJCCFy1KZV/8r2DGNZCoLTSXBseCeWIIbr4b2EoNqLaumE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8v+e0Gg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCD2C32782;
	Mon,  5 Aug 2024 21:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722894910;
	bh=xJfkjfNoHBgjh/kpG66XeHnHneaw6JzLNkWQnyfOKLs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Z8v+e0GgR75Fb4yvM6YeXDnYhKXYF1jyLym5V/1s18b8MlFoI9f9ProeLFJpeCqKE
	 idmrLZbgrym4uhj+7GZXemNrhyN0I3/b8pcVTrmxsXK06wdukkIJVScaNHC2mm5WTL
	 sUKBMfXwNw/vY/KYAcgeWpnmdih/1CxJXSZlZ5GgfZkkTqc2lRfzYODgtPmugqgR54
	 1MfERN0y9oJzIVp3bAMUi2uUu8DV2OdowLoVU+L66HgTRhXND7iETUiEWs9gkgmYOc
	 gjjEEhJFeC5cUJ9lf8tc+gZ2WmOtdAaClmXJ2YQQSeejOMfjrPPjFpc08MVi3K/agl
	 m6JzQ86aQYdZA==
Message-ID: <17286822755c4420d3ec2e405ccab41a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240803065625.347933-1-cuigaosheng1@huawei.com>
References: <20240803065625.347933-1-cuigaosheng1@huawei.com>
Subject: Re: [PATCH -next] spmi: pmic-arb: Add check for return value of platform_get_resource_byname
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org
To: cuigaosheng1@huawei.com
Date: Mon, 05 Aug 2024 14:55:07 -0700
User-Agent: alot/0.10

Quoting Gaosheng Cui (2024-08-02 23:56:25)
> Add check for the return value of platform_get_resource_byname() and
> return the error if it fails to catch the error.
>=20
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Is this the right fixes tag?

Fixes: b319b5922db2 ("spmi: pmic-arb: remove the read/write access checks")

